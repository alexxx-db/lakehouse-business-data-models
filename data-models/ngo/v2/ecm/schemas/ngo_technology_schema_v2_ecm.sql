-- Schema for Domain: technology | Business:  | Version: v2_ecm
-- Generated on: 2026-07-03 04:47:18

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`technology` COMMENT 'Systems of record: ServiceNow (ITSM), Jira Service Management, Azure AD / Okta (identity), SIEM platforms, asset management (Lansweeper, SNOW). Covers IT assets, services, security, connectivity, and platform integrations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`it_asset` (
    `it_asset_id` BIGINT COMMENT 'Unique identifier for the IT asset record. Primary key.',
    `network_site_id` BIGINT COMMENT 'Foreign key linking to technology.network_site. Business justification: IT assets are deployed at specific network sites (HQ, field offices, data centers). N:1 relationship - many assets at one network site. Enables physical/logical location tracking, network capacity pla',
    `parent_it_asset_id` BIGINT COMMENT 'Self-referencing FK on it_asset (parent_it_asset_id)',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member or employee to whom the asset is currently assigned for use.',
    `vendor_id` BIGINT COMMENT 'FK to supply.vendor',
    `asset_category` STRING COMMENT 'Detailed categorization of the asset within its type, specifying the specific kind of hardware or software. [ENUM-REF-CANDIDATE: laptop|desktop|server|tablet|smartphone|router|switch|firewall|printer|scanner|application_software|operating_system|database|middleware — 14 candidates stripped; promote to reference product]',
    `asset_condition` STRING COMMENT 'Assessment of the physical or functional condition of the asset, used for maintenance planning and disposal decisions. [ENUM-REF-CANDIDATE: new|excellent|good|fair|poor|damaged|obsolete — 7 candidates stripped; promote to reference product]',
    `asset_tag` STRING COMMENT 'Externally visible unique identifier affixed to the physical asset for inventory tracking and auditing purposes.. Valid values are `^[A-Z0-9]{6,20}$`',
    `asset_type` STRING COMMENT 'High-level classification of the IT asset distinguishing between hardware, software, network equipment, mobile devices, peripherals, and licenses.. Valid values are `hardware|software|network_equipment|mobile_device|peripheral|license`',
    `assigned_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the country where the asset is deployed.. Valid values are `^[A-Z]{3}$`',
    `assigned_location_name` STRING COMMENT 'Name or identifier of the specific office, field location, or facility where the asset is assigned.',
    `assigned_location_type` STRING COMMENT 'Type of organizational location where the asset is currently deployed or stored.. Valid values are `headquarters|country_office|field_office|warehouse|remote`',
    `assignment_date` DATE COMMENT 'Date on which the asset was assigned to the current staff member or location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the procurement cost.. Valid values are `^[A-Z]{3}$`',
    `depreciation_method` STRING COMMENT 'Accounting method used to depreciate the asset value over its useful life.. Valid values are `straight_line|declining_balance|units_of_production|none`',
    `disposal_date` DATE COMMENT 'Date on which the asset was disposed of, sold, donated, or decommissioned.',
    `disposal_method` STRING COMMENT 'Method by which the asset was disposed of at end of life, important for environmental and data security compliance.. Valid values are `sold|donated|recycled|destroyed|returned_to_vendor`',
    `hostname` STRING COMMENT 'Network hostname or computer name assigned to the asset for identification on the organizations network.',
    `ip_address` STRING COMMENT 'Network IP address assigned to the asset for connectivity and network management purposes.. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset record was last updated or modified.',
    `license_expiry_date` DATE COMMENT 'Date on which the software license expires and requires renewal to maintain compliance.',
    `lifecycle_status` STRING COMMENT 'Current state of the asset in its operational lifecycle, indicating whether it is actively in use, stored, under repair, or decommissioned.. Valid values are `active|in_storage|in_repair|deployed|retired|decommissioned`',
    `mac_address` STRING COMMENT 'Hardware MAC address uniquely identifying the network interface of the asset.. Valid values are `^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$`',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured or developed the IT asset.',
    `model` STRING COMMENT 'Manufacturer model number or name identifying the specific product variant.',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, or special handling instructions related to the asset.',
    `operating_system` STRING COMMENT 'Name and version of the operating system installed on the asset, critical for software compatibility and security patching.',
    `procurement_cost` DECIMAL(18,2) COMMENT 'Original purchase price or acquisition cost of the asset in the organizations base currency.',
    `procurement_date` DATE COMMENT 'Date on which the asset was purchased or acquired by the organization.',
    `product_name` STRING COMMENT 'Commercial or marketing name of the IT asset product.',
    `purchase_order_number` STRING COMMENT 'Reference number of the purchase order used to acquire the asset, linking to procurement records.',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the asset at the end of its useful life.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned unique serial number for the hardware or software license.',
    `software_version` STRING COMMENT 'Version number of the primary software or firmware installed on the asset.',
    `support_contract_number` STRING COMMENT 'Reference number for any active maintenance or support contract associated with the asset.',
    `support_expiry_date` DATE COMMENT 'Date on which the support or maintenance contract expires.',
    `useful_life_years` STRING COMMENT 'Expected useful life of the asset in years, used for depreciation and replacement planning.',
    `warranty_expiry_date` DATE COMMENT 'Date on which the manufacturer or vendor warranty coverage ends, after which maintenance costs may increase.',
    `warranty_start_date` DATE COMMENT 'Date on which the manufacturer or vendor warranty coverage begins.',
    `warranty_type` STRING COMMENT 'Type of warranty coverage applicable to the asset, distinguishing between manufacturer, extended, or third-party warranties.. Valid values are `manufacturer|extended|third_party|none`',
    CONSTRAINT pk_it_asset PRIMARY KEY(`it_asset_id`)
) COMMENT 'IT hardware or software asset. Source systems: ServiceNow CMDB, Lansweeper, SNOW asset management, Azure AD device inventory.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`system_platform` (
    `system_platform_id` BIGINT COMMENT 'Unique identifier for the system platform record.',
    `parent_system_platform_id` BIGINT COMMENT 'Reference identifier linking to the associated parent system platform entity.',
    `annual_cost` DECIMAL(18,2) COMMENT 'Attribute capturing the annual cost information for the system platform entity.',
    `api_endpoint` STRING COMMENT 'Attribute capturing the api endpoint information for the system platform entity.',
    `authentication_method` STRING COMMENT 'Attribute capturing the authentication method information for the system platform entity.',
    `backup_frequency` STRING COMMENT 'Attribute capturing the backup frequency information for the system platform entity.',
    `compliance_frameworks` STRING COMMENT 'Attribute capturing the compliance frameworks information for the system platform entity.',
    `contract_end_date` DATE COMMENT 'Date and time when the contract end event occurred for this system platform.',
    `contract_reference` STRING COMMENT 'Attribute capturing the contract reference information for the system platform entity.',
    `contract_start_date` DATE COMMENT 'Date and time when the contract start event occurred for this system platform.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this system platform.',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `data_classification_level` STRING COMMENT 'Attribute capturing the data classification level information for the system platform entity.',
    `decommission_date` DATE COMMENT 'Date and time when the decommission event occurred for this system platform.',
    `deployment_type` STRING COMMENT 'Classification type categorizing the deployment for this record.',
    `system_platform_description` STRING COMMENT 'Detailed textual description providing context about the system platform.',
    `disaster_recovery_tier` STRING COMMENT 'Attribute capturing the disaster recovery tier information for the system platform entity.',
    `geographic_coverage` DOUBLE COMMENT 'Attribute capturing the geographic coverage information for the system platform entity.',
    `go_live_date` DATE COMMENT 'Date and time when the go live event occurred for this system platform.',
    `hosting_environment` STRING COMMENT 'Attribute capturing the hosting environment information for the system platform entity.',
    `integration_count` DOUBLE COMMENT 'Count or number of integration items associated with this record.',
    `is_mobile_enabled` BOOLEAN COMMENT 'Boolean indicator specifying whether the record mobile enabled.',
    `is_offline_capable` BOOLEAN COMMENT 'Boolean indicator specifying whether the record offline capable.',
    `license_type` STRING COMMENT 'Classification type categorizing the license for this record.',
    `modified_by` STRING COMMENT 'Reference to the user or entity that performed the modified action.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this system platform.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the system platform entity.',
    `platform_code` STRING COMMENT 'Standardized code representing the platform classification or category.',
    `platform_name` STRING COMMENT 'Human-readable name or label for the platform.',
    `platform_status` STRING COMMENT 'Current status indicator for the platform workflow state.',
    `platform_type` STRING COMMENT 'Classification type categorizing the platform for this record.',
    `primary_business_domain` STRING COMMENT 'Attribute capturing the primary business domain information for the system platform entity.',
    `support_tier` STRING COMMENT 'Attribute capturing the support tier information for the system platform entity.',
    `system_owner` STRING COMMENT 'Attribute capturing the system owner information for the system platform entity.',
    `technical_owner` STRING COMMENT 'Attribute capturing the technical owner information for the system platform entity.',
    `url` STRING COMMENT 'Attribute capturing the url information for the system platform entity.',
    `user_count` STRING COMMENT 'Count or number of user items associated with this record.',
    `vendor_name` STRING COMMENT 'Human-readable name or label for the vendor.',
    `version` STRING COMMENT 'Attribute capturing the version information for the system platform entity.',
    `created_by` STRING COMMENT 'Reference to the user or entity that performed the created action.',
    CONSTRAINT pk_system_platform PRIMARY KEY(`system_platform_id`)
) COMMENT 'Enterprise system or platform. Source systems: ServiceNow CMDB, enterprise architecture tools. Examples: SAP S/4HANA, DHIS2, Primero, Kobo Toolbox. Systems-of-record: ServiceNow CMDB, SAP Solution Manager. Covers SAP S/4HANA, eTools, DHIS2, Kobo Toolbox, Primero, InSight, SCOPE, proGres and other humanitarian platforms.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`it_service` (
    `it_service_id` BIGINT COMMENT 'Unique identifier for the it service record.',
    `parent_it_service_id` BIGINT COMMENT 'Reference identifier linking to the associated parent it service entity.',
    `system_platform_id` BIGINT COMMENT 'Reference identifier linking to the associated primary system platform entity.',
    `access_request_process` STRING COMMENT 'Attribute capturing the access request process information for the it service entity.',
    `authentication_method` STRING COMMENT 'Attribute capturing the authentication method information for the it service entity.',
    `availability_target_percent` DOUBLE COMMENT 'Attribute capturing the availability target percent information for the it service entity.',
    `backup_frequency` STRING COMMENT 'Attribute capturing the backup frequency information for the it service entity.',
    `compliance_frameworks` STRING COMMENT 'Attribute capturing the compliance frameworks information for the it service entity.',
    `contract_reference_number` STRING COMMENT 'Count or number of contract reference items associated with this record.',
    `cost_allocation_method` DECIMAL(18,2) COMMENT 'Attribute capturing the cost allocation method information for the it service entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this it service.',
    `data_classification_level` STRING COMMENT 'Attribute capturing the data classification level information for the it service entity.',
    `disaster_recovery_rpo_hours` STRING COMMENT 'Attribute capturing the disaster recovery rpo hours information for the it service entity.',
    `disaster_recovery_rto_hours` STRING COMMENT 'Attribute capturing the disaster recovery rto hours information for the it service entity.',
    `geographic_coverage` DOUBLE COMMENT 'Attribute capturing the geographic coverage information for the it service entity.',
    `knowledge_base_url` STRING COMMENT 'Attribute capturing the knowledge base url information for the it service entity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the last modified event occurred for this it service.',
    `last_review_date` DATE COMMENT 'Date and time when the last review event occurred for this it service.',
    `modified_by_user` STRING COMMENT 'Attribute capturing the modified by user information for the it service entity.',
    `monthly_cost_usd` DECIMAL(18,2) COMMENT 'Attribute capturing the monthly cost usd information for the it service entity.',
    `next_review_date` DATE COMMENT 'Date and time when the next review event occurred for this it service.',
    `resolution_time_target_hours` STRING COMMENT 'Attribute capturing the resolution time target hours information for the it service entity.',
    `response_time_target_minutes` STRING COMMENT 'Attribute capturing the response time target minutes information for the it service entity.',
    `retirement_date` DATE COMMENT 'Date and time when the retirement event occurred for this it service.',
    `service_category` STRING COMMENT 'Attribute capturing the service category information for the it service entity.',
    `service_code` STRING COMMENT 'Standardized code representing the service classification or category.',
    `service_delivery_model` STRING COMMENT 'Attribute capturing the service delivery model information for the it service entity.',
    `service_description` STRING COMMENT 'Detailed textual description providing context about the service.',
    `service_hours` STRING COMMENT 'Attribute capturing the service hours information for the it service entity.',
    `service_launch_date` DATE COMMENT 'Date and time when the service launch event occurred for this it service.',
    `service_manager_name` STRING COMMENT 'Human-readable name or label for the service manager.',
    `service_name` STRING COMMENT 'Human-readable name or label for the service.',
    `service_owner_email` STRING COMMENT 'Attribute capturing the service owner email information for the it service entity.',
    `service_owner_name` STRING COMMENT 'Human-readable name or label for the service owner.',
    `service_status` STRING COMMENT 'Current status indicator for the service workflow state.',
    `service_type` STRING COMMENT 'Classification type categorizing the service for this record.',
    `sla_tier` STRING COMMENT 'Attribute capturing the sla tier information for the it service entity.',
    `support_contact_email` STRING COMMENT 'Attribute capturing the support contact email information for the it service entity.',
    `support_phone_number` STRING COMMENT 'Count or number of support phone items associated with this record.',
    `supported_user_population` STRING COMMENT 'Attribute capturing the supported user population information for the it service entity.',
    `training_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the training required condition applies.',
    `vendor_name` STRING COMMENT 'Human-readable name or label for the vendor.',
    CONSTRAINT pk_it_service PRIMARY KEY(`it_service_id`)
) COMMENT 'Master catalog of IT services offered by the technology team to internal staff and field operations, including connectivity services, helpdesk support, cloud storage, email, VPN access, data backup, and platform administration. Captures service name, service category, service owner, SLA tier, supported user population, availability target, and current service status. Aligned with ITIL service catalog practices. Systems-of-record: ServiceNow, SAP Solution Manager. Covers services hosted on humanitarian platforms (DHIS2, Kobo, Primero, eTools).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`service_request` (
    `service_request_id` BIGINT COMMENT 'Unique identifier for the service request record.',
    `country_office_id` BIGINT COMMENT 'Reference identifier linking to the associated country office entity.',
    `it_asset_id` BIGINT COMMENT 'Reference identifier linking to the associated it asset entity.',
    `it_service_id` BIGINT COMMENT 'Reference identifier linking to the associated it service entity.',
    `knowledge_article_id` BIGINT COMMENT 'Reference identifier linking to the associated knowledge article entity.',
    `parent_service_request_id` BIGINT COMMENT 'Reference identifier linking to the associated parent service request entity.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated primary service staff member entity.',
    `it_incident_id` BIGINT COMMENT 'Reference identifier linking to the associated related incident it incident entity.',
    `change_request_id` BIGINT COMMENT 'Reference identifier linking to the associated resulting change request entity.',
    `assigned_timestamp` TIMESTAMP COMMENT 'Date and time when the assigned event occurred for this service request.',
    `assignment_group` STRING COMMENT 'Attribute capturing the assignment group information for the service request entity.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the closed event occurred for this service request.',
    `contact_method` STRING COMMENT 'Attribute capturing the contact method information for the service request entity.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Standardized code representing the cost center classification or category.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this service request.',
    `service_request_description` STRING COMMENT 'Detailed textual description providing context about the service request.',
    `escalation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the escalation condition applies.',
    `escalation_reason` STRING COMMENT 'Attribute capturing the escalation reason information for the service request entity.',
    `first_response_timestamp` TIMESTAMP COMMENT 'Date and time when the first response event occurred for this service request.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the last modified event occurred for this service request.',
    `priority_level` STRING COMMENT 'Attribute capturing the priority level information for the service request entity.',
    `reopened_count` STRING COMMENT 'Count or number of reopened items associated with this record.',
    `request_type` STRING COMMENT 'Classification type categorizing the request for this record.',
    `requester_feedback` DECIMAL(18,2) COMMENT 'Attribute capturing the requester feedback information for the service request entity.',
    `requester_satisfaction_rating` STRING COMMENT 'Attribute capturing the requester satisfaction rating information for the service request entity.',
    `resolution_category` STRING COMMENT 'Attribute capturing the resolution category information for the service request entity.',
    `resolution_notes` STRING COMMENT 'Attribute capturing the resolution notes information for the service request entity.',
    `resolved_timestamp` TIMESTAMP COMMENT 'Date and time when the resolved event occurred for this service request.',
    `root_cause` STRING COMMENT 'Attribute capturing the root cause information for the service request entity.',
    `service_request_status` STRING COMMENT 'Current status indicator for the service request workflow state.',
    `sla_breach_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the sla breach condition applies.',
    `sla_target_hours` DECIMAL(18,2) COMMENT 'Attribute capturing the sla target hours information for the service request entity.',
    `subject` STRING COMMENT 'Attribute capturing the subject information for the service request entity.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the submitted event occurred for this service request.',
    `ticket_number` STRING COMMENT 'Count or number of ticket items associated with this record.',
    `time_spent_hours` DECIMAL(18,2) COMMENT 'Attribute capturing the time spent hours information for the service request entity.',
    CONSTRAINT pk_service_request PRIMARY KEY(`service_request_id`)
) COMMENT 'Transactional record of every IT helpdesk and service desk request raised by staff across HQ and field offices. Captures request type (hardware fault, software access, connectivity issue, platform support, data recovery), requester identity, affected system or asset, priority level, assigned technician, SLA breach flag, resolution notes, and closure timestamp. Sourced from the IT helpdesk ticketing system (e.g., Freshservice, Jira Service Management).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`change_request` (
    `change_request_id` BIGINT COMMENT 'Primary key',
    `cab_meeting_id` BIGINT COMMENT 'FK to CAB meeting',
    `it_project_id` BIGINT COMMENT 'FK to IT project',
    `staff_member_id` BIGINT COMMENT 'FK to staff member',
    `system_platform_id` BIGINT COMMENT 'FK to system platform',
    `rollback_change_request_id` BIGINT COMMENT 'Self-ref FK to rollback change request',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual end time',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual start time',
    `affected_services` STRING COMMENT 'Services affected by the change',
    `affected_systems` STRING COMMENT 'Systems affected',
    `approval_notes` STRING COMMENT 'Attribute capturing the approval notes information for the change request entity.',
    `assigned_to_name` STRING COMMENT 'Assigned person name',
    `cab_approval_date` DATE COMMENT 'Date and time when the cab approval event occurred for this change request.',
    `cab_approval_required` BOOLEAN COMMENT 'Whether CAB approval is required',
    `cab_approval_status` STRING COMMENT 'Current status indicator for the cab approval workflow state.',
    `change_category` STRING COMMENT 'Category of change',
    `change_number` STRING COMMENT 'Count or number of change items associated with this record.',
    `change_request_status` STRING COMMENT 'Current status indicator for the change request workflow state.',
    `change_type` STRING COMMENT 'Type of change',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the closed event occurred for this change request.',
    `closure_notes` STRING COMMENT 'Attribute capturing the closure notes information for the change request entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this change request.',
    `change_request_description` STRING COMMENT 'Detailed textual description providing context about the change request.',
    `downtime_required` BOOLEAN COMMENT 'Whether downtime is required',
    `estimated_downtime_minutes` STRING COMMENT 'Estimated downtime in minutes',
    `impact_assessment` STRING COMMENT 'Attribute capturing the impact assessment information for the change request entity.',
    `implementation_outcome` STRING COMMENT 'Attribute capturing the implementation outcome information for the change request entity.',
    `implementation_plan` STRING COMMENT 'Attribute capturing the implementation plan information for the change request entity.',
    `justification` STRING COMMENT 'Justification for the change',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this change request.',
    `post_implementation_notes` STRING COMMENT 'Post-implementation notes',
    `post_implementation_review_completed` BOOLEAN COMMENT 'Whether PIR was completed',
    `post_implementation_review_date` DATE COMMENT 'Date and time when the post implementation review event occurred for this change request.',
    `priority` STRING COMMENT 'Attribute capturing the priority information for the change request entity.',
    `requester_email` STRING COMMENT 'Requester email address',
    `requester_name` STRING COMMENT 'Human-readable name or label for the requester.',
    `risk_level` STRING COMMENT 'Attribute capturing the risk level information for the change request entity.',
    `rollback_plan` STRING COMMENT 'Attribute capturing the rollback plan information for the change request entity.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Scheduled end',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Scheduled start',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the submitted event occurred for this change request.',
    `test_plan` STRING COMMENT 'Attribute capturing the test plan information for the change request entity.',
    `title` STRING COMMENT 'Title of the change request',
    CONSTRAINT pk_change_request PRIMARY KEY(`change_request_id`)
) COMMENT 'Transactional record of formal IT change requests submitted for review and approval before implementation, covering system upgrades, configuration changes, platform migrations, network modifications, and security patches. Captures change type (standard, normal, emergency), risk assessment, change advisory board (CAB) approval status, rollback plan, implementation window, and post-implementation review outcome. Supports ITIL Change Management process.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`it_incident` (
    `it_incident_id` BIGINT COMMENT 'Unique identifier for the it incident record.',
    `caused_by_it_incident_id` BIGINT COMMENT 'Reference identifier linking to the associated caused by it incident entity.',
    `it_problem_id` BIGINT COMMENT 'Reference identifier linking to the associated it problem entity.',
    `it_service_id` BIGINT COMMENT 'Reference identifier linking to the associated it service entity.',
    `change_request_id` BIGINT COMMENT 'Reference identifier linking to the associated related change change request entity.',
    `system_platform_id` BIGINT COMMENT 'Reference identifier linking to the associated system platform entity.',
    `acknowledged_timestamp` TIMESTAMP COMMENT 'Date and time when the acknowledged event occurred for this it incident.',
    `affected_country_office` STRING COMMENT 'Attribute capturing the affected country office information for the it incident entity.',
    `affected_program` STRING COMMENT 'Attribute capturing the affected program information for the it incident entity.',
    `assigned_timestamp` TIMESTAMP COMMENT 'Date and time when the assigned event occurred for this it incident.',
    `assigned_to` STRING COMMENT 'Attribute capturing the assigned to information for the it incident entity.',
    `breach_notification_required` BOOLEAN COMMENT 'Attribute capturing the breach notification required information for the it incident entity.',
    `business_impact` STRING COMMENT 'Attribute capturing the business impact information for the it incident entity.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the closed event occurred for this it incident.',
    `communication_sent` BOOLEAN COMMENT 'Attribute capturing the communication sent information for the it incident entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this it incident.',
    `data_breach` BOOLEAN COMMENT 'Attribute capturing the data breach information for the it incident entity.',
    `detected_timestamp` TIMESTAMP COMMENT 'Date and time when the detected event occurred for this it incident.',
    `downtime_minutes` STRING COMMENT 'Attribute capturing the downtime minutes information for the it incident entity.',
    `escalated` BOOLEAN COMMENT 'Attribute capturing the escalated information for the it incident entity.',
    `escalation_level` STRING COMMENT 'Attribute capturing the escalation level information for the it incident entity.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the escalation event occurred for this it incident.',
    `financial_impact_usd` DECIMAL(18,2) COMMENT 'Attribute capturing the financial impact usd information for the it incident entity.',
    `impacted_user_count` STRING COMMENT 'Count or number of impacted user items associated with this record.',
    `incident_category` STRING COMMENT 'Attribute capturing the incident category information for the it incident entity.',
    `incident_number` STRING COMMENT 'Count or number of incident items associated with this record.',
    `incident_status` STRING COMMENT 'Current status indicator for the incident workflow state.',
    `incident_subcategory` STRING COMMENT 'Attribute capturing the incident subcategory information for the it incident entity.',
    `mean_time_to_resolution_minutes` STRING COMMENT 'Attribute capturing the mean time to resolution minutes information for the it incident entity.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this it incident.',
    `reported_by` STRING COMMENT 'Reference to the user or entity that performed the reported action.',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the reported event occurred for this it incident.',
    `resolution_description` STRING COMMENT 'Detailed textual description providing context about the resolution.',
    `resolved_timestamp` TIMESTAMP COMMENT 'Date and time when the resolved event occurred for this it incident.',
    `root_cause` STRING COMMENT 'Attribute capturing the root cause information for the it incident entity.',
    `root_cause_category` STRING COMMENT 'Attribute capturing the root cause category information for the it incident entity.',
    `security_incident` BOOLEAN COMMENT 'Attribute capturing the security incident information for the it incident entity.',
    `severity_level` STRING COMMENT 'Attribute capturing the severity level information for the it incident entity.',
    `user_satisfaction_rating` STRING COMMENT 'Attribute capturing the user satisfaction rating information for the it incident entity.',
    `vendor_ticket_number` STRING COMMENT 'Count or number of vendor ticket items associated with this record.',
    `workaround_applied` BOOLEAN COMMENT 'Attribute capturing the workaround applied information for the it incident entity.',
    `workaround_description` STRING COMMENT 'Detailed textual description providing context about the workaround.',
    CONSTRAINT pk_it_incident PRIMARY KEY(`it_incident_id`)
) COMMENT 'Transactional record of unplanned IT service disruptions and outages affecting NGO operations, including system downtime, network failures, data breaches, ransomware events, and platform unavailability. Captures incident category, severity level (P1–P4), affected systems, impacted country offices or programs, root cause analysis, mean time to resolution (MTTR), and escalation history. Distinct from service_request (which covers routine requests) — this captures unplanned disruptions.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`network_site` (
    `network_site_id` BIGINT COMMENT 'Unique identifier for the network site record.',
    `country_id` BIGINT COMMENT 'Reference identifier linking to the associated country entity.',
    `upstream_network_site_id` BIGINT COMMENT 'Reference identifier linking to the associated upstream network site entity.',
    `address` STRING COMMENT 'Attribute capturing the address information for the network site entity.',
    `backup_bandwidth_mbps` DECIMAL(18,2) COMMENT 'Attribute capturing the backup bandwidth mbps information for the network site entity.',
    `backup_connectivity_type` STRING COMMENT 'Classification type categorizing the backup connectivity for this record.',
    `bandwidth_capacity_mbps` DECIMAL(18,2) COMMENT 'Attribute capturing the bandwidth capacity mbps information for the network site entity.',
    `city` STRING COMMENT 'Attribute capturing the city information for the network site entity.',
    `compliance_certifications` STRING COMMENT 'Attribute capturing the compliance certifications information for the network site entity.',
    `connectivity_type` STRING COMMENT 'Classification type categorizing the connectivity for this record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this network site.',
    `decommission_date` DATE COMMENT 'Date and time when the decommission event occurred for this network site.',
    `disaster_recovery_tier` STRING COMMENT 'Attribute capturing the disaster recovery tier information for the network site entity.',
    `equipment_inventory` STRING COMMENT 'Attribute capturing the equipment inventory information for the network site entity.',
    `firewall_enabled` BOOLEAN COMMENT 'Attribute capturing the firewall enabled information for the network site entity.',
    `installation_date` DATE COMMENT 'Date and time when the installation event occurred for this network site.',
    `ip_address_range` STRING COMMENT 'Attribute capturing the ip address range information for the network site entity.',
    `isp_contract_number` STRING COMMENT 'Count or number of isp contract items associated with this record.',
    `isp_provider` STRING COMMENT 'Attribute capturing the isp provider information for the network site entity.',
    `last_maintenance_date` DATE COMMENT 'Date and time when the last maintenance event occurred for this network site.',
    `latitude` DECIMAL(18,2) COMMENT 'Attribute capturing the latitude information for the network site entity.',
    `longitude` DECIMAL(18,2) COMMENT 'Attribute capturing the longitude information for the network site entity.',
    `monthly_cost_usd` DECIMAL(18,2) COMMENT 'Attribute capturing the monthly cost usd information for the network site entity.',
    `network_administrator_email` STRING COMMENT 'Attribute capturing the network administrator email information for the network site entity.',
    `network_administrator_name` STRING COMMENT 'Human-readable name or label for the network administrator.',
    `network_administrator_phone` STRING COMMENT 'Attribute capturing the network administrator phone information for the network site entity.',
    `next_maintenance_date` DATE COMMENT 'Date and time when the next maintenance event occurred for this network site.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the network site entity.',
    `operational_status` DOUBLE COMMENT 'Current status indicator for the operational workflow state.',
    `postal_code` STRING COMMENT 'Standardized code representing the postal classification or category.',
    `region` STRING COMMENT 'Attribute capturing the region information for the network site entity.',
    `security_classification` STRING COMMENT 'Attribute capturing the security classification information for the network site entity.',
    `site_code` STRING COMMENT 'Standardized code representing the site classification or category.',
    `site_name` STRING COMMENT 'Human-readable name or label for the site.',
    `site_type` STRING COMMENT 'Classification type categorizing the site for this record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the updated event occurred for this network site.',
    `uptime_sla_percentage` DOUBLE COMMENT 'Attribute capturing the uptime sla percentage information for the network site entity.',
    `vlan_number` STRING COMMENT 'Count or number of vlan items associated with this record.',
    `vpn_enabled` BOOLEAN COMMENT 'Attribute capturing the vpn enabled information for the network site entity.',
    CONSTRAINT pk_network_site PRIMARY KEY(`network_site_id`)
) COMMENT 'Master record for each physical or logical network site in the NGOs connectivity infrastructure, including country office LANs, field site satellite/VSAT connections, HQ data center networks, and cloud VPN endpoints. Captures site name, location (country, region, GPS coordinates), connectivity type (fiber, VSAT, 4G/LTE, microwave), bandwidth capacity, ISP provider, uptime SLA, and network administrator responsible. SSOT for connectivity infrastructure topology.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` (
    `connectivity_log_id` BIGINT COMMENT 'Primary key',
    `country_office_id` BIGINT COMMENT 'FK to country office',
    `it_incident_id` BIGINT COMMENT 'FK to IT incident',
    `network_site_id` BIGINT COMMENT 'FK to network site',
    `previous_connectivity_log_id` BIGINT COMMENT 'Self-ref FK to previous log',
    `affected_users_count` STRING COMMENT 'Count or number of affected users items associated with this record.',
    `bandwidth_utilization_percent` DOUBLE COMMENT 'Attribute capturing the bandwidth utilization percent information for the connectivity log entity.',
    `business_impact_description` STRING COMMENT 'Detailed textual description providing context about the business impact.',
    `cause_classification` STRING COMMENT 'Attribute capturing the cause classification information for the connectivity log entity.',
    `cause_description` STRING COMMENT 'Detailed textual description providing context about the cause.',
    `connection_status` STRING COMMENT 'Current status indicator for the connection workflow state.',
    `connection_type` STRING COMMENT 'Classification type categorizing the connection for this record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this connectivity log.',
    `device_ip_address` STRING COMMENT 'Attribute capturing the device ip address information for the connectivity log entity.',
    `device_mac_address` STRING COMMENT 'Attribute capturing the device mac address information for the connectivity log entity.',
    `download_speed_mbps` DECIMAL(18,2) COMMENT 'Download speed',
    `isp_provider_name` STRING COMMENT 'Human-readable name or label for the isp provider.',
    `jitter_ms` DECIMAL(18,2) COMMENT 'Jitter in ms',
    `latency_ms` DECIMAL(18,2) COMMENT 'Latency in ms',
    `measurement_method` STRING COMMENT 'Attribute capturing the measurement method information for the connectivity log entity.',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the measurement event occurred for this connectivity log.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this connectivity log.',
    `monitoring_tool` STRING COMMENT 'Attribute capturing the monitoring tool information for the connectivity log entity.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the connectivity log entity.',
    `outage_duration_minutes` DOUBLE COMMENT 'Outage duration in minutes',
    `outage_end_timestamp` TIMESTAMP COMMENT 'Date and time when the outage end event occurred for this connectivity log.',
    `outage_start_timestamp` TIMESTAMP COMMENT 'Date and time when the outage start event occurred for this connectivity log.',
    `packet_loss_percent` DOUBLE COMMENT 'Attribute capturing the packet loss percent information for the connectivity log entity.',
    `priority_level` STRING COMMENT 'Attribute capturing the priority level information for the connectivity log entity.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the resolution event occurred for this connectivity log.',
    `signal_strength_dbm` DECIMAL(18,2) COMMENT 'Signal strength in dBm',
    `sla_compliant_flag` BOOLEAN COMMENT 'Whether SLA compliant',
    `sla_target_uptime_percent` DOUBLE COMMENT 'Attribute capturing the sla target uptime percent information for the connectivity log entity.',
    `upload_speed_mbps` DECIMAL(18,2) COMMENT 'Upload speed',
    CONSTRAINT pk_connectivity_log PRIMARY KEY(`connectivity_log_id`)
) COMMENT 'Transactional record of network connectivity events and uptime/downtime measurements for each network site. Captures measurement timestamp, site reference, connection status (up/down/degraded), latency (ms), bandwidth utilization (%), packet loss percentage, outage duration, and cause classification (ISP fault, power outage, equipment failure, weather). Enables SLA compliance tracking and field connectivity reporting for humanitarian operations.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`user_account` (
    `user_account_id` BIGINT COMMENT 'Unique identifier for the user account record.',
    `parent_user_account_id` BIGINT COMMENT 'Reference identifier linking to the associated parent user account entity.',
    `partner_org_id` BIGINT COMMENT 'Reference identifier linking to the associated partner org entity.',
    `system_platform_id` BIGINT COMMENT 'Reference identifier linking to the associated primary system platform entity.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated staff member entity.',
    `access_level` STRING COMMENT 'Attribute capturing the access level information for the user account entity.',
    `account_locked_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the account locked condition applies.',
    `account_locked_timestamp` TIMESTAMP COMMENT 'Date and time when the account locked event occurred for this user account.',
    `account_status` STRING COMMENT 'Current status indicator for the account workflow state.',
    `account_type` STRING COMMENT 'Classification type categorizing the account for this record.',
    `activation_date` DATE COMMENT 'Date and time when the activation event occurred for this user account.',
    `active_directory_guid` STRING COMMENT 'Attribute capturing the active directory guid information for the user account entity.',
    `beneficiary_data_access_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the beneficiary data access condition applies.',
    `commcare_username` STRING COMMENT 'Attribute capturing the commcare username information for the user account entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this user account.',
    `data_protection_acknowledgment_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the data protection acknowledgment condition applies.',
    `deprovisioning_date` DATE COMMENT 'Date and time when the deprovisioning event occurred for this user account.',
    `deprovisioning_reason` STRING COMMENT 'Attribute capturing the deprovisioning reason information for the user account entity.',
    `dhis2_username` STRING COMMENT 'Attribute capturing the dhis2 username information for the user account entity.',
    `donor_data_access_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the donor data access condition applies.',
    `email_address` STRING COMMENT 'Attribute capturing the email address information for the user account entity.',
    `failed_login_attempts` TIMESTAMP COMMENT 'Attribute capturing the failed login attempts information for the user account entity.',
    `field_access_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the field access condition applies.',
    `financial_system_access_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the financial system access condition applies.',
    `kobotoolbox_username` STRING COMMENT 'Attribute capturing the kobotoolbox username information for the user account entity.',
    `last_login_timestamp` TIMESTAMP COMMENT 'Date and time when the last login event occurred for this user account.',
    `last_password_change_date` DATE COMMENT 'Date and time when the last password change event occurred for this user account.',
    `mfa_enrolled_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the mfa enrolled condition applies.',
    `mfa_method` STRING COMMENT 'Attribute capturing the mfa method information for the user account entity.',
    `mobile_device_registered_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the mobile device registered condition applies.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this user account.',
    `password_expiry_date` DATE COMMENT 'Date and time when the password expiry event occurred for this user account.',
    `privileged_account_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the privileged account condition applies.',
    `provisioning_date` DATE COMMENT 'Date and time when the provisioning event occurred for this user account.',
    `remote_access_enabled_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the remote access enabled condition applies.',
    `salesforce_user_code` STRING COMMENT 'Standardized code representing the salesforce user classification or category.',
    `sap_user_code` STRING COMMENT 'Standardized code representing the sap user classification or category.',
    `security_training_completion_date` DATE COMMENT 'Date and time when the security training completion event occurred for this user account.',
    `suspension_date` DATE COMMENT 'Date and time when the suspension event occurred for this user account.',
    `suspension_reason` STRING COMMENT 'Attribute capturing the suspension reason information for the user account entity.',
    `username` STRING COMMENT 'Attribute capturing the username information for the user account entity.',
    `workday_user_code` STRING COMMENT 'Standardized code representing the workday user classification or category.',
    CONSTRAINT pk_user_account PRIMARY KEY(`user_account_id`)
) COMMENT 'Master record for every digital identity and system access account provisioned for NGO staff, volunteers, and authorized partner users across all platforms (Active Directory, Salesforce, SAP, KoboToolbox, CommCare, DHIS2, email). Captures username, account type, associated staff or volunteer identity, provisioning date, last login, account status (active, suspended, deprovisioned), and multi-factor authentication (MFA) enrollment status. SSOT for digital identity management — distinct from workforce.staff_member (which owns HR identity).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`access_role` (
    `access_role_id` BIGINT COMMENT 'Primary key',
    `parent_access_role_id` BIGINT COMMENT 'Self-ref FK to parent role',
    `system_platform_id` BIGINT COMMENT 'FK to system platform',
    `access_scope` STRING COMMENT 'Attribute capturing the access scope information for the access role entity.',
    `active_user_count` STRING COMMENT 'Count or number of active user items associated with this record.',
    `approval_authority_name` STRING COMMENT 'Human-readable name or label for the approval authority.',
    `approval_authority_title` STRING COMMENT 'Attribute capturing the approval authority title information for the access role entity.',
    `approved_by` STRING COMMENT 'Reference to the user or entity that performed the approved action.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the approved event occurred for this access role.',
    `audit_logging_required` BOOLEAN COMMENT 'Whether audit logging is required',
    `business_justification` STRING COMMENT 'Attribute capturing the business justification information for the access role entity.',
    `compliance_framework` STRING COMMENT 'Attribute capturing the compliance framework information for the access role entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this access role.',
    `data_classification_level` STRING COMMENT 'Attribute capturing the data classification level information for the access role entity.',
    `data_domain_access` STRING COMMENT 'Attribute capturing the data domain access information for the access role entity.',
    `effective_end_date` DATE COMMENT 'Date and time when the effective end event occurred for this access role.',
    `effective_start_date` DATE COMMENT 'Date and time when the effective start event occurred for this access role.',
    `last_recertification_date` DATE COMMENT 'Date and time when the last recertification event occurred for this access role.',
    `least_privilege_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the least privilege condition applies.',
    `modified_by` STRING COMMENT 'Reference to the user or entity that performed the modified action.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this access role.',
    `module_access` STRING COMMENT 'Attribute capturing the module access information for the access role entity.',
    `multi_factor_authentication_required` BOOLEAN COMMENT 'MFA required',
    `next_recertification_date` DATE COMMENT 'Date and time when the next recertification event occurred for this access role.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the access role entity.',
    `permission_scope` STRING COMMENT 'Attribute capturing the permission scope information for the access role entity.',
    `privileged_access_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the privileged access condition applies.',
    `recertification_frequency_days` STRING COMMENT 'Recertification frequency in days',
    `risk_level` STRING COMMENT 'Attribute capturing the risk level information for the access role entity.',
    `role_code` STRING COMMENT 'Standardized code representing the role classification or category.',
    `role_description` STRING COMMENT 'Detailed textual description providing context about the role.',
    `role_name` STRING COMMENT 'Human-readable name or label for the role.',
    `role_owner_email` STRING COMMENT 'Attribute capturing the role owner email information for the access role entity.',
    `role_owner_name` STRING COMMENT 'Human-readable name or label for the role owner.',
    `role_status` STRING COMMENT 'Current status indicator for the role workflow state.',
    `role_type` STRING COMMENT 'Classification type categorizing the role for this record.',
    `segregation_of_duties_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the segregation of duties condition applies.',
    `created_by` STRING COMMENT 'Reference to the user or entity that performed the created action.',
    CONSTRAINT pk_access_role PRIMARY KEY(`access_role_id`)
) COMMENT 'Master catalog of role-based access control (RBAC) roles and permission profiles defined across all NGO platforms and systems. Captures role name, associated system platform, permission scope (read/write/admin), data classification level accessible (public/internal/confidential/restricted), role owner, and approval authority. Enables least-privilege access governance and audit-ready access control documentation.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` (
    `access_provisioning_id` BIGINT COMMENT 'Primary key',
    `access_role_id` BIGINT COMMENT 'FK to access role',
    `staff_member_id` BIGINT COMMENT 'FK to approver staff member',
    `award_id` BIGINT COMMENT 'FK to award',
    `primary_access_staff_member_id` BIGINT COMMENT 'FK to primary access staff member',
    `user_account_id` BIGINT COMMENT 'FK to primary user account',
    `superseded_access_provisioning_id` BIGINT COMMENT 'Self-ref FK to superseded provisioning',
    `system_platform_id` BIGINT COMMENT 'FK to system platform',
    `target_user_user_account_id` BIGINT COMMENT 'FK to target user account',
    `tertiary_access_compliance_signoff_by_staff_member_id` BIGINT COMMENT 'FK to compliance signoff staff',
    `access_duration_days` DOUBLE COMMENT 'Access duration in days',
    `access_level` STRING COMMENT 'Attribute capturing the access level information for the access provisioning entity.',
    `access_review_due_date` DATE COMMENT 'Date and time when the access review due event occurred for this access provisioning.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the approval event occurred for this access provisioning.',
    `beneficiary_data_access_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the beneficiary data access condition applies.',
    `business_justification` STRING COMMENT 'Attribute capturing the business justification information for the access provisioning entity.',
    `compliance_signoff_required_flag` BOOLEAN COMMENT 'Compliance signoff required',
    `compliance_signoff_timestamp` TIMESTAMP COMMENT 'Date and time when the compliance signoff event occurred for this access provisioning.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this access provisioning.',
    `data_classification_access_level` STRING COMMENT 'Attribute capturing the data classification access level information for the access provisioning entity.',
    `deprovisioning_reason` STRING COMMENT 'Attribute capturing the deprovisioning reason information for the access provisioning entity.',
    `donor_audit_requirement_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the donor audit requirement condition applies.',
    `effective_end_date` DATE COMMENT 'Date and time when the effective end event occurred for this access provisioning.',
    `effective_start_date` DATE COMMENT 'Date and time when the effective start event occurred for this access provisioning.',
    `financial_data_access_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the financial data access condition applies.',
    `jml_lifecycle_stage` STRING COMMENT 'Attribute capturing the jml lifecycle stage information for the access provisioning entity.',
    `last_access_review_date` DATE COMMENT 'Date and time when the last access review event occurred for this access provisioning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the last modified event occurred for this access provisioning.',
    `multi_factor_authentication_required_flag` BOOLEAN COMMENT 'MFA required flag',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the access provisioning entity.',
    `provisioning_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the provisioning completed event occurred for this access provisioning.',
    `remote_access_permitted_flag` BOOLEAN COMMENT 'Remote access permitted',
    `request_number` STRING COMMENT 'Count or number of request items associated with this record.',
    `request_status` STRING COMMENT 'Current status indicator for the request workflow state.',
    `request_submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the request submitted event occurred for this access provisioning.',
    `request_type` STRING COMMENT 'Classification type categorizing the request for this record.',
    `security_incident_reference` STRING COMMENT 'Attribute capturing the security incident reference information for the access provisioning entity.',
    `target_system_environment` STRING COMMENT 'Attribute capturing the target system environment information for the access provisioning entity.',
    `target_user_email` STRING COMMENT 'Attribute capturing the target user email information for the access provisioning entity.',
    CONSTRAINT pk_access_provisioning PRIMARY KEY(`access_provisioning_id`)
) COMMENT 'Transactional record of every user access provisioning, modification, and deprovisioning event across all NGO systems and platforms. Captures request type (grant, modify, revoke), requesting manager, approver, target system platform, access role assigned, justification, effective date, and compliance sign-off. Supports joiner-mover-leaver (JML) lifecycle governance and donor audit requirements for data access controls.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`security_control` (
    `security_control_id` BIGINT COMMENT 'Unique identifier for the security control record.',
    `psea_policy_id` BIGINT COMMENT 'Reference identifier linking to the associated enforced psea policy entity.',
    `parent_security_control_id` BIGINT COMMENT 'Reference identifier linking to the associated parent security control entity.',
    `system_platform_id` BIGINT COMMENT 'Reference identifier linking to the associated primary system platform entity.',
    `active_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the active condition applies.',
    `annual_maintenance_cost` DECIMAL(18,2) COMMENT 'Attribute capturing the annual maintenance cost information for the security control entity.',
    `applicable_data_classification` STRING COMMENT 'Attribute capturing the applicable data classification information for the security control entity.',
    `applicable_systems` STRING COMMENT 'Attribute capturing the applicable systems information for the security control entity.',
    `audit_trail_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the audit trail required condition applies.',
    `automation_level` STRING COMMENT 'Attribute capturing the automation level information for the security control entity.',
    `compensating_control_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the compensating control condition applies.',
    `compliance_mandatory_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the compliance mandatory condition applies.',
    `control_description` STRING COMMENT 'Detailed textual description providing context about the control.',
    `control_domain` STRING COMMENT 'Attribute capturing the control domain information for the security control entity.',
    `control_identifier` STRING COMMENT 'Attribute capturing the control identifier information for the security control entity.',
    `control_name` STRING COMMENT 'Human-readable name or label for the control.',
    `control_objective` STRING COMMENT 'Attribute capturing the control objective information for the security control entity.',
    `control_owner` STRING COMMENT 'Attribute capturing the control owner information for the security control entity.',
    `control_owner_department` STRING COMMENT 'Attribute capturing the control owner department information for the security control entity.',
    `control_type` STRING COMMENT 'Classification type categorizing the control for this record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this security control.',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `effectiveness_rating` STRING COMMENT 'Attribute capturing the effectiveness rating information for the security control entity.',
    `evidence_location` STRING COMMENT 'Attribute capturing the evidence location information for the security control entity.',
    `exception_expiry_date` DATE COMMENT 'Date and time when the exception expiry event occurred for this security control.',
    `exception_granted_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the exception granted condition applies.',
    `exception_justification` STRING COMMENT 'Attribute capturing the exception justification information for the security control entity.',
    `framework_mapping` STRING COMMENT 'Attribute capturing the framework mapping information for the security control entity.',
    `implementation_cost` DECIMAL(18,2) COMMENT 'Attribute capturing the implementation cost information for the security control entity.',
    `implementation_date` DATE COMMENT 'Date and time when the implementation event occurred for this security control.',
    `implementation_guidance` STRING COMMENT 'Attribute capturing the implementation guidance information for the security control entity.',
    `implementation_status` STRING COMMENT 'Current status indicator for the implementation workflow state.',
    `last_assessment_date` DATE COMMENT 'Date and time when the last assessment event occurred for this security control.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the last modified event occurred for this security control.',
    `maturity_level` STRING COMMENT 'Attribute capturing the maturity level information for the security control entity.',
    `modified_by` STRING COMMENT 'Reference to the user or entity that performed the modified action.',
    `next_assessment_date` DATE COMMENT 'Date and time when the next assessment event occurred for this security control.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the security control entity.',
    `related_policy_reference` STRING COMMENT 'Attribute capturing the related policy reference information for the security control entity.',
    `remediation_due_date` DATE COMMENT 'Date and time when the remediation due event occurred for this security control.',
    `remediation_plan` STRING COMMENT 'Attribute capturing the remediation plan information for the security control entity.',
    `risk_rating` STRING COMMENT 'Attribute capturing the risk rating information for the security control entity.',
    `testing_frequency` STRING COMMENT 'Attribute capturing the testing frequency information for the security control entity.',
    `vendor_solution` STRING COMMENT 'Attribute capturing the vendor solution information for the security control entity.',
    CONSTRAINT pk_security_control PRIMARY KEY(`security_control_id`)
) COMMENT 'Master catalog of information security controls implemented across the NGOs technology environment, mapped to frameworks such as ISO 27001, NIST CSF, and CIS Controls. Captures control ID, control domain (access management, encryption, vulnerability management, incident response), implementation status, control owner, last assessment date, and effectiveness rating. Supports cybersecurity governance and donor audit readiness.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`security_assessment` (
    `security_assessment_id` BIGINT COMMENT 'Unique identifier for the security assessment record.',
    `award_id` BIGINT COMMENT 'Reference identifier linking to the associated award entity.',
    `followup_security_assessment_id` BIGINT COMMENT 'Reference identifier linking to the associated followup security assessment entity.',
    `system_platform_id` BIGINT COMMENT 'Reference identifier linking to the associated system platform entity.',
    `assessment_cost` DECIMAL(18,2) COMMENT 'Attribute capturing the assessment cost information for the security assessment entity.',
    `assessment_date` DATE COMMENT 'Date and time when the assessment event occurred for this security assessment.',
    `assessment_end_date` DATE COMMENT 'Date and time when the assessment end event occurred for this security assessment.',
    `assessment_frequency` STRING COMMENT 'Attribute capturing the assessment frequency information for the security assessment entity.',
    `assessment_number` STRING COMMENT 'Count or number of assessment items associated with this record.',
    `assessment_scope` STRING COMMENT 'Attribute capturing the assessment scope information for the security assessment entity.',
    `assessment_start_date` DATE COMMENT 'Date and time when the assessment start event occurred for this security assessment.',
    `assessment_status` STRING COMMENT 'Current status indicator for the assessment workflow state.',
    `assessment_type` STRING COMMENT 'Classification type categorizing the assessment for this record.',
    `assessor_certification` STRING COMMENT 'Attribute capturing the assessor certification information for the security assessment entity.',
    `assessor_name` STRING COMMENT 'Human-readable name or label for the assessor.',
    `beneficiary_data_at_risk` TIMESTAMP COMMENT 'Attribute capturing the beneficiary data at risk information for the security assessment entity.',
    `compliance_status` STRING COMMENT 'Current status indicator for the compliance workflow state.',
    `conducting_entity_name` STRING COMMENT 'Human-readable name or label for the conducting entity.',
    `conducting_entity_type` STRING COMMENT 'Classification type categorizing the conducting entity for this record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this security assessment.',
    `critical_findings_count` STRING COMMENT 'Count or number of critical findings items associated with this record.',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `data_classification_assessed` STRING COMMENT 'Attribute capturing the data classification assessed information for the security assessment entity.',
    `donor_reporting_required` BOOLEAN COMMENT 'Attribute capturing the donor reporting required information for the security assessment entity.',
    `executive_summary` STRING COMMENT 'Attribute capturing the executive summary information for the security assessment entity.',
    `high_findings_count` STRING COMMENT 'Count or number of high findings items associated with this record.',
    `key_recommendations` STRING COMMENT 'Attribute capturing the key recommendations information for the security assessment entity.',
    `low_findings_count` STRING COMMENT 'Count or number of low findings items associated with this record.',
    `medium_findings_count` STRING COMMENT 'Count or number of medium findings items associated with this record.',
    `methodology_used` STRING COMMENT 'Attribute capturing the methodology used information for the security assessment entity.',
    `modified_by` STRING COMMENT 'Reference to the user or entity that performed the modified action.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this security assessment.',
    `next_assessment_due_date` DATE COMMENT 'Date and time when the next assessment due event occurred for this security assessment.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the security assessment entity.',
    `overall_risk_rating` STRING COMMENT 'Attribute capturing the overall risk rating information for the security assessment entity.',
    `remediation_deadline` DATE COMMENT 'Attribute capturing the remediation deadline information for the security assessment entity.',
    `remediation_status` STRING COMMENT 'Current status indicator for the remediation workflow state.',
    `report_document_reference` STRING COMMENT 'Attribute capturing the report document reference information for the security assessment entity.',
    `report_issued_date` DATE COMMENT 'Date and time when the report issued event occurred for this security assessment.',
    `tools_used` STRING COMMENT 'Attribute capturing the tools used information for the security assessment entity.',
    `total_findings_count` STRING COMMENT 'Count or number of total findings items associated with this record.',
    `created_by` STRING COMMENT 'Reference to the user or entity that performed the created action.',
    CONSTRAINT pk_security_assessment PRIMARY KEY(`security_assessment_id`)
) COMMENT 'Transactional record of formal information security assessments, vulnerability scans, penetration tests, and cybersecurity audits conducted on NGO systems and infrastructure. Captures assessment type (penetration test, vulnerability scan, ISMS audit, third-party review), scope, conducting entity (internal/external), assessment date, findings count by severity (critical/high/medium/low), overall risk rating, and remediation deadline. Distinct from it_incident (which captures actual breaches).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`vulnerability` (
    `vulnerability_id` BIGINT COMMENT 'Unique identifier for the vulnerability record.',
    `it_asset_id` BIGINT COMMENT 'Reference identifier linking to the associated it asset entity.',
    `parent_vulnerability_id` BIGINT COMMENT 'Reference identifier linking to the associated parent vulnerability entity.',
    `it_incident_id` BIGINT COMMENT 'Reference identifier linking to the associated related incident it incident entity.',
    `system_platform_id` BIGINT COMMENT 'Reference identifier linking to the associated system platform entity.',
    `actual_remediation_date` DATE COMMENT 'Date and time when the actual remediation event occurred for this vulnerability.',
    `affected_component` STRING COMMENT 'Attribute capturing the affected component information for the vulnerability entity.',
    `affected_data_classification` STRING COMMENT 'Attribute capturing the affected data classification information for the vulnerability entity.',
    `affected_version` STRING COMMENT 'Attribute capturing the affected version information for the vulnerability entity.',
    `business_impact` STRING COMMENT 'Attribute capturing the business impact information for the vulnerability entity.',
    `compliance_impact` STRING COMMENT 'Attribute capturing the compliance impact information for the vulnerability entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this vulnerability.',
    `cve_identifier` STRING COMMENT 'Attribute capturing the cve identifier information for the vulnerability entity.',
    `cvss_score` DOUBLE COMMENT 'Attribute capturing the cvss score information for the vulnerability entity.',
    `cvss_vector` STRING COMMENT 'Attribute capturing the cvss vector information for the vulnerability entity.',
    `vulnerability_description` STRING COMMENT 'Detailed textual description providing context about the vulnerability.',
    `discovery_date` DATE COMMENT 'Date and time when the discovery event occurred for this vulnerability.',
    `discovery_method` STRING COMMENT 'Attribute capturing the discovery method information for the vulnerability entity.',
    `exploitability_status` STRING COMMENT 'Current status indicator for the exploitability workflow state.',
    `modified_by` STRING COMMENT 'Reference to the user or entity that performed the modified action.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this vulnerability.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the vulnerability entity.',
    `patch_available` BOOLEAN COMMENT 'Attribute capturing the patch available information for the vulnerability entity.',
    `patch_identifier` STRING COMMENT 'Attribute capturing the patch identifier information for the vulnerability entity.',
    `reference_urls` STRING COMMENT 'Attribute capturing the reference urls information for the vulnerability entity.',
    `remediation_owner` STRING COMMENT 'Attribute capturing the remediation owner information for the vulnerability entity.',
    `remediation_plan` STRING COMMENT 'Attribute capturing the remediation plan information for the vulnerability entity.',
    `reported_by` STRING COMMENT 'Reference to the user or entity that performed the reported action.',
    `risk_level` STRING COMMENT 'Attribute capturing the risk level information for the vulnerability entity.',
    `severity_rating` STRING COMMENT 'Attribute capturing the severity rating information for the vulnerability entity.',
    `target_remediation_date` DATE COMMENT 'Date and time when the target remediation event occurred for this vulnerability.',
    `title` STRING COMMENT 'Attribute capturing the title information for the vulnerability entity.',
    `vendor_advisory_url` STRING COMMENT 'Attribute capturing the vendor advisory url information for the vulnerability entity.',
    `verification_date` DATE COMMENT 'Date and time when the verification event occurred for this vulnerability.',
    `verification_status` STRING COMMENT 'Current status indicator for the verification workflow state.',
    `verified_by` STRING COMMENT 'Reference to the user or entity that performed the verified action.',
    `vulnerability_status` STRING COMMENT 'Current status indicator for the vulnerability workflow state.',
    `vulnerability_type` STRING COMMENT 'Classification type categorizing the vulnerability for this record.',
    `workaround_available` BOOLEAN COMMENT 'Attribute capturing the workaround available information for the vulnerability entity.',
    `workaround_description` STRING COMMENT 'Detailed textual description providing context about the workaround.',
    `created_by` STRING COMMENT 'Reference to the user or entity that performed the created action.',
    CONSTRAINT pk_vulnerability PRIMARY KEY(`vulnerability_id`)
) COMMENT 'Master record of identified cybersecurity vulnerabilities and weaknesses in NGO systems, applications, and infrastructure. Captures CVE identifier, affected system or asset, vulnerability severity (CVSS score), discovery method (scan, pen test, vendor advisory), discovery date, remediation status, assigned remediation owner, target remediation date, and actual closure date. Enables vulnerability lifecycle management and risk prioritization.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`software_license` (
    `software_license_id` BIGINT COMMENT 'Unique identifier for the software license record.',
    `award_id` BIGINT COMMENT 'Reference identifier linking to the associated award entity.',
    `system_platform_id` BIGINT COMMENT 'Reference identifier linking to the associated system platform entity.',
    `upgraded_from_software_license_id` BIGINT COMMENT 'Reference identifier linking to the associated upgraded from software license entity.',
    `annual_cost` DECIMAL(18,2) COMMENT 'Attribute capturing the annual cost information for the software license entity.',
    `auto_renewal_enabled` BOOLEAN COMMENT 'Attribute capturing the auto renewal enabled information for the software license entity.',
    `compliance_frameworks` STRING COMMENT 'Attribute capturing the compliance frameworks information for the software license entity.',
    `compliance_status` STRING COMMENT 'Current status indicator for the compliance workflow state.',
    `contract_reference` STRING COMMENT 'Attribute capturing the contract reference information for the software license entity.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Standardized code representing the cost center classification or category.',
    `cost_per_seat` DECIMAL(18,2) COMMENT 'Attribute capturing the cost per seat information for the software license entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this software license.',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `data_classification_level` STRING COMMENT 'Attribute capturing the data classification level information for the software license entity.',
    `deployment_type` STRING COMMENT 'Classification type categorizing the deployment for this record.',
    `disaster_recovery_tier` STRING COMMENT 'Attribute capturing the disaster recovery tier information for the software license entity.',
    `effective_start_date` DATE COMMENT 'Date and time when the effective start event occurred for this software license.',
    `expiration_date` DATE COMMENT 'Date and time when the expiration event occurred for this software license.',
    `is_mission_critical` BOOLEAN COMMENT 'Boolean indicator specifying whether the record mission critical.',
    `last_audit_date` DATE COMMENT 'Date and time when the last audit event occurred for this software license.',
    `license_number` STRING COMMENT 'Count or number of license items associated with this record.',
    `license_owner_email` STRING COMMENT 'Attribute capturing the license owner email information for the software license entity.',
    `license_owner_name` STRING COMMENT 'Human-readable name or label for the license owner.',
    `license_status` STRING COMMENT 'Current status indicator for the license workflow state.',
    `license_type` STRING COMMENT 'Classification type categorizing the license for this record.',
    `modified_by` STRING COMMENT 'Reference to the user or entity that performed the modified action.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this software license.',
    `next_audit_date` DATE COMMENT 'Date and time when the next audit event occurred for this software license.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the software license entity.',
    `payment_frequency` DECIMAL(18,2) COMMENT 'Attribute capturing the payment frequency information for the software license entity.',
    `primary_business_domain` STRING COMMENT 'Attribute capturing the primary business domain information for the software license entity.',
    `product_name` STRING COMMENT 'Human-readable name or label for the product.',
    `product_version` STRING COMMENT 'Attribute capturing the product version information for the software license entity.',
    `purchase_date` DATE COMMENT 'Date and time when the purchase event occurred for this software license.',
    `purchase_order_number` STRING COMMENT 'Count or number of purchase order items associated with this record.',
    `renewal_date` DATE COMMENT 'Date and time when the renewal event occurred for this software license.',
    `seats_available` STRING COMMENT 'Attribute capturing the seats available information for the software license entity.',
    `seats_consumed` STRING COMMENT 'Attribute capturing the seats consumed information for the software license entity.',
    `support_tier` STRING COMMENT 'Attribute capturing the support tier information for the software license entity.',
    `technical_contact_email` STRING COMMENT 'Attribute capturing the technical contact email information for the software license entity.',
    `technical_contact_name` STRING COMMENT 'Human-readable name or label for the technical contact.',
    `total_seats_purchased` STRING COMMENT 'Attribute capturing the total seats purchased information for the software license entity.',
    `vendor_account_number` STRING COMMENT 'Count or number of vendor account items associated with this record.',
    `vendor_name` STRING COMMENT 'Human-readable name or label for the vendor.',
    `created_by` STRING COMMENT 'Reference to the user or entity that performed the created action.',
    CONSTRAINT pk_software_license PRIMARY KEY(`software_license_id`)
) COMMENT 'Master record for all software licenses and SaaS subscriptions managed by the NGO, including Microsoft 365, Salesforce, SAP, KoboToolbox, CommCare, DHIS2, and security tools. Captures license type (perpetual, subscription, concurrent, named user), vendor, product name, total seats purchased, seats consumed, license key or agreement reference, renewal date, annual cost, and cost center allocation. Enables license compliance and renewal management.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`it_project` (
    `it_project_id` BIGINT COMMENT 'Unique identifier for the it project record.',
    `award_id` BIGINT COMMENT 'Reference identifier linking to the associated award entity.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated it staff member entity.',
    `parent_it_project_id` BIGINT COMMENT 'Reference identifier linking to the associated parent it project entity.',
    `primary_it_staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated primary it staff member entity.',
    `system_platform_id` BIGINT COMMENT 'Reference identifier linking to the associated primary system platform entity.',
    `tertiary_it_business_sponsor_staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated tertiary it business sponsor staff member entity.',
    `tertiary_it_staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated tertiary it staff member entity.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Attribute capturing the actual cost information for the it project entity.',
    `actual_end_date` DATE COMMENT 'Date and time when the actual end event occurred for this it project.',
    `actual_start_date` DATE COMMENT 'Date and time when the actual start event occurred for this it project.',
    `affected_systems` STRING COMMENT 'Attribute capturing the affected systems information for the it project entity.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the budget quantity or measurement.',
    `business_justification` STRING COMMENT 'Attribute capturing the business justification information for the it project entity.',
    `compliance_frameworks` STRING COMMENT 'Attribute capturing the compliance frameworks information for the it project entity.',
    `contract_reference` STRING COMMENT 'Attribute capturing the contract reference information for the it project entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this it project.',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `data_classification_level` STRING COMMENT 'Attribute capturing the data classification level information for the it project entity.',
    `delivery_methodology` STRING COMMENT 'Attribute capturing the delivery methodology information for the it project entity.',
    `it_project_description` STRING COMMENT 'Detailed textual description providing context about the it project.',
    `forecast_end_date` DATE COMMENT 'Date and time when the forecast end event occurred for this it project.',
    `funding_source` DECIMAL(18,2) COMMENT 'Attribute capturing the funding source information for the it project entity.',
    `go_live_date` DATE COMMENT 'Date and time when the go live event occurred for this it project.',
    `health_status` STRING COMMENT 'Current status indicator for the health workflow state.',
    `integration_count` DOUBLE COMMENT 'Count or number of integration items associated with this record.',
    `lessons_learned` STRING COMMENT 'Attribute capturing the lessons learned information for the it project entity.',
    `milestone_status` STRING COMMENT 'Current status indicator for the milestone workflow state.',
    `modified_by` STRING COMMENT 'Reference to the user or entity that performed the modified action.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this it project.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the it project entity.',
    `percent_complete` DOUBLE COMMENT 'Attribute capturing the percent complete information for the it project entity.',
    `planned_end_date` DATE COMMENT 'Date and time when the planned end event occurred for this it project.',
    `planned_start_date` DATE COMMENT 'Date and time when the planned start event occurred for this it project.',
    `priority` STRING COMMENT 'Attribute capturing the priority information for the it project entity.',
    `project_category` STRING COMMENT 'Attribute capturing the project category information for the it project entity.',
    `project_code` STRING COMMENT 'Standardized code representing the project classification or category.',
    `project_manager_name` STRING COMMENT 'Human-readable name or label for the project manager.',
    `project_name` STRING COMMENT 'Human-readable name or label for the project.',
    `project_phase` STRING COMMENT 'Attribute capturing the project phase information for the it project entity.',
    `project_priority` STRING COMMENT 'Attribute capturing the project priority information for the it project entity.',
    `project_sponsor_name` STRING COMMENT 'Human-readable name or label for the project sponsor.',
    `project_status` STRING COMMENT 'Current status indicator for the project workflow state.',
    `project_type` STRING COMMENT 'Classification type categorizing the project for this record.',
    `risk_level` STRING COMMENT 'Attribute capturing the risk level information for the it project entity.',
    `risk_summary` STRING COMMENT 'Attribute capturing the risk summary information for the it project entity.',
    `sponsoring_domain` STRING COMMENT 'Attribute capturing the sponsoring domain information for the it project entity.',
    `success_criteria` STRING COMMENT 'Attribute capturing the success criteria information for the it project entity.',
    `user_count` STRING COMMENT 'Count or number of user items associated with this record.',
    `vendor_name` STRING COMMENT 'Human-readable name or label for the vendor.',
    `created_by` STRING COMMENT 'Reference to the user or entity that performed the created action.',
    CONSTRAINT pk_it_project PRIMARY KEY(`it_project_id`)
) COMMENT 'Master record for technology projects and digital transformation initiatives managed by the IT department, including system implementations, platform migrations, infrastructure upgrades, and data governance programs. Captures project name, project type, sponsoring business domain, project manager, budget envelope, start date, planned end date, actual end date, milestone status, and delivery methodology (Agile/Waterfall). Distinct from program.intervention (which owns humanitarian program projects).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`platform_integration` (
    `platform_integration_id` BIGINT COMMENT 'Unique identifier for the platform integration record.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated owner staff member entity.',
    `primary_platform_staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated primary platform staff member entity.',
    `replaced_platform_integration_id` BIGINT COMMENT 'Reference identifier linking to the associated replaced platform integration entity.',
    `system_platform_id` BIGINT COMMENT 'Reference identifier linking to the associated source system platform entity.',
    `target_system_platform_id` BIGINT COMMENT 'Reference identifier linking to the associated target system platform entity.',
    `authentication_method` STRING COMMENT 'Attribute capturing the authentication method information for the platform integration entity.',
    `compliance_frameworks` STRING COMMENT 'Attribute capturing the compliance frameworks information for the platform integration entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this platform integration.',
    `data_classification_level` STRING COMMENT 'Attribute capturing the data classification level information for the platform integration entity.',
    `data_direction` STRING COMMENT 'Attribute capturing the data direction information for the platform integration entity.',
    `data_domain` STRING COMMENT 'Attribute capturing the data domain information for the platform integration entity.',
    `data_entity` STRING COMMENT 'Attribute capturing the data entity information for the platform integration entity.',
    `data_format` STRING COMMENT 'Attribute capturing the data format information for the platform integration entity.',
    `data_transformation_required` BOOLEAN COMMENT 'Attribute capturing the data transformation required information for the platform integration entity.',
    `decommission_date` DATE COMMENT 'Date and time when the decommission event occurred for this platform integration.',
    `documentation_url` STRING COMMENT 'Attribute capturing the documentation url information for the platform integration entity.',
    `encryption_enabled` BOOLEAN COMMENT 'Attribute capturing the encryption enabled information for the platform integration entity.',
    `encryption_in_transit_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the encryption in transit condition applies.',
    `encryption_protocol` STRING COMMENT 'Attribute capturing the encryption protocol information for the platform integration entity.',
    `error_handling_approach` STRING COMMENT 'Attribute capturing the error handling approach information for the platform integration entity.',
    `error_handling_strategy` DOUBLE COMMENT 'Attribute capturing the error handling strategy information for the platform integration entity.',
    `go_live_date` DATE COMMENT 'Date and time when the go live event occurred for this platform integration.',
    `integration_code` DOUBLE COMMENT 'Standardized code representing the integration classification or category.',
    `integration_description` STRING COMMENT 'Detailed textual description providing context about the integration.',
    `integration_name` DOUBLE COMMENT 'Human-readable name or label for the integration.',
    `integration_pattern` DOUBLE COMMENT 'Attribute capturing the integration pattern information for the platform integration entity.',
    `integration_status` STRING COMMENT 'Current status indicator for the integration workflow state.',
    `integration_type` DOUBLE COMMENT 'Classification type categorizing the integration for this record.',
    `last_failed_run_timestamp` TIMESTAMP COMMENT 'Date and time when the last failed run event occurred for this platform integration.',
    `last_run_timestamp` TIMESTAMP COMMENT 'Date and time when the last run event occurred for this platform integration.',
    `last_success_timestamp` TIMESTAMP COMMENT 'Date and time when the last success event occurred for this platform integration.',
    `last_successful_run_timestamp` TIMESTAMP COMMENT 'Date and time when the last successful run event occurred for this platform integration.',
    `middleware_platform` STRING COMMENT 'Attribute capturing the middleware platform information for the platform integration entity.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this platform integration.',
    `monitoring_enabled` BOOLEAN COMMENT 'Attribute capturing the monitoring enabled information for the platform integration entity.',
    `monitoring_enabled_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the monitoring enabled condition applies.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the platform integration entity.',
    `operational_status` DOUBLE COMMENT 'Current status indicator for the operational workflow state.',
    `owner_name` STRING COMMENT 'Human-readable name or label for the owner.',
    `record_volume_daily` STRING COMMENT 'Attribute capturing the record volume daily information for the platform integration entity.',
    `retry_count` STRING COMMENT 'Count or number of retry items associated with this record.',
    `schedule_frequency` STRING COMMENT 'Attribute capturing the schedule frequency information for the platform integration entity.',
    `sla_target_percent` DECIMAL(18,2) COMMENT 'Attribute capturing the sla target percent information for the platform integration entity.',
    `sla_uptime_percentage` DOUBLE COMMENT 'Attribute capturing the sla uptime percentage information for the platform integration entity.',
    `source_endpoint` STRING COMMENT 'Attribute capturing the source endpoint information for the platform integration entity.',
    `success_rate_percent` DECIMAL(18,2) COMMENT 'Attribute capturing the success rate percent information for the platform integration entity.',
    `sync_frequency` STRING COMMENT 'Attribute capturing the sync frequency information for the platform integration entity.',
    `sync_schedule` STRING COMMENT 'Attribute capturing the sync schedule information for the platform integration entity.',
    `target_endpoint` STRING COMMENT 'Attribute capturing the target endpoint information for the platform integration entity.',
    `timeout_seconds` STRING COMMENT 'Attribute capturing the timeout seconds information for the platform integration entity.',
    `total_records_transferred` BIGINT COMMENT 'Attribute capturing the total records transferred information for the platform integration entity.',
    `transformation_logic` STRING COMMENT 'Attribute capturing the transformation logic information for the platform integration entity.',
    CONSTRAINT pk_platform_integration PRIMARY KEY(`platform_integration_id`)
) COMMENT 'Master record for all system-to-system integrations and data exchange pipelines connecting NGO platforms, such as KoboToolbox-to-DHIS2, Salesforce-to-SAP, CommCare-to-beneficiary registry, and IATI publishing pipelines. Captures integration name, source system, target system, integration pattern (API, ETL, webhook, file transfer), data frequency, data classification of payload, integration owner, and operational status. SSOT for the integration architecture landscape.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` (
    `backup_schedule_id` BIGINT COMMENT 'Unique identifier for the backup schedule record. Primary key.',
    `parent_backup_schedule_id` BIGINT COMMENT 'Self-referencing FK on backup_schedule (parent_backup_schedule_id)',
    `system_platform_id` BIGINT COMMENT 'Reference to the IT system or platform covered by this backup schedule.',
    `user_account_id` BIGINT COMMENT 'Connect technology.backup_schedule by adding column user_account_id (BIGINT) with FK to technology.user_account.user_account_id because backup_schedule is under-connected. P6: connect_table: technology.backup_schedule** - add column user_ac',
    `alert_on_failure` BOOLEAN COMMENT 'Indicates whether automated alerts are sent when a backup fails or encounters errors.',
    `alert_recipients` STRING COMMENT 'Comma-separated list of email addresses or distribution lists that receive backup failure alerts.',
    `backup_frequency` STRING COMMENT 'Frequency at which backups are executed for this schedule.. Valid values are `hourly|daily|weekly|monthly|quarterly|on-demand`',
    `backup_target_location` STRING COMMENT 'Attribute capturing the backup target location information for the backup schedule entity.',
    `backup_type` STRING COMMENT 'Type of backup performed: full (complete copy), incremental (changes since last backup), differential (changes since last full), snapshot (point-in-time), or continuous (real-time replication).. Valid values are `full|incremental|differential|snapshot|continuous`',
    `backup_verification_enabled` BOOLEAN COMMENT 'Indicates whether automated verification and integrity checks are performed on backup files after completion.',
    `backup_window_end` STRING COMMENT 'Attribute capturing the backup window end information for the backup schedule entity.',
    `backup_window_end_time` TIMESTAMP COMMENT 'Time of day when the backup window ends, in HH:MM format (24-hour).',
    `backup_window_start` STRING COMMENT 'Attribute capturing the backup window start information for the backup schedule entity.',
    `backup_window_start_time` TIMESTAMP COMMENT 'Time of day when the backup window begins, in HH:MM format (24-hour).',
    `compliance_frameworks` STRING COMMENT 'Comma-separated list of compliance frameworks or regulations applicable to this backup schedule (e.g., GDPR, HIPAA, SOC2, ISO27001).',
    `compression_enabled` BOOLEAN COMMENT 'Indicates whether backup data is compressed to reduce storage space and transfer time.',
    `compression_ratio` DECIMAL(18,2) COMMENT 'Average compression ratio achieved for backups (e.g., 2.5 means data is compressed to 40% of original size).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this backup schedule record was first created in the system.',
    `data_asset_name` STRING COMMENT 'Name of the specific data asset, database, or repository covered by this backup schedule.',
    `data_classification_level` STRING COMMENT 'Highest data classification level of the data asset covered by this backup schedule, determining security and access controls.. Valid values are `restricted|confidential|internal|public`',
    `disaster_recovery_tier` STRING COMMENT 'Disaster recovery tier classification indicating the criticality and priority of this backup schedule for business continuity planning.. Valid values are `tier-1-critical|tier-2-high|tier-3-medium|tier-4-low`',
    `effective_end_date` DATE COMMENT 'Date when this backup schedule was deactivated or superseded. Null if currently active.',
    `effective_start_date` DATE COMMENT 'Date when this backup schedule became active and backups began executing.',
    `encryption_algorithm` STRING COMMENT 'Encryption algorithm used to secure backup data (e.g., AES-256, RSA-2048).',
    `encryption_enabled` BOOLEAN COMMENT 'Indicates whether backup data is encrypted at rest and in transit.',
    `encryption_enabled_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the encryption enabled condition applies.',
    `last_backup_duration_minutes` STRING COMMENT 'Duration in minutes of the most recent backup execution.',
    `last_backup_size_gb` DECIMAL(18,2) COMMENT 'Size of the most recent backup in gigabytes.',
    `last_backup_status` STRING COMMENT 'Outcome status of the most recent backup execution attempt.. Valid values are `success|failed|partial|in-progress|skipped`',
    `last_backup_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful backup execution for this schedule.',
    `last_restore_test_date` DATE COMMENT 'Date and time when the last restore test event occurred for this backup schedule.',
    `last_verification_status` STRING COMMENT 'Outcome of the most recent backup verification or integrity check.. Valid values are `passed|failed|not-verified`',
    `last_verification_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent backup verification or integrity check.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this backup schedule record was last modified.',
    `next_backup_timestamp` TIMESTAMP COMMENT 'Date and time when the next backup event occurred for this backup schedule.',
    `next_scheduled_backup_timestamp` TIMESTAMP COMMENT 'Timestamp when the next backup is scheduled to execute.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this backup schedule.',
    `offsite_copy_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the offsite copy condition applies.',
    `responsible_team` STRING COMMENT 'Name of the IT team or department responsible for managing and monitoring this backup schedule.',
    `retention_days` STRING COMMENT 'Attribute capturing the retention days information for the backup schedule entity.',
    `retention_period_days` STRING COMMENT 'Number of days that backup copies are retained before being eligible for deletion or archival.',
    `rpo_hours` STRING COMMENT 'Attribute capturing the rpo hours information for the backup schedule entity.',
    `rpo_minutes` STRING COMMENT 'Recovery Point Objective in minutes: the maximum acceptable amount of data loss measured in time. Defines how much data the organization can afford to lose.',
    `rto_hours` STRING COMMENT 'Attribute capturing the rto hours information for the backup schedule entity.',
    `rto_minutes` STRING COMMENT 'Recovery Time Objective in minutes: the maximum acceptable time to restore the system or data after a disruption. Defines how quickly the organization must recover.',
    `schedule_code` STRING COMMENT 'Business identifier code for the backup schedule, used for external reference and reporting.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `schedule_cron_expression` STRING COMMENT 'Cron expression defining the precise timing and recurrence pattern for automated backup execution.',
    `schedule_name` STRING COMMENT 'Human-readable name of the backup schedule describing the system or data asset covered.',
    `schedule_status` STRING COMMENT 'Current operational status of the backup schedule.. Valid values are `active|suspended|disabled|archived`',
    `storage_capacity_gb` DECIMAL(18,2) COMMENT 'Attribute capturing the storage capacity gb information for the backup schedule entity.',
    `storage_location_type` STRING COMMENT 'Primary storage location type for backup data: on-site (local datacenter), cloud (cloud provider), offsite (third-party facility), or hybrid (multiple locations).. Valid values are `on-site|cloud|offsite|hybrid`',
    `storage_path` STRING COMMENT 'File system path, bucket name, or URI where backup files are stored.',
    `storage_provider` STRING COMMENT 'Name of the storage provider or vendor hosting the backup data (e.g., AWS S3, Azure Blob, local NAS).',
    `technical_owner_email` STRING COMMENT 'Email address of the technical owner for notifications and escalations.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `technical_owner_name` STRING COMMENT 'Name of the technical owner or system administrator responsible for this backup schedule.',
    `verification_method` STRING COMMENT 'Attribute capturing the verification method information for the backup schedule entity.',
    CONSTRAINT pk_backup_schedule PRIMARY KEY(`backup_schedule_id`)
) COMMENT 'Master record defining the data backup and disaster recovery schedules for all critical NGO systems and data repositories. Captures system or data asset covered, backup frequency (daily/weekly/monthly), backup type (full/incremental/differential), retention period, storage location (on-site/cloud/offsite), recovery point objective (RPO), recovery time objective (RTO), and last successful backup timestamp. Supports business continuity planning.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`it_procurement` (
    `it_procurement_id` BIGINT COMMENT 'Unique identifier for the it procurement record.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated approver staff staff member entity.',
    `award_id` BIGINT COMMENT 'Reference identifier linking to the associated award entity.',
    `it_project_id` BIGINT COMMENT 'Reference identifier linking to the associated it project entity.',
    `it_requesting_staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated it requesting staff member entity.',
    `parent_it_procurement_id` BIGINT COMMENT 'Reference identifier linking to the associated parent it procurement entity.',
    `primary_it_staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated primary it staff member entity.',
    `it_asset_id` BIGINT COMMENT 'Reference identifier linking to the associated resulting it asset entity.',
    `software_license_id` BIGINT COMMENT 'Reference identifier linking to the associated resulting software license entity.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Attribute capturing the actual cost information for the it procurement entity.',
    `actual_delivery_date` DATE COMMENT 'Date and time when the actual delivery event occurred for this it procurement.',
    `approval_date` DATE COMMENT 'Date and time when the approval event occurred for this it procurement.',
    `approver_name` STRING COMMENT 'Human-readable name or label for the approver.',
    `budget_code` DECIMAL(18,2) COMMENT 'Standardized code representing the budget classification or category.',
    `business_justification` STRING COMMENT 'Attribute capturing the business justification information for the it procurement entity.',
    `compliance_check_required` BOOLEAN COMMENT 'Attribute capturing the compliance check required information for the it procurement entity.',
    `compliance_check_status` STRING COMMENT 'Current status indicator for the compliance check workflow state.',
    `contract_reference` STRING COMMENT 'Attribute capturing the contract reference information for the it procurement entity.',
    `country_office_code` STRING COMMENT 'Standardized code representing the country office classification or category.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this it procurement.',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `data_classification_level` STRING COMMENT 'Attribute capturing the data classification level information for the it procurement entity.',
    `delivery_confirmed_by` STRING COMMENT 'Reference to the user or entity that performed the delivery confirmed action.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Attribute capturing the estimated cost information for the it procurement entity.',
    `expected_delivery_date` DATE COMMENT 'Date and time when the expected delivery event occurred for this it procurement.',
    `invoice_number` STRING COMMENT 'Count or number of invoice items associated with this record.',
    `item_description` STRING COMMENT 'Detailed textual description providing context about the item.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this it procurement.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the it procurement entity.',
    `order_date` DATE COMMENT 'Date and time when the order event occurred for this it procurement.',
    `payment_date` DECIMAL(18,2) COMMENT 'Date and time when the payment event occurred for this it procurement.',
    `payment_status` DECIMAL(18,2) COMMENT 'Current status indicator for the payment workflow state.',
    `priority_level` STRING COMMENT 'Attribute capturing the priority level information for the it procurement entity.',
    `procurement_status` STRING COMMENT 'Current status indicator for the procurement workflow state.',
    `procurement_type` STRING COMMENT 'Classification type categorizing the procurement for this record.',
    `program_code` STRING COMMENT 'Standardized code representing the program classification or category.',
    `purchase_order_number` STRING COMMENT 'Count or number of purchase order items associated with this record.',
    `rejection_reason` STRING COMMENT 'Attribute capturing the rejection reason information for the it procurement entity.',
    `requester_email` STRING COMMENT 'Attribute capturing the requester email information for the it procurement entity.',
    `requester_name` STRING COMMENT 'Human-readable name or label for the requester.',
    `requisition_number` STRING COMMENT 'Count or number of requisition items associated with this record.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the submitted event occurred for this it procurement.',
    `vendor_code` STRING COMMENT 'Standardized code representing the vendor classification or category.',
    `vendor_name` STRING COMMENT 'Human-readable name or label for the vendor.',
    CONSTRAINT pk_it_procurement PRIMARY KEY(`it_procurement_id`)
) COMMENT 'Transactional record of IT-specific procurement requests and purchase orders for hardware, software, and technology services. Captures requisition type (hardware, software license, cloud service, managed service), requested item, vendor, estimated cost, budget code, approval chain, procurement status, and delivery confirmation. Complements supply.purchase_order (which covers humanitarian commodity procurement) — this is scoped exclusively to IT goods and services.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` (
    `cab_meeting_id` BIGINT COMMENT 'Primary key for cab_meeting',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated cab chair staff member entity.',
    `cab_staff_member_id` BIGINT COMMENT 'Identifier of the staff member who chairs or facilitates the CAB meeting, responsible for agenda management and decision facilitation.',
    `followup_cab_meeting_id` BIGINT COMMENT 'Self-referencing FK on cab_meeting (followup_cab_meeting_id)',
    `action_items_count` STRING COMMENT 'Number of follow-up action items or tasks assigned during the CAB meeting that require completion before the next meeting.',
    `actual_end_time` TIMESTAMP COMMENT 'The actual date and time when the CAB meeting concluded, capturing the true duration of the meeting.',
    `actual_start_time` TIMESTAMP COMMENT 'The actual date and time when the CAB meeting commenced, which may differ from scheduled time due to delays or early starts.',
    `agenda_document_url` STRING COMMENT 'Link or file path to the meeting agenda document outlining topics, change requests, and discussion items for the CAB meeting.',
    `attendee_count` STRING COMMENT 'Count or number of attendee items associated with this record.',
    `attendees_list` STRING COMMENT 'Attribute capturing the attendees list information for the cab meeting entity.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the CAB meeting was cancelled or postponed, if applicable (e.g., lack of quorum, emergency situation, no changes to review).',
    `changes_approved` STRING COMMENT 'Count of change requests that received approval from the CAB during the meeting.',
    `changes_approved_count` STRING COMMENT 'Count or number of changes approved items associated with this record.',
    `changes_deferred` STRING COMMENT 'Count of change requests that were postponed or tabled for future CAB review, requiring additional information or analysis.',
    `changes_deferred_count` STRING COMMENT 'Count or number of changes deferred items associated with this record.',
    `changes_rejected` STRING COMMENT 'Count of change requests that were rejected or denied by the CAB during the meeting.',
    `changes_rejected_count` STRING COMMENT 'Count or number of changes rejected items associated with this record.',
    `changes_reviewed_count` STRING COMMENT 'Count or number of changes reviewed items associated with this record.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the CAB meeting record was first created in the system.',
    `decisions_summary` STRING COMMENT 'Attribute capturing the decisions summary information for the cab meeting entity.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter during which the CAB meeting occurred, enabling quarterly performance analysis.',
    `fiscal_year` STRING COMMENT 'The fiscal year during which the CAB meeting occurred, used for reporting and trend analysis (e.g., FY2024).',
    `is_emergency_meeting` BOOLEAN COMMENT 'Flag indicating whether this CAB meeting was convened on an emergency basis to address critical or urgent change requests outside the regular schedule.',
    `meeting_date` DATE COMMENT 'Date and time when the meeting event occurred for this cab meeting.',
    `meeting_end_timestamp` TIMESTAMP COMMENT 'Date and time when the meeting end event occurred for this cab meeting.',
    `meeting_location` STRING COMMENT 'Physical or virtual location where the CAB meeting is held (e.g., conference room name, Zoom link, Microsoft Teams channel).',
    `meeting_notes` STRING COMMENT 'Free-text field capturing key discussion points, decisions, concerns raised, and general observations from the CAB meeting.',
    `meeting_number` STRING COMMENT 'Business identifier for the CAB meeting, typically following organizational numbering convention (e.g., CAB-2024-001).',
    `meeting_platform` STRING COMMENT 'The technology platform or medium used to conduct the CAB meeting (in-person, video conferencing tool, or hybrid).',
    `meeting_series_code` STRING COMMENT 'Identifier linking this CAB meeting to a recurring series or sequence of related meetings (e.g., weekly CAB, monthly emergency CAB).',
    `meeting_start_timestamp` TIMESTAMP COMMENT 'Date and time when the meeting start event occurred for this cab meeting.',
    `meeting_status` STRING COMMENT 'Current lifecycle state of the CAB meeting indicating whether it is planned, active, concluded, or cancelled.',
    `meeting_type` STRING COMMENT 'Classification of the CAB meeting based on urgency and purpose (standard for routine changes, emergency for critical incidents, expedited for time-sensitive approvals).',
    `minutes_document_reference` STRING COMMENT 'Attribute capturing the minutes document reference information for the cab meeting entity.',
    `minutes_document_url` STRING COMMENT 'Link or file path to the official meeting minutes documenting discussions, decisions, and action items from the CAB meeting.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the CAB meeting record was last updated or modified in the system.',
    `next_meeting_date` DATE COMMENT 'The scheduled date for the subsequent CAB meeting, typically determined during the current meeting.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the cab meeting entity.',
    `quorum_met` BOOLEAN COMMENT 'Indicator of whether the minimum required number of voting members was present to conduct official business.',
    `quorum_met_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the quorum met condition applies.',
    `quorum_required` STRING COMMENT 'Minimum number of voting members required to be present for the CAB meeting to make binding decisions.',
    `recording_url` STRING COMMENT 'Link to the audio or video recording of the CAB meeting for reference and compliance purposes.',
    `scheduled_date` DATE COMMENT 'The calendar date on which the CAB meeting is planned to occur.',
    `scheduled_end_time` TIMESTAMP COMMENT 'The precise date and time when the CAB meeting is scheduled to conclude, including timezone information.',
    `scheduled_start_time` TIMESTAMP COMMENT 'The precise date and time when the CAB meeting is scheduled to begin, including timezone information.',
    `total_attendees` STRING COMMENT 'Total count of individuals who attended the CAB meeting, including voting members, observers, and presenters.',
    `total_changes_reviewed` STRING COMMENT 'Count of change requests that were presented and reviewed during the CAB meeting.',
    `voting_members_present` STRING COMMENT 'Count of authorized voting members who attended the CAB meeting and are eligible to approve or reject change requests.',
    CONSTRAINT pk_cab_meeting PRIMARY KEY(`cab_meeting_id`)
) COMMENT 'Master reference table for cab_meeting. Referenced by cab_meeting_id.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`it_problem` (
    `it_problem_id` BIGINT COMMENT 'Unique identifier for the it problem record.',
    `parent_it_problem_id` BIGINT COMMENT 'Reference identifier linking to the associated parent it problem entity.',
    `system_platform_id` BIGINT COMMENT 'Reference identifier linking to the associated system platform entity.',
    `assigned_to` STRING COMMENT 'Attribute capturing the assigned to information for the it problem entity.',
    `business_impact` STRING COMMENT 'Attribute capturing the business impact information for the it problem entity.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the closed event occurred for this it problem.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this it problem.',
    `known_error_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the known error condition applies.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this it problem.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the it problem entity.',
    `priority_level` STRING COMMENT 'Attribute capturing the priority level information for the it problem entity.',
    `problem_category` STRING COMMENT 'Attribute capturing the problem category information for the it problem entity.',
    `problem_description` STRING COMMENT 'Detailed textual description providing context about the problem.',
    `problem_number` STRING COMMENT 'Count or number of problem items associated with this record.',
    `problem_status` STRING COMMENT 'Current status indicator for the problem workflow state.',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the reported event occurred for this it problem.',
    `resolution_description` STRING COMMENT 'Detailed textual description providing context about the resolution.',
    `resolved_timestamp` TIMESTAMP COMMENT 'Date and time when the resolved event occurred for this it problem.',
    `root_cause` STRING COMMENT 'Attribute capturing the root cause information for the it problem entity.',
    `root_cause_category` STRING COMMENT 'Attribute capturing the root cause category information for the it problem entity.',
    `severity_level` STRING COMMENT 'Attribute capturing the severity level information for the it problem entity.',
    `title` STRING COMMENT 'Attribute capturing the title information for the it problem entity.',
    `workaround_description` STRING COMMENT 'Detailed textual description providing context about the workaround.',
    CONSTRAINT pk_it_problem PRIMARY KEY(`it_problem_id`)
) COMMENT 'Master reference table for it_problem. Referenced by related_problem_id.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` (
    `knowledge_article_id` BIGINT COMMENT 'Unique identifier for the knowledge article record.',
    `it_service_id` BIGINT COMMENT 'Reference identifier linking to the associated it service entity.',
    `superseded_by_knowledge_article_id` BIGINT COMMENT 'Reference identifier linking to the associated superseded by knowledge article entity.',
    `system_platform_id` BIGINT COMMENT 'Reference identifier linking to the associated system platform entity.',
    `article_body` STRING COMMENT 'Attribute capturing the article body information for the knowledge article entity.',
    `article_number` STRING COMMENT 'Count or number of article items associated with this record.',
    `article_status` STRING COMMENT 'Current status indicator for the article workflow state.',
    `article_type` STRING COMMENT 'Classification type categorizing the article for this record.',
    `author_name` STRING COMMENT 'Human-readable name or label for the author.',
    `knowledge_article_category` STRING COMMENT 'Attribute capturing the knowledge article category information for the knowledge article entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this knowledge article.',
    `expiry_date` DATE COMMENT 'Date and time when the expiry event occurred for this knowledge article.',
    `helpful_count` STRING COMMENT 'Count or number of helpful items associated with this record.',
    `keywords` STRING COMMENT 'Attribute capturing the keywords information for the knowledge article entity.',
    `language_code` STRING COMMENT 'Standardized code representing the language classification or category.',
    `last_reviewed_date` DATE COMMENT 'Date and time when the last reviewed event occurred for this knowledge article.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this knowledge article.',
    `published_date` DATE COMMENT 'Date and time when the published event occurred for this knowledge article.',
    `title` STRING COMMENT 'Attribute capturing the title information for the knowledge article entity.',
    `version` STRING COMMENT 'Attribute capturing the version information for the knowledge article entity.',
    `view_count` STRING COMMENT 'Count or number of view items associated with this record.',
    CONSTRAINT pk_knowledge_article PRIMARY KEY(`knowledge_article_id`)
) COMMENT 'Master reference table for knowledge_article. Referenced by knowledge_article_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ADD CONSTRAINT `fk_technology_it_asset_network_site_id` FOREIGN KEY (`network_site_id`) REFERENCES `vibe_ngo_v1`.`technology`.`network_site`(`network_site_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ADD CONSTRAINT `fk_technology_it_asset_parent_it_asset_id` FOREIGN KEY (`parent_it_asset_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ADD CONSTRAINT `fk_technology_system_platform_parent_system_platform_id` FOREIGN KEY (`parent_system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ADD CONSTRAINT `fk_technology_it_service_parent_it_service_id` FOREIGN KEY (`parent_it_service_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_service`(`it_service_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ADD CONSTRAINT `fk_technology_it_service_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ADD CONSTRAINT `fk_technology_service_request_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ADD CONSTRAINT `fk_technology_service_request_it_service_id` FOREIGN KEY (`it_service_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_service`(`it_service_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ADD CONSTRAINT `fk_technology_service_request_knowledge_article_id` FOREIGN KEY (`knowledge_article_id`) REFERENCES `vibe_ngo_v1`.`technology`.`knowledge_article`(`knowledge_article_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ADD CONSTRAINT `fk_technology_service_request_parent_service_request_id` FOREIGN KEY (`parent_service_request_id`) REFERENCES `vibe_ngo_v1`.`technology`.`service_request`(`service_request_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ADD CONSTRAINT `fk_technology_service_request_it_incident_id` FOREIGN KEY (`it_incident_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_incident`(`it_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ADD CONSTRAINT `fk_technology_service_request_change_request_id` FOREIGN KEY (`change_request_id`) REFERENCES `vibe_ngo_v1`.`technology`.`change_request`(`change_request_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ADD CONSTRAINT `fk_technology_change_request_cab_meeting_id` FOREIGN KEY (`cab_meeting_id`) REFERENCES `vibe_ngo_v1`.`technology`.`cab_meeting`(`cab_meeting_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ADD CONSTRAINT `fk_technology_change_request_it_project_id` FOREIGN KEY (`it_project_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_project`(`it_project_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ADD CONSTRAINT `fk_technology_change_request_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ADD CONSTRAINT `fk_technology_change_request_rollback_change_request_id` FOREIGN KEY (`rollback_change_request_id`) REFERENCES `vibe_ngo_v1`.`technology`.`change_request`(`change_request_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ADD CONSTRAINT `fk_technology_it_incident_caused_by_it_incident_id` FOREIGN KEY (`caused_by_it_incident_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_incident`(`it_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ADD CONSTRAINT `fk_technology_it_incident_it_problem_id` FOREIGN KEY (`it_problem_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_problem`(`it_problem_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ADD CONSTRAINT `fk_technology_it_incident_it_service_id` FOREIGN KEY (`it_service_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_service`(`it_service_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ADD CONSTRAINT `fk_technology_it_incident_change_request_id` FOREIGN KEY (`change_request_id`) REFERENCES `vibe_ngo_v1`.`technology`.`change_request`(`change_request_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ADD CONSTRAINT `fk_technology_it_incident_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ADD CONSTRAINT `fk_technology_network_site_upstream_network_site_id` FOREIGN KEY (`upstream_network_site_id`) REFERENCES `vibe_ngo_v1`.`technology`.`network_site`(`network_site_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ADD CONSTRAINT `fk_technology_connectivity_log_it_incident_id` FOREIGN KEY (`it_incident_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_incident`(`it_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ADD CONSTRAINT `fk_technology_connectivity_log_network_site_id` FOREIGN KEY (`network_site_id`) REFERENCES `vibe_ngo_v1`.`technology`.`network_site`(`network_site_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ADD CONSTRAINT `fk_technology_connectivity_log_previous_connectivity_log_id` FOREIGN KEY (`previous_connectivity_log_id`) REFERENCES `vibe_ngo_v1`.`technology`.`connectivity_log`(`connectivity_log_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ADD CONSTRAINT `fk_technology_user_account_parent_user_account_id` FOREIGN KEY (`parent_user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ADD CONSTRAINT `fk_technology_user_account_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ADD CONSTRAINT `fk_technology_access_role_parent_access_role_id` FOREIGN KEY (`parent_access_role_id`) REFERENCES `vibe_ngo_v1`.`technology`.`access_role`(`access_role_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ADD CONSTRAINT `fk_technology_access_role_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ADD CONSTRAINT `fk_technology_access_provisioning_access_role_id` FOREIGN KEY (`access_role_id`) REFERENCES `vibe_ngo_v1`.`technology`.`access_role`(`access_role_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ADD CONSTRAINT `fk_technology_access_provisioning_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ADD CONSTRAINT `fk_technology_access_provisioning_superseded_access_provisioning_id` FOREIGN KEY (`superseded_access_provisioning_id`) REFERENCES `vibe_ngo_v1`.`technology`.`access_provisioning`(`access_provisioning_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ADD CONSTRAINT `fk_technology_access_provisioning_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ADD CONSTRAINT `fk_technology_access_provisioning_target_user_user_account_id` FOREIGN KEY (`target_user_user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ADD CONSTRAINT `fk_technology_security_control_parent_security_control_id` FOREIGN KEY (`parent_security_control_id`) REFERENCES `vibe_ngo_v1`.`technology`.`security_control`(`security_control_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ADD CONSTRAINT `fk_technology_security_control_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ADD CONSTRAINT `fk_technology_security_assessment_followup_security_assessment_id` FOREIGN KEY (`followup_security_assessment_id`) REFERENCES `vibe_ngo_v1`.`technology`.`security_assessment`(`security_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ADD CONSTRAINT `fk_technology_security_assessment_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ADD CONSTRAINT `fk_technology_vulnerability_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ADD CONSTRAINT `fk_technology_vulnerability_parent_vulnerability_id` FOREIGN KEY (`parent_vulnerability_id`) REFERENCES `vibe_ngo_v1`.`technology`.`vulnerability`(`vulnerability_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ADD CONSTRAINT `fk_technology_vulnerability_it_incident_id` FOREIGN KEY (`it_incident_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_incident`(`it_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ADD CONSTRAINT `fk_technology_vulnerability_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ADD CONSTRAINT `fk_technology_software_license_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ADD CONSTRAINT `fk_technology_software_license_upgraded_from_software_license_id` FOREIGN KEY (`upgraded_from_software_license_id`) REFERENCES `vibe_ngo_v1`.`technology`.`software_license`(`software_license_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ADD CONSTRAINT `fk_technology_it_project_parent_it_project_id` FOREIGN KEY (`parent_it_project_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_project`(`it_project_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ADD CONSTRAINT `fk_technology_it_project_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ADD CONSTRAINT `fk_technology_platform_integration_replaced_platform_integration_id` FOREIGN KEY (`replaced_platform_integration_id`) REFERENCES `vibe_ngo_v1`.`technology`.`platform_integration`(`platform_integration_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ADD CONSTRAINT `fk_technology_platform_integration_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ADD CONSTRAINT `fk_technology_platform_integration_target_system_platform_id` FOREIGN KEY (`target_system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ADD CONSTRAINT `fk_technology_backup_schedule_parent_backup_schedule_id` FOREIGN KEY (`parent_backup_schedule_id`) REFERENCES `vibe_ngo_v1`.`technology`.`backup_schedule`(`backup_schedule_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ADD CONSTRAINT `fk_technology_backup_schedule_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ADD CONSTRAINT `fk_technology_backup_schedule_user_account_id` FOREIGN KEY (`user_account_id`) REFERENCES `vibe_ngo_v1`.`technology`.`user_account`(`user_account_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ADD CONSTRAINT `fk_technology_it_procurement_it_project_id` FOREIGN KEY (`it_project_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_project`(`it_project_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ADD CONSTRAINT `fk_technology_it_procurement_parent_it_procurement_id` FOREIGN KEY (`parent_it_procurement_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_procurement`(`it_procurement_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ADD CONSTRAINT `fk_technology_it_procurement_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ADD CONSTRAINT `fk_technology_it_procurement_software_license_id` FOREIGN KEY (`software_license_id`) REFERENCES `vibe_ngo_v1`.`technology`.`software_license`(`software_license_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ADD CONSTRAINT `fk_technology_cab_meeting_followup_cab_meeting_id` FOREIGN KEY (`followup_cab_meeting_id`) REFERENCES `vibe_ngo_v1`.`technology`.`cab_meeting`(`cab_meeting_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ADD CONSTRAINT `fk_technology_it_problem_parent_it_problem_id` FOREIGN KEY (`parent_it_problem_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_problem`(`it_problem_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ADD CONSTRAINT `fk_technology_it_problem_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ADD CONSTRAINT `fk_technology_knowledge_article_it_service_id` FOREIGN KEY (`it_service_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_service`(`it_service_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ADD CONSTRAINT `fk_technology_knowledge_article_superseded_by_knowledge_article_id` FOREIGN KEY (`superseded_by_knowledge_article_id`) REFERENCES `vibe_ngo_v1`.`technology`.`knowledge_article`(`knowledge_article_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ADD CONSTRAINT `fk_technology_knowledge_article_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`technology` SET TAGS ('pii_division' = 'corporate');
ALTER SCHEMA `vibe_ngo_v1`.`technology` SET TAGS ('pii_domain' = 'technology');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` SET TAGS ('pii_subdomain' = 'infrastructure_assets');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` SET TAGS ('pii_domain' = 'technology');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `it_asset_id` SET TAGS ('pii_business_glossary_term' = 'Information Technology (IT) Asset ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `network_site_id` SET TAGS ('pii_business_glossary_term' = 'Network Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `parent_it_asset_id` SET TAGS ('pii_business_glossary_term' = 'Parent It Asset Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `parent_it_asset_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Staff Member ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `vendor_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `asset_category` SET TAGS ('pii_business_glossary_term' = 'Asset Category');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `asset_condition` SET TAGS ('pii_business_glossary_term' = 'Physical Asset Condition');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `asset_tag` SET TAGS ('pii_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `asset_tag` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `asset_type` SET TAGS ('pii_business_glossary_term' = 'Asset Type Classification');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `asset_type` SET TAGS ('pii_value_regex' = 'hardware|software|network_equipment|mobile_device|peripheral|license');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `assigned_country_code` SET TAGS ('pii_business_glossary_term' = 'Assigned Country Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `assigned_country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `assigned_location_name` SET TAGS ('pii_business_glossary_term' = 'Assigned Location Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `assigned_location_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `assigned_location_name` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `assigned_location_type` SET TAGS ('pii_business_glossary_term' = 'Assigned Location Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `assigned_location_type` SET TAGS ('pii_value_regex' = 'headquarters|country_office|field_office|warehouse|remote');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `assigned_location_type` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `assignment_date` SET TAGS ('pii_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `depreciation_method` SET TAGS ('pii_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `depreciation_method` SET TAGS ('pii_value_regex' = 'straight_line|declining_balance|units_of_production|none');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `disposal_date` SET TAGS ('pii_business_glossary_term' = 'Disposal Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `disposal_method` SET TAGS ('pii_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `disposal_method` SET TAGS ('pii_value_regex' = 'sold|donated|recycled|destroyed|returned_to_vendor');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `hostname` SET TAGS ('pii_business_glossary_term' = 'Network Hostname');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `ip_address` SET TAGS ('pii_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `ip_address` SET TAGS ('pii_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `ip_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `ip_address` SET TAGS ('pii_ip' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `ip_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `license_expiry_date` SET TAGS ('pii_business_glossary_term' = 'License Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_business_glossary_term' = 'Asset Lifecycle Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_value_regex' = 'active|in_storage|in_repair|deployed|retired|decommissioned');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `mac_address` SET TAGS ('pii_business_glossary_term' = 'Media Access Control (MAC) Address');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `mac_address` SET TAGS ('pii_value_regex' = '^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `mac_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `mac_address` SET TAGS ('pii_device' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `mac_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `manufacturer` SET TAGS ('pii_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `model` SET TAGS ('pii_business_glossary_term' = 'Model Number or Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Asset Notes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `operating_system` SET TAGS ('pii_business_glossary_term' = 'Operating System (OS)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `procurement_cost` SET TAGS ('pii_business_glossary_term' = 'Procurement Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `procurement_cost` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `procurement_date` SET TAGS ('pii_business_glossary_term' = 'Procurement Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `product_name` SET TAGS ('pii_business_glossary_term' = 'Product Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `product_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `product_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `salvage_value` SET TAGS ('pii_business_glossary_term' = 'Salvage Value');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `salvage_value` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `serial_number` SET TAGS ('pii_business_glossary_term' = 'Manufacturer Serial Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `software_version` SET TAGS ('pii_business_glossary_term' = 'Software Version');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `support_contract_number` SET TAGS ('pii_business_glossary_term' = 'Support Contract Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `support_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Support Contract Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `useful_life_years` SET TAGS ('pii_business_glossary_term' = 'Useful Life in Years');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `warranty_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Warranty Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `warranty_start_date` SET TAGS ('pii_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `warranty_type` SET TAGS ('pii_business_glossary_term' = 'Warranty Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `warranty_type` SET TAGS ('pii_value_regex' = 'manufacturer|extended|third_party|none');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` SET TAGS ('pii_subdomain' = 'infrastructure_assets');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` SET TAGS ('pii_domain' = 'technology');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` SET TAGS ('pii_column_comment_framework' = 'ITIL + humanitarian platform registry');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `is_mobile_enabled` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `is_mobile_enabled` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `platform_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `vendor_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` SET TAGS ('pii_subdomain' = 'service_operations');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` SET TAGS ('pii_domain' = 'technology');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` SET TAGS ('pii_column_comment_framework' = 'ITIL');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `service_manager_name` SET TAGS ('pii_type' = 'age');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `service_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `service_owner_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `service_owner_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `service_owner_name` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `support_contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `support_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `support_phone_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `support_phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `vendor_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` SET TAGS ('pii_subdomain' = 'service_operations');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` SET TAGS ('pii_subdomain' = 'service_operations');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `assigned_to_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `requester_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `requester_email` SET TAGS ('pii_type' = 'email');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `requester_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `requester_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` SET TAGS ('pii_subdomain' = 'service_operations');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` SET TAGS ('pii_subdomain' = 'infrastructure_assets');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `city` SET TAGS ('pii_type' = 'address');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `ip_address_range` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `ip_address_range` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `network_administrator_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `network_administrator_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `network_administrator_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `network_administrator_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `network_administrator_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `site_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` SET TAGS ('pii_subdomain' = 'infrastructure_assets');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `device_ip_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `device_ip_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `device_mac_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `device_mac_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `isp_provider_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` SET TAGS ('pii_subdomain' = 'access_security');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `commcare_username` SET TAGS ('pii_type' = 'credential');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `dhis2_username` SET TAGS ('pii_type' = 'credential');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `email_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `failed_login_attempts` SET TAGS ('pii_type' = 'credential');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `kobotoolbox_username` SET TAGS ('pii_type' = 'credential');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `last_login_timestamp` SET TAGS ('pii_type' = 'credential');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `last_password_change_date` SET TAGS ('pii_type' = 'credential');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `mobile_device_registered_flag` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `mobile_device_registered_flag` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `password_expiry_date` SET TAGS ('pii_type' = 'credential');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `username` SET TAGS ('pii_type' = 'credential');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` SET TAGS ('pii_subdomain' = 'access_security');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `approval_authority_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `role_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `role_owner_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `role_owner_email` SET TAGS ('pii_type' = 'email');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `role_owner_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `role_owner_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` SET TAGS ('pii_subdomain' = 'access_security');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `primary_access_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `primary_access_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `tertiary_access_compliance_signoff_by_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `tertiary_access_compliance_signoff_by_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `target_user_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `target_user_email` SET TAGS ('pii_type' = 'email');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` SET TAGS ('pii_subdomain' = 'access_security');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `control_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `evidence_location` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` SET TAGS ('pii_subdomain' = 'access_security');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `assessor_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `conducting_entity_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` SET TAGS ('pii_subdomain' = 'access_security');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` SET TAGS ('pii_subdomain' = 'infrastructure_assets');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `license_owner_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `license_owner_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `license_owner_name` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `product_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `technical_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `technical_contact_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `vendor_account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `vendor_account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `vendor_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` SET TAGS ('pii_subdomain' = 'digital_delivery');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `primary_it_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `primary_it_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `tertiary_it_business_sponsor_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `tertiary_it_business_sponsor_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `tertiary_it_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `tertiary_it_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `health_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `health_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `project_manager_name` SET TAGS ('pii_type' = 'age');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `project_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `project_sponsor_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `vendor_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` SET TAGS ('pii_subdomain' = 'digital_delivery');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `primary_platform_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `primary_platform_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `integration_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `owner_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` SET TAGS ('pii_subdomain' = 'infrastructure_assets');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `backup_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Backup Schedule ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `parent_backup_schedule_id` SET TAGS ('pii_business_glossary_term' = 'Parent Backup Schedule Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `parent_backup_schedule_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'System Platform ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `alert_on_failure` SET TAGS ('pii_business_glossary_term' = 'Alert on Failure');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `alert_recipients` SET TAGS ('pii_business_glossary_term' = 'Alert Recipients');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `alert_recipients` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `backup_frequency` SET TAGS ('pii_business_glossary_term' = 'Backup Frequency');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `backup_frequency` SET TAGS ('pii_value_regex' = 'hourly|daily|weekly|monthly|quarterly|on-demand');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `backup_target_location` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `backup_type` SET TAGS ('pii_business_glossary_term' = 'Backup Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `backup_type` SET TAGS ('pii_value_regex' = 'full|incremental|differential|snapshot|continuous');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `backup_verification_enabled` SET TAGS ('pii_business_glossary_term' = 'Backup Verification Enabled');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `backup_window_end_time` SET TAGS ('pii_business_glossary_term' = 'Backup Window End Time');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `backup_window_start_time` SET TAGS ('pii_business_glossary_term' = 'Backup Window Start Time');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `compliance_frameworks` SET TAGS ('pii_business_glossary_term' = 'Compliance Frameworks');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `compression_enabled` SET TAGS ('pii_business_glossary_term' = 'Compression Enabled');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `compression_ratio` SET TAGS ('pii_business_glossary_term' = 'Compression Ratio');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `data_asset_name` SET TAGS ('pii_business_glossary_term' = 'Data Asset Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `data_asset_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `data_asset_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `data_classification_level` SET TAGS ('pii_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `data_classification_level` SET TAGS ('pii_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `disaster_recovery_tier` SET TAGS ('pii_business_glossary_term' = 'Disaster Recovery (DR) Tier');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `disaster_recovery_tier` SET TAGS ('pii_value_regex' = 'tier-1-critical|tier-2-high|tier-3-medium|tier-4-low');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `encryption_algorithm` SET TAGS ('pii_business_glossary_term' = 'Encryption Algorithm');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `encryption_enabled` SET TAGS ('pii_business_glossary_term' = 'Encryption Enabled');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `last_backup_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Last Backup Duration Minutes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `last_backup_size_gb` SET TAGS ('pii_business_glossary_term' = 'Last Backup Size Gigabytes (GB)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `last_backup_status` SET TAGS ('pii_business_glossary_term' = 'Last Backup Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `last_backup_status` SET TAGS ('pii_value_regex' = 'success|failed|partial|in-progress|skipped');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `last_backup_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Backup Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `last_verification_status` SET TAGS ('pii_business_glossary_term' = 'Last Verification Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `last_verification_status` SET TAGS ('pii_value_regex' = 'passed|failed|not-verified');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `last_verification_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Verification Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `next_scheduled_backup_timestamp` SET TAGS ('pii_business_glossary_term' = 'Next Scheduled Backup Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `responsible_team` SET TAGS ('pii_business_glossary_term' = 'Responsible Team');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `retention_period_days` SET TAGS ('pii_business_glossary_term' = 'Retention Period Days');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `rpo_minutes` SET TAGS ('pii_business_glossary_term' = 'Recovery Point Objective (RPO) Minutes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `rto_minutes` SET TAGS ('pii_business_glossary_term' = 'Recovery Time Objective (RTO) Minutes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `schedule_code` SET TAGS ('pii_business_glossary_term' = 'Backup Schedule Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `schedule_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `schedule_cron_expression` SET TAGS ('pii_business_glossary_term' = 'Schedule Cron Expression');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_business_glossary_term' = 'Backup Schedule Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `schedule_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `schedule_status` SET TAGS ('pii_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `schedule_status` SET TAGS ('pii_value_regex' = 'active|suspended|disabled|archived');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `storage_location_type` SET TAGS ('pii_business_glossary_term' = 'Storage Location Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `storage_location_type` SET TAGS ('pii_value_regex' = 'on-site|cloud|offsite|hybrid');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `storage_location_type` SET TAGS ('pii_type' = 'age');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `storage_path` SET TAGS ('pii_business_glossary_term' = 'Storage Path');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `storage_path` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `storage_provider` SET TAGS ('pii_business_glossary_term' = 'Storage Provider');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `technical_owner_email` SET TAGS ('pii_business_glossary_term' = 'Technical Owner Email');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `technical_owner_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `technical_owner_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `technical_owner_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `technical_owner_email` SET TAGS ('pii_type' = 'email');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `technical_owner_name` SET TAGS ('pii_business_glossary_term' = 'Technical Owner Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `technical_owner_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `technical_owner_name` SET TAGS ('pii_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `technical_owner_name` SET TAGS ('pii_person_type' = 'person_name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `technical_owner_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `technical_owner_name` SET TAGS ('pii_masking_policy' = 'mask_non_prod');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `technical_owner_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` SET TAGS ('pii_subdomain' = 'digital_delivery');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `it_requesting_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `it_requesting_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `primary_it_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `primary_it_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `approver_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `requester_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `requester_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `requester_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `vendor_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` SET TAGS ('pii_subdomain' = 'service_operations');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `cab_meeting_id` SET TAGS ('pii_business_glossary_term' = 'Cab Meeting Identifier');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `cab_staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `cab_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `cab_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `followup_cab_meeting_id` SET TAGS ('pii_business_glossary_term' = 'Followup Cab Meeting Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `followup_cab_meeting_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `action_items_count` SET TAGS ('pii_business_glossary_term' = 'Action Items Count');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `actual_end_time` SET TAGS ('pii_business_glossary_term' = 'Actual End Time');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `actual_start_time` SET TAGS ('pii_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `agenda_document_url` SET TAGS ('pii_business_glossary_term' = 'Agenda Document Url');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `changes_approved` SET TAGS ('pii_business_glossary_term' = 'Changes Approved');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `changes_deferred` SET TAGS ('pii_business_glossary_term' = 'Changes Deferred');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `changes_rejected` SET TAGS ('pii_business_glossary_term' = 'Changes Rejected');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `fiscal_quarter` SET TAGS ('pii_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `is_emergency_meeting` SET TAGS ('pii_business_glossary_term' = 'Is Emergency Meeting');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `meeting_location` SET TAGS ('pii_business_glossary_term' = 'Meeting Location');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `meeting_location` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `meeting_notes` SET TAGS ('pii_business_glossary_term' = 'Meeting Notes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `meeting_number` SET TAGS ('pii_business_glossary_term' = 'Meeting Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `meeting_platform` SET TAGS ('pii_business_glossary_term' = 'Meeting Platform');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `meeting_series_code` SET TAGS ('pii_business_glossary_term' = 'Meeting Series Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `meeting_status` SET TAGS ('pii_business_glossary_term' = 'Meeting Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `meeting_type` SET TAGS ('pii_business_glossary_term' = 'Meeting Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `minutes_document_url` SET TAGS ('pii_business_glossary_term' = 'Minutes Document Url');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `next_meeting_date` SET TAGS ('pii_business_glossary_term' = 'Next Meeting Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `quorum_met` SET TAGS ('pii_business_glossary_term' = 'Quorum Met');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `quorum_required` SET TAGS ('pii_business_glossary_term' = 'Quorum Required');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `recording_url` SET TAGS ('pii_business_glossary_term' = 'Recording Url');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `scheduled_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `scheduled_end_time` SET TAGS ('pii_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `scheduled_start_time` SET TAGS ('pii_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `total_attendees` SET TAGS ('pii_business_glossary_term' = 'Total Attendees');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `total_changes_reviewed` SET TAGS ('pii_business_glossary_term' = 'Total Changes Reviewed');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `voting_members_present` SET TAGS ('pii_business_glossary_term' = 'Voting Members Present');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` SET TAGS ('pii_subdomain' = 'service_operations');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` SET TAGS ('pii_subdomain' = 'service_operations');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` SET TAGS ('pii_tier' = 'ecm');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `author_name` SET TAGS ('pii_type' = 'name');
