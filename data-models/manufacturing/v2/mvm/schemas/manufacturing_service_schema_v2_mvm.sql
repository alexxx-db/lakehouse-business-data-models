-- Schema for Domain: service | Business: Manufacturing | Version: v2_mvm
-- Generated on: 2026-07-10 14:44:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`service` COMMENT 'After-sales service and field service management domain covering service request tracking, warranty management, RMA processing, service contract administration, technical support, customer service case management, and post-sale support for installed automation systems and equipment via Salesforce Service Cloud.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`request` (
    `request_id` BIGINT COMMENT 'Primary key for request',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Associates request with specific site; required for Site‑Level Service Metrics and dispatch planning.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Service request handling requires linking to the exact device (device_registry) for remote diagnostics and parts lookup, a core process in field service.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Links service request to the contacting person; needed for Request Ownership report and escalation workflow.',
    `customer_account_id` BIGINT COMMENT 'Unique identifier of the customer who owns the asset.',
    `delivery_id` BIGINT COMMENT 'Foreign key linking to order.delivery. Business justification: After‑delivery service tickets reference the delivery record to verify shipment details and delivery‑based SLA compliance.',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: Service requests generated from an Engineering Change Order need the ECO reference to coordinate field updates and compliance reporting.',
    `engineering_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_specification. Business justification: Service requests for technical defects require reference to the governing engineering specification to determine if the product is performing within design parameters. This link supports root cause an',
    `entitlement_id` BIGINT COMMENT 'Foreign key linking to service.service_entitlement. Business justification: A service request is processed under a specific service entitlement that governs SLA targets, coverage level, and response commitments. Linking request to service_entitlement enables SLA breach tracki',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.header. Business justification: Service request fulfillment often ships replacement parts; linking request to the shipment that fulfills it enables tracking and cost allocation.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Service request part usage requires identifying the material master of the part consumed; the Parts Usage report relies on this link.',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Service requests are raised for a specific line item; linking to order_line supports root‑cause analysis and warranty validation per product.',
    `equipment_register_id` BIGINT COMMENT 'FK to asset.equipment_register',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.revision. Business justification: Links service request to the specific engineering revision that introduced the issue, enabling root‑cause analysis and traceability in the Service‑Engineering handoff report.',
    `run_id` BIGINT COMMENT 'Foreign key linking to production.production_run. Business justification: Batch-level quality investigations and product recalls require linking service requests to the originating production run. Manufacturing quality teams use this to identify all affected units from a ru',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: Installation or repair requests are triggered by a sales order intake; linking supports the Service Request Fulfillment dashboard that tracks requests against originating orders.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Required for Service Request processing: linking each request to the exact product master enables warranty validation, parts lookup, and service performance reporting.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Service Parts Allocation process assigns a stock location to each service request for part pick‑up; linking request to stock_location enables the allocation report.',
    `warranty_id` BIGINT COMMENT 'Foreign key linking to service.service_warranty. Business justification: A service request may be covered under a specific warranty record. Linking request to service_warranty enables warranty validation at request intake, coverage verification, and warranty claim processi',
    `actual_cost` DECIMAL(18,2) COMMENT 'Final monetary cost incurred for the service after completion.',
    `channel` STRING COMMENT 'Originating communication channel through which the request was submitted.. Valid values are `phone|email|portal|field|chat`',
    `closed_timestamp` TIMESTAMP COMMENT 'Date‑time when the request reached a closed state.',
    `contact_email` STRING COMMENT 'Primary email address for communications related to the request.',
    `contact_phone` STRING COMMENT 'Primary phone number for the customer contact.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the request was first recorded in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for cost fields.. Valid values are `USD|EUR|GBP|CNY|JPY`',
    `due_date` DATE COMMENT 'Target date by which the request should be resolved per SLA.',
    `escalation_level` STRING COMMENT 'Numeric level indicating how many times the request has been escalated.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Projected monetary cost of the service before execution.',
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
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Service Contract Management for Projects links contracts to the project they support, enabling contract compliance reporting.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.customer_contact. Business justification: Service contracts designate a specific customer contact as escalation owner. service_contract carries denormalized escalation_contact_name and escalation_contact_phone — normalizing to customer_contac',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Required for Contract Management report linking each service contract to the owning customer account; contracts are always signed with a specific customer.',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Contract creation process uses the original sales order as the basis for the service agreement; linking enables contract‑order reporting and compliance tracking.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Contracts are defined per product family; the FK supports contract pricing, compliance, and coverage reports that aggregate by family.',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: A sales representative owns the service contract relationship; linking supports the Service Contract Ownership dashboard for account management.',
    `amendment_count` STRING COMMENT 'Number of times the contract has been amended.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates if the contract will automatically renew without manual intervention.',
    `billing_cycle_day` STRING COMMENT 'Day of month when billing occurs (1‑31).',
    `billing_frequency` STRING COMMENT 'How often the customer is invoiced for the contract.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `contract_category` STRING COMMENT 'High‑level classification of the contract for reporting and analytics.. Valid values are `warranty|service|maintenance|support`',
    `contract_description` STRING COMMENT 'Free‑text description of the contract purpose and scope.',
    `contract_number` STRING COMMENT 'External business identifier for the contract, used in customer communications and invoicing.',
    `contract_type` STRING COMMENT 'Category of service agreement defining the billing and delivery model.. Valid values are `preventive_maintenance|full_service|time_and_material|extended_warranty`',
    `contract_value` DECIMAL(18,2) COMMENT 'Total monetary value of the contract before discounts and taxes.',
    `coverage_scope` STRING COMMENT 'Geographic or functional extent of the contract coverage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the contract value.. Valid values are `USD|EUR|GBP|JPY|CNY|CAD`',
    `discount_rate_percent` DECIMAL(18,2) COMMENT 'Percentage discount applied to the base contract value.',
    `effective_end_date` DATE COMMENT 'Date when the contract expires or is scheduled to end; null for open‑ended contracts.',
    `effective_start_date` DATE COMMENT 'Date when the contract becomes binding.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent contract amendment.',
    `manager_email` STRING COMMENT 'Email address of the manager overseeing the contract.',
    `net_contract_value` DECIMAL(18,2) COMMENT 'Contract value after discount and tax adjustments.',
    `notes` STRING COMMENT 'Additional remarks or internal notes related to the contract.',
    `payment_terms` STRING COMMENT 'Standard payment condition (e.g., Net 30, Net 45).',
    `regulatory_approval_status` STRING COMMENT 'Status of required regulatory approvals for the contract.. Valid values are `approved|pending|rejected`',
    `renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract is set to auto‑renew at expiry.',
    `renewal_term_months` STRING COMMENT 'Length of the renewal period in months when auto‑renewal is enabled.',
    `resolution_time_target_hours` DECIMAL(18,2) COMMENT 'Maximum time in hours to resolve a service request.',
    `response_time_target_hours` DECIMAL(18,2) COMMENT 'Maximum time in hours to acknowledge a service request.',
    `service_contract_status` STRING COMMENT 'Current lifecycle state of the contract.. Valid values are `draft|active|suspended|terminated|pending_approval`',
    `service_tier` STRING COMMENT 'Tier of service provided under the contract.. Valid values are `gold|silver|bronze`',
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

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`warranty` (
    `warranty_id` BIGINT COMMENT 'System-generated unique identifier for the warranty record.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Warranty Tracking per Project records warranty coverage for assets installed under a specific project.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Component‑level warranty tracking requires knowing which engineered component the warranty applies to for claim processing.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer who owns the warranty.',
    `delivery_id` BIGINT COMMENT 'Foreign key linking to order.delivery. Business justification: Warranty activation from delivery: in manufacturing, warranty coverage starts from the actual delivery/goods receipt date. Linking service_warranty to the delivery that triggered warranty activation s',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: Warranty records must reference the exact device (device_registry) to validate coverage during service events, required by warranty claim processes.',
    `header_id` BIGINT COMMENT 'Identifier of the originating sales order that generated the warranty.',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to order.line. Business justification: Per-unit warranty entitlement: a warranty record covers a specific product sold on a specific order line (with serial number and quantity). Linking service_warranty to the order line enables precise w',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Customer-facing service warranties are often backed by OEM or supplier procurement contracts enabling warranty claim recovery and supplier chargeback. Manufacturing service teams must trace which proc',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: Warranty coverage in manufacturing is frequently revision-specific — warranties may apply only to components at or after a specific engineering revision. This link enables revision-based warranty vali',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: Warranty activation at order fulfillment: warranty records in manufacturing are activated upon order delivery. Linking service_warranty to order_intake enables warranty period calculation from ship da',
    `sku_master_id` BIGINT COMMENT 'Internal identifier of the product that the warranty protects.',
    `claims_allowed_flag` BOOLEAN COMMENT 'True if the warranty permits service claims.',
    `claims_remaining` STRING COMMENT 'Number of warranty service claims still available to the customer.',
    `coverage_amount` DECIMAL(18,2) COMMENT 'Monetary limit of liability for the warranty.',
    `coverage_scope` STRING COMMENT 'Indicates whether the warranty covers a single product, an entire system, or a site installation.. Valid values are `product|system|site`',
    `coverage_terms` STRING COMMENT 'Textual description of what components or services are covered under the warranty.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency for the coverage amount.. Valid values are `USD|EUR|GBP|JPY|CNY|CAD`',
    `document_url` STRING COMMENT 'Link to the digital copy of the warranty contract.',
    `effective_from` DATE COMMENT 'Date when the warranty coverage becomes effective.',
    `effective_until` DATE COMMENT 'Date when the warranty coverage expires; null for open‑ended warranties.',
    `exclusions` STRING COMMENT 'Textual description of items or conditions not covered by the warranty.',
    `extended_until` DATE COMMENT 'Date to which the warranty has been extended, if applicable.',
    `lifecycle_status` STRING COMMENT 'Current state of the warranty in its lifecycle.. Valid values are `active|expired|suspended|pending|cancelled`',
    `notes` STRING COMMENT 'Free‑form notes entered by service personnel.',
    `product_serial_number` STRING COMMENT 'Manufacturer-assigned serial number of the product covered by the warranty.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the warranty record was first created.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the warranty record.',
    `registration_date` DATE COMMENT 'Date when the warranty was entered into the warranty management system.',
    `registration_status` STRING COMMENT 'Indicates whether the warranty has been formally registered in the system.. Valid values are `registered|unregistered|pending`',
    `renewal_flag` BOOLEAN COMMENT 'Indicates whether the warranty is eligible for renewal.',
    `renewal_terms` STRING COMMENT 'Textual description of the conditions and pricing for warranty renewal.',
    `service_level` STRING COMMENT 'Tier of service provided under the warranty.. Valid values are `basic|premium|gold`',
    `transferability_flag` BOOLEAN COMMENT 'True if the warranty can be transferred to a new owner.',
    `warranty_number` STRING COMMENT 'External reference number assigned to the warranty by the sales or service system.',
    `warranty_type` STRING COMMENT 'Classification of the warranty offering.. Valid values are `standard|extended|parts_only|labor_included`',
    CONSTRAINT pk_warranty PRIMARY KEY(`warranty_id`)
) COMMENT 'Master entity representing warranty coverage records for manufactured products, automation systems, and electrification solutions sold to customers. Captures warranty type (standard, extended, parts-only, labor-included), warranty start and end dates, coverage terms, exclusions, transferability flag, registration status, and originating sales order reference. Serves as the SSOT for warranty entitlement validation across service and field operations.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` (
    `field_service_order_id` BIGINT COMMENT 'System-generated unique identifier for the field service work order.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Field Service Order Allocation to Capital Projects ensures labor and parts costs are charged to the correct project budget.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Field service orders directly target a specific engineering component for repair or replacement. This link enables component-level field failure reporting, spare parts identification, and engineering ',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.customer_contact. Business justification: Field service dispatch in manufacturing requires a designated site contact for access coordination, scheduling confirmation, and work-order sign-off. Linking field_service_order to customer_contact en',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer who owns the equipment or requested the service.',
    `engineering_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_specification. Business justification: Field service engineers must reference the governing engineering specification during repair/maintenance to follow correct tolerances, safety requirements, and procedures. Manufacturing service operat',
    `entitlement_id` BIGINT COMMENT 'Foreign key linking to service.service_entitlement. Business justification: A field service order is governed by a service entitlement that defines SLA response and resolution targets. Linking FSO to service_entitlement enables SLA compliance tracking at the work order level ',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Field service orders often target a specific control system for maintenance; the order must reference that control system for scheduling and compliance reporting.',
    `installed_base_id` BIGINT COMMENT 'Foreign key linking to service.installed_base. Business justification: A field service order is performed on a specific customer-installed asset tracked in the installed_base registry. This FK links the work order to the exact installed equipment being serviced, enabling',
    `job_plan_id` BIGINT COMMENT 'Foreign key linking to asset.job_plan. Business justification: Field service engineers executing maintenance follow standardized job plans (OEM procedures, safety steps, task sequences). Linking field_service_order to job_plan enables work standardization complia',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Field service orders are dispatched to specific plant locations. Linking to the structured asset.location master enables site-based service reporting, travel planning, SLA management by location, and ',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Field service orders require parts to be staged at a specific warehouse location before engineer dispatch. This link supports pick-list generation, parts reservation confirmation, and warehouse stagin',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to supply.planned_order. Business justification: Field service execution drives spare parts planned orders. Linking FSO to planned_order supports the service parts replenishment process — dispatchers and planners track which planned order was create',
    `request_id` BIGINT COMMENT 'Foreign key linking to service.request. Business justification: A field service order is dispatched in response to a service request. The request is the originating trigger for the FSO; one request can spawn multiple field service orders (e.g., initial visit, foll',
    `service_contract_id` BIGINT COMMENT 'Foreign key linking to service.service_contract. Business justification: A field service order is executed under a service contract that defines coverage scope, SLA obligations, and billing terms. field_service_order currently stores service_contract_number as a denormaliz',
    `engineer_id` BIGINT COMMENT 'Identifier of the field service engineer assigned to execute the work.',
    `sla_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.sla_agreement. Business justification: Field service orders are dispatched under SLA commitments governing response and resolution times. field_service_order carries denormalized service_level_agreement_code — normalizing to sla_agreement_',
    `warranty_id` BIGINT COMMENT 'Foreign key linking to service.service_warranty. Business justification: A field service order may be executed under warranty coverage. Linking FSO to service_warranty enables warranty claim processing, coverage validation before dispatching billable work, and warranty uti',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Real end date‑time when the technician completed the work.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Real start date‑time when the technician began work on site.',
    `completion_status` STRING COMMENT 'Overall result of the work order execution.. Valid values are `completed|partial|failed`',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `USD|EUR|GBP|JPY|CNY|CAD`',
    `customer_signature_status` STRING COMMENT 'Status of the customers sign‑off on the completed work.. Valid values are `pending|signed|exempt`',
    `labor_cost` DECIMAL(18,2) COMMENT 'Cost of labor hours billed for the service.',
    `labor_hours` DECIMAL(18,2) COMMENT 'Total billable labor hours recorded for the work order.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the service location.',
    `lifecycle_status` STRING COMMENT 'Current state of the work order in its processing lifecycle.. Valid values are `draft|scheduled|in_progress|completed|cancelled|closed`',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the service location.',
    `order_number` STRING COMMENT 'Business-visible identifier assigned to the work order for tracking and customer communication.',
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
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned end date‑time for the service visit.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned start date‑time for the service visit.',
    `service_category` STRING COMMENT 'High‑level grouping of the service request based on urgency and purpose.. Valid values are `preventive|corrective|emergency`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the work order total.',
    `total_discount_amount` DECIMAL(18,2) COMMENT 'Aggregate discount applied to the work order.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Sum of all charge components before discounts and taxes.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after discounts and taxes.',
    `travel_cost` DECIMAL(18,2) COMMENT 'Monetary cost associated with travel time and distance.',
    `travel_distance_km` DECIMAL(18,2) COMMENT 'Distance traveled by the technician to the service site, measured in kilometers.',
    `travel_hours` DECIMAL(18,2) COMMENT 'Billable travel time incurred by the technician to reach the site.',
    `warranty_expiration_date` DATE COMMENT 'Date when the applicable warranty for the equipment expires.',
    `warranty_flag` BOOLEAN COMMENT 'Indicates whether the service is covered under an active warranty.',
    `work_description` STRING COMMENT 'Narrative description of the tasks to be performed during the service visit.',
    CONSTRAINT pk_field_service_order PRIMARY KEY(`field_service_order_id`)
) COMMENT 'Transactional entity representing a dispatched field service work order for on-site technical service, installation, commissioning, preventive maintenance, or repair of customer-installed automation systems and equipment. Captures work order type, assigned field service engineer, scheduled and actual visit dates, site address, work performed description, parts consumed, labor hours, travel time, customer sign-off status, and completion outcome. Linked to originating service request.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`installed_base` (
    `installed_base_id` BIGINT COMMENT 'Primary key for installed_base',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Installed Base Asset Allocation to Projects tracks which assets were delivered under each project for warranty and maintenance.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Required for maintenance teams to identify which component version is installed on each equipment for service actions and spare parts planning.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Needed for Installed Base inventory report to attribute each equipment record to its customer account for warranty and service planning.',
    `delivery_id` BIGINT COMMENT 'Foreign key linking to order.delivery. Business justification: Asset installation traceability: the installed base record for equipment is established when the product is delivered to the customer site. Linking installed_base to the originating delivery enables w',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: Installed base records are linked to IoT device entries to enable real‑time monitoring and predictive maintenance, a standard practice in smart factories.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Installed Base records need the material master for product specifications, supporting the Installed Base Specification report.',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to order.line. Business justification: Product lifecycle traceability from sale to installation: the installed base item corresponds to a specific order line (the line that sold the equipment, including serial number and quantity). Linking',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: Installed base records must track which engineering revision is physically deployed at a customer site. This is essential for field retrofit campaign management, spare parts compatibility validation, ',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Installed base records must reference the exact SKU to drive spare parts planning, warranty entitlement checks, and end-of-life notifications. Manufacturing service operations require SKU-level tracea',
    `capacity_kw` DECIMAL(18,2) COMMENT 'Rated capacity of the equipment in kilowatts.',
    `city` STRING COMMENT 'City component of the site address.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the installation site.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the installed base record was first created.',
    `current` DECIMAL(18,2) COMMENT 'Operating current of the equipment in amperes.',
    `firmware_version` STRING COMMENT 'Version of the firmware loaded on the installed device.',
    `installation_date` DATE COMMENT 'Calendar date when the equipment was installed at the customer site.',
    `installation_method` STRING COMMENT 'Method used to install the equipment.. Valid values are `new|retrofit|upgrade`',
    `last_service_date` DATE COMMENT 'Date of the most recent service activity performed on the asset.',
    `maintenance_frequency_days` STRING COMMENT 'Planned interval between preventive maintenance activities, in days.',
    `maintenance_type` STRING COMMENT 'Category of maintenance performed on the asset.. Valid values are `preventive|corrective|predictive`',
    `mean_time_between_failures_hours` DECIMAL(18,2) COMMENT 'Average elapsed time between successive failures, expressed in hours.',
    `mean_time_to_repair_hours` DECIMAL(18,2) COMMENT 'Average time required to repair the equipment after a failure, in hours.',
    `model_number` STRING COMMENT 'Manufacturer model identifier for the product.',
    `next_maintenance_date` DATE COMMENT 'Planned date for the next preventive maintenance event.',
    `operational_status` STRING COMMENT 'Current operational condition of the installed equipment.. Valid values are `running|degraded|stopped|decommissioned`',
    `overall_equipment_effectiveness` DECIMAL(18,2) COMMENT 'Calculated OEE percentage for the asset.',
    `power_rating_kw` DECIMAL(18,2) COMMENT 'Maximum power rating of the equipment in kilowatts.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned unique serial number of the installed equipment.',
    `site_address` STRING COMMENT 'Physical street address of the installation site.',
    `site_location` STRING COMMENT 'Internal code identifying the customer site or plant where the asset resides.',
    `software_version` STRING COMMENT 'Version of the application software running on the device.',
    `state` STRING COMMENT 'State or province component of the site address.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the installed base record.',
    `voltage` DECIMAL(18,2) COMMENT 'Operating voltage of the equipment in volts.',
    CONSTRAINT pk_installed_base PRIMARY KEY(`installed_base_id`)
) COMMENT 'Master entity representing the registry of all customer-installed automation systems, electrification solutions, and smart infrastructure components actively managed through after-sales service. Captures serial number, product model, firmware/software version, installation date, site location, operational status (running, degraded, stopped, decommissioned), last service date, next scheduled maintenance date, warranty linkage, and service contract coverage reference. Serves as the SSOT for the installed asset population and is the central reference point for all service transactions including requests, field orders, PM schedules, and remote diagnostics.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`entitlement` (
    `entitlement_id` BIGINT COMMENT 'Unique system-generated identifier for the service entitlement record.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Entitlement Allocation to Projects ties service entitlements to the project that generated the entitlement.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.customer_contact. Business justification: In manufacturing service operations, entitlements are often granted to a named technical contact (e.g., priority support for the plant maintenance manager). Linking service_entitlement to customer_con',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer who holds the entitlement.',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to order.line. Business justification: Entitlement granted by purchased line item: service entitlements are earned through purchase of specific products or service packages on order lines. Linking service_entitlement to the order line that',
    `sku_master_id` BIGINT COMMENT 'Identifier of the product or asset to which the entitlement applies.',
    `sla_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.sla_agreement. Business justification: Service entitlements are created from SLA agreements in manufacturing. Linking service_entitlement to sla_agreement enables SLA breach tracking, penalty credit calculation, and entitlement-to-agreemen',
    `acknowledgment_actual_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the request was acknowledged.',
    `acknowledgment_breach_flag` BOOLEAN COMMENT 'True if acknowledgment missed the SLA target.',
    `acknowledgment_breach_reason` STRING COMMENT 'Reason for acknowledgment SLA breach, if any.',
    `acknowledgment_elapsed_minutes` STRING COMMENT 'Minutes elapsed between request creation and acknowledgment.',
    `acknowledgment_target_timestamp` TIMESTAMP COMMENT 'Target timestamp for acknowledgment of the service request.',
    `business_hours_coverage` BOOLEAN COMMENT 'True if SLA applies only during standard business hours; false if 24/7.',
    `entitlement_code` STRING COMMENT 'Business code or number used externally to reference the entitlement.',
    `coverage_level` STRING COMMENT 'Level of service coverage associated with the entitlement.. Valid values are `standard|premium|enterprise`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the entitlement record was first created.',
    `effective_end_date` DATE COMMENT 'Date when the entitlement expires or is terminated; null for open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the entitlement becomes effective.',
    `entitlement_type` STRING COMMENT 'Category of entitlement such as warranty, contract, complimentary, or service plan.. Valid values are `warranty|contract|complimentary|service_plan`',
    `first_response_actual_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the first response was delivered.',
    `first_response_breach_flag` BOOLEAN COMMENT 'True if the first response missed the SLA target.',
    `first_response_breach_reason` STRING COMMENT 'Reason why the first response SLA was breached, if applicable.',
    `first_response_elapsed_minutes` STRING COMMENT 'Actual minutes elapsed between request creation and first response.',
    `first_response_target_timestamp` TIMESTAMP COMMENT 'Target timestamp by which the first response must be provided.',
    `entitlement_name` STRING COMMENT 'Descriptive name of the entitlement offering.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or remarks.',
    `priority_level` STRING COMMENT 'Priority classification of the entitlement for handling service requests.. Valid values are `low|medium|high|critical`',
    `resolution_actual_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the service request was resolved.',
    `resolution_breach_flag` BOOLEAN COMMENT 'True if the resolution missed the SLA target.',
    `resolution_breach_reason` STRING COMMENT 'Reason why the resolution SLA was breached, if applicable.',
    `resolution_elapsed_minutes` STRING COMMENT 'Minutes elapsed between request creation and resolution.',
    `resolution_target_timestamp` TIMESTAMP COMMENT 'Target timestamp by which the service request must be resolved.',
    `service_channel` STRING COMMENT 'Delivery channel for the service (e.g., phone, email, on‑site, remote).. Valid values are `phone|email|on_site|remote`',
    `service_entitlement_description` STRING COMMENT 'Free‑form description of the entitlement, including any special conditions.',
    `service_entitlement_status` STRING COMMENT 'Current lifecycle status of the entitlement.. Valid values are `active|inactive|suspended|pending`',
    `sla_resolution_time_target` STRING COMMENT 'Target time in minutes to fully resolve a service request.',
    `sla_response_time_target` STRING COMMENT 'Target time in minutes for initial response to a service request.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the entitlement record.',
    CONSTRAINT pk_entitlement PRIMARY KEY(`entitlement_id`)
) COMMENT 'Master entity defining specific service entitlement rules, coverage levels, and SLA milestone tracking associated with a service contract or warranty. Specifies which service types, response/resolution time SLAs, and support channels a customer is entitled to for a given installed asset or product family. Captures entitlement name, type (warranty, contract, complimentary), SLA response time target, SLA resolution time target, business hours coverage, and active status. Includes milestone compliance tracking: each SLA milestone event (first response, acknowledgment, resolution) with target timestamp, actual completion timestamp, breach flag, breach reason, and elapsed time. Enables automated SLA enforcement during service request intake, SLA performance monitoring, and breach root-cause analysis. Maps to Salesforce Service Cloud Entitlement and Milestone objects.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`engineer` (
    `engineer_id` BIGINT COMMENT 'Primary key for engineer',
    `active_assignment_count` STRING COMMENT 'Number of service assignments currently active for the engineer.',
    `address_line1` STRING COMMENT 'First line of the engineers mailing address.',
    `address_line2` STRING COMMENT 'Second line of the engineers mailing address.',
    `certification_drive_expiry` DATE COMMENT 'Expiration date of the drive‑systems certification.',
    `certification_electrification_expiry` DATE COMMENT 'Expiration date of the electrification certification.',
    `certification_hmi_expiry` DATE COMMENT 'Expiration date of the HMI certification.',
    `certification_plc_expiry` DATE COMMENT 'Expiration date of the PLC certification.',
    `certification_robotics_expiry` DATE COMMENT 'Expiration date of the robotics certification.',
    `certification_scada_expiry` DATE COMMENT 'Expiration date of the SCADA certification.',
    `city` STRING COMMENT 'City of the engineers mailing address.',
    `classification_or_type` STRING COMMENT 'Category of the engineer (e.g., internal employee, contractor, vendor).. Valid values are `internal|contractor|vendor`',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the engineers address.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the engineer record was first created.',
    `dispatch_zone` STRING COMMENT 'Specific dispatch zone or area assigned to the engineer.',
    `email_address` STRING COMMENT 'Primary email address for the engineer.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `employment_type` STRING COMMENT 'Type of employment relationship.. Valid values are `full_time|part_time|contract|temp`',
    `full_name` STRING COMMENT 'Legal full name of the engineer.',
    `hire_date` DATE COMMENT 'Date the engineer was hired.',
    `labor_classification` STRING COMMENT 'Labor classification for payroll and cost allocation.. Valid values are `skilled|unskilled|technician|engineer`',
    `labor_rate_hourly` DECIMAL(18,2) COMMENT 'Standard hourly labor rate for the engineer.',
    `last_dispatch_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent dispatch of the engineer.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle status of the engineer.. Valid values are `active|inactive|on_leave|retired|terminated`',
    `max_travel_distance_km` STRING COMMENT 'Maximum distance (in km) the engineer is willing to travel.',
    `next_available_timestamp` TIMESTAMP COMMENT 'Estimated timestamp when the engineer will be next available for dispatch.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates if the engineer is eligible for overtime work.',
    `performance_rating` STRING COMMENT 'Most recent performance rating for the engineer.. Valid values are `A|B|C|D|E`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the engineer.. Valid values are `^+?[0-9]{7,15}$`',
    `postal_code` STRING COMMENT 'Postal code of the engineers mailing address.',
    `primary_contact_method` STRING COMMENT 'Preferred method for contacting the engineer.. Valid values are `email|phone|sms`',
    `primary_language` STRING COMMENT 'Primary language spoken by the engineer.',
    `product_family_competency` STRING COMMENT 'Product families or equipment lines the engineer is qualified to service.',
    `security_clearance_level` STRING COMMENT 'Security clearance level required for assignments.. Valid values are `none|confidential|secret|top_secret`',
    `service_region` STRING COMMENT 'Geographic region where the engineer provides service.. Valid values are `NA|EU|APAC|LATAM|MEA`',
    `shift_preference` STRING COMMENT 'Preferred work shift for the engineer.. Valid values are `day|night|flex`',
    `skill_drive_systems_certified` BOOLEAN COMMENT 'Indicates if the engineer holds a drive‑systems certification.',
    `skill_electrification_certified` BOOLEAN COMMENT 'Indicates if the engineer holds an electrification certification.',
    `skill_hmi_certified` BOOLEAN COMMENT 'Indicates if the engineer holds an HMI certification.',
    `skill_plc_certified` BOOLEAN COMMENT 'Indicates if the engineer holds a PLC certification.',
    `skill_robotics_certified` BOOLEAN COMMENT 'Indicates if the engineer holds a robotics certification.',
    `skill_scada_certified` BOOLEAN COMMENT 'Indicates if the engineer holds a SCADA certification.',
    `state_province` STRING COMMENT 'State or province of the engineers mailing address.',
    `termination_date` DATE COMMENT 'Date the engineers employment ended, if applicable.',
    `travel_eligibility` BOOLEAN COMMENT 'Indicates if the engineer is eligible for travel assignments.',
    `union_member_flag` BOOLEAN COMMENT 'Indicates whether the engineer is a union member.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the engineer record.',
    `years_of_experience` STRING COMMENT 'Total years of relevant field service experience.',
    CONSTRAINT pk_engineer PRIMARY KEY(`engineer_id`)
) COMMENT 'Master entity representing field service engineers and technical support specialists assigned to service operations. Captures employee reference, skill certifications (PLC, SCADA, HMI, drive systems, electrification, robotics), product family competencies, service region assignment, current availability status (available, dispatched, on-leave, training), dispatch zone, language capabilities, active assignment count, and certification expiry dates. Serves as the SSOT for field service resource profiles and dispatch eligibility within the service domain.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` (
    `part_consumption_id` BIGINT COMMENT 'Primary key for part_consumption',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Parts Consumption Accounting to Project Costs tracks part usage against the project budget for cost control.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Parts consumed during field service are engineering-defined components. This link enables field failure rate analysis by component, warranty cost tracking per engineering component, and engineering ch',
    `delivery_id` BIGINT COMMENT 'Foreign key linking to order.delivery. Business justification: Service parts fulfillment tracking: when spare parts are shipped to a customer site for a field service job, the outbound delivery document records the shipment. Linking part_consumption to the fulfil',
    `field_service_order_id` BIGINT COMMENT 'Foreign key linking to service.field_service_order. Business justification: Parts are consumed during field service orders. part_consumption currently links to request but not directly to the field_service_order where the parts were physically used. This FK enables accurate p',
    `goods_issue_id` BIGINT COMMENT 'Foreign key linking to order.goods_issue. Business justification: Inventory cost allocation: in manufacturing ERP, spare part consumption for field service triggers a goods issue posting that records the inventory movement and cost. Linking part_consumption to goods',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Parts consumed in field service must be traceable to their manufacturing lot/batch for product recall management, ISO 9001 traceability compliance, and warranty claim validation. Manufacturing domain ',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Parts consumed during field service must link to material master for inventory goods-issue posting, MRP reorder triggering, and inventory valuation reconciliation. Manufacturing ERP (SAP-style) requir',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Parts consumed during field service are procured via purchase orders. Linking part_consumption to purchase_order enables job cost reconciliation, three-way match auditing, and warranty coverage valida',
    `service_contract_id` BIGINT COMMENT 'Foreign key linking to service.service_contract. Business justification: Parts consumed during service may be covered under a service contract (contract_coverage_flag exists on part_consumption). Linking to service_contract enables contract-covered parts cost tracking, bil',
    `request_id` BIGINT COMMENT 'Identifier of the service request (transaction header) to which this part consumption line belongs.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Parts consumed during field service must be traceable to SKU master for inventory replenishment, warranty cost accounting, and regulatory traceability. Manufacturing service cost reporting requires li',
    `sourcing_rule_id` BIGINT COMMENT 'Foreign key linking to supply.sourcing_rule. Business justification: Service parts procurement governance: sourcing rules define make/buy decisions, preferred suppliers, and MOQs for spare parts. Linking part_consumption to sourcing_rule enables procurement compliance ',
    `spare_part_id` BIGINT COMMENT 'Internal system identifier for the spare part consumed.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Part consumption must reference the specific warehouse bin/location from which parts were physically picked and issued. This drives warehouse management goods-issue accuracy, cycle count reconciliatio',
    `warranty_id` BIGINT COMMENT 'Foreign key linking to service.service_warranty. Business justification: Parts consumed during service may be covered under a specific warranty record. part_consumption has warranty_coverage_flag (boolean) but no FK to the actual warranty record. Linking to service_warrant',
    `actual_delivery_date` DATE COMMENT 'Calendar date when the part was actually received.',
    `consumption_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the part was recorded as consumed on site.',
    `contract_coverage_flag` BOOLEAN COMMENT 'True if the part usage is reimbursable under a service contract separate from warranty.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center code charged for the part consumption.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `delivery_tracking_number` STRING COMMENT 'Carrier‑provided tracking identifier for the part shipment.',
    `expected_delivery_date` DATE COMMENT 'Planned calendar date for part arrival at the service location.',
    `fulfillment_status` STRING COMMENT 'Current status of the part order fulfillment process.. Valid values are `pending|shipped|delivered|canceled`',
    `line_number` STRING COMMENT 'Sequential number of the line within the service part order, used for ordering and reference.',
    `line_total_amount` DECIMAL(18,2) COMMENT 'Total monetary value for the line (quantity × unit price) before any discounts or taxes.',
    `notes` STRING COMMENT 'Additional free‑form comments captured by the technician.',
    `order_date` TIMESTAMP COMMENT 'Date‑time when the part order was created in the service system.',
    `order_urgency` STRING COMMENT 'Business‑defined urgency level for the part order, used for prioritization.. Valid values are `low|medium|high|critical`',
    `quantity_consumed` STRING COMMENT 'Number of units of the part used during the service activity.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the part consumption record was first created in the lakehouse.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the part consumption record.',
    `source_type` STRING COMMENT 'Origin of the part supplied to the field technician.. Valid values are `warehouse_stock|van_stock|supplier_direct`',
    `unit_of_measure` STRING COMMENT 'Unit in which the part quantity is measured (e.g., each, set, box).',
    `unit_price` DECIMAL(18,2) COMMENT 'Standard price per unit of the part at the time of consumption, in the transaction currency.',
    `warranty_coverage_flag` BOOLEAN COMMENT 'Indicates whether the part consumption is covered under a warranty or service contract.',
    CONSTRAINT pk_part_consumption PRIMARY KEY(`part_consumption_id`)
) COMMENT 'Transactional entity representing spare parts consumption and parts orders associated with field service activities, including emergency parts procurement for critical equipment downtime. Captures part number (SKU), quantity consumed, source (warehouse stock, van stock, supplier direct ship), cost, warranty/contract coverage flag, order urgency classification, fulfillment status, and delivery tracking. Provides traceability of parts usage per service event for cost recovery, warranty claims, inventory replenishment triggers, and bridges service domain parts demand with inventory and procurement domain supply.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_entitlement_id` FOREIGN KEY (`entitlement_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`entitlement`(`entitlement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ADD CONSTRAINT `fk_service_request_warranty_id` FOREIGN KEY (`warranty_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`warranty`(`warranty_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_entitlement_id` FOREIGN KEY (`entitlement_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`entitlement`(`entitlement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_installed_base_id` FOREIGN KEY (`installed_base_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`installed_base`(`installed_base_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_request_id` FOREIGN KEY (`request_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`request`(`request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`service_contract`(`service_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_engineer_id` FOREIGN KEY (`engineer_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`engineer`(`engineer_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ADD CONSTRAINT `fk_service_field_service_order_warranty_id` FOREIGN KEY (`warranty_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`warranty`(`warranty_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ADD CONSTRAINT `fk_service_part_consumption_field_service_order_id` FOREIGN KEY (`field_service_order_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`field_service_order`(`field_service_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ADD CONSTRAINT `fk_service_part_consumption_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`service_contract`(`service_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ADD CONSTRAINT `fk_service_part_consumption_request_id` FOREIGN KEY (`request_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`request`(`request_id`);
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ADD CONSTRAINT `fk_service_part_consumption_warranty_id` FOREIGN KEY (`warranty_id`) REFERENCES `vibe_manufacturing_v1`.`service`.`warranty`(`warranty_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`service` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_manufacturing_v1`.`service` SET TAGS ('dbx_domain' = 'service');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` SET TAGS ('dbx_subdomain' = 'customer_support');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Request Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Specification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Entitlement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Request Asset Equipment Register Id');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `run_id` SET TAGS ('dbx_business_glossary_term' = 'Production Run Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Intake Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `warranty_id` SET TAGS ('dbx_business_glossary_term' = 'Service Warranty Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Service Cost');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Request Channel');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'phone|email|portal|field|chat');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Closed Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Email');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Phone');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`request` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
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
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `service_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Contract ID (SCID)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count (AC)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Renewal Flag (ARF)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `billing_cycle_day` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Day (BCD)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency (BF)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `contract_category` SET TAGS ('dbx_business_glossary_term' = 'Contract Category (CC)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `contract_category` SET TAGS ('dbx_value_regex' = 'warranty|service|maintenance|support');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `contract_description` SET TAGS ('dbx_business_glossary_term' = 'Contract Description (CD)');
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
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date (LAD)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Contract Manager Email (CME)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`service_contract` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
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
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `warranty_id` SET TAGS ('dbx_business_glossary_term' = 'Service Warranty Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CID)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (SOID)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Intake Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (PID)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `claims_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Claims Allowed Flag (CAF)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `claims_remaining` SET TAGS ('dbx_business_glossary_term' = 'Remaining Claims (RC)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Amount (CA)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `coverage_scope` SET TAGS ('dbx_business_glossary_term' = 'Coverage Scope (CS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `coverage_scope` SET TAGS ('dbx_value_regex' = 'product|system|site');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `coverage_terms` SET TAGS ('dbx_business_glossary_term' = 'Coverage Terms (CT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY|CAD');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Warranty Document URL (WDU)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFD)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EUD)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `exclusions` SET TAGS ('dbx_business_glossary_term' = 'Exclusions (EX)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `extended_until` SET TAGS ('dbx_business_glossary_term' = 'Extended Until Date (EUD)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|pending|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Warranty Notes (WN)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `product_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Product Serial Number (PSN)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (RCT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (RUT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Registration Date (WRD)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status (RS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'registered|unregistered|pending');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Flag (RF)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms (RT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level (SL)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'basic|premium|gold');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `transferability_flag` SET TAGS ('dbx_business_glossary_term' = 'Transferability Flag (TF)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `warranty_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Number (WN)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `warranty_type` SET TAGS ('dbx_business_glossary_term' = 'Warranty Type (WT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`warranty` ALTER COLUMN `warranty_type` SET TAGS ('dbx_value_regex' = 'standard|extended|parts_only|labor_included');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` SET TAGS ('dbx_subdomain' = 'customer_support');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `field_service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Field Service Order ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Specification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Entitlement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Control System Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `installed_base_id` SET TAGS ('dbx_business_glossary_term' = 'Installed Base Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `job_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Parts Staging Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Request Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `service_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `engineer_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `sla_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Agreement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `warranty_id` SET TAGS ('dbx_business_glossary_term' = 'Service Warranty Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp (AET)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp (AST)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status (CS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`field_service_order` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'completed|partial|failed');
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
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `installed_base_id` SET TAGS ('dbx_business_glossary_term' = 'Installed Base Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'running|degraded|stopped|decommissioned');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `overall_equipment_effectiveness` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) (OEE_PCT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `power_rating_kw` SET TAGS ('dbx_business_glossary_term' = 'Power Rating (kW) (POWER_RATING_KW)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number (SN)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `site_address` SET TAGS ('dbx_business_glossary_term' = 'Site Address (SITE_ADDR)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `site_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `site_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `site_location` SET TAGS ('dbx_business_glossary_term' = 'Site Location Code (SITE_LOC)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version (SWV)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province (STATE)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`installed_base` ALTER COLUMN `voltage` SET TAGS ('dbx_business_glossary_term' = 'Voltage (V) (VOLTAGE)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` SET TAGS ('dbx_subdomain' = 'agreement_management');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Entitlement Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `sla_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Agreement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `acknowledgment_actual_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Actual Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `acknowledgment_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Breach Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `acknowledgment_breach_reason` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Breach Reason');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `acknowledgment_elapsed_minutes` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Elapsed Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `acknowledgment_target_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Target Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `business_hours_coverage` SET TAGS ('dbx_business_glossary_term' = 'Business Hours Coverage Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `entitlement_code` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Code');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `coverage_level` SET TAGS ('dbx_business_glossary_term' = 'Coverage Level');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `coverage_level` SET TAGS ('dbx_value_regex' = 'standard|premium|enterprise');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `entitlement_type` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Type');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `entitlement_type` SET TAGS ('dbx_value_regex' = 'warranty|contract|complimentary|service_plan');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `first_response_actual_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Response Actual Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `first_response_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'First Response Breach Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `first_response_breach_reason` SET TAGS ('dbx_business_glossary_term' = 'First Response Breach Reason');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `first_response_elapsed_minutes` SET TAGS ('dbx_business_glossary_term' = 'First Response Elapsed Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `first_response_target_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Response Target Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `entitlement_name` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Name');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Notes');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `resolution_actual_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Actual Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `resolution_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Resolution Breach Flag');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `resolution_breach_reason` SET TAGS ('dbx_business_glossary_term' = 'Resolution Breach Reason');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `resolution_elapsed_minutes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Elapsed Minutes');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `resolution_target_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Target Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `service_channel` SET TAGS ('dbx_business_glossary_term' = 'Service Channel');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `service_channel` SET TAGS ('dbx_value_regex' = 'phone|email|on_site|remote');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `service_entitlement_description` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Description');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `service_entitlement_status` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Status');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `service_entitlement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `sla_resolution_time_target` SET TAGS ('dbx_business_glossary_term' = 'SLA Resolution Time Target (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `sla_response_time_target` SET TAGS ('dbx_business_glossary_term' = 'SLA Response Time Target (Minutes)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`entitlement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `engineer_id` SET TAGS ('dbx_business_glossary_term' = 'Engineer Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `active_assignment_count` SET TAGS ('dbx_business_glossary_term' = 'Active Assignment Count (ASSIGN_COUNT)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (ADDR1)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (ADDR2)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Engineer Email Address (EMAIL)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type (EMP_TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|temp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Engineer Full Name (FULL_NAME)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date (HIRE_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `labor_classification` SET TAGS ('dbx_business_glossary_term' = 'Labor Classification (LAB_CLASS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `labor_classification` SET TAGS ('dbx_value_regex' = 'skilled|unskilled|technician|engineer');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `labor_rate_hourly` SET TAGS ('dbx_business_glossary_term' = 'Hourly Labor Rate (HOURLY_RATE)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `last_dispatch_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Dispatch Timestamp (LAST_DISPATCH)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|retired|terminated');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `max_travel_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Maximum Travel Distance (MAX_TRAVEL_KM)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `next_available_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Available Timestamp (NEXT_AVAIL)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligibility Flag (OT_ELIG)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating (PERF_RATING)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Engineer Phone Number (PHONE)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (ZIP)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method (CONTACT_METHOD)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|sms');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language (LANG_PRIMARY)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`engineer` ALTER COLUMN `product_family_competency` SET TAGS ('dbx_business_glossary_term' = 'Product Family Competency (PF_COMP)');
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
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` SET TAGS ('dbx_subdomain' = 'customer_support');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `part_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Part Consumption Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `field_service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Field Service Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `goods_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `service_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `sourcing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Rule Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Part Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `warranty_id` SET TAGS ('dbx_business_glossary_term' = 'Service Warranty Id (Foreign Key)');
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
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `quantity_consumed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Consumed');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Part Source Type');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'warehouse_stock|van_stock|supplier_direct');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_manufacturing_v1`.`service`.`part_consumption` ALTER COLUMN `warranty_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Coverage Flag');
