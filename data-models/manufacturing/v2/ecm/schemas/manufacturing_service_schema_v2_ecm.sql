-- Schema for Domain: service | Business: Manufacturing | Version: v2_ecm
-- Generated on: 2026-07-03 05:59:38

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`service` COMMENT 'After-sales service and field service management domain covering service request tracking, warranty management, RMA processing, service contract administration, technical support, customer service case management, and post-sale support for installed automation systems and equipment via Salesforce Service Cloud.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`request` (
    `request_id` BIGINT COMMENT 'Primary key for request',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Associates request with specific site; required for Site‑Level Service Metrics and dispatch planning.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for internal charge‑back of service request costs; used in cost allocation reports and budgeting.',
    `customer_account_id` BIGINT COMMENT 'Unique identifier of the customer who owns the asset.',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Links service request to the contacting person; needed for Request Ownership report and escalation workflow.',
    `delivery_id` BIGINT COMMENT 'Foreign key linking to order.delivery. Business justification: After‑delivery service tickets reference the delivery record to verify shipment details and delivery‑based SLA compliance.',
    `device_registry_id` BIGINT COMMENT 'Foreign key linking to automation.device_registry. Business justification: Service request handling requires linking to the exact device (device_registry) for remote diagnostics and parts lookup, a core process in field service.',
    `ecn_id` BIGINT COMMENT 'Foreign key linking to engineering.ecn. Business justification: Linking a service request to the originating Engineering Change Notice ensures accurate impact analysis and audit trails.',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: Service requests generated from an Engineering Change Order need the ECO reference to coordinate field updates and compliance reporting.',
    `employee_id` BIGINT COMMENT 'Identifier of the field technician or support engineer assigned to the request.',
    `engineering_revision_id` BIGINT COMMENT 'Foreign key linking to engineering.revision. Business justification: Links service request to the specific engineering revision that introduced the issue, enabling root‑cause analysis and traceability in the Service‑Engineering handoff report.',
    `installed_base_id` BIGINT COMMENT 'FK to service.installed_base.installed_base_id — Service requests must link to the installed base record to identify which customer asset is being serviced, enabling warranty validation and service history tracking.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Service request part usage requires identifying the material master of the part consumed; the Parts Usage report relies on this link.',
    `equipment_register_id` BIGINT COMMENT 'FK to asset.equipment_register',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Project Service Request Tracking report ties each service request to its originating project for cost and schedule impact analysis.',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: Installation or repair requests are triggered by a sales order intake; linking supports the Service Request Fulfillment dashboard that tracks requests against originating orders.',
    `service_contract_id` BIGINT COMMENT 'Identifier of the service contract governing the request.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Required for Service Request processing: linking each request to the exact product master enables warranty validation, parts lookup, and service performance reporting.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Service Parts Allocation process assigns a stock location to each service request for part pick‑up; linking request to stock_location enables the allocation report.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Service request fulfillment often requires parts from a specific supplier; linking enables parts cost allocation and supplier performance reporting.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Final monetary cost incurred for the service after completion.',
    `channel` STRING COMMENT 'Originating communication channel through which the request was submitted.. Valid values are `phone|email|portal|field|chat`',
    `closed_timestamp` TIMESTAMP COMMENT 'Date‑time when the request reached a closed state.',
    `contact_email` STRING COMMENT 'Primary email address for communications related to the request.',
    `contact_phone` STRING COMMENT 'Primary phone number for the customer contact.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the request was first recorded in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for cost fields.. Valid values are `USD|EUR|GBP|CNY|JPY`',
    `due_date` TIMESTAMP COMMENT 'Target date by which the request should be resolved per SLA.',
    `escalation_level` STRING COMMENT 'Numeric level indicating how many times the request has been escalated.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Projected monetary cost of the service before execution.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `parts_cost` DECIMAL(18,2) COMMENT 'Total cost of parts consumed for the request.',
    `parts_used` STRING COMMENT 'Comma‑separated list of part numbers used during the service.',
    `priority` STRING COMMENT 'Urgency level used to drive routing and escalation.. Valid values are `low|medium|high|critical`',
    `request_number` STRING COMMENT 'Human‑readable business identifier assigned to the request (e.g., CASE‑00012345).',
    `request_status` STRING COMMENT 'Current lifecycle state of the service request.. Valid values are `open|in_progress|pending_customer|resolved|closed|cancelled`',
    `request_type` STRING COMMENT 'Category of the request indicating the nature of the support needed.. Valid values are `technical_support|field_service|warranty_claim|rma|complaint`',
    `resolution_deadline` DATE COMMENT 'Calculated deadline based on SLA tier and priority.',
    `resolution_description` STRING COMMENT 'Narrative of the actions taken to resolve the request.',
    `root_cause` STRING COMMENT 'Identified underlying cause of the reported issue after investigation.',
    `service_category` STRING COMMENT 'Classification of the service type performed.. Valid values are `preventive|corrective|installation|upgrade`',
    `site_country` STRING COMMENT 'Three‑letter ISO country code of the site location.. Valid values are `^[A-Z]{3}$`',
    `sla_actual_hours` STRING COMMENT 'Actual number of hours taken to resolve the request.',
    `sla_target_hours` STRING COMMENT 'Maximum number of hours allowed to resolve the request per SLA tier.',
    `sla_tier` STRING COMMENT 'Service level agreement tier defining response and resolution targets.. Valid values are `standard|gold|platinum`',
    `symptom_description` STRING COMMENT 'Free‑text description of the issue reported by the customer.',
    `travel_distance_km` DECIMAL(18,2) COMMENT 'Estimated distance in kilometers from technician base to site.',
    `travel_time_minutes` STRING COMMENT 'Estimated travel time for the technician to reach the site.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the request record.',
    `warranty_expiration_date` DATE COMMENT 'Date on which the asset warranty expires.',
    `warranty_flag` BOOLEAN COMMENT 'Indicates whether the asset is covered by an active warranty at the time of the request.',
    CONSTRAINT pk_request PRIMARY KEY(`request_id`)
) COMMENT 'Core transactional entity representing a customer-initiated after-sales service request or support ticket for installed automation systems and equipment. Captures request type (technical support, field service, warranty claim, RMA, complaint), priority, SLA tier, originating channel (phone, email, portal, field), reported symptom or issue description, affected installed base asset, site location, and full lifecycle status (open, in-progress, pending-customer, resolved, closed). Maps to Salesforce Service Cloud Case object. SSOT for all post-sale support interactions.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`service_contract` (
    `service_contract_id` BIGINT COMMENT 'Unique system-generated identifier for the service contract.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Contracts often cover specific components; linking enables contract scope reporting and component‑level service level agreement tracking.',
    `control_system_id` BIGINT COMMENT 'Foreign key linking to automation.control_system. Business justification: Contracts frequently cover specific control systems; linking provides contract‑to‑system traceability for SLA and compliance audits.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Service contracts generate financial transactions. Adding cost_center_id (FK → finance.cost_center.cost_center_id) enables proper cost allocation for service revenue.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Required for Contract Management report linking each service contract to the owning customer account; contracts are always signed with a specific customer.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Service contract revenue and expense postings need a GL account for proper accounting entries.',
    `order_header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Contract creation process uses the original sales order as the basis for the service agreement; linking enables contract‑order reporting and compliance tracking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Contract ownership accountability report links contract to owning employee for HR and compliance tracking.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Contracts are defined per product family; the FK supports contract pricing, compliance, and coverage reports that aggregate by family.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability analysis per service contract requires linking to a profit center for financial reporting.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Service Contract Management for Projects links contracts to the project they support, enabling contract compliance reporting.',
    `sales_contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: Service contract execution depends on the original sales contract to define scope, billing, and warranty; linking enables the Service Contract Management report that reconciles service obligations wit',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: A sales representative owns the service contract relationship; linking supports the Service Contract Ownership dashboard for account management.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Service contracts are managed within sales territories; linking enables the Territory Service Coverage KPI linking contracts to regional performance.',
    `amendment_count` STRING COMMENT 'Number of times the contract has been amended.',
    `annual_contract_value` DECIMAL(18,2) COMMENT '',
    `auto_renew_flag` BOOLEAN COMMENT '',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates if the contract will automatically renew without manual intervention.',
    `billing_cycle_day` STRING COMMENT 'Day of month when billing occurs (1‑31).',
    `billing_frequency` STRING COMMENT 'How often the customer is invoiced for the contract.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `contract_category` STRING COMMENT 'High‑level classification of the contract for reporting and analytics.. Valid values are `warranty|service|maintenance|support`',
    `contract_description` STRING COMMENT 'Free‑text description of the contract purpose and scope.',
    `contract_name` STRING COMMENT '',
    `contract_number` STRING COMMENT 'External business identifier for the contract, used in customer communications and invoicing.',
    `contract_status` STRING COMMENT '',
    `contract_type` STRING COMMENT 'Category of service agreement defining the billing and delivery model.. Valid values are `preventive_maintenance|full_service|time_and_material|extended_warranty`',
    `contract_value` DECIMAL(18,2) COMMENT 'Total monetary value of the contract before discounts and taxes.',
    `coverage_level` STRING COMMENT '',
    `coverage_scope` STRING COMMENT 'Geographic or functional extent of the contract coverage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the contract value.. Valid values are `USD|EUR|GBP|JPY|CNY|CAD`',
    `discount_rate_percent` DECIMAL(18,2) COMMENT 'Percentage discount applied to the base contract value.',
    `effective_end_date` DATE COMMENT 'Date when the contract expires or is scheduled to end; null for open‑ended contracts.',
    `effective_start_date` DATE COMMENT 'Date when the contract becomes binding.',
    `end_date` DATE COMMENT '',
    `escalation_contact_name` STRING COMMENT 'Name of the person to contact for escalations.',
    `escalation_contact_phone` STRING COMMENT 'Phone number for escalation contact.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent contract amendment.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `manager_email` STRING COMMENT 'Email address of the manager overseeing the contract.',
    `net_contract_value` DECIMAL(18,2) COMMENT 'Contract value after discount and tax adjustments.',
    `notes` STRING COMMENT 'Additional remarks or internal notes related to the contract.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Standard payment condition (e.g., Net 30, Net 45).',
    `regulatory_approval_status` STRING COMMENT 'Status of required regulatory approvals for the contract.. Valid values are `approved|pending|rejected`',
    `renewal_date` DATE COMMENT '',
    `renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract is set to auto‑renew at expiry.',
    `renewal_term_months` STRING COMMENT 'Length of the renewal period in months when auto‑renewal is enabled.',
    `resolution_time_target_hours` DECIMAL(18,2) COMMENT 'Maximum time in hours to resolve a service request.',
    `response_time_hours` STRING COMMENT '',
    `response_time_target_hours` DECIMAL(18,2) COMMENT 'Maximum time in hours to acknowledge a service request.',
    `service_contract_status` STRING COMMENT 'Current lifecycle state of the contract.. Valid values are `draft|active|suspended|terminated|pending_approval`',
    `service_tier` STRING COMMENT 'Tier of service provided under the contract.. Valid values are `gold|silver|bronze`',
    `start_date` DATE COMMENT '',
    `status_reason` STRING COMMENT 'Explanation for the current contract status, if applicable.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Applicable tax rate for the contract value.',
    `termination_date` DATE COMMENT 'Date on which the contract was terminated, if applicable.',
    `termination_reason` STRING COMMENT 'Reason provided for contract termination.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contract record.',
    `uptime_guarantee_percent` DECIMAL(18,2) COMMENT 'Percentage of time the covered equipment is guaranteed to be operational.',
    `warranty_end_date` DATE COMMENT 'Date when the warranty period ends.',
    `warranty_included_flag` BOOLEAN COMMENT 'Indicates whether a warranty is bundled with the service contract.',
    `warranty_start_date` DATE COMMENT 'Date when the warranty period begins.',
    CONSTRAINT pk_service_contract PRIMARY KEY(`service_contract_id`)
) COMMENT 'Master entity representing a formal after-sales service agreement between Manufacturing and a customer organization covering installed automation systems or equipment. Captures contract header: type (preventive maintenance, full-service, time-and-material, extended warranty), coverage scope, SLA commitments (response time, resolution time, uptime guarantee), start/end dates, renewal terms, billing frequency, and contract value. Includes contract line items: each line covering a specific installed asset or product family with line-level coverage type, SLA tier, pricing, coverage dates, and renewal flag. Serves as the SSOT for all service entitlement, coverage data, and contract profitability analysis at both header and line-item granularity.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` (
    `service_warranty_id` BIGINT COMMENT 'System-generated unique identifier for the warranty record.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Component‑level warranty tracking requires knowing which engineered component the warranty applies to for claim processing.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Warranty claim costs are allocated to a cost center for internal cost tracking and budgeting.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer who owns the warranty.',
    `device_registry_id` BIGINT COMMENT 'Foreign key linking to automation.device_registry. Business justification: Warranty records must reference the exact device (device_registry) to validate coverage during service events, required by warranty claim processes.',
    `installed_base_id` BIGINT COMMENT '',
    `order_header_id` BIGINT COMMENT 'Identifier of the originating sales order that generated the warranty.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Warranty Tracking per Project records warranty coverage for assets installed under a specific project.',
    `sales_contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: Warranty terms are defined in the sales contract; linking enables the Warranty Coverage audit to ensure warranties are honored per contract.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Warranty validation often requires the original shipment record as proof of delivery; linking warranty to that shipment satisfies compliance audits.',
    `sku_master_id` BIGINT COMMENT 'Internal identifier of the product that the warranty protects.',
    `asset_warranty_id` BIGINT COMMENT 'Reference to SSOT owner asset.asset_warranty for warranty conflict resolution.',
    `claim_limit_amount` DECIMAL(18,2) COMMENT '',
    `claims_allowed_flag` BOOLEAN COMMENT 'True if the warranty permits service claims.',
    `claims_remaining` STRING COMMENT 'Number of warranty service claims still available to the customer.',
    `coverage_amount` DECIMAL(18,2) COMMENT 'Monetary limit of liability for the warranty.',
    `coverage_description` STRING COMMENT '',
    `coverage_scope` STRING COMMENT 'Indicates whether the warranty covers a single product, an entire system, or a site installation.. Valid values are `product|system|site`',
    `coverage_terms` STRING COMMENT 'Textual description of what components or services are covered under the warranty.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency for the coverage amount.. Valid values are `USD|EUR|GBP|JPY|CNY|CAD`',
    `document_url` STRING COMMENT 'Link to the digital copy of the warranty contract.',
    `duration_months` DECIMAL(18,2) COMMENT '',
    `effective_from` DATE COMMENT 'Date when the warranty coverage becomes effective.',
    `effective_until` DATE COMMENT 'Date when the warranty coverage expires; null for open‑ended warranties.',
    `end_date` DATE COMMENT '',
    `exclusions` STRING COMMENT 'Textual description of items or conditions not covered by the warranty.',
    `extended_until` DATE COMMENT 'Date to which the warranty has been extended, if applicable.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `lifecycle_status` STRING COMMENT 'Current state of the warranty in its lifecycle.. Valid values are `active|expired|suspended|pending|cancelled`',
    `notes` STRING COMMENT 'Free‑form notes entered by service personnel.',
    `product_serial_number` STRING COMMENT 'Manufacturer-assigned serial number of the product covered by the warranty.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the warranty record was first created.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the warranty record.',
    `registration_date` DATE COMMENT 'Date when the warranty was entered into the warranty management system.',
    `registration_status` DECIMAL(18,2) COMMENT 'Indicates whether the warranty has been formally registered in the system.',
    `renewal_flag` BOOLEAN COMMENT 'Indicates whether the warranty is eligible for renewal.',
    `renewal_terms` STRING COMMENT 'Textual description of the conditions and pricing for warranty renewal.',
    `service_level` STRING COMMENT 'Tier of service provided under the warranty.. Valid values are `basic|premium|gold`',
    `start_date` DATE COMMENT '',
    `terms_and_conditions` STRING COMMENT '',
    `transferability_flag` BOOLEAN COMMENT 'True if the warranty can be transferred to a new owner.',
    `transferable_flag` BOOLEAN COMMENT '',
    `warranty_number` STRING COMMENT 'External reference number assigned to the warranty by the sales or service system.',
    `warranty_status` STRING COMMENT '',
    `warranty_type` STRING COMMENT 'Classification of the warranty offering.. Valid values are `standard|extended|parts_only|labor_included`',
    CONSTRAINT pk_service_warranty PRIMARY KEY(`service_warranty_id`)
) COMMENT 'Master entity representing warranty coverage records for manufactured products, automation systems, and electrification solutions sold to customers. Captures warranty type (standard, extended, parts-only, labor-included), warranty start and end dates, coverage terms, exclusions, transferability flag, registration status, and originating sales order reference. Serves as the SSOT for warranty entitlement validation across service and field operations.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`service_rma` (
    `service_rma_id` BIGINT COMMENT 'Unique surrogate key for the Return Material Authorization record.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer who initiated the RMA.',
    `device_registry_id` BIGINT COMMENT 'Foreign key linking to automation.device_registry. Business justification: RMA processing for returned equipment needs the device_registry reference to track serial numbers, firmware version, and disposition.',
    `inbound_delivery_id` BIGINT COMMENT 'Foreign key linking to logistics.inbound_delivery. Business justification: RMA returns are processed as inbound deliveries; linking the RMA to its inbound delivery enables traceability of returned goods.',
    `sku_master_id` BIGINT COMMENT 'Identifier of the product or component being returned.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: RMA audit requires recording which employee processed the return for traceability.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: RMA Processing linked to Project records returns and repairs as part of the projects warranty management.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: RMA process may be subject to specific regulatory reporting (e.g., hazardous material return), requiring linkage to the governing regulatory requirement.',
    `request_id` BIGINT COMMENT '',
    `sales_contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: RMA processing must reference the sales contract that provided the product; linking supports the RMA Reconciliation report for contract‑based returns.',
    `service_contract_id` BIGINT COMMENT 'Identifier of the service contract governing the RMA, if applicable.',
    `service_sku_master_id` BIGINT COMMENT '',
    `service_warranty_id` BIGINT COMMENT 'Identifier of the warranty contract covering the returned item, if applicable.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: RMA processing must track which supplier handles the returned or replacement product for warranty claims and cost recovery.',
    `carrier_name` STRING COMMENT 'Name of the logistics provider handling the return shipment.',
    `closed_date` TIMESTAMP COMMENT '',
    `compliance_status` STRING COMMENT 'Indicates whether the RMA process complies with relevant regulations.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the RMA record was first created in the system.',
    `credit_amount` DECIMAL(18,2) COMMENT '',
    `credit_note_number` DECIMAL(18,2) COMMENT 'Identifier of the credit note issued for the RMA, if any.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for monetary values.. Valid values are `USD|EUR|GBP|JPY|CNY`',
    `disposition` STRING COMMENT 'Final action taken for the returned item.. Valid values are `repair|replace|credit|scrap|return_to_vendor`',
    `disposition_date` TIMESTAMP COMMENT 'Date when the disposition decision was recorded.',
    `fault_description` STRING COMMENT 'Detailed description of the defect or issue reported by the customer.',
    `inspection_notes` STRING COMMENT 'Free-text notes captured during inspection.',
    `inspection_result` STRING COMMENT 'Outcome of the post-receipt inspection.. Valid values are `pass|fail|partial`',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the RMA is considered critical for business operations.',
    `is_under_warranty` BOOLEAN COMMENT 'True if the returned item is covered by an active warranty.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT 'Additional free-form information related to the RMA.',
    `quantity` STRING COMMENT 'Number of units being returned under this RMA.',
    `received_date` TIMESTAMP COMMENT 'Timestamp when the returned items were received at the service center.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Monetary amount refunded to the customer, if applicable.',
    `regulatory_report_flag` BOOLEAN COMMENT 'True if this RMA must be reported to a regulatory body.',
    `repair_cost` DECIMAL(18,2) COMMENT 'Cost incurred to repair the returned item.',
    `replacement_serial_number` STRING COMMENT 'Serial number of the replacement unit, if applicable.',
    `request_timestamp` TIMESTAMP COMMENT 'Date and time when the customer submitted the RMA request.',
    `return_quantity` DECIMAL(18,2) COMMENT '',
    `return_reason_code` STRING COMMENT 'Standardized code indicating why the item is being returned.. Valid values are `defective|damaged|wrong_item|no_longer_needed|other`',
    `return_shipment_date` TIMESTAMP COMMENT 'Date the customer shipped the item back to the service center.',
    `return_shipment_method` STRING COMMENT 'Logistics method used for the return shipment.. Valid values are `ground|air|courier|pickup`',
    `rma_number` STRING COMMENT 'External business identifier assigned to the RMA request.. Valid values are `^RMA-d{6}$`',
    `rma_reason` STRING COMMENT '',
    `rma_status` STRING COMMENT '',
    `serial_number` STRING COMMENT 'Manufacturer-assigned serial number of the specific unit returned.',
    `service_rma_status` STRING COMMENT 'Current lifecycle status of the RMA.. Valid values are `requested|approved|repaired|replaced|credited|closed`',
    `shipment_tracking_number` STRING COMMENT 'Carrier-provided tracking identifier for the return shipment.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the returned quantity.. Valid values are `each|box|kg|unit`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the RMA record.',
    `warranty_expiration_date` DATE COMMENT 'Date when the associated warranty expires.',
    CONSTRAINT pk_service_rma PRIMARY KEY(`service_rma_id`)
) COMMENT 'Transactional entity representing a Return Material Authorization record for defective, damaged, or warranty-eligible equipment and components returned by customers. Captures RMA number, return reason code, fault description, return authorization date, disposition decision (repair, replace, credit, scrap), return shipment tracking, inspection outcome, and resolution status. Manages the full RMA lifecycle from customer request through disposition and closure.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` (
    `field_service_order_id` BIGINT COMMENT 'System-generated unique identifier for the field service work order.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: The carrier used to transport items for a field service order is needed for performance reporting and carrier cost tracking.',
    `control_system_id` BIGINT COMMENT 'Foreign key linking to automation.control_system. Business justification: Field service orders often target a specific control system for maintenance; the order must reference that control system for scheduling and compliance reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Field service order expenses must be charged to a cost center for regional budgeting and cost tracking.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer who owns the equipment or requested the service.',
    `equipment_register_id` BIGINT COMMENT 'Identifier of the specific asset or equipment to be serviced.',
    `engineer_id` BIGINT COMMENT '',
    `field_service_engineer_id` BIGINT COMMENT 'Identifier of the field service engineer assigned to execute the work.',
    `installed_base_id` BIGINT COMMENT '',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Field Service Order Allocation to Capital Projects ensures labor and parts costs are charged to the correct project budget.',
    `request_id` BIGINT COMMENT '',
    `sales_contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: Field service orders generate revenue against the sales contract; linking powers the Field Service Billing report aligning service orders with contract terms.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Field service orders may generate shipments of tools or spare parts; associating the order with its shipment supports logistics coordination.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Real end date‑time when the technician completed the work.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Real start date‑time when the technician began work on site.',
    `arrival_timestamp` TIMESTAMP COMMENT '',
    `city` STRING COMMENT 'City component of the service site address.',
    `completion_status` STRING COMMENT 'Overall result of the work order execution.. Valid values are `completed|partial|failed`',
    `completion_timestamp` TIMESTAMP COMMENT '',
    `country` STRING COMMENT 'Three‑letter ISO country code of the service site.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `USD|EUR|GBP|JPY|CNY|CAD`',
    `customer_signature_status` STRING COMMENT 'Status of the customers sign‑off on the completed work.. Valid values are `pending|signed|exempt`',
    `dispatch_timestamp` TIMESTAMP COMMENT '',
    `labor_cost` DECIMAL(18,2) COMMENT 'Cost of labor hours billed for the service.',
    `labor_hours` DECIMAL(18,2) COMMENT 'Total billable labor hours recorded for the work order.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the service location.',
    `lifecycle_status` STRING COMMENT 'Current state of the work order in its processing lifecycle.. Valid values are `draft|scheduled|in_progress|completed|cancelled|closed`',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the service location.',
    `order_number` STRING COMMENT 'Business-visible identifier assigned to the work order for tracking and customer communication.',
    `order_status` STRING COMMENT '',
    `order_type` STRING COMMENT 'Classifies the nature of the service activity.. Valid values are `installation|maintenance|repair|commissioning|inspection`',
    `outcome_code` STRING COMMENT 'Standardized code describing the outcome of the service activity.. Valid values are `success|partial_success|failure`',
    `parts_cost` DECIMAL(18,2) COMMENT 'Cost of parts consumed during the service.',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the service site.',
    `priority` STRING COMMENT 'Indicates the urgency for scheduling and resource allocation.. Valid values are `low|medium|high|critical`',
    `record_audit_created` TIMESTAMP COMMENT 'System timestamp when the work order record was first persisted.',
    `record_audit_updated` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the work order record.',
    `request_timestamp` TIMESTAMP COMMENT 'Date‑time when the service request was initially created by the customer or internal system.',
    `resolution_description` STRING COMMENT 'Detailed narrative of how the issue was resolved.',
    `root_cause_code` STRING COMMENT 'Categorized reason for any service failure or deviation.. Valid values are `equipment_failure|human_error|material_shortage|other`',
    `scheduled_date` TIMESTAMP COMMENT '',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned end date‑time for the service visit.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned start date‑time for the service visit.',
    `service_category` STRING COMMENT 'High‑level grouping of the service request based on urgency and purpose.. Valid values are `preventive|corrective|emergency`',
    `service_contract_number` STRING COMMENT 'Human‑readable identifier of the service contract governing the work.',
    `service_level_agreement_code` STRING COMMENT 'Code referencing the SLA terms applicable to this work order.',
    `site_address` STRING COMMENT 'Street address of the customer site where service is performed.',
    `state` STRING COMMENT 'State or province component of the service site address.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the work order total.',
    `total_cost` DECIMAL(18,2) COMMENT '',
    `total_discount_amount` DECIMAL(18,2) COMMENT 'Aggregate discount applied to the work order.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Sum of all charge components before discounts and taxes.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after discounts and taxes.',
    `travel_cost` DECIMAL(18,2) COMMENT 'Monetary cost associated with travel time and distance.',
    `travel_distance_km` DECIMAL(18,2) COMMENT 'Distance traveled by the technician to the service site, measured in kilometers.',
    `travel_hours` DECIMAL(18,2) COMMENT 'Billable travel time incurred by the technician to reach the site.',
    `warranty_expiration_date` DATE COMMENT 'Date when the applicable warranty for the equipment expires.',
    `warranty_flag` BOOLEAN COMMENT 'Indicates whether the service is covered under an active warranty.',
    `work_description` STRING COMMENT 'Narrative description of the tasks to be performed during the service visit.',
    `work_performed` STRING COMMENT '',
    CONSTRAINT pk_field_service_order PRIMARY KEY(`field_service_order_id`)
) COMMENT 'Transactional entity representing a dispatched field service work order for on-site technical service, installation, commissioning, preventive maintenance, or repair of customer-installed automation systems and equipment. Captures work order type, assigned field service engineer, scheduled and actual visit dates, site address, work performed description, parts consumed, labor hours, travel time, customer sign-off status, and completion outcome. Linked to originating service request.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`installed_base` (
    `installed_base_id` BIGINT COMMENT 'Primary key for installed_base',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Required for maintenance teams to identify which component version is installed on each equipment for service actions and spare parts planning.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Needed for Installed Base inventory report to attribute each equipment record to its customer account for warranty and service planning.',
    `device_registry_id` BIGINT COMMENT 'Foreign key linking to automation.device_registry. Business justification: Installed base records are linked to IoT device entries to enable real‑time monitoring and predictive maintenance, a standard practice in smart factories.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Installation liability and warranty claims depend on the employee who performed the installation.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Installed Base records need the material master for product specifications, supporting the Installed Base Specification report.',
    `node_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_node. Business justification: Installed equipment is located at a logistics node; linking enables routing of maintenance crews and inventory planning.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Installed Base Asset Allocation to Projects tracks which assets were delivered under each project for warranty and maintenance.',
    `sales_contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: Installed base assets are delivered under a sales contract; linking allows the Asset Coverage compliance report to verify that each asset is covered by its sales contract.',
    `sku_master_id` BIGINT COMMENT '',
    `service_warranty_id` BIGINT COMMENT 'Foreign key linking to service.service_warranty. Business justification: Installed base is covered by a warranty; FK provides authoritative warranty data and removes duplicate fields.',
    `capacity_kw` DECIMAL(18,2) COMMENT 'Rated capacity of the equipment in kilowatts.',
    `city` STRING COMMENT 'City component of the site address.',
    `commissioning_date` DATE COMMENT '',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the installation site.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the installed base record was first created.',
    `current` DECIMAL(18,2) COMMENT 'Operating current of the equipment in amperes.',
    `firmware_version` STRING COMMENT 'Version of the firmware loaded on the installed device.',
    `install_date` DATE COMMENT '',
    `install_status` STRING COMMENT '',
    `installation_date` DATE COMMENT 'Calendar date when the equipment was installed at the customer site.',
    `installation_method` STRING COMMENT 'Method used to install the equipment.. Valid values are `new|retrofit|upgrade`',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `last_service_date` DATE COMMENT 'Date of the most recent service activity performed on the asset.',
    `location_description` STRING COMMENT '',
    `maintenance_frequency_days` STRING COMMENT 'Planned interval between preventive maintenance activities, in days.',
    `maintenance_type` STRING COMMENT 'Category of maintenance performed on the asset.. Valid values are `preventive|corrective|predictive`',
    `mean_time_between_failures_hours` DECIMAL(18,2) COMMENT 'Average elapsed time between successive failures, expressed in hours.',
    `mean_time_to_repair_hours` DECIMAL(18,2) COMMENT 'Average time required to repair the equipment after a failure, in hours.',
    `model_number` STRING COMMENT 'Manufacturer model identifier for the product.',
    `next_maintenance_date` DATE COMMENT 'Planned date for the next preventive maintenance event.',
    `operating_hours` DECIMAL(18,2) COMMENT '',
    `operational_status` DECIMAL(18,2) COMMENT 'Current operational condition of the installed equipment.',
    `overall_equipment_effectiveness` DECIMAL(18,2) COMMENT 'Calculated OEE percentage for the asset.',
    `power_rating_kw` DECIMAL(18,2) COMMENT 'Maximum power rating of the equipment in kilowatts.',
    `product_category` STRING COMMENT 'High‑level classification of the installed product.. Valid values are `automation|electrification|infrastructure`',
    `product_name` STRING COMMENT 'Human‑readable name of the installed product model.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned unique serial number of the installed equipment.',
    `site_address` STRING COMMENT 'Physical street address of the installation site.',
    `site_location` STRING COMMENT 'Internal code identifying the customer site or plant where the asset resides.',
    `software_version` STRING COMMENT 'Version of the application software running on the device.',
    `state` STRING COMMENT 'State or province component of the site address.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the installed base record.',
    `voltage` DECIMAL(18,2) COMMENT 'Operating voltage of the equipment in volts.',
    `warranty_expiry_date` DATE COMMENT '',
    CONSTRAINT pk_installed_base PRIMARY KEY(`installed_base_id`)
) COMMENT 'Master entity representing the registry of all customer-installed automation systems, electrification solutions, and smart infrastructure components actively managed through after-sales service. Captures serial number, product model, firmware/software version, installation date, site location, operational status (running, degraded, stopped, decommissioned), last service date, next scheduled maintenance date, warranty linkage, and service contract coverage reference. Serves as the SSOT for the installed asset population and is the central reference point for all service transactions including requests, field orders, PM schedules, and remote diagnostics.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` (
    `service_entitlement_id` BIGINT COMMENT 'Unique system-generated identifier for the service entitlement record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Entitlement usage incurs costs that must be charged to a cost center for budget control.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer who holds the entitlement.',
    `installed_base_id` BIGINT COMMENT 'Foreign key linking to service.installed_base. Business justification: Entitlement applies to a specific installed base; FK creates the needed inbound relationship.',
    `order_header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Entitlement eligibility is derived from the original sales order; linking supports entitlement reporting and audit of service levels.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Entitlement Allocation to Projects ties service entitlements to the project that generated the entitlement.',
    `service_contract_id` BIGINT COMMENT 'Identifier of the parent service contract governing this entitlement.',
    `sku_master_id` BIGINT COMMENT 'Identifier of the product or asset to which the entitlement applies.',
    `acknowledgment_actual_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the request was acknowledged.',
    `acknowledgment_breach_flag` BOOLEAN COMMENT 'True if acknowledgment missed the SLA target.',
    `acknowledgment_breach_reason` STRING COMMENT 'Reason for acknowledgment SLA breach, if any.',
    `acknowledgment_elapsed_minutes` STRING COMMENT 'Minutes elapsed between request creation and acknowledgment.',
    `acknowledgment_target_timestamp` TIMESTAMP COMMENT 'Target timestamp for acknowledgment of the service request.',
    `business_hours_coverage` BOOLEAN COMMENT 'True if SLA applies only during standard business hours; false if 24/7.',
    `coverage_level` STRING COMMENT 'Level of service coverage associated with the entitlement.. Valid values are `standard|premium|enterprise`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the entitlement record was first created.',
    `service_entitlement_description` STRING COMMENT 'Free‑form description of the entitlement, including any special conditions.',
    `effective_end_date` DATE COMMENT 'Date when the entitlement expires or is terminated; null for open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the entitlement becomes effective.',
    `end_date` DATE COMMENT '',
    `entitlement_code` STRING COMMENT 'Business code or number used externally to reference the entitlement.',
    `entitlement_name` STRING COMMENT 'Descriptive name of the entitlement offering.',
    `entitlement_status` STRING COMMENT '',
    `entitlement_type` STRING COMMENT 'Category of entitlement such as warranty, contract, complimentary, or service plan.. Valid values are `warranty|contract|complimentary|service_plan`',
    `first_response_actual_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the first response was delivered.',
    `first_response_breach_flag` BOOLEAN COMMENT 'True if the first response missed the SLA target.',
    `first_response_breach_reason` STRING COMMENT 'Reason why the first response SLA was breached, if applicable.',
    `first_response_elapsed_minutes` STRING COMMENT 'Actual minutes elapsed between request creation and first response.',
    `first_response_target_timestamp` TIMESTAMP COMMENT 'Target timestamp by which the first response must be provided.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or remarks.',
    `priority_level` STRING COMMENT 'Priority classification of the entitlement for handling service requests.. Valid values are `low|medium|high|critical`',
    `remaining_units` DECIMAL(18,2) COMMENT '',
    `resolution_actual_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the service request was resolved.',
    `resolution_breach_flag` BOOLEAN COMMENT 'True if the resolution missed the SLA target.',
    `resolution_breach_reason` STRING COMMENT 'Reason why the resolution SLA was breached, if applicable.',
    `resolution_elapsed_minutes` STRING COMMENT 'Minutes elapsed between request creation and resolution.',
    `resolution_target_timestamp` TIMESTAMP COMMENT 'Target timestamp by which the service request must be resolved.',
    `service_channel` STRING COMMENT 'Delivery channel for the service (e.g., phone, email, on‑site, remote).. Valid values are `phone|email|on_site|remote`',
    `service_entitlement_status` STRING COMMENT 'Current lifecycle status of the entitlement.. Valid values are `active|inactive|suspended|pending`',
    `sla_resolution_time_target` STRING COMMENT 'Target time in minutes to fully resolve a service request.',
    `sla_response_time_target` STRING COMMENT 'Target time in minutes for initial response to a service request.',
    `start_date` DATE COMMENT '',
    `total_units` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the entitlement record.',
    CONSTRAINT pk_service_entitlement PRIMARY KEY(`service_entitlement_id`)
) COMMENT 'Master entity defining specific service entitlement rules, coverage levels, and SLA milestone tracking associated with a service contract or warranty. Specifies which service types, response/resolution time SLAs, and support channels a customer is entitled to for a given installed asset or product family. Captures entitlement name, type (warranty, contract, complimentary), SLA response time target, SLA resolution time target, business hours coverage, and active status. Includes milestone compliance tracking: each SLA milestone event (first response, acknowledgment, resolution) with target timestamp, actual completion timestamp, breach flag, breach reason, and elapsed time. Enables automated SLA enforcement during service request intake, SLA performance monitoring, and breach root-cause analysis. Maps to Salesforce Service Cloud Entitlement and Milestone objects.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` (
    `sla_milestone_id` BIGINT COMMENT 'Unique system-generated identifier for the SLA milestone record.',
    `control_system_id` BIGINT COMMENT 'Foreign key linking to automation.control_system. Business justification: SLA milestones are measured against specific control systems; linking enables SLA reporting per system for regulatory compliance.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: SLA Milestone Monitoring within Projects links SLA milestones to the owning project for compliance dashboards.',
    `service_contract_id` BIGINT COMMENT 'Identifier of the SLA contract governing the service request.',
    `request_id` BIGINT COMMENT '',
    `sla_service_request_id` BIGINT COMMENT 'Identifier of the service request to which this SLA milestone belongs.',
    `actual_timestamp` TIMESTAMP COMMENT 'The actual date and time when the milestone was completed.',
    `assigned_team` STRING COMMENT 'Name or identifier of the support team responsible for meeting the milestone.',
    `breach_flag` BOOLEAN COMMENT 'True if the milestone was not met within the target time, otherwise False.',
    `breach_reason` STRING COMMENT 'Free‑text description of why the SLA milestone was breached.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SLA milestone record was first created in the system.',
    `elapsed_minutes` STRING COMMENT '',
    `elapsed_time_minutes` STRING COMMENT 'Total minutes elapsed between the target timestamp and the actual completion timestamp.',
    `entitlement_tier` STRING COMMENT 'Tier of service entitlement that defines SLA targets for the request.. Valid values are `standard|premium|enterprise`',
    `escalated_flag` BOOLEAN COMMENT 'True if the milestone required escalation to a higher support tier.',
    `escalation_reason` STRING COMMENT 'Reason provided for escalating the SLA milestone.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `milestone_name` STRING COMMENT 'Name of the SLA milestone (e.g., first response, acknowledgment, resolution, closure).. Valid values are `first_response|acknowledgment|resolution|closure`',
    `milestone_status` STRING COMMENT '',
    `milestone_type` STRING COMMENT '',
    `notes` STRING COMMENT 'Additional free‑form notes captured by the support team regarding the milestone.',
    `priority` STRING COMMENT 'Priority level assigned to the SLA milestone for handling urgency.. Valid values are `low|medium|high`',
    `resolution_code` STRING COMMENT 'Standard code indicating how the milestone was resolved (e.g., completed, workaround, escalated).',
    `sla_milestone_status` STRING COMMENT 'Current status of the milestone (e.g., pending, met, breached, cancelled).. Valid values are `pending|met|breached|cancelled`',
    `target_timestamp` TIMESTAMP COMMENT 'The contractual target date and time by which the milestone must be achieved.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the SLA milestone record.',
    CONSTRAINT pk_sla_milestone PRIMARY KEY(`sla_milestone_id`)
) COMMENT 'Transactional entity tracking SLA milestone compliance events for individual service requests, capturing each SLA target (first response, acknowledgment, resolution), target timestamp, actual completion timestamp, breach flag, breach reason, and elapsed time. Enables SLA performance monitoring and breach root-cause analysis across service contracts and entitlement tiers. Maps to Salesforce Service Cloud Milestone.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`engineer` (
    `engineer_id` BIGINT COMMENT 'Primary key for engineer',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for payroll and performance review; each service engineer is an employee tracked in HR.',
    `zone_id` BIGINT COMMENT '',
    `active_assignment_count` STRING COMMENT 'Number of service assignments currently active for the engineer.',
    `address_line1` STRING COMMENT 'First line of the engineers mailing address.',
    `address_line2` STRING COMMENT 'Second line of the engineers mailing address.',
    `availability_status` STRING COMMENT '',
    `certification_drive_expiry` DATE COMMENT 'Expiration date of the drive‑systems certification.',
    `certification_electrification_expiry` DATE COMMENT 'Expiration date of the electrification certification.',
    `certification_hmi_expiry` DATE COMMENT 'Expiration date of the HMI certification.',
    `certification_plc_expiry` DATE COMMENT 'Expiration date of the PLC certification.',
    `certification_robotics_expiry` DATE COMMENT 'Expiration date of the robotics certification.',
    `certification_scada_expiry` DATE COMMENT 'Expiration date of the SCADA certification.',
    `certification_status` STRING COMMENT '',
    `city` STRING COMMENT 'City of the engineers mailing address.',
    `classification_or_type` STRING COMMENT 'Category of the engineer (e.g., internal employee, contractor, vendor).. Valid values are `internal|contractor|vendor`',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the engineers address.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the engineer record was first created.',
    `currency_code` STRING COMMENT '',
    `dispatch_zone` STRING COMMENT 'Specific dispatch zone or area assigned to the engineer.',
    `email` STRING COMMENT '',
    `email_address` STRING COMMENT 'Primary email address for the engineer.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `employment_type` STRING COMMENT 'Type of employment relationship.. Valid values are `full_time|part_time|contract|temp`',
    `full_name` STRING COMMENT 'Legal full name of the engineer.',
    `hire_date` DATE COMMENT 'Date the engineer was hired.',
    `hourly_rate` DECIMAL(18,2) COMMENT '',
    `labor_classification` STRING COMMENT 'Labor classification for payroll and cost allocation.. Valid values are `skilled|unskilled|technician|engineer`',
    `labor_rate_hourly` DECIMAL(18,2) COMMENT 'Standard hourly labor rate for the engineer.',
    `last_dispatch_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent dispatch of the engineer.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `lifecycle_status` STRING COMMENT 'Current lifecycle status of the engineer.. Valid values are `active|inactive|on_leave|retired|terminated`',
    `max_travel_distance_km` STRING COMMENT 'Maximum distance (in km) the engineer is willing to travel.',
    `engineer_name` STRING COMMENT '',
    `next_available_timestamp` TIMESTAMP COMMENT 'Estimated timestamp when the engineer will be next available for dispatch.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates if the engineer is eligible for overtime work.',
    `performance_rating` STRING COMMENT 'Most recent performance rating for the engineer.. Valid values are `A|B|C|D|E`',
    `phone` STRING COMMENT '',
    `phone_number` STRING COMMENT 'Primary contact phone number for the engineer.. Valid values are `^+?[0-9]{7,15}$`',
    `postal_code` STRING COMMENT 'Postal code of the engineers mailing address.',
    `primary_contact_method` STRING COMMENT 'Preferred method for contacting the engineer.. Valid values are `email|phone|sms`',
    `primary_language` STRING COMMENT 'Primary language spoken by the engineer.',
    `product_family_competency` STRING COMMENT 'Product families or equipment lines the engineer is qualified to service.',
    `secondary_languages` STRING COMMENT 'Additional languages spoken by the engineer, comma‑separated.',
    `security_clearance_level` STRING COMMENT 'Security clearance level required for assignments.. Valid values are `none|confidential|secret|top_secret`',
    `service_region` STRING COMMENT 'Geographic region where the engineer provides service.. Valid values are `NA|EU|APAC|LATAM|MEA`',
    `shift_preference` STRING COMMENT 'Preferred work shift for the engineer.. Valid values are `day|night|flex`',
    `skill_drive_systems_certified` BOOLEAN COMMENT 'Indicates if the engineer holds a drive‑systems certification.',
    `skill_electrification_certified` BOOLEAN COMMENT 'Indicates if the engineer holds an electrification certification.',
    `skill_hmi_certified` BOOLEAN COMMENT 'Indicates if the engineer holds an HMI certification.',
    `skill_level` STRING COMMENT '',
    `skill_plc_certified` BOOLEAN COMMENT 'Indicates if the engineer holds a PLC certification.',
    `skill_robotics_certified` BOOLEAN COMMENT 'Indicates if the engineer holds a robotics certification.',
    `skill_scada_certified` BOOLEAN COMMENT 'Indicates if the engineer holds a SCADA certification.',
    `specialization` STRING COMMENT '',
    `state_province` STRING COMMENT 'State or province of the engineers mailing address.',
    `termination_date` DATE COMMENT 'Date the engineers employment ended, if applicable.',
    `travel_eligibility` BOOLEAN COMMENT 'Indicates if the engineer is eligible for travel assignments.',
    `union_member_flag` BOOLEAN COMMENT 'Indicates whether the engineer is a union member.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the engineer record.',
    `years_of_experience` STRING COMMENT 'Total years of relevant field service experience.',
    CONSTRAINT pk_engineer PRIMARY KEY(`engineer_id`)
) COMMENT 'Master entity representing field service engineers and technical support specialists assigned to service operations. Captures employee reference, skill certifications (PLC, SCADA, HMI, drive systems, electrification, robotics), product family competencies, service region assignment, current availability status (available, dispatched, on-leave, training), dispatch zone, language capabilities, active assignment count, and certification expiry dates. Serves as the SSOT for field service resource profiles and dispatch eligibility within the service domain.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`zone` (
    `zone_id` BIGINT COMMENT 'Unique surrogate key for the service zone.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Operational expenses of a service zone are allocated to a cost center for regional financial planning.',
    `employee_id` BIGINT COMMENT 'Employee responsible for managing the service zone.',
    `holiday_calendar_id` BIGINT COMMENT 'Reference to the calendar that defines public holidays for the zone.',
    `service_center_id` BIGINT COMMENT 'Identifier of the service center or depot responsible for the zone.',
    `active_flag` BOOLEAN COMMENT '',
    `city_list` STRING COMMENT 'Comma‑separated list of major cities included in the zone.',
    `zone_code` STRING COMMENT 'Business identifier code used in external systems and contracts.',
    `country` STRING COMMENT 'Three‑letter ISO country code where the zone resides.. Valid values are `^[A-Z]{3}$`',
    `coverage_area_sqkm` DECIMAL(18,2) COMMENT 'Geographic size of the zone in square kilometres.',
    `coverage_description` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the zone record was first created.',
    `zone_description` STRING COMMENT 'Free‑form description of the zone’s characteristics and purpose.',
    `effective_from` DATE COMMENT 'Date when the zone becomes active for dispatch planning.',
    `effective_until` DATE COMMENT 'Date when the zone is retired or re‑defined (null if open‑ended).',
    `is_holiday_observed` BOOLEAN COMMENT 'Indicates whether holidays from the linked calendar affect service commitments.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `latitude_center` DECIMAL(18,2) COMMENT 'Latitude of the geographic centroid of the zone.',
    `longitude_center` DECIMAL(18,2) COMMENT 'Longitude of the geographic centroid of the zone.',
    `max_travel_time_minutes` STRING COMMENT 'Maximum expected travel time from the service center to any point in the zone.',
    `zone_name` STRING COMMENT 'Human‑readable name of the service territory.',
    `operating_hours` STRING COMMENT 'Standard daily operating window for field service (e.g., 08:00-17:00).. Valid values are `^([01]d|2[0-3]):[0-5]d-([01]d|2[0-3]):[0-5]d$`',
    `postal_code_range` STRING COMMENT 'Range of postal codes (e.g., 10001‑10292) defining the zone boundaries.',
    `priority_rank` STRING COMMENT 'Numeric rank used to prioritize dispatches across zones (1 = highest).',
    `region` STRING COMMENT 'High‑level region (e.g., North America, EMEA) for reporting and routing.',
    `sla_coverage_level` STRING COMMENT 'Level of service commitment promised for the zone.. Valid values are `gold|silver|bronze|standard`',
    `state_province` STRING COMMENT 'State or province within the country covered by the zone.',
    `supported_product_family` STRING COMMENT 'Product families that can be serviced within this zone.. Valid values are `automation|electrification|smart_infrastructure|control_systems|sensors|software`',
    `time_zone` STRING COMMENT 'IANA time‑zone identifier for the zone (e.g., America/New_York).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the zone record.',
    `zone_status` STRING COMMENT 'Current lifecycle status of the zone.. Valid values are `active|inactive|planned|retired`',
    CONSTRAINT pk_zone PRIMARY KEY(`zone_id`)
) COMMENT 'Master entity defining geographic service territories used for field service dispatch routing and SLA coverage planning. Captures territory name, geographic boundaries (region, country, state/province, postal code ranges), assigned service center or depot, operating hours, holiday calendar reference, territory manager, and supported product families. Enables optimized field engineer dispatch, travel time estimation, and ensures SLA commitments are achievable based on geographic coverage density.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` (
    `service_capa_record_id` BIGINT COMMENT 'System-generated unique identifier for the CAPA record.',
    `asset_work_order_id` BIGINT COMMENT 'Link to the maintenance work order associated with the CAPA.',
    `compliance_capa_record_id` BIGINT COMMENT 'Foreign key linking to compliance.capa_record. Business justification: Service CAPA actions are reported to compliance CAPA records to ensure regulatory closure and audit traceability.',
    `design_review_id` BIGINT COMMENT 'Foreign key linking to engineering.design_review. Business justification: CAPA records often stem from findings in a design review; linking provides the design context for corrective actions.',
    `request_id` BIGINT COMMENT 'Link to the service case that originated the CAPA.',
    `employee_id` BIGINT COMMENT 'Identifier of the person accountable for implementing the corrective action.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: CAPA actions linked to Project enable quality improvement tracking for specific capital projects.',
    `service_request_id` BIGINT COMMENT '',
    `tertiary_service_corrective_action_owner_employee_id` BIGINT COMMENT 'Employee responsible for executing the corrective action.',
    `actual_completion_date` DATE COMMENT 'Date when the corrective/preventive actions were actually finished.',
    `affected_units_quantity` STRING COMMENT 'Number of units impacted by the issue.',
    `capa_number` STRING COMMENT 'External CAPA number assigned by the quality system.',
    `capa_status` STRING COMMENT '',
    `capa_type` STRING COMMENT '',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the CAPA record was closed.',
    `closure_date` DATE COMMENT '',
    `compliance_status` STRING COMMENT 'Current compliance state of the CAPA with internal quality standards.. Valid values are `compliant|non_compliant|pending`',
    `corrective_action` STRING COMMENT '',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective action to eliminate the root cause.',
    `cost_actual` DECIMAL(18,2) COMMENT 'Actual cost incurred after actions are completed.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated financial impact of implementing the corrective/preventive actions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the CAPA record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for cost fields.. Valid values are `^[A-Z]{3}$`',
    `documentation_url` STRING COMMENT 'Link to supporting documents or drawings related to the CAPA.',
    `due_date` DATE COMMENT '',
    `effectiveness_verified_flag` BOOLEAN COMMENT '',
    `is_closed` BOOLEAN COMMENT 'Indicates whether the CAPA has been formally closed.',
    `issue_description` BOOLEAN COMMENT 'Narrative description of the problem that triggered the CAPA.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT 'Free‑form notes entered by users.',
    `owner_name` STRING COMMENT '',
    `preventive_action` STRING COMMENT '',
    `preventive_action_description` STRING COMMENT 'Plan to prevent recurrence of the issue.',
    `priority` STRING COMMENT 'Business priority assigned to the CAPA.. Valid values are `low|medium|high|critical`',
    `product_family` STRING COMMENT 'Family or line of products affected by the CAPA.',
    `product_model` STRING COMMENT 'Specific model identifier of the affected product.',
    `risk_level` STRING COMMENT 'Overall risk rating associated with the non‑conformance.. Valid values are `low|medium|high`',
    `root_cause` STRING COMMENT '',
    `root_cause_analysis_date` DATE COMMENT 'Date when the root cause analysis was completed.',
    `root_cause_category` STRING COMMENT 'High‑level category of the root cause (e.g., Design, Process, Material).',
    `root_cause_subcategory` STRING COMMENT 'More detailed classification within the root cause category.',
    `serial_number` STRING COMMENT 'Unique serial number of the equipment or component.',
    `service_capa_record_status` STRING COMMENT 'Current lifecycle status of the CAPA record.. Valid values are `open|in_progress|closed|cancelled`',
    `severity` STRING COMMENT 'Severity level of the issue prompting the CAPA.. Valid values are `minor|major|critical`',
    `source` STRING COMMENT 'Origin of the CAPA record.. Valid values are `field_failure|service_case|recurring_defect|audit`',
    `target_completion_date` DATE COMMENT 'Planned date by which the corrective/preventive actions should be completed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the CAPA record.',
    `verification_date` DATE COMMENT 'Date on which the verification activity was performed.',
    `verification_method` STRING COMMENT 'Method used to verify that the corrective action is effective.. Valid values are `test|inspection|audit|review`',
    `verification_result` STRING COMMENT 'Outcome of the verification activity.. Valid values are `passed|failed|partial`',
    CONSTRAINT pk_service_capa_record PRIMARY KEY(`service_capa_record_id`)
) COMMENT 'Transactional entity representing Corrective and Preventive Action (CAPA) records initiated from service cases, field failures, or recurring defect patterns identified through after-sales support. Captures CAPA number, root cause category, affected product family, corrective action description, preventive action plan, responsible owner, target completion date, verification method, and closure status. Links service domain quality feedback to engineering and quality domain improvement processes.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` (
    `satisfaction_survey_id` BIGINT COMMENT 'Primary key for satisfaction_survey',
    `customer_account_id` BIGINT COMMENT 'Unique identifier of the customer who received the service and completed the survey.',
    `engineer_id` BIGINT COMMENT 'Identifier of the field service engineer or technician who performed the service.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Post‑Project Customer Satisfaction Survey ties survey results to the project for performance evaluation.',
    `request_id` BIGINT COMMENT '',
    `satisfaction_service_request_id` BIGINT COMMENT 'Identifier of the service request or field service work order that triggered the survey.',
    `communication_rating` STRING COMMENT 'Rating (1‑5) of the clarity and effectiveness of communication during the service.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `csat_score` DECIMAL(18,2) COMMENT '',
    `engineer_competence_rating` STRING COMMENT 'Rating (1‑5) of the engineers technical competence and professionalism.',
    `issue_resolution_rating` BOOLEAN COMMENT 'Rating (1‑5) of how effectively the issue was resolved.',
    `language` STRING COMMENT 'Language in which the survey was presented to the customer.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `lifecycle_status` STRING COMMENT 'Current processing state of the survey record.. Valid values are `pending|completed|cancelled|expired`',
    `nps_score` STRING COMMENT 'Numeric NPS value ranging from -100 to 100, applicable when survey_type = NPS.',
    `overall_score` DECIMAL(18,2) COMMENT 'Aggregated satisfaction rating (e.g., 1‑5 or 0‑10) representing the customers overall impression.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the survey record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the survey record.',
    `respondent_email` STRING COMMENT '',
    `response_text` STRING COMMENT '',
    `response_time_rating` STRING COMMENT 'Rating (1‑5) of how quickly the service request was responded to.',
    `response_timestamp` TIMESTAMP COMMENT 'Date‑time when the customer submitted the survey response.',
    `survey_channel` STRING COMMENT 'Medium through which the survey was delivered to the customer.. Valid values are `email|phone|web|in_app|paper`',
    `survey_date` DATE COMMENT '',
    `survey_number` STRING COMMENT 'Human‑readable identifier or code assigned to the survey instance.',
    `survey_status` STRING COMMENT '',
    `survey_type` STRING COMMENT 'Indicates the methodology of the survey, e.g., Customer Satisfaction (CSAT) or Net Promoter Score (NPS).. Valid values are `CSAT|NPS`',
    `survey_version` STRING COMMENT 'Version identifier of the survey template used, supporting template evolution tracking.',
    `verbatim_feedback` DECIMAL(18,2) COMMENT 'Open‑ended text field capturing free‑form comments from the customer.',
    CONSTRAINT pk_satisfaction_survey PRIMARY KEY(`satisfaction_survey_id`)
) COMMENT 'Transactional entity capturing post-service customer satisfaction survey responses collected after service request closure or field service visit completion. Captures survey type (CSAT, NPS), overall satisfaction score, individual dimension ratings (response time, engineer competence, issue resolution, communication), verbatim feedback, survey channel, and response timestamp. Provides voice-of-customer data for service quality improvement and SLA effectiveness measurement.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` (
    `knowledge_article_id` BIGINT COMMENT 'Unique identifier for the knowledge article.',
    `engineer_id` BIGINT COMMENT 'Foreign key linking to service.engineer. Business justification: Knowledge article author is a service engineer; FK replaces free‑text author field.',
    `sku_master_id` BIGINT COMMENT 'P11: Connect product.knowledge_article by adding column product_sku_master_id (BIGINT) with an FK to product.sku_master.sku_master_id. P11: connect_table: product.knowledge_article** - add column product_sku_master_id (BIGINT) with FK to pr',
    `applicable_models` STRING COMMENT 'Comma‑separated list of product model identifiers covered by the article.',
    `article_body` STRING COMMENT '',
    `article_number` STRING COMMENT '',
    `article_status` STRING COMMENT '',
    `article_title` STRING COMMENT '',
    `article_type` STRING COMMENT 'Classification of the article (e.g., troubleshooting, bulletin, safety recall, mandatory retrofit, advisory, firmware patch).. Valid values are `troubleshooting|bulletin|safety_recall|mandatory_retrofit|advisory|firmware_patch`',
    `attachment_url` STRING COMMENT 'Link to any supporting documents or media files.',
    `author_name` STRING COMMENT '',
    `knowledge_article_category` STRING COMMENT '',
    `compliance_deadline` DATE COMMENT 'Regulatory or contractual deadline for completing the required action.',
    `confidentiality_level` STRING COMMENT 'Data classification level for the article.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the article record was created.',
    `effective_from` DATE COMMENT 'Date from which the articles guidance is applicable.',
    `effective_until` DATE COMMENT 'Date after which the articles guidance is no longer applicable (nullable).',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Estimated effort in hours to execute the resolution.',
    `firmware_version` STRING COMMENT 'Firmware version(s) to which the article applies.',
    `helpful_rating` DECIMAL(18,2) COMMENT '',
    `is_faq` BOOLEAN COMMENT 'Indicates whether the article is a Frequently Asked Question (true) or not (false).',
    `is_mandatory` BOOLEAN COMMENT 'True if the article must be applied to comply with a regulation or contract.',
    `knowledge_article_status` STRING COMMENT 'Current lifecycle status of the article.. Valid values are `draft|published|archived|retired`',
    `language` STRING COMMENT 'Language of the article content.. Valid values are `en|es|de|fr|zh|ja`',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `last_review_date` DATE COMMENT 'Date when the article was last reviewed for accuracy.',
    `parts_required` STRING COMMENT 'List of part numbers or SKUs needed for the repair.',
    `product_family` STRING COMMENT 'Product family or line to which the article applies.',
    `publication_date` DATE COMMENT 'Date the article was first made publicly available.',
    `published_date` DATE COMMENT '',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the article satisfies applicable regulatory requirements.',
    `related_article_ids` STRING COMMENT 'Comma‑separated list of knowledge_article_id values that are related.',
    `required_action` STRING COMMENT 'Action that field engineers must perform (e.g., replace part, update firmware).',
    `resolution_procedure` STRING COMMENT 'Step‑by‑step instructions to resolve the issue.',
    `review_cycle` STRING COMMENT 'Frequency at which the article must be reviewed.. Valid values are `annual|semiannual|quarterly|monthly`',
    `revision_history` STRING COMMENT 'Chronological log of changes made to the article.',
    `root_cause` STRING COMMENT 'Narrative of the underlying cause of the issue.',
    `serial_number_range` STRING COMMENT 'Range of equipment serial numbers the article applies to (e.g., 1000‑1999).',
    `software_version` STRING COMMENT 'Software version(s) to which the article applies.',
    `summary` STRING COMMENT 'Brief summary or abstract of the article content.',
    `symptom_keywords` STRING COMMENT 'Keywords describing observed symptoms that trigger the article.',
    `tags` STRING COMMENT 'User‑defined tags or keywords for searchability.',
    `title` STRING COMMENT 'Descriptive title of the knowledge article.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the article.',
    `usage_count` BIGINT COMMENT 'Number of times the article has been accessed by service personnel.',
    `version_number` STRING COMMENT 'Version identifier for the article (e.g., v1.2).',
    `view_count` STRING COMMENT '',
    CONSTRAINT pk_knowledge_article PRIMARY KEY(`knowledge_article_id`)
) COMMENT 'Master entity representing the technical knowledge base including troubleshooting articles, official service bulletins, field service notices, safety recalls, FAQs, and technical notes used by service engineers and support agents. Captures article type/classification (troubleshooting, bulletin, safety recall, mandatory retrofit, advisory update, firmware patch, FAQ), title, product family applicability, affected product models and serial number ranges, symptom keywords, root cause description, resolution procedure, applicable firmware/software versions, required action, compliance deadline, estimated labor hours, parts required, publication status, and usage count. Supports first-call resolution improvement, field engineer self-service, proactive service campaign execution, and regulatory recall compliance tracking.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`bulletin` (
    `bulletin_id` BIGINT COMMENT 'Primary key for bulletin',
    `engineer_id` BIGINT COMMENT 'Foreign key linking to service.engineer. Business justification: Bulletin author is a service engineer; FK replaces free‑text author field.',
    `sku_master_id` BIGINT COMMENT 'P10: Connect product.bulletin by adding column product_sku_master_id (BIGINT) with an FK to product.sku_master.sku_master_id. P10: connect_table: product.bulletin** - add column product_sku_master_id (BIGINT) with FK to product.sku_master.s',
    `action_required` STRING COMMENT 'Detailed description of the service action(s) that must be performed.',
    `affected_product_models` STRING COMMENT 'Comma‑separated list of product model identifiers impacted by the bulletin.',
    `bulletin_number` STRING COMMENT 'Official alphanumeric identifier assigned to the bulletin by engineering.',
    `bulletin_status` STRING COMMENT 'Current lifecycle state of the bulletin.. Valid values are `draft|issued|active|closed|withdrawn`',
    `bulletin_title` STRING COMMENT '',
    `bulletin_type` STRING COMMENT 'Category of the bulletin indicating its purpose and urgency.. Valid values are `safety_recall|mandatory_retrofit|advisory_update|firmware_patch`',
    `compliance_deadline` DATE COMMENT 'Latest date by which the required actions must be completed to remain compliant.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bulletin record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency for estimated cost.. Valid values are `USD|EUR|JPY|GBP|CNY|CAD`',
    `bulletin_description` STRING COMMENT '',
    `distribution_channel` STRING COMMENT 'Method used to disseminate the bulletin to field personnel.. Valid values are `email|portal|field_technician|partner|api`',
    `effective_date` DATE COMMENT 'Date from which the bulletins actions become mandatory or recommended.',
    `engineering_department` STRING COMMENT 'Department within engineering responsible for the bulletin.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Projected total cost (parts + labor) for the bulletin actions.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Projected labor effort in hours to complete the required actions.',
    `expiration_date` DATE COMMENT 'Date after which the bulletin is no longer applicable.',
    `firmware_version` STRING COMMENT 'Specific firmware version that the bulletin addresses or updates.',
    `issue_date` DATE COMMENT 'Date the bulletin was formally issued to the field.',
    `labor_rate_per_hour` DECIMAL(18,2) COMMENT 'Standard labor rate used for cost estimation, expressed in the selected currency.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether compliance with the bulletin is mandatory (true) or advisory (false).',
    `parts_required` STRING COMMENT 'Comma‑separated list of part numbers and quantities needed to comply.',
    `regulatory_reference` STRING COMMENT 'Identifier of any external regulation or standard that mandates the bulletin.',
    `revision_number` STRING COMMENT 'Sequential revision number for the bulletin document.',
    `safety_notice_flag` BOOLEAN COMMENT 'True if the bulletin contains a safety‑critical notice.',
    `serial_number_range_end` STRING COMMENT 'Ending serial number in the inclusive range of units affected.',
    `serial_number_range_start` STRING COMMENT 'Starting serial number in the inclusive range of units affected.',
    `severity` STRING COMMENT '',
    `severity_level` STRING COMMENT 'Risk severity associated with the bulletin, used for prioritization.. Valid values are `critical|high|medium|low`',
    `software_patch_version` STRING COMMENT 'Version of the software patch associated with the bulletin.',
    `target_market` STRING COMMENT 'Geographic market(s) to which the bulletin applies.. Valid values are `NA|EU|APAC|LATAM|MEA`',
    `title` STRING COMMENT 'Short descriptive title of the bulletin.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the bulletin record.',
    `version` STRING COMMENT 'Version string (e.g., v1.2) of the bulletin.',
    CONSTRAINT pk_bulletin PRIMARY KEY(`bulletin_id`)
) COMMENT 'Master entity representing official technical service bulletins and field service notices issued by engineering or product management to communicate mandatory or advisory service actions for installed automation systems and equipment. Captures bulletin number, affected product models and serial number ranges, bulletin type (safety recall, mandatory retrofit, advisory update, firmware patch), action required, estimated labor hours, parts required, and compliance deadline. Drives proactive field service campaigns.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` (
    `service_pm_schedule_id` BIGINT COMMENT 'System-generated unique identifier for the preventive maintenance schedule.',
    `asset_pm_schedule_id` BIGINT COMMENT 'Reference to SSOT owner asset.asset_pm_schedule for pm_schedule conflict resolution.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory audit of preventive maintenance creation requires linking schedule to creator employee.',
    `equipment_register_id` BIGINT COMMENT 'Identifier of the customer‑installed equipment or system covered by the schedule.',
    `installed_base_id` BIGINT COMMENT '',
    `location_id` BIGINT COMMENT 'Identifier of the physical site or plant where the equipment resides.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Preventive Maintenance Scheduling for Project Assets ensures PM plans are associated with the correct capital project.',
    `service_asset_asset_pm_schedule_ssot_ref_id` BIGINT COMMENT 'SSOT reference to the single source of truth record; this product is a non-authoritative duplicate view.',
    `service_contract_id` BIGINT COMMENT 'Reference to the service contract under which the maintenance is provided.',
    `task_checklist_id` BIGINT COMMENT 'Identifier of the checklist of tasks to be performed during the maintenance visit.',
    `classification_or_type` STRING COMMENT 'High‑level classification of the maintenance approach.. Valid values are `preventive|predictive|corrective`',
    `compliance_status` STRING COMMENT 'Indicates whether the schedule complies with contractual or regulatory requirements.. Valid values are `compliant|non_compliant|pending|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the schedule record was first created in the system.',
    `service_pm_schedule_description` STRING COMMENT 'Free‑form description providing additional context about the maintenance schedule.',
    `effective_end_date` DATE COMMENT 'Date when the schedule expires; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the schedule becomes effective and eligible for execution.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT '',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Projected labor effort for the maintenance activity, expressed in hours.',
    `frequency_interval` STRING COMMENT '',
    `frequency_type` STRING COMMENT '',
    `interval_unit` STRING COMMENT 'Unit of measure for the maintenance interval (e.g., days, hours, cycles, meter reading).. Valid values are `days|hours|cycles|meter`',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the maintenance activity is mandatory under the contract (true) or optional (false).',
    `last_execution_date` DATE COMMENT 'Date when the maintenance task was last performed.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `last_performed_date` DATE COMMENT '',
    `lifecycle_status` STRING COMMENT 'Current lifecycle stage of the schedule.. Valid values are `planned|in_progress|completed|cancelled`',
    `maintenance_interval` DECIMAL(18,2) COMMENT 'Numeric value of the interval between maintenance actions.',
    `next_due_date` DATE COMMENT 'Scheduled date for the next maintenance execution.',
    `notes` STRING COMMENT 'Additional notes or remarks entered by planners or technicians.',
    `priority` STRING COMMENT 'Priority level assigned to the schedule for dispatch planning.. Valid values are `low|medium|high|critical`',
    `schedule_code` STRING COMMENT 'Business identifier code used externally to reference the schedule.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `schedule_name` STRING COMMENT 'Human‑readable name of the maintenance schedule.',
    `schedule_number` STRING COMMENT '',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the maintenance schedule.. Valid values are `active|inactive|suspended|draft`',
    `schedule_type` STRING COMMENT 'Indicates whether the schedule is time‑based, usage‑based, or condition‑based.. Valid values are `time_based|usage_based|condition_based`',
    `spare_parts_list` STRING COMMENT 'Comma‑separated list of part numbers required for the scheduled maintenance.',
    `updated_by` STRING COMMENT 'User identifier of the person who last updated the schedule record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the schedule record.',
    CONSTRAINT pk_service_pm_schedule PRIMARY KEY(`service_pm_schedule_id`)
) COMMENT 'Master entity defining scheduled preventive maintenance plans for customer-installed automation systems and equipment under service contracts. Captures maintenance plan type (time-based, usage-based, condition-based), maintenance interval, task checklist reference, required spare parts list, estimated labor hours, last execution date, next due date, and compliance status. Drives proactive field service dispatch and contract fulfillment tracking. Abbreviated from preventive_maintenance_schedule to comply with 30-character product name limit.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` (
    `service_contract_line_id` BIGINT COMMENT 'Primary key for the service_contract_line association',
    `equipment_register_id` BIGINT COMMENT 'Identifier of the asset or product covered by this line.',
    `service_contract_id` BIGINT COMMENT 'Identifier of the parent service contract header.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Each contract line item is governed by a regulatory requirement (e.g., safety standard), needed for compliance verification per line.',
    `sku_master_id` BIGINT COMMENT '',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Each contract line is fulfilled by a particular supplier; this link supports supplier performance metrics and pricing analysis per line.',
    `approval_date` DATE COMMENT 'Date when regulatory approval was granted.',
    `approval_reference` STRING COMMENT 'Reference number or document for regulatory approval.',
    `contract_line_description` STRING COMMENT 'Detailed description of the line item.',
    `coverage_end_timestamp` TIMESTAMP COMMENT 'Exact moment coverage ends.',
    `coverage_scope` STRING COMMENT 'Geographic or functional scope of the coverage for this equipment',
    `coverage_start_timestamp` TIMESTAMP COMMENT 'Exact moment coverage begins.',
    `coverage_type` STRING COMMENT 'Type of coverage applied to the equipment (e.g., preventive, full‑service)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `currency_code` STRING COMMENT '',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount applied to the line.',
    `discount_type` STRING COMMENT 'Method used to calculate the discount.. Valid values are `percentage|fixed|none`',
    `document_url` STRING COMMENT 'Link to supporting documentation for the line.',
    `effective_end_date` DATE COMMENT 'Date when coverage ends; null for open‑ended contracts.',
    `effective_start_date` DATE COMMENT 'Date when coverage for this equipment begins',
    `end_date` DATE COMMENT '',
    `is_exclusive` BOOLEAN COMMENT 'Indicates if the coverage is exclusive to the asset.',
    `is_renewable` BOOLEAN COMMENT 'Indicates if the line can be renewed after expiry.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `lifecycle_status` STRING COMMENT 'Lifecycle stage of the line item.. Valid values are `draft|approved|active|suspended|terminated`',
    `line_amount` DECIMAL(18,2) COMMENT '',
    `line_description` STRING COMMENT '',
    `line_number` STRING COMMENT '',
    `line_sequence` STRING COMMENT 'Sequential order of the line within the contract.',
    `metric_target_value` DECIMAL(18,2) COMMENT 'Target value for the service metric.',
    `metric_unit` STRING COMMENT 'Unit for the service metric (e.g., hours, percent).',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount after applying discount and tax.',
    `notes` STRING COMMENT 'Free‑form notes related to the contract line.',
    `price_amount` DECIMAL(18,2) COMMENT 'Monetary amount charged for this equipment under the contract line',
    `price_currency` DECIMAL(18,2) COMMENT 'Currency code for the price amount.',
    `price_unit` DECIMAL(18,2) COMMENT 'Billing unit associated with the price.',
    `product_category` STRING COMMENT 'Category of the covered product.',
    `product_family` STRING COMMENT 'Family classification of the covered product.',
    `quantity` DECIMAL(18,2) COMMENT 'Number of units covered by this line.',
    `regulatory_approval_flag` BOOLEAN COMMENT 'Indicates whether regulatory approval has been obtained.',
    `renewal_flag` BOOLEAN COMMENT 'Indicates if the line is set for automatic renewal.',
    `renewal_terms` STRING COMMENT 'Textual description of renewal conditions.',
    `service_contract_line_status` STRING COMMENT 'Current operational status of the contract line.. Valid values are `active|inactive|pending|cancelled|expired`',
    `service_level` STRING COMMENT 'Description of the service level (e.g., response time, uptime).',
    `service_metric` STRING COMMENT 'Metric used to measure service performance.',
    `sla_target_hours` DECIMAL(18,2) COMMENT 'Target number of service hours promised in the SLA.',
    `sla_tier` STRING COMMENT 'Service level agreement tier defining response and resolution targets',
    `start_date` DATE COMMENT '',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax applied to the line item.',
    `tax_included_flag` BOOLEAN COMMENT 'Indicates whether tax is already included in the price.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity.. Valid values are `unit|hour|day|month|year`',
    `unit_price` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update.',
    `warranty_flag` BOOLEAN COMMENT 'Indicates whether a warranty is included.',
    `warranty_period_months` STRING COMMENT 'Length of warranty coverage in months.',
    CONSTRAINT pk_service_contract_line PRIMARY KEY(`service_contract_line_id`)
) COMMENT 'Master entity representing individual line items within a service contract, each covering a specific installed asset, product family, or service scope element. Captures covered asset or product reference, coverage type, SLA tier, line-level pricing, coverage start/end dates, and renewal flag. Enables granular entitlement checking at the asset level and supports contract profitability analysis by line.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` (
    `remote_diagnostic_session_id` BIGINT COMMENT 'Unique system-generated identifier for each remote diagnostic session.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer whose equipment was serviced.',
    `employee_id` BIGINT COMMENT 'Identifier of the service engineer who performed the remote session.',
    `engineer_id` BIGINT COMMENT '',
    `equipment_register_id` BIGINT COMMENT 'Identifier of the equipment or system that was accessed remotely.',
    `installed_base_id` BIGINT COMMENT '',
    `location_id` BIGINT COMMENT 'Identifier of the physical site or plant where the asset resides.',
    `request_id` BIGINT COMMENT '',
    `bandwidth_mbps` DECIMAL(18,2) COMMENT 'Average data transfer bandwidth measured during the session.',
    `connection_method` STRING COMMENT 'Technical method used to establish the remote link for the session.. Valid values are `vpn|scada|iiot|hmi|remote_desktop`',
    `connection_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the session record was first created in the system.',
    `data_volume_mb` DECIMAL(18,2) COMMENT 'Total amount of diagnostic data transferred during the session.',
    `diagnostic_result` STRING COMMENT '',
    `diagnostic_tool` STRING COMMENT 'Software or utility employed by the technician during the session.. Valid values are `plc_viewer|oscilloscope|custom_script|log_analyzer`',
    `duration_minutes` DECIMAL(18,2) COMMENT '',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Total elapsed time of the session in seconds, calculated from start and end timestamps.',
    `end_timestamp` TIMESTAMP COMMENT 'Exact date and time when the remote diagnostic session ended.',
    `error_message` STRING COMMENT 'Any error text returned by the remote system or diagnostic tool.',
    `fault_code` STRING COMMENT 'Error or alarm code retrieved from the equipment during diagnosis.',
    `field_dispatch_needed` BOOLEAN COMMENT 'True if a subsequent on‑site service visit is required after the remote session.',
    `findings_summary` STRING COMMENT 'Concise narrative of the diagnostic observations and root cause analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `latency_ms` DECIMAL(18,2) COMMENT 'Average round‑trip latency observed during the session.',
    `notes` STRING COMMENT 'Additional free‑form comments captured by the technician.',
    `parameters_captured` STRING COMMENT 'Key parameter values (e.g., setpoints, sensor readings) recorded during the session.',
    `plc_program_state` STRING COMMENT 'Snapshot of the PLC program state captured at session start.',
    `recommended_action` STRING COMMENT 'Suggested remediation steps or configuration changes for the customer.',
    `remote_diagnostic_session_status` STRING COMMENT 'Current lifecycle state of the session.. Valid values are `open|in_progress|closed|cancelled`',
    `resolved_flag` BOOLEAN COMMENT 'Indicates whether the remote session fully resolved the reported issue.',
    `session_code` STRING COMMENT 'Business identifier assigned to the session, used for tracking and reference in service records.',
    `session_number` STRING COMMENT '',
    `session_status` STRING COMMENT '',
    `session_type` STRING COMMENT 'Purpose category of the remote session.. Valid values are `troubleshooting|maintenance|upgrade`',
    `start_timestamp` TIMESTAMP COMMENT 'Exact date and time when the remote diagnostic session began.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the session record.',
    CONSTRAINT pk_remote_diagnostic_session PRIMARY KEY(`remote_diagnostic_session_id`)
) COMMENT 'Transactional entity capturing remote diagnostic and telemetry-assisted troubleshooting sessions conducted by technical support engineers for customer-installed automation systems via IIoT connectivity, SCADA remote access, VPN tunnels, or HMI remote desktop. Captures session start/end timestamps, connection method, diagnostic tool used, fault codes retrieved, PLC program state, parameters captured, findings summary, recommended action, and whether the session resolved the issue without field dispatch. Supports remote-first service resolution strategy and field dispatch avoidance metrics.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` (
    `part_consumption_id` BIGINT COMMENT 'Primary key for part_consumption',
    `field_service_order_id` BIGINT COMMENT '',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Parts Consumption Accounting to Project Costs tracks part usage against the project budget for cost control.',
    `sales_contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: Parts used in service are billed to the originating sales contract; linking enables accurate cost allocation in the Service Parts Cost analysis.',
    `request_id` BIGINT COMMENT 'Identifier of the service request (transaction header) to which this part consumption line belongs.',
    `sku_master_id` BIGINT COMMENT '',
    `spare_part_id` BIGINT COMMENT 'Internal system identifier for the spare part consumed.',
    `supplier_id` BIGINT COMMENT 'Internal identifier of the external supplier providing the part.',
    `actual_delivery_date` DATE COMMENT 'Calendar date when the part was actually received.',
    `consumption_date` TIMESTAMP COMMENT '',
    `consumption_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the part was recorded as consumed on site.',
    `contract_coverage_flag` BOOLEAN COMMENT 'True if the part usage is reimbursable under a service contract separate from warranty.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Internal cost‑center code charged for the part consumption.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `delivery_tracking_number` STRING COMMENT 'Carrier‑provided tracking identifier for the part shipment.',
    `expected_delivery_date` DATE COMMENT 'Planned calendar date for part arrival at the service location.',
    `fulfillment_status` STRING COMMENT 'Current status of the part order fulfillment process.. Valid values are `pending|shipped|delivered|canceled`',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `line_number` STRING COMMENT 'Sequential number of the line within the service part order, used for ordering and reference.',
    `line_total_amount` DECIMAL(18,2) COMMENT 'Total monetary value for the line (quantity × unit price) before any discounts or taxes.',
    `notes` STRING COMMENT 'Additional free‑form comments captured by the technician.',
    `order_date` TIMESTAMP COMMENT 'Date‑time when the part order was created in the service system.',
    `order_urgency` STRING COMMENT 'Business‑defined urgency level for the part order, used for prioritization.. Valid values are `low|medium|high|critical`',
    `part_description` STRING COMMENT 'Human‑readable description of the spare part, including model or variant details.',
    `part_number` STRING COMMENT 'Manufacturer or internal SKU that uniquely identifies the spare part.',
    `quantity_consumed` DECIMAL(18,2) COMMENT 'Number of units of the part used during the service activity.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the part consumption record was first created in the lakehouse.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the part consumption record.',
    `source_type` STRING COMMENT 'Origin of the part supplied to the field technician.. Valid values are `warehouse_stock|van_stock|supplier_direct`',
    `total_cost` DECIMAL(18,2) COMMENT '',
    `unit_cost` DECIMAL(18,2) COMMENT '',
    `unit_of_measure` STRING COMMENT 'Unit in which the part quantity is measured (e.g., each, set, box).',
    `unit_price` DECIMAL(18,2) COMMENT 'Standard price per unit of the part at the time of consumption, in the transaction currency.',
    `warranty_coverage_flag` BOOLEAN COMMENT 'Indicates whether the part consumption is covered under a warranty or service contract.',
    `warranty_flag` BOOLEAN COMMENT '',
    CONSTRAINT pk_part_consumption PRIMARY KEY(`part_consumption_id`)
) COMMENT 'Transactional entity representing spare parts consumption and parts orders associated with field service activities, including emergency parts procurement for critical equipment downtime. Captures part number (SKU), quantity consumed, source (warehouse stock, van stock, supplier direct ship), cost, warranty/contract coverage flag, order urgency classification, fulfillment status, and delivery tracking. Provides traceability of parts usage per service event for cost recovery, warranty claims, inventory replenishment triggers, and bridges service domain parts demand with inventory and procurement domain supply.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`contract_line` (
    `contract_line_id` BIGINT COMMENT 'Primary key for contract_line',
    `equipment_register_id` BIGINT COMMENT 'P9: Connect asset.contract_line by adding column equipment_register_id (BIGINT) with an FK to asset.equipment_register.equipment_register_id. P9: connect_table: asset.contract_line** - add column equipment_register_id (BIGINT) with FK t',
    `sku_master_id` BIGINT COMMENT 'P8: Connect product.contract_line by adding column product_sku_master_id (BIGINT) with an FK to product.sku_master.sku_master_id. P8: connect_table: product.contract_line** - add column product_sku_master_id (BIGINT) with FK to product.sku_',
    `service_contract_id` BIGINT COMMENT 'Foreign key linking to service.service_contract. Business justification: Contract line must reference its parent service contract; adding service_contract_id creates the required parent‑child relationship within the service domain.',
    `auto_renew_flag` BOOLEAN COMMENT 'Indicates whether the line renews automatically.',
    `billing_amount` DECIMAL(18,2) COMMENT '',
    `billing_frequency` STRING COMMENT '',
    `cancellation_reason` STRING COMMENT 'Cancellation reason',
    `coverage_end_date` TIMESTAMP COMMENT 'coverage end date',
    `coverage_level` STRING COMMENT '',
    `coverage_start_date` TIMESTAMP COMMENT 'coverage start date',
    `coverage_type` STRING COMMENT '',
    `covered_quantity` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `discount_percent` DECIMAL(18,2) COMMENT 'Discount percentage applied to this line.',
    `end_date` DATE COMMENT '',
    `entitlement_hours` DECIMAL(18,2) COMMENT 'Entitled service hours for this line.',
    `escalation_percent` DECIMAL(18,2) COMMENT 'Escalation percent',
    `extended_price_amount` DECIMAL(18,2) COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `line_amount` DECIMAL(18,2) COMMENT '',
    `line_description` STRING COMMENT '',
    `line_notes` STRING COMMENT '',
    `line_number` STRING COMMENT '',
    `line_price` DECIMAL(18,2) COMMENT '',
    `line_price_amount` DECIMAL(18,2) COMMENT '',
    `line_status` STRING COMMENT '',
    `notes` STRING COMMENT '',
    `priority_level` STRING COMMENT 'Priority level',
    `quantity` DECIMAL(18,2) COMMENT '',
    `renewal_flag` BOOLEAN COMMENT '',
    `renewal_term_months` STRING COMMENT 'Renewal term months',
    `response_time_hours` STRING COMMENT '',
    `service_level` STRING COMMENT '',
    `service_level_code` STRING COMMENT 'Service level tier applicable to this contract line.',
    `sla_level` STRING COMMENT '',
    `sla_response_hours` DECIMAL(18,2) COMMENT '',
    `start_date` DATE COMMENT '',
    `contract_line_status` STRING COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per covered unit for the service line.',
    `unit_price_amount` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_contract_line PRIMARY KEY(`contract_line_id`)
) COMMENT 'Represents the association between equipment_register and service_contract, capturing coverage details, SLA tier, pricing, and effective dates for each equipment covered by a contract.. Existence Justification: An equipment asset can be covered by multiple service contracts over its lifecycle, and a single service contract can cover many equipment assets. Each equipment‑contract pairing is managed as a contract line item that stores coverage type, SLA tier, pricing, and effective dates. The relationship is actively created, updated, and deleted by contract administrators.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`engineer_assignment` (
    `engineer_assignment_id` BIGINT COMMENT 'Primary key for the engineer_assignment association',
    `control_system_id` BIGINT COMMENT 'Foreign key linking to the target control system',
    `field_service_order_id` BIGINT COMMENT 'Connect service.engineer_assignment by adding column field_service_order_id (BIGINT) with an FK to service.field_service_order.field_service_order_id. P12: connect_table: service.engineer_assignment** - add column field_service_order_id (BI',
    `engineer_id` BIGINT COMMENT 'Foreign key linking to the assigned engineer',
    `request_id` BIGINT COMMENT '',
    `actual_end_timestamp` TIMESTAMP COMMENT '',
    `actual_hours` DECIMAL(18,2) COMMENT '',
    `actual_start_timestamp` TIMESTAMP COMMENT '',
    `allocated_hours` DECIMAL(18,2) COMMENT '',
    `assigned_hours` DECIMAL(18,2) COMMENT '',
    `assigned_timestamp` TIMESTAMP COMMENT 'assigned timestamp',
    `assignment_date` DATE COMMENT '',
    `assignment_end_date` DATE COMMENT 'Date when the engineers assignment to the control system ends (null if ongoing)',
    `assignment_notes` STRING COMMENT '',
    `assignment_number` STRING COMMENT '',
    `assignment_role` STRING COMMENT 'Role of the engineer on the control system (e.g., Lead, Support, Specialist)',
    `assignment_start_date` DATE COMMENT 'Date when the engineers assignment to the control system begins',
    `assignment_status` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `end_timestamp` TIMESTAMP COMMENT 'end timestamp',
    `estimated_hours` DECIMAL(18,2) COMMENT '',
    `is_primary_flag` BOOLEAN COMMENT '',
    `labor_hours` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT '',
    `planned_hours` DECIMAL(18,2) COMMENT '',
    `role` STRING COMMENT 'Specifies the functional responsibility or job function assigned to the engineer for this particular service assignment, such as lead technician or support specialist.',
    `role_on_assignment` STRING COMMENT '',
    `scheduled_end` TIMESTAMP COMMENT '',
    `scheduled_end_time` TIMESTAMP COMMENT '',
    `scheduled_end_timestamp` TIMESTAMP COMMENT '',
    `scheduled_start` TIMESTAMP COMMENT '',
    `scheduled_start_time` TIMESTAMP COMMENT '',
    `scheduled_start_timestamp` TIMESTAMP COMMENT '',
    `start_timestamp` TIMESTAMP COMMENT 'start timestamp',
    `travel_time_hours` STRING COMMENT '',
    CONSTRAINT pk_engineer_assignment PRIMARY KEY(`engineer_assignment_id`)
) COMMENT 'Represents the assignment of a field service engineer to a control system. Each record captures the engineers role on the system and the period of the assignment, enabling tracking of maintenance responsibilities and compliance.. Existence Justification: Field service engineers are actively assigned to one or more control systems for maintenance, commissioning, and support. Each control system can have multiple engineers assigned, with each assignment capturing the engineers role and the start/end dates of the assignment. The assignment is a managed business entity that is created, updated, and retired as operational needs change.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` (
    `task_checklist_id` BIGINT COMMENT 'Primary key for task_checklist',
    `field_service_order_id` BIGINT COMMENT '',
    `parent_task_checklist_id` BIGINT COMMENT 'Self-referencing FK on task_checklist (parent_task_checklist_id)',
    `service_pm_schedule_id` BIGINT COMMENT '',
    `applicable_equipment_type` STRING COMMENT 'Type of automation equipment or system that the checklist is designed for.',
    `checklist_name` STRING COMMENT '',
    `checklist_number` STRING COMMENT '',
    `task_checklist_code` STRING COMMENT 'Alphanumeric code that uniquely identifies the checklist across enterprise systems.',
    `completed_flag` BOOLEAN COMMENT '',
    `completed_timestamp` TIMESTAMP COMMENT '',
    `compliance_required` BOOLEAN COMMENT 'True when the checklist must satisfy industry or safety regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the checklist record was initially loaded into the data platform.',
    `task_checklist_description` STRING COMMENT 'Detailed narrative explaining the purpose, scope, and usage guidelines for the checklist.',
    `effective_from` DATE COMMENT 'Calendar date from which the checklist is considered active and applicable.',
    `effective_until` DATE COMMENT 'Calendar date after which the checklist should no longer be used (nullable for open‑ended).',
    `is_mandatory` BOOLEAN COMMENT 'True if the checklist must be completed for compliance or safety reasons.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `last_reviewed_date` DATE COMMENT 'Date when the checklist was last examined for relevance and compliance.',
    `task_checklist_name` STRING COMMENT 'Descriptive name of the checklist used by service technicians and planners.',
    `notes` STRING COMMENT 'Supplementary information, comments, or special instructions related to the checklist.',
    `owner_role` STRING COMMENT 'Organizational role (e.g., Field Engineer, Service Manager) that maintains the checklist.',
    `task_checklist_status` STRING COMMENT 'Indicates whether the checklist is currently in use, retired, or under development.',
    `task_count` STRING COMMENT 'Total count of tasks that belong to this checklist.',
    `task_description` STRING COMMENT '',
    `task_sequence` STRING COMMENT '',
    `task_status` STRING COMMENT '',
    `task_checklist_type` STRING COMMENT 'Classification of the checklist based on service activity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to the checklist metadata.',
    `version_number` STRING COMMENT 'Sequential version identifier used to track revisions of the checklist.',
    CONSTRAINT pk_task_checklist PRIMARY KEY(`task_checklist_id`)
) COMMENT 'Master reference table for task_checklist. Referenced by task_checklist_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`service_center` (
    `service_center_id` BIGINT COMMENT 'Primary key for service_center',
    `parent_service_center_id` BIGINT COMMENT 'Self-referencing FK on service_center (parent_service_center_id)',
    `active_flag` BOOLEAN COMMENT '',
    `address` STRING COMMENT '',
    `address_line1` STRING COMMENT 'Primary street address of the service center.',
    `address_line2` STRING COMMENT 'Secondary address information (e.g., suite or floor).',
    `average_resolution_time_minutes` STRING COMMENT 'Mean time from request receipt to case closure.',
    `average_response_time_minutes` STRING COMMENT 'Mean time from service request receipt to first response.',
    `center_code` STRING COMMENT 'Business identifier or code assigned to the service center.',
    `center_type` STRING COMMENT 'Classification of the service center based on its operational scope.',
    `city` STRING COMMENT 'City where the service center is located.',
    `closing_date` DATE COMMENT 'Date when the service center ceased operations (if applicable).',
    `service_center_code` STRING COMMENT '',
    `compliance_certifications` STRING COMMENT 'Pipe‑separated list of certifications held by the center.',
    `contact_phone` STRING COMMENT '',
    `contract_number` STRING COMMENT 'Identifier of the primary service contract governing the center.',
    `country` STRING COMMENT '',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the service center location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the service center record was first created.',
    `email_address` STRING COMMENT 'Primary contact email address for the service center.',
    `external_system_code` STRING COMMENT 'Identifier of the service center in an external ERP or CRM system.',
    `inspection_status` STRING COMMENT 'Result of the latest compliance inspection.',
    `is_primary_center` BOOLEAN COMMENT 'True if this center is designated as the primary hub for its region.',
    `last_inspection_date` DATE COMMENT 'Most recent date on which the center passed a compliance inspection.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `latitude` DOUBLE COMMENT 'Geographic latitude coordinate of the service center.',
    `longitude` DOUBLE COMMENT 'Geographic longitude coordinate of the service center.',
    `manager_email` STRING COMMENT 'Email address of the service center manager.',
    `manager_name` STRING COMMENT 'Full name of the person responsible for the service center.',
    `manager_phone` STRING COMMENT 'Phone number of the service center manager.',
    `service_center_name` STRING COMMENT 'Human‑readable name of the service center.',
    `notes` STRING COMMENT 'Free‑form remarks or operational notes about the service center.',
    `opening_date` DATE COMMENT 'Date when the service center began operations.',
    `operating_hours` STRING COMMENT 'Standard weekly operating hours (e.g., Mon‑Fri 08:00‑17:00).',
    `phone_number` STRING COMMENT 'Primary contact telephone number for the service center.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the service center address.',
    `region` STRING COMMENT 'Broad geographic region where the center operates.',
    `rma_processing_enabled` BOOLEAN COMMENT 'Flag indicating if Return‑Material Authorization processing is supported.',
    `service_capacity` STRING COMMENT 'Number of service bays or workstations available at the center.',
    `service_level_agreement` STRING COMMENT 'Code referencing the SLA governing response and resolution times.',
    `state_province` STRING COMMENT 'State or province of the service center location.',
    `service_center_status` STRING COMMENT 'Current lifecycle status of the service center.',
    `supported_equipment` STRING COMMENT 'Comma‑separated list of equipment categories the center can service.',
    `time_zone` STRING COMMENT 'IANA time‑zone identifier for the center (e.g., America/New_York).',
    `total_rma_cases_last_year` DECIMAL(18,2) COMMENT 'Number of Return‑Material Authorization cases processed last year.',
    `total_service_requests_last_year` DECIMAL(18,2) COMMENT 'Count of all service requests handled in the previous calendar year.',
    `total_warranty_cases_last_year` DECIMAL(18,2) COMMENT 'Number of warranty‑covered service cases processed last year.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the service center record.',
    `warranty_service_available` BOOLEAN COMMENT 'Indicates whether the center provides warranty‑covered service.',
    CONSTRAINT pk_service_center PRIMARY KEY(`service_center_id`)
) COMMENT 'Master reference table for service_center. Referenced by service_center_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` (
    `holiday_calendar_id` BIGINT COMMENT 'Primary key for holiday_calendar',
    `base_holiday_calendar_id` BIGINT COMMENT 'Self-referencing FK on holiday_calendar (base_holiday_calendar_id)',
    `service_center_id` BIGINT COMMENT '',
    `calendar_code` STRING COMMENT '',
    `calendar_name` STRING COMMENT '',
    `calendar_year` STRING COMMENT 'Four‑digit year component of the holiday_date, stored for partitioning and reporting efficiency.',
    `country` STRING COMMENT '',
    `country_code` STRING COMMENT 'Three‑letter ISO country code indicating the nation where the holiday is observed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the holiday record was first created in the system.',
    `holiday_calendar_description` STRING COMMENT 'Free‑form text providing additional details about the holiday.',
    `effective_from` DATE COMMENT 'Date from which the holiday entry becomes valid (useful for future‑planned holidays).',
    `effective_until` DATE COMMENT 'Date after which the holiday entry is no longer valid (for temporary or retired holidays).',
    `holiday_category` STRING COMMENT 'Broad category describing the origin or purpose of the holiday.',
    `holiday_date` DATE COMMENT 'Calendar date on which the holiday occurs.',
    `holiday_name` STRING COMMENT 'Official name or title of the holiday (e.g., "Independence Day").',
    `holiday_type` STRING COMMENT 'Classification of the holiday indicating its nature (public, bank, observed, company‑specific, or regional).',
    `is_company_holiday` BOOLEAN COMMENT 'True if the holiday is specific to the manufacturing company (e.g., plant shutdown).',
    `is_national_holiday` BOOLEAN COMMENT 'True if the holiday is recognized at the national level.',
    `is_observed` BOOLEAN COMMENT 'Indicates whether the holiday is officially observed (true) or not (false).',
    `is_working_day_flag` BOOLEAN COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT 'Optional free‑form notes or comments about the holiday.',
    `region` STRING COMMENT 'Broad geographic region to which the holiday applies.',
    `holiday_calendar_status` STRING COMMENT 'Current lifecycle status of the holiday record.',
    `updated_by` STRING COMMENT 'Identifier of the user or process that last updated the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the holiday record.',
    `created_by` STRING COMMENT 'Identifier of the user or process that created the record.',
    CONSTRAINT pk_holiday_calendar PRIMARY KEY(`holiday_calendar_id`)
) COMMENT 'Master reference table for holiday_calendar. Referenced by holiday_calendar_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_installed_base_id` FOREIGN KEY (`installed_base_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`installed_base`(`installed_base_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`service_contract`(`service_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ADD CONSTRAINT `fk_service_service_warranty_installed_base_id` FOREIGN KEY (`installed_base_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`installed_base`(`installed_base_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ADD CONSTRAINT `fk_service_service_rma_request_id` FOREIGN KEY (`request_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`request`(`request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ADD CONSTRAINT `fk_service_service_rma_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`service_contract`(`service_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ADD CONSTRAINT `fk_service_service_rma_service_warranty_id` FOREIGN KEY (`service_warranty_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`service_warranty`(`service_warranty_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_engineer_id` FOREIGN KEY (`engineer_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`engineer`(`engineer_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_field_service_engineer_id` FOREIGN KEY (`field_service_engineer_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`engineer`(`engineer_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_installed_base_id` FOREIGN KEY (`installed_base_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`installed_base`(`installed_base_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_request_id` FOREIGN KEY (`request_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`request`(`request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ADD CONSTRAINT `fk_service_installed_base_service_warranty_id` FOREIGN KEY (`service_warranty_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`service_warranty`(`service_warranty_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ADD CONSTRAINT `fk_service_service_entitlement_installed_base_id` FOREIGN KEY (`installed_base_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`installed_base`(`installed_base_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ADD CONSTRAINT `fk_service_service_entitlement_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`service_contract`(`service_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ADD CONSTRAINT `fk_service_sla_milestone_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`service_contract`(`service_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ADD CONSTRAINT `fk_service_sla_milestone_request_id` FOREIGN KEY (`request_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`request`(`request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ADD CONSTRAINT `fk_service_sla_milestone_sla_service_request_id` FOREIGN KEY (`sla_service_request_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`request`(`request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ADD CONSTRAINT `fk_service_engineer_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`zone`(`zone_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ADD CONSTRAINT `fk_service_zone_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ADD CONSTRAINT `fk_service_zone_service_center_id` FOREIGN KEY (`service_center_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`service_center`(`service_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ADD CONSTRAINT `fk_service_service_capa_record_request_id` FOREIGN KEY (`request_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`request`(`request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ADD CONSTRAINT `fk_service_service_capa_record_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`request`(`request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ADD CONSTRAINT `fk_service_satisfaction_survey_engineer_id` FOREIGN KEY (`engineer_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`engineer`(`engineer_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ADD CONSTRAINT `fk_service_satisfaction_survey_request_id` FOREIGN KEY (`request_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`request`(`request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ADD CONSTRAINT `fk_service_satisfaction_survey_satisfaction_service_request_id` FOREIGN KEY (`satisfaction_service_request_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`request`(`request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ADD CONSTRAINT `fk_service_knowledge_article_engineer_id` FOREIGN KEY (`engineer_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`engineer`(`engineer_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ADD CONSTRAINT `fk_service_bulletin_engineer_id` FOREIGN KEY (`engineer_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`engineer`(`engineer_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ADD CONSTRAINT `fk_service_service_pm_schedule_installed_base_id` FOREIGN KEY (`installed_base_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`installed_base`(`installed_base_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ADD CONSTRAINT `fk_service_service_pm_schedule_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`service_contract`(`service_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ADD CONSTRAINT `fk_service_service_pm_schedule_task_checklist_id` FOREIGN KEY (`task_checklist_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`task_checklist`(`task_checklist_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ADD CONSTRAINT `fk_service_service_contract_line_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`service_contract`(`service_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ADD CONSTRAINT `fk_service_remote_diagnostic_session_engineer_id` FOREIGN KEY (`engineer_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`engineer`(`engineer_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ADD CONSTRAINT `fk_service_remote_diagnostic_session_installed_base_id` FOREIGN KEY (`installed_base_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`installed_base`(`installed_base_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ADD CONSTRAINT `fk_service_remote_diagnostic_session_request_id` FOREIGN KEY (`request_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`request`(`request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ADD CONSTRAINT `fk_service_part_consumption_field_service_order_id` FOREIGN KEY (`field_service_order_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`field_service_order`(`field_service_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ADD CONSTRAINT `fk_service_part_consumption_request_id` FOREIGN KEY (`request_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`request`(`request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`contract_line` ADD CONSTRAINT `fk_service_contract_line_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`service_contract`(`service_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer_assignment` ADD CONSTRAINT `fk_service_engineer_assignment_field_service_order_id` FOREIGN KEY (`field_service_order_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`field_service_order`(`field_service_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer_assignment` ADD CONSTRAINT `fk_service_engineer_assignment_engineer_id` FOREIGN KEY (`engineer_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`engineer`(`engineer_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer_assignment` ADD CONSTRAINT `fk_service_engineer_assignment_request_id` FOREIGN KEY (`request_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`request`(`request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` ADD CONSTRAINT `fk_service_task_checklist_field_service_order_id` FOREIGN KEY (`field_service_order_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`field_service_order`(`field_service_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` ADD CONSTRAINT `fk_service_task_checklist_parent_task_checklist_id` FOREIGN KEY (`parent_task_checklist_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`task_checklist`(`task_checklist_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` ADD CONSTRAINT `fk_service_task_checklist_service_pm_schedule_id` FOREIGN KEY (`service_pm_schedule_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`service_pm_schedule`(`service_pm_schedule_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ADD CONSTRAINT `fk_service_service_center_parent_service_center_id` FOREIGN KEY (`parent_service_center_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`service_center`(`service_center_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` ADD CONSTRAINT `fk_service_holiday_calendar_base_holiday_calendar_id` FOREIGN KEY (`base_holiday_calendar_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` ADD CONSTRAINT `fk_service_holiday_calendar_service_center_id` FOREIGN KEY (`service_center_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`service_center`(`service_center_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`service` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_manufacturing_v1`.`service` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` SET TAGS ('dbx_subdomain' = 'request_management');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Request Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `ecn_id` SET TAGS ('dbx_business_glossary_term' = 'Ecn Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Technician ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `engineering_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `installed_base_id` SET TAGS ('dbx_business_glossary_term' = 'Installed Base Id');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Request Asset Equipment Register Id');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Intake Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `service_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Contract ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Service Cost');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Request Channel');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'phone|email|portal|field|chat');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Closed Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Email');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `contact_email` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Phone');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `contact_phone` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CNY|JPY');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Request Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Service Cost');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `parts_cost` SET TAGS ('dbx_business_glossary_term' = 'Parts Cost');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `parts_used` SET TAGS ('dbx_business_glossary_term' = 'Parts Used');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Request Priority');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Service Request Number');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `request_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_customer|resolved|closed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Service Request Type');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'technical_support|field_service|warranty_claim|rma|complaint');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `resolution_deadline` SET TAGS ('dbx_business_glossary_term' = 'Resolution Deadline');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `service_category` SET TAGS ('dbx_value_regex' = 'preventive|corrective|installation|upgrade');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `site_country` SET TAGS ('dbx_business_glossary_term' = 'Site Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `site_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `sla_actual_hours` SET TAGS ('dbx_business_glossary_term' = 'SLA Actual Hours');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Hours');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'SLA Tier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'standard|gold|platinum');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `symptom_description` SET TAGS ('dbx_business_glossary_term' = 'Symptom Description');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `travel_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Travel Distance (KM)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `travel_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Travel Time (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `warranty_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Coverage Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` SET TAGS ('dbx_subdomain' = 'contract_coverage');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `service_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Contract ID (SCID)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `control_system_id` SET TAGS ('dbx_business_glossary_term' = 'Control System Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count (AC)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Renewal Flag (ARF)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `billing_cycle_day` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Day (BCD)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency (BF)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `contract_category` SET TAGS ('dbx_business_glossary_term' = 'Contract Category (CC)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `contract_category` SET TAGS ('dbx_value_regex' = 'warranty|service|maintenance|support');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `contract_description` SET TAGS ('dbx_business_glossary_term' = 'Contract Description (CD)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number (CN)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type (CT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'preventive_maintenance|full_service|time_and_material|extended_warranty');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `contract_value` SET TAGS ('dbx_business_glossary_term' = 'Contract Value (CV)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `coverage_scope` SET TAGS ('dbx_business_glossary_term' = 'Coverage Scope (CS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CCY)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY|CAD');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `discount_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate (Percent) (DR)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EED)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (ESD)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Name (ECN)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Phone (ECP)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date (LAD)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Contract Manager Email (CME)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `manager_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `net_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Net Contract Value (NCV)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes (CN)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status (RAS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Flag (RF)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term (Months) (RTM)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `resolution_time_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Resolution Time Target (Hours) (RTT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `response_time_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Time Target (Hours) (RTT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `service_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status (CS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `service_contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|pending_approval');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `service_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Tier (ST)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `service_tier` SET TAGS ('dbx_value_regex' = 'gold|silver|bronze');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Contract Status Reason (CSR)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate (Percent) (TR)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (TD)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason (TR)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `uptime_guarantee_percent` SET TAGS ('dbx_business_glossary_term' = 'Uptime Guarantee (Percent) (UG)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `warranty_end_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty End Date (WED)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `warranty_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Included Flag (WIF)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date (WSD)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` SET TAGS ('dbx_subdomain' = 'contract_coverage');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` SET TAGS ('dbx_ssot' = 'reference');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` SET TAGS ('dbx_ssot_group' = 'warranty');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` SET TAGS ('dbx_ssot_master' = 'asset.asset_warranty');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` SET TAGS ('dbx_ssot_of' = 'asset.asset_warranty');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` SET TAGS ('dbx_ssot_canonical' = 'asset.asset_warranty');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` SET TAGS ('dbx_ssot_role' = 'source_of_truth');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `service_warranty_id` SET TAGS ('dbx_business_glossary_term' = 'Service Warranty Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CID)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (SOID)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (PID)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `asset_warranty_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `claims_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Claims Allowed Flag (CAF)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `claims_remaining` SET TAGS ('dbx_business_glossary_term' = 'Remaining Claims (RC)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Amount (CA)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `coverage_scope` SET TAGS ('dbx_business_glossary_term' = 'Coverage Scope (CS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `coverage_scope` SET TAGS ('dbx_value_regex' = 'product|system|site');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `coverage_terms` SET TAGS ('dbx_business_glossary_term' = 'Coverage Terms (CT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY|CAD');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Warranty Document URL (WDU)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFD)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EUD)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `exclusions` SET TAGS ('dbx_business_glossary_term' = 'Exclusions (EX)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `extended_until` SET TAGS ('dbx_business_glossary_term' = 'Extended Until Date (EUD)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|pending|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Warranty Notes (WN)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `product_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Product Serial Number (PSN)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (RCT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (RUT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Registration Date (WRD)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status (RS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Flag (RF)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms (RT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level (SL)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'basic|premium|gold');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `transferability_flag` SET TAGS ('dbx_business_glossary_term' = 'Transferability Flag (TF)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `warranty_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Number (WN)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `warranty_type` SET TAGS ('dbx_business_glossary_term' = 'Warranty Type (WT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_warranty` ALTER COLUMN `warranty_type` SET TAGS ('dbx_value_regex' = 'standard|extended|parts_only|labor_included');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` SET TAGS ('dbx_subdomain' = 'request_management');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `service_rma_id` SET TAGS ('dbx_business_glossary_term' = 'RMA Primary Key');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `inbound_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Delivery Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processed By Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `service_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `service_warranty_id` SET TAGS ('dbx_business_glossary_term' = 'Warranty Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `carrier_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `carrier_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `credit_note_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Number');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'repair|replace|credit|scrap|return_to_vendor');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `fault_description` SET TAGS ('dbx_business_glossary_term' = 'Fault Description');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'pass|fail|partial');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical RMA Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `is_under_warranty` SET TAGS ('dbx_business_glossary_term' = 'Under Warranty Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'General Notes');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Returned Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'RMA Received Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `refund_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `refund_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `regulatory_report_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `repair_cost` SET TAGS ('dbx_business_glossary_term' = 'Repair Cost Amount');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `repair_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `repair_cost` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `replacement_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Replacement Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'RMA Request Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_value_regex' = 'defective|damaged|wrong_item|no_longer_needed|other');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `return_shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Return Shipment Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `return_shipment_method` SET TAGS ('dbx_business_glossary_term' = 'Return Shipment Method');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `return_shipment_method` SET TAGS ('dbx_value_regex' = 'ground|air|courier|pickup');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `rma_number` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Number');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `rma_number` SET TAGS ('dbx_value_regex' = '^RMA-d{6}$');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number of Returned Unit');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `serial_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `serial_number` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `service_rma_status` SET TAGS ('dbx_business_glossary_term' = 'RMA Status');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `service_rma_status` SET TAGS ('dbx_value_regex' = 'requested|approved|repaired|replaced|credited|closed');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `shipment_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|box|kg|unit');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_rma` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `field_service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Field Service Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `control_system_id` SET TAGS ('dbx_business_glossary_term' = 'Control System Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `field_service_engineer_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp (AET)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp (AST)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status (CS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'completed|partial|failed');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY|CAD');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `customer_signature_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Signature Status (CSS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `customer_signature_status` SET TAGS ('dbx_value_regex' = 'pending|signed|exempt');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost (LC)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours (HRS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (°)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Work Order Lifecycle Status (WOLS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|in_progress|completed|cancelled|closed');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (°)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number (WON)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type (WOT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'installation|maintenance|repair|commissioning|inspection');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `outcome_code` SET TAGS ('dbx_business_glossary_term' = 'Outcome Code (OC)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `outcome_code` SET TAGS ('dbx_value_regex' = 'success|partial_success|failure');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `parts_cost` SET TAGS ('dbx_business_glossary_term' = 'Parts Cost (PC)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority Level (PL)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (RUT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp (RT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code (RCC)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_value_regex' = 'equipment_failure|human_error|material_shortage|other');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `scheduled_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp (SET)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp (SST)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category (SC)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `service_category` SET TAGS ('dbx_value_regex' = 'preventive|corrective|emergency');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `service_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Number (SCN)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `service_level_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement Code (SLAC)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `site_address` SET TAGS ('dbx_business_glossary_term' = 'Site Address (SA)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `site_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `site_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `site_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `site_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TA)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `total_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Amount (TDA)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `total_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Amount (TGA)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `total_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Net Amount (TNA)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `travel_cost` SET TAGS ('dbx_business_glossary_term' = 'Travel Cost (TC)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `travel_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Travel Distance (KM)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `travel_hours` SET TAGS ('dbx_business_glossary_term' = 'Travel Hours (HRS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `warranty_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Covered Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `work_description` SET TAGS ('dbx_business_glossary_term' = 'Work Description');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` SET TAGS ('dbx_subdomain' = 'asset_entitlement');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `installed_base_id` SET TAGS ('dbx_business_glossary_term' = 'Installed Base Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Installed By Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Node Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `service_warranty_id` SET TAGS ('dbx_business_glossary_term' = 'Service Warranty Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Capacity (kW) (CAP_KW)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CITY)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3) (COUNTRY_CD)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `current` SET TAGS ('dbx_business_glossary_term' = 'Current (A) (CURRENT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version (FWV)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date (INST_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `installation_method` SET TAGS ('dbx_business_glossary_term' = 'Installation Method (INST_METHOD)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `installation_method` SET TAGS ('dbx_value_regex' = 'new|retrofit|upgrade');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `last_service_date` SET TAGS ('dbx_business_glossary_term' = 'Last Service Date (LAST_SVC_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `maintenance_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Frequency (Days) (MT_FREQ_DAYS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Type (MT_TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `maintenance_type` SET TAGS ('dbx_value_regex' = 'preventive|corrective|predictive');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `mean_time_between_failures_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (Hours) (MTBF_HRS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `mean_time_to_repair_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (Hours) (MTTR_HRS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number (MN)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date (NEXT_MAINT_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status (OP_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `overall_equipment_effectiveness` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) (OEE_PCT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `power_rating_kw` SET TAGS ('dbx_business_glossary_term' = 'Power Rating (kW) (POWER_RATING_KW)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category (PC)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `product_category` SET TAGS ('dbx_value_regex' = 'automation|electrification|infrastructure');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name (PN)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `product_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `product_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number (SN)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `site_address` SET TAGS ('dbx_business_glossary_term' = 'Site Address (SITE_ADDR)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `site_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `site_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `site_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `site_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `site_location` SET TAGS ('dbx_business_glossary_term' = 'Site Location Code (SITE_LOC)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version (SWV)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province (STATE)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `voltage` SET TAGS ('dbx_business_glossary_term' = 'Voltage (V) (VOLTAGE)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` SET TAGS ('dbx_subdomain' = 'asset_entitlement');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `service_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Entitlement Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `installed_base_id` SET TAGS ('dbx_business_glossary_term' = 'Installed Base Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `service_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `acknowledgment_actual_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Actual Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `acknowledgment_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Breach Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `acknowledgment_breach_reason` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Breach Reason');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `acknowledgment_elapsed_minutes` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Elapsed Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `acknowledgment_target_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Target Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `business_hours_coverage` SET TAGS ('dbx_business_glossary_term' = 'Business Hours Coverage Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `coverage_level` SET TAGS ('dbx_business_glossary_term' = 'Coverage Level');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `coverage_level` SET TAGS ('dbx_value_regex' = 'standard|premium|enterprise');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `service_entitlement_description` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Description');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `entitlement_code` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Code');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `entitlement_name` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Name');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `entitlement_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `entitlement_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `entitlement_type` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Type');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `entitlement_type` SET TAGS ('dbx_value_regex' = 'warranty|contract|complimentary|service_plan');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `first_response_actual_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Response Actual Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `first_response_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'First Response Breach Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `first_response_breach_reason` SET TAGS ('dbx_business_glossary_term' = 'First Response Breach Reason');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `first_response_elapsed_minutes` SET TAGS ('dbx_business_glossary_term' = 'First Response Elapsed Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `first_response_target_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Response Target Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Notes');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `resolution_actual_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Actual Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `resolution_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Resolution Breach Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `resolution_breach_reason` SET TAGS ('dbx_business_glossary_term' = 'Resolution Breach Reason');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `resolution_elapsed_minutes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Elapsed Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `resolution_target_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Target Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `service_channel` SET TAGS ('dbx_business_glossary_term' = 'Service Channel');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `service_channel` SET TAGS ('dbx_value_regex' = 'phone|email|on_site|remote');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `service_entitlement_status` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Status');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `service_entitlement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `sla_resolution_time_target` SET TAGS ('dbx_business_glossary_term' = 'SLA Resolution Time Target (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `sla_response_time_target` SET TAGS ('dbx_business_glossary_term' = 'SLA Response Time Target (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_entitlement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` SET TAGS ('dbx_subdomain' = 'request_management');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ALTER COLUMN `sla_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'SLA Milestone Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ALTER COLUMN `control_system_id` SET TAGS ('dbx_business_glossary_term' = 'Control System Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ALTER COLUMN `service_contract_id` SET TAGS ('dbx_business_glossary_term' = 'SLA Contract Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ALTER COLUMN `sla_service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ALTER COLUMN `actual_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SLA Actual Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ALTER COLUMN `assigned_team` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ALTER COLUMN `breach_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ALTER COLUMN `breach_reason` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Reason');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ALTER COLUMN `elapsed_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Elapsed Time (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ALTER COLUMN `entitlement_tier` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Tier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ALTER COLUMN `entitlement_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|enterprise');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ALTER COLUMN `escalated_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'SLA Milestone Name');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_value_regex' = 'first_response|acknowledgment|resolution|closure');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Milestone Notes');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Milestone Priority');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ALTER COLUMN `resolution_code` SET TAGS ('dbx_business_glossary_term' = 'Resolution Code');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ALTER COLUMN `sla_milestone_status` SET TAGS ('dbx_business_glossary_term' = 'SLA Milestone Status');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ALTER COLUMN `sla_milestone_status` SET TAGS ('dbx_value_regex' = 'pending|met|breached|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ALTER COLUMN `target_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`sla_milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `engineer_id` SET TAGS ('dbx_business_glossary_term' = 'Engineer Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `active_assignment_count` SET TAGS ('dbx_business_glossary_term' = 'Active Assignment Count (ASSIGN_COUNT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (ADDR1)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (ADDR2)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `certification_drive_expiry` SET TAGS ('dbx_business_glossary_term' = 'Drive Systems Certification Expiry Date (DRIVE_EXP)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `certification_electrification_expiry` SET TAGS ('dbx_business_glossary_term' = 'Electrification Certification Expiry Date (ELEC_EXP)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `certification_hmi_expiry` SET TAGS ('dbx_business_glossary_term' = 'HMI Certification Expiry Date (HMI_EXP)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `certification_plc_expiry` SET TAGS ('dbx_business_glossary_term' = 'PLC Certification Expiry Date (PLC_EXP)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `certification_robotics_expiry` SET TAGS ('dbx_business_glossary_term' = 'Robotics Certification Expiry Date (ROBO_EXP)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `certification_scada_expiry` SET TAGS ('dbx_business_glossary_term' = 'SCADA Certification Expiry Date (SCADA_EXP)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CITY)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `classification_or_type` SET TAGS ('dbx_business_glossary_term' = 'Engineer Classification (CLASS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `classification_or_type` SET TAGS ('dbx_value_regex' = 'internal|contractor|vendor');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `dispatch_zone` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Zone (ZONE)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `email` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Engineer Email Address (EMAIL)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `email_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type (EMP_TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|temp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Engineer Full Name (FULL_NAME)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `full_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `full_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date (HIRE_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `labor_classification` SET TAGS ('dbx_business_glossary_term' = 'Labor Classification (LAB_CLASS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `labor_classification` SET TAGS ('dbx_value_regex' = 'skilled|unskilled|technician|engineer');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `labor_rate_hourly` SET TAGS ('dbx_business_glossary_term' = 'Hourly Labor Rate (HOURLY_RATE)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `last_dispatch_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Dispatch Timestamp (LAST_DISPATCH)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|retired|terminated');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `max_travel_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Maximum Travel Distance (MAX_TRAVEL_KM)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `engineer_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `engineer_name` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `next_available_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Available Timestamp (NEXT_AVAIL)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligibility Flag (OT_ELIG)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating (PERF_RATING)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `phone` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Engineer Phone Number (PHONE)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (ZIP)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method (CONTACT_METHOD)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|sms');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language (LANG_PRIMARY)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `product_family_competency` SET TAGS ('dbx_business_glossary_term' = 'Product Family Competency (PF_COMP)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `secondary_languages` SET TAGS ('dbx_business_glossary_term' = 'Secondary Languages (LANG_SECONDARY)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level (SEC_CLEAR)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_value_regex' = 'none|confidential|secret|top_secret');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `service_region` SET TAGS ('dbx_business_glossary_term' = 'Service Region (REGION)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `service_region` SET TAGS ('dbx_value_regex' = 'NA|EU|APAC|LATAM|MEA');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `shift_preference` SET TAGS ('dbx_business_glossary_term' = 'Shift Preference (SHIFT_PREF)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `shift_preference` SET TAGS ('dbx_value_regex' = 'day|night|flex');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `skill_drive_systems_certified` SET TAGS ('dbx_business_glossary_term' = 'Drive Systems Certification Flag (DRIVE_CERT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `skill_electrification_certified` SET TAGS ('dbx_business_glossary_term' = 'Electrification Certification Flag (ELEC_CERT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `skill_hmi_certified` SET TAGS ('dbx_business_glossary_term' = 'HMI Certification Flag (HMI_CERT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `skill_plc_certified` SET TAGS ('dbx_business_glossary_term' = 'PLC Certification Flag (PLC_CERT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `skill_robotics_certified` SET TAGS ('dbx_business_glossary_term' = 'Robotics Certification Flag (ROBO_CERT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `skill_scada_certified` SET TAGS ('dbx_business_glossary_term' = 'SCADA Certification Flag (SCADA_CERT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State/Province (STATE)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (TERM_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `travel_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Travel Eligibility (TRAVEL_ELIG)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `union_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Flag (UNION_FLAG)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Experience (EXP_YRS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Service Zone Identifier (SZ_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Manager Identifier (TM_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Identifier (HOL_CAL_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `service_center_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Service Center Identifier (SC_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `city_list` SET TAGS ('dbx_business_glossary_term' = 'Serviced Cities List (CITY_LIST)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Service Zone Code (SZC)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country ISO Alpha‑3 Code (ISO3)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `coverage_area_sqkm` SET TAGS ('dbx_business_glossary_term' = 'Coverage Area (sq km) (COV_AREA)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `zone_description` SET TAGS ('dbx_business_glossary_term' = 'Service Zone Description (SZ_DESC)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFF_FROM)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFF_UNTIL)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `is_holiday_observed` SET TAGS ('dbx_business_glossary_term' = 'Holiday Observation Flag (HOL_OBS_FLAG)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `latitude_center` SET TAGS ('dbx_business_glossary_term' = 'Central Latitude Coordinate (LAT_CENT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `latitude_center` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `latitude_center` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `longitude_center` SET TAGS ('dbx_business_glossary_term' = 'Central Longitude Coordinate (LON_CENT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `longitude_center` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `longitude_center` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `max_travel_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Maximum Travel Time (minutes) (MAX_TRAVEL_MIN)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `zone_name` SET TAGS ('dbx_business_glossary_term' = 'Service Zone Name (SZN)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `zone_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours (OP_HRS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `operating_hours` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):[0-5]d-([01]d|2[0-3]):[0-5]d$');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `postal_code_range` SET TAGS ('dbx_business_glossary_term' = 'Postal Code Range (PC_RANGE)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `postal_code_range` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `postal_code_range` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Territory Priority Rank (PRIORITY_RANK)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region (REG)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `sla_coverage_level` SET TAGS ('dbx_business_glossary_term' = 'SLA Coverage Level (SLA_LEVEL)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `sla_coverage_level` SET TAGS ('dbx_value_regex' = 'gold|silver|bronze|standard');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province (ST_PROV)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `supported_product_family` SET TAGS ('dbx_business_glossary_term' = 'Supported Product Family (PROD_FAM)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `supported_product_family` SET TAGS ('dbx_value_regex' = 'automation|electrification|smart_infrastructure|control_systems|sensors|software');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone Identifier (TZ_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (REC_UPDATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `zone_status` SET TAGS ('dbx_business_glossary_term' = 'Service Zone Status (SZ_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`zone` ALTER COLUMN `zone_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|retired');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` SET TAGS ('dbx_subdomain' = 'quality_improvement');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `service_capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'CAPA Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `asset_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Work Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `compliance_capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Capa Record Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `design_review_id` SET TAGS ('dbx_business_glossary_term' = 'Design Review Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Related Service Case ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `tertiary_service_corrective_action_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Owner ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `tertiary_service_corrective_action_owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `tertiary_service_corrective_action_owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `affected_units_quantity` SET TAGS ('dbx_business_glossary_term' = 'Affected Units Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `capa_number` SET TAGS ('dbx_business_glossary_term' = 'CAPA Number (CAPA No.)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `cost_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `is_closed` SET TAGS ('dbx_business_glossary_term' = 'Is Closed Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `issue_description` SET TAGS ('dbx_business_glossary_term' = 'Issue Description');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'CAPA Notes');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `owner_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `owner_name` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `preventive_action_description` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Description');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'CAPA Priority');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `product_model` SET TAGS ('dbx_business_glossary_term' = 'Product Model');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'CAPA Risk Level');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `root_cause_analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `root_cause_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Sub‑Category');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number (SN)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `serial_number` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `service_capa_record_status` SET TAGS ('dbx_business_glossary_term' = 'CAPA Status');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `service_capa_record_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'CAPA Severity');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'minor|major|critical');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'CAPA Source');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'field_failure|service_case|recurring_defect|audit');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'test|inspection|audit|review');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `verification_result` SET TAGS ('dbx_business_glossary_term' = 'Verification Result');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_capa_record` ALTER COLUMN `verification_result` SET TAGS ('dbx_value_regex' = 'passed|failed|partial');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` SET TAGS ('dbx_subdomain' = 'quality_improvement');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ALTER COLUMN `satisfaction_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction Survey Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ALTER COLUMN `engineer_id` SET TAGS ('dbx_business_glossary_term' = 'Service Engineer ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ALTER COLUMN `satisfaction_service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ALTER COLUMN `communication_rating` SET TAGS ('dbx_business_glossary_term' = 'Communication Rating');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ALTER COLUMN `engineer_competence_rating` SET TAGS ('dbx_business_glossary_term' = 'Engineer Competence Rating');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ALTER COLUMN `issue_resolution_rating` SET TAGS ('dbx_business_glossary_term' = 'Issue Resolution Rating');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Survey Language');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Survey Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'pending|completed|cancelled|expired');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Satisfaction Score');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ALTER COLUMN `respondent_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ALTER COLUMN `respondent_email` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ALTER COLUMN `response_time_rating` SET TAGS ('dbx_business_glossary_term' = 'Response Time Rating');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Survey Response Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ALTER COLUMN `survey_channel` SET TAGS ('dbx_business_glossary_term' = 'Survey Channel');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ALTER COLUMN `survey_channel` SET TAGS ('dbx_value_regex' = 'email|phone|web|in_app|paper');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ALTER COLUMN `survey_number` SET TAGS ('dbx_business_glossary_term' = 'Survey Number');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type (Customer Satisfaction Survey Type)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'CSAT|NPS');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ALTER COLUMN `survey_version` SET TAGS ('dbx_business_glossary_term' = 'Survey Version');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`satisfaction_survey` ALTER COLUMN `verbatim_feedback` SET TAGS ('dbx_business_glossary_term' = 'Verbatim Feedback');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` SET TAGS ('dbx_subdomain' = 'technical_support');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `knowledge_article_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Article ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `engineer_id` SET TAGS ('dbx_business_glossary_term' = 'Author Engineer Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `applicable_models` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Models');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `article_type` SET TAGS ('dbx_business_glossary_term' = 'Article Type');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `article_type` SET TAGS ('dbx_value_regex' = 'troubleshooting|bulletin|safety_recall|mandatory_retrofit|advisory|firmware_patch');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `attachment_url` SET TAGS ('dbx_business_glossary_term' = 'Attachment URL');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `author_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `author_name` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `is_faq` SET TAGS ('dbx_business_glossary_term' = 'FAQ Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Article Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `knowledge_article_status` SET TAGS ('dbx_business_glossary_term' = 'Article Status');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `knowledge_article_status` SET TAGS ('dbx_value_regex' = 'draft|published|archived|retired');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Article Language');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = 'en|es|de|fr|zh|ja');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `parts_required` SET TAGS ('dbx_business_glossary_term' = 'Parts Required');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `related_article_ids` SET TAGS ('dbx_business_glossary_term' = 'Related Article IDs');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `required_action` SET TAGS ('dbx_business_glossary_term' = 'Required Action');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `resolution_procedure` SET TAGS ('dbx_business_glossary_term' = 'Resolution Procedure');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'annual|semiannual|quarterly|monthly');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `revision_history` SET TAGS ('dbx_business_glossary_term' = 'Revision History');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `serial_number_range` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Range');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `summary` SET TAGS ('dbx_business_glossary_term' = 'Article Summary');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `symptom_keywords` SET TAGS ('dbx_business_glossary_term' = 'Symptom Keywords');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Article Tags');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Article Title');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Article Usage Count');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`knowledge_article` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` SET TAGS ('dbx_subdomain' = 'technical_support');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `bulletin_id` SET TAGS ('dbx_business_glossary_term' = 'Bulletin Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `engineer_id` SET TAGS ('dbx_business_glossary_term' = 'Author Engineer Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `action_required` SET TAGS ('dbx_business_glossary_term' = 'Action Required (AR)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `affected_product_models` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Models (APM)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `bulletin_number` SET TAGS ('dbx_business_glossary_term' = 'Bulletin Number (BN)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `bulletin_status` SET TAGS ('dbx_business_glossary_term' = 'Bulletin Status (BS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `bulletin_status` SET TAGS ('dbx_value_regex' = 'draft|issued|active|closed|withdrawn');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `bulletin_type` SET TAGS ('dbx_business_glossary_term' = 'Bulletin Type (BT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `bulletin_type` SET TAGS ('dbx_value_regex' = 'safety_recall|mandatory_retrofit|advisory_update|firmware_patch');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline (CD)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CNY|CAD');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel (DC)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = 'email|portal|field_technician|partner|api');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (ED)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `engineering_department` SET TAGS ('dbx_business_glossary_term' = 'Engineering Department (ED)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost (EC)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours (ELH)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXP)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version (FV)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `labor_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Per Hour (LRPH)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag (MF)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `parts_required` SET TAGS ('dbx_business_glossary_term' = 'Parts Required (PR)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference (RR)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number (RN)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `safety_notice_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Notice Flag (SNF)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `serial_number_range_end` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Range End (SNRE)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `serial_number_range_start` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Range Start (SNRS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level (SL)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `software_patch_version` SET TAGS ('dbx_business_glossary_term' = 'Software Patch Version (SPV)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market (TM)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `target_market` SET TAGS ('dbx_value_regex' = 'NA|EU|APAC|LATAM|MEA');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Bulletin Title (BT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`bulletin` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version (VER)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` SET TAGS ('dbx_subdomain' = 'asset_entitlement');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` SET TAGS ('dbx_ssot' = 'reference');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` SET TAGS ('dbx_ssot_group' = 'pm_schedule');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` SET TAGS ('dbx_ssot_master' = 'asset.asset_pm_schedule');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` SET TAGS ('dbx_ssot_of' = 'asset.asset_pm_schedule');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` SET TAGS ('dbx_ssot_canonical' = 'asset.asset_pm_schedule');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` SET TAGS ('dbx_ssot_role' = 'duplicate');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `service_pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance Schedule ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `asset_pm_schedule_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `service_asset_asset_pm_schedule_ssot_ref_id` SET TAGS ('dbx_ssot_ref' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `service_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Contract ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `task_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Task Checklist ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `classification_or_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Classification');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `classification_or_type` SET TAGS ('dbx_value_regex' = 'preventive|predictive|corrective');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|exempt');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `service_pm_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Schedule Description');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `interval_unit` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Interval Unit');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `interval_unit` SET TAGS ('dbx_value_regex' = 'days|hours|cycles|meter');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Maintenance Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `last_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Last Execution Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `maintenance_interval` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Interval');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Priority');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance Schedule Code');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance Schedule Name');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|draft');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Schedule Type');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'time_based|usage_based|condition_based');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `spare_parts_list` SET TAGS ('dbx_business_glossary_term' = 'Spare Parts List');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_pm_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` SET TAGS ('dbx_subdomain' = 'contract_coverage');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `service_contract_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Line - Service Contract Line Id');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `service_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Contract ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `contract_line_description` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Description');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `coverage_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `coverage_scope` SET TAGS ('dbx_business_glossary_term' = 'Coverage Scope');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `coverage_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type (Percentage, Fixed, None)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed|none');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `is_renewable` SET TAGS ('dbx_business_glossary_term' = 'Renewable Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status of Contract Line');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|suspended|terminated');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `metric_target_value` SET TAGS ('dbx_business_glossary_term' = 'Metric Target Value');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `metric_unit` SET TAGS ('dbx_business_glossary_term' = 'Metric Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount After Discounts and Taxes');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `price_amount` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Price');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `price_currency` SET TAGS ('dbx_business_glossary_term' = 'Price Currency (ISO 4217 Currency Code)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit (Per Year, Per Month, etc.)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity of Coverage Units');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `regulatory_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms Description');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `service_contract_line_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Status');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `service_contract_line_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|cancelled|expired');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level Description');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `service_metric` SET TAGS ('dbx_business_glossary_term' = 'Service Metric (e.g., MTTR, Uptime)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Hours (Hours)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'SLA Tier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `tax_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Included Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'unit|hour|day|month|year');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `warranty_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Inclusion Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract_line` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period in Months');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` SET TAGS ('dbx_subdomain' = 'technical_support');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `remote_diagnostic_session_id` SET TAGS ('dbx_business_glossary_term' = 'Remote Diagnostic Session ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `bandwidth_mbps` SET TAGS ('dbx_business_glossary_term' = 'Network Bandwidth (Mbps)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `connection_method` SET TAGS ('dbx_business_glossary_term' = 'Connection Method');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `connection_method` SET TAGS ('dbx_value_regex' = 'vpn|scada|iiot|hmi|remote_desktop');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `data_volume_mb` SET TAGS ('dbx_business_glossary_term' = 'Data Volume (MB)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `diagnostic_tool` SET TAGS ('dbx_business_glossary_term' = 'Diagnostic Tool');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `diagnostic_tool` SET TAGS ('dbx_value_regex' = 'plc_viewer|oscilloscope|custom_script|log_analyzer');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Remote Diagnostic Session Duration (seconds)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Remote Diagnostic Session End Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `fault_code` SET TAGS ('dbx_business_glossary_term' = 'Fault Code');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `field_dispatch_needed` SET TAGS ('dbx_business_glossary_term' = 'Field Dispatch Needed Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Network Latency (ms)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Session Notes');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `parameters_captured` SET TAGS ('dbx_business_glossary_term' = 'Captured Parameters');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `plc_program_state` SET TAGS ('dbx_business_glossary_term' = 'PLC Program State');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `remote_diagnostic_session_status` SET TAGS ('dbx_business_glossary_term' = 'Remote Diagnostic Session Status');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `remote_diagnostic_session_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `resolved_flag` SET TAGS ('dbx_business_glossary_term' = 'Issue Resolved Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `session_code` SET TAGS ('dbx_business_glossary_term' = 'Remote Diagnostic Session Code (RDSC)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `session_type` SET TAGS ('dbx_business_glossary_term' = 'Session Type');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `session_type` SET TAGS ('dbx_value_regex' = 'troubleshooting|maintenance|upgrade');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Remote Diagnostic Session Start Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`remote_diagnostic_session` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `part_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Part Consumption Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Part Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `consumption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Part Consumption Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `contract_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Coverage Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `delivery_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Tracking Number');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'pending|shipped|delivered|canceled');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Total Amount');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Part Order Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `order_urgency` SET TAGS ('dbx_business_glossary_term' = 'Order Urgency Classification');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `order_urgency` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `part_description` SET TAGS ('dbx_business_glossary_term' = 'Part Description');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number (SKU)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `quantity_consumed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Consumed');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Part Source Type');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'warehouse_stock|van_stock|supplier_direct');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `warranty_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Coverage Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`contract_line` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`contract_line` SET TAGS ('dbx_subdomain' = 'contract_coverage');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`contract_line` SET TAGS ('dbx_association_edges' = 'asset.equipment_register,service.service_contract');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`contract_line` ALTER COLUMN `contract_line_id` SET TAGS ('dbx_business_glossary_term' = 'contract_line Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`contract_line` ALTER COLUMN `service_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`contract_line` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renew Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`contract_line` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percent');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`contract_line` ALTER COLUMN `entitlement_hours` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Hours');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`contract_line` ALTER COLUMN `service_level_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`contract_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer_assignment` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer_assignment` SET TAGS ('dbx_association_edges' = 'service.engineer,automation.control_system');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer_assignment` ALTER COLUMN `engineer_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Engineer Assignment - Engineer Assignment Id');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer_assignment` ALTER COLUMN `control_system_id` SET TAGS ('dbx_business_glossary_term' = 'Engineer Assignment - Control System Id');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer_assignment` ALTER COLUMN `engineer_id` SET TAGS ('dbx_business_glossary_term' = 'Engineer Assignment - Service Engineer Id');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer_assignment` ALTER COLUMN `assignment_role` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` ALTER COLUMN `task_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Task Checklist Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` ALTER COLUMN `parent_task_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Task Checklist Id');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` ALTER COLUMN `parent_task_checklist_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` ALTER COLUMN `applicable_equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Equipment Type');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` ALTER COLUMN `checklist_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` ALTER COLUMN `task_checklist_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` ALTER COLUMN `compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Required');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` ALTER COLUMN `task_checklist_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` ALTER COLUMN `task_checklist_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` ALTER COLUMN `task_checklist_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` ALTER COLUMN `task_checklist_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` ALTER COLUMN `owner_role` SET TAGS ('dbx_business_glossary_term' = 'Owner Role');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` ALTER COLUMN `task_checklist_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` ALTER COLUMN `task_count` SET TAGS ('dbx_business_glossary_term' = 'Task Count');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` ALTER COLUMN `task_checklist_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`task_checklist` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` SET TAGS ('dbx_subdomain' = 'technical_support');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `service_center_id` SET TAGS ('dbx_business_glossary_term' = 'Service Center Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `parent_service_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Service Center Id');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `parent_service_center_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `address` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `average_resolution_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Resolution Time Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `average_response_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Response Time Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `center_code` SET TAGS ('dbx_business_glossary_term' = 'Center Code');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `center_type` SET TAGS ('dbx_business_glossary_term' = 'Center Type');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Closing Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `contact_phone` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `email_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `external_system_code` SET TAGS ('dbx_business_glossary_term' = 'External System Code');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `is_primary_center` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Center');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Manager Email');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `manager_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `manager_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Manager Phone');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `manager_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `service_center_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `service_center_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `service_center_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `rma_processing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Rma Processing Enabled');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `service_capacity` SET TAGS ('dbx_business_glossary_term' = 'Service Capacity');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `service_center_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `supported_equipment` SET TAGS ('dbx_business_glossary_term' = 'Supported Equipment');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `total_rma_cases_last_year` SET TAGS ('dbx_business_glossary_term' = 'Total Rma Cases Last Year');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `total_service_requests_last_year` SET TAGS ('dbx_business_glossary_term' = 'Total Service Requests Last Year');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `total_warranty_cases_last_year` SET TAGS ('dbx_business_glossary_term' = 'Total Warranty Cases Last Year');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_center` ALTER COLUMN `warranty_service_available` SET TAGS ('dbx_business_glossary_term' = 'Warranty Service Available');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` SET TAGS ('dbx_subdomain' = 'request_management');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` ALTER COLUMN `base_holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Base Holiday Calendar Id');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` ALTER COLUMN `base_holiday_calendar_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` ALTER COLUMN `calendar_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` ALTER COLUMN `calendar_year` SET TAGS ('dbx_business_glossary_term' = 'Calendar Year');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` ALTER COLUMN `holiday_calendar_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` ALTER COLUMN `holiday_category` SET TAGS ('dbx_business_glossary_term' = 'Holiday Category');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` ALTER COLUMN `holiday_date` SET TAGS ('dbx_business_glossary_term' = 'Holiday Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` ALTER COLUMN `holiday_name` SET TAGS ('dbx_business_glossary_term' = 'Holiday Name');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` ALTER COLUMN `holiday_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` ALTER COLUMN `holiday_type` SET TAGS ('dbx_business_glossary_term' = 'Holiday Type');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` ALTER COLUMN `is_company_holiday` SET TAGS ('dbx_business_glossary_term' = 'Is Company Holiday');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` ALTER COLUMN `is_national_holiday` SET TAGS ('dbx_business_glossary_term' = 'Is National Holiday');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` ALTER COLUMN `is_observed` SET TAGS ('dbx_business_glossary_term' = 'Is Observed');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` ALTER COLUMN `holiday_calendar_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`holiday_calendar` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
