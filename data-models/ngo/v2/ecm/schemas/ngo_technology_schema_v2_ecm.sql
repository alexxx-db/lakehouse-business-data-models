-- Schema for Domain: technology | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 18:48:27

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`technology` COMMENT 'Manages organizational IT systems, digital platforms (KoboToolbox, CommCare, DHIS2, Salesforce, SAP), data governance, information security, and technology infrastructure supporting humanitarian operations';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`it_asset` (
    `it_asset_id` BIGINT COMMENT 'Unique identifier for the IT asset record. Primary key.',
    `network_site_id` BIGINT COMMENT 'Foreign key linking to technology.network_site. Business justification: IT assets are deployed at specific network sites (HQ, field offices, data centers). N:1 relationship - many assets at one network site. Enables physical/logical location tracking, network capacity pla',
    `parent_it_asset_id` BIGINT COMMENT 'Self-referencing FK on it_asset (parent_it_asset_id)',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member or employee to whom the asset is currently assigned for use.',
    `vendor_id` BIGINT COMMENT 'FK to supply.vendor',
    `assigned_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the country where the asset is deployed.. Valid values are `^[A-Z]{3}$`',
    `assigned_location_name` STRING COMMENT 'Name or identifier of the specific office, field location, or facility where the asset is assigned.',
    `assigned_location_type` STRING COMMENT 'Type of organizational location where the asset is currently deployed or stored.. Valid values are `headquarters|country_office|field_office|warehouse|remote`',
    `assignment_date` DATE COMMENT 'Date on which the asset was assigned to the current staff member or location.',
    `it_asset_category` STRING COMMENT 'Detailed categorization of the asset within its type, specifying the specific kind of hardware or software. [ENUM-REF-CANDIDATE: laptop|desktop|server|tablet|smartphone|router|switch|firewall|printer|scanner|application_software|operating_system|database|middleware — 14 candidates stripped; promote to reference product]',
    `condition` STRING COMMENT 'Assessment of the physical or functional condition of the asset, used for maintenance planning and disposal decisions. [ENUM-REF-CANDIDATE: new|excellent|good|fair|poor|damaged|obsolete — 7 candidates stripped; promote to reference product]',
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
    `tag` STRING COMMENT 'Externally visible unique identifier affixed to the physical asset for inventory tracking and auditing purposes.. Valid values are `^[A-Z0-9]{6,20}$`',
    `it_asset_type` STRING COMMENT 'High-level classification of the IT asset distinguishing between hardware, software, network equipment, mobile devices, peripherals, and licenses.. Valid values are `hardware|software|network_equipment|mobile_device|peripheral|license`',
    `useful_life_years` STRING COMMENT 'Expected useful life of the asset in years, used for depreciation and replacement planning.',
    `warranty_expiry_date` DATE COMMENT 'Date on which the manufacturer or vendor warranty coverage ends, after which maintenance costs may increase.',
    `warranty_start_date` DATE COMMENT 'Date on which the manufacturer or vendor warranty coverage begins.',
    `warranty_type` STRING COMMENT 'Type of warranty coverage applicable to the asset, distinguishing between manufacturer, extended, or third-party warranties.. Valid values are `manufacturer|extended|third_party|none`',
    CONSTRAINT pk_it_asset PRIMARY KEY(`it_asset_id`)
) COMMENT 'Master catalog of all IT hardware and software assets owned or leased by the NGO, including laptops, servers, networking equipment, mobile devices, and licensed software. Captures asset tag, serial number, model, manufacturer, procurement date, warranty expiry, assigned location (country office or HQ), assigned staff member, asset condition, and lifecycle status (active, in-repair, decommissioned). SSOT for IT asset inventory across all field and HQ locations.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`system_platform` (
    `system_platform_id` BIGINT COMMENT 'Unique identifier for the system platform record. Primary key.',
    `parent_system_platform_id` BIGINT COMMENT 'Self-referencing FK on system_platform (parent_system_platform_id)',
    `annual_cost` DECIMAL(18,2) COMMENT 'Total annual cost for the platform including license fees, subscription fees, support costs, and hosting costs.',
    `api_endpoint` STRING COMMENT 'Base URL or endpoint for the platforms application programming interface (API) if available.',
    `authentication_method` STRING COMMENT 'Primary authentication method used to access the platform (SSO, LDAP, OAuth, SAML, Multi-Factor Authentication, Username Password, API Key, Certificate, Other). [ENUM-REF-CANDIDATE: SSO|LDAP|OAuth|SAML|Multi-Factor Authentication|Username Password|API Key|Certificate|Other — 9 candidates stripped; promote to reference product]',
    `backup_frequency` STRING COMMENT 'Frequency at which data backups are performed for this platform (Real-Time, Hourly, Daily, Weekly, Monthly, On-Demand, Not Applicable). [ENUM-REF-CANDIDATE: Real-Time|Hourly|Daily|Weekly|Monthly|On-Demand|Not Applicable — 7 candidates stripped; promote to reference product]',
    `system_platform_code` STRING COMMENT 'Short alphanumeric code or abbreviation used internally to reference the platform (e.g., KOBO, DHIS2, SFDC, SAP, WD).',
    `compliance_frameworks` STRING COMMENT 'Comma-separated list of compliance frameworks or standards that this platform must adhere to (e.g., GDPR, HIPAA, SOC 2, ISO 27001, CHS, Sphere, IATI, 2 CFR 200).',
    `contract_end_date` DATE COMMENT 'End date or expiration date of the current contract or subscription agreement. Null for perpetual licenses or open-ended agreements.',
    `contract_reference` STRING COMMENT 'Reference number or identifier of the contract, license agreement, or subscription agreement governing the use of this platform.',
    `contract_start_date` DATE COMMENT 'Start date of the current contract or subscription agreement for the platform.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this system platform record was first created in the registry.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the annual cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `data_classification_level` STRING COMMENT 'Highest data classification level of information stored or processed by this platform (restricted, confidential, internal, public).. Valid values are `restricted|confidential|internal|public`',
    `decommission_date` DATE COMMENT 'Date when the platform was or is planned to be decommissioned and taken out of service. Null for active platforms.',
    `deployment_type` STRING COMMENT 'Deployment model of the platform indicating where and how it is hosted (Cloud, On-Premise, Hybrid, SaaS, PaaS, IaaS).. Valid values are `Cloud|On-Premise|Hybrid|SaaS|PaaS|IaaS`',
    `system_platform_description` STRING COMMENT 'Detailed description of the platforms purpose, capabilities, and business functions it supports.',
    `disaster_recovery_tier` STRING COMMENT 'Disaster recovery tier classification indicating the criticality and recovery time objectives for the platform (Tier 0 = Mission Critical, Tier 4 = Non-Critical).. Valid values are `Tier 0|Tier 1|Tier 2|Tier 3|Tier 4|Not Applicable`',
    `geographic_coverage` STRING COMMENT 'Geographic scope or regions where this platform is deployed or accessible (e.g., Global, Regional, Country-Specific). Use three-letter ISO country codes where applicable.',
    `go_live_date` DATE COMMENT 'Date when the platform was first deployed and made operational for business use.',
    `hosting_environment` STRING COMMENT 'Specific hosting environment or infrastructure provider (e.g., AWS, Azure, Google Cloud, On-Premise Data Center, Vendor-Hosted).',
    `integration_count` STRING COMMENT 'Number of active integrations or interfaces connecting this platform to other systems.',
    `is_mobile_enabled` BOOLEAN COMMENT 'Indicates whether the platform has mobile application support or mobile-responsive interface (True/False).',
    `is_offline_capable` BOOLEAN COMMENT 'Indicates whether the platform supports offline data collection or operation with later synchronization (True/False). Critical for field operations in low-connectivity humanitarian contexts.',
    `license_type` STRING COMMENT 'Type of software license or subscription model (e.g., Perpetual, Subscription, Open Source, Freemium, Enterprise, Named User, Concurrent User). [ENUM-REF-CANDIDATE: Perpetual|Subscription|Open Source|Freemium|Enterprise|Named User|Concurrent User|Other — 8 candidates stripped; promote to reference product]',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified this system platform record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this system platform record was last modified or updated.',
    `system_platform_name` STRING COMMENT 'Official name of the digital platform or enterprise information system (e.g., KoboToolbox, CommCare, DHIS2, Salesforce Nonprofit Cloud, SAP S/4HANA for Nonprofits, Workday HCM, Raisers Edge NXT, Unit4 ERP, Power BI, Tableau).',
    `notes` STRING COMMENT 'Additional notes, comments, or special considerations related to the platform.',
    `primary_business_domain` STRING COMMENT 'Primary business domain or functional area that this platform serves (e.g., Beneficiary, Program, Grant, Donor, Finance, Workforce, Volunteer, Supply Chain, Field Operations, Monitoring and Evaluation, Partnership, Communications, Technology, Compliance). [ENUM-REF-CANDIDATE: Beneficiary|Program|Grant|Donor|Finance|Workforce|Volunteer|Supply Chain|Field Operations|Monitoring and Evaluation|Partnership|Communications|Technology|Compliance|Other — 15 candidates stripped; promote to reference product]',
    `system_platform_status` STRING COMMENT 'Current lifecycle status of the platform (Active, Inactive, Pilot, Sunset, Decommissioned, Under Implementation, Maintenance). [ENUM-REF-CANDIDATE: Active|Inactive|Pilot|Sunset|Decommissioned|Under Implementation|Maintenance — 7 candidates stripped; promote to reference product]',
    `support_tier` STRING COMMENT 'Level of support or service tier provided for the platform (Standard, Premium, Enterprise, Community, Internal, Vendor-Managed).. Valid values are `Standard|Premium|Enterprise|Community|Internal|Vendor-Managed`',
    `system_owner` STRING COMMENT 'Name or identifier of the individual or role responsible for the business ownership and governance of this platform.',
    `technical_owner` STRING COMMENT 'Name or identifier of the individual or role responsible for the technical administration and support of this platform.',
    `system_platform_type` STRING COMMENT 'Categorical classification of the platform by its primary business function (e.g., ERP, CRM, HRIS, GIS, Data Collection, Business Intelligence, Grant Management, Donor Management, Case Management, Health Information System, Financial Management, Custom Application, Collaboration Platform, Other). [ENUM-REF-CANDIDATE: ERP|CRM|HRIS|GIS|Data Collection|Business Intelligence|Grant Management|Donor Management|Case Management|Health Information System|Financial Management|Custom Application|Collaboration Platform|Other — 14 candidates stripped; promote to reference product]',
    `url` STRING COMMENT 'Primary web URL or access endpoint for the platform.',
    `user_count` STRING COMMENT 'Total number of licensed or active users for the platform.',
    `vendor_name` STRING COMMENT 'Name of the software vendor or provider (e.g., Salesforce, SAP, Workday, Blackbaud, Unit4, DHIS2 Core Team, Harvard Humanitarian Initiative).',
    `version` STRING COMMENT 'Current version number or release identifier of the platform (e.g., 2023.1, v4.5.2, Spring 24).',
    `created_by` STRING COMMENT 'Identifier of the user or system that created this system platform record.',
    CONSTRAINT pk_system_platform PRIMARY KEY(`system_platform_id`)
) COMMENT 'Master registry of all digital platforms and enterprise information systems deployed across the NGO, including KoboToolbox, CommCare, DHIS2, Salesforce, SAP S/4HANA, Workday, Raisers Edge NXT, and custom-built applications. Captures platform name, vendor, version, deployment type (cloud/on-premise/hybrid), hosting environment, primary business domain served, contract reference, go-live date, decommission date, and system owner. SSOT for the organizational application portfolio.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`it_service` (
    `it_service_id` BIGINT COMMENT 'Unique identifier for the IT service. Primary key for the IT service catalog.',
    `parent_it_service_id` BIGINT COMMENT 'Self-referencing FK on it_service (parent_it_service_id)',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: IT services are delivered via specific platforms (e.g., Email service via Exchange platform, Helpdesk service via ServiceNow platform). This FK tracks the PRIMARY platform. N:1 relationship - many ser',
    `access_request_process` STRING COMMENT 'Process required for users to request access to this service: self_service (automatic provisioning), manager_approval (requires line manager approval), it_approval (requires IT team approval), or security_clearance (requires security review).. Valid values are `self_service|manager_approval|it_approval|security_clearance`',
    `authentication_method` STRING COMMENT 'Primary authentication mechanism for accessing the service: single_sign_on (SSO via organizational identity provider), username_password (basic credentials), multi_factor (MFA required), or certificate_based (digital certificates).. Valid values are `single_sign_on|username_password|multi_factor|certificate_based`',
    `availability_target_percent` DECIMAL(18,2) COMMENT 'Target uptime percentage for the service as defined in the SLA (e.g., 99.9% for critical services, 95% for standard services). Measured over a calendar month.',
    `backup_frequency` STRING COMMENT 'Frequency at which data for this service is backed up: real_time (continuous replication), hourly, daily, weekly, monthly, or not_applicable (service does not store data requiring backup).. Valid values are `real_time|hourly|daily|weekly|monthly|not_applicable`',
    `it_service_category` STRING COMMENT 'High-level classification of the IT service type: connectivity (internet, VPN), infrastructure (servers, storage), application (Salesforce, SAP, DHIS2), support (helpdesk, training), security (firewall, antivirus), or data_management (backup, archiving).. Valid values are `connectivity|infrastructure|application|support|security|data_management`',
    `it_service_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the service for internal reference and system integration (e.g., EMAIL-001, VPN-002, STORAGE-003).. Valid values are `^[A-Z0-9]{3,10}$`',
    `compliance_frameworks` STRING COMMENT 'Comma-separated list of regulatory or compliance frameworks this service must adhere to (e.g., GDPR, HIPAA, ISO 27001, CHS, Sphere Standards, OMB Uniform Guidance). Used for audit and compliance reporting.',
    `contract_reference_number` STRING COMMENT 'Reference number of the contract or agreement governing the service provision, if applicable. Used for vendor management and compliance tracking.',
    `cost_allocation_method` STRING COMMENT 'Method used to allocate service costs to programs or departments: direct_charge (charged to specific cost centers), shared_pool (distributed across all users), overhead (absorbed in indirect costs), or grant_funded (covered by specific donor grants).. Valid values are `direct_charge|shared_pool|overhead|grant_funded`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service record was first created in the IT service catalog system.',
    `data_classification_level` STRING COMMENT 'Highest classification level of data handled by this service: public (no restrictions), internal (internal use only), confidential (business-sensitive), or restricted (PII, PHI, or donor-sensitive data).. Valid values are `public|internal|confidential|restricted`',
    `delivery_model` STRING COMMENT 'How the service is delivered: in_house (managed by internal IT team), outsourced (managed by external vendor), hybrid (combination of internal and external), or cloud_saas (Software as a Service from cloud provider).. Valid values are `in_house|outsourced|hybrid|cloud_saas`',
    `it_service_description` STRING COMMENT 'Detailed description of what the IT service provides, its purpose, and how it supports humanitarian operations and staff productivity.',
    `disaster_recovery_rpo_hours` STRING COMMENT 'Recovery Point Objective (RPO) in hours: maximum acceptable age of data that may be lost in a disaster. Defines backup frequency requirements.',
    `disaster_recovery_rto_hours` STRING COMMENT 'Recovery Time Objective (RTO) in hours: maximum acceptable time to restore the service after a disaster or major outage. Critical for business continuity planning.',
    `geographic_coverage` STRING COMMENT 'Geographic scope of service availability: global (all locations), regional (specific regions), country_specific (single country operations), or headquarters_only (HQ office only).. Valid values are `global|regional|country_specific|headquarters_only`',
    `hours` STRING COMMENT 'Hours during which the service is available and supported: 24x7 (24 hours, 7 days a week), business_hours (Monday-Friday, 9am-5pm local time), extended_hours (weekdays plus evenings/weekends), or on_demand (available upon request).. Valid values are `24x7|business_hours|extended_hours|on_demand`',
    `knowledge_base_url` STRING COMMENT 'URL link to the knowledge base, user guide, or documentation portal for this service. Enables self-service support and user training.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service record was last updated in the IT service catalog system. Used for change tracking and audit trails.',
    `last_review_date` DATE COMMENT 'Date when the service was last reviewed for performance, cost-effectiveness, and alignment with business needs. Part of continuous service improvement.',
    `launch_date` DATE COMMENT 'Date when the service was first made available to users in production. Used for service lifecycle tracking and anniversary reporting.',
    `manager_name` STRING COMMENT 'Name of the individual responsible for day-to-day operational management of the service, including incident response and user support.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the IT staff member who last modified this service record. Used for accountability and audit purposes.',
    `monthly_cost_usd` DECIMAL(18,2) COMMENT 'Average monthly cost in USD to deliver this service, including licensing, infrastructure, support, and vendor fees. Used for IT budget planning and cost allocation.',
    `it_service_name` STRING COMMENT 'The official name of the IT service as presented to users (e.g., Email Service, VPN Access, Cloud Storage, Helpdesk Support).',
    `next_review_date` DATE COMMENT 'Scheduled date for the next service review. Ensures regular evaluation of service performance and relevance.',
    `owner_email` STRING COMMENT 'Primary email contact for the service owner for escalations and service-related inquiries.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `owner_name` STRING COMMENT 'Name of the individual accountable for the service delivery, performance, and continuous improvement. Typically a senior IT manager or director.',
    `resolution_time_target_hours` STRING COMMENT 'Maximum time in hours to resolve an incident or fulfill a service request for this service, as defined in the SLA.',
    `response_time_target_minutes` STRING COMMENT 'Maximum time in minutes for the IT team to acknowledge and begin working on an incident or service request for this service, as defined in the SLA.',
    `retirement_date` DATE COMMENT 'Planned or actual date when the service will be or was decommissioned and removed from the service catalog. Null for active services.',
    `sla_tier` STRING COMMENT 'Service level tier defining response and resolution commitments: platinum (mission-critical, 24/7 support), gold (high priority, business hours), silver (standard support), bronze (basic support), or best_effort (no guaranteed SLA).. Valid values are `platinum|gold|silver|bronze|best_effort`',
    `it_service_status` STRING COMMENT 'Current lifecycle status of the IT service: active (available for use), inactive (temporarily unavailable), retired (decommissioned), under_development (being built), pilot (limited rollout), or maintenance (scheduled downtime).. Valid values are `active|inactive|retired|under_development|pilot|maintenance`',
    `support_contact_email` STRING COMMENT 'Primary email address for users to request support or report issues with this service (e.g., helpdesk@ngo.org, itsupport@ngo.org).. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `support_phone_number` STRING COMMENT 'Primary phone number for users to contact IT support for this service. May include international dialing codes for global services.',
    `supported_user_population` STRING COMMENT 'Primary user group or population that this service is designed to support: all_staff, field_operations (humanitarian workers in the field), headquarters (HQ staff), program_staff, finance_staff, senior_management, or external_partners (donors, implementing partners). [ENUM-REF-CANDIDATE: all_staff|field_operations|headquarters|program_staff|finance_staff|senior_management|external_partners — 7 candidates stripped; promote to reference product]',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether formal training is required before users can access this service. True if training is mandatory, False if service is self-explanatory or training is optional.',
    `it_service_type` STRING COMMENT 'ITIL service classification: business_service (directly supports business operations), technical_service (underlying infrastructure), or supporting_service (enables other services).. Valid values are `business_service|technical_service|supporting_service`',
    `vendor_name` STRING COMMENT 'Name of the external vendor or service provider if the service is outsourced or provided via SaaS (e.g., Microsoft, Salesforce, Amazon Web Services). Null for in-house services.',
    CONSTRAINT pk_it_service PRIMARY KEY(`it_service_id`)
) COMMENT 'Master catalog of IT services offered by the technology team to internal staff and field operations, including connectivity services, helpdesk support, cloud storage, email, VPN access, data backup, and platform administration. Captures service name, service category, service owner, SLA tier, supported user population, availability target, and current service status. Aligned with ITIL service catalog practices.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`service_request` (
    `service_request_id` BIGINT COMMENT 'Unique identifier for the IT service request ticket. Primary key.',
    `country_office_id` BIGINT COMMENT 'Identifier of the office or field location where the requester is based (HQ, regional office, country office, field site).',
    `it_asset_id` BIGINT COMMENT 'Identifier of the specific hardware asset or device affected (e.g., laptop serial number, desktop tag, mobile device IMEI, printer asset code). Null if request is not hardware-related.',
    `it_service_id` BIGINT COMMENT 'Foreign key linking to technology.it_service. Business justification: Service requests are raised for specific IT services from the service catalog. The affected_system STRING field should be normalized to FK relationship with it_service. N:1 relationship - many service',
    `knowledge_article_id` BIGINT COMMENT 'Identifier of the knowledge base article used or created as a result of resolving this service request. Null if no article linked.',
    `parent_service_request_id` BIGINT COMMENT 'Self-referencing FK on service_request (related_service_request_id)',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member who submitted the service request.',
    `it_incident_id` BIGINT COMMENT 'Identifier of a related major incident or problem ticket if this service request is linked to a broader system issue. Null if standalone.',
    `change_request_id` BIGINT COMMENT 'Foreign key linking to technology.change_request. Business justification: Service requests can escalate to formal change requests when they require CAB approval or significant system modifications. N:1 relationship (service request escalates to change). Temporal note: FK po',
    `assigned_timestamp` TIMESTAMP COMMENT 'Date and time when the service request was assigned to a technician or support group. Null if not yet assigned.',
    `assignment_group` STRING COMMENT 'Name of the IT support team or functional group responsible for handling the request (e.g., Desktop Support, Network Operations, Application Support, Field IT, Security Operations).',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the service request was formally closed, typically after requester confirmation or auto-closure. Null if not yet closed.',
    `contact_method` STRING COMMENT 'Channel through which the service request was submitted: web portal (self-service), email, phone call, live chat, walk-in (in-person), or mobile app.. Valid values are `web_portal|email|phone|chat|walk_in|mobile_app`',
    `cost_center_code` STRING COMMENT 'Cost center or budget code to which IT support costs for this service request are allocated, typically aligned with the requesters department or program.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the service request record was first created in the IT helpdesk system.',
    `service_request_description` STRING COMMENT 'Detailed description of the issue or service need provided by the requester, including symptoms, error messages, and context.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the service request was escalated to higher-level support or management (True = escalated, False = not escalated).',
    `escalation_reason` STRING COMMENT 'Reason for escalating the service request (e.g., SLA breach, technical complexity, VIP requester, repeated issue). Null if not escalated.',
    `first_response_timestamp` TIMESTAMP COMMENT 'Date and time when the assigned technician first acknowledged or responded to the service request. Null if no response yet.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the service request record was last updated in the IT helpdesk system.',
    `priority_level` STRING COMMENT 'Business priority assigned to the service request based on impact and urgency: critical (mission-critical system down), high (major functionality impaired), medium (moderate impact), or low (minor inconvenience).. Valid values are `critical|high|medium|low`',
    `reopened_count` STRING COMMENT 'Number of times the service request was reopened after initial resolution due to recurring issues or incomplete resolution.',
    `requester_feedback` STRING COMMENT 'Free-text feedback or comments provided by the requester about the service experience. Null if no feedback provided.',
    `requester_satisfaction_rating` STRING COMMENT 'Satisfaction score provided by the requester after resolution, typically on a scale of 1 to 5 (1 = very dissatisfied, 5 = very satisfied). Null if feedback not provided.',
    `resolution_category` STRING COMMENT 'Classification of how the request was resolved (e.g., hardware replacement, software configuration, password reset, user training, escalation to vendor, workaround provided). Null if not yet resolved.',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the actions taken by the technician to resolve the request, including troubleshooting steps, configuration changes, and final solution. Null if not yet resolved.',
    `resolved_timestamp` TIMESTAMP COMMENT 'Date and time when the service request was marked as resolved by the technician. Null if not yet resolved.',
    `root_cause` STRING COMMENT 'Identified underlying cause of the issue (e.g., hardware failure, software bug, user error, network outage, configuration drift). Null if not determined or not applicable.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the service request resolution exceeded the SLA target time (True = breached, False = within SLA).',
    `sla_target_hours` DECIMAL(18,2) COMMENT 'Target resolution time in hours as defined by the IT service level agreement for this request type and priority combination.',
    `service_request_status` STRING COMMENT 'Current lifecycle status of the service request: open (newly submitted), assigned (allocated to technician), in_progress (actively being worked), pending_user (awaiting requester input), resolved (solution provided), closed (confirmed complete), or cancelled (withdrawn). [ENUM-REF-CANDIDATE: open|assigned|in_progress|pending_user|resolved|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `subject` STRING COMMENT 'Brief summary or title of the service request as entered by the requester (e.g., Laptop not connecting to VPN, Request access to Salesforce reports).',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the service request was originally submitted by the requester.',
    `ticket_number` STRING COMMENT 'Human-readable external ticket number assigned by the IT helpdesk system (e.g., INC-000012345, SR-20230415-001).. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `time_spent_hours` DECIMAL(18,2) COMMENT 'Total technician effort hours logged against this service request for resolution activities. Null if not yet tracked or resolved.',
    `service_request_type` STRING COMMENT 'Category of the IT service request: hardware fault (device malfunction), software access (application permissions), connectivity issue (network/internet), platform support (KoboToolbox, CommCare, DHIS2, Salesforce, SAP assistance), data recovery (backup restoration), or account provisioning (new user setup).. Valid values are `hardware_fault|software_access|connectivity_issue|platform_support|data_recovery|account_provisioning`',
    CONSTRAINT pk_service_request PRIMARY KEY(`service_request_id`)
) COMMENT 'Transactional record of every IT helpdesk and service desk request raised by staff across HQ and field offices. Captures request type (hardware fault, software access, connectivity issue, platform support, data recovery), requester identity, affected system or asset, priority level, assigned technician, SLA breach flag, resolution notes, and closure timestamp. Sourced from the IT helpdesk ticketing system (e.g., Freshservice, Jira Service Management).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`change_request` (
    `change_request_id` BIGINT COMMENT 'Unique identifier for the IT change request record. Primary key.',
    `cab_meeting_id` BIGINT COMMENT 'Identifier of the CAB meeting session where this change request was reviewed. Links to meeting records for audit trail and decision context.',
    `it_project_id` BIGINT COMMENT 'Foreign key linking to technology.it_project. Business justification: Change requests can be part of larger IT projects (e.g., project-driven changes vs. ad-hoc operational changes). N:1 relationship - many change requests can belong to one project. Enables project-leve',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member or system user who submitted the change request. Links to workforce or user management system.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Change requests target specific platforms for modifications. While affected_systems is a STRING list (multiple systems), this FK tracks the PRIMARY system being changed. N:1 relationship - many change',
    `rollback_change_request_id` BIGINT COMMENT 'Self-referencing FK on change_request (rollback_change_request_id)',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when change implementation was completed. Used for duration analysis and schedule variance reporting.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when change implementation began. Used for tracking adherence to schedule and post-implementation analysis.',
    `affected_services` STRING COMMENT 'Business services and operational capabilities that may experience disruption or modification during change implementation. Used for stakeholder notification and service continuity planning.',
    `affected_systems` STRING COMMENT 'Comma-separated list or description of IT systems, platforms, and applications that will be modified or impacted by the change. Examples include Salesforce, SAP, DHIS2, KoboToolbox, CommCare.',
    `approval_notes` STRING COMMENT 'Comments, conditions, or recommendations provided by approvers during the review process. Captures decision rationale and any special instructions.',
    `assigned_to_name` STRING COMMENT 'Full name of the individual or team assigned to execute the change implementation. Provides accountability and contact information.',
    `cab_approval_date` DATE COMMENT 'Date when the Change Advisory Board formally approved or rejected the change request. Null if CAB review is not required or not yet completed.',
    `cab_approval_required` BOOLEAN COMMENT 'Indicates whether the change requires formal review and approval by the Change Advisory Board. True for normal and emergency changes; false for standard pre-approved changes.',
    `cab_approval_status` STRING COMMENT 'Current approval decision status from the Change Advisory Board. Conditional approval indicates approval with specific requirements or constraints.. Valid values are `pending|approved|rejected|conditional|not_required`',
    `change_category` STRING COMMENT 'Functional area or domain affected by the change request. Used for routing to appropriate technical teams and impact analysis.. Valid values are `infrastructure|application|security|network|database|platform`',
    `change_number` STRING COMMENT 'Externally-visible unique change request number following organizational numbering convention (e.g., CHG0001234). Used for tracking and communication across IT teams and stakeholders.. Valid values are `^CHG[0-9]{7}$`',
    `change_type` STRING COMMENT 'Classification of the change request based on risk, urgency, and approval requirements. Standard changes are pre-approved low-risk changes; normal changes require CAB review; emergency changes address critical incidents; expedited changes are fast-tracked normal changes.. Valid values are `standard|normal|emergency|expedited`',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the change request was formally closed after successful implementation and post-implementation review. Marks the end of the change lifecycle.',
    `closure_notes` STRING COMMENT 'Final comments and summary recorded when closing the change request. Documents final disposition and any outstanding items or follow-up actions.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the change request record was first created in the system. Used for audit trail and lifecycle tracking.',
    `change_request_description` STRING COMMENT 'Detailed narrative describing the change to be implemented, including technical specifications, configuration modifications, and scope of work. Provides comprehensive context for reviewers and implementers.',
    `downtime_required` BOOLEAN COMMENT 'Indicates whether the change implementation requires system or service downtime. True if downtime is necessary; false if change can be implemented without service interruption.',
    `estimated_downtime_minutes` STRING COMMENT 'Anticipated duration of system or service unavailability during change implementation, measured in minutes. Used for scheduling and stakeholder communication.',
    `impact_assessment` STRING COMMENT 'Detailed analysis of potential effects on systems, services, users, and business operations. Identifies affected components, dependencies, and downstream consequences.',
    `implementation_outcome` STRING COMMENT 'Final result of the change implementation. Successful indicates change achieved objectives; failed indicates implementation did not complete; partially successful indicates some objectives met; rolled back indicates change was reverted.. Valid values are `successful|failed|partially_successful|rolled_back`',
    `implementation_plan` STRING COMMENT 'Step-by-step technical procedure for executing the change, including pre-implementation tasks, execution steps, validation checkpoints, and post-implementation activities.',
    `justification` STRING COMMENT 'Business rationale and expected benefits of implementing the change. Explains why the change is necessary and how it supports organizational objectives or resolves issues.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the change request record was last updated. Tracks most recent modification for audit and synchronization purposes.',
    `post_implementation_notes` STRING COMMENT 'Summary of post-implementation review findings, including actual vs. expected outcomes, issues encountered, lessons learned, and recommendations for future changes.',
    `post_implementation_review_completed` BOOLEAN COMMENT 'Indicates whether a formal post-implementation review has been conducted to assess change success, lessons learned, and process improvements. Required for normal and emergency changes.',
    `post_implementation_review_date` DATE COMMENT 'Date when the post-implementation review was completed. Used for tracking compliance with change management process requirements.',
    `priority` STRING COMMENT 'Urgency and importance level assigned to the change request. Determines review timeline and implementation scheduling relative to other changes.. Valid values are `critical|high|medium|low`',
    `requester_email` STRING COMMENT 'Email address of the change requester for status updates and communication throughout the change lifecycle.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requester_name` STRING COMMENT 'Full name of the individual who initiated the change request. Provides human-readable identification for reporting and communication.',
    `risk_level` STRING COMMENT 'Overall risk rating assigned to the change based on potential impact to systems, services, and operations. Influences approval authority and implementation controls.. Valid values are `low|medium|high|critical`',
    `rollback_plan` STRING COMMENT 'Documented procedure for reverting the change and restoring systems to their previous state if implementation fails or causes unacceptable issues. Critical for risk mitigation.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned date and time when change implementation should be completed. Defines the end of the approved implementation window.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned date and time when change implementation will begin. Defines the start of the implementation window approved by Change Advisory Board (CAB).',
    `change_request_status` STRING COMMENT 'Current lifecycle state of the change request in the approval and implementation workflow. Tracks progression from initial submission through completion or cancellation. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|scheduled|in_progress|implemented|closed|cancelled — 10 candidates stripped; promote to reference product]',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the change request was formally submitted for review. Marks the beginning of the change request lifecycle and approval workflow.',
    `test_plan` STRING COMMENT 'Testing strategy and validation procedures to verify successful implementation and confirm that the change achieves intended outcomes without introducing defects.',
    `title` STRING COMMENT 'Brief descriptive title summarizing the nature and purpose of the change request. Should be concise yet informative for quick identification.',
    CONSTRAINT pk_change_request PRIMARY KEY(`change_request_id`)
) COMMENT 'Transactional record of formal IT change requests submitted for review and approval before implementation, covering system upgrades, configuration changes, platform migrations, network modifications, and security patches. Captures change type (standard, normal, emergency), risk assessment, change advisory board (CAB) approval status, rollback plan, implementation window, and post-implementation review outcome. Supports ITIL Change Management process.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`it_incident` (
    `it_incident_id` BIGINT COMMENT 'Unique identifier for the IT incident record. Primary key.',
    `caused_by_it_incident_id` BIGINT COMMENT 'Self-referencing FK on it_incident (caused_by_it_incident_id)',
    `it_problem_id` BIGINT COMMENT 'Identifier of the related problem record if this incident is linked to a known underlying problem requiring root cause analysis and permanent fix.',
    `it_service_id` BIGINT COMMENT 'Foreign key linking to technology.it_service. Business justification: IT incidents disrupt specific IT services. The affected_service STRING field should be normalized to FK. N:1 relationship - many incidents affect one service. Core ITSM relationship for service availa',
    `change_request_id` BIGINT COMMENT 'Identifier of the related change request if this incident was caused by or resolved through a change to IT infrastructure or configuration.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: IT incidents occur on specific platforms and disrupt their operations. The affected_system STRING field should be normalized to FK. N:1 relationship - many incidents can affect one platform. Core inci',
    `acknowledged_timestamp` TIMESTAMP COMMENT 'Date and time when the assigned team acknowledged receipt and began investigation.',
    `affected_country_office` STRING COMMENT 'Three-letter ISO country code of the country office or field location experiencing the incident (e.g., KEN for Kenya, SYR for Syria, USA for headquarters). Null if incident is global.. Valid values are `^[A-Z]{3}$`',
    `affected_program` STRING COMMENT 'Name or code of the humanitarian program or project impacted by the incident (e.g., WASH Emergency Response, Health Services Delivery, Education Access Program).',
    `assigned_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was assigned to a support team or individual.',
    `assigned_to` STRING COMMENT 'Name or identifier of the IT support team member or group currently responsible for resolving the incident.',
    `breach_notification_required` BOOLEAN COMMENT 'Indicates whether regulatory breach notification is required under GDPR, CCPA, or other data protection laws.',
    `business_impact` STRING COMMENT 'Assessment of the business impact of the incident: critical (mission-critical operations halted), high (major program disruption), medium (moderate inconvenience), low (minimal impact).. Valid values are `critical|high|medium|low`',
    `it_incident_category` STRING COMMENT 'High-level classification of the incident type: hardware failure, software defect, network outage, security breach, data loss, or platform unavailability.. Valid values are `hardware|software|network|security|data|platform`',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was formally closed after user confirmation that the issue is resolved.',
    `communication_sent` BOOLEAN COMMENT 'Indicates whether a communication or notification was sent to affected users or stakeholders about the incident.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this incident record was first created in the IT service management system.',
    `data_breach` BOOLEAN COMMENT 'Indicates whether the incident resulted in unauthorized access to or disclosure of sensitive data (beneficiary PII, donor information, financial records).',
    `detected_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was first detected or when the service disruption began (may precede reported_timestamp if detected by monitoring tools).',
    `downtime_minutes` STRING COMMENT 'Total duration in minutes that the affected system or service was unavailable.',
    `escalated` BOOLEAN COMMENT 'Indicates whether the incident was escalated to higher-level support or management due to severity or complexity.',
    `escalation_level` STRING COMMENT 'Level to which the incident was escalated: L1 (first-line support), L2 (specialist support), L3 (engineering), management (executive attention), vendor (third-party escalation).. Valid values are `L1|L2|L3|management|vendor`',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was escalated.',
    `financial_impact_usd` DECIMAL(18,2) COMMENT 'Estimated financial cost of the incident in USD, including lost productivity, recovery costs, and potential donor impact.',
    `impacted_user_count` STRING COMMENT 'Estimated number of staff, volunteers, or beneficiaries affected by the incident.',
    `mean_time_to_resolution_minutes` STRING COMMENT 'Total elapsed time in minutes from incident detection to resolution. Key performance indicator for IT service quality.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this incident record was last updated.',
    `number` STRING COMMENT 'Human-readable unique incident ticket number assigned by the IT service management system (e.g., INC0012345).. Valid values are `^INC[0-9]{6,10}$`',
    `reported_by` STRING COMMENT 'Name or identifier of the person who first reported the incident (staff member, volunteer, or system monitor).',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was first reported to the IT service desk.',
    `resolution_description` STRING COMMENT 'Detailed narrative of the actions taken to resolve the incident and restore service.',
    `resolved_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was resolved and service was restored.',
    `root_cause` STRING COMMENT 'Identified underlying cause of the incident after investigation (e.g., hardware failure, software bug, configuration error, cyberattack, human error, third-party service outage).',
    `root_cause_category` STRING COMMENT 'High-level classification of the root cause for trend analysis: infrastructure failure, application defect, configuration error, security breach, human error, or third-party dependency.. Valid values are `infrastructure|application|configuration|security|human_error|third_party`',
    `security_incident` BOOLEAN COMMENT 'Indicates whether the incident is classified as a security incident (data breach, ransomware, unauthorized access, phishing attack).',
    `severity_level` STRING COMMENT 'Priority classification of the incident impact: P1 (critical - complete service outage), P2 (high - major functionality impaired), P3 (medium - partial degradation), P4 (low - minor issue).. Valid values are `P1|P2|P3|P4`',
    `it_incident_status` STRING COMMENT 'Current lifecycle state of the incident: new (just reported), assigned (routed to team), in_progress (actively being worked), pending (awaiting external input), resolved (fix applied), closed (confirmed resolved), reopened (recurred after closure). [ENUM-REF-CANDIDATE: new|assigned|in_progress|pending|resolved|closed|reopened — 7 candidates stripped; promote to reference product]',
    `subcategory` STRING COMMENT 'Detailed classification within the incident category (e.g., ransomware, server crash, database corruption, API timeout, VPN failure).',
    `user_satisfaction_rating` STRING COMMENT 'Post-resolution satisfaction rating provided by the user (typically 1-5 scale, where 5 is highly satisfied).',
    `vendor_ticket_number` STRING COMMENT 'External ticket or case number assigned by a third-party vendor or service provider if the incident was escalated externally.',
    `workaround_applied` BOOLEAN COMMENT 'Indicates whether a temporary workaround was applied to restore service before a permanent fix was implemented.',
    `workaround_description` STRING COMMENT 'Description of the temporary workaround applied, if any.',
    CONSTRAINT pk_it_incident PRIMARY KEY(`it_incident_id`)
) COMMENT 'Transactional record of unplanned IT service disruptions and outages affecting NGO operations, including system downtime, network failures, data breaches, ransomware events, and platform unavailability. Captures incident category, severity level (P1–P4), affected systems, impacted country offices or programs, root cause analysis, mean time to resolution (MTTR), and escalation history. Distinct from service_request (which covers routine requests) — this captures unplanned disruptions.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`network_site` (
    `network_site_id` BIGINT COMMENT 'Unique identifier for the network site. Primary key for the network site entity.',
    `country_id` BIGINT COMMENT 'add column country_id (BIGINT) with FK to field.country.country_id - network_site only has a self-ref and inbound refs; physical sites exist in countries',
    `upstream_network_site_id` BIGINT COMMENT 'Self-referencing FK on network_site (upstream_network_site_id)',
    `address` STRING COMMENT 'Full physical address of the network site location. Organizational contact data classified as confidential.',
    `backup_bandwidth_mbps` DECIMAL(18,2) COMMENT 'Bandwidth capacity in megabits per second (Mbps) available on the backup connectivity link.',
    `backup_connectivity_type` STRING COMMENT 'Secondary or backup connectivity technology available for failover in case primary connection fails (e.g., 4G LTE backup for fiber).',
    `bandwidth_capacity_mbps` DECIMAL(18,2) COMMENT 'Maximum bandwidth capacity in megabits per second (Mbps) available at this network site.',
    `city` STRING COMMENT 'City or municipality where the network site is located.',
    `network_site_code` STRING COMMENT 'Business identifier code for the network site, typically used in network diagrams and infrastructure documentation.. Valid values are `^[A-Z0-9]{3,12}$`',
    `compliance_certifications` STRING COMMENT 'List of compliance certifications or standards this network site adheres to (e.g., ISO 27001, SOC 2, CHS).',
    `connectivity_type` STRING COMMENT 'Primary connectivity technology used at this network site for internet and WAN access. [ENUM-REF-CANDIDATE: fiber|vsat|4g_lte|5g|microwave|satellite|dsl|cable|vpn — 9 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this network site record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date when the network site was or will be decommissioned and taken out of service.',
    `disaster_recovery_tier` STRING COMMENT 'Disaster recovery priority tier assigned to this site (e.g., Tier 1 critical, Tier 2 important, Tier 3 standard) for business continuity planning.',
    `equipment_inventory` STRING COMMENT 'Summary list of key network equipment deployed at this site (routers, switches, access points, modems).',
    `firewall_enabled` BOOLEAN COMMENT 'Indicates whether a firewall is deployed and active at this network site for security protection.',
    `installation_date` DATE COMMENT 'Date when the network site was initially installed and commissioned for operational use.',
    `ip_address_range` STRING COMMENT 'IP address range or subnet allocated to this network site (e.g., CIDR notation 10.20.30.0/24).',
    `isp_contract_number` STRING COMMENT 'Contract or account number with the ISP provider for billing and service management.',
    `isp_provider` STRING COMMENT 'Name of the Internet Service Provider or telecommunications carrier providing connectivity to this site.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent scheduled maintenance or inspection performed on this network site.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees) of the network site for GIS mapping and infrastructure planning.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees) of the network site for GIS mapping and infrastructure planning.',
    `monthly_cost_usd` DECIMAL(18,2) COMMENT 'Average monthly operational cost in US Dollars for maintaining this network site, including ISP fees, equipment leases, and support.',
    `network_site_name` STRING COMMENT 'Human-readable name of the network site (e.g., Nairobi Country Office LAN, Coxs Bazar Field Site VSAT, Geneva HQ Data Center).',
    `network_administrator_email` STRING COMMENT 'Email address of the network administrator responsible for this site. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `network_administrator_name` STRING COMMENT 'Name of the staff member or team responsible for managing and maintaining this network site.',
    `network_administrator_phone` STRING COMMENT 'Phone number of the network administrator for emergency contact and support escalation. Organizational contact data classified as confidential.',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next planned maintenance or inspection of this network site.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or special instructions related to this network site.',
    `operational_status` STRING COMMENT 'Current operational state of the network site in its lifecycle.. Valid values are `active|inactive|maintenance|planned|decommissioned|suspended`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the network site location. Organizational contact data classified as confidential.',
    `region` STRING COMMENT 'Geographic or administrative region within the country (e.g., province, state, district) where the site is located.',
    `security_classification` STRING COMMENT 'Data security classification level assigned to this network site based on the sensitivity of data and systems it hosts.. Valid values are `public|internal|confidential|restricted`',
    `network_site_type` STRING COMMENT 'Classification of the network site based on organizational function and operational role.. Valid values are `country_office|field_site|headquarters|regional_office|data_center|cloud_endpoint`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this network site record was last modified or updated.',
    `uptime_sla_percentage` DECIMAL(18,2) COMMENT 'Contractual uptime Service Level Agreement percentage guaranteed by the ISP (e.g., 99.9%).',
    `vlan_number` STRING COMMENT 'Virtual LAN identifier(s) configured at this network site for network segmentation and security.',
    `vpn_enabled` BOOLEAN COMMENT 'Indicates whether VPN connectivity is configured and available at this network site for secure remote access.',
    CONSTRAINT pk_network_site PRIMARY KEY(`network_site_id`)
) COMMENT 'Master record for each physical or logical network site in the NGOs connectivity infrastructure, including country office LANs, field site satellite/VSAT connections, HQ data center networks, and cloud VPN endpoints. Captures site name, location (country, region, GPS coordinates), connectivity type (fiber, VSAT, 4G/LTE, microwave), bandwidth capacity, ISP provider, uptime SLA, and network administrator responsible. SSOT for connectivity infrastructure topology.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` (
    `connectivity_log_id` BIGINT COMMENT 'Unique identifier for the connectivity log record.',
    `country_office_id` BIGINT COMMENT 'Reference to the field office associated with this connectivity measurement.',
    `it_incident_id` BIGINT COMMENT 'Foreign key linking to technology.it_incident. Business justification: Connectivity outages and network issues can trigger IT incidents. The incident_ticket_number STRING field should be normalized to FK. N:1 relationship - many connectivity log entries can be associated',
    `network_site_id` BIGINT COMMENT 'Reference to the network site where connectivity was measured.',
    `previous_connectivity_log_id` BIGINT COMMENT 'Self-referencing FK on connectivity_log (previous_connectivity_log_id)',
    `affected_users_count` STRING COMMENT 'Estimated number of users or staff affected by connectivity issues at this site.',
    `bandwidth_utilization_percent` DECIMAL(18,2) COMMENT 'Percentage of available bandwidth currently in use at the time of measurement.',
    `business_impact_description` STRING COMMENT 'Description of the operational or programmatic impact caused by connectivity issues.',
    `cause_classification` STRING COMMENT 'Root cause category for connectivity issues or outages. [ENUM-REF-CANDIDATE: isp_fault|power_outage|equipment_failure|weather|configuration_error|capacity_exceeded|security_incident|maintenance|natural_disaster|vandalism|unknown — promote to reference product]. Valid values are `isp_fault|power_outage|equipment_failure|weather|configuration_error|capacity_exceeded`',
    `cause_description` STRING COMMENT 'Detailed narrative description of the root cause of connectivity issues or outage.',
    `connection_status` STRING COMMENT 'Current operational status of the network connection at the time of measurement.. Valid values are `up|down|degraded|intermittent|maintenance|unknown`',
    `connection_type` STRING COMMENT 'Type of network connection technology used at this site.. Valid values are `fiber|satellite|cellular|microwave|dsl|cable`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this connectivity log record was first created in the system.',
    `device_ip_address` STRING COMMENT 'IP address of the network device or router at the measurement site.. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$`',
    `device_mac_address` STRING COMMENT 'MAC address of the network device or router at the measurement site.. Valid values are `^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$`',
    `download_speed_mbps` DECIMAL(18,2) COMMENT 'Measured download speed in megabits per second.',
    `isp_provider_name` STRING COMMENT 'Name of the Internet Service Provider delivering connectivity to this site.',
    `jitter_ms` DECIMAL(18,2) COMMENT 'Variation in latency measured in milliseconds, indicating network stability.',
    `latency_ms` DECIMAL(18,2) COMMENT 'Network latency measured in milliseconds, representing the round-trip time for data packets.',
    `measurement_method` STRING COMMENT 'Method by which the connectivity measurement was performed.. Valid values are `automated|manual|scheduled|on_demand`',
    `measurement_timestamp` TIMESTAMP COMMENT 'The exact date and time when the connectivity measurement was captured.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this connectivity log record was last modified.',
    `monitoring_tool` STRING COMMENT 'Name of the network monitoring tool or system that captured this measurement.',
    `notes` STRING COMMENT 'Additional notes or observations related to this connectivity measurement.',
    `outage_duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of connectivity outage in minutes, if applicable to this measurement.',
    `outage_end_timestamp` TIMESTAMP COMMENT 'The date and time when the connectivity outage was resolved.',
    `outage_start_timestamp` TIMESTAMP COMMENT 'The date and time when the connectivity outage began.',
    `packet_loss_percent` DECIMAL(18,2) COMMENT 'Percentage of data packets lost during transmission, indicating network quality.',
    `priority_level` STRING COMMENT 'Business priority level assigned to this connectivity site for incident response.. Valid values are `critical|high|medium|low`',
    `resolution_timestamp` TIMESTAMP COMMENT 'The date and time when the connectivity issue was fully resolved.',
    `signal_strength_dbm` DECIMAL(18,2) COMMENT 'Signal strength measured in dBm for wireless connections.',
    `sla_compliant_flag` BOOLEAN COMMENT 'Indicates whether this connectivity measurement meets the SLA requirements.',
    `sla_target_uptime_percent` DECIMAL(18,2) COMMENT 'The contractual uptime percentage target defined in the SLA with the ISP.',
    `upload_speed_mbps` DECIMAL(18,2) COMMENT 'Measured upload speed in megabits per second.',
    CONSTRAINT pk_connectivity_log PRIMARY KEY(`connectivity_log_id`)
) COMMENT 'Transactional record of network connectivity events and uptime/downtime measurements for each network site. Captures measurement timestamp, site reference, connection status (up/down/degraded), latency (ms), bandwidth utilization (%), packet loss percentage, outage duration, and cause classification (ISP fault, power outage, equipment failure, weather). Enables SLA compliance tracking and field connectivity reporting for humanitarian operations.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`user_account` (
    `user_account_id` BIGINT COMMENT 'Unique identifier for the user account record. Primary key for digital identity management across all NGO platforms.',
    `parent_user_account_id` BIGINT COMMENT 'Self-referencing FK on user_account (linked_user_account_id)',
    `partner_org_id` BIGINT COMMENT 'Reference to partner organization for external authorized users from Community-Based Organizations (CBOs), Civil Society Organizations (CSOs), or other International Non-Governmental Organizations (INGOs).',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: User accounts have a primary system theyre provisioned in (e.g., Active Directory, Salesforce, SAP). The primary_system STRING field should be normalized to FK. N:1 relationship - many user accounts ',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member record in the workforce domain. Links digital identity to HR identity for employees.',
    `access_level` STRING COMMENT 'Overall access privilege level assigned to the user account. Determines baseline permissions across organizational systems.. Valid values are `read_only|standard|power_user|administrator|super_admin`',
    `activation_date` DATE COMMENT 'Date when the user account was activated and became available for login. May differ from provisioning date if account required approval workflow.',
    `active_directory_guid` STRING COMMENT 'Globally unique identifier assigned by Active Directory. Used for cross-system identity federation and single sign-on (SSO).. Valid values are `^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$`',
    `beneficiary_data_access_flag` BOOLEAN COMMENT 'Indicates whether the user has access to beneficiary registration, case management, and Person of Concern (PoC) data. True for program staff and case managers.',
    `commcare_username` STRING COMMENT 'Username for CommCare mobile case management platform. Used for community health worker tracking and beneficiary follow-up.. Valid values are `^[a-zA-Z0-9._-]{3,64}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this user account record was first created in the system of record. Audit trail for data lineage.',
    `data_protection_acknowledgment_flag` BOOLEAN COMMENT 'Indicates whether the user has acknowledged and accepted organizational data protection policies including GDPR, beneficiary data handling, and confidentiality requirements.',
    `deprovisioning_date` DATE COMMENT 'Date when the account was permanently deprovisioned and access was revoked across all systems. Typically occurs upon staff departure or contract end.',
    `deprovisioning_reason` STRING COMMENT 'Reason for account deprovisioning. Captures the business justification for permanent access revocation.. Valid values are `employment_ended|contract_expired|voluntary_resignation|security_violation|duplicate_account|other`',
    `dhis2_username` STRING COMMENT 'Username for DHIS2 health program monitoring platform. Used for indicator tracking, aggregate reporting, and Monitoring Evaluation and Learning (MEL) activities.. Valid values are `^[a-zA-Z0-9._-]{3,64}$`',
    `donor_data_access_flag` BOOLEAN COMMENT 'Indicates whether the user has access to donor management and constituent relationship management (CRM) systems. True for fundraising and development staff.',
    `email_address` STRING COMMENT 'Primary email address associated with the user account. Used for system notifications, password resets, and organizational communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `failed_login_attempts` STRING COMMENT 'Count of consecutive failed login attempts since last successful authentication. Used for account lockout policies and security monitoring.',
    `field_access_flag` BOOLEAN COMMENT 'Indicates whether the user has access to field operations systems and mobile data collection platforms. True for field staff and community health workers.',
    `financial_system_access_flag` BOOLEAN COMMENT 'Indicates whether the user has access to financial systems including General Ledger (GL), Accounts Payable (AP), Accounts Receivable (AR), and grant financial management. True for finance staff.',
    `kobotoolbox_username` STRING COMMENT 'Username for KoboToolbox field data collection platform. Used for beneficiary surveys, needs assessments, and humanitarian data collection.. Valid values are `^[a-zA-Z0-9._-]{3,64}$`',
    `last_login_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful authentication to any organizational system. Used for dormant account detection and security monitoring.',
    `last_password_change_date` DATE COMMENT 'Date when the user last changed their password. Used to enforce password rotation policies and detect stale credentials.',
    `locked_flag` BOOLEAN COMMENT 'Indicates whether the account is locked due to excessive failed login attempts or security policy violation. True if locked; requires administrator intervention to unlock.',
    `locked_timestamp` TIMESTAMP COMMENT 'Timestamp when the account was locked. Null if account has never been locked.',
    `mfa_enrolled_flag` BOOLEAN COMMENT 'Indicates whether the user has enrolled in multi-factor authentication. True if MFA is configured; false if only password authentication is enabled.',
    `mfa_method` STRING COMMENT 'The primary multi-factor authentication method configured for this account. None indicates MFA is not enabled.. Valid values are `authenticator_app|sms|email|hardware_token|biometric|none`',
    `mobile_device_registered_flag` BOOLEAN COMMENT 'Indicates whether the user has registered a mobile device for organizational access. True for users accessing CommCare, KoboToolbox, or other mobile platforms.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this user account record was last modified. Audit trail for change tracking and compliance reporting.',
    `password_expiry_date` DATE COMMENT 'Date when the current password expires and must be changed. Enforces organizational password rotation policy.',
    `privileged_account_flag` BOOLEAN COMMENT 'Indicates whether this is a privileged account with elevated permissions (administrator, super admin, system service). True for accounts requiring enhanced security monitoring.',
    `provisioning_date` DATE COMMENT 'Date when the user account was initially created and provisioned across organizational systems.',
    `remote_access_enabled_flag` BOOLEAN COMMENT 'Indicates whether the user is authorized for remote access via VPN or external networks. True for users working from field locations or home offices.',
    `salesforce_user_code` STRING COMMENT 'Unique user identifier in Salesforce Nonprofit Cloud. Links digital identity to donor management, constituent tracking, and campaign management activities.. Valid values are `^[a-zA-Z0-9]{15,18}$`',
    `sap_user_code` STRING COMMENT 'User identifier in SAP S/4HANA for Nonprofits. Provides access to General Ledger (GL), Accounts Payable (AP), Accounts Receivable (AR), fund accounting, and procurement modules.. Valid values are `^[A-Z0-9_]{1,12}$`',
    `security_training_completion_date` DATE COMMENT 'Date when the user completed mandatory information security and data protection training. Required for compliance with organizational security policies.',
    `user_account_status` STRING COMMENT 'Current lifecycle status of the user account. Active accounts have full access; suspended accounts are temporarily disabled; locked accounts require admin intervention; deprovisioned accounts are permanently disabled.. Valid values are `active|suspended|locked|deprovisioned|pending_activation`',
    `suspension_date` DATE COMMENT 'Date when the account was suspended. Null if account has never been suspended.',
    `suspension_reason` STRING COMMENT 'Free-text explanation for why the account was suspended. Captures business justification for temporary access revocation.',
    `user_account_type` STRING COMMENT 'Classification of the user account based on the relationship to the organization. Determines access policies and provisioning workflows.. Valid values are `staff|volunteer|partner|contractor|consultant|system_service`',
    `username` STRING COMMENT 'Unique username for system authentication. Primary login identifier across Active Directory, Salesforce, SAP, KoboToolbox, CommCare, DHIS2, and email systems.. Valid values are `^[a-zA-Z0-9._-]{3,64}$`',
    `workday_user_code` STRING COMMENT 'User identifier in Workday Human Capital Management (HCM) system. Provides access to human resources, payroll, talent management, and learning modules.. Valid values are `^[a-zA-Z0-9_-]{1,32}$`',
    CONSTRAINT pk_user_account PRIMARY KEY(`user_account_id`)
) COMMENT 'Master record for every digital identity and system access account provisioned for NGO staff, volunteers, and authorized partner users across all platforms (Active Directory, Salesforce, SAP, KoboToolbox, CommCare, DHIS2, email). Captures username, account type, associated staff or volunteer identity, provisioning date, last login, account status (active, suspended, deprovisioned), and multi-factor authentication (MFA) enrollment status. SSOT for digital identity management — distinct from workforce.staff_member (which owns HR identity).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`access_role` (
    `access_role_id` BIGINT COMMENT 'Unique identifier for the access role record. Primary key.',
    `parent_access_role_id` BIGINT COMMENT 'Self-referencing FK on access_role (parent_access_role_id)',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Access roles are defined within specific platforms (e.g., Salesforce Admin role, SAP Finance User role). The platform_system STRING field should be normalized to FK. N:1 relationship - many roles defi',
    `access_scope` STRING COMMENT 'Geographic or organizational scope of data access granted by this role (global, regional, country-level, program-specific, project-specific, department-specific).. Valid values are `global|regional|country|program|project|department`',
    `active_user_count` STRING COMMENT 'Current number of active users assigned to this role. Used for access governance reporting and license management.',
    `approval_authority_name` STRING COMMENT 'Name of the individual or committee authorized to approve assignment of this role to users (e.g., Chief Information Officer, Executive Director, Security Committee).',
    `approval_authority_title` STRING COMMENT 'Job title or position of the approval authority (e.g., Chief Information Officer, Director of Information Security, Head of Human Resources).',
    `approved_by` STRING COMMENT 'Username or identifier of the approval authority who formally approved this role definition for use.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this role definition was formally approved by the designated approval authority.',
    `audit_logging_required` BOOLEAN COMMENT 'Indicates whether all actions performed by users with this role must be logged for audit and compliance purposes (True) or standard logging applies (False).',
    `business_justification` STRING COMMENT 'Business rationale and justification for the existence and permission scope of this role.',
    `access_role_code` STRING COMMENT 'Unique business identifier or short code for the role (e.g., PROG_MGR, FIN_OFF, FLD_COORD) used across systems.',
    `compliance_framework` STRING COMMENT 'Comma-separated list of regulatory or compliance frameworks this role supports (e.g., OMB Uniform Guidance 2 CFR 200, GDPR, CHS, IATI, ASC 958).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this role record was first created in the system.',
    `data_classification_level` STRING COMMENT 'The highest data classification level this role is authorized to access (public, internal, confidential, restricted) per organizational data governance policy.. Valid values are `public|internal|confidential|restricted`',
    `data_domain_access` STRING COMMENT 'Comma-separated list of data domains this role can access (e.g., Beneficiary, Donor, Finance, Program, Grant, Volunteer, Supply Chain, MEL).',
    `access_role_description` STRING COMMENT 'Detailed description of the roles purpose, responsibilities, and typical use cases within the organization.',
    `effective_end_date` DATE COMMENT 'Date when this role definition expires or was retired. Null if the role is currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this role definition became active and available for assignment to users.',
    `last_recertification_date` DATE COMMENT 'Date when this role definition was last reviewed and recertified by the role owner or approval authority.',
    `least_privilege_flag` BOOLEAN COMMENT 'Indicates whether this role adheres to the principle of least privilege (True) or grants elevated/broad access (False).',
    `modified_by` STRING COMMENT 'Username or identifier of the individual who last modified this role definition.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this role record was last updated in the system.',
    `module_access` STRING COMMENT 'Comma-separated list of system modules or functional areas this role can access (e.g., Donor Management, Grant Accounting, Case Management, Field Data Collection).',
    `multi_factor_authentication_required` BOOLEAN COMMENT 'Indicates whether users assigned this role must use multi-factor authentication (MFA) for access (True) or single-factor is permitted (False).',
    `access_role_name` STRING COMMENT 'Human-readable name of the role-based access control (RBAC) role (e.g., Program Manager, Finance Officer, Field Coordinator, Donor Relations Specialist).',
    `next_recertification_date` DATE COMMENT 'Scheduled date for the next access recertification review of this role definition.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this role definition, assignment criteria, or usage guidelines.',
    `owner_email` STRING COMMENT 'Email address of the role owner for contact and accountability purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `owner_name` STRING COMMENT 'Name of the individual or department responsible for defining and maintaining this role (e.g., IT Director, HRIS Manager, Security Officer).',
    `permission_scope` STRING COMMENT 'The level of access permission granted by this role (read-only, write, admin, execute, delete, full control).. Valid values are `read|write|admin|execute|delete|full_control`',
    `privileged_access_flag` BOOLEAN COMMENT 'Indicates whether this role grants privileged or administrative access requiring enhanced monitoring and audit (True) or standard user access (False).',
    `recertification_frequency_days` STRING COMMENT 'Number of days between required access recertification reviews for users assigned this role (e.g., 90, 180, 365). Null if recertification is not required.',
    `risk_level` STRING COMMENT 'Risk classification of this role based on the sensitivity of data and scope of permissions (low, medium, high, critical).. Valid values are `low|medium|high|critical`',
    `segregation_of_duties_flag` BOOLEAN COMMENT 'Indicates whether this role is subject to segregation of duties controls (True) to prevent conflicts of interest or fraud risk (False if not applicable).',
    `access_role_status` STRING COMMENT 'Current lifecycle status of the access role (active, inactive, suspended, deprecated, pending approval).. Valid values are `active|inactive|suspended|deprecated|pending_approval`',
    `access_role_type` STRING COMMENT 'Categorical classification of the role by organizational function (functional, technical, administrative, executive, field operations, donor relations).. Valid values are `functional|technical|administrative|executive|field_operations|donor_relations`',
    `created_by` STRING COMMENT 'Username or identifier of the individual who created this role definition in the system.',
    CONSTRAINT pk_access_role PRIMARY KEY(`access_role_id`)
) COMMENT 'Master catalog of role-based access control (RBAC) roles and permission profiles defined across all NGO platforms and systems. Captures role name, associated system platform, permission scope (read/write/admin), data classification level accessible (public/internal/confidential/restricted), role owner, and approval authority. Enables least-privilege access governance and audit-ready access control documentation.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` (
    `access_provisioning_id` BIGINT COMMENT 'Unique identifier for the access provisioning transaction record.',
    `access_role_id` BIGINT COMMENT 'Foreign key linking to technology.access_role. Business justification: Access provisioning assigns specific RBAC roles to users. The access_role_assigned STRING field should be normalized to FK. N:1 relationship - many provisioning events assign one role. Core RBAC relat',
    `staff_member_id` BIGINT COMMENT 'Identifier of the IT security officer, system owner, or authorized approver who reviewed and approved or rejected the access request.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Access to donor-restricted data/systems must track grant authorization. Business need: data security compliance (donor audit requirements), segregation of duties enforcement, access review for grant-s',
    `primary_access_staff_member_id` BIGINT COMMENT 'Human Resources Information System (HRIS) employee or volunteer identifier for the target user, formatted as EMP-XXXXXX (employee), VOL-XXXXXX (volunteer), or CON-XXXXXX (consultant).',
    `user_account_id` BIGINT COMMENT 'Identifier of the staff member or system user who initiated the access provisioning request.',
    `superseded_access_provisioning_id` BIGINT COMMENT 'Self-referencing FK on access_provisioning (superseded_access_provisioning_id)',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Access provisioning grants access to specific platforms (Salesforce, SAP, DHIS2, etc.). The target_system_platform STRING field should be normalized to FK. N:1 relationship - many provisioning events ',
    `target_user_user_account_id` BIGINT COMMENT 'Identifier of the staff member or volunteer for whom access is being provisioned, modified, or revoked.',
    `tertiary_access_compliance_signoff_by_staff_member_id` BIGINT COMMENT 'Identifier of the compliance officer or data protection officer who provided formal sign-off for this access provisioning.',
    `access_duration_days` STRING COMMENT 'Number of days the access is valid, calculated from effective start date to effective end date. Null for indefinite access.',
    `access_level` STRING COMMENT 'Privilege level granted: read_only (view only), read_write (view and edit), admin (full module administration), super_admin (system-wide administration), or restricted (limited scope access).. Valid values are `read_only|read_write|admin|super_admin|restricted`',
    `access_review_due_date` DATE COMMENT 'Date when this access provisioning is scheduled for periodic review to validate continued business need and compliance with least privilege principle.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the access provisioning request was approved or rejected by the designated approver.',
    `beneficiary_data_access_flag` BOOLEAN COMMENT 'Indicates whether this access provisioning grants permission to view or edit beneficiary personally identifiable information (PII) and program participation records (True/False).',
    `business_justification` STRING COMMENT 'Detailed explanation of the business need and rationale for the access provisioning request, including job role requirements, project assignment, or operational necessity.',
    `completed_timestamp` TIMESTAMP COMMENT 'Date and time when the IT administrator or automated provisioning system completed the access setup in the target system.',
    `compliance_signoff_required_flag` BOOLEAN COMMENT 'Indicates whether this access provisioning requires formal compliance officer or data protection officer sign-off before activation (True/False).',
    `compliance_signoff_timestamp` TIMESTAMP COMMENT 'Date and time when the compliance officer provided formal sign-off approval for this access provisioning.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this access provisioning record was first created in the system.',
    `data_classification_access_level` STRING COMMENT 'Highest data classification level the user is authorized to access through this provisioning: public (unrestricted), internal (staff only), confidential (business sensitive), or restricted (PII/PHI/donor data).. Valid values are `public|internal|confidential|restricted`',
    `deprovisioning_reason` STRING COMMENT 'Explanation for access revocation or suspension, including termination, role change, security incident, policy violation, or contract end. Populated only for revoke or suspend request types.',
    `donor_audit_requirement_flag` BOOLEAN COMMENT 'Indicates whether this access provisioning is subject to donor audit requirements and must maintain enhanced documentation for compliance reporting (True/False).',
    `effective_end_date` DATE COMMENT 'Date when the provisioned access expires or is scheduled for automatic revocation. Null indicates indefinite access subject to periodic review.',
    `effective_start_date` DATE COMMENT 'Date when the provisioned access becomes active and the user is authorized to use the system or platform.',
    `financial_data_access_flag` BOOLEAN COMMENT 'Indicates whether this access provisioning grants permission to view or edit financial transactions, donor contributions, or grant accounting data (True/False).',
    `jml_lifecycle_stage` STRING COMMENT 'Stage in the employee lifecycle that triggered this access provisioning: joiner (new hire), mover (role change/transfer), leaver (termination/resignation), contractor_onboard (external consultant start), or contractor_offboard (external consultant end).. Valid values are `joiner|mover|leaver|contractor_onboard|contractor_offboard`',
    `last_access_review_date` DATE COMMENT 'Date when this access provisioning was last reviewed and validated by the system owner or security officer.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this access provisioning record was most recently updated.',
    `multi_factor_authentication_required_flag` BOOLEAN COMMENT 'Indicates whether the provisioned access requires multi-factor authentication for login and session management (True/False).',
    `notes` STRING COMMENT 'Additional comments, special instructions, or contextual information related to the access provisioning request and fulfillment.',
    `remote_access_permitted_flag` BOOLEAN COMMENT 'Indicates whether the user is authorized to access the system remotely from outside the organizational network (True/False).',
    `request_number` STRING COMMENT 'Externally-known unique identifier for the access provisioning request, formatted as APR-YYYYMMDD-XXXXXX.. Valid values are `^APR-[0-9]{8}-[A-Z0-9]{6}$`',
    `request_status` STRING COMMENT 'Current lifecycle status of the access provisioning request in the approval and fulfillment workflow. [ENUM-REF-CANDIDATE: draft|submitted|pending_approval|approved|rejected|in_progress|completed|cancelled — 8 candidates stripped; promote to reference product]',
    `request_submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the access provisioning request was formally submitted for approval.',
    `request_type` STRING COMMENT 'Type of access provisioning action requested: grant (new access), modify (change existing access), revoke (remove access), suspend (temporary disable), reinstate (restore suspended access), or transfer (move access to different user).. Valid values are `grant|modify|revoke|suspend|reinstate|transfer`',
    `security_incident_reference` STRING COMMENT 'Reference number of the security incident that triggered emergency access revocation or suspension, formatted as INC-XXXXXXXX. Populated only when access change is incident-driven.. Valid values are `^INC-[0-9]{8}$`',
    `target_system_environment` STRING COMMENT 'Environment tier of the target system where access is being provisioned: production (live operational), staging (pre-production testing), development (build environment), training (user education), or sandbox (isolated testing).. Valid values are `production|staging|development|training|sandbox`',
    `target_user_email` STRING COMMENT 'Email address of the target user receiving the access provisioning action, used for notification and audit trail.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    CONSTRAINT pk_access_provisioning PRIMARY KEY(`access_provisioning_id`)
) COMMENT 'Transactional record of every user access provisioning, modification, and deprovisioning event across all NGO systems and platforms. Captures request type (grant, modify, revoke), requesting manager, approver, target system platform, access role assigned, justification, effective date, and compliance sign-off. Supports joiner-mover-leaver (JML) lifecycle governance and donor audit requirements for data access controls.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`security_control` (
    `security_control_id` BIGINT COMMENT 'Unique identifier for the security control record. Primary key.',
    `psea_policy_id` BIGINT COMMENT 'Foreign key linking to safeguarding.psea_policy. Business justification: Security controls (encryption, access restrictions, audit logging, data retention) implement specific safeguarding policy requirements. Compliance teams need to map which technical controls enforce wh',
    `parent_security_control_id` BIGINT COMMENT 'Self-referencing FK on security_control (parent_security_control_id)',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Security controls are implemented on specific platforms. While applicable_systems is a STRING list (controls often apply to multiple systems), this FK tracks the PRIMARY platform. N:1 relationship - m',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this security control record is currently active and in use (True) or has been archived or decommissioned (False).',
    `annual_maintenance_cost` DECIMAL(18,2) COMMENT 'Estimated annual cost to maintain, operate, and support this security control, including subscription fees, support contracts, and staff time.',
    `applicable_data_classification` STRING COMMENT 'Comma-separated list of data classification levels protected by this control (e.g., restricted, confidential, internal, public). Indicates which data sensitivity tiers require this control.',
    `applicable_systems` STRING COMMENT 'Comma-separated list of IT systems, platforms, or applications to which this security control applies (e.g., Salesforce, SAP, DHIS2, KoboToolbox, CommCare, network infrastructure).',
    `audit_trail_required_flag` BOOLEAN COMMENT 'Indicates whether this control requires detailed audit logging and trail retention for compliance or forensic purposes (True/False).',
    `automation_level` STRING COMMENT 'Degree to which the security control is automated: manual (human-executed), semi-automated (human-initiated with automated execution), or fully automated (no human intervention required).. Valid values are `manual|semi_automated|fully_automated`',
    `compensating_control_flag` BOOLEAN COMMENT 'Indicates whether this control serves as a compensating control for another control that cannot be fully implemented (True/False).',
    `compliance_mandatory_flag` BOOLEAN COMMENT 'Indicates whether this control is mandatory for regulatory or donor compliance requirements (True) or is a best-practice recommendation (False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this security control record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost fields (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `security_control_description` STRING COMMENT 'Detailed description of the security control objective, scope, and implementation approach.',
    `domain` STRING COMMENT 'Primary security domain or category to which this control belongs (e.g., access management, encryption, vulnerability management, incident response). [ENUM-REF-CANDIDATE: access_management|asset_management|cryptography|physical_security|operations_security|communications_security|system_acquisition|supplier_relationships|incident_management|business_continuity|compliance|vulnerability_management|identity_management|network_security|endpoint_security|data_protection — 16 candidates stripped; promote to reference product]',
    `effectiveness_rating` STRING COMMENT 'Assessment outcome indicating whether the control is achieving its intended security objective: effective (fully meeting objectives), partially effective (meeting some objectives), ineffective (not meeting objectives), or not tested (no assessment conducted).. Valid values are `effective|partially_effective|ineffective|not_tested`',
    `evidence_location` STRING COMMENT 'File path, URL, or document reference where evidence of control implementation and effectiveness is stored for audit purposes.',
    `exception_expiry_date` DATE COMMENT 'Date when the granted exception expires and the control must be re-evaluated or implemented.',
    `exception_granted_flag` BOOLEAN COMMENT 'Indicates whether a formal exception or waiver has been granted for non-implementation or partial implementation of this control (True/False).',
    `exception_justification` STRING COMMENT 'Business or technical justification for granting an exception to this security control requirement.',
    `framework_mapping` STRING COMMENT 'Comma-separated list of security frameworks and specific control identifiers to which this control maps (e.g., ISO-27001:A.9.1.1, NIST-CSF:PR.AC-1, CIS-Controls:5.1). Supports multi-framework compliance mapping.',
    `identifier` STRING COMMENT 'External business identifier for the security control, typically following framework naming conventions (e.g., ISO-27001-A.9.1.1, NIST-CSF-PR.AC-1, CIS-5.1).. Valid values are `^[A-Z0-9]{2,10}-[A-Z0-9]{2,10}(-[A-Z0-9]{1,10})?$`',
    `implementation_cost` DECIMAL(18,2) COMMENT 'Total cost incurred to implement this security control, including software licenses, hardware, consulting, and labor.',
    `implementation_date` DATE COMMENT 'Date when the security control was fully implemented and became operational.',
    `implementation_guidance` STRING COMMENT 'Detailed guidance, procedures, or references for implementing and maintaining this security control.',
    `implementation_status` STRING COMMENT 'Current lifecycle status of the security control implementation.. Valid values are `not_implemented|planned|in_progress|implemented|operational|decommissioned`',
    `last_assessment_date` DATE COMMENT 'Date of the most recent assessment, audit, or effectiveness test of this security control.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this security control record was last updated or modified.',
    `maturity_level` STRING COMMENT 'Maturity assessment of the control implementation based on capability maturity model: initial (ad-hoc), developing (repeatable), defined (documented process), managed (measured and controlled), optimizing (continuous improvement).. Valid values are `initial|developing|defined|managed|optimizing`',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified this security control record.',
    `security_control_name` STRING COMMENT 'Human-readable name of the security control (e.g., Access Control Policy, Multi-Factor Authentication, Encryption at Rest).',
    `next_assessment_date` DATE COMMENT 'Planned date for the next scheduled assessment or audit of this security control.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the security control implementation, assessment, or operational considerations.',
    `objective` STRING COMMENT 'Specific security objective or goal that this control is designed to achieve (e.g., prevent unauthorized access, detect malware, ensure data integrity).',
    `owner` STRING COMMENT 'Name or identifier of the individual or role responsible for the ongoing management and effectiveness of this security control.',
    `owner_department` STRING COMMENT 'Organizational department or unit to which the control owner belongs (e.g., IT Security, Infrastructure, Compliance).',
    `related_policy_reference` STRING COMMENT 'Reference to the organizational policy, standard, or procedure document that governs this security control.',
    `remediation_due_date` DATE COMMENT 'Target date by which remediation actions must be completed to bring the control to effective status.',
    `remediation_plan` STRING COMMENT 'Description of the action plan to address control deficiencies, gaps, or ineffectiveness identified during assessments.',
    `risk_rating` STRING COMMENT 'Risk level associated with failure or absence of this control, indicating the potential impact to the organization.. Valid values are `critical|high|medium|low`',
    `testing_frequency` STRING COMMENT 'Scheduled frequency at which the security control effectiveness is tested or validated. [ENUM-REF-CANDIDATE: continuous|daily|weekly|monthly|quarterly|semi_annually|annually|ad_hoc — 8 candidates stripped; promote to reference product]',
    `security_control_type` STRING COMMENT 'Classification of the control by its function: preventive (stops incidents), detective (identifies incidents), corrective (remediates incidents), deterrent (discourages threats), compensating (alternative control), or directive (policy-based).. Valid values are `preventive|detective|corrective|deterrent|compensating|directive`',
    `vendor_solution` STRING COMMENT 'Name of the third-party vendor or technology solution used to implement this control (e.g., CrowdStrike, Qualys, Okta, Splunk).',
    CONSTRAINT pk_security_control PRIMARY KEY(`security_control_id`)
) COMMENT 'Master catalog of information security controls implemented across the NGOs technology environment, mapped to frameworks such as ISO 27001, NIST CSF, and CIS Controls. Captures control ID, control domain (access management, encryption, vulnerability management, incident response), implementation status, control owner, last assessment date, and effectiveness rating. Supports cybersecurity governance and donor audit readiness.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`security_assessment` (
    `security_assessment_id` BIGINT COMMENT 'Unique identifier for the security assessment record. Primary key.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Security assessments may be donor-required (e.g., USAID ADS 545 compliance) or grant-funded. Business need: donor compliance reporting, grant budget tracking for assessment costs, audit evidence for d',
    `followup_security_assessment_id` BIGINT COMMENT 'Self-referencing FK on security_assessment (followup_security_assessment_id)',
    `system_platform_id` BIGINT COMMENT 'Reference to the IT system or platform being assessed (e.g., Salesforce, SAP, DHIS2, KoboToolbox).',
    `assessor_certification` STRING COMMENT 'Professional certifications held by the assessor (e.g., CISSP, CEH, CISA, OSCP), demonstrating competence and credibility.',
    `assessor_name` STRING COMMENT 'Name of the lead assessor or security professional who conducted the assessment.',
    `beneficiary_data_at_risk` BOOLEAN COMMENT 'Flag indicating whether the assessed system processes or stores beneficiary personally identifiable information (PII) or sensitive program data, requiring heightened protection per humanitarian standards.',
    `compliance_status` STRING COMMENT 'Indicates whether the assessed system meets applicable compliance requirements (e.g., ISO 27001, GDPR, CHS, donor security requirements).. Valid values are `compliant|non_compliant|partially_compliant|not_applicable`',
    `conducting_entity_name` STRING COMMENT 'Name of the organization, department, or individual who conducted the security assessment (e.g., internal IT Security team, external firm name).',
    `conducting_entity_type` STRING COMMENT 'Indicates whether the assessment was conducted by internal IT/security staff, external consultants/auditors, or a joint team.. Valid values are `internal|external|joint`',
    `cost` DECIMAL(18,2) COMMENT 'Total cost incurred for conducting the security assessment, including consultant fees, tool licenses, and internal resource costs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this security assessment record was first created in the system.',
    `critical_findings_count` STRING COMMENT 'Number of critical severity findings identified during the assessment. Critical findings represent immediate threats requiring urgent remediation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the assessment cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `data_classification_assessed` STRING COMMENT 'Highest data classification level of information processed or stored on the assessed system, determining assessment rigor requirements.. Valid values are `restricted|confidential|internal|public`',
    `security_assessment_date` DATE COMMENT 'The date on which the security assessment was conducted or completed.',
    `donor_reporting_required` BOOLEAN COMMENT 'Indicates whether assessment results must be reported to donors as part of grant compliance or security attestation requirements.',
    `end_date` DATE COMMENT 'The date on which the security assessment activities concluded.',
    `executive_summary` STRING COMMENT 'High-level summary of assessment findings, risk posture, and key recommendations for executive leadership.',
    `frequency` STRING COMMENT 'Planned frequency for conducting security assessments on this system (annual, semi-annual, quarterly, ad-hoc, or continuous monitoring).. Valid values are `annual|semi_annual|quarterly|ad_hoc|continuous`',
    `high_findings_count` STRING COMMENT 'Number of high severity findings identified during the assessment. High findings represent significant vulnerabilities requiring prompt attention.',
    `key_recommendations` STRING COMMENT 'Primary recommendations for improving security posture based on assessment findings.',
    `low_findings_count` STRING COMMENT 'Number of low severity findings identified during the assessment. Low findings represent minor issues or informational observations.',
    `medium_findings_count` STRING COMMENT 'Number of medium severity findings identified during the assessment. Medium findings represent moderate risks requiring planned remediation.',
    `methodology_used` STRING COMMENT 'Security assessment methodology or framework used (e.g., OWASP Testing Guide, NIST SP 800-115, PTES, OSSTMM).',
    `modified_by` STRING COMMENT 'User or system identifier of the person who last modified this security assessment record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this security assessment record was last modified.',
    `next_assessment_due_date` DATE COMMENT 'Scheduled date for the next security assessment of this system or infrastructure, based on organizational policy or regulatory requirements.',
    `notes` STRING COMMENT 'Additional notes, observations, or context related to the security assessment.',
    `number` STRING COMMENT 'Business identifier or reference number for the security assessment, used for tracking and reporting purposes.',
    `overall_risk_rating` STRING COMMENT 'Overall risk rating assigned to the assessed system or infrastructure based on the aggregate findings and their severity.. Valid values are `critical|high|medium|low|minimal`',
    `remediation_deadline` DATE COMMENT 'Target date by which identified vulnerabilities and findings must be remediated or mitigated.',
    `remediation_status` STRING COMMENT 'Current status of remediation efforts for findings identified in this assessment.. Valid values are `not_started|in_progress|completed|overdue|deferred`',
    `report_document_reference` STRING COMMENT 'Reference identifier or file path to the detailed assessment report document stored in the document management system.',
    `report_issued_date` DATE COMMENT 'Date on which the formal assessment report was issued to stakeholders.',
    `scope` STRING COMMENT 'Detailed description of the scope of the security assessment, including systems, networks, applications, or infrastructure components covered.',
    `start_date` DATE COMMENT 'The date on which the security assessment activities commenced.',
    `security_assessment_status` STRING COMMENT 'Current lifecycle status of the security assessment.. Valid values are `scheduled|in_progress|completed|cancelled|on_hold`',
    `tools_used` STRING COMMENT 'List of security tools and software used during the assessment (e.g., Nessus, Burp Suite, Metasploit, Qualys).',
    `total_findings_count` STRING COMMENT 'Total number of findings identified across all severity levels during the assessment.',
    `security_assessment_type` STRING COMMENT 'Type of security assessment conducted: penetration test (simulated attack), vulnerability scan (automated tool scan), ISMS audit (Information Security Management System review), third-party review (external consultant assessment), compliance audit (regulatory check), or risk assessment (threat analysis).. Valid values are `penetration_test|vulnerability_scan|isms_audit|third_party_review|compliance_audit|risk_assessment`',
    `created_by` STRING COMMENT 'User or system identifier of the person who created this security assessment record.',
    CONSTRAINT pk_security_assessment PRIMARY KEY(`security_assessment_id`)
) COMMENT 'Transactional record of formal information security assessments, vulnerability scans, penetration tests, and cybersecurity audits conducted on NGO systems and infrastructure. Captures assessment type (penetration test, vulnerability scan, ISMS audit, third-party review), scope, conducting entity (internal/external), assessment date, findings count by severity (critical/high/medium/low), overall risk rating, and remediation deadline. Distinct from it_incident (which captures actual breaches).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`vulnerability` (
    `vulnerability_id` BIGINT COMMENT 'Unique identifier for the cybersecurity vulnerability record. Primary key for the vulnerability data product.',
    `it_asset_id` BIGINT COMMENT 'Foreign key linking to technology.it_asset. Business justification: Vulnerabilities can be specific to individual IT assets (e.g., unpatched laptop, vulnerable server). The affected_asset_identifier STRING field should be normalized to FK. N:1 relationship - many vuln',
    `parent_vulnerability_id` BIGINT COMMENT 'Self-referencing FK on vulnerability (related_vulnerability_id)',
    `it_incident_id` BIGINT COMMENT 'Identifier of any security incident that resulted from or is related to the exploitation of this vulnerability.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Vulnerabilities are discovered in specific platforms (e.g., Salesforce CVE, SAP security advisory). The affected_system_name STRING field should be normalized to FK. N:1 relationship - many vulnerabil',
    `actual_remediation_date` DATE COMMENT 'Actual date when the vulnerability was successfully remediated or closed, after verification of fix effectiveness.',
    `affected_component` STRING COMMENT 'Specific component, module, library, or service within the system that contains the vulnerability (e.g., Apache Struts, OpenSSL, Windows RDP).',
    `affected_data_classification` STRING COMMENT 'Highest data classification level of information that could be exposed or compromised if this vulnerability is exploited.. Valid values are `Restricted|Confidential|Internal|Public`',
    `affected_version` STRING COMMENT 'Version number or range of the affected software, application, or component that contains the vulnerability.',
    `business_impact` STRING COMMENT 'Description of the potential business impact if the vulnerability is exploited, including operational disruption, data breach, financial loss, or reputational damage.',
    `compliance_impact` STRING COMMENT 'Description of regulatory or compliance implications if the vulnerability is not remediated, including potential violations of donor requirements, GDPR, PCI-DSS, or other frameworks.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the vulnerability record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `cve_identifier` STRING COMMENT 'Standardized CVE identifier assigned by MITRE for publicly disclosed cybersecurity vulnerabilities. Format: CVE-YYYY-NNNNN.. Valid values are `^CVE-[0-9]{4}-[0-9]{4,}$`',
    `cvss_score` DECIMAL(18,2) COMMENT 'Numerical severity score of the vulnerability based on CVSS framework, ranging from 0.0 (informational) to 10.0 (critical).',
    `cvss_vector` STRING COMMENT 'CVSS vector string representing the detailed scoring metrics (Attack Vector, Attack Complexity, Privileges Required, User Interaction, Scope, Confidentiality, Integrity, Availability).',
    `vulnerability_description` STRING COMMENT 'Detailed technical description of the vulnerability, including the nature of the weakness, potential exploit vectors, and affected components.',
    `discovery_date` DATE COMMENT 'Date when the vulnerability was first discovered or identified within the organizations environment.',
    `discovery_method` STRING COMMENT 'Method or source through which the vulnerability was identified (e.g., vulnerability scan, penetration test, vendor security advisory, internal audit).. Valid values are `Automated Scan|Penetration Test|Vendor Advisory|Security Audit|Incident Response|Bug Bounty`',
    `exploitability_status` STRING COMMENT 'Current state of exploit availability and active exploitation: whether exploit code exists, is publicly available, or is being actively used in attacks.. Valid values are `Not Exploitable|Proof of Concept|Exploited in Wild|Weaponized|Unknown`',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified the vulnerability record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the vulnerability record was last updated or modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Additional notes, comments, or context about the vulnerability, remediation efforts, or organizational decisions regarding risk acceptance.',
    `patch_available` BOOLEAN COMMENT 'Indicates whether a vendor-provided patch or security update is available to remediate the vulnerability.',
    `patch_identifier` STRING COMMENT 'Vendor-assigned identifier or reference number for the security patch or update that addresses the vulnerability (e.g., MS21-001, KB4012598).',
    `reference_urls` STRING COMMENT 'Additional reference links to external resources, security bulletins, or technical documentation related to the vulnerability (comma-separated list).',
    `remediation_owner` STRING COMMENT 'Name of the individual or team responsible for remediating the vulnerability (e.g., IT Security Team, System Administrator, Application Owner).',
    `remediation_plan` STRING COMMENT 'Detailed plan or approach for addressing the vulnerability, including patching, configuration changes, compensating controls, or risk acceptance rationale.',
    `reported_by` STRING COMMENT 'Name of the individual, team, vendor, or security researcher who reported or discovered the vulnerability.',
    `risk_level` STRING COMMENT 'Organizational risk rating assigned to the vulnerability based on CVSS score, exploitability, asset criticality, and business impact.. Valid values are `Critical|High|Medium|Low`',
    `severity_rating` STRING COMMENT 'Qualitative severity classification of the vulnerability based on CVSS score ranges: Critical (9.0-10.0), High (7.0-8.9), Medium (4.0-6.9), Low (0.1-3.9), Informational (0.0).. Valid values are `Critical|High|Medium|Low|Informational`',
    `vulnerability_status` STRING COMMENT 'Current lifecycle status of the vulnerability: Open (newly identified), In Progress (remediation underway), Remediated (fix applied), Accepted (risk accepted), Mitigated (compensating controls applied), Closed (verified resolved).. Valid values are `Open|In Progress|Remediated|Accepted|Mitigated|Closed`',
    `target_remediation_date` DATE COMMENT 'Planned or target date by which the vulnerability should be remediated, based on severity and organizational risk tolerance.',
    `title` STRING COMMENT 'Short descriptive title or name of the vulnerability for quick identification and reference.',
    `vulnerability_type` STRING COMMENT 'Classification of the vulnerability by attack type or weakness category (e.g., SQL Injection, XSS, Buffer Overflow, Authentication Bypass). [ENUM-REF-CANDIDATE: SQL Injection|Cross-Site Scripting (XSS)|Buffer Overflow|Authentication Bypass|Privilege Escalation|Remote Code Execution|Denial of Service|Information Disclosure|Insecure Deserialization|Security Misconfiguration — promote to reference product]. Valid values are `SQL Injection|Cross-Site Scripting (XSS)|Buffer Overflow|Authentication Bypass|Privilege Escalation|Remote Code Execution`',
    `vendor_advisory_url` STRING COMMENT 'Web link to the vendors official security advisory or bulletin providing details about the vulnerability and remediation guidance.',
    `verification_date` DATE COMMENT 'Date when the remediation was verified and confirmed effective through re-scanning or testing.',
    `verification_status` STRING COMMENT 'Status of post-remediation verification testing to confirm the vulnerability has been successfully resolved and no longer exploitable.. Valid values are `Not Verified|Verified|Failed Verification|Pending Verification`',
    `verified_by` STRING COMMENT 'Name of the individual or team who performed the verification testing to confirm successful remediation.',
    `workaround_available` BOOLEAN COMMENT 'Indicates whether a temporary workaround or compensating control is available to mitigate the vulnerability until a permanent fix is applied.',
    `workaround_description` STRING COMMENT 'Description of the temporary workaround or compensating control that can reduce risk until the vulnerability is fully remediated.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created the vulnerability record in the system.',
    CONSTRAINT pk_vulnerability PRIMARY KEY(`vulnerability_id`)
) COMMENT 'Master record of identified cybersecurity vulnerabilities and weaknesses in NGO systems, applications, and infrastructure. Captures CVE identifier, affected system or asset, vulnerability severity (CVSS score), discovery method (scan, pen test, vendor advisory), discovery date, remediation status, assigned remediation owner, target remediation date, and actual closure date. Enables vulnerability lifecycle management and risk prioritization.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`software_license` (
    `software_license_id` BIGINT COMMENT 'Unique identifier for the software license record. Primary key.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Software licenses purchased with grant funds must track funding source. Business need: allowable cost verification (donor-specific software restrictions), grant budget compliance, audit trail for gran',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Software licenses are often tied to specific platforms they enable (e.g., Salesforce licenses, SAP licenses, Microsoft 365 for specific platform). N:1 relationship - many licenses for one platform. En',
    `upgraded_from_software_license_id` BIGINT COMMENT 'Self-referencing FK on software_license (upgraded_from_software_license_id)',
    `annual_cost` DECIMAL(18,2) COMMENT 'The total annual cost of the license or subscription in the specified currency. For multi-year agreements, this represents the annualized cost. Used for budget tracking and cost allocation.',
    `auto_renewal_enabled` BOOLEAN COMMENT 'Indicates whether the license or subscription is configured for automatic renewal. True if auto-renewal is active, false if manual renewal is required.',
    `compliance_frameworks` STRING COMMENT 'Comma-separated list of regulatory or industry compliance frameworks that this software must adhere to (e.g., GDPR, HIPAA, SOC 2, Core Humanitarian Standard (CHS), International Aid Transparency Initiative (IATI), OMB Uniform Guidance 2 CFR 200).',
    `compliance_status` STRING COMMENT 'Indicates whether the organizations usage is compliant with the license terms: compliant (usage within purchased entitlements), non-compliant (over-deployed or terms violation), under review (compliance check in progress), or audit required (vendor audit requested).. Valid values are `compliant|non_compliant|under_review|audit_required`',
    `contract_reference` STRING COMMENT 'Reference number or identifier for the master service agreement, Memorandum of Understanding (MoU), or Letter of Agreement (LoA) governing this license.',
    `cost_center_code` STRING COMMENT 'The organizational cost center or department code to which this license cost is allocated (e.g., IT, Programs, Finance). Used for financial reporting and budget tracking per OMB Uniform Guidance 2 CFR 200.',
    `cost_per_seat` DECIMAL(18,2) COMMENT 'The cost per individual license seat or user, calculated as annual cost divided by total seats purchased. Used for cost optimization and per-user budget allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this license record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the annual cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `data_classification_level` STRING COMMENT 'The highest data classification level that this software is authorized to process or store (restricted, confidential, internal, public), per the organizations data governance policy.. Valid values are `restricted|confidential|internal|public`',
    `deployment_type` STRING COMMENT 'The deployment model for the licensed software: cloud (vendor-hosted cloud infrastructure), on-premise (NGO-hosted on local servers), hybrid (combination of cloud and on-premise), or SaaS (Software as a Service, fully managed by vendor).. Valid values are `cloud|on_premise|hybrid|saas`',
    `disaster_recovery_tier` STRING COMMENT 'The disaster recovery priority tier for this software: tier 1 (critical, immediate recovery), tier 2 (important, recovery within hours), tier 3 (standard, recovery within days), tier 4 (low priority), or not applicable.. Valid values are `tier_1|tier_2|tier_3|tier_4|not_applicable`',
    `effective_start_date` DATE COMMENT 'The date the license becomes active and usage rights begin. For subscriptions, this is the start of the current billing period.',
    `expiration_date` DATE COMMENT 'The date the license expires or the subscription term ends. Null for perpetual licenses. Critical for renewal planning and compliance tracking.',
    `is_mission_critical` BOOLEAN COMMENT 'Indicates whether this software is mission-critical to humanitarian operations or core business functions. True if downtime would severely impact program delivery or beneficiary services.',
    `last_audit_date` DATE COMMENT 'The date of the most recent internal or vendor-initiated license compliance audit.',
    `modified_by` STRING COMMENT 'The username or identifier of the person who last modified this license record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this license record was last updated. Used for audit trail and change tracking.',
    `next_audit_date` DATE COMMENT 'The scheduled date for the next license compliance audit or review.',
    `notes` STRING COMMENT 'Free-text field for additional information, special terms, renewal reminders, or vendor-specific notes related to this license.',
    `number` STRING COMMENT 'The externally-known license key, agreement reference, or subscription identifier provided by the vendor (e.g., Microsoft 365 tenant ID, Salesforce org ID, SAP license key).',
    `owner_email` STRING COMMENT 'The email address of the license owner for renewal notifications and vendor communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `owner_name` STRING COMMENT 'The name of the staff member or role responsible for managing this license, including renewals, compliance, and vendor relationship management.',
    `payment_frequency` STRING COMMENT 'The billing cycle or payment schedule for the license: monthly, quarterly, annually, one-time (perpetual), or multi-year (prepaid multi-year subscription).. Valid values are `monthly|quarterly|annually|one_time|multi_year`',
    `primary_business_domain` STRING COMMENT 'The primary business function or domain supported by this software (e.g., Donor Management, Program Management, Financial Management, Field Data Collection, Monitoring Evaluation and Learning).',
    `product_name` STRING COMMENT 'The name of the software product or Software as a Service (SaaS) subscription (e.g., Microsoft 365 E5, Salesforce Nonprofit Cloud, SAP S/4HANA, KoboToolbox, CommCare, DHIS2, Tableau Creator).',
    `product_version` STRING COMMENT 'The version or release number of the licensed software product (e.g., SAP S/4HANA 2021, Salesforce Spring 23, DHIS2 2.38).',
    `purchase_date` DATE COMMENT 'The date the license was originally purchased or the subscription was first activated.',
    `purchase_order_number` STRING COMMENT 'The purchase order number associated with the license procurement, linking to the organizations Enterprise Resource Planning (ERP) system (e.g., SAP S/4HANA, Unit4 ERP).',
    `renewal_date` DATE COMMENT 'The scheduled date for license renewal or subscription extension. Used for proactive renewal management and budget planning.',
    `seats_available` STRING COMMENT 'The number of unused licenses available for assignment (calculated as total_seats_purchased minus seats_consumed).',
    `seats_consumed` STRING COMMENT 'The number of licenses currently assigned or actively in use by staff, volunteers, or partners. Used to track utilization and identify over-provisioning or under-provisioning.',
    `software_license_status` STRING COMMENT 'Current lifecycle state of the license: active (in use and compliant), expired (past renewal date), suspended (temporarily disabled), pending renewal (approaching expiration), cancelled (terminated), or trial (evaluation period).. Valid values are `active|expired|suspended|pending_renewal|cancelled|trial`',
    `support_tier` STRING COMMENT 'The level of vendor support included with the license: basic (email support), standard (business hours support), premium (24/7 support with SLA), enterprise (dedicated account manager), or community (open-source community support).. Valid values are `basic|standard|premium|enterprise|community`',
    `technical_contact_email` STRING COMMENT 'The email address of the technical contact for vendor support escalations and technical communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `technical_contact_name` STRING COMMENT 'The name of the technical staff member responsible for software implementation, configuration, and technical support.',
    `total_seats_purchased` STRING COMMENT 'The total number of user licenses, seats, or entitlements purchased under this license agreement. For concurrent licenses, this represents the maximum simultaneous users allowed.',
    `software_license_type` STRING COMMENT 'The licensing model governing usage rights: perpetual (one-time purchase, indefinite use), subscription (recurring payment, time-bound), concurrent (shared pool of active sessions), named user (assigned to specific individuals), device (tied to hardware), site (location-based), enterprise (organization-wide), or open source (freely licensed). [ENUM-REF-CANDIDATE: perpetual|subscription|concurrent|named_user|device|site|enterprise|open_source — 8 candidates stripped; promote to reference product]',
    `vendor_account_number` STRING COMMENT 'The organizations customer account number or tenant identifier with the vendor (e.g., Salesforce Org ID, Microsoft tenant ID, SAP customer number).',
    `vendor_name` STRING COMMENT 'The name of the software vendor or publisher (e.g., Microsoft, Salesforce, SAP, Dimagi, DHIS2 Core Team).',
    `created_by` STRING COMMENT 'The username or identifier of the person who created this license record.',
    CONSTRAINT pk_software_license PRIMARY KEY(`software_license_id`)
) COMMENT 'Master record for all software licenses and SaaS subscriptions managed by the NGO, including Microsoft 365, Salesforce, SAP, KoboToolbox, CommCare, DHIS2, and security tools. Captures license type (perpetual, subscription, concurrent, named user), vendor, product name, total seats purchased, seats consumed, license key or agreement reference, renewal date, annual cost, and cost center allocation. Enables license compliance and renewal management.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`it_project` (
    `it_project_id` BIGINT COMMENT 'Unique identifier for the IT project record. Primary key.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: IT projects are often grant-funded (e.g., USAID Digital Development, Gates Foundation technology grants). Business need: cost allocation to grant budgets, donor reporting on technology investments, al',
    `staff_member_id` BIGINT COMMENT 'FK to workforce.staff_member',
    `parent_it_project_id` BIGINT COMMENT 'Self-referencing FK on it_project (parent_it_project_id)',
    `primary_it_staff_member_id` BIGINT COMMENT 'Identifier of the staff member serving as the IT project manager, responsible for planning, execution, and delivery.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: IT projects often focus on implementing, upgrading, or integrating a primary platform. While affected_systems is a STRING list (multiple), this FK tracks the PRIMARY platform. N:1 relationship - many ',
    `tertiary_it_business_sponsor_staff_member_id` BIGINT COMMENT 'Identifier of the senior business stakeholder (typically a director or VP) who sponsors and champions the project.',
    `tertiary_it_staff_member_id` BIGINT COMMENT 'FK to workforce.staff_member',
    `lead_staff_member_id` BIGINT COMMENT '',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total actual expenditure incurred to date on the project, tracked against the approved budget.',
    `actual_end_date` DATE COMMENT 'Actual date when the project was completed and deliverables were accepted by the business sponsor. Null for projects still in progress.',
    `actual_start_date` DATE COMMENT 'Actual date when project execution commenced, which may differ from the planned start date due to delays or early initiation.',
    `affected_systems` STRING COMMENT 'Comma-separated list of system platforms or applications impacted by this project (e.g., Salesforce, SAP S/4HANA, Power BI). Links to technology.system_platform records.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total approved budget envelope for the IT project, including all cost categories (labor, software licenses, hardware, consulting, training).',
    `business_justification` STRING COMMENT 'Business case or rationale for the project, including problem statement, expected benefits, and alignment with organizational strategy.',
    `it_project_category` STRING COMMENT 'Strategic classification of the project: strategic (aligned with multi-year digital transformation roadmap), operational (business-as-usual system maintenance or enhancement), compliance (regulatory or donor-mandated requirement), or innovation (pilot, proof-of-concept, emerging technology exploration).. Valid values are `strategic|operational|compliance|innovation`',
    `it_project_code` STRING COMMENT 'Business-assigned unique code for the IT project, typically following organizational naming conventions (e.g., DHIS-2024-001, SAP-MIG-2023).. Valid values are `^[A-Z]{2,4}-[0-9]{4,6}$`',
    `compliance_frameworks` STRING COMMENT 'Comma-separated list of compliance frameworks or standards that this project must adhere to (e.g., GDPR, IATI, CHS, OMB 2 CFR 200, ISO 27001).',
    `contract_reference` STRING COMMENT 'Reference number or identifier of the contract or Statement of Work (SoW) governing vendor engagement for this project.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this IT project record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for budget and cost amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `data_classification_level` STRING COMMENT 'Highest data classification level of information handled by systems or processes within the scope of this project.. Valid values are `public|internal|confidential|restricted`',
    `delivery_methodology` STRING COMMENT 'Project management methodology used for delivery: agile (sprint-based, iterative), waterfall (sequential phases), hybrid (combination of agile and waterfall), or iterative (phased releases).. Valid values are `agile|waterfall|hybrid|iterative`',
    `it_project_description` STRING COMMENT 'Detailed narrative description of the project objectives, scope, deliverables, and expected business outcomes.',
    `forecast_end_date` DATE COMMENT 'Current forecast or revised completion date based on actual progress and known risks, updated regularly during project execution.',
    `funding_source` STRING COMMENT 'Source of funding for the IT project (e.g., Unrestricted Operating Budget, USAID Digital Transformation Grant, DFID ICT4D Program, Internal IT Capital Fund).',
    `go_live_date` DATE COMMENT 'Date when the system, platform, or solution delivered by the project was deployed to production and made available to end users.',
    `health_status` STRING COMMENT 'RAG (Red-Amber-Green) health indicator for the project: green (on track, no issues), yellow (at risk, requires attention), red (critical issues, intervention needed). Assessed based on schedule, budget, scope, and quality metrics.. Valid values are `green|yellow|red`',
    `integration_count` STRING COMMENT 'Number of system integrations (APIs, ETL pipelines, data feeds) developed or modified as part of this project.',
    `lessons_learned` STRING COMMENT 'Summary of key lessons learned during project execution, documented during project closure for knowledge transfer and continuous improvement.',
    `milestone_status` STRING COMMENT 'Summary of key milestone completion status, typically a brief text indicating which major milestones have been achieved (e.g., Requirements Complete, Design 80%, Build 40%).',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this IT project record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this IT project record was last modified or updated.',
    `it_project_name` STRING COMMENT 'Full descriptive name of the IT project (e.g., Salesforce Nonprofit Cloud Implementation, DHIS2 Upgrade to Version 2.39, Data Governance Framework Rollout).',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or context relevant to the project that do not fit into other structured fields.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Overall project completion percentage (0.00 to 100.00), calculated based on earned value, milestone completion, or weighted task progress.',
    `planned_end_date` DATE COMMENT 'Originally planned completion date for the project, as documented in the project charter or initial plan.',
    `planned_start_date` DATE COMMENT 'Originally planned start date for project execution, as documented in the project charter or initial plan.',
    `priority` STRING COMMENT 'Business priority level assigned to the project for resource allocation and scheduling decisions.. Valid values are `critical|high|medium|low`',
    `risk_level` STRING COMMENT 'Overall risk assessment for the project based on identified risks, dependencies, complexity, and external factors.. Valid values are `low|medium|high|critical`',
    `sponsoring_domain` STRING COMMENT 'The primary business domain or functional area that sponsors and benefits from this IT project (e.g., Program, Finance, Monitoring and Evaluation, Donor Relations). Maps to the organizations data domain taxonomy.',
    `it_project_status` STRING COMMENT 'Current lifecycle status of the IT project: planning (requirements gathering, design), active (in execution), on_hold (temporarily paused), completed (delivered but not yet closed), cancelled (terminated before completion), or closed (formally closed with lessons learned documented).. Valid values are `planning|active|on_hold|completed|cancelled|closed`',
    `success_criteria` STRING COMMENT 'Measurable criteria that define project success, including Key Performance Indicators (KPIs), acceptance criteria, and business outcome targets.',
    `it_project_type` STRING COMMENT 'Classification of the IT project by its primary objective: system implementation (new platform deployment), platform migration (moving from one system to another), infrastructure upgrade (hardware/network improvements), data governance (policies, standards, MDM), security enhancement (cybersecurity, compliance), or integration development (API, ETL, data pipelines).. Valid values are `system_implementation|platform_migration|infrastructure_upgrade|data_governance|security_enhancement|integration_development`',
    `user_count` STRING COMMENT 'Estimated or actual number of end users who will be impacted by or will use the solution delivered by this project.',
    `vendor_name` STRING COMMENT 'Name of the primary external vendor, consultant, or implementation partner engaged for this project (if applicable).',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this IT project record.',
    CONSTRAINT pk_it_project PRIMARY KEY(`it_project_id`)
) COMMENT 'Master record for technology projects and digital transformation initiatives managed by the IT department, including system implementations, platform migrations, infrastructure upgrades, and data governance programs. Captures project name, project type, sponsoring business domain, project manager, budget envelope, start date, planned end date, actual end date, milestone status, and delivery methodology (Agile/Waterfall). Distinct from program.intervention (which owns humanitarian program projects).';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`platform_integration` (
    `platform_integration_id` BIGINT COMMENT 'Unique identifier for the platform integration record. Primary key.',
    `staff_member_id` BIGINT COMMENT 'FK to workforce.staff_member',
    `primary_platform_staff_member_id` BIGINT COMMENT 'Reference to the staff member who is the business owner responsible for this integration.',
    `replaced_platform_integration_id` BIGINT COMMENT 'Self-referencing FK on platform_integration (replaced_platform_integration_id)',
    `system_platform_id` BIGINT COMMENT 'Reference to the source system platform from which data originates in this integration.',
    `target_system_platform_id` BIGINT COMMENT 'Reference to the target system platform to which data is loaded in this integration.',
    `authentication_method` STRING COMMENT 'Authentication mechanism used to secure the integration connection (OAuth2, API key, basic auth, certificate, SAML, none).. Valid values are `oauth2|api_key|basic_auth|certificate|saml|none`',
    `platform_integration_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the integration for technical reference and logging.',
    `compliance_frameworks` STRING COMMENT 'Comma-separated list of compliance frameworks this integration must adhere to (e.g., GDPR, CHS, IATI, 2 CFR 200).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this integration record was first created in the system.',
    `data_classification_level` STRING COMMENT 'Highest data classification level of the payload being transferred (restricted, confidential, internal, public).. Valid values are `restricted|confidential|internal|public`',
    `data_domain` STRING COMMENT 'Business data domain that this integration serves (e.g., Beneficiary, Donor, Program, Finance, Monitoring and Evaluation).',
    `data_entity` STRING COMMENT 'Primary data entity or object being exchanged (e.g., Beneficiary Registration, Donor Gift, Program Indicator, Financial Transaction).',
    `data_transformation_required` BOOLEAN COMMENT 'Indicates whether data transformation or mapping is required between source and target schemas (true) or not (false).',
    `decommission_date` DATE COMMENT 'Date when the integration was or will be decommissioned and retired from service.',
    `documentation_url` STRING COMMENT 'URL or file path to the technical documentation, integration specification, or runbook for this integration.',
    `encryption_enabled` BOOLEAN COMMENT 'Indicates whether data in transit is encrypted (true) or not (false).',
    `encryption_protocol` STRING COMMENT 'Encryption protocol used for data in transit (e.g., TLS 1.3, AES-256).',
    `error_handling_strategy` STRING COMMENT 'Strategy for handling errors during integration execution (retry, skip, halt, log and continue).. Valid values are `retry|skip|halt|log_and_continue`',
    `go_live_date` DATE COMMENT 'Date when the integration was first activated in production.',
    `last_failed_run_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent failed execution of this integration.',
    `last_successful_run_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful execution of this integration.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this integration record was last modified.',
    `monitoring_enabled` BOOLEAN COMMENT 'Indicates whether automated monitoring and alerting is enabled for this integration (true) or not (false).',
    `platform_integration_name` STRING COMMENT 'Human-readable name of the integration (e.g., KoboToolbox to DHIS2 Beneficiary Sync, Salesforce to SAP Donor Gift Feed).',
    `notes` STRING COMMENT 'Additional notes, comments, or context about the integration for operational reference.',
    `operational_status` STRING COMMENT 'Current operational status of the integration (active, inactive, suspended, testing, decommissioned).. Valid values are `active|inactive|suspended|testing|decommissioned`',
    `pattern` STRING COMMENT 'Technical integration pattern employed (API, ETL, webhook, file transfer, message queue, database replication).. Valid values are `api|etl|webhook|file_transfer|message_queue|database_replication`',
    `retry_count` STRING COMMENT 'Number of retry attempts configured for failed integration runs.',
    `sla_uptime_percentage` DECIMAL(18,2) COMMENT 'Target uptime percentage defined in the service level agreement for this integration (e.g., 99.50 for 99.5%).',
    `source_endpoint` STRING COMMENT 'Technical endpoint, API URL, or file path from which data is extracted in the source system.',
    `sync_frequency` STRING COMMENT 'Frequency at which data is synchronized between source and target systems (real-time, hourly, daily, weekly, monthly, on-demand).. Valid values are `real_time|hourly|daily|weekly|monthly|on_demand`',
    `sync_schedule` STRING COMMENT 'Detailed schedule specification (e.g., cron expression, time of day) for batch integrations.',
    `target_endpoint` STRING COMMENT 'Technical endpoint, API URL, or file path to which data is loaded in the target system.',
    `timeout_seconds` STRING COMMENT 'Maximum time in seconds allowed for a single integration execution before timeout.',
    `total_records_transferred` BIGINT COMMENT 'Cumulative count of records successfully transferred through this integration since go-live.',
    `transformation_logic` STRING COMMENT 'Description or reference to the transformation logic, mapping rules, or ETL script applied during data exchange.',
    `platform_integration_type` STRING COMMENT 'Classification of the integration pattern used (data sync, event stream, batch transfer, API integration, file exchange, webhook).. Valid values are `data_sync|event_stream|batch_transfer|api_integration|file_exchange|webhook`',
    CONSTRAINT pk_platform_integration PRIMARY KEY(`platform_integration_id`)
) COMMENT 'Master record for all system-to-system integrations and data exchange pipelines connecting NGO platforms, such as KoboToolbox-to-DHIS2, Salesforce-to-SAP, CommCare-to-beneficiary registry, and IATI publishing pipelines. Captures integration name, source system, target system, integration pattern (API, ETL, webhook, file transfer), data frequency, data classification of payload, integration owner, and operational status. SSOT for the integration architecture landscape.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` (
    `backup_schedule_id` BIGINT COMMENT 'Unique identifier for the backup schedule record. Primary key.',
    `parent_backup_schedule_id` BIGINT COMMENT 'Self-referencing FK on backup_schedule (parent_backup_schedule_id)',
    `system_platform_id` BIGINT COMMENT 'Reference to the IT system or platform covered by this backup schedule.',
    `user_account_id` BIGINT COMMENT 'add column user_account_id (BIGINT) with FK to technology.user_account.user_account_id - backup_schedule only has self-ref and system_platform FK but needs an owner/creator reference',
    `alert_on_failure` BOOLEAN COMMENT 'Indicates whether automated alerts are sent when a backup fails or encounters errors.',
    `alert_recipients` STRING COMMENT 'Comma-separated list of email addresses or distribution lists that receive backup failure alerts.',
    `backup_frequency` STRING COMMENT 'Frequency at which backups are executed for this schedule.. Valid values are `hourly|daily|weekly|monthly|quarterly|on-demand`',
    `backup_type` STRING COMMENT 'Type of backup performed: full (complete copy), incremental (changes since last backup), differential (changes since last full), snapshot (point-in-time), or continuous (real-time replication).. Valid values are `full|incremental|differential|snapshot|continuous`',
    `backup_verification_enabled` BOOLEAN COMMENT 'Indicates whether automated verification and integrity checks are performed on backup files after completion.',
    `backup_window_end_time` TIMESTAMP COMMENT 'Time of day when the backup window ends, in HH:MM format (24-hour).',
    `backup_window_start_time` TIMESTAMP COMMENT 'Time of day when the backup window begins, in HH:MM format (24-hour).',
    `backup_schedule_code` STRING COMMENT 'Business identifier code for the backup schedule, used for external reference and reporting.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `compliance_frameworks` STRING COMMENT 'Comma-separated list of compliance frameworks or regulations applicable to this backup schedule (e.g., GDPR, HIPAA, SOC2, ISO27001).',
    `compression_enabled` BOOLEAN COMMENT 'Indicates whether backup data is compressed to reduce storage space and transfer time.',
    `compression_ratio` DECIMAL(18,2) COMMENT 'Average compression ratio achieved for backups (e.g., 2.5 means data is compressed to 40% of original size).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this backup schedule record was first created in the system.',
    `cron_expression` STRING COMMENT 'Cron expression defining the precise timing and recurrence pattern for automated backup execution.',
    `data_asset_name` STRING COMMENT 'Name of the specific data asset, database, or repository covered by this backup schedule.',
    `data_classification_level` STRING COMMENT 'Highest data classification level of the data asset covered by this backup schedule, determining security and access controls.. Valid values are `restricted|confidential|internal|public`',
    `disaster_recovery_tier` STRING COMMENT 'Disaster recovery tier classification indicating the criticality and priority of this backup schedule for business continuity planning.. Valid values are `tier-1-critical|tier-2-high|tier-3-medium|tier-4-low`',
    `effective_end_date` DATE COMMENT 'Date when this backup schedule was deactivated or superseded. Null if currently active.',
    `effective_start_date` DATE COMMENT 'Date when this backup schedule became active and backups began executing.',
    `encryption_algorithm` STRING COMMENT 'Encryption algorithm used to secure backup data (e.g., AES-256, RSA-2048).',
    `encryption_enabled` BOOLEAN COMMENT 'Indicates whether backup data is encrypted at rest and in transit.',
    `last_backup_duration_minutes` STRING COMMENT 'Duration in minutes of the most recent backup execution.',
    `last_backup_size_gb` DECIMAL(18,2) COMMENT 'Size of the most recent backup in gigabytes.',
    `last_backup_status` STRING COMMENT 'Outcome status of the most recent backup execution attempt.. Valid values are `success|failed|partial|in-progress|skipped`',
    `last_backup_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful backup execution for this schedule.',
    `last_verification_status` STRING COMMENT 'Outcome of the most recent backup verification or integrity check.. Valid values are `passed|failed|not-verified`',
    `last_verification_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent backup verification or integrity check.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this backup schedule record was last modified.',
    `backup_schedule_name` STRING COMMENT 'Human-readable name of the backup schedule describing the system or data asset covered.',
    `next_scheduled_backup_timestamp` TIMESTAMP COMMENT 'Timestamp when the next backup is scheduled to execute.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this backup schedule.',
    `responsible_team` STRING COMMENT 'Name of the IT team or department responsible for managing and monitoring this backup schedule.',
    `retention_period_days` STRING COMMENT 'Number of days that backup copies are retained before being eligible for deletion or archival.',
    `rpo_minutes` STRING COMMENT 'Recovery Point Objective in minutes: the maximum acceptable amount of data loss measured in time. Defines how much data the organization can afford to lose.',
    `rto_minutes` STRING COMMENT 'Recovery Time Objective in minutes: the maximum acceptable time to restore the system or data after a disruption. Defines how quickly the organization must recover.',
    `backup_schedule_status` STRING COMMENT 'Current operational status of the backup schedule.. Valid values are `active|suspended|disabled|archived`',
    `storage_location_type` STRING COMMENT 'Primary storage location type for backup data: on-site (local datacenter), cloud (cloud provider), offsite (third-party facility), or hybrid (multiple locations).. Valid values are `on-site|cloud|offsite|hybrid`',
    `storage_path` STRING COMMENT 'File system path, bucket name, or URI where backup files are stored.',
    `storage_provider` STRING COMMENT 'Name of the storage provider or vendor hosting the backup data (e.g., AWS S3, Azure Blob, local NAS).',
    `technical_owner_email` STRING COMMENT 'Email address of the technical owner for notifications and escalations.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `technical_owner_name` STRING COMMENT 'Name of the technical owner or system administrator responsible for this backup schedule.',
    CONSTRAINT pk_backup_schedule PRIMARY KEY(`backup_schedule_id`)
) COMMENT 'Master record defining the data backup and disaster recovery schedules for all critical NGO systems and data repositories. Captures system or data asset covered, backup frequency (daily/weekly/monthly), backup type (full/incremental/differential), retention period, storage location (on-site/cloud/offsite), recovery point objective (RPO), recovery time objective (RTO), and last successful backup timestamp. Supports business continuity planning.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`it_procurement` (
    `it_procurement_id` BIGINT COMMENT 'Unique identifier for the IT procurement request or purchase order record.',
    `staff_member_id` BIGINT COMMENT 'Unique identifier of the staff member who approved the IT procurement request, typically a budget holder or IT manager.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: IT procurement funded by grants must track award source. Business need: grant budget compliance, allowable cost verification (donor procurement rules), audit trail, cost allocation, donor reporting on',
    `parent_it_procurement_id` BIGINT COMMENT 'Self-referencing FK on it_procurement (parent_it_procurement_id)',
    `primary_it_staff_member_id` BIGINT COMMENT 'Unique identifier of the staff member who initiated the IT procurement request.',
    `it_asset_id` BIGINT COMMENT 'Foreign key linking to technology.it_asset. Business justification: IT procurement of hardware results in IT asset records. Tracks procurement-to-asset lifecycle. N:1 relationship (procurement creates asset). Temporal note: FK populated AFTER delivery and asset regist',
    `software_license_id` BIGINT COMMENT 'Foreign key linking to technology.software_license. Business justification: IT procurement of software/SaaS results in software license records. Tracks procurement-to-license lifecycle. N:1 relationship (procurement creates license). Temporal note: FK populated after license ',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual total cost incurred after procurement completion, based on final invoice amounts.',
    `actual_delivery_date` DATE COMMENT 'Actual date on which the IT goods or services were received and confirmed by the requesting party.',
    `approval_date` DATE COMMENT 'Date on which the IT procurement request was formally approved by the authorized approver.',
    `approver_name` STRING COMMENT 'Full name of the staff member who approved the IT procurement request.',
    `budget_code` STRING COMMENT 'Budget line or cost center code against which this IT procurement is charged, aligned with the organizations Chart of Accounts (CoA).',
    `business_justification` STRING COMMENT 'Detailed explanation of the business need and rationale for this IT procurement, including expected benefits and alignment with organizational strategy.',
    `compliance_check_required` BOOLEAN COMMENT 'Flag indicating whether this IT procurement requires additional compliance review (e.g., sanctions screening, data protection impact assessment, export control review).',
    `compliance_check_status` STRING COMMENT 'Status of compliance review: not_required (no review needed), pending (under review), approved (cleared), rejected (compliance issue identified).. Valid values are `not_required|pending|approved|rejected`',
    `contract_reference` STRING COMMENT 'Reference number or identifier of the master contract or framework agreement under which this IT procurement is made, if applicable.',
    `country_office_code` STRING COMMENT 'Three-letter ISO country code identifying the country office or field location requesting the IT procurement.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this IT procurement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the procurement transaction (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `data_classification_level` STRING COMMENT 'Highest data classification level that the procured IT system or service will handle, determining security and compliance requirements.. Valid values are `public|internal|confidential|restricted`',
    `delivery_confirmed_by` STRING COMMENT 'Name of the staff member who confirmed receipt and acceptance of the IT goods or services.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated total cost of the IT procurement request, including all line items, taxes, and fees.',
    `expected_delivery_date` DATE COMMENT 'Anticipated date by which the IT goods or services are expected to be delivered or made available.',
    `invoice_number` STRING COMMENT 'Vendor invoice number associated with this IT procurement, used for payment processing and financial reconciliation.',
    `item_description` STRING COMMENT 'Detailed description of the IT goods or services being procured, including specifications, quantities, and business justification.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this IT procurement record was last updated or modified.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or special instructions related to this IT procurement request.',
    `order_date` DATE COMMENT 'Date on which the purchase order was issued to the vendor.',
    `payment_date` DATE COMMENT 'Date on which payment was made to the vendor for this IT procurement.',
    `payment_status` STRING COMMENT 'Current status of payment to the vendor: pending (awaiting payment), paid (fully settled), partially_paid (partial payment made), overdue (payment past due date), cancelled (payment voided).. Valid values are `pending|paid|partially_paid|overdue|cancelled`',
    `priority_level` STRING COMMENT 'Business priority of the procurement request: critical (emergency/operational impact), high (urgent business need), medium (planned requirement), low (nice-to-have).. Valid values are `critical|high|medium|low`',
    `program_code` STRING COMMENT 'Program or project code that this IT procurement supports, enabling program-level cost tracking and reporting.',
    `purchase_order_number` STRING COMMENT 'Unique purchase order number issued to the vendor after approval, serving as the contractual commitment to purchase.',
    `rejection_reason` STRING COMMENT 'Explanation provided when an IT procurement request is rejected, documenting the rationale for denial.',
    `requester_email` STRING COMMENT 'Email address of the staff member who initiated the IT procurement request, used for communication and notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requester_name` STRING COMMENT 'Full name of the staff member who initiated the IT procurement request.',
    `requisition_number` STRING COMMENT 'Externally-known unique identifier for the IT procurement requisition, typically generated by the ERP or procurement system.. Valid values are `^REQ-IT-[0-9]{6,10}$`',
    `it_procurement_status` STRING COMMENT 'Current lifecycle status of the IT procurement request: draft (being prepared), submitted (awaiting review), pending_approval (in approval workflow), approved (authorized for purchase), rejected (denied), ordered (purchase order issued to vendor), received (goods/services delivered), cancelled (request withdrawn). [ENUM-REF-CANDIDATE: draft|submitted|pending_approval|approved|rejected|ordered|received|cancelled — 8 candidates stripped; promote to reference product]',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the IT procurement request was formally submitted for approval, marking the start of the approval workflow.',
    `it_procurement_type` STRING COMMENT 'Category of IT procurement: hardware (laptops, servers, network equipment), software license (perpetual or subscription), cloud service (SaaS, IaaS, PaaS), managed service (outsourced IT operations), consulting (professional services), maintenance (support contracts), or telecom (connectivity services). [ENUM-REF-CANDIDATE: hardware|software_license|cloud_service|managed_service|consulting|maintenance|telecom — 7 candidates stripped; promote to reference product]',
    `vendor_code` STRING COMMENT 'Unique identifier for the vendor in the organizations vendor master data system.',
    `vendor_name` STRING COMMENT 'Name of the supplier or service provider from whom the IT goods or services are being procured.',
    CONSTRAINT pk_it_procurement PRIMARY KEY(`it_procurement_id`)
) COMMENT 'Transactional record of IT-specific procurement requests and purchase orders for hardware, software, and technology services. Captures requisition type (hardware, software license, cloud service, managed service), requested item, vendor, estimated cost, budget code, approval chain, procurement status, and delivery confirmation. Complements supply.purchase_order (which covers humanitarian commodity procurement) — this is scoped exclusively to IT goods and services.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` (
    `cab_meeting_id` BIGINT COMMENT 'Primary key for cab_meeting',
    `followup_cab_meeting_id` BIGINT COMMENT 'Self-referencing FK on cab_meeting (followup_cab_meeting_id)',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member who chairs or facilitates the CAB meeting, responsible for agenda management and decision facilitation.',
    `action_items_count` STRING COMMENT 'Number of follow-up action items or tasks assigned during the CAB meeting that require completion before the next meeting.',
    `actual_end_time` TIMESTAMP COMMENT 'The actual date and time when the CAB meeting concluded, capturing the true duration of the meeting.',
    `actual_start_time` TIMESTAMP COMMENT 'The actual date and time when the CAB meeting commenced, which may differ from scheduled time due to delays or early starts.',
    `agenda_document_url` STRING COMMENT 'Link or file path to the meeting agenda document outlining topics, change requests, and discussion items for the CAB meeting.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the CAB meeting was cancelled or postponed, if applicable (e.g., lack of quorum, emergency situation, no changes to review).',
    `changes_approved` STRING COMMENT 'Count of change requests that received approval from the CAB during the meeting.',
    `changes_deferred` STRING COMMENT 'Count of change requests that were postponed or tabled for future CAB review, requiring additional information or analysis.',
    `changes_rejected` STRING COMMENT 'Count of change requests that were rejected or denied by the CAB during the meeting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the CAB meeting record was first created in the system.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter during which the CAB meeting occurred, enabling quarterly performance analysis.',
    `fiscal_year` STRING COMMENT 'The fiscal year during which the CAB meeting occurred, used for reporting and trend analysis (e.g., FY2024).',
    `is_emergency_meeting` BOOLEAN COMMENT 'Flag indicating whether this CAB meeting was convened on an emergency basis to address critical or urgent change requests outside the regular schedule.',
    `location` STRING COMMENT 'Physical or virtual location where the CAB meeting is held (e.g., conference room name, Zoom link, Microsoft Teams channel).',
    `minutes_document_url` STRING COMMENT 'Link or file path to the official meeting minutes documenting discussions, decisions, and action items from the CAB meeting.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the CAB meeting record was last updated or modified in the system.',
    `next_meeting_date` DATE COMMENT 'The scheduled date for the subsequent CAB meeting, typically determined during the current meeting.',
    `notes` STRING COMMENT 'Free-text field capturing key discussion points, decisions, concerns raised, and general observations from the CAB meeting.',
    `number` STRING COMMENT 'Business identifier for the CAB meeting, typically following organizational numbering convention (e.g., CAB-2024-001).',
    `platform` STRING COMMENT 'The technology platform or medium used to conduct the CAB meeting (in-person, video conferencing tool, or hybrid).',
    `quorum_met` BOOLEAN COMMENT 'Indicator of whether the minimum required number of voting members was present to conduct official business.',
    `quorum_required` STRING COMMENT 'Minimum number of voting members required to be present for the CAB meeting to make binding decisions.',
    `recording_url` STRING COMMENT 'Link to the audio or video recording of the CAB meeting for reference and compliance purposes.',
    `scheduled_date` DATE COMMENT 'The calendar date on which the CAB meeting is planned to occur.',
    `scheduled_end_time` TIMESTAMP COMMENT 'The precise date and time when the CAB meeting is scheduled to conclude, including timezone information.',
    `scheduled_start_time` TIMESTAMP COMMENT 'The precise date and time when the CAB meeting is scheduled to begin, including timezone information.',
    `series_code` STRING COMMENT 'Identifier linking this CAB meeting to a recurring series or sequence of related meetings (e.g., weekly CAB, monthly emergency CAB).',
    `cab_meeting_status` STRING COMMENT 'Current lifecycle state of the CAB meeting indicating whether it is planned, active, concluded, or cancelled.',
    `total_attendees` STRING COMMENT 'Total count of individuals who attended the CAB meeting, including voting members, observers, and presenters.',
    `total_changes_reviewed` STRING COMMENT 'Count of change requests that were presented and reviewed during the CAB meeting.',
    `cab_meeting_type` STRING COMMENT 'Classification of the CAB meeting based on urgency and purpose (standard for routine changes, emergency for critical incidents, expedited for time-sensitive approvals).',
    `voting_members_present` STRING COMMENT 'Count of authorized voting members who attended the CAB meeting and are eligible to approve or reject change requests.',
    CONSTRAINT pk_cab_meeting PRIMARY KEY(`cab_meeting_id`)
) COMMENT 'Master reference table for cab_meeting. Referenced by cab_meeting_id.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`it_problem` (
    `it_problem_id` BIGINT COMMENT 'Primary key for it_problem',
    `parent_it_problem_id` BIGINT COMMENT 'Self-referencing FK on it_problem (related_it_problem_id)',
    `system_platform_id` BIGINT COMMENT 'add column system_platform_id (BIGINT) with FK to technology.system_platform.system_platform_id - it_problem only has a self-ref and one inbound from it_incident; problems must be associated with a platform',
    `actual_resolution_hours` DECIMAL(18,2) COMMENT 'Actual number of hours spent investigating and resolving the problem.',
    `affected_configuration_item` STRING COMMENT 'Configuration item or asset identified as the source or affected component of the problem.',
    `affected_service` STRING COMMENT 'Name or identifier of the IT service affected by this problem.',
    `approval_status` STRING COMMENT 'Status of management approval for problem resolution actions or change requests.',
    `assigned_group` STRING COMMENT 'IT support group or team responsible for managing this problem.',
    `assigned_to` STRING COMMENT 'Name or identifier of the individual or team currently assigned to investigate and resolve the problem.',
    `business_justification` STRING COMMENT 'Business rationale and justification for prioritizing and resolving this problem.',
    `it_problem_category` STRING COMMENT 'High-level categorization of the IT problem type.',
    `change_request_number` STRING COMMENT 'Reference number of the change request created to implement the problem resolution.',
    `closed_by` STRING COMMENT 'Name or identifier of the person who closed the problem record.',
    `closed_date` DATE COMMENT 'Date when the problem record was formally closed after verification and documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this problem record was first created in the system.',
    `it_problem_description` STRING COMMENT 'Detailed description of the IT problem, including symptoms, impact, and context.',
    `detected_date` DATE COMMENT 'Date when the underlying problem was first detected in the IT environment.',
    `environment` STRING COMMENT 'IT environment where the problem was identified or is occurring.',
    `estimated_resolution_hours` DECIMAL(18,2) COMMENT 'Estimated number of hours required to fully resolve the problem.',
    `geographic_location` STRING COMMENT 'Geographic location or region where the problem is affecting operations.',
    `impact` STRING COMMENT 'Scope of organizational impact caused by the problem.',
    `incident_count` STRING COMMENT 'Number of incidents that have been linked to or caused by this problem.',
    `investigation_start_date` DATE COMMENT 'Date when formal investigation of the problem began.',
    `known_error` BOOLEAN COMMENT 'Indicates whether this problem has been classified as a known error with documented root cause and workaround.',
    `known_error_date` DATE COMMENT 'Date when the problem was officially classified as a known error.',
    `lessons_learned` STRING COMMENT 'Key lessons learned and knowledge captured from investigating and resolving this problem.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this problem record was last modified or updated.',
    `number` STRING COMMENT 'Human-readable unique reference number for the IT problem, typically following organizational numbering convention (e.g., PRB0001234).',
    `preventive_action_taken` STRING COMMENT 'Description of preventive measures implemented to avoid recurrence of this problem.',
    `priority` STRING COMMENT 'Business priority level assigned to the problem based on impact and urgency.',
    `recurring_problem` BOOLEAN COMMENT 'Indicates whether this is a recurring problem that has occurred multiple times.',
    `reported_by` STRING COMMENT 'Name or identifier of the person who initially reported or identified the problem.',
    `reported_date` DATE COMMENT 'Date when the problem was first reported or identified.',
    `resolution_date` DATE COMMENT 'Date when the permanent solution was implemented and the problem was resolved.',
    `resolution_description` STRING COMMENT 'Detailed description of the permanent solution implemented to resolve the problem.',
    `root_cause_description` STRING COMMENT 'Detailed explanation of the underlying root cause identified through problem investigation.',
    `severity` STRING COMMENT 'Technical severity level indicating the extent of service disruption or degradation.',
    `it_problem_status` STRING COMMENT 'Current lifecycle status of the IT problem record.',
    `subcategory` STRING COMMENT 'Detailed subcategory providing more specific classification within the problem category.',
    `title` STRING COMMENT 'Brief descriptive title summarizing the IT problem.',
    `urgency` STRING COMMENT 'Time sensitivity for resolving the problem based on business needs.',
    `vendor_reference` STRING COMMENT 'External vendor case or ticket number if the problem involves third-party systems or support.',
    `workaround_description` STRING COMMENT 'Temporary solution or workaround to mitigate the problem impact while permanent resolution is developed.',
    CONSTRAINT pk_it_problem PRIMARY KEY(`it_problem_id`)
) COMMENT 'Master reference table for it_problem. Referenced by related_problem_id.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` (
    `knowledge_article_id` BIGINT COMMENT 'Primary key for knowledge_article',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member or user who originally authored the knowledge article.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the organizational department or unit that owns or is responsible for this knowledge article.',
    `owner_staff_member_id` BIGINT COMMENT 'Identifier of the staff member or team responsible for maintaining and updating the knowledge article.',
    `reviewer_staff_member_id` BIGINT COMMENT 'Identifier of the staff member who reviewed and approved the knowledge article for publication.',
    `superseded_knowledge_article_id` BIGINT COMMENT 'Self-referencing FK on knowledge_article (superseded_knowledge_article_id)',
    `author_staff_member_id` BIGINT COMMENT '',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this knowledge article was approved for publication by the designated reviewer.',
    `archived_date` DATE COMMENT 'Date on which this knowledge article was archived or moved out of active publication status.',
    `attachment_count` STRING COMMENT 'Number of file attachments associated with this knowledge article, such as documents, images, or reference materials.',
    `average_rating` DECIMAL(18,2) COMMENT 'Average user rating score for the knowledge article on a scale of 0.00 to 5.00, calculated from user feedback.',
    `knowledge_article_category` STRING COMMENT 'Primary business or functional category to which this knowledge article belongs, such as IT Infrastructure, Data Governance, Security, Field Operations, or Program Management.',
    `content` STRING COMMENT 'Full text body of the knowledge article, containing the detailed information, instructions, procedures, or reference material.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this knowledge article record was first created in the system.',
    `effective_date` DATE COMMENT 'Date on which this knowledge article becomes effective and applicable, particularly important for policy and procedure articles.',
    `expiration_date` DATE COMMENT 'Date on which this knowledge article expires or is scheduled for review and potential retirement, ensuring content freshness.',
    `external_url` STRING COMMENT 'Web address or hyperlink to external resources or related documentation referenced by this knowledge article.',
    `helpful_count` BIGINT COMMENT 'Number of users who have marked this knowledge article as helpful, used for quality assessment and content improvement.',
    `is_featured` BOOLEAN COMMENT 'Boolean flag indicating whether this knowledge article is featured or promoted in the knowledge base interface for high visibility.',
    `is_searchable` BOOLEAN COMMENT 'Boolean flag indicating whether this knowledge article is included in search indexes and discoverable through knowledge base search functionality.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords and tags associated with the knowledge article to facilitate search and discovery.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language in which the knowledge article is written.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this knowledge article record was last modified or updated.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this knowledge article to ensure continued accuracy and relevance.',
    `not_helpful_count` BIGINT COMMENT 'Number of users who have marked this knowledge article as not helpful, used for quality assessment and content improvement.',
    `number` STRING COMMENT 'Externally visible unique identifier for the knowledge article, used for reference and citation across systems and by end users.',
    `priority` STRING COMMENT 'Business priority or importance level of the knowledge article, used to determine visibility and promotion in knowledge base interfaces.',
    `published_date` DATE COMMENT 'Date on which this knowledge article was first published and made available to its intended audience.',
    `related_system` STRING COMMENT 'Name or identifier of the IT system, platform, or application that this knowledge article primarily addresses, such as KoboToolbox, CommCare, DHIS2, Salesforce, or SAP.',
    `retired_date` DATE COMMENT 'Date on which this knowledge article was permanently retired and removed from the knowledge base.',
    `review_date` DATE COMMENT 'Date on which this knowledge article was last reviewed for accuracy and relevance by a subject matter expert.',
    `knowledge_article_status` STRING COMMENT 'Current lifecycle state of the knowledge article, indicating whether it is in draft, under review, approved for publication, actively published, archived for reference, or retired from use.',
    `subcategory` STRING COMMENT 'Secondary classification within the primary category, providing more granular topical organization for the knowledge article.',
    `summary` STRING COMMENT 'Brief abstract or executive summary of the knowledge article content, used for search results and quick reference.',
    `title` STRING COMMENT 'The primary title or headline of the knowledge article, used for search and display purposes.',
    `knowledge_article_type` STRING COMMENT 'Classification of the knowledge article by its purpose and structure, such as how-to guide, troubleshooting procedure, frequently asked question, reference documentation, or policy statement.',
    `version_number` STRING COMMENT 'Version identifier for the knowledge article, following semantic versioning convention (major.minor), incremented with each published revision.',
    `view_count` BIGINT COMMENT 'Cumulative number of times this knowledge article has been viewed by users, used for usage analytics and popularity ranking.',
    `visibility` STRING COMMENT 'Access control classification indicating who can view this knowledge article: public (external users), internal (all staff), restricted (specific teams), or confidential (named individuals).',
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
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ADD CONSTRAINT `fk_technology_it_procurement_parent_it_procurement_id` FOREIGN KEY (`parent_it_procurement_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_procurement`(`it_procurement_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ADD CONSTRAINT `fk_technology_it_procurement_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ADD CONSTRAINT `fk_technology_it_procurement_software_license_id` FOREIGN KEY (`software_license_id`) REFERENCES `vibe_ngo_v1`.`technology`.`software_license`(`software_license_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ADD CONSTRAINT `fk_technology_cab_meeting_followup_cab_meeting_id` FOREIGN KEY (`followup_cab_meeting_id`) REFERENCES `vibe_ngo_v1`.`technology`.`cab_meeting`(`cab_meeting_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ADD CONSTRAINT `fk_technology_it_problem_parent_it_problem_id` FOREIGN KEY (`parent_it_problem_id`) REFERENCES `vibe_ngo_v1`.`technology`.`it_problem`(`it_problem_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ADD CONSTRAINT `fk_technology_it_problem_system_platform_id` FOREIGN KEY (`system_platform_id`) REFERENCES `vibe_ngo_v1`.`technology`.`system_platform`(`system_platform_id`);
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ADD CONSTRAINT `fk_technology_knowledge_article_superseded_knowledge_article_id` FOREIGN KEY (`superseded_knowledge_article_id`) REFERENCES `vibe_ngo_v1`.`technology`.`knowledge_article`(`knowledge_article_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`technology` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_ngo_v1`.`technology` SET TAGS ('dbx_domain' = 'technology');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Information Technology (IT) Asset ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `network_site_id` SET TAGS ('dbx_business_glossary_term' = 'Network Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `parent_it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Parent It Asset Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `parent_it_asset_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Staff Member ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `vendor_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `assigned_country_code` SET TAGS ('dbx_business_glossary_term' = 'Assigned Country Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `assigned_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `assigned_location_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Location Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `assigned_location_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `assigned_location_type` SET TAGS ('dbx_business_glossary_term' = 'Assigned Location Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `assigned_location_type` SET TAGS ('dbx_value_regex' = 'headquarters|country_office|field_office|warehouse|remote');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `it_asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `condition` SET TAGS ('dbx_business_glossary_term' = 'Physical Asset Condition');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|none');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'sold|donated|recycled|destroyed|returned_to_vendor');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `hostname` SET TAGS ('dbx_business_glossary_term' = 'Network Hostname');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Lifecycle Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|in_storage|in_repair|deployed|retired|decommissioned');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'Media Access Control (MAC) Address');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `mac_address` SET TAGS ('dbx_value_regex' = '^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `model` SET TAGS ('dbx_business_glossary_term' = 'Model Number or Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Asset Notes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System (OS)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `procurement_cost` SET TAGS ('dbx_business_glossary_term' = 'Procurement Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `procurement_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `procurement_date` SET TAGS ('dbx_business_glossary_term' = 'Procurement Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `product_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `salvage_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `salvage_value` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Serial Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `support_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Support Contract Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `support_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Support Contract Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `tag` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `it_asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type Classification');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `it_asset_type` SET TAGS ('dbx_value_regex' = 'hardware|software|network_equipment|mobile_device|peripheral|license');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life in Years');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `warranty_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `warranty_type` SET TAGS ('dbx_business_glossary_term' = 'Warranty Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_asset` ALTER COLUMN `warranty_type` SET TAGS ('dbx_value_regex' = 'manufacturer|extended|third_party|none');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `system_platform_id` SET TAGS ('dbx_business_glossary_term' = 'System Platform ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `parent_system_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Parent System Platform Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `parent_system_platform_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `annual_cost` SET TAGS ('dbx_business_glossary_term' = 'Annual Cost');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `annual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `api_endpoint` SET TAGS ('dbx_business_glossary_term' = 'API (Application Programming Interface) Endpoint');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `backup_frequency` SET TAGS ('dbx_business_glossary_term' = 'Backup Frequency');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `system_platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `compliance_frameworks` SET TAGS ('dbx_business_glossary_term' = 'Compliance Frameworks');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `deployment_type` SET TAGS ('dbx_business_glossary_term' = 'Deployment Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `deployment_type` SET TAGS ('dbx_value_regex' = 'Cloud|On-Premise|Hybrid|SaaS|PaaS|IaaS');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `system_platform_description` SET TAGS ('dbx_business_glossary_term' = 'Platform Description');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `disaster_recovery_tier` SET TAGS ('dbx_business_glossary_term' = 'Disaster Recovery (DR) Tier');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `disaster_recovery_tier` SET TAGS ('dbx_value_regex' = 'Tier 0|Tier 1|Tier 2|Tier 3|Tier 4|Not Applicable');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `hosting_environment` SET TAGS ('dbx_business_glossary_term' = 'Hosting Environment');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `integration_count` SET TAGS ('dbx_business_glossary_term' = 'Integration Count');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `is_mobile_enabled` SET TAGS ('dbx_business_glossary_term' = 'Mobile Enabled Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `is_mobile_enabled` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `is_mobile_enabled` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `is_offline_capable` SET TAGS ('dbx_business_glossary_term' = 'Offline Capable Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `system_platform_name` SET TAGS ('dbx_business_glossary_term' = 'Platform Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `system_platform_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Platform Notes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `primary_business_domain` SET TAGS ('dbx_business_glossary_term' = 'Primary Business Domain');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `system_platform_status` SET TAGS ('dbx_business_glossary_term' = 'Platform Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `support_tier` SET TAGS ('dbx_business_glossary_term' = 'Support Tier');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `support_tier` SET TAGS ('dbx_value_regex' = 'Standard|Premium|Enterprise|Community|Internal|Vendor-Managed');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `system_owner` SET TAGS ('dbx_business_glossary_term' = 'System Owner');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `technical_owner` SET TAGS ('dbx_business_glossary_term' = 'Technical Owner');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `system_platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Platform URL');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `user_count` SET TAGS ('dbx_business_glossary_term' = 'User Count');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `vendor_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Platform Version');
ALTER TABLE `vibe_ngo_v1`.`technology`.`system_platform` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `it_service_id` SET TAGS ('dbx_business_glossary_term' = 'Information Technology (IT) Service Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `parent_it_service_id` SET TAGS ('dbx_business_glossary_term' = 'Parent It Service Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `parent_it_service_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `system_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Primary System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `access_request_process` SET TAGS ('dbx_business_glossary_term' = 'Access Request Process');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `access_request_process` SET TAGS ('dbx_value_regex' = 'self_service|manager_approval|it_approval|security_clearance');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'single_sign_on|username_password|multi_factor|certificate_based');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `availability_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Availability Target Percentage');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `backup_frequency` SET TAGS ('dbx_business_glossary_term' = 'Backup Frequency');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `backup_frequency` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly|monthly|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `it_service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `it_service_category` SET TAGS ('dbx_value_regex' = 'connectivity|infrastructure|application|support|security|data_management');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `it_service_code` SET TAGS ('dbx_business_glossary_term' = 'Service Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `it_service_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `compliance_frameworks` SET TAGS ('dbx_business_glossary_term' = 'Compliance Frameworks');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'direct_charge|shared_pool|overhead|grant_funded');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `delivery_model` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery Model');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `delivery_model` SET TAGS ('dbx_value_regex' = 'in_house|outsourced|hybrid|cloud_saas');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `it_service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `disaster_recovery_rpo_hours` SET TAGS ('dbx_business_glossary_term' = 'Disaster Recovery Recovery Point Objective (RPO) in Hours');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `disaster_recovery_rto_hours` SET TAGS ('dbx_business_glossary_term' = 'Disaster Recovery Recovery Time Objective (RTO) in Hours');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_value_regex' = 'global|regional|country_specific|headquarters_only');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `hours` SET TAGS ('dbx_business_glossary_term' = 'Service Hours');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `hours` SET TAGS ('dbx_value_regex' = '24x7|business_hours|extended_hours|on_demand');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `knowledge_base_url` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Base Uniform Resource Locator (URL)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Service Launch Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Service Manager Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `monthly_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Monthly Cost in United States Dollars (USD)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `monthly_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `it_service_name` SET TAGS ('dbx_business_glossary_term' = 'Service Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `it_service_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `owner_email` SET TAGS ('dbx_business_glossary_term' = 'Service Owner Email Address');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Service Owner Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `owner_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `resolution_time_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Resolution Time Target in Hours');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `response_time_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Response Time Target in Minutes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|best_effort');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `it_service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `it_service_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|under_development|pilot|maintenance');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Support Contact Email Address');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `support_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Support Phone Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `support_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `support_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `supported_user_population` SET TAGS ('dbx_business_glossary_term' = 'Supported User Population');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `it_service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `it_service_type` SET TAGS ('dbx_value_regex' = 'business_service|technical_service|supporting_service');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_service` ALTER COLUMN `vendor_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Office Location ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Asset ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `it_service_id` SET TAGS ('dbx_business_glossary_term' = 'It Service Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `knowledge_article_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Article ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `parent_service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Related Service Request Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `parent_service_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Requester Staff ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `it_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Related Incident ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Change Request Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assigned Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `assignment_group` SET TAGS ('dbx_business_glossary_term' = 'Assignment Group');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `contact_method` SET TAGS ('dbx_business_glossary_term' = 'Contact Method');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `contact_method` SET TAGS ('dbx_value_regex' = 'web_portal|email|phone|chat|walk_in|mobile_app');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `service_request_description` SET TAGS ('dbx_business_glossary_term' = 'Request Description');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `first_response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Response Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `reopened_count` SET TAGS ('dbx_business_glossary_term' = 'Reopened Count');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `requester_feedback` SET TAGS ('dbx_business_glossary_term' = 'Requester Feedback');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `requester_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Requester Satisfaction Rating');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `resolution_category` SET TAGS ('dbx_business_glossary_term' = 'Resolution Category');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolved Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `service_request_status` SET TAGS ('dbx_business_glossary_term' = 'Service Request Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Request Subject');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Ticket Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `ticket_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `time_spent_hours` SET TAGS ('dbx_business_glossary_term' = 'Time Spent Hours');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `service_request_type` SET TAGS ('dbx_business_glossary_term' = 'Request Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`service_request` ALTER COLUMN `service_request_type` SET TAGS ('dbx_value_regex' = 'hardware_fault|software_access|connectivity_issue|platform_support|data_recovery|account_provisioning');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Change Request ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `cab_meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Change Advisory Board (CAB) Meeting ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `it_project_id` SET TAGS ('dbx_business_glossary_term' = 'It Project Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Requester ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `system_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Primary System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `rollback_change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Rollback Change Request Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `rollback_change_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `affected_services` SET TAGS ('dbx_business_glossary_term' = 'Affected Services');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `affected_systems` SET TAGS ('dbx_business_glossary_term' = 'Affected Systems');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `approval_notes` SET TAGS ('dbx_business_glossary_term' = 'Approval Notes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `assigned_to_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `assigned_to_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `cab_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Change Advisory Board (CAB) Approval Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `cab_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Change Advisory Board (CAB) Approval Required Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `cab_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Change Advisory Board (CAB) Approval Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `cab_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional|not_required');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `change_category` SET TAGS ('dbx_business_glossary_term' = 'Change Category');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `change_category` SET TAGS ('dbx_value_regex' = 'infrastructure|application|security|network|database|platform');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `change_number` SET TAGS ('dbx_business_glossary_term' = 'Change Request Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `change_number` SET TAGS ('dbx_value_regex' = '^CHG[0-9]{7}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'standard|normal|emergency|expedited');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Notes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `change_request_description` SET TAGS ('dbx_business_glossary_term' = 'Change Request Description');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `downtime_required` SET TAGS ('dbx_business_glossary_term' = 'Downtime Required Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `estimated_downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Downtime Duration (Minutes)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `implementation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Implementation Outcome');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `implementation_outcome` SET TAGS ('dbx_value_regex' = 'successful|failed|partially_successful|rolled_back');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `implementation_plan` SET TAGS ('dbx_business_glossary_term' = 'Implementation Plan');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `post_implementation_notes` SET TAGS ('dbx_business_glossary_term' = 'Post-Implementation Notes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `post_implementation_review_completed` SET TAGS ('dbx_business_glossary_term' = 'Post-Implementation Review (PIR) Completed Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `post_implementation_review_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Implementation Review (PIR) Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Change Priority');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `requester_email` SET TAGS ('dbx_business_glossary_term' = 'Requester Email Address');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `requester_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `requester_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `requester_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `requester_name` SET TAGS ('dbx_business_glossary_term' = 'Requester Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `requester_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Level');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `rollback_plan` SET TAGS ('dbx_business_glossary_term' = 'Rollback Plan');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `scheduled_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `change_request_status` SET TAGS ('dbx_business_glossary_term' = 'Change Request Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `test_plan` SET TAGS ('dbx_business_glossary_term' = 'Test Plan');
ALTER TABLE `vibe_ngo_v1`.`technology`.`change_request` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Change Request Title');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `it_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Information Technology (IT) Incident ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `caused_by_it_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Caused By It Incident Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `caused_by_it_incident_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `it_problem_id` SET TAGS ('dbx_business_glossary_term' = 'Related Problem ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `it_service_id` SET TAGS ('dbx_business_glossary_term' = 'It Service Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Related Change ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `system_platform_id` SET TAGS ('dbx_business_glossary_term' = 'System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `affected_country_office` SET TAGS ('dbx_business_glossary_term' = 'Affected Country Office');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `affected_country_office` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `affected_program` SET TAGS ('dbx_business_glossary_term' = 'Affected Program');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assigned Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Assigned To');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `assigned_to` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `breach_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Breach Notification Required');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `business_impact` SET TAGS ('dbx_business_glossary_term' = 'Business Impact');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `business_impact` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `it_incident_category` SET TAGS ('dbx_business_glossary_term' = 'Incident Category');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `it_incident_category` SET TAGS ('dbx_value_regex' = 'hardware|software|network|security|data|platform');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `communication_sent` SET TAGS ('dbx_business_glossary_term' = 'Communication Sent');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `data_breach` SET TAGS ('dbx_business_glossary_term' = 'Data Breach');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `detected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detected Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime in Minutes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `escalated` SET TAGS ('dbx_business_glossary_term' = 'Escalated');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'L1|L2|L3|management|vendor');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `financial_impact_usd` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact in United States Dollars (USD)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `financial_impact_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `impacted_user_count` SET TAGS ('dbx_business_glossary_term' = 'Impacted User Count');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `mean_time_to_resolution_minutes` SET TAGS ('dbx_business_glossary_term' = 'Mean Time to Resolution (MTTR) in Minutes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `number` SET TAGS ('dbx_value_regex' = '^INC[0-9]{6,10}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `reported_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolved Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'infrastructure|application|configuration|security|human_error|third_party');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `security_incident` SET TAGS ('dbx_business_glossary_term' = 'Security Incident');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'P1|P2|P3|P4');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `it_incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Incident Subcategory');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `user_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'User Satisfaction Rating');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `vendor_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Ticket Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `workaround_applied` SET TAGS ('dbx_business_glossary_term' = 'Workaround Applied');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_incident` ALTER COLUMN `workaround_description` SET TAGS ('dbx_business_glossary_term' = 'Workaround Description');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` SET TAGS ('dbx_subdomain' = 'infrastructure_connectivity');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `network_site_id` SET TAGS ('dbx_business_glossary_term' = 'Network Site ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `upstream_network_site_id` SET TAGS ('dbx_business_glossary_term' = 'Upstream Network Site Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `upstream_network_site_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `address` SET TAGS ('dbx_business_glossary_term' = 'Physical Address');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `backup_bandwidth_mbps` SET TAGS ('dbx_business_glossary_term' = 'Backup Bandwidth (Mbps)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `backup_connectivity_type` SET TAGS ('dbx_business_glossary_term' = 'Backup Connectivity Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `bandwidth_capacity_mbps` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth Capacity (Mbps)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `city` SET TAGS ('dbx_pii_location' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `network_site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `network_site_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `connectivity_type` SET TAGS ('dbx_business_glossary_term' = 'Connectivity Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `disaster_recovery_tier` SET TAGS ('dbx_business_glossary_term' = 'Disaster Recovery Tier');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `equipment_inventory` SET TAGS ('dbx_business_glossary_term' = 'Equipment Inventory');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `firewall_enabled` SET TAGS ('dbx_business_glossary_term' = 'Firewall Enabled');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `ip_address_range` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address Range');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `ip_address_range` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `ip_address_range` SET TAGS ('dbx_pii_location' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `isp_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Internet Service Provider (ISP) Contract Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `isp_contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `isp_provider` SET TAGS ('dbx_business_glossary_term' = 'Internet Service Provider (ISP) Provider');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `monthly_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Monthly Cost (USD)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `monthly_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `network_site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `network_site_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `network_administrator_email` SET TAGS ('dbx_business_glossary_term' = 'Network Administrator Email');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `network_administrator_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `network_administrator_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `network_administrator_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `network_administrator_name` SET TAGS ('dbx_business_glossary_term' = 'Network Administrator Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `network_administrator_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `network_administrator_phone` SET TAGS ('dbx_business_glossary_term' = 'Network Administrator Phone');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `network_administrator_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `network_administrator_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|planned|decommissioned|suspended');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `security_classification` SET TAGS ('dbx_business_glossary_term' = 'Security Classification');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `security_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `network_site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `network_site_type` SET TAGS ('dbx_value_regex' = 'country_office|field_site|headquarters|regional_office|data_center|cloud_endpoint');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `uptime_sla_percentage` SET TAGS ('dbx_business_glossary_term' = 'Uptime Service Level Agreement (SLA) Percentage');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `uptime_sla_percentage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `vlan_number` SET TAGS ('dbx_business_glossary_term' = 'Virtual Local Area Network (VLAN) ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `vlan_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`network_site` ALTER COLUMN `vpn_enabled` SET TAGS ('dbx_business_glossary_term' = 'Virtual Private Network (VPN) Enabled');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` SET TAGS ('dbx_subdomain' = 'infrastructure_connectivity');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `connectivity_log_id` SET TAGS ('dbx_business_glossary_term' = 'Connectivity Log ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Field Office ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `it_incident_id` SET TAGS ('dbx_business_glossary_term' = 'It Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `network_site_id` SET TAGS ('dbx_business_glossary_term' = 'Network Site ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `previous_connectivity_log_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Connectivity Log Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `previous_connectivity_log_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `affected_users_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Users Count');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `bandwidth_utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth Utilization Percentage');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `business_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Business Impact Description');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `cause_classification` SET TAGS ('dbx_business_glossary_term' = 'Cause Classification');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `cause_classification` SET TAGS ('dbx_value_regex' = 'isp_fault|power_outage|equipment_failure|weather|configuration_error|capacity_exceeded');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `cause_description` SET TAGS ('dbx_business_glossary_term' = 'Cause Description');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `connection_status` SET TAGS ('dbx_business_glossary_term' = 'Connection Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `connection_status` SET TAGS ('dbx_value_regex' = 'up|down|degraded|intermittent|maintenance|unknown');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `connection_type` SET TAGS ('dbx_business_glossary_term' = 'Connection Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `connection_type` SET TAGS ('dbx_value_regex' = 'fiber|satellite|cellular|microwave|dsl|cable');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `device_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Device Internet Protocol (IP) Address');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `device_ip_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `device_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `device_ip_address` SET TAGS ('dbx_pii_location' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `device_mac_address` SET TAGS ('dbx_business_glossary_term' = 'Device Media Access Control (MAC) Address');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `device_mac_address` SET TAGS ('dbx_value_regex' = '^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `device_mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `device_mac_address` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `download_speed_mbps` SET TAGS ('dbx_business_glossary_term' = 'Download Speed (Megabits per Second)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `isp_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Internet Service Provider (ISP) Provider Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `isp_provider_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `jitter_ms` SET TAGS ('dbx_business_glossary_term' = 'Jitter (Milliseconds)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Latency (Milliseconds)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'automated|manual|scheduled|on_demand');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `monitoring_tool` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Tool');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `outage_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Outage Duration (Minutes)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `outage_duration_minutes` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `outage_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outage End Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `outage_end_timestamp` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `outage_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outage Start Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `outage_start_timestamp` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `packet_loss_percent` SET TAGS ('dbx_business_glossary_term' = 'Packet Loss Percentage');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Signal Strength (Decibel-Milliwatts)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `sla_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliant Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `sla_target_uptime_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Uptime Percentage');
ALTER TABLE `vibe_ngo_v1`.`technology`.`connectivity_log` ALTER COLUMN `upload_speed_mbps` SET TAGS ('dbx_business_glossary_term' = 'Upload Speed (Megabits per Second)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` SET TAGS ('dbx_subdomain' = 'access_security');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `user_account_id` SET TAGS ('dbx_business_glossary_term' = 'User Account ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `parent_user_account_id` SET TAGS ('dbx_business_glossary_term' = 'Linked User Account Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `parent_user_account_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `system_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Primary System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Member ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `access_level` SET TAGS ('dbx_value_regex' = 'read_only|standard|power_user|administrator|super_admin');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `active_directory_guid` SET TAGS ('dbx_business_glossary_term' = 'Active Directory Global Unique Identifier (GUID)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `active_directory_guid` SET TAGS ('dbx_value_regex' = '^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `active_directory_guid` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `active_directory_guid` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `beneficiary_data_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Data Access Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `commcare_username` SET TAGS ('dbx_business_glossary_term' = 'CommCare Username');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `commcare_username` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._-]{3,64}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `commcare_username` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `commcare_username` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `data_protection_acknowledgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Acknowledgment Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `deprovisioning_date` SET TAGS ('dbx_business_glossary_term' = 'Deprovisioning Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `deprovisioning_reason` SET TAGS ('dbx_business_glossary_term' = 'Deprovisioning Reason');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `deprovisioning_reason` SET TAGS ('dbx_value_regex' = 'employment_ended|contract_expired|voluntary_resignation|security_violation|duplicate_account|other');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `dhis2_username` SET TAGS ('dbx_business_glossary_term' = 'District Health Information System 2 (DHIS2) Username');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `dhis2_username` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._-]{3,64}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `dhis2_username` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `dhis2_username` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `donor_data_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Data Access Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `failed_login_attempts` SET TAGS ('dbx_business_glossary_term' = 'Failed Login Attempts');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `failed_login_attempts` SET TAGS ('dbx_pii_credential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `field_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Field Access Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `financial_system_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial System Access Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `kobotoolbox_username` SET TAGS ('dbx_business_glossary_term' = 'KoboToolbox Username');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `kobotoolbox_username` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._-]{3,64}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `kobotoolbox_username` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `kobotoolbox_username` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `last_login_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Login Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `last_login_timestamp` SET TAGS ('dbx_pii_credential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `last_password_change_date` SET TAGS ('dbx_business_glossary_term' = 'Last Password Change Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `last_password_change_date` SET TAGS ('dbx_pii_credential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `locked_flag` SET TAGS ('dbx_business_glossary_term' = 'Account Locked Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `locked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Account Locked Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `mfa_enrolled_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Factor Authentication (MFA) Enrolled Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `mfa_method` SET TAGS ('dbx_business_glossary_term' = 'Multi-Factor Authentication (MFA) Method');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `mfa_method` SET TAGS ('dbx_value_regex' = 'authenticator_app|sms|email|hardware_token|biometric|none');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `mobile_device_registered_flag` SET TAGS ('dbx_business_glossary_term' = 'Mobile Device Registered Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `mobile_device_registered_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `mobile_device_registered_flag` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `password_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Password Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `password_expiry_date` SET TAGS ('dbx_pii_credential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `privileged_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Privileged Account Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `provisioning_date` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `remote_access_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Access Enabled Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `salesforce_user_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce User ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `salesforce_user_code` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9]{15,18}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `salesforce_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `salesforce_user_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `sap_user_code` SET TAGS ('dbx_business_glossary_term' = 'SAP User ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `sap_user_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,12}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `sap_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `sap_user_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `security_training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Security Training Completion Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `user_account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `user_account_status` SET TAGS ('dbx_value_regex' = 'active|suspended|locked|deprovisioned|pending_activation');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `user_account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `user_account_type` SET TAGS ('dbx_value_regex' = 'staff|volunteer|partner|contractor|consultant|system_service');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `username` SET TAGS ('dbx_business_glossary_term' = 'Username');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `username` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._-]{3,64}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `username` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `username` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `workday_user_code` SET TAGS ('dbx_business_glossary_term' = 'Workday User ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `workday_user_code` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9_-]{1,32}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `workday_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`user_account` ALTER COLUMN `workday_user_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` SET TAGS ('dbx_subdomain' = 'access_security');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `access_role_id` SET TAGS ('dbx_business_glossary_term' = 'Access Role Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `parent_access_role_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Access Role Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `parent_access_role_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `system_platform_id` SET TAGS ('dbx_business_glossary_term' = 'System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `access_scope` SET TAGS ('dbx_business_glossary_term' = 'Access Scope');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `access_scope` SET TAGS ('dbx_value_regex' = 'global|regional|country|program|project|department');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `active_user_count` SET TAGS ('dbx_business_glossary_term' = 'Active User Count');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `approval_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `approval_authority_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `approval_authority_title` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Title');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `audit_logging_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Logging Required');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `access_role_code` SET TAGS ('dbx_business_glossary_term' = 'Role Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `data_domain_access` SET TAGS ('dbx_business_glossary_term' = 'Data Domain Access');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `access_role_description` SET TAGS ('dbx_business_glossary_term' = 'Role Description');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `last_recertification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Recertification Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `least_privilege_flag` SET TAGS ('dbx_business_glossary_term' = 'Least Privilege Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `module_access` SET TAGS ('dbx_business_glossary_term' = 'Module Access');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `multi_factor_authentication_required` SET TAGS ('dbx_business_glossary_term' = 'Multi-Factor Authentication (MFA) Required');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `access_role_name` SET TAGS ('dbx_business_glossary_term' = 'Role Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `access_role_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `next_recertification_date` SET TAGS ('dbx_business_glossary_term' = 'Next Recertification Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `owner_email` SET TAGS ('dbx_business_glossary_term' = 'Role Owner Email Address');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii_contact' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Role Owner Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `owner_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `permission_scope` SET TAGS ('dbx_business_glossary_term' = 'Permission Scope');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `permission_scope` SET TAGS ('dbx_value_regex' = 'read|write|admin|execute|delete|full_control');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `privileged_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Privileged Access Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `recertification_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Recertification Frequency (Days)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `segregation_of_duties_flag` SET TAGS ('dbx_business_glossary_term' = 'Segregation of Duties (SoD) Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `access_role_status` SET TAGS ('dbx_business_glossary_term' = 'Role Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `access_role_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|deprecated|pending_approval');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `access_role_type` SET TAGS ('dbx_business_glossary_term' = 'Role Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `access_role_type` SET TAGS ('dbx_value_regex' = 'functional|technical|administrative|executive|field_operations|donor_relations');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_role` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` SET TAGS ('dbx_subdomain' = 'access_security');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `access_provisioning_id` SET TAGS ('dbx_business_glossary_term' = 'Access Provisioning ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `access_role_id` SET TAGS ('dbx_business_glossary_term' = 'Access Role Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `primary_access_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Target User Employee ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `primary_access_staff_member_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `primary_access_staff_member_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `user_account_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By User ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `superseded_access_provisioning_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Access Provisioning Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `superseded_access_provisioning_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `system_platform_id` SET TAGS ('dbx_business_glossary_term' = 'System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `target_user_user_account_id` SET TAGS ('dbx_business_glossary_term' = 'Target User ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `tertiary_access_compliance_signoff_by_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Sign-Off By ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `tertiary_access_compliance_signoff_by_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `tertiary_access_compliance_signoff_by_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `access_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Access Duration Days');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `access_level` SET TAGS ('dbx_value_regex' = 'read_only|read_write|admin|super_admin|restricted');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `access_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Access Review Due Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `beneficiary_data_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Data Access Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Completed Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `compliance_signoff_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Sign-Off Required Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `compliance_signoff_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Sign-Off Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `data_classification_access_level` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Access Level');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `data_classification_access_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `deprovisioning_reason` SET TAGS ('dbx_business_glossary_term' = 'Deprovisioning Reason');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `donor_audit_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Audit Requirement Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `financial_data_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Data Access Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `jml_lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Joiner-Mover-Leaver (JML) Lifecycle Stage');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `jml_lifecycle_stage` SET TAGS ('dbx_value_regex' = 'joiner|mover|leaver|contractor_onboard|contractor_offboard');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `jml_lifecycle_stage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `last_access_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Access Review Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `multi_factor_authentication_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Factor Authentication (MFA) Required Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Access Provisioning Notes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `remote_access_permitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Access Permitted Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Access Provisioning Request Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^APR-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Access Request Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `request_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Submitted Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Access Request Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'grant|modify|revoke|suspend|reinstate|transfer');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `security_incident_reference` SET TAGS ('dbx_business_glossary_term' = 'Security Incident Reference');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `security_incident_reference` SET TAGS ('dbx_value_regex' = '^INC-[0-9]{8}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `target_system_environment` SET TAGS ('dbx_business_glossary_term' = 'Target System Environment');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `target_system_environment` SET TAGS ('dbx_value_regex' = 'production|staging|development|training|sandbox');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `target_user_email` SET TAGS ('dbx_business_glossary_term' = 'Target User Email Address');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `target_user_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `target_user_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`access_provisioning` ALTER COLUMN `target_user_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` SET TAGS ('dbx_subdomain' = 'access_security');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `security_control_id` SET TAGS ('dbx_business_glossary_term' = 'Security Control Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `psea_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Enforced Psea Policy Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `parent_security_control_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Security Control Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `parent_security_control_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `system_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Primary System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `annual_maintenance_cost` SET TAGS ('dbx_business_glossary_term' = 'Annual Maintenance Cost');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `annual_maintenance_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `applicable_data_classification` SET TAGS ('dbx_business_glossary_term' = 'Applicable Data Classification Levels');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `applicable_systems` SET TAGS ('dbx_business_glossary_term' = 'Applicable Systems');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `audit_trail_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `automation_level` SET TAGS ('dbx_business_glossary_term' = 'Control Automation Level');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `automation_level` SET TAGS ('dbx_value_regex' = 'manual|semi_automated|fully_automated');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `compensating_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensating Control Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `compliance_mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Mandatory Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `security_control_description` SET TAGS ('dbx_business_glossary_term' = 'Security Control Description');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `domain` SET TAGS ('dbx_business_glossary_term' = 'Security Control Domain');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Control Effectiveness Rating');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective|not_tested');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `evidence_location` SET TAGS ('dbx_business_glossary_term' = 'Control Evidence Location');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `evidence_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `exception_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `exception_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Granted Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `exception_justification` SET TAGS ('dbx_business_glossary_term' = 'Exception Justification');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `exception_justification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `framework_mapping` SET TAGS ('dbx_business_glossary_term' = 'Security Framework Mapping');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `identifier` SET TAGS ('dbx_business_glossary_term' = 'Control Identifier Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `identifier` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}-[A-Z0-9]{2,10}(-[A-Z0-9]{1,10})?$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `implementation_cost` SET TAGS ('dbx_business_glossary_term' = 'Implementation Cost');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `implementation_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `implementation_guidance` SET TAGS ('dbx_business_glossary_term' = 'Implementation Guidance');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `implementation_status` SET TAGS ('dbx_value_regex' = 'not_implemented|planned|in_progress|implemented|operational|decommissioned');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `maturity_level` SET TAGS ('dbx_business_glossary_term' = 'Control Maturity Level');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `maturity_level` SET TAGS ('dbx_value_regex' = 'initial|developing|defined|managed|optimizing');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `security_control_name` SET TAGS ('dbx_business_glossary_term' = 'Security Control Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `security_control_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `next_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Control Notes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Security Control Objective');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Security Control Owner');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Control Owner Department');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `related_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Related Policy Reference');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Control Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `testing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Control Testing Frequency');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `security_control_type` SET TAGS ('dbx_business_glossary_term' = 'Security Control Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `security_control_type` SET TAGS ('dbx_value_regex' = 'preventive|detective|corrective|deterrent|compensating|directive');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_control` ALTER COLUMN `vendor_solution` SET TAGS ('dbx_business_glossary_term' = 'Vendor Solution');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` SET TAGS ('dbx_subdomain' = 'access_security');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `security_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Security Assessment ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `followup_security_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Followup Security Assessment Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `followup_security_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `system_platform_id` SET TAGS ('dbx_business_glossary_term' = 'System Platform ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `assessor_certification` SET TAGS ('dbx_business_glossary_term' = 'Assessor Certification');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `beneficiary_data_at_risk` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Data at Risk');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partially_compliant|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `conducting_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Conducting Entity Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `conducting_entity_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `conducting_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Conducting Entity Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `conducting_entity_type` SET TAGS ('dbx_value_regex' = 'internal|external|joint');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Assessment Cost');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `data_classification_assessed` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Assessed');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `data_classification_assessed` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `security_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `donor_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Donor Reporting Required');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment End Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `executive_summary` SET TAGS ('dbx_business_glossary_term' = 'Executive Summary');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `executive_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Assessment Frequency');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|ad_hoc|continuous');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `high_findings_count` SET TAGS ('dbx_business_glossary_term' = 'High Findings Count');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `key_recommendations` SET TAGS ('dbx_business_glossary_term' = 'Key Recommendations');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `key_recommendations` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `low_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Low Findings Count');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `medium_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Medium Findings Count');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `methodology_used` SET TAGS ('dbx_business_glossary_term' = 'Methodology Used');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `overall_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `overall_risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|minimal');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `remediation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Remediation Deadline');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|overdue|deferred');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `report_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Report Document Reference');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `report_document_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `report_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Report Issued Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Assessment Scope');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Start Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `security_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `security_assessment_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|on_hold');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `tools_used` SET TAGS ('dbx_business_glossary_term' = 'Tools Used');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `total_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `security_assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `security_assessment_type` SET TAGS ('dbx_value_regex' = 'penetration_test|vulnerability_scan|isms_audit|third_party_review|compliance_audit|risk_assessment');
ALTER TABLE `vibe_ngo_v1`.`technology`.`security_assessment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` SET TAGS ('dbx_subdomain' = 'access_security');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `vulnerability_id` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'It Asset Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `parent_vulnerability_id` SET TAGS ('dbx_business_glossary_term' = 'Related Vulnerability Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `parent_vulnerability_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `it_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Related Incident Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `system_platform_id` SET TAGS ('dbx_business_glossary_term' = 'System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `actual_remediation_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Remediation Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `affected_component` SET TAGS ('dbx_business_glossary_term' = 'Affected Component');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `affected_data_classification` SET TAGS ('dbx_business_glossary_term' = 'Affected Data Classification Level');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `affected_data_classification` SET TAGS ('dbx_value_regex' = 'Restricted|Confidential|Internal|Public');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `affected_version` SET TAGS ('dbx_business_glossary_term' = 'Affected Version');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `business_impact` SET TAGS ('dbx_business_glossary_term' = 'Business Impact');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `compliance_impact` SET TAGS ('dbx_business_glossary_term' = 'Compliance Impact');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `cve_identifier` SET TAGS ('dbx_business_glossary_term' = 'Common Vulnerabilities and Exposures (CVE) Identifier');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `cve_identifier` SET TAGS ('dbx_value_regex' = '^CVE-[0-9]{4}-[0-9]{4,}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `cvss_score` SET TAGS ('dbx_business_glossary_term' = 'Common Vulnerability Scoring System (CVSS) Score');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `cvss_vector` SET TAGS ('dbx_business_glossary_term' = 'Common Vulnerability Scoring System (CVSS) Vector String');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `vulnerability_description` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Description');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `discovery_method` SET TAGS ('dbx_business_glossary_term' = 'Discovery Method');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `discovery_method` SET TAGS ('dbx_value_regex' = 'Automated Scan|Penetration Test|Vendor Advisory|Security Audit|Incident Response|Bug Bounty');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `exploitability_status` SET TAGS ('dbx_business_glossary_term' = 'Exploitability Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `exploitability_status` SET TAGS ('dbx_value_regex' = 'Not Exploitable|Proof of Concept|Exploited in Wild|Weaponized|Unknown');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `patch_available` SET TAGS ('dbx_business_glossary_term' = 'Patch Available Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `patch_identifier` SET TAGS ('dbx_business_glossary_term' = 'Patch Identifier');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `reference_urls` SET TAGS ('dbx_business_glossary_term' = 'Reference Uniform Resource Locators (URLs)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `remediation_owner` SET TAGS ('dbx_business_glossary_term' = 'Remediation Owner');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `severity_rating` SET TAGS ('dbx_business_glossary_term' = 'Severity Rating');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `severity_rating` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low|Informational');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `vulnerability_status` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `vulnerability_status` SET TAGS ('dbx_value_regex' = 'Open|In Progress|Remediated|Accepted|Mitigated|Closed');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `target_remediation_date` SET TAGS ('dbx_business_glossary_term' = 'Target Remediation Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Title');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `vulnerability_type` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `vulnerability_type` SET TAGS ('dbx_value_regex' = 'SQL Injection|Cross-Site Scripting (XSS)|Buffer Overflow|Authentication Bypass|Privilege Escalation|Remote Code Execution');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `vendor_advisory_url` SET TAGS ('dbx_business_glossary_term' = 'Vendor Advisory Uniform Resource Locator (URL)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'Not Verified|Verified|Failed Verification|Pending Verification');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `workaround_available` SET TAGS ('dbx_business_glossary_term' = 'Workaround Available Flag');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `workaround_description` SET TAGS ('dbx_business_glossary_term' = 'Workaround Description');
ALTER TABLE `vibe_ngo_v1`.`technology`.`vulnerability` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `software_license_id` SET TAGS ('dbx_business_glossary_term' = 'Software License ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `system_platform_id` SET TAGS ('dbx_business_glossary_term' = 'System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `upgraded_from_software_license_id` SET TAGS ('dbx_business_glossary_term' = 'Upgraded From Software License Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `upgraded_from_software_license_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `annual_cost` SET TAGS ('dbx_business_glossary_term' = 'Annual Cost');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `auto_renewal_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Enabled');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `compliance_frameworks` SET TAGS ('dbx_business_glossary_term' = 'Compliance Frameworks');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|audit_required');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `cost_per_seat` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Seat');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `deployment_type` SET TAGS ('dbx_business_glossary_term' = 'Deployment Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `deployment_type` SET TAGS ('dbx_value_regex' = 'cloud|on_premise|hybrid|saas');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `disaster_recovery_tier` SET TAGS ('dbx_business_glossary_term' = 'Disaster Recovery (DR) Tier');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `disaster_recovery_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `is_mission_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Mission Critical');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `owner_email` SET TAGS ('dbx_business_glossary_term' = 'License Owner Email');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii_contact' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'License Owner Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `owner_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|one_time|multi_year');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `primary_business_domain` SET TAGS ('dbx_business_glossary_term' = 'Primary Business Domain');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `product_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `product_version` SET TAGS ('dbx_business_glossary_term' = 'Product Version');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `seats_available` SET TAGS ('dbx_business_glossary_term' = 'Seats Available');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `seats_consumed` SET TAGS ('dbx_business_glossary_term' = 'Seats Consumed');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `software_license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `software_license_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|pending_renewal|cancelled|trial');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `support_tier` SET TAGS ('dbx_business_glossary_term' = 'Support Tier');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `support_tier` SET TAGS ('dbx_value_regex' = 'basic|standard|premium|enterprise|community');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Technical Contact Email');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_pii_contact' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `technical_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Technical Contact Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `technical_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `technical_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `total_seats_purchased` SET TAGS ('dbx_business_glossary_term' = 'Total Seats Purchased');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `software_license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `vendor_account_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Account Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `vendor_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `vendor_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `vendor_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`software_license` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `it_project_id` SET TAGS ('dbx_business_glossary_term' = 'Information Technology (IT) Project ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `parent_it_project_id` SET TAGS ('dbx_business_glossary_term' = 'Parent It Project Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `parent_it_project_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `primary_it_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `primary_it_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `primary_it_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `system_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Primary System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `tertiary_it_business_sponsor_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Business Sponsor ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `tertiary_it_business_sponsor_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `tertiary_it_business_sponsor_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `tertiary_it_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'It Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `tertiary_it_staff_member_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `lead_staff_member_id` SET TAGS ('dbx_renamed_from' = 'staff_member_id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `affected_systems` SET TAGS ('dbx_business_glossary_term' = 'Affected Systems');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `it_project_category` SET TAGS ('dbx_business_glossary_term' = 'Project Category');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `it_project_category` SET TAGS ('dbx_value_regex' = 'strategic|operational|compliance|innovation');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `it_project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `it_project_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4,6}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `compliance_frameworks` SET TAGS ('dbx_business_glossary_term' = 'Compliance Frameworks');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `delivery_methodology` SET TAGS ('dbx_business_glossary_term' = 'Delivery Methodology');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `delivery_methodology` SET TAGS ('dbx_value_regex' = 'agile|waterfall|hybrid|iterative');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `it_project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `forecast_end_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast End Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `health_status` SET TAGS ('dbx_business_glossary_term' = 'Project Health Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `health_status` SET TAGS ('dbx_value_regex' = 'green|yellow|red');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `health_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `health_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `health_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `integration_count` SET TAGS ('dbx_business_glossary_term' = 'Integration Count');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `it_project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `it_project_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Project Priority');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `sponsoring_domain` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Business Domain');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `it_project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `it_project_status` SET TAGS ('dbx_value_regex' = 'planning|active|on_hold|completed|cancelled|closed');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `success_criteria` SET TAGS ('dbx_business_glossary_term' = 'Success Criteria');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `it_project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `it_project_type` SET TAGS ('dbx_value_regex' = 'system_implementation|platform_migration|infrastructure_upgrade|data_governance|security_enhancement|integration_development');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `user_count` SET TAGS ('dbx_business_glossary_term' = 'User Count');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `vendor_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_project` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `platform_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Integration ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `primary_platform_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Integration Owner ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `primary_platform_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `primary_platform_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `replaced_platform_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Replaced Platform Integration Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `replaced_platform_integration_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `system_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Source System Platform ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `target_system_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Target System Platform ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'oauth2|api_key|basic_auth|certificate|saml|none');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `platform_integration_code` SET TAGS ('dbx_business_glossary_term' = 'Integration Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `compliance_frameworks` SET TAGS ('dbx_business_glossary_term' = 'Compliance Frameworks');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `data_domain` SET TAGS ('dbx_business_glossary_term' = 'Data Domain');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `data_entity` SET TAGS ('dbx_business_glossary_term' = 'Data Entity');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `data_transformation_required` SET TAGS ('dbx_business_glossary_term' = 'Data Transformation Required');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `encryption_enabled` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `encryption_protocol` SET TAGS ('dbx_business_glossary_term' = 'Encryption Protocol');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `error_handling_strategy` SET TAGS ('dbx_business_glossary_term' = 'Error Handling Strategy');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `error_handling_strategy` SET TAGS ('dbx_value_regex' = 'retry|skip|halt|log_and_continue');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `last_failed_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Failed Run Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `last_successful_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Successful Run Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `monitoring_enabled` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Enabled');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `platform_integration_name` SET TAGS ('dbx_business_glossary_term' = 'Integration Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `platform_integration_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|testing|decommissioned');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `pattern` SET TAGS ('dbx_business_glossary_term' = 'Integration Pattern');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `pattern` SET TAGS ('dbx_value_regex' = 'api|etl|webhook|file_transfer|message_queue|database_replication');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `sla_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `sla_uptime_percentage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `source_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Source Endpoint');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `sync_frequency` SET TAGS ('dbx_business_glossary_term' = 'Synchronization Frequency');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `sync_frequency` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly|monthly|on_demand');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `sync_schedule` SET TAGS ('dbx_business_glossary_term' = 'Synchronization Schedule');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `target_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Target Endpoint');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `timeout_seconds` SET TAGS ('dbx_business_glossary_term' = 'Timeout Seconds');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `total_records_transferred` SET TAGS ('dbx_business_glossary_term' = 'Total Records Transferred');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `transformation_logic` SET TAGS ('dbx_business_glossary_term' = 'Transformation Logic');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `platform_integration_type` SET TAGS ('dbx_business_glossary_term' = 'Integration Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`platform_integration` ALTER COLUMN `platform_integration_type` SET TAGS ('dbx_value_regex' = 'data_sync|event_stream|batch_transfer|api_integration|file_exchange|webhook');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `backup_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Backup Schedule ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `parent_backup_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Backup Schedule Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `parent_backup_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `system_platform_id` SET TAGS ('dbx_business_glossary_term' = 'System Platform ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `alert_on_failure` SET TAGS ('dbx_business_glossary_term' = 'Alert on Failure');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `alert_recipients` SET TAGS ('dbx_business_glossary_term' = 'Alert Recipients');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `alert_recipients` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `backup_frequency` SET TAGS ('dbx_business_glossary_term' = 'Backup Frequency');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `backup_frequency` SET TAGS ('dbx_value_regex' = 'hourly|daily|weekly|monthly|quarterly|on-demand');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `backup_type` SET TAGS ('dbx_business_glossary_term' = 'Backup Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `backup_type` SET TAGS ('dbx_value_regex' = 'full|incremental|differential|snapshot|continuous');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `backup_verification_enabled` SET TAGS ('dbx_business_glossary_term' = 'Backup Verification Enabled');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `backup_window_end_time` SET TAGS ('dbx_business_glossary_term' = 'Backup Window End Time');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `backup_window_start_time` SET TAGS ('dbx_business_glossary_term' = 'Backup Window Start Time');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `backup_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Backup Schedule Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `backup_schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `compliance_frameworks` SET TAGS ('dbx_business_glossary_term' = 'Compliance Frameworks');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `compression_enabled` SET TAGS ('dbx_business_glossary_term' = 'Compression Enabled');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `compression_ratio` SET TAGS ('dbx_business_glossary_term' = 'Compression Ratio');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `cron_expression` SET TAGS ('dbx_business_glossary_term' = 'Schedule Cron Expression');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `data_asset_name` SET TAGS ('dbx_business_glossary_term' = 'Data Asset Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `data_asset_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `disaster_recovery_tier` SET TAGS ('dbx_business_glossary_term' = 'Disaster Recovery (DR) Tier');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `disaster_recovery_tier` SET TAGS ('dbx_value_regex' = 'tier-1-critical|tier-2-high|tier-3-medium|tier-4-low');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `encryption_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Encryption Algorithm');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `encryption_enabled` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `last_backup_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Last Backup Duration Minutes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `last_backup_size_gb` SET TAGS ('dbx_business_glossary_term' = 'Last Backup Size Gigabytes (GB)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `last_backup_status` SET TAGS ('dbx_business_glossary_term' = 'Last Backup Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `last_backup_status` SET TAGS ('dbx_value_regex' = 'success|failed|partial|in-progress|skipped');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `last_backup_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Backup Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `last_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `last_verification_status` SET TAGS ('dbx_value_regex' = 'passed|failed|not-verified');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `last_verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `backup_schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Backup Schedule Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `backup_schedule_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `next_scheduled_backup_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Backup Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `responsible_team` SET TAGS ('dbx_business_glossary_term' = 'Responsible Team');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Days');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `rpo_minutes` SET TAGS ('dbx_business_glossary_term' = 'Recovery Point Objective (RPO) Minutes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `rto_minutes` SET TAGS ('dbx_business_glossary_term' = 'Recovery Time Objective (RTO) Minutes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `backup_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `backup_schedule_status` SET TAGS ('dbx_value_regex' = 'active|suspended|disabled|archived');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `storage_location_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `storage_location_type` SET TAGS ('dbx_value_regex' = 'on-site|cloud|offsite|hybrid');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `storage_location_type` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `storage_path` SET TAGS ('dbx_business_glossary_term' = 'Storage Path');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `storage_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `storage_path` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `storage_provider` SET TAGS ('dbx_business_glossary_term' = 'Storage Provider');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `storage_provider` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `technical_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Technical Owner Email');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `technical_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `technical_owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `technical_owner_email` SET TAGS ('dbx_pii_contact' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `technical_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Technical Owner Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`backup_schedule` ALTER COLUMN `technical_owner_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `it_procurement_id` SET TAGS ('dbx_business_glossary_term' = 'Information Technology (IT) Procurement ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Staff ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `parent_it_procurement_id` SET TAGS ('dbx_business_glossary_term' = 'Parent It Procurement Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `parent_it_procurement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `primary_it_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Requester Staff ID');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `primary_it_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `primary_it_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting It Asset Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `software_license_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Software License Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `approver_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `compliance_check_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Required');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `country_office_code` SET TAGS ('dbx_business_glossary_term' = 'Country Office Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `country_office_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `delivery_confirmed_by` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmed By');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|paid|partially_paid|overdue|cancelled');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `requester_email` SET TAGS ('dbx_business_glossary_term' = 'Requester Email Address');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `requester_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `requester_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `requester_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `requester_name` SET TAGS ('dbx_business_glossary_term' = 'Requester Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `requester_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^REQ-IT-[0-9]{6,10}$');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `it_procurement_status` SET TAGS ('dbx_business_glossary_term' = 'Procurement Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `it_procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_procurement` ALTER COLUMN `vendor_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `cab_meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Cab Meeting Identifier');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `followup_cab_meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Followup Cab Meeting Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `followup_cab_meeting_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `action_items_count` SET TAGS ('dbx_business_glossary_term' = 'Action Items Count');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `agenda_document_url` SET TAGS ('dbx_business_glossary_term' = 'Agenda Document Url');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `agenda_document_url` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `changes_approved` SET TAGS ('dbx_business_glossary_term' = 'Changes Approved');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `changes_deferred` SET TAGS ('dbx_business_glossary_term' = 'Changes Deferred');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `changes_rejected` SET TAGS ('dbx_business_glossary_term' = 'Changes Rejected');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `is_emergency_meeting` SET TAGS ('dbx_business_glossary_term' = 'Is Emergency Meeting');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Meeting Location');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `minutes_document_url` SET TAGS ('dbx_business_glossary_term' = 'Minutes Document Url');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `next_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Next Meeting Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Meeting Notes');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Meeting Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Meeting Platform');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `quorum_met` SET TAGS ('dbx_business_glossary_term' = 'Quorum Met');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `quorum_required` SET TAGS ('dbx_business_glossary_term' = 'Quorum Required');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `recording_url` SET TAGS ('dbx_business_glossary_term' = 'Recording Url');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `series_code` SET TAGS ('dbx_business_glossary_term' = 'Meeting Series Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `cab_meeting_status` SET TAGS ('dbx_business_glossary_term' = 'Meeting Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `total_attendees` SET TAGS ('dbx_business_glossary_term' = 'Total Attendees');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `total_changes_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Total Changes Reviewed');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `cab_meeting_type` SET TAGS ('dbx_business_glossary_term' = 'Meeting Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`cab_meeting` ALTER COLUMN `voting_members_present` SET TAGS ('dbx_business_glossary_term' = 'Voting Members Present');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `it_problem_id` SET TAGS ('dbx_business_glossary_term' = 'It Problem Identifier');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `parent_it_problem_id` SET TAGS ('dbx_business_glossary_term' = 'Related It Problem Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `parent_it_problem_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `actual_resolution_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Hours');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `affected_configuration_item` SET TAGS ('dbx_business_glossary_term' = 'Affected Configuration Item');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `affected_service` SET TAGS ('dbx_business_glossary_term' = 'Affected Service');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `assigned_group` SET TAGS ('dbx_business_glossary_term' = 'Assigned Group');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Assigned To');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `it_problem_category` SET TAGS ('dbx_business_glossary_term' = 'Problem Category');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `change_request_number` SET TAGS ('dbx_business_glossary_term' = 'Change Request Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `closed_by` SET TAGS ('dbx_business_glossary_term' = 'Closed By');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `it_problem_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `detected_date` SET TAGS ('dbx_business_glossary_term' = 'Detected Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `environment` SET TAGS ('dbx_business_glossary_term' = 'Environment');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `estimated_resolution_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Resolution Hours');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `geographic_location` SET TAGS ('dbx_business_glossary_term' = 'Geographic Location');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `impact` SET TAGS ('dbx_business_glossary_term' = 'Impact');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `incident_count` SET TAGS ('dbx_business_glossary_term' = 'Incident Count');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `known_error` SET TAGS ('dbx_business_glossary_term' = 'Known Error');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `known_error_date` SET TAGS ('dbx_business_glossary_term' = 'Known Error Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Problem Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `preventive_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Taken');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `recurring_problem` SET TAGS ('dbx_business_glossary_term' = 'Recurring Problem');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `it_problem_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Problem Subcategory');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `urgency` SET TAGS ('dbx_business_glossary_term' = 'Urgency');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `vendor_reference` SET TAGS ('dbx_business_glossary_term' = 'Vendor Reference');
ALTER TABLE `vibe_ngo_v1`.`technology`.`it_problem` ALTER COLUMN `workaround_description` SET TAGS ('dbx_business_glossary_term' = 'Workaround Description');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `knowledge_article_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Article Identifier');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `owner_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `owner_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `owner_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `reviewer_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `reviewer_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `reviewer_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `superseded_knowledge_article_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Knowledge Article Id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `superseded_knowledge_article_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `author_staff_member_id` SET TAGS ('dbx_renamed_from' = 'staff_member_id');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `archived_date` SET TAGS ('dbx_business_glossary_term' = 'Archived Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `average_rating` SET TAGS ('dbx_business_glossary_term' = 'Average Rating');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `average_rating` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `knowledge_article_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `content` SET TAGS ('dbx_business_glossary_term' = 'Content');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `external_url` SET TAGS ('dbx_business_glossary_term' = 'External Url');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `helpful_count` SET TAGS ('dbx_business_glossary_term' = 'Helpful Count');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `is_featured` SET TAGS ('dbx_business_glossary_term' = 'Is Featured');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `is_searchable` SET TAGS ('dbx_business_glossary_term' = 'Is Searchable');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `not_helpful_count` SET TAGS ('dbx_business_glossary_term' = 'Not Helpful Count');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Article Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `published_date` SET TAGS ('dbx_business_glossary_term' = 'Published Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `related_system` SET TAGS ('dbx_business_glossary_term' = 'Related System');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `retired_date` SET TAGS ('dbx_business_glossary_term' = 'Retired Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `knowledge_article_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Subcategory');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `summary` SET TAGS ('dbx_business_glossary_term' = 'Summary');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `knowledge_article_type` SET TAGS ('dbx_business_glossary_term' = 'Article Type');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `view_count` SET TAGS ('dbx_business_glossary_term' = 'View Count');
ALTER TABLE `vibe_ngo_v1`.`technology`.`knowledge_article` ALTER COLUMN `visibility` SET TAGS ('dbx_business_glossary_term' = 'Visibility');
