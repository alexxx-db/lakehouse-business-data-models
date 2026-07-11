-- Schema for Domain: interoperability | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 14:11:14

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`interoperability` COMMENT 'Manages healthcare data exchange standards (HL7v2, FHIR, CDA), HIE participation, interface engine configurations, message tracking, and data transformation mappings for interoperability with external systems and health information exchanges.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` (
    `exchange_standard_id` BIGINT COMMENT 'Unique identifier for the healthcare data exchange standard record. Primary key.',
    `superseded_exchange_standard_id` BIGINT COMMENT 'Self-referencing FK on exchange_standard (superseded_exchange_standard_id)',
    `employee_id` BIGINT COMMENT 'add column workforce_employee_id (BIGINT) with FK to workforce.employee.employee_id - exchange standards need a steward/owner but the table only has a self-ref',
    `backward_compatibility` BOOLEAN COMMENT 'Boolean flag indicating whether this version of the exchange standard is backward compatible with previous versions (True) or requires breaking changes (False).',
    `certification_date` DATE COMMENT 'Date when ONC Health IT Certification or other third-party certification was achieved for this exchange standard implementation.',
    `certification_status` STRING COMMENT 'Status of ONC Health IT Certification or other third-party certification for this exchange standard implementation: certified (passed certification), pending (under review), not_required (certification not applicable), failed (did not pass).. Valid values are `certified|pending|not_required|failed`',
    `character_set` STRING COMMENT 'Character encoding standard used for text data in this exchange standard (e.g., UTF-8, ASCII, ISO-8859-1).',
    `conformance_profile` STRING COMMENT 'Name or identifier of the conformance profile, implementation guide, or constraint specification applied to this standard (e.g., US Core, IHE PIX, Carequality Framework).',
    `contact_email` STRING COMMENT 'Email address of the technical lead or subject matter expert responsible for this exchange standard.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_person` STRING COMMENT 'Name of the technical lead, integration architect, or subject matter expert responsible for this exchange standard within the organization.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this exchange standard record was first created in the system.',
    `documentation_url` STRING COMMENT 'Web URL to internal implementation guides, mapping documentation, or configuration instructions for this exchange standard.',
    `effective_date` DATE COMMENT 'Date when this exchange standard version became effective and available for use in the organizations interoperability infrastructure.',
    `encoding_format` STRING COMMENT 'Data encoding format used by this exchange standard: pipe_delimited (HL7v2), xml (CDA, FHIR XML), json (FHIR JSON), edi (X12), binary (DICOM).. Valid values are `pipe_delimited|xml|json|edi|binary`',
    `end_date` DATE COMMENT 'Date when this exchange standard version was deprecated or retired from active use. Null if still active.',
    `governing_body` STRING COMMENT 'Name of the standards development organization or governing body responsible for maintaining this exchange standard (e.g., HL7 International, ANSI ASC X12, NEMA, IHE).',
    `hie_participation` STRING COMMENT 'Comma-separated list of Health Information Exchange networks or frameworks that require or support this exchange standard (e.g., Carequality, CommonWell, eHealth Exchange, State HIE).',
    `interface_engine_support` STRING COMMENT 'Name and version of the interface engine or integration platform that supports this exchange standard (e.g., Epic Bridges, Cerner Millennium Interface Engine, Rhapsody, Mirth Connect).',
    `is_mandatory` BOOLEAN COMMENT 'Boolean flag indicating whether support for this exchange standard is mandatory for regulatory compliance or organizational policy (True) or optional (False).',
    `message_types_supported` STRING COMMENT 'Comma-separated list of message types, event codes, or transaction sets supported under this standard (e.g., ADT^A01, ADT^A04, ORM^O01, ORU^R01, MDM^T02, SIU^S12, DFT^P03 for HL7v2; 837I, 837P, 835, 270, 271, 278 for X12).',
    `migration_path` STRING COMMENT 'Description of the migration or upgrade path from previous versions of this exchange standard, including transformation rules and mapping guidance.',
    `notes` STRING COMMENT 'Additional notes, comments, or special considerations related to the implementation, configuration, or usage of this exchange standard.',
    `publication_date` DATE COMMENT 'Date when this version of the exchange standard was officially published or released by the governing body.',
    `regulatory_requirement` STRING COMMENT 'Name of the regulatory mandate, certification requirement, or compliance framework that requires support for this exchange standard (e.g., ONC 2015 Edition, CMS Interoperability Rule, Carequality Framework).',
    `resource_types_supported` STRING COMMENT 'Comma-separated list of FHIR resource types or CDA document types supported (e.g., Patient, Observation, Encounter, MedicationRequest for FHIR; CCD, C-CDA, QRDA for CDA).',
    `security_profile` STRING COMMENT 'Name of the security profile or framework applied to protect data exchanged using this standard (e.g., IHE ATNA, SMART on FHIR, OAuth 2.0, SAML 2.0).',
    `specification_url` STRING COMMENT 'Web URL to the official specification documentation for this exchange standard version.',
    `standard_code` STRING COMMENT 'Short code or abbreviation for the exchange standard used in system configurations and interface mappings (e.g., HL7V2, FHIR, CDA, X12, DICOM).',
    `standard_name` STRING COMMENT 'Official name of the healthcare data exchange standard (e.g., HL7 Version 2, FHIR R4, CDA R2, X12 EDI, DICOM).',
    `standard_type` STRING COMMENT 'Category of the exchange standard indicating its primary purpose: messaging (HL7v2), document (CDA), transaction (X12 EDI), imaging (DICOM), or API (FHIR).. Valid values are `messaging|document|transaction|imaging|api`',
    `exchange_standard_status` STRING COMMENT 'Current lifecycle status of the exchange standard within the organization: active (in production use), deprecated (supported but discouraged), retired (no longer supported), planned (approved for future implementation), testing (under evaluation).. Valid values are `active|deprecated|retired|planned|testing`',
    `terminology_binding` STRING COMMENT 'Comma-separated list of standard code systems and value sets bound to this exchange standard (e.g., SNOMED CT, LOINC, RxNorm, ICD-10-CM, CPT, CVX).',
    `testing_tool` STRING COMMENT 'Name of the testing or validation tool used to verify conformance to this exchange standard (e.g., NIST HL7v2 Validator, Touchstone FHIR Testing, X12 EDI Validator).',
    `transport_protocol` STRING COMMENT 'Network transport protocol(s) used to transmit messages conforming to this standard (e.g., MLLP, HTTPS, SFTP, AS2, Direct Secure Messaging).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this exchange standard record was last modified or updated.',
    `use_case_description` STRING COMMENT 'Detailed description of the primary business use cases and clinical workflows supported by this exchange standard (e.g., patient admission/discharge/transfer notifications, lab result delivery, claims submission, clinical document exchange).',
    `validation_rules` STRING COMMENT 'Description of validation rules, schematron constraints, or conformance checks applied to messages or documents conforming to this standard.',
    `version` STRING COMMENT 'Version number or release identifier of the exchange standard (e.g., 2.5.1, R4, STU3, 5010, 2021e).',
    CONSTRAINT pk_exchange_standard PRIMARY KEY(`exchange_standard_id`)
) COMMENT 'Reference master catalog of healthcare data exchange standards supported by the organization, including HL7v2 message types (ADT, ORM, ORU, MDM, SIU, DFT), HL7 FHIR versions (R4, STU3), CDA document types (CCD, C-CDA, QRDA), X12 EDI transaction sets (837, 835, 270/271, 278), and DICOM. Captures standard name, version, specification URL, conformance profile, supported message events, and activation status. Serves as the authoritative reference for all interface and mapping configurations.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` (
    `trading_partner_id` BIGINT COMMENT 'Unique identifier for the trading partner record. Primary key for the trading partner entity.',
    `interface_engine_id` BIGINT COMMENT 'Reference identifier for the interface engine configuration profile associated with this trading partner. Links to specific message routing, transformation, and validation rules.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Trading partners in healthcare interoperability are often provider organizations (hospitals, clinics, physician groups). NPI field exists but lacks FK. Interface management, credentialing validation, ',
    `parent_trading_partner_id` BIGINT COMMENT 'Self-referencing FK on trading_partner (parent_trading_partner_id)',
    `active_flag` BOOLEAN COMMENT 'Indicates whether the trading partner relationship is currently active and data exchange is enabled. Inactive partners are retained for historical reference.',
    `address_line_1` STRING COMMENT 'First line of the trading partner organizations primary business address (street number and name).',
    `address_line_2` STRING COMMENT 'Second line of the trading partner organizations address (suite, floor, building, or other secondary address information).',
    `cda_endpoint_url` STRING COMMENT 'Endpoint URL for exchanging CDA documents (C-CDA) with the trading partner. Used for continuity of care documents and clinical summaries.',
    `certification_expiration_date` DATE COMMENT 'Date on which the trading partners current interoperability certification expires. Null if not certified or certification does not expire.',
    `certification_status` STRING COMMENT 'Current certification or accreditation status of the trading partner for interoperability standards compliance (e.g., ONC Health IT Certification, EHNAC accreditation).. Valid values are `not_certified|in_certification|certified|expired`',
    `city` STRING COMMENT 'City name of the trading partner organizations primary business address.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the trading partner organizations primary business address.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the trading partner record was first created in the system.',
    `data_sharing_agreement_reference` STRING COMMENT 'Reference identifier or document number for the executed data sharing agreement, business associate agreement, or memorandum of understanding governing the interoperability relationship.',
    `data_transformation_mapping_reference` STRING COMMENT 'Reference identifier or document name for the data transformation and mapping specifications used to translate data formats between internal systems and the trading partners expected format.',
    `direct_address` STRING COMMENT 'Direct Protocol email-style address for secure, encrypted health information exchange. Used for point-to-point clinical messaging.',
    `effective_end_date` DATE COMMENT 'Date on which the trading partner relationship and data exchange agreement ended or is scheduled to end. Null for ongoing relationships.',
    `effective_start_date` DATE COMMENT 'Date on which the trading partner relationship and data exchange agreement became effective.',
    `exchange_volume_last_30_days` STRING COMMENT 'Total count of messages or transactions exchanged with this trading partner in the last 30 days. Used for capacity planning and relationship monitoring.',
    `fhir_endpoint_url` STRING COMMENT 'Base URL for the trading partners FHIR API endpoint. Used for RESTful FHIR-based data exchange and queries.',
    `hie_network_name` STRING COMMENT 'Name of the primary HIE network through which data is exchanged with this trading partner (e.g., regional HIE, CommonWell, Carequality).',
    `hie_participation_flag` BOOLEAN COMMENT 'Indicates whether the trading partner actively participates in one or more regional or national Health Information Exchanges.',
    `hl7v2_endpoint_url` STRING COMMENT 'Network endpoint (MLLP, HTTPS, or other transport) for HL7 Version 2 message exchange with the trading partner.',
    `last_successful_exchange_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful data exchange (message sent or received) with this trading partner. Used for monitoring connectivity and operational health.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the trading partner record was most recently modified.',
    `message_tracking_enabled_flag` BOOLEAN COMMENT 'Indicates whether detailed message-level tracking and logging is enabled for exchanges with this trading partner. Used for audit, troubleshooting, and compliance monitoring.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or context about the trading partner relationship, technical requirements, or operational considerations.',
    `npi` STRING COMMENT 'Ten-digit National Provider Identifier assigned by CMS. Used for HIPAA-compliant transactions and provider identification in interoperability exchanges.. Valid values are `^[0-9]{10}$`',
    `oid` STRING COMMENT 'HL7 Object Identifier uniquely identifying the trading partner in HL7 message exchanges. Hierarchical dotted-decimal format per ISO/IEC 8824 standard.',
    `onboarding_status` STRING COMMENT 'Current lifecycle status of the trading partner onboarding and integration process. Tracks progression from initial planning through active data exchange.. Valid values are `planning|in_progress|testing|active|suspended|terminated`',
    `operational_contact_email` STRING COMMENT 'Email address of the primary operational contact for technical coordination, interface troubleshooting, and data exchange issue escalation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `operational_contact_name` STRING COMMENT 'Full name of the primary operational contact at the trading partner organization responsible for interoperability coordination and issue resolution.',
    `operational_contact_phone` STRING COMMENT 'Primary phone number for the operational contact at the trading partner organization.',
    `partner_name` STRING COMMENT 'Official legal or business name of the external trading partner organization (hospital, clinic, HIE, payer, lab, pharmacy, public health agency, ACO partner).',
    `partner_type` STRING COMMENT 'Classification of the trading partner entity type. Determines the nature of the interoperability relationship and data exchange patterns. [ENUM-REF-CANDIDATE: hospital|clinic|hie|payer|lab|pharmacy|public_health_agency|aco_partner — 8 candidates stripped; promote to reference product]',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the trading partner organizations primary business address.',
    `sla_response_time_hours` DECIMAL(18,2) COMMENT 'Contractual or agreed-upon maximum response time in hours for the trading partner to acknowledge or respond to data exchange requests.',
    `state_province` STRING COMMENT 'State or province code of the trading partner organizations primary business address. Two-letter abbreviation for US states.',
    `supported_standards` STRING COMMENT 'Comma-separated list of interoperability standards and versions supported by the trading partner (e.g., HL7v2.5.1, FHIR R4, C-CDA R2.1, X12 5010).',
    `technical_contact_email` STRING COMMENT 'Email address of the technical contact for interface specifications, HL7 message troubleshooting, and API integration support.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `technical_contact_name` STRING COMMENT 'Full name of the technical contact responsible for interface engine configuration, message format specifications, and technical integration support.',
    `technical_contact_phone` STRING COMMENT 'Primary phone number for the technical contact at the trading partner organization.',
    CONSTRAINT pk_trading_partner PRIMARY KEY(`trading_partner_id`)
) COMMENT 'Master record for every external entity with which the healthcare organization exchanges clinical or administrative data. Includes hospitals, clinics, HIEs (Health Information Exchanges), payers, public health agencies, labs, pharmacies, and ACO partners. Captures partner name, NPI, OID (HL7 Object Identifier), endpoint URLs, supported standards, data sharing agreement reference, onboarding status, and operational contact. SSOT for external interoperability partner identity.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` (
    `interface_engine_id` BIGINT COMMENT 'Unique identifier for the interface engine instance. Primary key for the interface engine master record.',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility or data center where this interface engine instance is physically or logically hosted.',
    `replaced_interface_engine_id` BIGINT COMMENT 'Self-referencing FK on interface_engine (replaced_interface_engine_id)',
    `admin_url` STRING COMMENT 'Web-based administrative console URL used by technical staff to configure and monitor the interface engine.',
    `audit_logging_enabled` BOOLEAN COMMENT 'Indicates whether comprehensive audit logging is enabled to track all message processing activities and system access.',
    `cloud_provider` STRING COMMENT 'Name of the cloud service provider hosting the interface engine, if applicable to cloud or hybrid deployments. [ENUM-REF-CANDIDATE: AWS|Azure|Google Cloud|Oracle Cloud|IBM Cloud|On-Premise|Not Applicable — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this interface engine record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date when the interface engine was retired from service and removed from active operations.',
    `deployment_environment` STRING COMMENT 'Environment classification indicating the operational tier where this interface engine instance is deployed.. Valid values are `production|staging|development|test|disaster_recovery|sandbox`',
    `disaster_recovery_enabled` BOOLEAN COMMENT 'Indicates whether disaster recovery capabilities are configured for this interface engine instance.',
    `encryption_enabled` BOOLEAN COMMENT 'Indicates whether data encryption is enabled for messages in transit and at rest within the interface engine.',
    `engine_code` STRING COMMENT 'Short alphanumeric code or abbreviation used to uniquely identify the interface engine in technical documentation and system configurations.',
    `engine_name` STRING COMMENT 'Business-friendly name assigned to this interface engine instance for identification and operational reference.',
    `fhir_version_support` STRING COMMENT 'Fast Healthcare Interoperability Resources (FHIR) specification versions supported, such as DSTU2, STU3, R4, R5.',
    `go_live_date` DATE COMMENT 'Date when the interface engine was activated for production message processing and integration workflows.',
    `high_availability_enabled` BOOLEAN COMMENT 'Indicates whether the interface engine is configured with high availability features such as clustering or failover.',
    `hipaa_compliant` BOOLEAN COMMENT 'Indicates whether the interface engine configuration meets Health Insurance Portability and Accountability Act (HIPAA) compliance requirements for Protected Health Information (PHI) transmission.',
    `hitrust_certified` BOOLEAN COMMENT 'Indicates whether the interface engine has achieved Health Information Trust Alliance Common Security Framework (HITRUST CSF) certification.',
    `hl7_version_support` STRING COMMENT 'Specific HL7 message versions supported by the interface engine, such as 2.3, 2.4, 2.5, 2.6, 2.7, 2.8.',
    `hosting_model` STRING COMMENT 'Infrastructure deployment model describing where and how the interface engine is hosted and managed.. Valid values are `on_premise|cloud|hybrid|saas|paas|iaas`',
    `installation_date` DATE COMMENT 'Date when the interface engine software was initially installed and configured in the environment.',
    `last_maintenance_date` DATE COMMENT 'Date when the most recent scheduled maintenance or system update was performed on the interface engine.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this interface engine record was most recently modified or updated.',
    `license_expiration_date` DATE COMMENT 'Date when the current software license for the interface engine expires and requires renewal.',
    `license_type` STRING COMMENT 'Type of software license under which the interface engine is deployed and operated.. Valid values are `perpetual|subscription|open_source|enterprise|community|trial`',
    `max_concurrent_connections` STRING COMMENT 'Maximum number of simultaneous interface connections or channels that this engine instance can support.',
    `message_throughput_capacity` STRING COMMENT 'Maximum number of messages per hour that the interface engine is designed to process under normal operating conditions.',
    `next_scheduled_maintenance_date` DATE COMMENT 'Date when the next planned maintenance window or system upgrade is scheduled for this interface engine.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special configurations, or important information about this interface engine instance.',
    `operational_status` STRING COMMENT 'Current operational state of the interface engine indicating its availability and readiness for message processing.. Valid values are `active|inactive|maintenance|decommissioned|planned|suspended`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary technical contact for operational issues and escalations related to this interface engine.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary technical contact or administrator responsible for this interface engine.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary technical contact for urgent operational support and incident response.',
    `primary_hostname` STRING COMMENT 'Fully qualified domain name or hostname used to access the primary interface engine instance.',
    `primary_ip_address` STRING COMMENT 'Primary Internet Protocol address assigned to the interface engine instance for network communication.',
    `product_name` STRING COMMENT 'Specific product name or edition of the interface engine software as designated by the vendor.',
    `responsible_team` STRING COMMENT 'Name of the IT or integration team responsible for managing, maintaining, and supporting this interface engine instance.',
    `support_contract_expiration_date` DATE COMMENT 'Date when the current vendor support and maintenance contract expires.',
    `support_contract_status` STRING COMMENT 'Current status of the vendor support and maintenance contract for this interface engine instance.. Valid values are `active|expired|pending_renewal|not_applicable`',
    `supported_protocols` STRING COMMENT 'Comma-separated list of communication protocols supported by this interface engine instance, such as HL7v2, FHIR, CDA, DICOM, X12.',
    `vendor_name` STRING COMMENT 'Name of the software vendor or manufacturer that provides the interface engine platform. [ENUM-REF-CANDIDATE: Mirth Connect|NextGen Connect|Rhapsody|Qvera|Ensemble|HealthShare|Cloverleaf|Corepoint|Azure API for FHIR|AWS HealthLake|Google Cloud Healthcare API|Custom Built|Other — 13 candidates stripped; promote to reference product]',
    `version` STRING COMMENT 'Current version number of the interface engine software installed, including major, minor, and patch levels.',
    CONSTRAINT pk_interface_engine PRIMARY KEY(`interface_engine_id`)
) COMMENT 'Master record for every interface engine instance and integration platform deployed within the organization, including Mirth Connect, Rhapsody, Ensemble/HealthShare, Azure API for FHIR, and AWS HealthLake. Captures engine name, vendor, version, deployment environment (prod/stage/dev), hosting model (on-prem/cloud), primary IP/hostname, admin URL, operational status, and responsible team. SSOT for interface infrastructure inventory.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` (
    `interface_channel_id` BIGINT COMMENT 'Unique identifier for the interface channel configuration. Primary key for the interface channel master record.',
    `exchange_standard_id` BIGINT COMMENT 'Foreign key linking to interoperability.exchange_standard. Business justification: Interface channels implement specific exchange standards (HL7v2, FHIR, CDA, X12, etc.). Currently this is captured as STRING columns message_standard and message_version. Adding exchange_standard_id F',
    `care_site_id` BIGINT COMMENT 'add column facility_care_site_id (BIGINT) with FK to facility.care_site.care_site_id - interface channels serve specific facilities but lack a care_site FK',
    `interface_engine_id` BIGINT COMMENT 'add column interoperability_interface_engine_id (BIGINT) with FK to interoperability.interface_engine.interface_engine_id - channels run on interface engines but lack this FK',
    `replaced_interface_channel_id` BIGINT COMMENT 'Self-referencing FK on interface_channel (replaced_interface_channel_id)',
    `trading_partner_id` BIGINT COMMENT '',
    `acknowledgment_required` BOOLEAN COMMENT 'Indicates whether the interface channel requires acknowledgment messages (ACK/NACK) from the receiving system to confirm successful message receipt and processing per HL7 protocol.',
    `acknowledgment_timeout_seconds` STRING COMMENT 'Maximum time in seconds the interface engine will wait for an acknowledgment message before treating the transmission as failed.',
    `audit_logging_enabled` BOOLEAN COMMENT 'Indicates whether detailed audit logging is enabled for all messages transmitted through this channel to support HIPAA compliance, troubleshooting, and security monitoring.',
    `authentication_method` STRING COMMENT 'Security authentication mechanism used to verify identity when establishing connection through this interface channel.. Valid values are `none|basic|certificate|oauth|saml|mutual_tls`',
    `business_owner_name` STRING COMMENT 'Name of the business stakeholder or department responsible for the functional requirements and operational oversight of this interface channel.',
    `channel_code` STRING COMMENT 'Unique business identifier or code for the interface channel, often used in operational monitoring and troubleshooting.',
    `channel_name` STRING COMMENT 'Human-readable name assigned to this interface channel for identification and management purposes within the interface engine.',
    `channel_status` STRING COMMENT 'Current operational status of the interface channel indicating whether it is actively processing messages, temporarily disabled, under testing, or in an error state.. Valid values are `active|inactive|testing|suspended|maintenance|error`',
    `channel_type` STRING COMMENT 'Directional classification of the interface channel indicating whether it receives data (inbound), sends data (outbound), or supports both directions (bidirectional).. Valid values are `inbound|outbound|bidirectional`',
    `connection_host` STRING COMMENT 'Network host address (IP address or hostname) used to establish connection with the remote system for message transmission.',
    `connection_port` STRING COMMENT 'Network port number used for establishing connection with the remote system. Standard MLLP ports are typically in the range 5000-6000.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this interface channel record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date when this interface channel was or is planned to be deactivated and removed from production service.',
    `destination_facility_identifier` STRING COMMENT 'Identifier of the destination facility or organization receiving messages, often corresponding to the MSH-6 receiving facility field in HL7v2 messages.',
    `destination_system_identifier` STRING COMMENT 'Technical identifier or code for the destination system as configured in the interface engine, often corresponding to the MSH-5 receiving application field in HL7v2 messages.',
    `destination_system_name` STRING COMMENT 'Name of the receiving system or application that consumes messages from this interface channel (e.g., laboratory information system, radiology information system, health information exchange).',
    `encryption_enabled` BOOLEAN COMMENT 'Indicates whether data transmitted through this interface channel is encrypted in transit to protect Protected Health Information (PHI) per HIPAA requirements.',
    `encryption_protocol` STRING COMMENT 'Specific encryption protocol or cipher suite used for securing data transmission (e.g., TLS 1.2, TLS 1.3, AES-256).',
    `go_live_date` DATE COMMENT 'Date when this interface channel was first activated and began processing production messages.',
    `hie_network_name` STRING COMMENT 'Name of the Health Information Exchange network or community this channel connects to (e.g., state HIE, CommonWell, Carequality).',
    `hie_participant_flag` BOOLEAN COMMENT 'Indicates whether this interface channel is used for participation in a regional or national Health Information Exchange network for sharing patient data across organizations.',
    `last_tested_date` DATE COMMENT 'Most recent date when this interface channel underwent testing or validation to ensure continued operational integrity.',
    `max_message_size_kb` STRING COMMENT 'Maximum allowed size in kilobytes for a single message transmitted through this channel. Large messages (e.g., CDA documents with embedded images) may require higher limits.',
    `message_archival_days` STRING COMMENT 'Number of days that transmitted messages are retained in the interface engine archive for audit, troubleshooting, and compliance purposes before purging.',
    `message_encoding` STRING COMMENT 'Data encoding format used for message serialization. ER7 (pipe-delimited) is standard for HL7v2, XML for CDA and some HL7v2, JSON for FHIR REST APIs.. Valid values are `ER7|XML|JSON|PIPE|FIXED`',
    `message_event_type` STRING COMMENT 'Specific message event or trigger type handled by this channel (e.g., ADT^A01 for patient admission, ORU^R01 for lab results, SIU^S12 for appointment notification). Defines the business transaction supported.',
    `message_retry_count` STRING COMMENT 'Number of automatic retry attempts the interface engine will make if message transmission fails before escalating to error handling.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this interface channel configuration, performance, and business requirements.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special configuration details, known issues, or business context related to this interface channel.',
    `phi_transmitted_flag` BOOLEAN COMMENT 'Indicates whether this interface channel transmits Protected Health Information subject to HIPAA privacy and security regulations, requiring enhanced monitoring and audit controls.',
    `retry_interval_seconds` STRING COMMENT 'Time interval in seconds between automatic retry attempts for failed message transmissions.',
    `sla_tier` STRING COMMENT 'Priority tier assigned to this interface channel defining expected uptime, response time, and support escalation procedures. Critical tier for life-safety interfaces (e.g., ED admissions), standard for routine reporting.. Valid values are `critical|high|standard|low`',
    `sla_uptime_target_percent` DECIMAL(18,2) COMMENT 'Target uptime percentage defined in the service level agreement for this interface channel (e.g., 99.9% for critical interfaces, 99.0% for standard).',
    `source_facility_identifier` STRING COMMENT 'Identifier of the source facility or organization sending messages, often corresponding to the MSH-4 sending facility field in HL7v2 messages.',
    `source_system_identifier` STRING COMMENT 'Technical identifier or code for the source system as configured in the interface engine, often corresponding to the MSH-3 sending application field in HL7v2 messages.',
    `source_system_name` STRING COMMENT 'Name of the originating system or application that sends messages through this interface channel (e.g., Epic EHR, Cerner Millennium, MEDITECH, PACS).',
    `support_contact_email` STRING COMMENT 'Primary email address for technical support escalation and incident notification related to this interface channel.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `support_contact_phone` STRING COMMENT 'Primary phone number for technical support escalation and incident notification related to this interface channel.',
    `technical_owner_name` STRING COMMENT 'Name of the technical team or individual responsible for configuration, maintenance, and troubleshooting of this interface channel.',
    `transformation_map_name` STRING COMMENT 'Name of the data transformation or mapping configuration applied to messages passing through this channel to convert between different formats, vocabularies, or data structures.',
    `transport_protocol` STRING COMMENT 'Network transport protocol used by the interface channel to transmit messages between source and destination systems. MLLP (Minimal Lower Layer Protocol) is standard for HL7v2, while HTTP/HTTPS/REST are common for FHIR. [ENUM-REF-CANDIDATE: MLLP|HTTP|HTTPS|SFTP|FTP|SOAP|REST|TCP|DICOM — 9 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this interface channel record was last modified.',
    CONSTRAINT pk_interface_channel PRIMARY KEY(`interface_channel_id`)
) COMMENT 'Master record for every configured interface channel (connection) within an interface engine, representing a discrete data flow between a source system and a destination system. Captures channel name, channel type (inbound/outbound/bidirectional), transport protocol (MLLP, HTTP/S, SFTP, SOAP, REST), source system, destination system, message standard, message event type, encoding (ER7/XML/JSON), channel status (active/inactive/testing), and SLA tier. Each channel is the atomic unit of interface management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` (
    `message_log_id` BIGINT COMMENT 'Unique identifier for each healthcare message transaction processed through the interface engine. Primary key for the message log.',
    `interface_channel_id` BIGINT COMMENT 'Foreign key linking to interoperability.interface_channel. Business justification: Message logs must link to the interface channel that processed them. Currently only interface_name (STRING) exists. FK to interface_channel enables proper channel tracking, monitoring channel-specific',
    `mapping_rule_id` BIGINT COMMENT 'Identifier of the transformation rule set or mapping configuration applied to this message. Used for transformation audit trails and troubleshooting data mapping issues.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: HL7 ADT and clinical messages reference patient identity for routing, processing, and reconciliation. Message audit trails require authoritative patient linkage for safety investigations, duplicate me',
    `original_message_log_id` BIGINT COMMENT 'Reference to the message_log_id of the original message if this is a duplicate or retry. Used for linking duplicate messages and retry attempts back to the original transaction for audit trail completeness.',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility or system that originated and sent the message. Corresponds to MSH-4 in HL7 v2.x. Used for routing and source system identification.',
    `receiving_facility_care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility or system that is the intended recipient of the message. Corresponds to MSH-6 in HL7 v2.x. Used for routing and destination system identification.',
    `scheduling_appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: ADT messages (A04 admit, A08 update, A11 cancel) reference the triggering appointment. Interface engines log appointment_id for reconciliation when inbound/outbound scheduling messages fail. Real-worl',
    `visit_id` BIGINT COMMENT 'The unique identifier for the patient encounter or visit associated with this message, extracted from PV1-19 in HL7 v2.x ADT messages. Used for encounter-level message correlation and clinical workflow tracking.',
    `ack_code` STRING COMMENT 'The acknowledgment code returned by the receiving system indicating message acceptance status. AA=Application Accept, AE=Application Error, AR=Application Reject, CA=Commit Accept, CE=Commit Error, CR=Commit Reject. Corresponds to MSA-1 in HL7 v2.x ACK messages.. Valid values are `AA|AE|AR|CA|CE|CR`',
    `ack_timestamp` TIMESTAMP COMMENT 'The date and time when the acknowledgment (ACK) message was received from the destination system. Used for round-trip latency measurement and SLA compliance verification.',
    `business_event_type` STRING COMMENT 'High-level business event classification derived from the message type (e.g., Patient Admission, Lab Result, Medication Order, Appointment Scheduling, Charge Posting). Used for business-level reporting and analytics independent of technical message type codes.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this message log record was first created in the data warehouse. Used for data lineage tracking and audit trail purposes.',
    `destination_ip_address` STRING COMMENT 'IP address of the receiving system that accepted the message. Used for routing verification, network troubleshooting, and security audit trails.',
    `duplicate_check_performed` BOOLEAN COMMENT 'Indicates whether the interface engine performed duplicate message detection based on message_control_id or other unique identifiers. True if duplicate check was performed, False otherwise. Used for idempotency verification.',
    `encryption_applied` BOOLEAN COMMENT 'Indicates whether the message was encrypted during transmission (e.g., TLS/SSL for transport encryption, message-level encryption). True if encryption was applied, False otherwise. Critical for HIPAA Security Rule compliance verification.',
    `error_code` STRING COMMENT 'Standardized error code assigned when message processing fails. May correspond to HL7 v2.x error codes (ERR segment) or interface engine-specific error classification codes. Used for error categorization and root cause analysis.',
    `error_description` STRING COMMENT 'Detailed human-readable description of the error or rejection reason. Includes validation failures, parsing errors, business rule violations, or system connectivity issues. Critical for troubleshooting and resolution.',
    `error_severity` STRING COMMENT 'Severity classification of the error or issue encountered during message processing. Information=informational only, Warning=non-blocking issue, Error=processing failed but recoverable, Fatal=unrecoverable failure requiring manual intervention.. Valid values are `information|warning|error|fatal`',
    `hie_transaction_code` STRING COMMENT 'Unique transaction identifier assigned by the Health Information Exchange when the message is part of an HIE data exchange. Used for cross-organizational message tracking and HIE audit compliance.',
    `is_duplicate` BOOLEAN COMMENT 'Indicates whether this message was identified as a duplicate of a previously processed message. True if duplicate detected, False otherwise. Duplicate messages may be rejected or logged depending on interface configuration.',
    `message_control_number` STRING COMMENT 'Unique message control identifier assigned by the sending system, corresponding to MSH-10 segment in HL7 v2.x messages. Used for message tracking and acknowledgment correlation.',
    `message_priority` STRING COMMENT 'Priority level assigned to the message for processing queue management. STAT=immediate life-threatening, ASAP=as soon as possible, Urgent=expedited processing, Routine=normal processing. May be derived from ORC-7 or OBR-5 in HL7 v2.x order messages.. Valid values are `routine|urgent|stat|asap`',
    `message_sequence_number` BIGINT COMMENT 'Sequential number assigned by the interface engine for message ordering and gap detection. Used to identify missing messages in a sequence and ensure proper message ordering for dependent transactions.',
    `message_standard` STRING COMMENT 'The interoperability standard protocol used for the message transmission (HL7v2 for traditional interface messages, FHIR for modern RESTful API exchanges, CDA for clinical document architecture, X12 for claims and eligibility, NCPDP for pharmacy transactions, DICOM for imaging).. Valid values are `HL7v2|FHIR|CDA|X12|NCPDP|DICOM`',
    `message_timestamp` TIMESTAMP COMMENT 'The date and time when the message was originally created by the sending system. Corresponds to MSH-7 in HL7 v2.x. This is the business event timestamp, distinct from processing timestamps.',
    `message_type` STRING COMMENT 'The type and trigger event of the healthcare message in standard format (e.g., ADT^A01 for patient admission, ORU^R01 for observation result, DFT^P03 for charge posting, SIU^S12 for appointment notification). Corresponds to MSH-9 in HL7 v2.x.',
    `message_version` STRING COMMENT 'Version of the messaging standard used (e.g., 2.3, 2.5.1, 2.7 for HL7 v2.x; R4, STU3 for FHIR; Release 2 for CDA). Corresponds to MSH-12 in HL7 v2.x.',
    `patient_mrn` STRING COMMENT 'The Medical Record Number of the patient referenced in the message, extracted from PID-3 in HL7 v2.x messages. Used for patient-centric message tracking and audit trails. Protected Health Information (PHI) under HIPAA.',
    `payload_size_bytes` BIGINT COMMENT 'Size of the message payload in bytes. Used for capacity planning, bandwidth analysis, and identifying unusually large messages that may impact performance.',
    `phi_present` BOOLEAN COMMENT 'Indicates whether the message contains Protected Health Information as defined by HIPAA Privacy Rule. True if PHI is present, False otherwise. Used for security classification, audit logging, and breach notification workflows.',
    `processing_end_timestamp` TIMESTAMP COMMENT 'The date and time when the interface engine completed processing the message (successfully or with error). Used for latency calculation and throughput analysis.',
    `processing_latency_ms` BIGINT COMMENT 'Total time in milliseconds from message receipt to processing completion. Calculated as the difference between processing_end_timestamp and received_timestamp. Key metric for SLA monitoring and performance optimization.',
    `processing_start_timestamp` TIMESTAMP COMMENT 'The date and time when the interface engine began processing the message (parsing, validation, transformation). Used for performance monitoring and bottleneck identification.',
    `processing_status` STRING COMMENT 'Current processing state of the message in the interface engine workflow. Tracks the message lifecycle from receipt through final disposition. Critical for operational monitoring and error investigation. [ENUM-REF-CANDIDATE: received|processing|processed|acknowledged|errored|rejected|retrying|failed — 8 candidates stripped; promote to reference product]',
    `received_timestamp` TIMESTAMP COMMENT 'The date and time when the message was received by the interface engine infrastructure. Used for latency calculation and SLA monitoring.',
    `receiving_application` STRING COMMENT 'Name or identifier of the destination application system that should receive and process the message. Corresponds to MSH-5 in HL7 v2.x.',
    `retry_count` STRING COMMENT 'Number of times the interface engine has attempted to reprocess this message after initial failure. Used for identifying chronic failures and triggering escalation workflows.',
    `sending_application` STRING COMMENT 'Name or identifier of the source application system that generated the message (e.g., Epic, Cerner, MEDITECH module name). Corresponds to MSH-3 in HL7 v2.x.',
    `sla_met` BOOLEAN COMMENT 'Indicates whether the message processing met the defined SLA threshold. True if processing_latency_ms is less than or equal to sla_threshold_ms, False otherwise. Key metric for operational performance reporting and vendor accountability.',
    `sla_threshold_ms` BIGINT COMMENT 'The maximum allowed processing latency in milliseconds for this message type as defined by the interface SLA. Used for automated SLA compliance monitoring and alerting when processing_latency_ms exceeds this threshold.',
    `source_ip_address` STRING COMMENT 'IP address of the sending system that transmitted the message. Used for security auditing, network troubleshooting, and access control verification.',
    `transformation_applied` BOOLEAN COMMENT 'Indicates whether data transformation or mapping rules were applied to the message during processing (e.g., code set translation, field mapping, data enrichment). True if transformations were applied, False if message was passed through unchanged.',
    `transport_protocol` STRING COMMENT 'The network transport protocol used to transmit the message. MLLP=Minimal Lower Layer Protocol (standard for HL7 v2.x), HTTP/HTTPS for FHIR REST APIs, SFTP/FTP for batch file transfers, SOAP for legacy web services. [ENUM-REF-CANDIDATE: MLLP|HTTP|HTTPS|SFTP|FTP|REST|SOAP — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this message log record was last modified in the data warehouse. Updated when message status changes (e.g., from processing to processed, or when retry attempts occur).',
    `validation_errors` STRING COMMENT 'Detailed list of validation errors or warnings encountered during message validation. Includes schema violations, missing required fields, invalid code values, and business rule failures. Used for data quality monitoring and sender feedback.',
    `validation_status` STRING COMMENT 'Result of message validation against the applicable standard schema and business rules. Passed=all validations successful, Failed=validation errors prevent processing, Warning=non-critical validation issues, Not_Validated=validation was skipped.. Valid values are `passed|failed|warning|not_validated`',
    CONSTRAINT pk_message_log PRIMARY KEY(`message_log_id`)
) COMMENT 'Transactional log of every healthcare message processed through the interface engine infrastructure. Captures message control ID, message type (ADT^A01, ORU^R01, etc.), sending facility, receiving facility, message timestamp, processing status (received/processed/acknowledged/errored/rejected), ACK code, error description, payload size, and processing latency. Serves as the operational audit trail for all HL7v2, FHIR, CDA, and X12 message traffic. Critical for SLA monitoring, error investigation, and compliance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` (
    `message_error_id` BIGINT COMMENT 'Unique identifier for the message error record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the interface analyst, support engineer, or team member assigned to investigate and resolve the error.',
    `interface_channel_id` BIGINT COMMENT 'Reference to the interface engine channel or route where the error occurred.',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: Every message error is associated with a specific message log entry. Currently message_error uses message_control_id (STRING) to reference the message, but this is a weak reference. Adding message_log',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Interface error resolution workflows require patient context to assess clinical impact and prioritize remediation. Patient safety investigations trace errors to affected patients. message_error has pa',
    `related_prior_message_error_id` BIGINT COMMENT 'Self-referencing FK on message_error (related_message_error_id)',
    `visit_id` BIGINT COMMENT 'The encounter or visit identifier associated with the failed message, if applicable.',
    `acknowledgment_code` STRING COMMENT 'The HL7 acknowledgment code returned or expected: AA (Application Accept), AE (Application Error), AR (Application Reject), CA (Commit Accept), CE (Commit Error), CR (Commit Reject).. Valid values are `AA|AE|AR|CA|CE|CR`',
    `actual_resolution_minutes` STRING COMMENT 'The actual time in minutes from error detection to resolution, used for SLA compliance tracking and performance measurement.',
    `business_impact_description` STRING COMMENT 'Description of the operational or clinical impact of the error, such as delayed lab results, missed patient admissions, billing delays, or care coordination disruptions.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this error record was first created in the system.',
    `error_category` STRING COMMENT 'The high-level classification of the error type: parsing (message structure issues), validation (business rule violations), routing (destination resolution failures), transformation (mapping errors), delivery (transmission failures), authentication, authorization, timeout, or system errors. [ENUM-REF-CANDIDATE: parsing|validation|routing|transformation|delivery|authentication|authorization|timeout|system — 9 candidates stripped; promote to reference product]',
    `error_code` STRING COMMENT 'The system-generated error code or exception identifier assigned by the interface engine or application.',
    `error_description` STRING COMMENT 'Detailed human-readable description of the error, including technical details, affected segments or resources, and contextual information for troubleshooting.',
    `error_severity` STRING COMMENT 'The severity level of the error indicating business impact: critical (patient safety or operational halt), high (significant workflow disruption), medium (degraded functionality), low (minor issue), or informational (warning only).. Valid values are `critical|high|medium|low|informational`',
    `error_stack_trace` STRING COMMENT 'The technical stack trace or detailed exception log captured at the point of failure, used for root cause analysis and debugging.',
    `error_timestamp` TIMESTAMP COMMENT 'The precise date and time when the message processing error was detected by the interface engine.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the error was escalated to higher-level support, management, or vendor due to complexity, severity, or SLA breach.',
    `escalation_timestamp` TIMESTAMP COMMENT 'The date and time when the error was escalated for additional support or management attention.',
    `field_position_error` STRING COMMENT 'The specific field position or element path within the segment or resource where the error occurred (e.g., PID-5 for patient name, Patient.name.family).',
    `interface_engine_version` STRING COMMENT 'The version of the interface engine software (e.g., Rhapsody, Mirth Connect, Cloverleaf, Ensemble) that processed the message when the error occurred.',
    `message_segment_error` STRING COMMENT 'The specific HL7 segment (e.g., PID, OBR, DG1) or FHIR resource element path where the error was detected.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this error record was last updated, reflecting status changes, resolution updates, or additional investigation notes.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether automated notifications (email, SMS, dashboard alert) were sent to stakeholders about this error.',
    `patient_mrn` STRING COMMENT 'The Medical Record Number of the patient associated with the failed message, if applicable and extractable from the message content.',
    `raw_message_payload` STRING COMMENT 'The complete raw message content (HL7 pipe-delimited text, FHIR JSON/XML, CDA document) that failed processing, stored for forensic analysis and replay. Contains Protected Health Information (PHI).',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the investigation, root cause findings, corrective actions taken, and resolution approach.',
    `resolution_status` STRING COMMENT 'The current status of error resolution workflow: new (unassigned), assigned (allocated to resolver), in_progress (actively being worked), resolved (fix applied), closed (verified and completed), reopened (recurred after resolution), or cancelled (no action needed). [ENUM-REF-CANDIDATE: new|assigned|in_progress|resolved|closed|reopened|cancelled — 7 candidates stripped; promote to reference product]',
    `resolution_timestamp` TIMESTAMP COMMENT 'The date and time when the error was marked as resolved or closed.',
    `retry_count` STRING COMMENT 'The number of automatic retry attempts made by the interface engine before the error was logged or escalated.',
    `retry_eligible_flag` BOOLEAN COMMENT 'Indicates whether the message is eligible for automatic or manual retry based on error type and business rules.',
    `root_cause_category` STRING COMMENT 'The classified root cause of the error: data_quality (source data issues), configuration (interface setup problems), mapping (transformation logic errors), network (connectivity failures), system_outage (application downtime), third_party (external system issues), user_error (manual process mistakes), or unknown (cause not determined). [ENUM-REF-CANDIDATE: data_quality|configuration|mapping|network|system_outage|third_party|user_error|unknown — 8 candidates stripped; promote to reference product]',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the error resolution exceeded the defined SLA threshold for the interface channel or message type.',
    `sla_target_resolution_minutes` STRING COMMENT 'The target resolution time in minutes defined by the SLA for this error category and severity level.',
    `validation_rule_violated` STRING COMMENT 'The specific business or technical validation rule that was violated, causing the error (e.g., required field missing, invalid code value, referential integrity failure).',
    CONSTRAINT pk_message_error PRIMARY KEY(`message_error_id`)
) COMMENT 'Transactional record of every message processing error, rejection, or exception encountered during interface engine processing. Captures error timestamp, error code, error category (parsing/validation/routing/transformation/delivery), error description, affected message control ID, channel reference, error severity, resolution status, assigned resolver, resolution timestamp, and root cause classification. Enables systematic error management, SLA breach tracking, and interface reliability improvement.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` (
    `fhir_endpoint_id` BIGINT COMMENT 'Unique identifier for the FHIR API endpoint record. Primary key for the FHIR endpoint registry.',
    `data_sharing_agreement_id` BIGINT COMMENT 'Identifier of the legal data sharing agreement or Business Associate Agreement (BAA) governing data exchange through this endpoint. Links to compliance and legal documentation.',
    `org_provider_id` BIGINT COMMENT 'Identifier of the organization responsible for managing and maintaining this FHIR endpoint. Links to the organization master data.',
    `superseded_fhir_endpoint_id` BIGINT COMMENT 'Self-referencing FK on fhir_endpoint (superseded_fhir_endpoint_id)',
    `trading_partner_id` BIGINT COMMENT 'Foreign key linking to interoperability.trading_partner. Business justification: Many FHIR endpoints are partner-specific (payer APIs, HIE endpoints, provider directories). Link to trading_partner enables tracking which partner owns/operates each endpoint, managing partner-specifi',
    `authentication_method` STRING COMMENT 'The authentication and authorization mechanism required to access this FHIR endpoint (e.g., OAuth2, SMART on FHIR, API key, basic authentication, mutual TLS, or none for public endpoints).. Valid values are `oauth2|smart_on_fhir|api_key|basic_auth|mutual_tls|none`',
    `average_response_time_ms` STRING COMMENT 'Average response time in milliseconds for API requests to this endpoint over a defined measurement period. Used for performance monitoring and optimization.',
    `bulk_data_export_support_flag` BOOLEAN COMMENT 'Indicates whether this endpoint supports FHIR Bulk Data Access (Flat FHIR) for large-scale data export operations. True if bulk export is supported, False otherwise.',
    `capability_statement_url` STRING COMMENT 'URL to the FHIR CapabilityStatement resource that describes the functionality and supported operations of this endpoint. Typically accessed via [base_url]/metadata.',
    `cms_compliance_flag` BOOLEAN COMMENT 'Indicates whether this endpoint is compliant with CMS Interoperability and Patient Access Final Rule requirements (21st Century Cures Act). True if compliant, False otherwise.',
    `connection_type` STRING COMMENT 'The protocol or connection type used by this endpoint (e.g., HL7 FHIR REST, HL7 FHIR Messaging, Direct messaging, IHE XDS, HL7 v2, custom integration).. Valid values are `hl7_fhir_rest|hl7_fhir_messaging|direct|ihe_xds|hl7_v2|custom`',
    `contact_email` STRING COMMENT 'Email address of the technical contact for this endpoint. Used for notifications, alerts, and support communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Name of the technical contact person responsible for this endpoint. Used for operational support and issue resolution.',
    `contact_phone` STRING COMMENT 'Phone number of the technical contact for this endpoint. Used for urgent operational issues and escalations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this endpoint record was first created in the system. Used for audit trail and data lineage.',
    `deprecation_date` DATE COMMENT 'Date when this endpoint was marked as deprecated and scheduled for retirement. Used for migration planning and stakeholder communication.',
    `documentation_url` STRING COMMENT 'URL to the technical documentation, developer guide, or API reference for this FHIR endpoint. Used by developers and integration partners.',
    `endpoint_name` STRING COMMENT 'Human-readable name or label for the FHIR endpoint, used for identification and management purposes.',
    `endpoint_type` STRING COMMENT 'Classification of the FHIR endpoint based on its primary use case and audience (e.g., patient-facing SMART on FHIR apps, payer FHIR APIs for CMS Interoperability Rule, provider directory endpoints, internal FHIR server instances, HIE gateways).. Valid values are `patient_facing|payer_api|provider_directory|internal_server|hie_gateway|research_api`',
    `endpoint_url` STRING COMMENT 'The full URL of the FHIR API endpoint, including protocol, domain, and base path. This is the technical address where FHIR requests are sent.',
    `environment` STRING COMMENT 'The deployment environment of this FHIR endpoint (e.g., production, staging, testing, development, sandbox). Used to distinguish live endpoints from test environments.. Valid values are `production|staging|testing|development|sandbox`',
    `fhir_version` STRING COMMENT 'The version of the FHIR specification that this endpoint implements (e.g., R4, STU3, DSTU2, R5).. Valid values are `R4|STU3|DSTU2|R5`',
    `hie_network_name` STRING COMMENT 'Name of the Health Information Exchange network that this endpoint participates in, if applicable. Used for tracking HIE partnerships and data sharing agreements.',
    `hie_participant_flag` BOOLEAN COMMENT 'Indicates whether this endpoint participates in a Health Information Exchange network. True if the endpoint is registered with an HIE, False otherwise.',
    `last_availability_check_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent automated availability or health check performed on this endpoint. Used for monitoring and alerting.',
    `last_availability_status` STRING COMMENT 'Result of the most recent availability check (e.g., available, unavailable, degraded, timeout, error). Used for operational monitoring and incident response.. Valid values are `available|unavailable|degraded|timeout|error`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this endpoint record was last modified. Used for change tracking and audit purposes.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to this FHIR endpoint. Used for operational context and knowledge transfer.',
    `oauth_authorization_url` STRING COMMENT 'The OAuth 2.0 authorization endpoint URL used for user authorization flows when authentication_method is OAuth2 or SMART on FHIR.',
    `oauth_token_url` STRING COMMENT 'The OAuth 2.0 token endpoint URL used for obtaining access tokens when authentication_method is OAuth2 or SMART on FHIR.',
    `onc_certification_flag` BOOLEAN COMMENT 'Indicates whether this endpoint is part of an ONC-certified Health IT Module under the 21st Century Cures Act certification criteria.',
    `operational_status` STRING COMMENT 'Current operational state of the FHIR endpoint. Active indicates the endpoint is live and available for production use. Testing indicates the endpoint is in a test or sandbox environment. Maintenance indicates temporary unavailability. Deprecated indicates the endpoint is scheduled for retirement. Retired indicates the endpoint is no longer available.. Valid values are `active|inactive|testing|maintenance|deprecated|retired`',
    `patient_access_api_flag` BOOLEAN COMMENT 'Indicates whether this endpoint is designated as a Patient Access API under CMS Interoperability Rule requirements. True if it provides patient-facing access to health data, False otherwise.',
    `payer_to_payer_api_flag` BOOLEAN COMMENT 'Indicates whether this endpoint is designated as a Payer-to-Payer API under CMS Interoperability Rule requirements. True if it supports payer-to-payer data exchange, False otherwise.',
    `provider_access_api_flag` BOOLEAN COMMENT 'Indicates whether this endpoint is designated as a Provider Access API under CMS Interoperability Rule requirements. True if it provides provider-to-provider data exchange, False otherwise.',
    `public_endpoint_flag` BOOLEAN COMMENT 'Indicates whether this endpoint is publicly accessible without authentication (e.g., for provider directory lookups). True if public, False if authentication is required.',
    `rate_limit_requests_per_day` STRING COMMENT 'Maximum number of API requests allowed per day for this endpoint. Used for capacity planning and fair use enforcement.',
    `rate_limit_requests_per_minute` STRING COMMENT 'Maximum number of API requests allowed per minute for this endpoint. Used for throttling and capacity management.',
    `registration_date` DATE COMMENT 'Date when this FHIR endpoint was first registered in the organizations endpoint inventory. Used for tracking endpoint lifecycle and governance.',
    `retirement_date` DATE COMMENT 'Date when this endpoint was or will be retired and decommissioned. Used for lifecycle management and historical tracking.',
    `security_certificate_expiry_date` DATE COMMENT 'Expiration date of the SSL/TLS security certificate used by this endpoint. Critical for maintaining secure communications and avoiding service disruptions.',
    `smart_app_launch_support_flag` BOOLEAN COMMENT 'Indicates whether this endpoint supports the SMART App Launch Framework for third-party application integration. True if SMART launch is supported, False otherwise.',
    `supported_resource_types` STRING COMMENT 'Comma-separated list of FHIR resource types supported by this endpoint (e.g., Patient, Observation, Condition, MedicationRequest, Encounter, Coverage, ExplanationOfBenefit). Derived from the CapabilityStatement.',
    `total_requests_last_30_days` BIGINT COMMENT 'Total number of API requests received by this endpoint in the last 30 days. Used for usage analytics and capacity planning.',
    `uptime_percentage` DECIMAL(18,2) COMMENT 'Calculated uptime percentage for this endpoint over a defined measurement period (typically 30 days). Used for Service Level Agreement (SLA) tracking and performance reporting.',
    CONSTRAINT pk_fhir_endpoint PRIMARY KEY(`fhir_endpoint_id`)
) COMMENT 'Master record for every FHIR API endpoint registered and managed by the organization, including patient-facing SMART on FHIR apps, payer FHIR APIs (CMS Interoperability Rule), provider directory endpoints, and internal FHIR server instances. Captures endpoint URL, FHIR version (R4/STU3), capability statement URL, supported resource types, authentication method (OAuth2/SMART/API key), rate limits, CMS compliance flag (21st Century Cures Act), and operational status. SSOT for FHIR API inventory.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` (
    `fhir_resource_log_id` BIGINT COMMENT 'Unique identifier for each FHIR resource operation log entry. Primary key for the FHIR resource log.',
    `demographics_id` BIGINT COMMENT 'The Medical Record Number (MRN) or FHIR Patient resource ID representing the patient whose data is the subject of the API operation. Empty for non-patient-specific operations (e.g., Practitioner lookup). Required for Protected Health Information (PHI) access auditing per HIPAA.',
    `employee_id` BIGINT COMMENT 'Identifier of the end user or practitioner who initiated the FHIR API request through the client application. May be a National Provider Identifier (NPI), employee ID, or patient portal user ID. Critical for HIPAA audit trail and access accountability.',
    `fhir_endpoint_id` BIGINT COMMENT 'Foreign key linking to interoperability.fhir_endpoint. Business justification: FHIR resource operations are executed against specific FHIR endpoints. Linking fhir_resource_log to fhir_endpoint enables tracking which endpoint served each request, monitoring endpoint-specific perf',
    `related_prior_fhir_resource_log_id` BIGINT COMMENT 'Self-referencing FK on fhir_resource_log (related_fhir_resource_log_id)',
    `visit_id` BIGINT COMMENT 'The FHIR Encounter resource ID representing the clinical encounter context in which the API operation occurred. Used to link API access to specific episodes of care for clinical workflow analysis.',
    `access_decision` STRING COMMENT 'The access control decision made by the authorization engine (granted, denied, conditional). Supports security audit and access policy effectiveness analysis.. Valid values are `granted|denied|conditional`',
    `authorization_scope` STRING COMMENT 'The OAuth 2.0 scopes granted to the requesting client for this operation (e.g., patient/*.read, user/Observation.write). Defines the access permissions under which the operation was performed.',
    `conformance_validation_result` STRING COMMENT 'Indicates whether the FHIR resource in the request or response passed conformance validation against the applicable FHIR profile or implementation guide (passed, failed, not_validated). Supports data quality monitoring and interoperability compliance.. Valid values are `passed|failed|not_validated`',
    `consent_policy_applied` STRING COMMENT 'Identifier or reference to the patient consent policy that was evaluated and applied during this operation. Supports consent-based access control and HIPAA minimum necessary compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this log record was created in the data warehouse. Used for data lineage and audit trail purposes.',
    `cures_act_exception_flag` BOOLEAN COMMENT 'Indicates whether this operation involved an exception to the information blocking prohibition under the 21st Century Cures Act (e.g., privacy exception, security exception). True if an exception was invoked, False otherwise.',
    `data_segmentation_applied` BOOLEAN COMMENT 'Indicates whether data segmentation for privacy (DS4P) was applied to filter sensitive data elements from the response based on patient consent or policy. True if segmentation occurred, False otherwise.',
    `denial_reason` STRING COMMENT 'The reason code or message explaining why access was denied or the operation failed. Used for troubleshooting and identifying access control issues.',
    `exception_reason` STRING COMMENT 'The specific exception category or reason code under the 21st Century Cures Act that justified restricting access or blocking information (e.g., privacy, security, infeasibility). Required when cures_act_exception_flag is True.',
    `fhir_profile_url` STRING COMMENT 'The canonical URL of the FHIR profile or implementation guide against which the resource was validated (e.g., US Core, IPS). Identifies the conformance standard applied.',
    `fhir_resource_identifier` STRING COMMENT 'The logical identifier of the specific FHIR resource instance being accessed (e.g., Patient/12345, Observation/67890). Empty for search or create operations that do not target a specific resource instance.',
    `fhir_resource_type` STRING COMMENT 'The type of FHIR resource being accessed or manipulated (e.g., Patient, Observation, Condition, MedicationRequest). Defines the clinical or administrative entity subject to the operation. [ENUM-REF-CANDIDATE: Patient|Observation|Condition|MedicationRequest|Procedure|Encounter|AllergyIntolerance|DiagnosticReport|Immunization|CarePlan|DocumentReference|Practitioner|Organization|Location|Device|Appointment|ServiceRequest|Coverage|Claim|ExplanationOfBenefit|CareTeam|Goal|Medication|Substance|Specimen|Task|Communication|Consent|Provenance|AuditEvent|Bundle — promote to reference product]',
    `fhir_version_code` STRING COMMENT 'The version identifier of the FHIR resource instance accessed via vread or returned in response. Supports resource versioning and history tracking per FHIR specification.',
    `hie_transaction_code` STRING COMMENT 'Correlation identifier linking this FHIR operation to a broader Health Information Exchange (HIE) transaction or query. Used to trace data flows across organizational boundaries.',
    `http_status_code` STRING COMMENT 'The HTTP response status code returned by the FHIR server (e.g., 200 for success, 404 for not found, 401 for unauthorized, 500 for server error). Indicates the outcome of the API operation.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this log record was last modified or updated in the data warehouse. Supports change tracking and data quality monitoring.',
    `operation_outcome` STRING COMMENT 'High-level categorization of the operation result (success, client_error, server_error, not_found, unauthorized, forbidden, validation_error). Derived from HTTP status code for simplified reporting and alerting. [ENUM-REF-CANDIDATE: success|client_error|server_error|not_found|unauthorized|forbidden|validation_error — 7 candidates stripped; promote to reference product]',
    `operation_type` STRING COMMENT 'The RESTful interaction type performed on the FHIR resource (read, vread, update, patch, delete, create, search-type, history-instance, history-type, or custom $operation). Aligns with FHIR RESTful API interaction definitions. [ENUM-REF-CANDIDATE: read|vread|update|patch|delete|create|search-type|history-instance|history-type|operation — 10 candidates stripped; promote to reference product]',
    `request_body_size_bytes` STRING COMMENT 'The size of the HTTP request body payload in bytes. Used for bandwidth monitoring and identifying large resource submissions.',
    `request_method` STRING COMMENT 'The HTTP method used for the FHIR API request (GET, POST, PUT, PATCH, DELETE). Indicates the type of RESTful operation performed.. Valid values are `GET|POST|PUT|PATCH|DELETE`',
    `request_timestamp` TIMESTAMP COMMENT 'The date and time when the FHIR API request was received by the server. Represents the business event time for the operation and is used for audit trail and performance analysis.',
    `request_url` STRING COMMENT 'The full URL path of the FHIR API request, including query parameters for search operations. Captures the exact API endpoint and parameters used for detailed audit and debugging.',
    `requesting_application_code` STRING COMMENT 'Identifier of the client application or system that initiated the FHIR API request (e.g., mobile app, EHR module, third-party application). Used for access tracking and application-level analytics.',
    `requesting_client_code` STRING COMMENT 'OAuth 2.0 client identifier or API key associated with the requesting application. Supports authentication audit and client-level access control.',
    `response_body_size_bytes` STRING COMMENT 'The size of the HTTP response body payload in bytes. Used for bandwidth monitoring and identifying large resource retrievals.',
    `response_time_ms` STRING COMMENT 'The elapsed time in milliseconds between request receipt and response transmission. Key performance indicator for FHIR API latency and service level agreement (SLA) monitoring.',
    `response_timestamp` TIMESTAMP COMMENT 'The date and time when the FHIR API response was sent back to the client. Used to calculate response time and monitor API performance.',
    `search_parameters` STRING COMMENT 'The query string parameters used in FHIR search operations (e.g., _id, _lastUpdated, patient, code). Captured for search pattern analysis and optimization.',
    `search_result_count` STRING COMMENT 'The number of FHIR resources returned in response to a search operation. Used to analyze search effectiveness and identify overly broad queries.',
    `source_ip_address` STRING COMMENT 'The IP address of the client that originated the FHIR API request. Used for security monitoring, access control, and geographic analysis. May be considered personally identifiable information (PII) in some jurisdictions.',
    `user_agent` STRING COMMENT 'The HTTP User-Agent header value identifying the client software, operating system, and device type. Used for client compatibility analysis and troubleshooting.',
    `validation_errors` STRING COMMENT 'Detailed error messages or codes returned by the FHIR validator when conformance validation fails. Used for troubleshooting and data quality improvement.',
    CONSTRAINT pk_fhir_resource_log PRIMARY KEY(`fhir_resource_log_id`)
) COMMENT 'Transactional log of every FHIR resource operation (read, search, create, update, delete, $operation) processed through FHIR API endpoints. Captures FHIR resource type (Patient, Observation, Condition, MedicationRequest, etc.), operation type, request timestamp, response HTTP status, FHIR resource ID, requesting application/client ID, patient context, response time, and conformance validation result. Supports 21st Century Cures Act audit requirements and FHIR API performance monitoring.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` (
    `mapping_rule_id` BIGINT COMMENT 'Unique identifier for the individual transformation rule within a data mapping definition. Primary key for the mapping rule record.',
    `fallback_mapping_rule_id` BIGINT COMMENT 'Self-referencing FK on mapping_rule (fallback_mapping_rule_id)',
    `mapping_definition_id` BIGINT COMMENT 'Reference to the parent mapping definition container that groups related transformation rules. Links this atomic rule to its parent mapping context.',
    `crosswalk_id` BIGINT COMMENT 'Foreign key linking to reference.crosswalk. Business justification: Interface transformation rules reference crosswalk tables for code-to-code mappings. Real-world: mapping rules execute crosswalk lookups during message transformation to translate between code systems',
    `exchange_standard_id` BIGINT COMMENT 'Foreign key linking to interoperability.exchange_standard. Business justification: Mapping rules transform data FROM a source exchange standard. Adding this FK provides authoritative linkage to the standard definition (HL7v2, FHIR, CDA, etc.) and enables validation that the source_e',
    `approved_by` STRING COMMENT 'Identifier of the user or authority who approved this transformation rule for production use. Supports governance and change control processes for interface engine configurations.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this transformation rule was approved for production use. Supports governance and change control processes for interface engine configurations.',
    `condition_expression` STRING COMMENT 'Boolean expression or predicate that determines when this rule should be applied. If empty or null, the rule applies unconditionally. Supports conditional transformation logic.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this transformation rule record was first created in the system. Supports audit trail and change tracking for interface configurations.',
    `data_type_conversion` STRING COMMENT 'Specific instructions or function calls for converting the source data type to the target data type. May include format strings, parsing rules, or precision handling.',
    `default_value` DECIMAL(18,2) COMMENT 'The value to assign to the target field when the source value is missing, null, or does not meet the condition expression. Supports fallback behavior in transformation logic.',
    `effective_end_date` DATE COMMENT 'The date when this transformation rule is no longer active and should not be applied. Nullable for rules with indefinite validity. Supports rule retirement and deprecation.',
    `effective_start_date` DATE COMMENT 'The date when this transformation rule becomes active and should be applied by the interface engine. Supports time-based rule activation for regulatory or business changes.',
    `equivalence_type` STRING COMMENT 'Describes the semantic relationship between the source and target concepts in terminology mapping. Follows HL7 FHIR ConceptMapEquivalence value set for interoperability standards. [ENUM-REF-CANDIDATE: equivalent|equal|wider|subsumes|narrower|specializes|inexact|unmatched|disjoint — 9 candidates stripped; promote to reference product]',
    `error_handling_action` STRING COMMENT 'Defines the action to take when this rule encounters an error during execution. Options: abort (stop processing), log (record error and continue), skip (ignore rule), retry (attempt again), default (use default_value).. Valid values are `abort|log|skip|retry|default`',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this transformation rule must successfully execute for the overall mapping to be considered valid. If true, rule failure causes message rejection or error.',
    `modified_by` STRING COMMENT 'Identifier of the user, system, or interface analyst who last modified this transformation rule. Used for accountability and audit trail in interface engine governance.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this transformation rule record was last modified. Supports audit trail and change tracking for interface configurations.',
    `notes` STRING COMMENT 'Free-text field for additional comments, implementation notes, known issues, or special considerations related to this transformation rule. Supports knowledge transfer and maintenance.',
    `null_handling_strategy` STRING COMMENT 'Defines how the transformation engine should handle null or missing source values. Options: skip (do not write target), default (use default_value), error (raise exception), empty_string (write empty string), preserve_null (write null to target).. Valid values are `skip|default|error|empty_string|preserve_null`',
    `rule_description` STRING COMMENT 'Detailed explanation of the transformation logic, business rationale, and expected behavior of this mapping rule. Documents the purpose and context for future maintenance.',
    `rule_name` STRING COMMENT 'Human-readable name or label for the transformation rule. Used for identification and documentation purposes in interface engine configurations.',
    `rule_priority` STRING COMMENT 'Priority level for rule execution when multiple rules could apply to the same source-target pair. Higher values indicate higher priority. Used for conflict resolution.',
    `rule_sequence` STRING COMMENT 'Ordinal position of this transformation rule within the parent mapping definition. Determines execution order when multiple rules apply to the same source-target pair.',
    `rule_status` STRING COMMENT 'Current lifecycle status of the transformation rule. Determines whether the rule is executed by the interface engine during message processing.. Valid values are `draft|active|inactive|deprecated|testing`',
    `rule_version` STRING COMMENT 'Version identifier for this transformation rule. Supports granular versioning and change tracking of individual rules independent of the parent mapping definition.',
    `source_data_type` STRING COMMENT 'The data type of the source field as defined in the source system schema or message specification. Used for type validation and conversion planning.',
    `source_expression` STRING COMMENT 'The source field path, XPath, JSONPath, or HL7 segment/field reference that identifies the input data element to be transformed. May include extraction logic or functions.',
    `target_code_system` STRING COMMENT 'The terminology or code system used in the target field. Examples: ICD-10, SNOMED CT, LOINC, NDC, CPT. Used for terminology mapping and value set translation.',
    `target_data_type` STRING COMMENT 'The data type of the target field as defined in the target system schema or message specification. Used for type conversion and validation.',
    `target_expression` STRING COMMENT 'The target field path, XPath, JSONPath, or HL7 segment/field reference that identifies where the transformed value should be written. May include assignment logic or functions.',
    `test_case_reference` STRING COMMENT 'Reference to the test case or test suite that validates this transformation rule. Links rule to quality assurance artifacts for regression testing and validation.',
    `transformation_function` STRING COMMENT 'The function, method, or algorithm applied to convert the source value to the target format. May reference built-in interface engine functions, custom scripts, or standard conversion routines.',
    `validation_rule` STRING COMMENT 'Post-transformation validation expression or constraint that the target value must satisfy. Used to ensure data quality and conformance to target system requirements.',
    `created_by` STRING COMMENT 'Identifier of the user, system, or interface analyst who created this transformation rule. Used for accountability and audit trail in interface engine governance.',
    CONSTRAINT pk_mapping_rule PRIMARY KEY(`mapping_rule_id`)
) COMMENT 'Individual transformation rule record within a data mapping definition, representing the atomic unit of field-level or value-level translation logic. Captures rule sequence, source expression, target expression, condition expression, default value, null handling behavior, data type conversion, and test case reference. Enables granular versioning, testing, and governance of transformation logic separate from the parent mapping container.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` (
    `hie_participation_id` BIGINT COMMENT 'Unique identifier for the HIE participation record. Primary key for the HIE participation entity.',
    `business_associate_agreement_id` BIGINT COMMENT 'Reference to the Business Associate Agreement governing the HIE relationship, if the HIE is acting as a business associate.',
    `care_site_id` BIGINT COMMENT 'Reference to the specific facility participating in the HIE, if participation is facility-level rather than organization-wide.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who last updated this HIE participation record.',
    `financial_entity_id` BIGINT COMMENT 'Reference to the healthcare organization participating in the HIE. Links to the organization master data.',
    `hie_organization_id` BIGINT COMMENT 'Unique identifier assigned by the HIE network to this participating organization. Used for routing and identification within the HIE.',
    `interface_engine_id` BIGINT COMMENT 'Foreign key linking to interoperability.interface_engine. Business justification: HIE participation uses specific interface engine endpoints for connectivity. Currently interface_engine_endpoint (STRING) exists. FK to interface_engine enables tracking which engine instance handles ',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: HIE participation tracks which provider organizations participate in health information exchanges. Care_site_id exists but doesnt identify the legal NPI holder. Credentialing, regulatory reporting, a',
    `renewed_hie_participation_id` BIGINT COMMENT 'Self-referencing FK on hie_participation (renewed_hie_participation_id)',
    `annual_participation_fee` DECIMAL(18,2) COMMENT 'Annual fee charged by the HIE network for participation, if applicable.',
    `compliance_attestation_date` DATE COMMENT 'Date when the organization attested to compliance with HIE policies, HIPAA requirements, and technical standards.',
    `compliance_attestation_expiration_date` DATE COMMENT 'Date when the current compliance attestation expires and must be renewed.',
    `contribution_volume_monthly_avg` STRING COMMENT 'Average number of clinical documents or messages contributed to the HIE per month by this organization.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this HIE participation record was first created in the system.',
    `data_sharing_scope` STRING COMMENT 'Description of the types of clinical data shared through the HIE (e.g., ADT, lab results, radiology reports, medication history, immunizations, clinical summaries).',
    `data_use_agreement_expiration_date` DATE COMMENT 'Date when the current Data Use Agreement expires and must be renewed.',
    `data_use_agreement_signed_date` DATE COMMENT 'Date when the organization signed the Data Use Agreement or Participation Agreement with the HIE.',
    `go_live_date` DATE COMMENT 'Date when the organization began actively exchanging data through the HIE network in production.',
    `hie_network_name` STRING COMMENT 'Official name of the HIE network (e.g., CommonWell Health Alliance, Carequality, eHealth Exchange, state-specific HIE name).',
    `hie_network_type` STRING COMMENT 'Classification of the HIE network by geographic or organizational scope: state HIE, regional HIE, national network, private exchange, or vendor-specific network.. Valid values are `state|regional|national|private|vendor`',
    `interface_engine_endpoint` STRING COMMENT 'Technical endpoint URL or address configured in the interface engine for HIE connectivity (e.g., FHIR base URL, Direct address, HL7 MLLP endpoint).',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance or security audit conducted by the HIE network.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next compliance or security audit by the HIE network.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the HIE participation, including special configurations, exceptions, or historical context.',
    `npi` STRING COMMENT 'National Provider Identifier for the organization participating in the HIE, used for provider directory and routing purposes.. Valid values are `^[0-9]{10}$`',
    `onboarding_date` DATE COMMENT 'Date when the organization formally joined the HIE network and completed technical onboarding.',
    `participation_status` STRING COMMENT 'Current status of the organizations participation in the HIE network: active (exchanging data), inactive (not exchanging), suspended (temporarily halted), pending onboarding (in setup), or terminated (ended).. Valid values are `active|inactive|suspended|pending_onboarding|terminated`',
    `participation_tier` STRING COMMENT 'Level of participation in the HIE: query-only (read access), contribute-only (write access), query-and-contribute (bidirectional), or full bidirectional with advanced services.. Valid values are `query_only|contribute_only|query_and_contribute|full_bidirectional`',
    `patient_consent_model` STRING COMMENT 'Consent framework governing patient data sharing: opt-in (explicit consent required), opt-out (default sharing unless patient objects), no consent required (permitted by law), or emergency-only access.. Valid values are `opt_in|opt_out|no_consent_required|emergency_only`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary organizational contact for HIE participation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary organizational contact responsible for HIE participation and coordination.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary organizational contact for HIE participation.',
    `query_volume_monthly_avg` STRING COMMENT 'Average number of queries sent to the HIE per month by this organization.',
    `supported_standards` STRING COMMENT 'List of interoperability standards supported for this HIE participation (e.g., HL7 v2.5.1, FHIR R4, CDA R2, Direct 1.1, IHE XDS).',
    `suspension_reason` STRING COMMENT 'Reason for suspension or termination of HIE participation (e.g., compliance violation, technical issues, voluntary withdrawal, contract expiration).',
    `technical_connection_type` STRING COMMENT 'Technical method used to connect to the HIE: Direct Messaging (SMTP/S-MIME), FHIR API, HL7v2 interface, CDA document exchange, or proprietary protocol.. Valid values are `direct_messaging|fhir_api|hl7v2_interface|cda_exchange|proprietary`',
    `technical_contact_email` STRING COMMENT 'Email address of the technical contact for HIE interface support.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `technical_contact_name` STRING COMMENT 'Name of the technical contact responsible for interface configuration and troubleshooting.',
    `technical_contact_phone` STRING COMMENT 'Phone number of the technical contact for HIE interface support.',
    `termination_date` DATE COMMENT 'Date when the organization formally ended participation in the HIE network.',
    `transaction_fee_model` STRING COMMENT 'Pricing model for HIE transactions: flat rate, per-transaction fee, tiered pricing based on volume, or no fee.. Valid values are `flat_rate|per_transaction|tiered|no_fee`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this HIE participation record was last updated in the system.',
    CONSTRAINT pk_hie_participation PRIMARY KEY(`hie_participation_id`)
) COMMENT 'Master record documenting the healthcare organizations formal participation in Health Information Exchanges (HIEs), including state HIEs, regional HIEs (CommonWell, Carequality, eHealth Exchange), and national networks. Captures HIE name, network type, participation tier (query/contribute/both), onboarding date, data sharing scope, patient consent model (opt-in/opt-out), technical connection type, compliance attestation date, and participation status. SSOT for HIE network membership.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` (
    `hie_query_id` BIGINT COMMENT 'Unique identifier for each HIE query transaction. Primary key for the HIE query record.',
    `clinician_id` BIGINT COMMENT 'Identifier of the healthcare provider who requested the HIE query.',
    `consent_policy_id` BIGINT COMMENT 'Identifier of the consent policy applied to this HIE query for patient privacy enforcement.',
    `demographics_id` BIGINT COMMENT 'Internal identifier of the patient for whom the HIE query was performed.',
    `follow_up_hie_query_id` BIGINT COMMENT 'Self-referencing FK on hie_query (follow_up_hie_query_id)',
    `hie_organization_id` BIGINT COMMENT 'Foreign key linking to interoperability.hie_organization. Business justification: HIE queries are submitted to or received from specific HIE organizations. Currently only hie_network_name (STRING) exists. Adding FK to hie_organization enables proper referential integrity, tracking ',
    `hie_participation_id` BIGINT COMMENT 'Foreign key linking to interoperability.hie_participation. Business justification: HIE queries are executed within the context of a specific HIE participation agreement. Currently hie_query has hie_network_name (STRING) and care_site_id, but no direct link to the participation recor',
    `interface_engine_id` BIGINT COMMENT 'Identifier of the interface engine that processed and routed the HIE query.',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility that initiated the HIE query request.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter during which the HIE query was performed.',
    `audit_logged` BOOLEAN COMMENT 'Indicates whether the HIE query transaction was logged in the audit trail for compliance and security monitoring.',
    `clinical_purpose_code` STRING COMMENT 'Code indicating the clinical purpose for which the HIE query was performed, used for consent enforcement and audit logging.. Valid values are `treatment|payment|operations|research|public_health|emergency`',
    `consent_verified` BOOLEAN COMMENT 'Indicates whether patient consent was verified before the HIE query was executed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the HIE query record was created in the data warehouse.',
    `data_sensitivity_level` STRING COMMENT 'Sensitivity classification of the data requested or returned in the HIE query.. Valid values are `normal|restricted|confidential|highly_confidential`',
    `documents_returned_count` STRING COMMENT 'Number of clinical documents returned by the responding facility in response to the HIE query.',
    `error_code` STRING COMMENT 'Error code returned by the HIE network if the query failed or encountered issues.',
    `error_message` STRING COMMENT 'Detailed error message describing the reason for query failure or issues encountered.',
    `hie_transaction_code` STRING COMMENT 'Unique transaction identifier assigned by the HIE network for tracking and audit purposes.',
    `initiating_facility_npi` STRING COMMENT 'National Provider Identifier of the facility that initiated the query.. Valid values are `^[0-9]{10}$`',
    `match_algorithm` STRING COMMENT 'Name or identifier of the patient matching algorithm used by the HIE to determine patient identity.',
    `match_confidence_score` DECIMAL(18,2) COMMENT 'Confidence score (0-100) indicating the likelihood that the patient demographics matched the correct patient record in the responding system.',
    `notes` STRING COMMENT 'Additional notes or comments related to the HIE query transaction for operational or audit purposes.',
    `patient_date_of_birth` DATE COMMENT 'Date of birth of the patient used in the HIE query for demographic matching.',
    `patient_first_name` STRING COMMENT 'First name of the patient submitted in the HIE query for demographic matching.',
    `patient_gender` STRING COMMENT 'Gender of the patient submitted in the HIE query for demographic matching.. Valid values are `male|female|other|unknown`',
    `patient_last_name` STRING COMMENT 'Last name of the patient submitted in the HIE query for demographic matching.',
    `patient_mrn` STRING COMMENT 'Medical Record Number of the patient used in the HIE query for patient matching.',
    `patient_ssn_last_four` STRING COMMENT 'Last four digits of the patient Social Security Number used for matching in the HIE query.. Valid values are `^[0-9]{4}$`',
    `patient_zip_code` STRING COMMENT 'ZIP code of the patient address used in the HIE query for demographic matching.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `query_message_control_number` STRING COMMENT 'Unique message identifier for the query request as defined by the messaging protocol.',
    `query_priority` STRING COMMENT 'Priority level assigned to the HIE query indicating urgency of the information request.. Valid values are `routine|urgent|stat|emergency`',
    `query_protocol` STRING COMMENT 'Interoperability protocol used to submit and receive the HIE query.. Valid values are `hl7v2|fhir|cda|ihe_xds|direct`',
    `query_response_time_seconds` DECIMAL(18,2) COMMENT 'Time in seconds taken for the HIE network to return a response to the query request.',
    `query_source_system` STRING COMMENT 'Name or identifier of the source system (EMR/EHR) from which the HIE query was initiated.',
    `query_status` STRING COMMENT 'Current processing status of the HIE query transaction.. Valid values are `submitted|in_progress|completed|failed|timeout|cancelled`',
    `query_timestamp` TIMESTAMP COMMENT 'Date and time when the HIE query was submitted to the health information exchange network.',
    `query_type` STRING COMMENT 'Type of query submitted to the HIE network. [ENUM-REF-CANDIDATE: patient_discovery|document_query|document_retrieve|patient_demographics_query|clinical_data_query|medication_history_query|immunization_query|lab_results_query|radiology_query|care_summary_query — promote to reference product]. Valid values are `patient_discovery|document_query|document_retrieve|patient_demographics_query|clinical_data_query|medication_history_query`',
    `requesting_provider_npi` STRING COMMENT 'National Provider Identifier of the provider who requested the HIE query.. Valid values are `^[0-9]{10}$`',
    `responding_facility_npi` STRING COMMENT 'National Provider Identifier of the facility that responded to the query.. Valid values are `^[0-9]{10}$`',
    `response_timestamp` TIMESTAMP COMMENT 'Date and time when the HIE query response was received from the responding facility.',
    `retry_count` STRING COMMENT 'Number of times the HIE query was retried due to failures or timeouts.',
    CONSTRAINT pk_hie_query PRIMARY KEY(`hie_query_id`)
) COMMENT 'Transactional record of every patient record query submitted to or received from an HIE network. Captures query timestamp, query type (patient discovery/document query/document retrieve), initiating facility, responding facility, patient demographics used for matching, match confidence score, number of documents returned, query response time, query status, and clinical purpose code. Supports care coordination analytics, HIE utilization reporting, and patient consent enforcement.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` (
    `cda_document_id` BIGINT COMMENT 'Unique identifier for the CDA document record in the interoperability layer. Primary key.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: CDA documents require linking to authoring clinician for credentialing privileging reviews, peer review case attribution, and Promoting Interoperability attestation. Author_provider_npi exists but lac',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan. Business justification: Care plans are transmitted in C-CDA Care Plan documents for care coordination. Linking cda_document to care_plan enables tracking which care plans were shared with external providers, supports care co',
    `consent_reference_id` BIGINT COMMENT 'Identifier of the patient consent record authorizing the exchange of this CDA document.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: CDA documents have custodian organization (legal entity responsible for the document). Custodian_organization_name exists but lacks FK. Healthcare compliance, legal health record management, and breac',
    `demographics_id` BIGINT COMMENT 'Internal system identifier for the patient who is the subject of this CDA document.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_diagnosis. Business justification: C-CDA documents contain diagnosis sections (Problem List, Encounter Diagnoses). Linking cda_document to clinical_diagnosis enables reconciliation of which specific diagnoses were transmitted in care t',
    `financial_entity_id` BIGINT COMMENT 'Identifier of the organization responsible for maintaining and safeguarding the CDA document.',
    `interface_channel_id` BIGINT COMMENT 'Identifier of the interface engine channel or route through which this CDA document was transmitted or received.',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility or organization that authored or generated this CDA document.',
    `problem_id` BIGINT COMMENT 'Foreign key linking to clinical.problem. Business justification: Problem lists are core C-CDA content (Problem List section required in many document types). Linking cda_document to problem enables tracking which problems were transmitted in care transitions, suppo',
    `superseded_cda_document_id` BIGINT COMMENT 'Self-referencing FK on cda_document (superseded_cda_document_id)',
    `trading_partner_id` BIGINT COMMENT 'Foreign key linking to interoperability.trading_partner. Business justification: CDA documents are exchanged with trading partners (sent to or received from). Currently only destination_system_code and destination_system_name exist as strings. FK to trading_partner enables proper ',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter or visit associated with this CDA document, if applicable.',
    `acknowledgment_status` STRING COMMENT 'Status of the acknowledgment received from the destination system for outbound CDA document transmissions.. Valid values are `acknowledged|rejected|pending|not_required`',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Date and time when acknowledgment was received from the destination system.',
    `cda_version` STRING COMMENT 'Version of the CDA standard used for this document (e.g., CDA R2, C-CDA R1.1, C-CDA R2.1, C-CDA R3.0).',
    `confidentiality_code` STRING COMMENT 'HL7 confidentiality code indicating the privacy level of the document (e.g., N=Normal, R=Restricted, V=Very Restricted).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this CDA document record was first created in the interoperability system.',
    `document_creation_timestamp` TIMESTAMP COMMENT 'Date and time when the CDA document was originally created or authored, as recorded in the CDA effectiveTime element.',
    `document_hash` STRING COMMENT 'Cryptographic hash (e.g., SHA-256) of the CDA document content for integrity verification and tamper detection.',
    `document_size_bytes` BIGINT COMMENT 'Size of the CDA document file in bytes.',
    `document_status` STRING COMMENT 'Current lifecycle status of the CDA document indicating its completeness and validity for clinical use.. Valid values are `draft|final|amended|deprecated|entered_in_error`',
    `document_title` STRING COMMENT 'Human-readable title of the CDA document as specified in the title element.',
    `document_type_code` STRING COMMENT 'LOINC code representing the type of clinical document (e.g., 34133-9 for Summarization of Episode Note, 11488-4 for Consultation Note, 18842-5 for Discharge Summary).',
    `document_type_name` STRING COMMENT 'Human-readable name of the CDA document type (e.g., Continuity of Care Document (CCD), Consolidated CDA (C-CDA), Quality Reporting Document Architecture (QRDA) Category I, QRDA Category III, Referral Note, Discharge Summary, Progress Note, Operative Note).',
    `document_unique_identifier` STRING COMMENT 'Globally unique identifier for the CDA document, typically an Object Identifier (OID) conforming to ISO/IEC 8824 standard. This is the CDA documents id element value.',
    `document_version_number` STRING COMMENT 'Sequential version number of this CDA document within its document set. Increments with each amendment or update.',
    `exchange_direction` STRING COMMENT 'Direction of document exchange relative to the organization: inbound (received from external source) or outbound (sent to external recipient).. Valid values are `inbound|outbound`',
    `hipaa_compliant_flag` BOOLEAN COMMENT 'Indicates whether the CDA document exchange complies with HIPAA Privacy and Security Rules.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the primary language of the CDA document content (e.g., en, es, fr).',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this CDA document record was last modified in the interoperability system.',
    `notes` STRING COMMENT 'Free-text notes or comments about the CDA document exchange, validation issues, or special handling instructions.',
    `patient_mrn` STRING COMMENT 'Medical Record Number of the patient who is the subject of this CDA document. Links to the patient master index.',
    `purpose_of_use_code` STRING COMMENT 'HL7 PurposeOfUse code indicating the reason for document exchange (e.g., TREATMENT, PAYMENT, OPERATIONS, RESEARCH).',
    `receipt_timestamp` TIMESTAMP COMMENT 'Date and time when the CDA document was received by the destination system for inbound exchanges.',
    `service_end_date` DATE COMMENT 'End date of the clinical service period documented in this CDA document.',
    `service_start_date` DATE COMMENT 'Start date of the clinical service period documented in this CDA document.',
    `source_system_code` STRING COMMENT 'Code identifying the source system or Electronic Health Record (EHR) that generated or transmitted this CDA document (e.g., EPIC, CERNER, MEDITECH).',
    `source_system_name` STRING COMMENT 'Name of the source system or EHR that generated this CDA document.',
    `storage_location_uri` STRING COMMENT 'Uniform Resource Identifier or file path indicating where the CDA document XML file is stored in the document repository or object storage system.',
    `transmission_timestamp` TIMESTAMP COMMENT 'Date and time when the CDA document was transmitted through the interface engine or HIE.',
    `validation_error_count` STRING COMMENT 'Number of validation errors identified during CDA schema and implementation guide validation.',
    `validation_status` STRING COMMENT 'Result of CDA schema and implementation guide validation performed on the document.. Valid values are `passed|failed|not_validated|warning`',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when CDA document validation was performed.',
    `validation_warning_count` STRING COMMENT 'Number of validation warnings identified during CDA document validation.',
    CONSTRAINT pk_cda_document PRIMARY KEY(`cda_document_id`)
) COMMENT 'Master record for every CDA (Clinical Document Architecture) document generated, received, or exchanged through the interoperability layer. Captures document type (CCD, C-CDA, QRDA I/III, Referral Note, Discharge Summary), document unique ID (OID), document creation timestamp, author facility, patient reference, CDA version, document status (draft/final/amended/deprecated), exchange direction (inbound/outbound), source system, and storage reference. SSOT for CDA document inventory.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` (
    `cda_validation_result_id` BIGINT COMMENT 'Unique identifier for the CDA validation result record. Primary key.',
    `cda_document_id` BIGINT COMMENT 'Unique identifier of the CDA document that was validated. References the source document in the document repository.',
    `revalidated_cda_validation_result_id` BIGINT COMMENT 'Self-referencing FK on cda_validation_result (revalidated_cda_validation_result_id)',
    `trading_partner_id` BIGINT COMMENT 'Identifier of the trading partner or external organization that submitted or will receive the validated document.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter associated with the CDA document being validated.',
    `certification_requirement_met` BOOLEAN COMMENT 'Indicates whether the validation results demonstrate that certification requirements (e.g., ONC Health IT Certification) are met.',
    `conformance_profile` STRING COMMENT 'The CDA conformance profile or implementation guide tested during validation (e.g., C-CDA 2.1, QRDA Category I, QRDA Category III).. Valid values are `c_cda_2_1|c_cda_1_1|qrda_i|qrda_iii|care_plan|consultation_note_2_1`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this validation result record was first created in the system.',
    `critical_error_list` STRING COMMENT 'Comma-separated or structured list of critical error codes that must be resolved before document can be accepted.',
    `destination_system` STRING COMMENT 'Name of the destination system or Health Information Exchange (HIE) that will receive the validated document.',
    `document_author_npi` STRING COMMENT 'National Provider Identifier of the clinician or provider who authored the CDA document.. Valid values are `^[0-9]{10}$`',
    `document_size_kb` DECIMAL(18,2) COMMENT 'Size of the CDA document in kilobytes. Used for performance analysis and capacity planning.',
    `document_type` STRING COMMENT 'Type of CDA document validated (e.g., Continuity of Care Document, Discharge Summary, Progress Note). [ENUM-REF-CANDIDATE: continuity_of_care|discharge_summary|progress_note|consultation_note|operative_note|history_and_physical|referral_note — 7 candidates stripped; promote to reference product]',
    `finding_details` STRING COMMENT 'Structured or semi-structured text containing detailed validation findings including error codes, line numbers, XPath locations, and remediation guidance.',
    `hie_network_name` STRING COMMENT 'Name of the Health Information Exchange network through which the document will be exchanged.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this validation result record was last modified.',
    `notes` STRING COMMENT 'Free-text notes or comments about the validation results, remediation actions, or special circumstances.',
    `patient_mrn` STRING COMMENT 'Medical Record Number of the patient whose clinical information is contained in the validated CDA document.',
    `regulatory_submission_type` STRING COMMENT 'Type of regulatory submission this validation supports (e.g., Meaningful Use, MIPS, HEDIS, CMS Quality Reporting).',
    `remediation_assigned_to` STRING COMMENT 'Username or identifier of the user or team assigned to remediate validation errors.',
    `remediation_completed_timestamp` TIMESTAMP COMMENT 'Date and time when document remediation was completed and the document was re-validated successfully.',
    `remediation_required_flag` BOOLEAN COMMENT 'Indicates whether document remediation is required before the document can be accepted or submitted.',
    `retry_count` STRING COMMENT 'Number of times the document has been re-validated after remediation attempts.',
    `schema_validation_passed` BOOLEAN COMMENT 'Indicates whether the document passed XML schema validation against the CDA schema definition.',
    `schematron_validation_passed` BOOLEAN COMMENT 'Indicates whether the document passed Schematron rule-based validation for conformance profile requirements.',
    `structural_validation_passed` BOOLEAN COMMENT 'Indicates whether the document passed structural validation for required sections, entries, and document hierarchy.',
    `submission_readiness_flag` BOOLEAN COMMENT 'Indicates whether the document is ready for regulatory submission or external exchange based on validation results.',
    `total_error_count` STRING COMMENT 'Total number of errors identified during validation. Errors represent critical conformance failures that prevent document acceptance.',
    `total_informational_count` STRING COMMENT 'Total number of informational findings identified during validation. Informational findings provide guidance for document quality improvement.',
    `total_warning_count` STRING COMMENT 'Total number of warnings identified during validation. Warnings represent non-critical issues that should be reviewed but do not prevent document acceptance.',
    `validation_execution_time_ms` STRING COMMENT 'Time taken to complete the validation process measured in milliseconds. Used for performance monitoring.',
    `validation_initiated_by` STRING COMMENT 'Username or identifier of the user or system process that initiated the validation.',
    `validation_purpose` STRING COMMENT 'Business purpose for performing the validation (e.g., trading partner onboarding, regulatory submission readiness, quality assurance).. Valid values are `trading_partner_onboarding|regulatory_submission|quality_assurance|pre_exchange_check|post_exchange_audit`',
    `validation_status` STRING COMMENT 'Overall pass/fail status of the validation. Indicates whether the document meets conformance requirements.. Valid values are `pass|fail|warning|error`',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the CDA document validation was performed. Primary business event timestamp for this transaction.',
    `validator_tool_name` STRING COMMENT 'Name of the validation tool or engine used to perform the conformance check (e.g., NIST CDA Validator, Schematron Validator, C-CDA Validator).',
    `validator_tool_version` STRING COMMENT 'Version number of the validation tool used to ensure traceability of validation logic.',
    `vocabulary_validation_passed` BOOLEAN COMMENT 'Indicates whether the document passed vocabulary validation for coded elements (SNOMED CT, LOINC, RxNorm, ICD-10).',
    CONSTRAINT pk_cda_validation_result PRIMARY KEY(`cda_validation_result_id`)
) COMMENT 'Transactional record of CDA document conformance validation results produced by schematron validators and C-CDA validators. Captures validation timestamp, document reference, validator tool used, conformance profile tested (C-CDA 2.1, QRDA I, etc.), total errors, total warnings, total informational findings, overall pass/fail status, and structured finding details. Supports document quality assurance, trading partner onboarding, and regulatory submission readiness.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` (
    `patient_identity_match_id` BIGINT COMMENT 'Unique identifier for the patient identity matching event. Primary key for this transactional record.',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility or organization from which the match request originated.',
    `employee_id` BIGINT COMMENT 'User ID of the clinician or staff member who initiated the match request from the source system.',
    `hie_organization_id` BIGINT COMMENT 'Foreign key linking to interoperability.hie_organization. Business justification: Patient identity matching events occur when querying HIE networks. Link to hie_organization provides organizational context for match requests, enables tracking match accuracy by HIE network, and supp',
    `mpi_record_id` BIGINT COMMENT 'The Enterprise Master Patient Index identifier from the EMPI system that was matched. May differ from local MPI ID in multi-system environments.',
    `source_mpi_record_id` BIGINT COMMENT 'The enterprise Master Patient Index identifier that was matched to the submitted patient identifiers. Represents the golden record in the MPI.',
    `superseded_patient_identity_match_id` BIGINT COMMENT 'Self-referencing FK on patient_identity_match (superseded_patient_identity_match_id)',
    `candidate_count` STRING COMMENT 'Number of candidate patient records identified during the matching process before final match determination.',
    `consent_override_flag` BOOLEAN COMMENT 'Indicates whether patient consent restrictions were overridden for this match request due to emergency or break-the-glass access (True=override applied, False=normal consent rules applied).',
    `consent_override_reason` STRING COMMENT 'Reason documented for overriding patient consent restrictions during the match request (e.g., emergency treatment, break-the-glass).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this patient identity match record was first created in the system. Used for audit trail and data lineage.',
    `duplicate_record_flag` BOOLEAN COMMENT 'Indicates whether the match process identified a potential duplicate patient record that should be investigated for merging (True=duplicate detected, False=no duplicate).',
    `error_code` STRING COMMENT 'Error code returned if the match process encountered an error or exception. Empty if match completed successfully.',
    `error_message` STRING COMMENT 'Detailed error message describing any errors encountered during the match process.',
    `hie_transaction_code` STRING COMMENT 'Unique transaction identifier from the Health Information Exchange network, used to correlate this match event with HIE query logs.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this patient identity match record was last modified. Used for audit trail and change tracking.',
    `manual_review_assigned_to` STRING COMMENT 'User ID or name of the HIM staff member assigned to manually review this match result.',
    `manual_review_completed_timestamp` TIMESTAMP COMMENT 'Date and time when manual review of the match result was completed.',
    `manual_review_notes` STRING COMMENT 'Free-text notes entered by the reviewer documenting the rationale for the manual review decision.',
    `manual_review_outcome` STRING COMMENT 'Outcome of the manual review process (CONFIRMED=match confirmed, REJECTED=match rejected, MERGED=records merged, NEW_RECORD_CREATED=new MPI record created).. Valid values are `CONFIRMED|REJECTED|MERGED|NEW_RECORD_CREATED`',
    `manual_review_required_flag` BOOLEAN COMMENT 'Indicates whether the match result requires manual review by HIM staff due to ambiguous or low-confidence matching (True=manual review required, False=automated match accepted).',
    `match_algorithm_code` STRING COMMENT 'Code identifying the specific matching algorithm or rule set used to perform the patient identity match (e.g., deterministic, probabilistic, hybrid).',
    `match_algorithm_version` STRING COMMENT 'Version number of the matching algorithm used, enabling traceability and audit of algorithm changes over time.',
    `match_confidence_level` STRING COMMENT 'Categorical confidence level of the match result based on match score thresholds (HIGH=score above high threshold, MEDIUM=score in middle range, LOW=score below medium threshold).. Valid values are `HIGH|MEDIUM|LOW`',
    `match_method` STRING COMMENT 'Method used to perform the patient identity match (DETERMINISTIC=exact match on key identifiers, PROBABILISTIC=statistical matching, HYBRID=combination, MANUAL=human review).. Valid values are `DETERMINISTIC|PROBABILISTIC|HYBRID|MANUAL`',
    `match_processing_time_ms` STRING COMMENT 'Time taken to process the identity match request, measured in milliseconds. Used for performance monitoring and SLA tracking.',
    `match_request_timestamp` TIMESTAMP COMMENT 'The date and time when the patient identity match request was initiated during cross-organizational data exchange. Represents the principal business event time for this transaction.',
    `match_result_status` STRING COMMENT 'Outcome of the patient identity matching process (MATCH=definitive match found, POSSIBLE_MATCH=potential match requiring review, NO_MATCH=no match found, MULTIPLE_MATCH=multiple candidates found, ERROR=matching process failed).. Valid values are `MATCH|POSSIBLE_MATCH|NO_MATCH|MULTIPLE_MATCH|ERROR`',
    `match_score` DECIMAL(18,2) COMMENT 'Numerical score representing the confidence level of the patient identity match, typically expressed as a percentage or weighted score. Higher scores indicate stronger matches.',
    `matched_date_of_birth` DATE COMMENT 'Date of birth from the matched MPI record, used to validate the match quality.',
    `matched_patient_first_name` STRING COMMENT 'First name of the patient from the matched MPI record, returned as part of the match result.',
    `matched_patient_last_name` STRING COMMENT 'Last name of the patient from the matched MPI record, returned as part of the match result.',
    `requesting_user_npi` STRING COMMENT 'National Provider Identifier of the healthcare provider who initiated the match request, if applicable.',
    `source_system_code` BIGINT COMMENT 'Identifier of the source system or application that initiated the patient identity match request.',
    `source_system_name` STRING COMMENT 'Name of the source system or application that initiated the match request (e.g., Epic EHR, Cerner Millennium, HIE portal).',
    `submitted_address_line_1` STRING COMMENT 'First line of the patient address submitted in the match request.',
    `submitted_city` STRING COMMENT 'City of the patient address submitted in the match request.',
    `submitted_date_of_birth` DATE COMMENT 'Date of birth of the patient submitted in the match request, used as a key demographic matching attribute.',
    `submitted_gender` STRING COMMENT 'Gender of the patient submitted in the match request (M=Male, F=Female, U=Unknown, O=Other).. Valid values are `M|F|U|O`',
    `submitted_mrn` STRING COMMENT 'The Medical Record Number submitted as part of the match request from the source system. May be facility-specific.',
    `submitted_patient_first_name` STRING COMMENT 'First name of the patient submitted in the match request for identity matching purposes.',
    `submitted_patient_last_name` STRING COMMENT 'Last name of the patient submitted in the match request for identity matching purposes.',
    `submitted_phone_number` STRING COMMENT 'Phone number of the patient submitted in the match request.',
    `submitted_postal_code` STRING COMMENT 'Postal code of the patient address submitted in the match request.',
    `submitted_ssn` STRING COMMENT 'Social Security Number submitted in the match request, if available. Used as a strong identifier for matching.',
    `submitted_state` STRING COMMENT 'State or province of the patient address submitted in the match request.',
    `transaction_type` STRING COMMENT 'Type of interoperability transaction that triggered the identity match (PIX Query, PDQ Query, MPI Lookup, EMPI Match, FHIR Patient Match, HL7 ADT).. Valid values are `PIX_QUERY|PDQ_QUERY|MPI_LOOKUP|EMPI_MATCH|FHIR_PATIENT_MATCH|HL7_ADT`',
    CONSTRAINT pk_patient_identity_match PRIMARY KEY(`patient_identity_match_id`)
) COMMENT 'Transactional record of patient identity matching events performed during cross-organizational data exchange, including MPI (Master Patient Index) lookups, EMPI matching, and IHE PIX/PDQ transactions. Captures match request timestamp, source system, match algorithm used, candidate patient identifiers submitted, match score, match result (match/possible match/no match), matched MPI record reference, and manual review flag. Critical for preventing patient data mismatches during HIE queries and care transitions.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` (
    `direct_message_id` BIGINT COMMENT 'Unique identifier for the Direct Secure Messaging transaction. Primary key for the direct_message product.',
    `interface_engine_id` BIGINT COMMENT 'Identifier of the interface engine or Direct messaging gateway that processed and transmitted the message. Links to the interface_engine product for system tracking.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Direct Secure Messaging transmits patient PHI (referrals, care summaries, lab results). Audit trails and breach investigations require authoritative patient linkage. Meaningful Use attestation require',
    `replied_to_direct_message_id` BIGINT COMMENT 'Self-referencing FK on direct_message (replied_to_direct_message_id)',
    `direct_address_id` BIGINT COMMENT 'Foreign key linking to interoperability.direct_address. Business justification: Direct messages are sent FROM managed Direct addresses. Currently sender_direct_address is a STRING column. Adding sender_direct_address_id FK links the message to the managed address record in direct',
    `trading_partner_id` BIGINT COMMENT 'Identifier of the trading partner (external organization) involved in the Direct message exchange. Links to the trading_partner product for relationship management.',
    `visit_id` BIGINT COMMENT 'Identifier of the clinical encounter associated with the Direct message content, linking the message to a specific episode of care.',
    `acknowledgment_code` STRING COMMENT 'SMTP or application-level acknowledgment code returned by the recipient system confirming message receipt and processing status.',
    `attachment_count` STRING COMMENT 'Number of file attachments included with the Direct message (e.g., CDA documents, PDF reports, DICOM images). Zero indicates message body only.',
    `attachment_types` STRING COMMENT 'Comma-separated list of MIME types for all attachments included in the Direct message (e.g., application/xml, application/pdf, image/jpeg).',
    `certificate_validation_result` STRING COMMENT 'Result of the digital certificate validation process for both sender and recipient certificates, ensuring trust and authenticity of the Direct message exchange.. Valid values are `valid|expired|revoked|untrusted|validation_failed|not_checked`',
    `clinical_document_reference` STRING COMMENT 'Reference identifier or pointer to the associated clinical document (CDA, FHIR document, or other format) that was transmitted within or attached to the Direct message.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this Direct message record was first created in the system. Represents the audit trail creation time, distinct from the send_timestamp.',
    `delivery_status` STRING COMMENT 'Current delivery status of the Direct message indicating whether it was successfully delivered, failed, bounced, or is pending delivery confirmation.. Valid values are `sent|delivered|failed|bounced|pending|rejected`',
    `delivery_timestamp` TIMESTAMP COMMENT 'The date and time when the Direct message was successfully delivered to the recipient system, or when a delivery failure was confirmed. Null if delivery is still pending.',
    `encryption_algorithm` STRING COMMENT 'The cryptographic algorithm used to encrypt the Direct message (e.g., AES-256, 3DES). Supports security audit and compliance verification.',
    `encryption_status` STRING COMMENT 'Indicates whether the Direct message was successfully encrypted using S/MIME encryption standards as required by the Direct Protocol for Protected Health Information (PHI) transmission.. Valid values are `encrypted|unencrypted|partially_encrypted|encryption_failed`',
    `failure_reason` STRING COMMENT 'Detailed description of the reason for message delivery failure, including SMTP error codes, certificate validation errors, or recipient system unavailability. Null for successful deliveries.',
    `hie_network_name` STRING COMMENT 'Name of the Health Information Exchange network or DirectTrust community through which the message was routed, if applicable. Null for direct point-to-point exchanges.',
    `hipaa_compliant` BOOLEAN COMMENT 'Boolean flag indicating whether the Direct message transmission met all HIPAA Security Rule requirements for Protected Health Information (PHI) exchange, including encryption and authentication.',
    `meaningful_use_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether this Direct message transaction qualifies for Meaningful Use or Promoting Interoperability attestation requirements under CMS programs.',
    `message_control_number` STRING COMMENT 'Unique control identifier assigned to the Direct message by the sending system, used for tracking and correlation across systems.',
    `message_priority` STRING COMMENT 'Priority level assigned to the Direct message indicating the urgency of the clinical information being exchanged. Influences routing and notification workflows.. Valid values are `routine|urgent|stat|emergency`',
    `message_size_bytes` BIGINT COMMENT 'Total size of the Direct message including all attachments and headers, measured in bytes. Used for capacity planning and transmission monitoring.',
    `message_type` STRING COMMENT 'Classification of the Direct message content indicating the clinical purpose or document type being exchanged (e.g., referral, care summary, lab result, discharge notification).. Valid values are `referral|care_summary|lab_result|discharge_notification|consultation_request|imaging_report`',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this Direct message record was last modified or updated in the system. Supports audit trail and change tracking requirements.',
    `notes` STRING COMMENT 'Free-text notes or comments about the Direct message transaction, including manual interventions, escalations, or special handling instructions.',
    `patient_mrn` STRING COMMENT 'The Medical Record Number of the patient whose clinical information is being exchanged in the Direct message. Used for patient matching and care coordination.',
    `read_receipt_received` BOOLEAN COMMENT 'Boolean flag indicating whether a read receipt (Message Disposition Notification) was received from the recipient, confirming the message was opened.',
    `read_receipt_requested` BOOLEAN COMMENT 'Boolean flag indicating whether the sender requested a read receipt (Message Disposition Notification) to confirm the recipient opened and read the message.',
    `read_timestamp` TIMESTAMP COMMENT 'The date and time when the recipient opened and read the Direct message, as reported by the Message Disposition Notification. Null if no read receipt was received.',
    `recipient_certificate_serial_number` STRING COMMENT 'Serial number of the digital certificate used by the recipient to decrypt the Direct message. Used for certificate tracking and audit trails.',
    `recipient_direct_address` STRING COMMENT 'The Direct Protocol email address of the intended recipient (provider, organization, or system) receiving the secure message. Format follows standard email address structure with DirectTrust-accredited domain.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_npi` STRING COMMENT 'National Provider Identifier of the receiving provider or organization. Ten-digit unique identifier assigned by CMS for HIPAA-covered entities.. Valid values are `^[0-9]{10}$`',
    `recipient_organization_name` STRING COMMENT 'Name of the healthcare organization or facility that received the Direct message. Supports care coordination tracking and organizational analytics.',
    `retry_count` STRING COMMENT 'Number of times the system attempted to resend the Direct message after initial delivery failure. Zero indicates successful first-attempt delivery.',
    `send_timestamp` TIMESTAMP COMMENT 'The date and time when the Direct message was sent from the originating system. Represents the business event time of message transmission.',
    `sender_certificate_serial_number` STRING COMMENT 'Serial number of the digital certificate used by the sender to sign and encrypt the Direct message. Used for certificate tracking and audit trails.',
    `subject_line` STRING COMMENT 'Subject line of the Direct message providing a brief description of the message content or purpose. May contain patient identifiers or clinical context.',
    `workflow_status` STRING COMMENT 'Current status of the Direct message within the internal care coordination workflow, tracking the message from initiation through final processing and archival. [ENUM-REF-CANDIDATE: initiated|in_transit|delivered|acknowledged|processed|archived|failed — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_direct_message PRIMARY KEY(`direct_message_id`)
) COMMENT 'Transactional record of every Direct Secure Messaging transaction exchanged via the Direct Protocol (DirectTrust). Captures message ID, sender Direct address, recipient Direct address, message type (referral, care summary, lab result, discharge notification), send timestamp, delivery status (sent/delivered/failed/bounced), message size, encryption status, certificate validation result, and associated clinical document reference. Supports care coordination, referral workflows, and Meaningful Use/Promoting Interoperability attestation.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` (
    `direct_address_id` BIGINT COMMENT 'Unique identifier for the Direct Secure Messaging address record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Foreign key reference to the facility associated with this Direct address when the address type is facility or organization.',
    `clinician_id` BIGINT COMMENT 'Foreign key reference to the provider associated with this Direct address when the address type is provider.',
    `demographics_id` BIGINT COMMENT 'Foreign key reference to the patient associated with this Direct address when the address type is patient.',
    `replaced_direct_address_id` BIGINT COMMENT 'Self-referencing FK on direct_address (replaced_direct_address_id)',
    `activation_date` DATE COMMENT 'The date on which this Direct address was activated and became operational for sending and receiving secure messages.',
    `address_status` STRING COMMENT 'Current operational status of the Direct address. Active addresses can send and receive messages; inactive, suspended, or revoked addresses cannot.. Valid values are `active|inactive|suspended|pending_activation|revoked|expired`',
    `address_type` STRING COMMENT 'Classification of the Direct address by entity type. Indicates whether the address belongs to an individual provider, a facility, a patient, an organizational unit, a department, or an application endpoint.. Valid values are `provider|facility|patient|organization|department|application`',
    `administrative_contact_email` STRING COMMENT 'The email address of the administrative contact responsible for this Direct address. Used for notifications and operational communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `administrative_contact_name` STRING COMMENT 'The name of the administrative contact responsible for managing this Direct address. Used for operational coordination and issue resolution.',
    `administrative_contact_phone` STRING COMMENT 'The phone number of the administrative contact responsible for this Direct address. Used for urgent operational communications.',
    `auto_renewal_enabled_flag` BOOLEAN COMMENT 'Indicates whether automatic certificate renewal is enabled for this Direct address. True if auto-renewal is configured, False if manual renewal is required.',
    `certificate_expiration_date` DATE COMMENT 'The date on which the digital certificate for this Direct address will expire. Certificates must be renewed before this date to maintain secure messaging capability.',
    `certificate_issue_date` DATE COMMENT 'The date on which the digital certificate for this Direct address was issued by the Certificate Authority.',
    `certificate_issuer_dn` STRING COMMENT 'The Distinguished Name of the Certificate Authority that issued the certificate for this Direct address. Identifies the trusted CA in the PKI hierarchy.',
    `certificate_serial_number` STRING COMMENT 'The unique serial number of the X.509 digital certificate issued for this Direct address. Used for certificate identification and revocation checking.',
    `certificate_status` STRING COMMENT 'Current status of the X.509 digital certificate associated with this Direct address. Valid certificates are required for secure message encryption and signing.. Valid values are `valid|expired|revoked|suspended|pending_issuance|renewal_required`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this Direct address record was first created in the system. Used for audit trail and data lineage tracking.',
    `deactivation_date` DATE COMMENT 'The date on which this Direct address was deactivated and ceased to be operational. Null if the address is currently active.',
    `department_name` STRING COMMENT 'The name of the clinical or administrative department associated with this Direct address when the address type is department or organization.',
    `direct_address` STRING COMMENT 'The fully qualified Direct address in email format (e.g., provider@direct.hospital.org). Used for secure HIPAA-compliant messaging between healthcare entities.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `display_name` STRING COMMENT 'The human-readable display name associated with this Direct address, typically shown in message headers and address books (e.g., Dr. John Smith, Cardiology Department).',
    `encryption_algorithm` STRING COMMENT 'The cryptographic algorithm used for encrypting messages sent to this Direct address (e.g., AES-256, 3DES). Ensures HIPAA-compliant secure transmission.',
    `hipaa_compliant_flag` BOOLEAN COMMENT 'Indicates whether this Direct address has been verified as HIPAA-compliant for secure transmission of Protected Health Information (PHI). True if compliant, False otherwise.',
    `hisp_domain` STRING COMMENT 'The domain name of the HISP that manages this Direct address (e.g., direct.hospital.org). Used for routing and trust validation.',
    `hisp_name` STRING COMMENT 'The name of the Health Information Service Provider that hosts and manages the Direct messaging infrastructure for this address.',
    `hitrust_certified_flag` BOOLEAN COMMENT 'Indicates whether the HISP managing this Direct address holds HITRUST CSF certification. True if certified, False otherwise.',
    `last_message_received_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent message received by this Direct address. Used for activity tracking and dormant address identification.',
    `last_message_sent_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent message sent from this Direct address. Used for activity tracking and dormant address identification.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this Direct address record was last modified. Used for audit trail and change tracking.',
    `message_volume_last_30_days` STRING COMMENT 'The total number of messages sent or received by this Direct address in the last 30 days. Used for activity monitoring and capacity planning.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to this Direct address. Used for operational context and troubleshooting.',
    `notification_email` STRING COMMENT 'The email address to which operational notifications about this Direct address are sent (e.g., certificate expiration warnings, delivery failures).. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `npi` STRING COMMENT 'The 10-digit National Provider Identifier associated with this Direct address when the address type is provider. Used to link the Direct address to a specific healthcare provider.. Valid values are `^[0-9]{10}$`',
    `primary_use_case` STRING COMMENT 'The primary clinical or operational use case for which this Direct address is utilized. Helps categorize messaging patterns and workflows. [ENUM-REF-CANDIDATE: care_coordination|referral|lab_results|radiology_results|discharge_summary|continuity_of_care|patient_portal|public_health_reporting — 8 candidates stripped; promote to reference product]',
    `signature_algorithm` STRING COMMENT 'The cryptographic algorithm used for digitally signing messages from this Direct address (e.g., RSA-SHA256). Ensures message integrity and non-repudiation.',
    `specialty` STRING COMMENT 'The clinical specialty of the provider associated with this Direct address when the address type is provider (e.g., Cardiology, Family Medicine, Radiology).',
    `trust_bundle_membership_status` STRING COMMENT 'Current status of this Direct address membership in the trust bundle. Active membership is required for trusted message exchange.. Valid values are `active|inactive|pending|removed`',
    `trust_bundle_name` STRING COMMENT 'The name of the trust bundle or trust anchor bundle that this Direct address belongs to. Trust bundles define the set of trusted Certificate Authorities for secure message exchange.',
    CONSTRAINT pk_direct_address PRIMARY KEY(`direct_address_id`)
) COMMENT 'Master record for all Direct Secure Messaging addresses managed by or registered with the organization, including provider Direct addresses, facility Direct addresses, and patient Direct addresses. Captures Direct address (FQDN format), address type (provider/facility/patient), associated NPI or facility ID, certificate status, certificate expiration date, HISP (Health Information Service Provider) name, trust bundle membership, and activation status. SSOT for Direct address inventory.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` (
    `interface_sla_id` BIGINT COMMENT 'Unique identifier for the interface SLA record. Primary key.',
    `interface_channel_id` BIGINT COMMENT 'Reference to the interface channel or connection to which this SLA applies. Links to the specific HL7v2, FHIR, or CDA interface channel being monitored.',
    `superseded_interface_sla_id` BIGINT COMMENT 'Self-referencing FK on interface_sla (superseded_interface_sla_id)',
    `trading_partner_id` BIGINT COMMENT 'Reference to the trading partner or Health Information Exchange (HIE) participant associated with this SLA. Identifies the external organization with whom the SLA is established.',
    `alert_threshold_percent` DECIMAL(18,2) COMMENT 'Percentage threshold at which proactive alerts are triggered before an SLA breach occurs. Enables early warning and intervention.',
    `auto_escalation_enabled_flag` BOOLEAN COMMENT 'Indicates whether automatic escalation is enabled when SLA thresholds are breached. True if auto-escalation is active, False if manual escalation is required.',
    `business_criticality` STRING COMMENT 'Business criticality classification of the interface and its associated SLA. Determines priority for monitoring, response, and resource allocation.. Valid values are `critical|high|medium|low`',
    `compliance_framework` STRING COMMENT 'Regulatory or industry compliance framework that this SLA supports. May reference HIPAA, HITRUST, HL7 standards, or other healthcare interoperability requirements.',
    `contract_reference` STRING COMMENT 'Reference to the master service contract or data sharing agreement that governs this SLA. Links SLA to legal or business agreements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA record was first created in the system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `effective_end_date` DATE COMMENT 'Date when this SLA expires or is no longer enforced. Null if the SLA is open-ended or perpetual.',
    `effective_start_date` DATE COMMENT 'Date when this SLA becomes effective and monitoring begins. SLA targets are enforced starting from this date.',
    `escalation_contact_email` STRING COMMENT 'Email address of the escalation contact person for SLA breaches.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `escalation_contact_name` STRING COMMENT 'Name of the escalation contact person for SLA breaches. Secondary contact when primary contact is unavailable or issue requires escalation.',
    `escalation_contact_phone` STRING COMMENT 'Phone number of the escalation contact person for SLA breaches.',
    `escalation_path` STRING COMMENT 'Defined escalation path or procedure to follow when SLA thresholds are breached. May reference teams, roles, or contact procedures.',
    `last_review_date` DATE COMMENT 'Date when this SLA was last reviewed and validated by stakeholders. Used for tracking periodic SLA review cycles.',
    `max_error_rate_percent` DECIMAL(18,2) COMMENT 'Maximum acceptable error rate as a percentage of total messages processed. Error rates exceeding this threshold trigger SLA breach alerts.',
    `max_latency_ms` STRING COMMENT 'Maximum acceptable message processing latency in milliseconds. Messages exceeding this threshold are considered SLA violations.',
    `measurement_window_hours` STRING COMMENT 'Time window in hours over which SLA metrics are measured and evaluated. Defines the rolling period for performance assessment.',
    `message_throughput_target` DECIMAL(18,2) COMMENT 'Target number of messages per hour that the interface channel must process to meet SLA requirements. Measured in messages per hour.',
    `modified_by` STRING COMMENT 'Username or identifier of the person who last modified this SLA record. Used for audit and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA record was last modified. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for tracking changes and audit trails.',
    `monitoring_enabled_flag` BOOLEAN COMMENT 'Indicates whether active monitoring and alerting is enabled for this SLA. True if monitoring is active, False if disabled.',
    `next_review_date` DATE COMMENT 'Date when this SLA is scheduled for next review. Ensures periodic validation and updates to SLA terms.',
    `notes` STRING COMMENT 'Additional notes, comments, or context about this SLA. Free-text field for operational or business information.',
    `notification_email_list` STRING COMMENT 'Comma-separated list of email addresses to notify when SLA thresholds are breached or alerts are triggered.',
    `penalty_clause` STRING COMMENT 'Description of financial or operational penalties that apply when SLA targets are not met. May reference contract terms or service credits.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact person responsible for this SLA.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary contact person responsible for this SLA. First point of contact for SLA-related issues.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary contact person responsible for this SLA.',
    `reporting_frequency` STRING COMMENT 'Frequency at which SLA performance reports are generated and distributed to stakeholders.. Valid values are `real_time|hourly|daily|weekly|monthly`',
    `sla_code` STRING COMMENT 'Unique business code or identifier for the SLA. Used for operational tracking and cross-system reference.',
    `sla_name` STRING COMMENT 'Business-friendly name or title of the SLA. Used for identification and reporting purposes.',
    `sla_status` STRING COMMENT 'Current operational status of the SLA. Indicates whether the SLA is actively enforced, temporarily suspended, or in draft state.. Valid values are `active|suspended|expired|draft|under_review`',
    `sla_type` STRING COMMENT 'Classification of the SLA based on the primary performance metric being measured. Determines the focus area for monitoring and alerting.. Valid values are `interface_throughput|latency|error_rate|uptime|composite`',
    `throughput_unit` STRING COMMENT 'Unit of measure for the message throughput target. Defines the time granularity for throughput measurement.. Valid values are `messages_per_hour|messages_per_minute|messages_per_day|transactions_per_second`',
    `uptime_target_percent` DECIMAL(18,2) COMMENT 'Target uptime percentage for the interface channel or connection. Represents the minimum percentage of time the interface must be operational.',
    `version` STRING COMMENT 'Version number or identifier for this SLA definition. Tracks changes and revisions to SLA terms over time.',
    `created_by` STRING COMMENT 'Username or identifier of the person who created this SLA record. Used for audit and accountability purposes.',
    CONSTRAINT pk_interface_sla PRIMARY KEY(`interface_sla_id`)
) COMMENT 'Master record defining Service Level Agreement (SLA) targets for each interface channel or trading partner connection. Captures SLA name, associated channel or partner, message throughput target (messages/hour), maximum acceptable latency (ms), maximum error rate threshold (%), uptime target (%), alerting thresholds, escalation path, measurement window, and effective date. Enables proactive interface performance management and SLA breach alerting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` (
    `interface_downtime_id` BIGINT COMMENT 'Unique identifier for the interface downtime event record.',
    `fhir_endpoint_id` BIGINT COMMENT 'Foreign key linking to interoperability.fhir_endpoint. Business justification: FHIR endpoints can experience downtime separately from HL7 interface channels. Adding fhir_endpoint_id FK enables tracking API-specific outages, monitoring FHIR endpoint SLAs, and analyzing downtime p',
    `interface_channel_id` BIGINT COMMENT 'Reference to the interface channel affected by this downtime event.',
    `interface_engine_id` BIGINT COMMENT 'Reference to the interface engine hosting the affected channel.',
    `employee_id` BIGINT COMMENT 'Reference to the user or system account that first detected and reported the downtime event.',
    `related_prior_interface_downtime_id` BIGINT COMMENT 'Self-referencing FK on interface_downtime (related_interface_downtime_id)',
    `trading_partner_id` BIGINT COMMENT 'Reference to the trading partner connection affected by this downtime event, if applicable.',
    `actual_uptime_percentage` DECIMAL(18,2) COMMENT 'The actual uptime percentage achieved during the measurement period, accounting for this downtime event.',
    `affected_channels_count` STRING COMMENT 'Number of interface channels affected by this downtime event.',
    `affected_departments` STRING COMMENT 'Comma-separated list of clinical or operational departments impacted by this interface downtime event.',
    `affected_facilities` STRING COMMENT 'Comma-separated list of facility names or identifiers impacted by this interface downtime event.',
    `affected_message_types` STRING COMMENT 'Comma-separated list of HL7 message types (e.g., ADT, ORM, ORU) or FHIR resource types affected during the downtime period.',
    `business_impact_description` STRING COMMENT 'Narrative description of the business and clinical impact caused by this downtime event, including affected workflows and patient care implications.',
    `change_request_reference` STRING COMMENT 'Reference number or identifier of the change request that triggered this downtime, if applicable for planned maintenance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this downtime event record was first created in the system.',
    `detection_method` STRING COMMENT 'Method by which the downtime event was initially detected.. Valid values are `automated_monitoring|user_reported|scheduled_check|vendor_notification|system_alert`',
    `downtime_duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of the downtime event measured in minutes, calculated from start to end timestamp.',
    `downtime_end_timestamp` TIMESTAMP COMMENT 'The precise date and time when the interface downtime event ended and service was restored. Null if downtime is still active.',
    `downtime_event_number` STRING COMMENT 'Business identifier for the downtime event, used for tracking and reporting purposes.',
    `downtime_start_timestamp` TIMESTAMP COMMENT 'The precise date and time when the interface downtime event began, marking the start of service interruption.',
    `downtime_status` STRING COMMENT 'Current lifecycle status of the downtime event indicating whether it is active, resolved, under investigation, recovering, or closed.. Valid values are `active|resolved|investigating|recovering|closed`',
    `downtime_type` STRING COMMENT 'Classification of the downtime event indicating whether it was planned maintenance, unplanned outage, trading partner outage, emergency maintenance, scheduled upgrade, or network failure.. Valid values are `planned_maintenance|unplanned_outage|trading_partner_outage|emergency_maintenance|scheduled_upgrade|network_failure`',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this downtime event was escalated to higher-level support or management.',
    `escalation_level` STRING COMMENT 'The support tier or level to which the downtime event was escalated.. Valid values are `tier_1|tier_2|tier_3|management|vendor`',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the downtime event was escalated to higher-level support or management.',
    `impact_severity` STRING COMMENT 'Business impact severity level of the downtime event, indicating the criticality of the service interruption on clinical and operational workflows.. Valid values are `critical|high|medium|low`',
    `incident_ticket_reference` STRING COMMENT 'Reference number or identifier of the IT service management incident ticket associated with this downtime event.',
    `messages_lost_count` BIGINT COMMENT 'Total number of interface messages permanently lost or unrecoverable due to the downtime event.',
    `messages_queued_count` BIGINT COMMENT 'Total number of interface messages queued or held during the downtime period awaiting transmission or processing.',
    `messages_replayed_count` BIGINT COMMENT 'Total number of interface messages successfully replayed or reprocessed after service recovery.',
    `notes` STRING COMMENT 'Additional free-text notes and observations related to the downtime event.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether stakeholder notifications were sent regarding this downtime event.',
    `notification_timestamp` TIMESTAMP COMMENT 'Date and time when stakeholder notifications were sent for this downtime event.',
    `post_incident_review_completed_flag` BOOLEAN COMMENT 'Indicates whether a post-incident review was conducted to analyze lessons learned and prevent recurrence.',
    `post_incident_review_date` DATE COMMENT 'Date when the post-incident review meeting was conducted.',
    `preventive_actions` STRING COMMENT 'Description of preventive actions identified and planned to prevent recurrence of similar downtime events.',
    `problem_ticket_reference` STRING COMMENT 'Reference number or identifier of the IT service management problem ticket if root cause analysis was escalated.',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the resolution steps taken to restore service and recover from the downtime event.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the downtime event was resolved and service restoration was confirmed.',
    `root_cause_category` STRING COMMENT 'High-level classification of the root cause that triggered the downtime event.. Valid values are `hardware_failure|software_bug|network_issue|configuration_error|capacity_overload|external_dependency`',
    `root_cause_description` STRING COMMENT 'Detailed narrative description of the root cause analysis findings explaining why the downtime occurred.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether this downtime event resulted in a breach of the interface availability Service Level Agreement.',
    `sla_target_uptime_percentage` DECIMAL(18,2) COMMENT 'The contractual target uptime percentage defined in the SLA for the affected interface channel.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this downtime event record was last modified.',
    `workaround_description` STRING COMMENT 'Description of the temporary workaround implemented to maintain business continuity during the downtime event.',
    `workaround_implemented_flag` BOOLEAN COMMENT 'Indicates whether a temporary workaround was implemented to mitigate the impact while permanent resolution was in progress.',
    CONSTRAINT pk_interface_downtime PRIMARY KEY(`interface_downtime_id`)
) COMMENT 'Transactional record of every planned and unplanned interface downtime event affecting interface channels or trading partner connections. Captures downtime start timestamp, downtime end timestamp, downtime type (planned maintenance/unplanned outage/trading partner outage), affected channels, root cause, impact severity, messages queued during downtime, messages replayed after recovery, and incident ticket reference. Supports SLA reporting, root cause analysis, and operational resilience tracking.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` (
    `terminology_mapping_id` BIGINT COMMENT 'Unique identifier for the terminology mapping record. Primary key.',
    `primary_superseded_by_terminology_mapping_id` BIGINT COMMENT 'Reference to the newer mapping that replaces this one when a mapping is deprecated or retired.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or governance committee member who approved this mapping for production use.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Interface engines map CPT procedure codes between EHR and billing systems or trading partners. Real-world scenario: translating local procedure codes to standard CPT for claims transmission via 837 tr',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: DME and supply interfaces map local codes to HCPCS for claims submission. Real-world: translating internal supply codes to HCPCS Level II for Medicare/Medicaid billing via 837 transactions.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Interface engines map ICD diagnosis codes between internal and trading partner systems. Real-world interoperability requires translating ICD-9 to ICD-10, or local codes to standard ICD for HIE queries',
    `loinc_code_id` BIGINT COMMENT 'Foreign key linking to reference.loinc_code. Business justification: Lab interfaces map local test codes to LOINC for interoperability. Real-world: ORU result messages translate internal lab codes to standard LOINC for HIE sharing and public health reporting.',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Pharmacy interfaces map medication codes to NDC for e-prescribing and medication reconciliation. Real-world: NCPDP SCRIPT messages and FHIR MedicationRequest resources require NDC code mapping.',
    `code_set_version_id` BIGINT COMMENT 'Foreign key linking to reference.code_set_version. Business justification: Terminology mappings must reference specific versions of code sets (ICD-10, SNOMED, LOINC) to ensure mapping accuracy. Links interoperability domain to reference data domain, enabling version-controll',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: FHIR interfaces map SNOMED CT concepts for clinical terminology interoperability. Real-world: translating local problem list terms to SNOMED for USCDI-compliant FHIR API exchanges and care quality rep',
    `exchange_standard_id` BIGINT COMMENT 'Foreign key linking to interoperability.exchange_standard. Business justification: Terminology mappings target specific exchange standards (e.g., mapping local codes to FHIR ValueSets, HL7v2 tables, or CDA code systems). Currently only target_code_system (STRING) exists. FK to excha',
    `tertiary_terminology_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who most recently modified this mapping record.',
    `alternate_target_code_value` DECIMAL(18,2) COMMENT 'An alternative target code value that may also be valid for this mapping, used when multiple valid mappings exist.',
    `alternate_target_display_name` STRING COMMENT 'Display name for the alternate target code, providing additional context for secondary mapping options.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this mapping was officially approved by the governance process.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this mapping record was first created in the system.',
    `effective_end_date` DATE COMMENT 'The date after which this terminology mapping is no longer valid and should not be used. Null indicates an open-ended mapping.',
    `effective_start_date` DATE COMMENT 'The date from which this terminology mapping becomes valid and should be used in data transformation and exchange processes.',
    `error_count` BIGINT COMMENT 'Number of errors or exceptions encountered when applying this mapping, used to identify problematic mappings requiring review.',
    `governance_approval_status` STRING COMMENT 'Status of governance review and approval for this mapping: pending (awaiting review), approved (validated and authorized for use), rejected (not approved), conditional (approved with restrictions or conditions).. Valid values are `pending|approved|rejected|conditional`',
    `last_review_date` DATE COMMENT 'Date when this mapping was last reviewed by a subject matter expert or governance committee.',
    `mapping_code` STRING COMMENT 'Unique business code or identifier for this mapping, used for external reference and integration.',
    `mapping_confidence_score` DECIMAL(18,2) COMMENT 'Numeric confidence score (0.00 to 100.00) representing the certainty or quality of the mapping, often derived from automated mapping tools or expert review.',
    `mapping_method` STRING COMMENT 'The method by which this mapping was created: manual (human expert), automated (algorithm or tool), hybrid (combination of automated and manual review), vendor_supplied (provided by EHR or terminology vendor).. Valid values are `manual|automated|hybrid|vendor_supplied`',
    `mapping_name` STRING COMMENT 'Human-readable name or title for this terminology mapping, used for identification and reference in governance workflows.',
    `mapping_priority` STRING COMMENT 'Business priority level for this mapping, indicating urgency or importance for clinical, billing, or regulatory use cases.. Valid values are `high|medium|low`',
    `mapping_rationale` STRING COMMENT 'Detailed explanation or justification for why this particular mapping was chosen, especially for inexact or complex mappings.',
    `mapping_relationship_type` STRING COMMENT 'The semantic relationship between the source and target codes: equivalent (exact match), wider/subsumes (target is broader), narrower/specializes (target is more specific), inexact (approximate match), unmatched (no suitable target), disjoint (concepts do not overlap), relatedto (related but not hierarchical). [ENUM-REF-CANDIDATE: equivalent|equal|wider|subsumes|narrower|specializes|inexact|unmatched|disjoint|relatedto — 10 candidates stripped; promote to reference product]',
    `mapping_status` STRING COMMENT 'Current lifecycle status of the mapping: draft (in development), active (approved and in use), retired (no longer valid), deprecated (superseded by newer mapping), under_review (pending governance approval).. Valid values are `draft|active|retired|deprecated|under_review`',
    `mapping_tool_name` STRING COMMENT 'Name of the software tool or platform used to create or validate this mapping (e.g., UMLS Metathesaurus, Apelon DTS, proprietary mapping engine).',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this mapping record was last modified or updated.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this mapping to ensure continued accuracy and relevance.',
    `notes` STRING COMMENT 'Free-text notes or comments about this mapping, including special handling instructions, known limitations, or historical context.',
    `source_code_system` STRING COMMENT 'The code system or terminology from which the source code originates (e.g., local facility codes, proprietary system codes, legacy identifiers).',
    `source_code_system_version` STRING COMMENT 'Version of the source code system, ensuring mapping accuracy when source terminologies evolve over time.',
    `source_context` STRING COMMENT 'Additional contextual information about where or how the source code is used in the source system (e.g., specific module, workflow, or clinical domain).',
    `target_code_system` STRING COMMENT 'The standard terminology or code system to which the source code is being mapped (e.g., SNOMED CT, LOINC, RxNorm, ICD-10, CPT, CVX).',
    `target_code_system_version` STRING COMMENT 'Version of the target standard terminology, critical for maintaining mapping accuracy as standards evolve.',
    `target_code_value` DECIMAL(18,2) COMMENT 'The actual code value in the target standard terminology that the source code maps to.',
    `target_context` STRING COMMENT 'Additional contextual information about the appropriate use of the target code in the target terminology or receiving system.',
    `target_display_name` STRING COMMENT 'Human-readable display name or description of the target code as defined in the standard terminology.',
    `usage_count` BIGINT COMMENT 'Number of times this mapping has been applied in data transformation or exchange processes, indicating mapping utilization and importance.',
    `use_case_category` STRING COMMENT 'The primary business or clinical use case for which this mapping is intended (e.g., clinical documentation, laboratory results, radiology reports, pharmacy orders, billing and coding, quality reporting, research data, HIE exchange, public health reporting). [ENUM-REF-CANDIDATE: clinical_documentation|laboratory|radiology|pharmacy|billing|quality_reporting|research|hie_exchange|public_health — 9 candidates stripped; promote to reference product]',
    `validation_status` STRING COMMENT 'Status of technical and semantic validation for this mapping: validated (passed all checks), unvalidated (not yet tested), failed_validation (errors detected), pending_validation (queued for review).. Valid values are `validated|unvalidated|failed_validation|pending_validation`',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when this mapping was last validated or tested for accuracy and completeness.',
    CONSTRAINT pk_terminology_mapping PRIMARY KEY(`terminology_mapping_id`)
) COMMENT 'Master record for enterprise terminology translation mappings between local codes and standard terminologies (SNOMED CT, LOINC, RxNorm, ICD-10, CPT, CVX). Captures source code system, source code value, source display name, target code system, target code value, target display name, mapping relationship type (equivalent/broader/narrower/related), mapping confidence, effective date, expiration date, and governance approval status. Distinct from data_mapping (field-level) — this is value-level code translation.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` (
    `subscription_topic_id` BIGINT COMMENT 'Unique identifier for the subscription topic record. Primary key.',
    `exchange_standard_id` BIGINT COMMENT 'Reference to the data exchange standard governing the format and structure of notifications for this subscription.',
    `interface_engine_id` BIGINT COMMENT 'Reference to the interface engine responsible for processing and delivering notifications for this subscription topic.',
    `superseded_subscription_topic_id` BIGINT COMMENT 'Self-referencing FK on subscription_topic (superseded_subscription_topic_id)',
    `trading_partner_id` BIGINT COMMENT 'Reference to the trading partner organization subscribing to this topic.',
    `audit_logging_enabled_flag` BOOLEAN COMMENT 'Indicates whether all notification events for this subscription are logged for compliance and audit purposes.',
    `authentication_credential` STRING COMMENT 'Encrypted or tokenized authentication credential (API key, token reference, certificate thumbprint) used to authenticate with the subscriber endpoint. Stored securely.',
    `authentication_method` STRING COMMENT 'The authentication mechanism required for the subscriber endpoint to accept notifications.. Valid values are `none|basic_auth|bearer_token|oauth2|mutual_tls|api_key`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this subscription topic record was first created in the system.',
    `data_sharing_agreement_reference` STRING COMMENT 'Reference identifier to the legal data sharing agreement or business associate agreement governing this subscription.',
    `effective_end_date` DATE COMMENT 'Date when this subscription topic expires or is scheduled for deactivation. Null indicates no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this subscription topic becomes active and begins processing events.',
    `encryption_required_flag` BOOLEAN COMMENT 'Indicates whether notification payloads must be encrypted in transit and at rest.',
    `event_batch_size` STRING COMMENT 'Number of events to batch together in a single notification delivery. 1 indicates individual event notifications.',
    `event_batch_window_seconds` STRING COMMENT 'Time window in seconds to collect events before sending a batched notification.',
    `fhir_filter_criteria` STRING COMMENT 'FHIR search parameters or filter expressions used to narrow the scope of events that trigger notifications (e.g., Observation?code=http://loinc.org|2339-0&status=final).',
    `fhir_resource_type` STRING COMMENT 'The FHIR resource type being monitored for this subscription (e.g., Patient, Observation, Encounter, DiagnosticReport). Null for non-FHIR subscriptions.',
    `hl7v2_message_type` STRING COMMENT 'The HL7 v2.x message type and trigger event for this subscription (e.g., ADT^A01, ORU^R01, SIU^S12). Null for non-HL7v2 subscriptions.',
    `last_error_message` STRING COMMENT 'Most recent error message or exception details from a failed notification delivery attempt.',
    `last_error_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent notification delivery failure for this subscription topic.',
    `last_notification_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful notification delivery for this subscription topic.',
    `max_retry_attempts` STRING COMMENT 'Maximum number of retry attempts for failed notification deliveries before marking as permanently failed.',
    `notes` STRING COMMENT 'Free-text notes for additional context, configuration details, or operational instructions related to this subscription topic.',
    `notification_channel_type` STRING COMMENT 'The communication channel or protocol used to deliver subscription notifications to the subscriber.. Valid values are `rest_hook|websocket|email|fhir_messaging|sms|hl7v2_mllp`',
    `notification_count_total` BIGINT COMMENT 'Cumulative count of all notifications sent for this subscription topic since activation.',
    `notification_failure_count` BIGINT COMMENT 'Cumulative count of failed notification delivery attempts for this subscription topic.',
    `patient_consent_required_flag` BOOLEAN COMMENT 'Indicates whether individual patient consent is required before sending notifications for this subscription topic.',
    `payload_content_type` STRING COMMENT 'Specifies what data is included in the notification payload: full FHIR resource, resource ID only, empty notification, or custom format.. Valid values are `full_resource|id_only|empty|custom`',
    `payload_mime_type` STRING COMMENT 'The MIME type of the notification payload (e.g., application/fhir+json, application/hl7-v2, application/xml).',
    `phi_included_flag` BOOLEAN COMMENT 'Indicates whether the notification payload contains Protected Health Information subject to HIPAA regulations.',
    `priority_level` STRING COMMENT 'Business priority of this subscription topic, used for resource allocation and queue management during high-volume periods.. Valid values are `critical|high|normal|low`',
    `retry_interval_seconds` STRING COMMENT 'Time interval in seconds between retry attempts for failed notifications.',
    `retry_policy` STRING COMMENT 'The retry strategy applied when notification delivery fails.. Valid values are `none|exponential_backoff|fixed_interval|immediate_only`',
    `subscriber_contact_email` STRING COMMENT 'Email address of the primary contact for subscription-related communications and issue resolution.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `subscriber_contact_name` STRING COMMENT 'Name of the primary technical or operational contact for the subscribing organization.',
    `subscriber_contact_phone` STRING COMMENT 'Phone number of the primary contact for urgent subscription issues or outage notifications.',
    `subscriber_endpoint_url` STRING COMMENT 'The target URL or endpoint address where notifications are sent (e.g., REST endpoint, websocket URL, MLLP host:port).',
    `subscriber_organization_name` STRING COMMENT 'Name of the external organization or system subscribing to this topic.',
    `subscription_status` STRING COMMENT 'Current operational status of the subscription topic indicating whether it is actively processing events.. Valid values are `active|inactive|suspended|error|testing|pending_approval`',
    `timeout_seconds` STRING COMMENT 'Maximum time in seconds to wait for a response from the subscriber endpoint before considering the notification delivery failed.',
    `topic_code` STRING COMMENT 'Unique business code identifying the subscription topic, used for external system references and configuration management.',
    `topic_name` STRING COMMENT 'Human-readable name of the subscription topic (e.g., ADT Notifications, Lab Result Availability, Care Gap Alerts).',
    `topic_type` STRING COMMENT 'Classification of the subscription topic based on the underlying standard or use case.. Valid values are `fhir_subscription|hl7v2_event|cda_notification|custom_event|care_coordination|clinical_alert`',
    `trigger_event_type` STRING COMMENT 'The specific clinical or administrative event type that triggers this subscription (e.g., ADT^A01, Observation.create, Encounter.discharge).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this subscription topic record was last modified.',
    CONSTRAINT pk_subscription_topic PRIMARY KEY(`subscription_topic_id`)
) COMMENT 'Master record for FHIR Subscription topics and HL7v2 event subscriptions configured to push notifications to external systems when specific clinical events occur (e.g., ADT notifications, lab result availability, care gap alerts). Captures topic name, trigger event type, FHIR resource filter criteria, notification channel type (REST-hook/websocket/email/FHIR messaging), subscriber endpoint, payload type (full-resource/id-only/empty), and subscription status. Supports event-driven interoperability and care coordination notifications.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` (
    `subscription_notification_id` BIGINT COMMENT 'Unique identifier for the subscription notification event record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility or organization where the triggering event originated. Identifies the source system or location that generated the event data.',
    `financial_entity_id` BIGINT COMMENT 'Reference to the organization or trading partner that is the recipient of this notification. Links to the external entity consuming the event data.',
    `interface_channel_id` BIGINT COMMENT 'Reference to the specific interface channel or connection configuration used to deliver this notification. Links to the technical routing and transport configuration.',
    `interface_engine_id` BIGINT COMMENT 'Reference to the interface engine or integration platform that processed and dispatched this notification. Links to the technical infrastructure component responsible for delivery.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Event-driven notifications (ADT, lab results, imaging) are patient-specific and require authoritative identity for routing to subscribers. Delivery confirmation and audit trails depend on patient link',
    `retried_subscription_notification_id` BIGINT COMMENT 'Self-referencing FK on subscription_notification (retried_subscription_notification_id)',
    `scheduling_appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: Real-time appointment notifications via FHIR subscriptions (Appointment resource updates). Modern interoperability pattern: external systems subscribe to appointment events (booked, cancelled, resched',
    `subscription_topic_id` BIGINT COMMENT 'Reference to the FHIR Subscription or HL7 event subscription definition that triggered this notification. Links to the subscription configuration that defines the topic, criteria, and endpoint.',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter associated with the triggering event, if applicable. Null for non-encounter events. Links the notification to the specific episode of care.',
    `acknowledgment_received_flag` BOOLEAN COMMENT 'Indicates whether a positive acknowledgment (ACK) was received from the subscriber endpoint. True if ACK received; false if NACK or no response. Used to distinguish between delivery success and failure.',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'The date and time when the acknowledgment was received from the subscriber endpoint. Null if no acknowledgment received. Used to calculate delivery latency and SLA compliance.',
    `business_impact_description` STRING COMMENT 'Free-text description of the business impact if this notification failed to deliver (e.g., delayed care coordination, missed clinical alert, billing delay). Used for prioritizing remediation efforts.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this notification record was first created in the system. Used for audit trail and data lineage tracking.',
    `delivery_latency_milliseconds` STRING COMMENT 'The elapsed time in milliseconds between notification dispatch and acknowledgment receipt. Null if acknowledgment not received. Used for performance monitoring and SLA tracking.',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the notification delivery. Sent indicates dispatched; delivered indicates acknowledgment received; failed indicates delivery error; retrying indicates automatic retry in progress; abandoned indicates retry limit exceeded.. Valid values are `sent|delivered|failed|retrying|abandoned`',
    `encryption_enabled_flag` BOOLEAN COMMENT 'Indicates whether the notification was transmitted using encryption (e.g., TLS, HTTPS). True if encrypted; false if transmitted in clear text. Used for security compliance auditing.',
    `error_code` STRING COMMENT 'The error code returned by the subscriber endpoint or notification engine if delivery failed. Null if delivery succeeded. Used for troubleshooting and categorizing failure types.',
    `error_message` STRING COMMENT 'The detailed error message or description returned if delivery failed. Null if delivery succeeded. Provides human-readable context for troubleshooting failed notifications.',
    `failure_reason_category` STRING COMMENT 'High-level categorization of the failure reason if delivery failed. Null if delivery succeeded. Used for root cause analysis and identifying systemic issues. [ENUM-REF-CANDIDATE: network_error|authentication_failure|authorization_failure|endpoint_unavailable|timeout|invalid_payload|subscriber_error|configuration_error — 8 candidates stripped; promote to reference product]',
    `http_response_code` STRING COMMENT 'The HTTP status code returned by the subscriber endpoint (e.g., 200 for success, 404 for not found, 500 for server error). Null if transport protocol is not HTTP-based.',
    `max_retry_count` STRING COMMENT 'The maximum number of retry attempts configured for this subscription before the notification is abandoned. Defines the retry policy threshold.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this notification record was last updated (e.g., status change, retry attempt). Used for audit trail and tracking notification lifecycle changes.',
    `next_retry_timestamp` TIMESTAMP COMMENT 'The scheduled date and time for the next delivery retry attempt. Null if delivery succeeded or retry limit reached. Used by the notification engine to schedule retry jobs.',
    `notes` STRING COMMENT 'Free-text field for additional context, troubleshooting notes, or operational comments related to this notification. Used for documenting manual interventions or special circumstances.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether an alert or notification was sent to support staff regarding this delivery event (e.g., for failures or SLA breaches). True if alert sent; false otherwise. Used for operational monitoring.',
    `notification_timestamp` TIMESTAMP COMMENT 'The exact date and time when the notification was dispatched to the subscriber endpoint. Represents the principal business event time for this transaction.',
    `patient_mrn` STRING COMMENT 'The Medical Record Number of the patient associated with the triggering event, if applicable. Null for non-patient events. Used for patient-centric notification tracking and audit trails. Protected Health Information (PHI) under HIPAA.',
    `payload_content_type` STRING COMMENT 'The MIME type or format of the notification payload (e.g., application/fhir+json, application/hl7-v2, empty for id-only notifications). Defines how the subscriber should parse the notification body.. Valid values are `application/fhir+json|application/fhir+xml|application/hl7-v2|text/plain|empty`',
    `payload_reference` STRING COMMENT 'Reference to the stored notification payload (e.g., object storage key, message queue ID, archive location). Enables retrieval of the full notification body for audit or replay purposes. Null if payload is not persisted.',
    `payload_size_bytes` STRING COMMENT 'The size of the notification payload in bytes. Used for capacity planning, bandwidth monitoring, and identifying oversized notifications that may cause delivery issues.',
    `phi_transmitted_flag` BOOLEAN COMMENT 'Indicates whether the notification payload contained Protected Health Information (PHI) as defined by HIPAA. True if PHI was included; false if only identifiers or metadata were sent. Used for compliance auditing and security monitoring.',
    `priority` STRING COMMENT 'The priority level assigned to this notification, determining delivery urgency and retry behavior. STAT indicates immediate delivery required; urgent indicates expedited delivery; routine indicates standard delivery.. Valid values are `routine|urgent|stat|asap`',
    `retry_count` STRING COMMENT 'The number of delivery retry attempts made for this notification. Zero indicates first attempt; increments with each retry. Used to track delivery reliability and identify problematic endpoints.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the notification delivery exceeded the SLA target delivery time. True if SLA was breached; false if delivered within SLA. Used for performance reporting and partner accountability.',
    `sla_target_delivery_seconds` STRING COMMENT 'The target delivery time in seconds defined by the Service Level Agreement (SLA) for this subscription. Used to measure whether the notification met the agreed-upon delivery performance standard.',
    `subscriber_endpoint_url` STRING COMMENT 'The target URL or endpoint address where the notification was sent. May be a REST endpoint, message queue, webhook, or Direct address. Business-confidential as it reveals system integration architecture.',
    `subscription_topic` STRING COMMENT 'The canonical URL or topic identifier that defines the event type being monitored (e.g., Patient admission, Lab result available, Medication order). Represents the business event category that triggered the notification.',
    `triggering_event_type` STRING COMMENT 'The specific event action that triggered the notification (e.g., create, update, delete, admit, discharge, transfer). Represents the CRUD or clinical workflow event that caused the subscription to fire. [ENUM-REF-CANDIDATE: create|update|delete|admit|discharge|transfer|result_available|order_placed|status_change — 9 candidates stripped; promote to reference product]',
    `triggering_resource_identifier` STRING COMMENT 'The unique identifier of the specific resource instance that triggered the notification (e.g., Patient/12345, Observation/67890). Enables tracing back to the exact clinical or administrative record that caused the event.',
    `triggering_resource_type` STRING COMMENT 'The FHIR resource type or HL7 message type that triggered the notification (e.g., Patient, Observation, MedicationRequest, ADT^A01). Identifies the clinical or administrative data entity involved in the event.',
    CONSTRAINT pk_subscription_notification PRIMARY KEY(`subscription_notification_id`)
) COMMENT 'Transactional record of every event-driven notification dispatched to a subscriber endpoint via FHIR Subscription or HL7 event notification. Captures notification timestamp, subscription topic reference, triggering event type, triggering resource ID, subscriber endpoint, delivery status (sent/delivered/failed/retrying), HTTP response code, retry count, and payload reference. Enables monitoring of event-driven interoperability workflows and subscriber delivery reliability.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` (
    `onboarding_project_id` BIGINT COMMENT 'Unique identifier for the interface or trading partner onboarding project. Primary key for the onboarding project record.',
    `exchange_standard_id` BIGINT COMMENT 'Foreign key linking to interoperability.exchange_standard. Business justification: Each onboarding project implements a specific exchange standard (HL7v2, FHIR, CDA). Link to exchange_standard enables tracking project scope, managing standard-specific requirements, and analyzing onb',
    `interface_engine_id` BIGINT COMMENT 'Reference to the interface engine or integration platform where this interface will be deployed and managed.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Onboarding projects establish interfaces with provider organizations. Linking to org_provider enables tracking which healthcare entities have active data exchange, supports payer credentialing validat',
    `predecessor_onboarding_project_id` BIGINT COMMENT 'Self-referencing FK on onboarding_project (predecessor_onboarding_project_id)',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Interoperability onboarding projects are staffed initiatives requiring workforce accountability. Project managers performance reviews, resource allocation, project portfolio reporting, and capacity p',
    `trading_partner_id` BIGINT COMMENT 'Reference to the trading partner or external organization being onboarded for data exchange. Links to the trading partner master record.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual total cost incurred for this onboarding project to date or upon completion.',
    `actual_go_live_date` DATE COMMENT 'Actual date when the interface was successfully deployed to production and began live data exchange.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total budget allocated for this onboarding project, including labor, software, and external vendor costs.',
    `build_completion_date` DATE COMMENT 'Date when the interface development and configuration was completed and ready for testing.',
    `business_owner_name` STRING COMMENT 'Full name of the business stakeholder or department owner sponsoring this onboarding project.',
    `certification_date` DATE COMMENT 'Date when certification or accreditation was successfully obtained for this interface.',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether formal certification (ONC, DirectTrust, Carequality, CommonWell, etc.) is required for this interface onboarding.',
    `certification_status` STRING COMMENT 'Current status of the certification or accreditation process for this interface onboarding project.. Valid values are `not_started|in_progress|submitted|approved|rejected|not_required`',
    `certification_type` STRING COMMENT 'Type of certification or accreditation required for this interface, such as ONC Health IT Certification, DirectTrust accreditation, or Carequality connection.. Valid values are `ONC|DirectTrust|Carequality|CommonWell|EHNAC|None`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this onboarding project record was first created in the system.',
    `data_sharing_agreement_date` DATE COMMENT 'Date when the data sharing agreement or business associate agreement was signed and became effective.',
    `data_sharing_agreement_signed_flag` BOOLEAN COMMENT 'Indicates whether a data sharing agreement or business associate agreement has been executed with the trading partner.',
    `design_completion_date` DATE COMMENT 'Date when the interface design, including mapping specifications and technical architecture, was completed and approved.',
    `discovery_completion_date` DATE COMMENT 'Date when the discovery phase was completed and requirements were finalized.',
    `discovery_start_date` DATE COMMENT 'Date when the discovery phase began, including requirements gathering and technical assessment activities.',
    `estimated_message_volume_monthly` STRING COMMENT 'Estimated number of messages or transactions expected to be exchanged per month once the interface is live.',
    `integration_testing_completion_date` DATE COMMENT 'Date when integration testing was successfully completed and the interface was validated for production readiness.',
    `integration_testing_start_date` DATE COMMENT 'Date when end-to-end integration testing with the trading partner began.',
    `interface_type` STRING COMMENT 'The type or standard of interface being onboarded, such as HL7v2, FHIR, CDA, Direct messaging, X12 EDI, NCPDP, or custom integration. [ENUM-REF-CANDIDATE: HL7v2|FHIR|CDA|Direct|X12|NCPDP|Custom — 7 candidates stripped; promote to reference product]',
    `lessons_learned` STRING COMMENT 'Documentation of key lessons learned, best practices, and improvement opportunities identified during the onboarding project.',
    `message_type` STRING COMMENT 'Specific message types or transaction sets being implemented in this onboarding project (e.g., ADT, ORU, SIU for HL7v2; Patient, Observation for FHIR).',
    `mitigation_plan` STRING COMMENT 'Description of risk mitigation strategies and contingency plans for addressing identified project risks.',
    `notes` STRING COMMENT 'Additional notes, comments, or context relevant to this onboarding project for reference and documentation purposes.',
    `priority` STRING COMMENT 'Business priority level assigned to this onboarding project, determining resource allocation and scheduling precedence.. Valid values are `critical|high|medium|low`',
    `project_closure_date` DATE COMMENT 'Date when the onboarding project was formally closed after successful go-live and post-live stabilization.',
    `project_code` STRING COMMENT 'Short alphanumeric code or identifier used to reference this onboarding project in communications and documentation.',
    `project_initiation_date` DATE COMMENT 'Date when the onboarding project was formally initiated and approved to proceed.',
    `project_name` STRING COMMENT 'Business name or title assigned to this onboarding project for identification and tracking purposes.',
    `project_phase` STRING COMMENT 'Current phase or stage of the onboarding project lifecycle, tracking progress from initial discovery through post-live support. [ENUM-REF-CANDIDATE: discovery|design|build|testing|go_live|post_live|on_hold|cancelled — 8 candidates stripped; promote to reference product]',
    `project_status` STRING COMMENT 'Overall status of the onboarding project indicating whether it is actively progressing, completed, paused, or terminated.. Valid values are `active|completed|on_hold|cancelled|delayed`',
    `risk_description` STRING COMMENT 'Description of key risks, challenges, or concerns identified for this onboarding project.',
    `risk_level` STRING COMMENT 'Overall risk assessment for this onboarding project based on complexity, dependencies, and potential impact.. Valid values are `low|medium|high|critical`',
    `target_go_live_date` DATE COMMENT 'Planned or target date for the interface to go live and begin production data exchange.',
    `technical_lead_email` STRING COMMENT 'Email address of the technical lead for technical coordination and issue resolution.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `technical_lead_name` STRING COMMENT 'Full name of the technical lead or integration engineer responsible for the technical implementation of the interface.',
    `uat_completion_date` DATE COMMENT 'Date when user acceptance testing was completed and business sign-off was obtained.',
    `uat_start_date` DATE COMMENT 'Date when user acceptance testing by business stakeholders and end users began.',
    `unit_testing_completion_date` DATE COMMENT 'Date when unit testing was successfully completed with all test cases passed.',
    `unit_testing_start_date` DATE COMMENT 'Date when unit testing of individual interface components began.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this onboarding project record was last modified or updated.',
    CONSTRAINT pk_onboarding_project PRIMARY KEY(`onboarding_project_id`)
) COMMENT 'Master record for every trading partner or interface onboarding project managed by the interoperability team. Captures project name, trading partner reference, interface type being onboarded, project phase (discovery/design/build/testing/go-live/post-live), project manager, target go-live date, actual go-live date, testing milestone dates, certification requirements (ONC, DirectTrust, Carequality), and project status. Enables portfolio management of the organizations interface onboarding pipeline.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` (
    `conformance_test_id` BIGINT COMMENT 'Unique identifier for the conformance test record. Primary key.',
    `exchange_standard_id` BIGINT COMMENT 'Foreign key linking to interoperability.exchange_standard. Business justification: Each conformance test validates compliance with a specific exchange standard and version (HL7v2.5.1, FHIR R4, CDA R2). Link to exchange_standard enables tracking certification status by standard, mana',
    `fhir_endpoint_id` BIGINT COMMENT 'Reference to the FHIR endpoint being tested for conformance. Nullable if test is not FHIR-specific.',
    `interface_channel_id` BIGINT COMMENT 'Reference to the interface channel being tested for conformance and interoperability.',
    `onboarding_project_id` BIGINT COMMENT 'Foreign key linking to interoperability.onboarding_project. Business justification: Conformance tests are conducted as part of trading partner onboarding projects. Currently conformance_test has interface_channel_id, fhir_endpoint_id, and trading_partner_id, but no link to the onboar',
    `retest_conformance_test_id` BIGINT COMMENT 'Self-referencing FK on conformance_test (retest_conformance_test_id)',
    `trading_partner_id` BIGINT COMMENT 'Reference to the trading partner for whom this conformance test was conducted. Nullable if internal testing.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the conformance test results were approved for certification submission or go-live.',
    `approved_by` STRING COMMENT 'Name of the individual who approved the conformance test results for certification submission or go-live.',
    `certification_submission_reference` STRING COMMENT 'Reference number or identifier for the ONC Health IT Certification submission associated with this conformance test. Nullable if not part of a certification submission.',
    `conformance_status` STRING COMMENT 'Overall conformance status determination based on test results. Indicates whether the interface/endpoint meets the required conformance profile.. Valid values are `Conformant|Non-Conformant|Conditionally Conformant|Pending Review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this conformance test record was first created in the system. Audit trail field.',
    `critical_failures_count` STRING COMMENT 'Number of critical or blocking failures identified during the conformance test that prevent certification or go-live.',
    `failure_summary` STRING COMMENT 'Summary description of the failures encountered during the conformance test, including error codes and affected test cases.',
    `fhir_resource_type` STRING COMMENT 'The FHIR resource type being tested for conformance (e.g., Patient, Observation, MedicationRequest, Encounter). Nullable if test is not FHIR-specific.',
    `go_live_readiness_status` STRING COMMENT 'Status indicating whether the interface or endpoint is ready for production go-live based on conformance test results.. Valid values are `Ready|Not Ready|Conditionally Ready|Pending Retest`',
    `message_event` STRING COMMENT 'The HL7 v2 message event trigger being tested (e.g., A01, A04, O01, R01). Nullable if test is not HL7 v2-specific.',
    `message_type` STRING COMMENT 'The HL7 v2 message type being tested (e.g., ADT, ORM, ORU, DFT). Nullable if test is not HL7 v2-specific.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about the conformance test execution, results, or context.',
    `onc_certification_criteria` STRING COMMENT 'The specific ONC Health IT Certification criteria being tested (e.g., 170.315(g)(10) for Standardized API for Patient and Population Services). Nullable if not ONC certification-related.',
    `pass_percentage` DECIMAL(18,2) COMMENT 'Percentage of test cases that passed, calculated as (test_cases_passed / total_test_cases) * 100. Used for conformance scoring.',
    `remediation_notes` STRING COMMENT 'Detailed notes on the remediation actions required or taken to address conformance test failures.',
    `remediation_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether remediation work is required to address conformance test failures before go-live or certification.',
    `retest_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a retest is required after remediation or configuration changes.',
    `retest_scheduled_date` DATE COMMENT 'The scheduled date for retesting after remediation. Nullable if no retest is scheduled.',
    `test_cases_failed` STRING COMMENT 'Number of test cases that failed during this conformance test execution.',
    `test_cases_passed` STRING COMMENT 'Number of test cases that passed successfully during this conformance test execution.',
    `test_cases_skipped` STRING COMMENT 'Number of test cases that were skipped or not executed during this conformance test run.',
    `test_duration_minutes` STRING COMMENT 'Total duration of the conformance test execution in minutes, from start to completion.',
    `test_environment` STRING COMMENT 'The environment in which the conformance test was executed (e.g., Development, Test, Staging, Production).. Valid values are `Development|Test|Staging|Pre-Production|Production`',
    `test_execution_date` DATE COMMENT 'The date on which the conformance test was executed. Principal business event timestamp for this transaction.',
    `test_execution_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the conformance test execution began, including time zone information.',
    `test_log_url` STRING COMMENT 'URL or file path to the detailed test execution logs for troubleshooting and audit purposes.',
    `test_report_url` STRING COMMENT 'URL or file path to the detailed conformance test report generated by the testing tool.',
    `test_result` STRING COMMENT 'Overall pass/fail result of the conformance test execution. Indicates whether the interface or endpoint met conformance requirements.. Valid values are `Pass|Fail|Partial Pass|Inconclusive|Error`',
    `test_scope` STRING COMMENT 'Description of the scope of the conformance test, including message types, FHIR resources, or transaction sets being validated (e.g., ADT^A01, Patient Resource, CDA Document).',
    `test_suite_name` STRING COMMENT 'Name of the conformance testing tool or suite used to execute the test (e.g., ONC Certification, Touchstone, Inferno, HL7 Conformance Tester). [ENUM-REF-CANDIDATE: ONC Certification|Touchstone|Inferno|HL7 Conformance Tester|IHE Gazelle|NIST Test Tool|Custom Internal Suite — 7 candidates stripped; promote to reference product]',
    `test_suite_version` STRING COMMENT 'Version number of the test suite or testing tool used for this conformance test execution.',
    `tester_email` STRING COMMENT 'Email address of the individual or team who executed the conformance test.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `tester_name` STRING COMMENT 'Name of the individual or team who executed the conformance test.',
    `total_test_cases` STRING COMMENT 'Total number of individual test cases executed as part of this conformance test run.',
    `transaction_set` STRING COMMENT 'The transaction set or interaction pattern being tested (e.g., IHE PIX Query, IHE PDQ Query, FHIR RESTful API operations). Nullable if not applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this conformance test record was last updated. Audit trail field.',
    CONSTRAINT pk_conformance_test PRIMARY KEY(`conformance_test_id`)
) COMMENT 'Transactional record of conformance and interoperability testing activities conducted for interface channels, FHIR endpoints, and trading partner connections. Captures test execution date, test suite used (ONC Certification, Touchstone, Inferno, HL7 Conformance Tester), test scope (message type/FHIR resource/transaction set), pass/fail result, number of test cases executed, number passed, number failed, critical failures, and certification submission reference. Supports ONC Health IT Certification and trading partner go-live readiness.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` (
    `promoting_interoperability_id` BIGINT COMMENT 'Unique identifier for the promoting interoperability performance record.',
    `care_site_id` BIGINT COMMENT 'Reference to the specific facility or hospital reporting this PI measure performance.',
    `clinician_id` BIGINT COMMENT 'Reference to the eligible clinician or provider reporting this PI measure performance.',
    `employee_id` BIGINT COMMENT 'Reference to the user who last updated this PI measure performance record.',
    `org_provider_id` BIGINT COMMENT 'Reference to the healthcare organization reporting this PI measure performance.',
    `prior_promoting_interoperability_id` BIGINT COMMENT 'Self-referencing FK on promoting_interoperability (prior_promoting_interoperability_id)',
    `apm_participation_flag` BOOLEAN COMMENT 'Indicates whether this PI measure is being reported as part of an Alternative Payment Model.',
    `attestation_contact_email` STRING COMMENT 'The email address of the individual responsible for submitting this PI measure attestation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `attestation_contact_name` STRING COMMENT 'The name of the individual responsible for submitting this PI measure attestation.',
    `attestation_contact_phone` STRING COMMENT 'The phone number of the individual responsible for submitting this PI measure attestation.',
    `attestation_date` DATE COMMENT 'The date on which the PI measure performance was attested and submitted to CMS.',
    `attestation_method` STRING COMMENT 'The method or channel used to submit the PI measure attestation to CMS.. Valid values are `cms_web_interface|qpp_portal|ehr_direct_submission|registry|qcdr|api`',
    `attestation_status` STRING COMMENT 'The current status of the PI measure attestation submission to CMS.. Valid values are `not_started|in_progress|submitted|accepted|rejected|pending_review`',
    `bonus_points_earned` STRING COMMENT 'The number of bonus points earned for exceptional performance on this PI measure.',
    `cms_program_year` STRING COMMENT 'The CMS program year for which this PI measure is being reported (may differ from calendar year).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this PI measure performance record was first created in the system.',
    `data_completeness_percentage` DECIMAL(18,2) COMMENT 'The percentage of required data elements that were complete and available for this PI measure calculation.',
    `denominator_count` STRING COMMENT 'The total number of eligible instances for the measure (total opportunities).',
    `ehr_certification_number` STRING COMMENT 'The ONC certification identifier for the EHR technology used to support this PI measure.',
    `ehr_product_version` STRING COMMENT 'The version of the EHR product used to support this PI measure.',
    `ehr_vendor_name` STRING COMMENT 'The name of the EHR vendor whose system was used to support this PI measure.',
    `exclusion_count` STRING COMMENT 'The number of instances excluded from the measure calculation due to valid exclusion criteria.',
    `hardship_exception_flag` BOOLEAN COMMENT 'Indicates whether a hardship exception was granted for this PI measure.',
    `hardship_exception_reason` STRING COMMENT 'The reason or justification for the hardship exception if one was granted.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this PI measure performance record was last modified.',
    `measure_category` STRING COMMENT 'The category of the PI measure within the CMS program structure. [ENUM-REF-CANDIDATE: electronic_prescribing|health_information_exchange|provider_to_patient_exchange|public_health_reporting|clinical_data_registry_reporting|base_score|performance_score|bonus — 8 candidates stripped; promote to reference product]',
    `measure_identifier` STRING COMMENT 'The unique CMS identifier for the specific PI measure being reported (e.g., PI_EP_1, PI_HIE_1).',
    `measure_name` STRING COMMENT 'The descriptive name of the PI measure (e.g., e-Prescribing, Health Information Exchange, Support Electronic Referral Loops).',
    `measure_weight` DECIMAL(18,2) COMMENT 'The weight or contribution of this measure to the overall PI score, expressed as a percentage.',
    `mips_participation_flag` BOOLEAN COMMENT 'Indicates whether this PI measure is being reported as part of MIPS participation.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding this PI measure performance or attestation.',
    `npi` STRING COMMENT 'The National Provider Identifier of the reporting clinician or organization.. Valid values are `^[0-9]{10}$`',
    `numerator_count` STRING COMMENT 'The number of instances that meet the measure criteria (successful actions or compliant cases).',
    `payment_adjustment_percentage` DECIMAL(18,2) COMMENT 'The percentage payment adjustment (positive or negative) resulting from this PI measure performance.',
    `performance_met_flag` BOOLEAN COMMENT 'Indicates whether the performance rate met the CMS threshold for this measure.',
    `performance_rate` DECIMAL(18,2) COMMENT 'The calculated performance rate for the measure, expressed as a percentage (numerator divided by denominator minus exclusions).',
    `reporting_entity_type` STRING COMMENT 'The type of entity reporting this PI measure (eligible clinician, hospital, group, or APM entity).. Valid values are `eligible_clinician|eligible_hospital|critical_access_hospital|group_practice|apm_entity`',
    `reporting_period_end_date` DATE COMMENT 'The end date of the reporting period for this PI measure performance.',
    `reporting_period_start_date` DATE COMMENT 'The start date of the reporting period for this PI measure performance.',
    `reporting_year` STRING COMMENT 'The calendar year for which this PI measure performance is being reported.',
    `submission_confirmation_number` STRING COMMENT 'The confirmation number provided by CMS upon successful submission of the PI measure attestation.',
    `threshold_percentage` DECIMAL(18,2) COMMENT 'The CMS-defined threshold percentage that must be met for this measure to be considered compliant.',
    `tin` STRING COMMENT 'The Tax Identification Number of the reporting organization or practice.. Valid values are `^[0-9]{9}$`',
    `validation_errors` STRING COMMENT 'Description of any validation errors encountered during PI measure submission or processing.',
    `validation_status` STRING COMMENT 'The status of data validation checks performed on this PI measure submission.. Valid values are `not_validated|passed|failed|pending`',
    CONSTRAINT pk_promoting_interoperability PRIMARY KEY(`promoting_interoperability_id`)
) COMMENT 'Transactional record tracking the organizations performance on CMS Promoting Interoperability (PI) program measures (formerly Meaningful Use), including electronic prescribing rates, health information exchange rates, provider-to-patient exchange rates, public health reporting rates, and clinical data registry reporting rates. Captures reporting period, eligible clinician or hospital reference, measure identifier, numerator count, denominator count, exclusion count, performance rate, and attestation status. Supports CMS PI attestation and value-based program compliance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` (
    `public_health_report_id` BIGINT COMMENT 'Unique identifier for each public health reporting submission record. Primary key for the public health report entity.',
    `care_site_id` BIGINT COMMENT 'Unique identifier of the healthcare facility or organization submitting this public health report. Links to the facility master data.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Public health reports (immunization registries, syndromic surveillance, reportable conditions) are submitted by clinicians. Provider_npi exists but lacks FK. Public health agencies, credentialing comm',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Public health reporting submits notifiable conditions using ICD codes. Real-world: electronic lab reporting (ELR) and case reporting to state health departments require standard ICD-10 diagnosis codes',
    `corrected_public_health_report_id` BIGINT COMMENT 'Self-referencing FK on public_health_report (corrected_public_health_report_id)',
    `data_use_agreement_id` BIGINT COMMENT 'Unique identifier of the data use agreement or data sharing agreement governing the exchange of this public health report with the receiving agency. Links to the legal agreement authorizing the data sharing.',
    `exchange_standard_id` BIGINT COMMENT 'Foreign key linking to interoperability.exchange_standard. Business justification: Public health reports conform to specific exchange standards (HL7v2, CDA, FHIR, etc.) mandated by reporting agencies. Currently this is captured as STRING columns message_standard and message_version.',
    `immunization_id` BIGINT COMMENT 'Foreign key linking to clinical.immunization. Business justification: Immunization registries (IIS) are mandatory public health reporting under meaningful use. Linking public_health_report to immunization enables tracking which immunization records were successfully sub',
    `interface_channel_id` BIGINT COMMENT 'Unique identifier of the interface engine channel used to transmit this public health report. Links to the interface channel configuration that defines transport, protocol, and endpoint details.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Reportable conditions (infectious diseases, cancer, immunizations) are patient-specific and submitted to public health agencies. Case tracking, duplicate prevention, and follow-up investigations requi',
    `measure_id` BIGINT COMMENT 'Foreign key linking to quality.measure. Business justification: Public health reports (immunization registry submissions, syndromic surveillance, cancer registry) often satisfy quality measure numerators (e.g., HEDIS childhood immunization, CMS immunization measur',
    `trading_partner_id` BIGINT COMMENT 'Unique identifier of the trading partner record representing the receiving public health agency. Links to trading partner master data containing contact information, technical endpoints, and data sharing agreements.',
    `visit_id` BIGINT COMMENT 'Unique identifier of the clinical encounter associated with this public health report, if applicable. Links the report to the originating patient visit or episode of care.',
    `acknowledgment_code` STRING COMMENT 'Code returned by the receiving public health agency in the acknowledgment message indicating acceptance, rejection, or error condition. Typically an HL7 acknowledgment code (AA, AE, AR, CA, CE, CR) or FHIR OperationOutcome code.',
    `acknowledgment_payload` STRING COMMENT 'Full text of the acknowledgment message received from the public health agency, including any error details, validation messages, or processing notes.',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Date and time when the acknowledgment message was received from the public health agency confirming receipt and processing status of the submission.',
    `attestation_eligible_flag` BOOLEAN COMMENT 'Boolean indicator of whether this public health report submission counts toward CMS Promoting Interoperability attestation requirements. True if the submission meets all criteria for attestation credit.',
    `case_count` STRING COMMENT 'Number of individual cases, records, or events included in this public health report submission. For ELR this is lab result count, for IIS this is immunization count, for syndromic surveillance this is encounter count.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this public health report record was first created in the data warehouse. Audit timestamp for data lineage and record creation tracking.',
    `encryption_enabled_flag` BOOLEAN COMMENT 'Boolean indicator of whether the public health report transmission was encrypted in transit. True if encryption was applied, false if transmitted in clear text. Critical for HIPAA compliance and PHI protection.',
    `error_description` STRING COMMENT 'Detailed description of any errors, validation failures, or rejection reasons returned by the receiving public health agency. Populated when submission_status is rejected or error.',
    `jurisdiction_code` STRING COMMENT 'Code identifying the state, county, or local public health jurisdiction to which this report is being submitted. Typically a FIPS code or state abbreviation.',
    `message_payload` STRING COMMENT 'Full text of the transmitted public health message in its native format (HL7 v2 pipe-delimited message, FHIR JSON bundle, CDA XML document). Stored for audit, troubleshooting, and resubmission purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this public health report record was last updated in the data warehouse. Audit timestamp for tracking changes to submission status, acknowledgments, or retry attempts.',
    `patient_mrn` STRING COMMENT 'Medical record number of the patient associated with this public health report, if the report pertains to a single patient. For batch submissions covering multiple patients, this field may be null.',
    `phi_included_flag` BOOLEAN COMMENT 'Boolean indicator of whether this public health report contains Protected Health Information as defined by HIPAA. True if PHI is present, requiring additional security and privacy controls.',
    `promoting_interoperability_measure` STRING COMMENT 'CMS Promoting Interoperability (formerly Meaningful Use) measure that this public health report submission satisfies. Examples include Public Health Registry Reporting, Immunization Registry Reporting, Electronic Case Reporting, Syndromic Surveillance Reporting.',
    `report_identifier` STRING COMMENT 'External business identifier or control number assigned to this public health report submission for tracking and reconciliation with the receiving agency.',
    `report_type` STRING COMMENT 'Category of public health report being submitted. ELR = Electronic Lab Reporting, IIS = Immunization Information System, syndromic_surveillance = BioSense Platform submissions, cancer_registry = state cancer registry reporting, vital_records = birth/death certificate reporting, reportable_condition = notifiable disease reporting.. Valid values are `ELR|IIS|syndromic_surveillance|cancer_registry|vital_records|reportable_condition`',
    `reporting_agency_code` STRING COMMENT 'Standardized code or identifier for the receiving public health agency, typically a state health department code or federal agency identifier.',
    `reporting_agency_name` STRING COMMENT 'Name of the state or federal public health agency receiving this report submission (e.g., State Department of Health, CDC BioSense Platform, State Immunization Registry).',
    `reporting_period_end_date` DATE COMMENT 'End date of the time period covered by this public health report submission. Defines the upper bound of the reporting window.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the time period covered by this public health report submission. For lab results, this may be the specimen collection date range start; for immunizations, the administration date range start.',
    `retry_count` STRING COMMENT 'Number of times this public health report submission has been retried after initial failure. Used to track resubmission attempts and prevent infinite retry loops.',
    `submission_source_system` STRING COMMENT 'Name or identifier of the source clinical system that generated the data for this public health report (e.g., Epic EHR, Cerner Millennium, Laboratory Information System). Used for troubleshooting and data lineage tracking.',
    `submission_status` STRING COMMENT 'Current lifecycle status of the public health report submission. Accepted = successfully received and validated by agency, rejected = failed validation or business rules, pending = awaiting acknowledgment, acknowledged = receipt confirmed but not yet processed, error = transmission or technical failure.. Valid values are `accepted|rejected|pending|acknowledged|error`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the public health report was transmitted to the receiving agency. This is the principal business event timestamp representing when the reporting obligation was fulfilled.',
    `transmission_method` STRING COMMENT 'Technical transport protocol used to transmit the public health report. HTTPS = secure web service, SFTP = secure file transfer, Direct = Direct secure messaging, SOAP = SOAP web service, REST = RESTful API, MLLP = Minimal Lower Layer Protocol for HL7 v2.. Valid values are `HTTPS|SFTP|Direct|SOAP|REST|MLLP`',
    CONSTRAINT pk_public_health_report PRIMARY KEY(`public_health_report_id`)
) COMMENT 'Transactional record of every public health reporting submission made to state and federal public health agencies, including electronic lab reporting (ELR), immunization registry submissions (IIS), syndromic surveillance (BioSense), cancer registry reporting, and vital records reporting. Captures report type, reporting agency, submission timestamp, reporting period, message standard used (HL7v2 2.5.1, FHIR), submission status (accepted/rejected/pending), acknowledgment code, and case count. Supports Promoting Interoperability public health measures.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` (
    `care_transition_notification_id` BIGINT COMMENT 'Unique identifier for the care transition notification record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility that sent the care transition notification.',
    `clinician_id` BIGINT COMMENT 'Reference to the attending provider responsible for the patient during the care transition event.',
    `demographics_id` BIGINT COMMENT 'Reference to the patient who experienced the care transition event.',
    `hie_transaction_id` BIGINT COMMENT 'Transaction identifier assigned by the Health Information Exchange network if the notification was routed through an HIE.',
    `interface_channel_id` BIGINT COMMENT 'Reference to the interface engine channel configuration used to send the notification.',
    `direct_address_id` BIGINT COMMENT 'Foreign key linking to interoperability.direct_address. Business justification: Care transition notifications (ADT notifications) are often sent via Direct Secure Messaging to care team members. The receiving_party_identifier could be a Direct address. Adding recipient_direct_add',
    `scheduling_appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: ADT notifications (discharge, transfer) trigger follow-up appointment scheduling per care coordination protocols. CMS care transitions programs and ACO contracts require tracking whether transition no',
    `superseded_care_transition_notification_id` BIGINT COMMENT 'Self-referencing FK on care_transition_notification (superseded_care_transition_notification_id)',
    `visit_id` BIGINT COMMENT 'Reference to the encounter associated with the care transition event (admission, discharge, transfer, or ED visit).',
    `acknowledgment_code` STRING COMMENT 'HL7 acknowledgment code received from the recipient system (AA=Application Accept, AE=Application Error, AR=Application Reject, CA=Commit Accept, CE=Commit Error, CR=Commit Reject).',
    `acknowledgment_received_flag` BOOLEAN COMMENT 'Indicates whether an acknowledgment was received from the recipient system confirming receipt of the notification.',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Date and time when the acknowledgment was received from the recipient system.',
    `actual_delivery_minutes` STRING COMMENT 'Actual time in minutes from event occurrence to successful notification delivery for SLA compliance monitoring.',
    `attending_provider_npi` STRING COMMENT 'National Provider Identifier of the attending provider for regulatory reporting.. Valid values are `^[0-9]{10}$`',
    `care_coordination_purpose` STRING COMMENT 'Specific care coordination purpose for the notification (e.g., post-discharge follow-up, medication reconciliation, care plan update, transition of care summary).',
    `cms_interoperability_compliant_flag` BOOLEAN COMMENT 'Indicates whether this notification meets CMS Interoperability and Patient Access Final Rule requirements for ADT notifications.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this notification record was created in the system for audit trail purposes.',
    `delivery_attempt_count` STRING COMMENT 'Number of delivery attempts made for this notification.',
    `delivery_channel` STRING COMMENT 'Communication channel used to deliver the notification: Direct secure messaging, FHIR API, HL7 v2 interface, Clinical Document Architecture (CDA), REST API, secure email, or fax. [ENUM-REF-CANDIDATE: direct|fhir|hl7v2|cda|api|secure_email|fax — 7 candidates stripped; promote to reference product]',
    `delivery_status` STRING COMMENT 'Current status of the notification delivery: sent, delivered to recipient system, failed, pending transmission, acknowledged by recipient, or rejected.. Valid values are `sent|delivered|failed|pending|acknowledged|rejected`',
    `discharge_disposition` STRING COMMENT 'Disposition of the patient at discharge (e.g., home, skilled nursing facility, hospice, left against medical advice) when event type is discharge.',
    `encryption_applied_flag` BOOLEAN COMMENT 'Indicates whether the notification message was encrypted during transmission to protect Protected Health Information (PHI).',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the care transition event occurred (when the patient was admitted, discharged, or transferred).',
    `event_type` STRING COMMENT 'Type of care transition event that triggered the notification: admission, discharge, transfer between units, emergency department visit, observation admission, or inpatient admission.. Valid values are `admission|discharge|transfer|ed_visit|observation_admission|inpatient_admission`',
    `failure_reason` STRING COMMENT 'Description of the reason for delivery failure if the notification was not successfully delivered.',
    `message_standard` STRING COMMENT 'Interoperability standard used for the notification message: HL7 v2.x, FHIR R4, FHIR R5, CDA R2, Consolidated CDA (C-CDA), or proprietary format.. Valid values are `hl7v2|fhir_r4|fhir_r5|cda_r2|ccda|proprietary`',
    `message_type_code` STRING COMMENT 'Specific message type code from the standard (e.g., ADT^A01 for admission, ADT^A03 for discharge in HL7 v2).',
    `message_version` STRING COMMENT 'Version of the message standard used (e.g., 2.5.1 for HL7 v2, 4.0.1 for FHIR R4).',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this notification record was last modified for audit trail and change tracking.',
    `notification_content_summary` STRING COMMENT 'Brief summary of the notification content for audit and tracking purposes without including full PHI details.',
    `notification_control_number` STRING COMMENT 'Business identifier for the notification message, typically the HL7 message control ID or FHIR message identifier used for tracking and acknowledgment.',
    `notification_priority` STRING COMMENT 'Priority level assigned to the notification for delivery processing: routine, urgent, stat (immediate), or emergency.. Valid values are `routine|urgent|stat|emergency`',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Date and time when the notification was sent to the receiving party.',
    `notification_source_system` STRING COMMENT 'Name of the source system that generated the care transition notification (e.g., Epic, Cerner, MEDITECH).',
    `patient_consent_status` STRING COMMENT 'Status of patient consent for sharing care transition information with the receiving party.. Valid values are `consented|declined|not_required|pending|revoked`',
    `payload_size_bytes` BIGINT COMMENT 'Size of the notification message payload in bytes for performance monitoring and capacity planning.',
    `phi_included_flag` BOOLEAN COMMENT 'Indicates whether the notification contains Protected Health Information subject to HIPAA Privacy Rule requirements.',
    `primary_diagnosis_code` STRING COMMENT 'Primary diagnosis code (ICD-10-CM) associated with the care transition event for clinical context.',
    `primary_diagnosis_description` STRING COMMENT 'Human-readable description of the primary diagnosis for the care transition event.',
    `receiving_party_identifier` STRING COMMENT 'Identifier of the receiving party (NPI for providers, organization ID for payers/ACOs, Direct address, or FHIR endpoint identifier).',
    `receiving_party_name` STRING COMMENT 'Name of the receiving party or organization for human-readable identification.',
    `receiving_party_type` STRING COMMENT 'Type of recipient receiving the care transition notification: Primary Care Physician (PCP), specialist, payer, Accountable Care Organization (ACO), care manager, Health Information Exchange (HIE), patient, or family member. [ENUM-REF-CANDIDATE: pcp|specialist|payer|aco|care_manager|hie|patient|family_member — 8 candidates stripped; promote to reference product]',
    `sending_facility_npi` STRING COMMENT 'National Provider Identifier of the sending facility for regulatory reporting and identification.. Valid values are `^[0-9]{10}$`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the notification delivery exceeded the SLA target time, requiring escalation or remediation.',
    `sla_target_delivery_minutes` STRING COMMENT 'Target time in minutes for notification delivery per service level agreement with receiving party or regulatory requirement.',
    `transfer_from_location` STRING COMMENT 'Location or unit from which the patient was transferred when event type is transfer.',
    `transfer_to_location` STRING COMMENT 'Location or unit to which the patient was transferred when event type is transfer.',
    CONSTRAINT pk_care_transition_notification PRIMARY KEY(`care_transition_notification_id`)
) COMMENT 'Transactional record of every care transition notification (ADT notification) sent to care team members, PCPs, payers, and ACO partners when a patient is admitted, discharged, or transferred. Captures notification timestamp, event type (admission/discharge/transfer/ED visit), sending facility, receiving party type (PCP/specialist/payer/ACO), delivery channel (Direct/FHIR/HL7v2/API), delivery status, patient reference, encounter reference, and acknowledgment receipt. Supports CMS Interoperability Rule ADT notification requirements and care coordination.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` (
    `hie_transaction_id` BIGINT COMMENT 'Primary key for hie_transaction',
    `demographics_id` BIGINT COMMENT 'The unique identifier for the patient whose data is being exchanged in this transaction. May be a medical record number (MRN) or other patient identifier.',
    `hie_organization_id` BIGINT COMMENT 'Foreign key linking to interoperability.hie_organization. Business justification: HIE transactions involve specific HIE organizations (source or destination). Currently only hie_network_id (STRING) exists. FK to hie_organization enables proper organizational tracking, retrieving or',
    `interface_channel_id` BIGINT COMMENT 'Foreign key linking to interoperability.interface_channel. Business justification: HIE transactions flow through specific interface channels. Currently only interface_id (STRING) exists. Adding proper FK to interface_channel enables tracking which channel processed each transaction,',
    `mapping_rule_id` BIGINT COMMENT 'Identifier of the transformation rule or mapping configuration applied to this transaction, if any.',
    `parent_hie_transaction_id` BIGINT COMMENT 'Reference to a parent HIE transaction if this transaction is a retry, follow-up, or child transaction of another exchange.',
    `primary_related_prior_hie_transaction_id` BIGINT COMMENT 'Self-referencing FK on hie_transaction (related_hie_transaction_id)',
    `visit_id` BIGINT COMMENT 'The unique identifier for the clinical encounter or visit associated with this transaction, if applicable.',
    `acknowledgment_code` STRING COMMENT 'The acknowledgment status code received from the destination system (AA=Application Accept, AE=Application Error, AR=Application Reject, CA=Commit Accept, CE=Commit Error, CR=Commit Reject).',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'The date and time when the acknowledgment was received from the destination system.',
    `archived_timestamp` TIMESTAMP COMMENT 'The date and time when this transaction record was archived, if applicable.',
    `business_purpose` STRING COMMENT 'The business or clinical purpose for which this data exchange was performed, as defined by HIPAA permitted uses.',
    `consent_status` STRING COMMENT 'The status of patient consent for data sharing at the time of this transaction.',
    `correlation_identifier` STRING COMMENT 'Identifier used to correlate this transaction with related transactions or to link request and response messages.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this HIE transaction record was first created in the system.',
    `destination_system_code` STRING COMMENT 'Identifier of the target system or organization that is the intended recipient of the message in this HIE transaction.',
    `destination_system_name` STRING COMMENT 'Human-readable name of the destination system or facility that is receiving this transaction.',
    `direction` STRING COMMENT 'Indicates whether this transaction represents data received from an external system (inbound) or sent to an external system (outbound).',
    `endpoint_url` STRING COMMENT 'The network endpoint URL or address where the message was sent or received.',
    `error_code` STRING COMMENT 'The error code returned if the transaction failed or was rejected, indicating the specific issue encountered.',
    `error_description` STRING COMMENT 'Human-readable description of the error or rejection reason if the transaction was not successfully processed.',
    `is_archived` BOOLEAN COMMENT 'Indicates whether this transaction record has been archived for long-term retention and is no longer actively processed.',
    `message_control_number` STRING COMMENT 'Unique control identifier assigned by the sending system to track this specific message instance.',
    `message_event_code` STRING COMMENT 'The specific event or trigger code within the message standard (e.g., ADT^A01 for patient admission in HL7 v2).',
    `message_size_bytes` STRING COMMENT 'The size of the message payload in bytes for this transaction.',
    `message_standard` STRING COMMENT 'The healthcare interoperability standard used for this transaction (e.g., HL7 v2, FHIR, CDA, X12 EDI).',
    `message_version` STRING COMMENT 'The specific version of the message standard used (e.g., 2.5.1 for HL7 v2, R4 for FHIR).',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this HIE transaction record was last updated or modified.',
    `priority` STRING COMMENT 'The priority level assigned to this transaction indicating urgency of processing (routine, urgent, stat, emergency).',
    `processing_duration_ms` STRING COMMENT 'The time in milliseconds taken to process this transaction from receipt to acknowledgment.',
    `retry_count` STRING COMMENT 'The number of times this transaction has been retried after initial failure.',
    `security_classification` STRING COMMENT 'The confidentiality or security classification level of the data being exchanged in this transaction.',
    `source_system_code` STRING COMMENT 'Identifier of the originating system or organization that sent the message in this HIE transaction.',
    `source_system_name` STRING COMMENT 'Human-readable name of the source system or facility that originated this transaction.',
    `hie_transaction_status` STRING COMMENT 'Current lifecycle status of the HIE transaction indicating whether the data exchange has been successfully completed, is in progress, or encountered errors.',
    `transaction_number` STRING COMMENT 'Business-facing unique transaction number or reference code assigned to this HIE data exchange event.',
    `transaction_timestamp` TIMESTAMP COMMENT 'The date and time when the HIE transaction was initiated or the message was sent/received. Represents the principal business event time for this exchange.',
    `transaction_type` STRING COMMENT 'Classification of the HIE transaction based on the clinical or administrative event being exchanged (e.g., admission notification, lab result delivery, patient query).',
    `transformation_applied` BOOLEAN COMMENT 'Indicates whether data transformation or mapping was applied to convert the message between different standards or formats.',
    `transmission_protocol` STRING COMMENT 'The network protocol used to transmit this message (e.g., MLLP for HL7 v2, HTTPS for FHIR, Direct for secure messaging).',
    CONSTRAINT pk_hie_transaction PRIMARY KEY(`hie_transaction_id`)
) COMMENT 'Master reference table for hie_transaction. Referenced by hie_transaction_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` (
    `data_sharing_agreement_id` BIGINT COMMENT 'Primary key for data_sharing_agreement',
    `interface_engine_id` BIGINT COMMENT 'Foreign key linking to interoperability.interface_engine. Business justification: Data sharing agreements specify which interface engine configuration to use for data exchange. Currently interface_engine_configuration_id (BIGINT) exists but doesnt reference the interface_engine ta',
    `superseded_data_sharing_agreement_id` BIGINT COMMENT 'Self-referencing FK on data_sharing_agreement (superseded_data_sharing_agreement_id)',
    `trading_partner_id` BIGINT COMMENT 'Foreign key linking to interoperability.trading_partner. Business justification: Each data sharing agreement is established with a specific trading partner. Currently partner_organization_id (BIGINT) exists but doesnt reference the trading_partner table. Adding proper FK enables ',
    `agreement_name` STRING COMMENT 'Human-readable name or title of the data sharing agreement, describing the partnership or data exchange purpose.',
    `agreement_number` STRING COMMENT 'Business identifier for the data sharing agreement, used for external reference and communication with partner organizations.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the data sharing agreement, indicating whether it is operational or in a transitional state.',
    `agreement_type` STRING COMMENT 'Classification of the data sharing agreement based on the nature of the partnership and data exchange model.',
    `audit_logging_required_flag` BOOLEAN COMMENT 'Indicates whether comprehensive audit logging of data access and transmission is required under this agreement.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews unless either party provides termination notice.',
    `breach_notification_required_flag` BOOLEAN COMMENT 'Indicates whether the partner organization must notify the healthcare organization of any data breaches involving shared data.',
    `breach_notification_timeframe_hours` STRING COMMENT 'Maximum number of hours within which the partner organization must notify of a data breach.',
    `compliance_review_frequency_days` STRING COMMENT 'Number of days between scheduled compliance reviews of this data sharing agreement.',
    `consent_required_flag` BOOLEAN COMMENT 'Indicates whether explicit patient consent is required before data can be shared under this agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this data sharing agreement record was first created in the system.',
    `data_categories_shared` STRING COMMENT 'Comma-separated list or description of the types of healthcare data covered by this agreement (e.g., clinical, administrative, financial, laboratory, imaging).',
    `data_exchange_direction` STRING COMMENT 'Direction of data flow under this agreement, indicating whether data is received, sent, or exchanged in both directions.',
    `data_exchange_standard` STRING COMMENT 'Primary healthcare data standard or protocol used for data exchange under this agreement.',
    `data_quality_standards` STRING COMMENT 'Documented data quality requirements and standards that shared data must meet (e.g., completeness, accuracy, timeliness).',
    `data_retention_period_days` STRING COMMENT 'Number of days the receiving organization is permitted to retain the shared data before it must be destroyed or returned.',
    `data_use_restrictions` STRING COMMENT 'Documented restrictions or limitations on how the receiving organization may use the shared data.',
    `effective_date` DATE COMMENT 'Date when the data sharing agreement becomes legally binding and operational for data exchange activities.',
    `encryption_required_flag` BOOLEAN COMMENT 'Indicates whether data must be encrypted during transmission and at rest as a condition of this agreement.',
    `expiration_date` DATE COMMENT 'Date when the data sharing agreement terminates or requires renewal. Nullable for agreements with no defined end date.',
    `hipaa_business_associate_flag` BOOLEAN COMMENT 'Indicates whether the partner organization is classified as a HIPAA Business Associate, requiring a Business Associate Agreement.',
    `last_compliance_review_date` DATE COMMENT 'Date of the most recent compliance review conducted for this data sharing agreement.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this data sharing agreement record was last modified in the system.',
    `legal_basis` STRING COMMENT 'Legal or regulatory framework authorizing the data sharing (e.g., HIPAA, 42 CFR Part 2, state law, patient consent).',
    `next_compliance_review_date` DATE COMMENT 'Scheduled date for the next compliance review of this data sharing agreement.',
    `notes` STRING COMMENT 'Additional notes, comments, or special considerations related to this data sharing agreement.',
    `partner_contact_email` STRING COMMENT 'Email address of the primary contact person at the partner organization for this data sharing agreement.',
    `partner_contact_name` STRING COMMENT 'Name of the primary contact person at the partner organization for this data sharing agreement.',
    `partner_contact_phone` STRING COMMENT 'Phone number of the primary contact person at the partner organization for this data sharing agreement.',
    `phi_included_flag` BOOLEAN COMMENT 'Indicates whether Protected Health Information is included in the data shared under this agreement, requiring HIPAA compliance.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary internal contact person for this data sharing agreement.',
    `primary_contact_name` STRING COMMENT 'Name of the primary internal contact person responsible for this data sharing agreement.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary internal contact person for this data sharing agreement.',
    `purpose_of_use` STRING COMMENT 'Documented business purpose for which data is shared under this agreement (e.g., treatment, care coordination, quality reporting, research).',
    `renewal_notification_days` STRING COMMENT 'Number of days before expiration that stakeholders should be notified for agreement renewal consideration.',
    `responsible_department` STRING COMMENT 'Internal department or business unit responsible for managing and maintaining this data sharing agreement.',
    `security_requirements` STRING COMMENT 'Documented security controls and safeguards required for data transmission and storage under this agreement.',
    `termination_date` DATE COMMENT 'Actual date when the data sharing agreement was terminated, if applicable.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the data sharing agreement.',
    `termination_reason` STRING COMMENT 'Documented reason for termination of the data sharing agreement, if applicable.',
    `transmission_frequency` STRING COMMENT 'Expected frequency or schedule for data transmission under this agreement.',
    `transmission_method` STRING COMMENT 'Technical method or protocol used to transmit data between organizations under this agreement.',
    CONSTRAINT pk_data_sharing_agreement PRIMARY KEY(`data_sharing_agreement_id`)
) COMMENT 'Master reference table for data_sharing_agreement. Referenced by data_sharing_agreement_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` (
    `hie_organization_id` BIGINT COMMENT 'Primary key for hie_organization',
    `parent_hie_organization_id` BIGINT COMMENT 'Self-referencing FK on hie_organization (parent_hie_organization_id)',
    `address_line_1` STRING COMMENT 'The first line of the organizations physical address, typically containing street number and name.',
    `address_line_2` STRING COMMENT 'The second line of the organizations physical address, typically containing suite, floor, or building information.',
    `authentication_method` STRING COMMENT 'The authentication mechanism required to connect to the organizations HIE endpoint.',
    `carequality_participant` BOOLEAN COMMENT 'Indicates whether the organization is a participant in the Carequality interoperability framework.',
    `certification_date` DATE COMMENT 'The date when the organization received its current health information exchange certification.',
    `certification_expiry_date` DATE COMMENT 'The date when the organizations health information exchange certification expires.',
    `certification_status` STRING COMMENT 'The current certification status of the organization for health information exchange capabilities.',
    `city` STRING COMMENT 'The city where the HIE organization is located.',
    `commonwell_participant` BOOLEAN COMMENT 'Indicates whether the organization is a member of the CommonWell Health Alliance network.',
    `country_code` STRING COMMENT 'The three-letter ISO country code where the HIE organization is located.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this HIE organization record was first created in the system.',
    `data_sharing_agreement_date` DATE COMMENT 'The date when the data sharing agreement was signed with this HIE organization.',
    `data_sharing_agreement_expiry_date` DATE COMMENT 'The date when the data sharing agreement with this HIE organization expires and requires renewal.',
    `data_sharing_agreement_signed` BOOLEAN COMMENT 'Indicates whether a formal data sharing agreement has been executed with this HIE organization.',
    `direct_trust_bundle_enabled` BOOLEAN COMMENT 'Indicates whether the organization participates in the Direct Trust network for secure health information exchange.',
    `endpoint_protocol` STRING COMMENT 'The communication protocol used by the organizations HIE endpoint for data exchange.',
    `endpoint_url` STRING COMMENT 'The primary technical endpoint URL for connecting to the organizations HIE services and data exchange interfaces.',
    `hipaa_compliant` BOOLEAN COMMENT 'Indicates whether the HIE organization has been verified as HIPAA compliant for protected health information exchange.',
    `interface_engine_type` STRING COMMENT 'The type or vendor of the interface engine used by the organization for health data exchange (e.g., Rhapsody, Mirth Connect, Cloverleaf, Ensemble).',
    `is_active` BOOLEAN COMMENT 'Indicates whether this HIE organization record is currently active and available for data exchange operations.',
    `last_successful_exchange_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent successful data exchange with this HIE organization.',
    `message_volume_monthly_avg` BIGINT COMMENT 'The average number of interoperability messages exchanged with this organization per month.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this HIE organization record was last modified.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about the HIE organization, including special configuration requirements or operational considerations.',
    `organization_identifier` STRING COMMENT 'The externally-known unique identifier for the HIE organization, such as National Provider Identifier (NPI), Tax ID (TIN), or other registry identifier.',
    `organization_name` STRING COMMENT 'The official legal name of the HIE organization or health information exchange entity.',
    `organization_type` STRING COMMENT 'Classification of the HIE organization indicating the type of healthcare entity participating in health information exchange.',
    `participation_end_date` DATE COMMENT 'The date when the organizations participation in the health information exchange ended or is scheduled to end. Null for ongoing participation.',
    `participation_start_date` DATE COMMENT 'The date when the organization began participating in the health information exchange.',
    `participation_status` STRING COMMENT 'Current lifecycle status of the organizations participation in the health information exchange network.',
    `postal_code` STRING COMMENT 'The postal or ZIP code of the organizations address.',
    `primary_contact_email` STRING COMMENT 'The email address of the primary contact person for HIE coordination and technical communication.',
    `primary_contact_name` STRING COMMENT 'The name of the primary contact person at the HIE organization responsible for interoperability coordination.',
    `primary_contact_phone` STRING COMMENT 'The phone number of the primary contact person for HIE coordination and support.',
    `state_province` STRING COMMENT 'The state or province where the HIE organization is located.',
    `supported_cda_versions` STRING COMMENT 'Comma-separated list of CDA document standard versions supported by this organization for clinical document exchange (e.g., CDA R2, C-CDA R1.1, C-CDA R2.1).',
    `supported_fhir_versions` STRING COMMENT 'Comma-separated list of FHIR standard versions supported by this organization for interoperability (e.g., DSTU2, STU3, R4, R5).',
    `supported_hl7v2_versions` STRING COMMENT 'Comma-separated list of HL7v2 message standard versions supported by this organization for interoperability (e.g., 2.3, 2.5.1, 2.7).',
    `tefca_qhin_participant` BOOLEAN COMMENT 'Indicates whether the organization participates in TEFCA as a Qualified Health Information Network or through a QHIN.',
    CONSTRAINT pk_hie_organization PRIMARY KEY(`hie_organization_id`)
) COMMENT 'Master reference table for hie_organization. Referenced by hie_organization_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` (
    `mapping_definition_id` BIGINT COMMENT 'Primary key for mapping_definition',
    `primary_superseded_by_mapping_definition_id` BIGINT COMMENT 'Reference to the newer mapping definition that replaces this one when this mapping is deprecated or retired.',
    `exchange_standard_id` BIGINT COMMENT 'Foreign key linking to interoperability.exchange_standard. Business justification: Mapping definitions transform data from a source exchange standard. Currently only source_standard (STRING) exists. FK to exchange_standard enables proper standard version tracking, managing standard-',
    `approval_date` DATE COMMENT 'The date when this mapping definition received formal approval for production use.',
    `approval_status` STRING COMMENT 'Current approval state in the governance workflow: pending (awaiting review), approved (authorized for use), rejected (not approved), under_review (in evaluation).',
    `approved_by` STRING COMMENT 'Name or identifier of the person or committee who approved this mapping definition for production use.',
    `bidirectional_flag` BOOLEAN COMMENT 'Indicates whether this mapping definition can be applied in both directions (source to target and target to source). True if bidirectional, false if unidirectional.',
    `cardinality_source` STRING COMMENT 'The cardinality constraint of the source element (e.g., 0..1, 1..1, 0..*, 1..*) indicating minimum and maximum occurrences.',
    `cardinality_target` STRING COMMENT 'The cardinality constraint of the target element (e.g., 0..1, 1..1, 0..*, 1..*) indicating minimum and maximum occurrences.',
    `change_reason` STRING COMMENT 'Explanation of why this mapping definition was created or modified, including references to change requests or regulatory requirements.',
    `complexity_score` STRING COMMENT 'Numeric score (1-10) indicating the complexity of the transformation logic, used for resource planning and maintenance prioritization.',
    `conditional_logic` STRING COMMENT 'Boolean or conditional expression that determines when this mapping rule should be applied. May reference other field values or business rules.',
    `contact_information` STRING COMMENT 'Contact details (email, phone, or team name) for the subject matter expert or team responsible for this mapping definition.',
    `copyright_notice` STRING COMMENT 'Legal copyright statement or intellectual property notice associated with this mapping definition.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this mapping definition record was first created in the system.',
    `default_value` DECIMAL(18,2) COMMENT 'The default value to be used when the source element is null, missing, or does not meet transformation conditions.',
    `documentation_url` STRING COMMENT 'Web address or file path to detailed technical documentation, implementation guides, or specification documents for this mapping.',
    `effective_end_date` DATE COMMENT 'The date when this mapping definition is no longer valid or has been superseded by a newer version. Null indicates no planned end date.',
    `effective_start_date` DATE COMMENT 'The date when this mapping definition becomes active and available for use in data transformation processes.',
    `equivalence_type` STRING COMMENT 'Describes the semantic relationship between source and target concepts: equivalent (same meaning), equal (identical), wider (target is broader), subsumes (target includes source), narrower (target is more specific), specializes (target refines source), inexact (approximate match), unmatched (no correspondence), disjoint (mutually exclusive).',
    `error_handling_strategy` STRING COMMENT 'Defines the action to take when mapping transformation fails: fail (halt processing), warn (log warning and continue), skip (omit element), default (use default value), retry (attempt again), log (record error and continue).',
    `experimental_flag` BOOLEAN COMMENT 'Indicates whether this mapping definition is experimental and not yet approved for production use. True if experimental, false if production-ready.',
    `jurisdiction` STRING COMMENT 'Geographic or regulatory jurisdiction where this mapping definition applies (e.g., USA, CAN, EUR). Uses ISO 3166-1 alpha-3 country codes.',
    `last_review_date` DATE COMMENT 'The date when this mapping definition was last reviewed for accuracy, relevance, and compliance with current standards.',
    `mapping_code` STRING COMMENT 'Unique business code or identifier for the mapping definition, used for external reference and system integration.',
    `mapping_name` STRING COMMENT 'Human-readable name of the data mapping definition used for identification and reference purposes.',
    `mapping_status` STRING COMMENT 'Current lifecycle status of the mapping definition: draft (under development), active (in production use), deprecated (scheduled for retirement), retired (no longer used), testing (under validation).',
    `mapping_type` STRING COMMENT 'Classification of the mapping definition by its transformation approach: conceptual (high-level business concept alignment), structural (data structure transformation), semantic (meaning preservation), syntactic (format conversion), value_set (enumeration mapping), or code_system (terminology mapping).',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this mapping definition record was last modified or updated.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review of this mapping definition.',
    `priority_order` STRING COMMENT 'Numeric value indicating the execution order or priority when multiple mapping rules apply to the same element. Lower numbers execute first.',
    `publisher_organization` STRING COMMENT 'The organization or department responsible for authoring, maintaining, and publishing this mapping definition.',
    `purpose_description` STRING COMMENT 'Detailed explanation of why this mapping definition exists and what business or clinical need it addresses.',
    `source_data_type` STRING COMMENT 'The data type of the source element as defined in the source standard (e.g., XPN, CodeableConcept, string, dateTime).',
    `source_element_path` STRING COMMENT 'The hierarchical path or location of the source data element within the source standard structure (e.g., PID-5 for HL7v2, Patient.name for FHIR).',
    `source_standard` STRING COMMENT 'The healthcare data standard or format of the source system from which data is being mapped. Examples include HL7v2, FHIR, CDA, X12, DICOM, or custom proprietary formats.',
    `source_version` STRING COMMENT 'Version number or release identifier of the source data standard (e.g., HL7v2.5.1, FHIR R4, CDA R2).',
    `target_data_type` STRING COMMENT 'The data type of the target element as defined in the target standard (e.g., XPN, CodeableConcept, string, dateTime).',
    `target_element_path` STRING COMMENT 'The hierarchical path or location of the target data element within the target standard structure (e.g., PID-5 for HL7v2, Patient.name for FHIR).',
    `target_standard` STRING COMMENT 'The healthcare data standard or format of the target system to which data is being mapped. Examples include HL7v2, FHIR, CDA, X12, DICOM, or custom proprietary formats.',
    `target_version` STRING COMMENT 'Version number or release identifier of the target data standard (e.g., HL7v2.5.1, FHIR R4, CDA R2).',
    `test_case_reference` STRING COMMENT 'Reference identifier or URL to the test cases and validation scenarios used to verify this mapping definition.',
    `transformation_rule` STRING COMMENT 'The technical expression, formula, or logic that defines how source data is transformed into target data. May include concatenation, splitting, date format conversion, unit conversion, or conditional logic.',
    `use_context` STRING COMMENT 'Description of the clinical, operational, or business context in which this mapping is intended to be used (e.g., inpatient admissions, lab results, claims processing).',
    `validation_rule` STRING COMMENT 'Expression or constraint that validates the transformed data meets target system requirements before transmission. May include format checks, range validation, or business rule validation.',
    `version_number` STRING COMMENT 'Version identifier for this mapping definition, following semantic versioning or organizational versioning standards.',
    CONSTRAINT pk_mapping_definition PRIMARY KEY(`mapping_definition_id`)
) COMMENT 'Master reference table for mapping_definition. Referenced by mapping_definition_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` (
    `data_use_agreement_id` BIGINT COMMENT 'Primary key for data_use_agreement',
    `employee_id` BIGINT COMMENT 'Identifier of the healthcare organizations compliance officer responsible for oversight of this agreement.',
    `superseded_data_use_agreement_id` BIGINT COMMENT 'Self-referencing FK on data_use_agreement (superseded_data_use_agreement_id)',
    `trading_partner_id` BIGINT COMMENT 'Foreign key linking to interoperability.trading_partner. Business justification: Data use agreements govern data exchange with specific trading partners (research institutions, public health agencies). FK to trading_partner enables tracking agreements by partner, managing partner-',
    `agreement_name` STRING COMMENT 'Human-readable name or title of the data use agreement.',
    `agreement_number` STRING COMMENT 'Externally-known business identifier for the data use agreement, typically formatted as DUA-NNNNNN.',
    `agreement_type` STRING COMMENT 'Classification of the data use agreement based on the type of data sharing and purpose.',
    `amendment_count` STRING COMMENT 'Number of amendments made to this data use agreement since its original execution.',
    `audit_rights` STRING COMMENT 'Description of the healthcare organizations rights to audit the recipients use and protection of the shared data.',
    `auto_renewal` BOOLEAN COMMENT 'Indicates whether this agreement automatically renews unless terminated by either party.',
    `breach_notification_required` BOOLEAN COMMENT 'Indicates whether the recipient must notify the healthcare organization of any data breach or unauthorized disclosure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this data use agreement record was first created in the system.',
    `data_classification` STRING COMMENT 'Classification of the data being shared under this agreement based on identifiability.',
    `data_destruction_required` BOOLEAN COMMENT 'Indicates whether the recipient is required to destroy or return the data at the end of the agreement.',
    `data_format` STRING COMMENT 'Standard format in which data will be provided to the recipient.',
    `data_purpose` STRING COMMENT 'Detailed description of the permitted purpose for which the recipient may use the shared data.',
    `data_retention_period_days` STRING COMMENT 'Maximum number of days the recipient is permitted to retain the shared data.',
    `data_scope` STRING COMMENT 'Description of the specific data elements, datasets, or data categories covered by this agreement.',
    `data_transfer_method` STRING COMMENT 'Technical method by which data will be transferred to the recipient organization.',
    `effective_date` DATE COMMENT 'Date when the data use agreement becomes legally binding and data sharing may commence.',
    `expiration_date` DATE COMMENT 'Date when the data use agreement terminates. Nullable for agreements without a fixed end date.',
    `governing_law` STRING COMMENT 'Legal jurisdiction and governing law that applies to this data use agreement.',
    `irb_approval_date` DATE COMMENT 'Date when IRB approval was granted for this data use. Nullable if not applicable.',
    `irb_approval_number` STRING COMMENT 'IRB approval number if the data use is for research purposes requiring IRB oversight. Nullable if not applicable.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment to this agreement. Nullable if never amended.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this data use agreement record was last modified in the system.',
    `legal_review_completed` BOOLEAN COMMENT 'Indicates whether legal review of this agreement has been completed by the healthcare organizations legal department.',
    `legal_review_date` DATE COMMENT 'Date when legal review of this agreement was completed. Nullable if not yet reviewed.',
    `notes` STRING COMMENT 'Additional notes, comments, or special conditions related to this data use agreement.',
    `permitted_disclosures` STRING COMMENT 'Description of any permitted further disclosures or sub-sharing allowed under this agreement.',
    `prohibited_uses` STRING COMMENT 'Explicit description of uses or disclosures that are prohibited under this agreement.',
    `recipient_contact_email` STRING COMMENT 'Email address of the primary contact person at the recipient organization.',
    `recipient_contact_name` STRING COMMENT 'Full name of the primary contact person at the recipient organization responsible for this agreement.',
    `recipient_contact_phone` STRING COMMENT 'Phone number of the primary contact person at the recipient organization.',
    `renewal_eligible` BOOLEAN COMMENT 'Indicates whether this agreement is eligible for renewal upon expiration.',
    `security_requirements` STRING COMMENT 'Description of security safeguards and controls the recipient must implement to protect the shared data.',
    `signature_date_healthcare` DATE COMMENT 'Date when the healthcare organizations authorized representative signed the agreement.',
    `signature_date_recipient` DATE COMMENT 'Date when the recipient organizations authorized representative signed the agreement.',
    `signed_by_healthcare` STRING COMMENT 'Full name of the authorized representative who signed this agreement on behalf of the healthcare organization.',
    `signed_by_recipient` STRING COMMENT 'Full name of the authorized representative who signed this agreement on behalf of the recipient organization.',
    `data_use_agreement_status` STRING COMMENT 'Current lifecycle status of the data use agreement.',
    `termination_date` DATE COMMENT 'Actual date when the agreement was terminated, if terminated before expiration date. Nullable if not terminated.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required for either party to terminate the agreement.',
    `transfer_frequency` STRING COMMENT 'Frequency at which data will be transferred to the recipient under this agreement.',
    CONSTRAINT pk_data_use_agreement PRIMARY KEY(`data_use_agreement_id`)
) COMMENT 'Master reference table for data_use_agreement. Referenced by data_use_agreement_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ADD CONSTRAINT `fk_interoperability_exchange_standard_superseded_exchange_standard_id` FOREIGN KEY (`superseded_exchange_standard_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`exchange_standard`(`exchange_standard_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ADD CONSTRAINT `fk_interoperability_trading_partner_interface_engine_id` FOREIGN KEY (`interface_engine_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_engine`(`interface_engine_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ADD CONSTRAINT `fk_interoperability_trading_partner_parent_trading_partner_id` FOREIGN KEY (`parent_trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ADD CONSTRAINT `fk_interoperability_interface_engine_replaced_interface_engine_id` FOREIGN KEY (`replaced_interface_engine_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_engine`(`interface_engine_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ADD CONSTRAINT `fk_interoperability_interface_channel_exchange_standard_id` FOREIGN KEY (`exchange_standard_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`exchange_standard`(`exchange_standard_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ADD CONSTRAINT `fk_interoperability_interface_channel_interface_engine_id` FOREIGN KEY (`interface_engine_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_engine`(`interface_engine_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ADD CONSTRAINT `fk_interoperability_interface_channel_replaced_interface_channel_id` FOREIGN KEY (`replaced_interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ADD CONSTRAINT `fk_interoperability_interface_channel_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ADD CONSTRAINT `fk_interoperability_message_log_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ADD CONSTRAINT `fk_interoperability_message_log_mapping_rule_id` FOREIGN KEY (`mapping_rule_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`mapping_rule`(`mapping_rule_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ADD CONSTRAINT `fk_interoperability_message_log_original_message_log_id` FOREIGN KEY (`original_message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ADD CONSTRAINT `fk_interoperability_message_error_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ADD CONSTRAINT `fk_interoperability_message_error_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ADD CONSTRAINT `fk_interoperability_message_error_related_prior_message_error_id` FOREIGN KEY (`related_prior_message_error_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_error`(`message_error_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ADD CONSTRAINT `fk_interoperability_fhir_endpoint_data_sharing_agreement_id` FOREIGN KEY (`data_sharing_agreement_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement`(`data_sharing_agreement_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ADD CONSTRAINT `fk_interoperability_fhir_endpoint_superseded_fhir_endpoint_id` FOREIGN KEY (`superseded_fhir_endpoint_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint`(`fhir_endpoint_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ADD CONSTRAINT `fk_interoperability_fhir_endpoint_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ADD CONSTRAINT `fk_interoperability_fhir_resource_log_fhir_endpoint_id` FOREIGN KEY (`fhir_endpoint_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint`(`fhir_endpoint_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ADD CONSTRAINT `fk_interoperability_fhir_resource_log_related_prior_fhir_resource_log_id` FOREIGN KEY (`related_prior_fhir_resource_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log`(`fhir_resource_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ADD CONSTRAINT `fk_interoperability_mapping_rule_fallback_mapping_rule_id` FOREIGN KEY (`fallback_mapping_rule_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`mapping_rule`(`mapping_rule_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ADD CONSTRAINT `fk_interoperability_mapping_rule_mapping_definition_id` FOREIGN KEY (`mapping_definition_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`mapping_definition`(`mapping_definition_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ADD CONSTRAINT `fk_interoperability_mapping_rule_exchange_standard_id` FOREIGN KEY (`exchange_standard_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`exchange_standard`(`exchange_standard_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ADD CONSTRAINT `fk_interoperability_hie_participation_hie_organization_id` FOREIGN KEY (`hie_organization_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`hie_organization`(`hie_organization_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ADD CONSTRAINT `fk_interoperability_hie_participation_interface_engine_id` FOREIGN KEY (`interface_engine_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_engine`(`interface_engine_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ADD CONSTRAINT `fk_interoperability_hie_participation_renewed_hie_participation_id` FOREIGN KEY (`renewed_hie_participation_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`hie_participation`(`hie_participation_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ADD CONSTRAINT `fk_interoperability_hie_query_follow_up_hie_query_id` FOREIGN KEY (`follow_up_hie_query_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`hie_query`(`hie_query_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ADD CONSTRAINT `fk_interoperability_hie_query_hie_organization_id` FOREIGN KEY (`hie_organization_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`hie_organization`(`hie_organization_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ADD CONSTRAINT `fk_interoperability_hie_query_hie_participation_id` FOREIGN KEY (`hie_participation_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`hie_participation`(`hie_participation_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ADD CONSTRAINT `fk_interoperability_hie_query_interface_engine_id` FOREIGN KEY (`interface_engine_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_engine`(`interface_engine_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_superseded_cda_document_id` FOREIGN KEY (`superseded_cda_document_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ADD CONSTRAINT `fk_interoperability_cda_document_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ADD CONSTRAINT `fk_interoperability_cda_validation_result_cda_document_id` FOREIGN KEY (`cda_document_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`cda_document`(`cda_document_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ADD CONSTRAINT `fk_interoperability_cda_validation_result_revalidated_cda_validation_result_id` FOREIGN KEY (`revalidated_cda_validation_result_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`cda_validation_result`(`cda_validation_result_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ADD CONSTRAINT `fk_interoperability_cda_validation_result_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ADD CONSTRAINT `fk_interoperability_patient_identity_match_hie_organization_id` FOREIGN KEY (`hie_organization_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`hie_organization`(`hie_organization_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ADD CONSTRAINT `fk_interoperability_patient_identity_match_superseded_patient_identity_match_id` FOREIGN KEY (`superseded_patient_identity_match_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`patient_identity_match`(`patient_identity_match_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ADD CONSTRAINT `fk_interoperability_direct_message_interface_engine_id` FOREIGN KEY (`interface_engine_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_engine`(`interface_engine_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ADD CONSTRAINT `fk_interoperability_direct_message_replied_to_direct_message_id` FOREIGN KEY (`replied_to_direct_message_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`direct_message`(`direct_message_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ADD CONSTRAINT `fk_interoperability_direct_message_direct_address_id` FOREIGN KEY (`direct_address_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`direct_address`(`direct_address_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ADD CONSTRAINT `fk_interoperability_direct_message_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ADD CONSTRAINT `fk_interoperability_direct_address_replaced_direct_address_id` FOREIGN KEY (`replaced_direct_address_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`direct_address`(`direct_address_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ADD CONSTRAINT `fk_interoperability_interface_sla_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ADD CONSTRAINT `fk_interoperability_interface_sla_superseded_interface_sla_id` FOREIGN KEY (`superseded_interface_sla_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_sla`(`interface_sla_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ADD CONSTRAINT `fk_interoperability_interface_sla_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ADD CONSTRAINT `fk_interoperability_interface_downtime_fhir_endpoint_id` FOREIGN KEY (`fhir_endpoint_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint`(`fhir_endpoint_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ADD CONSTRAINT `fk_interoperability_interface_downtime_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ADD CONSTRAINT `fk_interoperability_interface_downtime_interface_engine_id` FOREIGN KEY (`interface_engine_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_engine`(`interface_engine_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ADD CONSTRAINT `fk_interoperability_interface_downtime_related_prior_interface_downtime_id` FOREIGN KEY (`related_prior_interface_downtime_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_downtime`(`interface_downtime_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ADD CONSTRAINT `fk_interoperability_interface_downtime_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ADD CONSTRAINT `fk_interoperability_terminology_mapping_primary_superseded_by_terminology_mapping_id` FOREIGN KEY (`primary_superseded_by_terminology_mapping_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`terminology_mapping`(`terminology_mapping_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ADD CONSTRAINT `fk_interoperability_terminology_mapping_exchange_standard_id` FOREIGN KEY (`exchange_standard_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`exchange_standard`(`exchange_standard_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ADD CONSTRAINT `fk_interoperability_subscription_topic_exchange_standard_id` FOREIGN KEY (`exchange_standard_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`exchange_standard`(`exchange_standard_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ADD CONSTRAINT `fk_interoperability_subscription_topic_interface_engine_id` FOREIGN KEY (`interface_engine_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_engine`(`interface_engine_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ADD CONSTRAINT `fk_interoperability_subscription_topic_superseded_subscription_topic_id` FOREIGN KEY (`superseded_subscription_topic_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`subscription_topic`(`subscription_topic_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ADD CONSTRAINT `fk_interoperability_subscription_topic_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ADD CONSTRAINT `fk_interoperability_subscription_notification_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ADD CONSTRAINT `fk_interoperability_subscription_notification_interface_engine_id` FOREIGN KEY (`interface_engine_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_engine`(`interface_engine_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ADD CONSTRAINT `fk_interoperability_subscription_notification_retried_subscription_notification_id` FOREIGN KEY (`retried_subscription_notification_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`subscription_notification`(`subscription_notification_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ADD CONSTRAINT `fk_interoperability_subscription_notification_subscription_topic_id` FOREIGN KEY (`subscription_topic_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`subscription_topic`(`subscription_topic_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ADD CONSTRAINT `fk_interoperability_onboarding_project_exchange_standard_id` FOREIGN KEY (`exchange_standard_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`exchange_standard`(`exchange_standard_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ADD CONSTRAINT `fk_interoperability_onboarding_project_interface_engine_id` FOREIGN KEY (`interface_engine_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_engine`(`interface_engine_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ADD CONSTRAINT `fk_interoperability_onboarding_project_predecessor_onboarding_project_id` FOREIGN KEY (`predecessor_onboarding_project_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`onboarding_project`(`onboarding_project_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ADD CONSTRAINT `fk_interoperability_onboarding_project_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ADD CONSTRAINT `fk_interoperability_conformance_test_exchange_standard_id` FOREIGN KEY (`exchange_standard_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`exchange_standard`(`exchange_standard_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ADD CONSTRAINT `fk_interoperability_conformance_test_fhir_endpoint_id` FOREIGN KEY (`fhir_endpoint_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint`(`fhir_endpoint_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ADD CONSTRAINT `fk_interoperability_conformance_test_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ADD CONSTRAINT `fk_interoperability_conformance_test_onboarding_project_id` FOREIGN KEY (`onboarding_project_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`onboarding_project`(`onboarding_project_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ADD CONSTRAINT `fk_interoperability_conformance_test_retest_conformance_test_id` FOREIGN KEY (`retest_conformance_test_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`conformance_test`(`conformance_test_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ADD CONSTRAINT `fk_interoperability_conformance_test_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ADD CONSTRAINT `fk_interoperability_promoting_interoperability_prior_promoting_interoperability_id` FOREIGN KEY (`prior_promoting_interoperability_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability`(`promoting_interoperability_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ADD CONSTRAINT `fk_interoperability_public_health_report_corrected_public_health_report_id` FOREIGN KEY (`corrected_public_health_report_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`public_health_report`(`public_health_report_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ADD CONSTRAINT `fk_interoperability_public_health_report_data_use_agreement_id` FOREIGN KEY (`data_use_agreement_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`data_use_agreement`(`data_use_agreement_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ADD CONSTRAINT `fk_interoperability_public_health_report_exchange_standard_id` FOREIGN KEY (`exchange_standard_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`exchange_standard`(`exchange_standard_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ADD CONSTRAINT `fk_interoperability_public_health_report_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ADD CONSTRAINT `fk_interoperability_public_health_report_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ADD CONSTRAINT `fk_interoperability_care_transition_notification_hie_transaction_id` FOREIGN KEY (`hie_transaction_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`hie_transaction`(`hie_transaction_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ADD CONSTRAINT `fk_interoperability_care_transition_notification_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ADD CONSTRAINT `fk_interoperability_care_transition_notification_direct_address_id` FOREIGN KEY (`direct_address_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`direct_address`(`direct_address_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ADD CONSTRAINT `fk_interoperability_care_transition_notification_superseded_care_transition_notification_id` FOREIGN KEY (`superseded_care_transition_notification_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`care_transition_notification`(`care_transition_notification_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ADD CONSTRAINT `fk_interoperability_hie_transaction_hie_organization_id` FOREIGN KEY (`hie_organization_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`hie_organization`(`hie_organization_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ADD CONSTRAINT `fk_interoperability_hie_transaction_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ADD CONSTRAINT `fk_interoperability_hie_transaction_mapping_rule_id` FOREIGN KEY (`mapping_rule_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`mapping_rule`(`mapping_rule_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ADD CONSTRAINT `fk_interoperability_hie_transaction_parent_hie_transaction_id` FOREIGN KEY (`parent_hie_transaction_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`hie_transaction`(`hie_transaction_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ADD CONSTRAINT `fk_interoperability_hie_transaction_primary_related_prior_hie_transaction_id` FOREIGN KEY (`primary_related_prior_hie_transaction_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`hie_transaction`(`hie_transaction_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ADD CONSTRAINT `fk_interoperability_data_sharing_agreement_interface_engine_id` FOREIGN KEY (`interface_engine_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_engine`(`interface_engine_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ADD CONSTRAINT `fk_interoperability_data_sharing_agreement_superseded_data_sharing_agreement_id` FOREIGN KEY (`superseded_data_sharing_agreement_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement`(`data_sharing_agreement_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ADD CONSTRAINT `fk_interoperability_data_sharing_agreement_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ADD CONSTRAINT `fk_interoperability_hie_organization_parent_hie_organization_id` FOREIGN KEY (`parent_hie_organization_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`hie_organization`(`hie_organization_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ADD CONSTRAINT `fk_interoperability_mapping_definition_primary_superseded_by_mapping_definition_id` FOREIGN KEY (`primary_superseded_by_mapping_definition_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`mapping_definition`(`mapping_definition_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ADD CONSTRAINT `fk_interoperability_mapping_definition_exchange_standard_id` FOREIGN KEY (`exchange_standard_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`exchange_standard`(`exchange_standard_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ADD CONSTRAINT `fk_interoperability_data_use_agreement_superseded_data_use_agreement_id` FOREIGN KEY (`superseded_data_use_agreement_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`data_use_agreement`(`data_use_agreement_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ADD CONSTRAINT `fk_interoperability_data_use_agreement_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`interoperability` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`interoperability` SET TAGS ('dbx_domain' = 'interoperability');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` SET TAGS ('dbx_subdomain' = 'interface_integration');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `exchange_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Standard Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `superseded_exchange_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Exchange Standard Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `superseded_exchange_standard_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `backward_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Backward Compatibility Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending|not_required|failed');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `character_set` SET TAGS ('dbx_business_glossary_term' = 'Character Set');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `conformance_profile` SET TAGS ('dbx_business_glossary_term' = 'Conformance Profile');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `contact_person` SET TAGS ('dbx_business_glossary_term' = 'Contact Person');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `encoding_format` SET TAGS ('dbx_business_glossary_term' = 'Encoding Format');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `encoding_format` SET TAGS ('dbx_value_regex' = 'pipe_delimited|xml|json|edi|binary');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `hie_participation` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange (HIE) Participation');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `interface_engine_support` SET TAGS ('dbx_business_glossary_term' = 'Interface Engine Support');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `message_types_supported` SET TAGS ('dbx_business_glossary_term' = 'Message Types Supported');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `message_types_supported` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `migration_path` SET TAGS ('dbx_business_glossary_term' = 'Migration Path');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `resource_types_supported` SET TAGS ('dbx_business_glossary_term' = 'Resource Types Supported');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `security_profile` SET TAGS ('dbx_business_glossary_term' = 'Security Profile');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `specification_url` SET TAGS ('dbx_business_glossary_term' = 'Specification Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `standard_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `standard_name` SET TAGS ('dbx_business_glossary_term' = 'Standard Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `standard_type` SET TAGS ('dbx_business_glossary_term' = 'Standard Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `standard_type` SET TAGS ('dbx_value_regex' = 'messaging|document|transaction|imaging|api');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `exchange_standard_status` SET TAGS ('dbx_business_glossary_term' = 'Standard Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `exchange_standard_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|retired|planned|testing');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `terminology_binding` SET TAGS ('dbx_business_glossary_term' = 'Terminology Binding');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `testing_tool` SET TAGS ('dbx_business_glossary_term' = 'Testing Tool');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `transport_protocol` SET TAGS ('dbx_business_glossary_term' = 'Transport Protocol');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `use_case_description` SET TAGS ('dbx_business_glossary_term' = 'Use Case Description');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `validation_rules` SET TAGS ('dbx_business_glossary_term' = 'Validation Rules');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Standard Version');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` SET TAGS ('dbx_subdomain' = 'interface_integration');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `interface_engine_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Engine Configuration Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `parent_trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Trading Partner Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `parent_trading_partner_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `cda_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Clinical Document Architecture (CDA) Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `certification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'not_certified|in_certification|certified|expired');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `data_sharing_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Agreement Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `data_transformation_mapping_reference` SET TAGS ('dbx_business_glossary_term' = 'Data Transformation Mapping Reference');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `direct_address` SET TAGS ('dbx_business_glossary_term' = 'Direct Secure Messaging Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `direct_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `direct_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `exchange_volume_last_30_days` SET TAGS ('dbx_business_glossary_term' = 'Exchange Volume Last 30 Days');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `fhir_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `hie_network_name` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange (HIE) Network Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `hie_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange (HIE) Participation Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `hl7v2_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Health Level Seven Version 2 (HL7v2) Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `last_successful_exchange_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Successful Exchange Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `message_tracking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Message Tracking Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `message_tracking_enabled_flag` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `oid` SET TAGS ('dbx_business_glossary_term' = 'Object Identifier (OID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'planning|in_progress|testing|active|suspended|terminated');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Operational Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Operational Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Operational Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `partner_name` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time Hours');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `supported_standards` SET TAGS ('dbx_business_glossary_term' = 'Supported Interoperability Standards');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Technical Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Technical Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Technical Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` SET TAGS ('dbx_subdomain' = 'interface_integration');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `interface_engine_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Engine ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `replaced_interface_engine_id` SET TAGS ('dbx_business_glossary_term' = 'Replaced Interface Engine Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `replaced_interface_engine_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `admin_url` SET TAGS ('dbx_business_glossary_term' = 'Administration URL');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `admin_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `audit_logging_enabled` SET TAGS ('dbx_business_glossary_term' = 'Audit Logging Enabled');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `cloud_provider` SET TAGS ('dbx_business_glossary_term' = 'Cloud Provider');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `deployment_environment` SET TAGS ('dbx_business_glossary_term' = 'Deployment Environment');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `deployment_environment` SET TAGS ('dbx_value_regex' = 'production|staging|development|test|disaster_recovery|sandbox');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `disaster_recovery_enabled` SET TAGS ('dbx_business_glossary_term' = 'Disaster Recovery Enabled');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `encryption_enabled` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `engine_code` SET TAGS ('dbx_business_glossary_term' = 'Interface Engine Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `engine_name` SET TAGS ('dbx_business_glossary_term' = 'Interface Engine Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `fhir_version_support` SET TAGS ('dbx_business_glossary_term' = 'FHIR Version Support');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `high_availability_enabled` SET TAGS ('dbx_business_glossary_term' = 'High Availability Enabled');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `hipaa_compliant` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Compliant');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `hitrust_certified` SET TAGS ('dbx_business_glossary_term' = 'HITRUST Certified');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `hl7_version_support` SET TAGS ('dbx_business_glossary_term' = 'HL7 Version Support');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `hosting_model` SET TAGS ('dbx_business_glossary_term' = 'Hosting Model');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `hosting_model` SET TAGS ('dbx_value_regex' = 'on_premise|cloud|hybrid|saas|paas|iaas');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'perpetual|subscription|open_source|enterprise|community|trial');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `max_concurrent_connections` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Connections');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `message_throughput_capacity` SET TAGS ('dbx_business_glossary_term' = 'Message Throughput Capacity');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `message_throughput_capacity` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|decommissioned|planned|suspended');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_hostname` SET TAGS ('dbx_business_glossary_term' = 'Primary Hostname');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_hostname` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Primary IP Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `responsible_team` SET TAGS ('dbx_business_glossary_term' = 'Responsible Team');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `support_contract_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Support Contract Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `support_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Support Contract Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `support_contract_status` SET TAGS ('dbx_value_regex' = 'active|expired|pending_renewal|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `supported_protocols` SET TAGS ('dbx_business_glossary_term' = 'Supported Protocols');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` SET TAGS ('dbx_subdomain' = 'interface_integration');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `interface_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Channel Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `exchange_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Standard Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `replaced_interface_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Replaced Interface Channel Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `replaced_interface_channel_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `acknowledgment_required` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `acknowledgment_timeout_seconds` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Timeout in Seconds');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `audit_logging_enabled` SET TAGS ('dbx_business_glossary_term' = 'Audit Logging Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'none|basic|certificate|oauth|saml|mutual_tls');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `business_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Business Owner Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Interface Channel Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Interface Channel Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_business_glossary_term' = 'Interface Channel Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_value_regex' = 'active|inactive|testing|suspended|maintenance|error');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Interface Channel Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'inbound|outbound|bidirectional');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `connection_host` SET TAGS ('dbx_business_glossary_term' = 'Connection Host Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `connection_host` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `connection_port` SET TAGS ('dbx_business_glossary_term' = 'Connection Port Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `connection_port` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_facility_identifier` SET TAGS ('dbx_business_glossary_term' = 'Destination Facility Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Destination System Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_system_name` SET TAGS ('dbx_business_glossary_term' = 'Destination System Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `encryption_enabled` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `encryption_protocol` SET TAGS ('dbx_business_glossary_term' = 'Encryption Protocol');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `hie_network_name` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange (HIE) Network Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `hie_participant_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange (HIE) Participant Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `last_tested_date` SET TAGS ('dbx_business_glossary_term' = 'Last Tested Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `max_message_size_kb` SET TAGS ('dbx_business_glossary_term' = 'Maximum Message Size in Kilobytes (KB)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `max_message_size_kb` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `message_archival_days` SET TAGS ('dbx_business_glossary_term' = 'Message Archival Retention Days');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `message_archival_days` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `message_encoding` SET TAGS ('dbx_business_glossary_term' = 'Message Encoding Format');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `message_encoding` SET TAGS ('dbx_value_regex' = 'ER7|XML|JSON|PIPE|FIXED');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `message_encoding` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `message_event_type` SET TAGS ('dbx_business_glossary_term' = 'Message Event Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `message_event_type` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `message_retry_count` SET TAGS ('dbx_business_glossary_term' = 'Message Retry Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `message_retry_count` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Interface Channel Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `phi_transmitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Transmitted Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `retry_interval_seconds` SET TAGS ('dbx_business_glossary_term' = 'Retry Interval in Seconds');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'critical|high|standard|low');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Target Percentage');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_facility_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source Facility Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_system_name` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Support Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `support_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Support Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `support_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `support_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `technical_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Technical Owner Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `transformation_map_name` SET TAGS ('dbx_business_glossary_term' = 'Transformation Map Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `transport_protocol` SET TAGS ('dbx_business_glossary_term' = 'Transport Protocol');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` SET TAGS ('dbx_subdomain' = 'interface_integration');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_log_id` SET TAGS ('dbx_business_glossary_term' = 'Message Log ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_log_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `interface_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Channel Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `mapping_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Transformation Rule Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `original_message_log_id` SET TAGS ('dbx_business_glossary_term' = 'Original Message Log ID Reference');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `original_message_log_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Facility Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `care_site_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `receiving_facility_care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Facility Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Appointment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `ack_code` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment (ACK) Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `ack_code` SET TAGS ('dbx_value_regex' = 'AA|AE|AR|CA|CE|CR');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `ack_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Received Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `business_event_type` SET TAGS ('dbx_business_glossary_term' = 'Business Event Type Classification');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `destination_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Destination Internet Protocol (IP) Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `destination_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `destination_ip_address` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `duplicate_check_performed` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Message Check Performed Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `encryption_applied` SET TAGS ('dbx_business_glossary_term' = 'Encryption Applied Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `error_description` SET TAGS ('dbx_business_glossary_term' = 'Error Description Text');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `error_severity` SET TAGS ('dbx_business_glossary_term' = 'Error Severity Level');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `error_severity` SET TAGS ('dbx_value_regex' = 'information|warning|error|fatal');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `hie_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange (HIE) Transaction ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `is_duplicate` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Message Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_control_number` SET TAGS ('dbx_business_glossary_term' = 'Message Control ID (MSH-10)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_control_number` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_priority` SET TAGS ('dbx_business_glossary_term' = 'Message Processing Priority');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat|asap');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_priority` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Message Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_sequence_number` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_standard` SET TAGS ('dbx_business_glossary_term' = 'Message Standard Protocol');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_standard` SET TAGS ('dbx_value_regex' = 'HL7v2|FHIR|CDA|X12|NCPDP|DICOM');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_standard` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Message Creation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_timestamp` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_type` SET TAGS ('dbx_business_glossary_term' = 'Message Type Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_type` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_version` SET TAGS ('dbx_business_glossary_term' = 'Message Standard Version');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_version` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_business_glossary_term' = 'Patient Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `payload_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Message Payload Size in Bytes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `phi_present` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Present Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `processing_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `processing_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Processing Latency in Milliseconds');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `processing_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Message Processing Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Message Received Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `receiving_application` SET TAGS ('dbx_business_glossary_term' = 'Receiving Application Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Attempt Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `sending_application` SET TAGS ('dbx_business_glossary_term' = 'Sending Application Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `sla_met` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `sla_threshold_ms` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Threshold in Milliseconds');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `source_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Source Internet Protocol (IP) Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `source_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `source_ip_address` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `transformation_applied` SET TAGS ('dbx_business_glossary_term' = 'Data Transformation Applied Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `transport_protocol` SET TAGS ('dbx_business_glossary_term' = 'Transport Protocol Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `validation_errors` SET TAGS ('dbx_business_glossary_term' = 'Validation Error Details');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Message Validation Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'passed|failed|warning|not_validated');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` SET TAGS ('dbx_subdomain' = 'interface_integration');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `message_error_id` SET TAGS ('dbx_business_glossary_term' = 'Message Error ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `message_error_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Resolver ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `interface_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Channel ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `message_log_id` SET TAGS ('dbx_business_glossary_term' = 'Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `message_log_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `related_prior_message_error_id` SET TAGS ('dbx_business_glossary_term' = 'Related Message Error Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `related_prior_message_error_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `related_prior_message_error_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `visit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `visit_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `acknowledgment_code` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `acknowledgment_code` SET TAGS ('dbx_value_regex' = 'AA|AE|AR|CA|CE|CR');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `actual_resolution_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Minutes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `business_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Business Impact Description');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `error_category` SET TAGS ('dbx_business_glossary_term' = 'Error Category');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `error_description` SET TAGS ('dbx_business_glossary_term' = 'Error Description');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `error_severity` SET TAGS ('dbx_business_glossary_term' = 'Error Severity');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `error_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `error_stack_trace` SET TAGS ('dbx_business_glossary_term' = 'Error Stack Trace');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `error_stack_trace` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `error_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Error Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `field_position_error` SET TAGS ('dbx_business_glossary_term' = 'Field Position Error');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `interface_engine_version` SET TAGS ('dbx_business_glossary_term' = 'Interface Engine Version');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `message_segment_error` SET TAGS ('dbx_business_glossary_term' = 'Message Segment Error');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `message_segment_error` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_business_glossary_term' = 'Patient Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `raw_message_payload` SET TAGS ('dbx_business_glossary_term' = 'Raw Message Payload');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `raw_message_payload` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `raw_message_payload` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `retry_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Retry Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `sla_target_resolution_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Resolution Minutes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `validation_rule_violated` SET TAGS ('dbx_business_glossary_term' = 'Validation Rule Violated');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` SET TAGS ('dbx_subdomain' = 'standards_terminology');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `fhir_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Endpoint Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `data_sharing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Agreement Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Managing Organization Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `superseded_fhir_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Fhir Endpoint Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `superseded_fhir_endpoint_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'oauth2|smart_on_fhir|api_key|basic_auth|mutual_tls|none');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `average_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Average Response Time Milliseconds');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `average_response_time_ms` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `bulk_data_export_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Bulk Data Export Support Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `capability_statement_url` SET TAGS ('dbx_business_glossary_term' = 'Capability Statement Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `capability_statement_url` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `cms_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `connection_type` SET TAGS ('dbx_business_glossary_term' = 'Connection Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `connection_type` SET TAGS ('dbx_value_regex' = 'hl7_fhir_rest|hl7_fhir_messaging|direct|ihe_xds|hl7_v2|custom');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `endpoint_name` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `endpoint_type` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `endpoint_type` SET TAGS ('dbx_value_regex' = 'patient_facing|payer_api|provider_directory|internal_server|hie_gateway|research_api');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `environment` SET TAGS ('dbx_business_glossary_term' = 'Environment');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `environment` SET TAGS ('dbx_value_regex' = 'production|staging|testing|development|sandbox');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `fhir_version` SET TAGS ('dbx_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Version');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `fhir_version` SET TAGS ('dbx_value_regex' = 'R4|STU3|DSTU2|R5');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `hie_network_name` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange (HIE) Network Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `hie_participant_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange (HIE) Participant Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `last_availability_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Availability Check Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `last_availability_status` SET TAGS ('dbx_business_glossary_term' = 'Last Availability Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `last_availability_status` SET TAGS ('dbx_value_regex' = 'available|unavailable|degraded|timeout|error');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `oauth_authorization_url` SET TAGS ('dbx_business_glossary_term' = 'OAuth Authorization Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `oauth_authorization_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `oauth_token_url` SET TAGS ('dbx_business_glossary_term' = 'OAuth Token Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `oauth_token_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `onc_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Office of the National Coordinator (ONC) Certification Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|testing|maintenance|deprecated|retired');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `patient_access_api_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Access Application Programming Interface (API) Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `payer_to_payer_api_flag` SET TAGS ('dbx_business_glossary_term' = 'Payer to Payer Application Programming Interface (API) Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `provider_access_api_flag` SET TAGS ('dbx_business_glossary_term' = 'Provider Access Application Programming Interface (API) Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `public_endpoint_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Endpoint Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `rate_limit_requests_per_day` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Requests Per Day');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `rate_limit_requests_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Requests Per Minute');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `security_certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Security Certificate Expiry Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `smart_app_launch_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitutable Medical Applications Reusable Technologies (SMART) App Launch Support Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `supported_resource_types` SET TAGS ('dbx_business_glossary_term' = 'Supported Resource Types');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `total_requests_last_30_days` SET TAGS ('dbx_business_glossary_term' = 'Total Requests Last 30 Days');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Uptime Percentage');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `uptime_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` SET TAGS ('dbx_subdomain' = 'standards_terminology');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `fhir_resource_log_id` SET TAGS ('dbx_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Resource Log ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Context ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `demographics_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting User ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `fhir_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Fhir Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `related_prior_fhir_resource_log_id` SET TAGS ('dbx_business_glossary_term' = 'Related Fhir Resource Log Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `related_prior_fhir_resource_log_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Context ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `access_decision` SET TAGS ('dbx_business_glossary_term' = 'Access Decision');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `access_decision` SET TAGS ('dbx_value_regex' = 'granted|denied|conditional');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `authorization_scope` SET TAGS ('dbx_business_glossary_term' = 'Authorization Scope');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `conformance_validation_result` SET TAGS ('dbx_business_glossary_term' = 'Conformance Validation Result');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `conformance_validation_result` SET TAGS ('dbx_value_regex' = 'passed|failed|not_validated');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `consent_policy_applied` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Applied');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `cures_act_exception_flag` SET TAGS ('dbx_business_glossary_term' = '21st Century Cures Act Exception Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `data_segmentation_applied` SET TAGS ('dbx_business_glossary_term' = 'Data Segmentation Applied Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `exception_reason` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Profile Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('dbx_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Resource ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Resource Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Version ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `hie_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange (HIE) Transaction ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `http_status_code` SET TAGS ('dbx_business_glossary_term' = 'Hypertext Transfer Protocol (HTTP) Status Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `operation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Operation Outcome');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `operation_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Operation Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `request_body_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Request Body Size in Bytes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `request_method` SET TAGS ('dbx_business_glossary_term' = 'Hypertext Transfer Protocol (HTTP) Request Method');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `request_method` SET TAGS ('dbx_value_regex' = 'GET|POST|PUT|PATCH|DELETE');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `request_url` SET TAGS ('dbx_business_glossary_term' = 'Request Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `requesting_application_code` SET TAGS ('dbx_business_glossary_term' = 'Requesting Application ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `requesting_client_code` SET TAGS ('dbx_business_glossary_term' = 'Requesting Client ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `response_body_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Response Body Size in Bytes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Response Time in Milliseconds');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `search_parameters` SET TAGS ('dbx_business_glossary_term' = 'FHIR Search Parameters');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `search_result_count` SET TAGS ('dbx_business_glossary_term' = 'Search Result Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `source_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Source Internet Protocol (IP) Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `source_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `source_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `validation_errors` SET TAGS ('dbx_business_glossary_term' = 'Validation Errors');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` SET TAGS ('dbx_subdomain' = 'standards_terminology');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `mapping_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Mapping Rule Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `fallback_mapping_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Fallback Mapping Rule Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `fallback_mapping_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `mapping_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Mapping Definition Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `crosswalk_id` SET TAGS ('dbx_business_glossary_term' = 'Source Crosswalk Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `exchange_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Source Exchange Standard Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `condition_expression` SET TAGS ('dbx_business_glossary_term' = 'Condition Expression');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `data_type_conversion` SET TAGS ('dbx_business_glossary_term' = 'Data Type Conversion Logic');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `default_value` SET TAGS ('dbx_business_glossary_term' = 'Default Value');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `equivalence_type` SET TAGS ('dbx_business_glossary_term' = 'Equivalence Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `error_handling_action` SET TAGS ('dbx_business_glossary_term' = 'Error Handling Action');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `error_handling_action` SET TAGS ('dbx_value_regex' = 'abort|log|skip|retry|default');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rule Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `null_handling_strategy` SET TAGS ('dbx_business_glossary_term' = 'Null Handling Strategy');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `null_handling_strategy` SET TAGS ('dbx_value_regex' = 'skip|default|error|empty_string|preserve_null');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `rule_priority` SET TAGS ('dbx_business_glossary_term' = 'Rule Priority');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `rule_sequence` SET TAGS ('dbx_business_glossary_term' = 'Rule Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|deprecated|testing');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `rule_version` SET TAGS ('dbx_business_glossary_term' = 'Rule Version');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `source_data_type` SET TAGS ('dbx_business_glossary_term' = 'Source Data Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `source_expression` SET TAGS ('dbx_business_glossary_term' = 'Source Expression');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `target_code_system` SET TAGS ('dbx_business_glossary_term' = 'Target Code System');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `target_data_type` SET TAGS ('dbx_business_glossary_term' = 'Target Data Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `target_expression` SET TAGS ('dbx_business_glossary_term' = 'Target Expression');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `test_case_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Case Reference');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `transformation_function` SET TAGS ('dbx_business_glossary_term' = 'Transformation Function');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `validation_rule` SET TAGS ('dbx_business_glossary_term' = 'Validation Rule Expression');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` SET TAGS ('dbx_subdomain' = 'health_exchange');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `hie_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange (HIE) Participation ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `business_associate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Business Associate Agreement (BAA) ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `financial_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Organization ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `hie_organization_id` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange (HIE) Organization ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `interface_engine_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Engine Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `renewed_hie_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Renewed Hie Participation Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `renewed_hie_participation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `annual_participation_fee` SET TAGS ('dbx_business_glossary_term' = 'Annual Participation Fee');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `annual_participation_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `compliance_attestation_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Attestation Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `compliance_attestation_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Attestation Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `contribution_volume_monthly_avg` SET TAGS ('dbx_business_glossary_term' = 'Contribution Volume Monthly Average');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `data_sharing_scope` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Scope');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `data_use_agreement_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Data Use Agreement (DUA) Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `data_use_agreement_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Data Use Agreement (DUA) Signed Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `hie_network_name` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange (HIE) Network Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `hie_network_type` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange (HIE) Network Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `hie_network_type` SET TAGS ('dbx_value_regex' = 'state|regional|national|private|vendor');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `interface_engine_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Interface Engine Endpoint');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `interface_engine_endpoint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_onboarding|terminated');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `participation_tier` SET TAGS ('dbx_business_glossary_term' = 'Participation Tier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `participation_tier` SET TAGS ('dbx_value_regex' = 'query_only|contribute_only|query_and_contribute|full_bidirectional');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `patient_consent_model` SET TAGS ('dbx_business_glossary_term' = 'Patient Consent Model');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `patient_consent_model` SET TAGS ('dbx_value_regex' = 'opt_in|opt_out|no_consent_required|emergency_only');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `query_volume_monthly_avg` SET TAGS ('dbx_business_glossary_term' = 'Query Volume Monthly Average');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `supported_standards` SET TAGS ('dbx_business_glossary_term' = 'Supported Standards');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_connection_type` SET TAGS ('dbx_business_glossary_term' = 'Technical Connection Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_connection_type` SET TAGS ('dbx_value_regex' = 'direct_messaging|fhir_api|hl7v2_interface|cda_exchange|proprietary');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Technical Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Technical Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_name` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Technical Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `transaction_fee_model` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee Model');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `transaction_fee_model` SET TAGS ('dbx_value_regex' = 'flat_rate|per_transaction|tiered|no_fee');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` SET TAGS ('dbx_subdomain' = 'health_exchange');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `hie_query_id` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange (HIE) Query Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Provider Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `follow_up_hie_query_id` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Hie Query Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `follow_up_hie_query_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `hie_organization_id` SET TAGS ('dbx_business_glossary_term' = 'Hie Organization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `hie_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Hie Participation Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `interface_engine_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Engine Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating Facility Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `audit_logged` SET TAGS ('dbx_business_glossary_term' = 'Audit Logged Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `clinical_purpose_code` SET TAGS ('dbx_business_glossary_term' = 'Clinical Purpose of Use Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `clinical_purpose_code` SET TAGS ('dbx_value_regex' = 'treatment|payment|operations|research|public_health|emergency');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `consent_verified` SET TAGS ('dbx_business_glossary_term' = 'Patient Consent Verified Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `data_sensitivity_level` SET TAGS ('dbx_business_glossary_term' = 'Data Sensitivity Level');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `data_sensitivity_level` SET TAGS ('dbx_value_regex' = 'normal|restricted|confidential|highly_confidential');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `documents_returned_count` SET TAGS ('dbx_business_glossary_term' = 'Documents Returned Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Query Error Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Query Error Message');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `error_message` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `hie_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'HIE Transaction Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `initiating_facility_npi` SET TAGS ('dbx_business_glossary_term' = 'Initiating Facility National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `initiating_facility_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `match_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Patient Matching Algorithm');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `match_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Patient Match Confidence Score');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Query Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Patient Date of Birth');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_first_name` SET TAGS ('dbx_business_glossary_term' = 'Patient First Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_gender` SET TAGS ('dbx_business_glossary_term' = 'Patient Gender');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_gender` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_gender` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_last_name` SET TAGS ('dbx_business_glossary_term' = 'Patient Last Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_business_glossary_term' = 'Patient Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_ssn_last_four` SET TAGS ('dbx_business_glossary_term' = 'Patient Social Security Number (SSN) Last Four Digits');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_ssn_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_ssn_last_four` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_ssn_last_four` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_zip_code` SET TAGS ('dbx_business_glossary_term' = 'Patient ZIP Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_zip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `query_message_control_number` SET TAGS ('dbx_business_glossary_term' = 'Query Message Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `query_message_control_number` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `query_priority` SET TAGS ('dbx_business_glossary_term' = 'Query Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `query_priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat|emergency');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `query_protocol` SET TAGS ('dbx_business_glossary_term' = 'Query Protocol');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `query_protocol` SET TAGS ('dbx_value_regex' = 'hl7v2|fhir|cda|ihe_xds|direct');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `query_response_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Query Response Time in Seconds');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `query_source_system` SET TAGS ('dbx_business_glossary_term' = 'Query Source System');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `query_status` SET TAGS ('dbx_business_glossary_term' = 'Query Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `query_status` SET TAGS ('dbx_value_regex' = 'submitted|in_progress|completed|failed|timeout|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `query_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Query Submission Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `query_type` SET TAGS ('dbx_business_glossary_term' = 'HIE Query Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `query_type` SET TAGS ('dbx_value_regex' = 'patient_discovery|document_query|document_retrieve|patient_demographics_query|clinical_data_query|medication_history_query');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `requesting_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Requesting Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `requesting_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `responding_facility_npi` SET TAGS ('dbx_business_glossary_term' = 'Responding Facility National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `responding_facility_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Query Response Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Query Retry Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` SET TAGS ('dbx_subdomain' = 'standards_terminology');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `cda_document_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Document Architecture (CDA) Document ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Author Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `consent_reference_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Reference ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `financial_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Organization ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `interface_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Channel ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Author Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `problem_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `superseded_cda_document_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Cda Document Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `superseded_cda_document_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_value_regex' = 'acknowledged|rejected|pending|not_required');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `cda_version` SET TAGS ('dbx_business_glossary_term' = 'Clinical Document Architecture (CDA) Version');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `confidentiality_code` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `document_creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Document Creation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `document_hash` SET TAGS ('dbx_business_glossary_term' = 'Document Hash');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `document_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Document Size in Bytes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `document_status` SET TAGS ('dbx_value_regex' = 'draft|final|amended|deprecated|entered_in_error');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `document_title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `document_type_code` SET TAGS ('dbx_business_glossary_term' = 'Document Type Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `document_type_name` SET TAGS ('dbx_business_glossary_term' = 'Document Type Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `document_unique_identifier` SET TAGS ('dbx_business_glossary_term' = 'Document Unique Identifier (OID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `document_version_number` SET TAGS ('dbx_business_glossary_term' = 'Document Version Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `exchange_direction` SET TAGS ('dbx_business_glossary_term' = 'Exchange Direction');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `exchange_direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `hipaa_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Compliant Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_business_glossary_term' = 'Patient Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `purpose_of_use_code` SET TAGS ('dbx_business_glossary_term' = 'Purpose of Use Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `source_system_name` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `storage_location_uri` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Uniform Resource Identifier (URI)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `storage_location_uri` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `transmission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transmission Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `validation_error_count` SET TAGS ('dbx_business_glossary_term' = 'Validation Error Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'passed|failed|not_validated|warning');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `validation_warning_count` SET TAGS ('dbx_business_glossary_term' = 'Validation Warning Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` SET TAGS ('dbx_subdomain' = 'standards_terminology');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `cda_validation_result_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Document Architecture (CDA) Validation Result Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `cda_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `revalidated_cda_validation_result_id` SET TAGS ('dbx_business_glossary_term' = 'Revalidated Cda Validation Result Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `revalidated_cda_validation_result_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `certification_requirement_met` SET TAGS ('dbx_business_glossary_term' = 'Certification Requirement Met Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `conformance_profile` SET TAGS ('dbx_business_glossary_term' = 'Conformance Profile');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `conformance_profile` SET TAGS ('dbx_value_regex' = 'c_cda_2_1|c_cda_1_1|qrda_i|qrda_iii|care_plan|consultation_note_2_1');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `critical_error_list` SET TAGS ('dbx_business_glossary_term' = 'Critical Error List');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `destination_system` SET TAGS ('dbx_business_glossary_term' = 'Destination System Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `document_author_npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI) of Document Author');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `document_author_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `document_size_kb` SET TAGS ('dbx_business_glossary_term' = 'Document Size in Kilobytes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Clinical Document Architecture (CDA) Document Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `finding_details` SET TAGS ('dbx_business_glossary_term' = 'Validation Finding Details');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `hie_network_name` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange (HIE) Network Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Validation Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `regulatory_submission_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `remediation_assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Remediation Assigned To User');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `remediation_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completed Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Validation Retry Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `schema_validation_passed` SET TAGS ('dbx_business_glossary_term' = 'Extensible Markup Language (XML) Schema Validation Passed Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `schematron_validation_passed` SET TAGS ('dbx_business_glossary_term' = 'Schematron Validation Passed Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `structural_validation_passed` SET TAGS ('dbx_business_glossary_term' = 'Structural Validation Passed Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `submission_readiness_flag` SET TAGS ('dbx_business_glossary_term' = 'Submission Readiness Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `total_error_count` SET TAGS ('dbx_business_glossary_term' = 'Total Error Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `total_informational_count` SET TAGS ('dbx_business_glossary_term' = 'Total Informational Finding Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `total_warning_count` SET TAGS ('dbx_business_glossary_term' = 'Total Warning Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `validation_execution_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Validation Execution Time in Milliseconds');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `validation_initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Validation Initiated By User');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `validation_purpose` SET TAGS ('dbx_business_glossary_term' = 'Validation Purpose');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `validation_purpose` SET TAGS ('dbx_value_regex' = 'trading_partner_onboarding|regulatory_submission|quality_assurance|pre_exchange_check|post_exchange_audit');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pass|fail|warning|error');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `validator_tool_name` SET TAGS ('dbx_business_glossary_term' = 'Validator Tool Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `validator_tool_version` SET TAGS ('dbx_business_glossary_term' = 'Validator Tool Version');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `vocabulary_validation_passed` SET TAGS ('dbx_business_glossary_term' = 'Vocabulary Validation Passed Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` SET TAGS ('dbx_subdomain' = 'health_exchange');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `patient_identity_match_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identity Match ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Source Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting User ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `hie_organization_id` SET TAGS ('dbx_business_glossary_term' = 'Hie Organization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Matched Enterprise Master Patient Index (EMPI) ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `source_mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Matched Master Patient Index (MPI) ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `source_mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `source_mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `superseded_patient_identity_match_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Patient Identity Match Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `superseded_patient_identity_match_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `candidate_count` SET TAGS ('dbx_business_glossary_term' = 'Candidate Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `consent_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Override Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `consent_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Consent Override Reason');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `duplicate_record_flag` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Record Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `error_message` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `hie_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange (HIE) Transaction ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `manual_review_assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Manual Review Assigned To');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `manual_review_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Manual Review Completed Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `manual_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Manual Review Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `manual_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Manual Review Outcome');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `manual_review_outcome` SET TAGS ('dbx_value_regex' = 'CONFIRMED|REJECTED|MERGED|NEW_RECORD_CREATED');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `manual_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Manual Review Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `match_algorithm_code` SET TAGS ('dbx_business_glossary_term' = 'Match Algorithm Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `match_algorithm_version` SET TAGS ('dbx_business_glossary_term' = 'Match Algorithm Version');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `match_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Match Confidence Level');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `match_confidence_level` SET TAGS ('dbx_value_regex' = 'HIGH|MEDIUM|LOW');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `match_method` SET TAGS ('dbx_business_glossary_term' = 'Match Method');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `match_method` SET TAGS ('dbx_value_regex' = 'DETERMINISTIC|PROBABILISTIC|HYBRID|MANUAL');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `match_processing_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Match Processing Time (Milliseconds)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `match_request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Match Request Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `match_result_status` SET TAGS ('dbx_business_glossary_term' = 'Match Result Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `match_result_status` SET TAGS ('dbx_value_regex' = 'MATCH|POSSIBLE_MATCH|NO_MATCH|MULTIPLE_MATCH|ERROR');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `match_score` SET TAGS ('dbx_business_glossary_term' = 'Match Score');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Matched Date of Birth');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_patient_first_name` SET TAGS ('dbx_business_glossary_term' = 'Matched Patient First Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_patient_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_patient_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_patient_last_name` SET TAGS ('dbx_business_glossary_term' = 'Matched Patient Last Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_patient_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_patient_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `requesting_user_npi` SET TAGS ('dbx_business_glossary_term' = 'Requesting User National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `source_system_name` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Submitted Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_city` SET TAGS ('dbx_business_glossary_term' = 'Submitted City');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Submitted Date of Birth');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_gender` SET TAGS ('dbx_business_glossary_term' = 'Submitted Gender');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_gender` SET TAGS ('dbx_value_regex' = 'M|F|U|O');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_gender` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_mrn` SET TAGS ('dbx_business_glossary_term' = 'Submitted Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_patient_first_name` SET TAGS ('dbx_business_glossary_term' = 'Submitted Patient First Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_patient_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_patient_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_patient_last_name` SET TAGS ('dbx_business_glossary_term' = 'Submitted Patient Last Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_patient_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_patient_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Submitted Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Submitted Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_ssn` SET TAGS ('dbx_business_glossary_term' = 'Submitted Social Security Number (SSN)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_ssn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_ssn` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_state` SET TAGS ('dbx_business_glossary_term' = 'Submitted State');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'PIX_QUERY|PDQ_QUERY|MPI_LOOKUP|EMPI_MATCH|FHIR_PATIENT_MATCH|HL7_ADT');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` SET TAGS ('dbx_subdomain' = 'public_reporting');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `direct_message_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Message Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `direct_message_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `interface_engine_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Engine Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `replied_to_direct_message_id` SET TAGS ('dbx_business_glossary_term' = 'Replied To Direct Message Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `replied_to_direct_message_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `replied_to_direct_message_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `direct_address_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Direct Address Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `direct_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `direct_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `acknowledgment_code` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `attachment_types` SET TAGS ('dbx_business_glossary_term' = 'Attachment Types');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `certificate_validation_result` SET TAGS ('dbx_business_glossary_term' = 'Certificate Validation Result');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `certificate_validation_result` SET TAGS ('dbx_value_regex' = 'valid|expired|revoked|untrusted|validation_failed|not_checked');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `clinical_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Clinical Document Reference');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'sent|delivered|failed|bounced|pending|rejected');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `encryption_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Encryption Algorithm');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `encryption_status` SET TAGS ('dbx_business_glossary_term' = 'Encryption Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `encryption_status` SET TAGS ('dbx_value_regex' = 'encrypted|unencrypted|partially_encrypted|encryption_failed');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `hie_network_name` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange (HIE) Network Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `hipaa_compliant` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Compliant Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `meaningful_use_eligible` SET TAGS ('dbx_business_glossary_term' = 'Meaningful Use Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `message_control_number` SET TAGS ('dbx_business_glossary_term' = 'Message Control Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `message_control_number` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `message_priority` SET TAGS ('dbx_business_glossary_term' = 'Message Priority');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `message_priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat|emergency');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `message_priority` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `message_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Message Size in Bytes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `message_size_bytes` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `message_type` SET TAGS ('dbx_business_glossary_term' = 'Message Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `message_type` SET TAGS ('dbx_value_regex' = 'referral|care_summary|lab_result|discharge_notification|consultation_request|imaging_report');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `message_type` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_business_glossary_term' = 'Patient Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `read_receipt_received` SET TAGS ('dbx_business_glossary_term' = 'Read Receipt Received Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `read_receipt_requested` SET TAGS ('dbx_business_glossary_term' = 'Read Receipt Requested Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `read_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Read Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_certificate_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Recipient Certificate Serial Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_direct_address` SET TAGS ('dbx_business_glossary_term' = 'Recipient Direct Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_direct_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_direct_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_direct_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_npi` SET TAGS ('dbx_business_glossary_term' = 'Recipient National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Organization Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `send_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Send Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `sender_certificate_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Sender Certificate Serial Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `subject_line` SET TAGS ('dbx_business_glossary_term' = 'Message Subject Line');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Workflow Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` SET TAGS ('dbx_subdomain' = 'public_reporting');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Address ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `replaced_direct_address_id` SET TAGS ('dbx_business_glossary_term' = 'Replaced Direct Address Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `replaced_direct_address_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `replaced_direct_address_id` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Direct Address Activation Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `address_status` SET TAGS ('dbx_business_glossary_term' = 'Direct Address Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_activation|revoked|expired');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Direct Address Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'provider|facility|patient|organization|department|application');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `address_type` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Administrative Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Administrative Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Administrative Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `auto_renewal_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate Auto-Renewal Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `certificate_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `certificate_issuer_dn` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issuer Distinguished Name (DN)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `certificate_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Serial Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `certificate_serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Digital Certificate Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `certificate_status` SET TAGS ('dbx_value_regex' = 'valid|expired|revoked|suspended|pending_issuance|renewal_required');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Direct Address Deactivation Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address` SET TAGS ('dbx_business_glossary_term' = 'Direct Secure Messaging Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `display_name` SET TAGS ('dbx_business_glossary_term' = 'Direct Address Display Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `display_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `display_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `encryption_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Encryption Algorithm');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `hipaa_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Compliant Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `hisp_domain` SET TAGS ('dbx_business_glossary_term' = 'Health Information Service Provider (HISP) Domain');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `hisp_name` SET TAGS ('dbx_business_glossary_term' = 'Health Information Service Provider (HISP) Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `hitrust_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Information Trust Alliance (HITRUST) Certified Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `last_message_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Message Received Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `last_message_received_timestamp` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `last_message_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Message Sent Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `last_message_sent_timestamp` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `message_volume_last_30_days` SET TAGS ('dbx_business_glossary_term' = 'Message Volume Last 30 Days');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `message_volume_last_30_days` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Direct Address Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `notification_email` SET TAGS ('dbx_business_glossary_term' = 'Notification Email Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `notification_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `notification_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `notification_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `npi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `primary_use_case` SET TAGS ('dbx_business_glossary_term' = 'Primary Use Case');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `signature_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Algorithm');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `specialty` SET TAGS ('dbx_business_glossary_term' = 'Provider Specialty');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `trust_bundle_membership_status` SET TAGS ('dbx_business_glossary_term' = 'Trust Bundle Membership Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `trust_bundle_membership_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|removed');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `trust_bundle_name` SET TAGS ('dbx_business_glossary_term' = 'Trust Bundle Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` SET TAGS ('dbx_subdomain' = 'interface_integration');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `interface_sla_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Service Level Agreement (SLA) ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `interface_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Channel ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `superseded_interface_sla_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Interface Sla Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `superseded_interface_sla_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `alert_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Percentage');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `auto_escalation_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Escalation Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `business_criticality` SET TAGS ('dbx_business_glossary_term' = 'Business Criticality Level');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `business_criticality` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `contract_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_path` SET TAGS ('dbx_business_glossary_term' = 'Escalation Path');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `max_error_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Maximum Error Rate Percentage');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `max_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Maximum Acceptable Latency (Milliseconds)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `measurement_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Measurement Window (Hours)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `message_throughput_target` SET TAGS ('dbx_business_glossary_term' = 'Message Throughput Target');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `message_throughput_target` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `monitoring_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `notification_email_list` SET TAGS ('dbx_business_glossary_term' = 'Notification Email Distribution List');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `notification_email_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `notification_email_list` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Description');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly|monthly');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `sla_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `sla_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `sla_status` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `sla_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|draft|under_review');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `sla_type` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `sla_type` SET TAGS ('dbx_value_regex' = 'interface_throughput|latency|error_rate|uptime|composite');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `throughput_unit` SET TAGS ('dbx_business_glossary_term' = 'Throughput Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `throughput_unit` SET TAGS ('dbx_value_regex' = 'messages_per_hour|messages_per_minute|messages_per_day|transactions_per_second');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `uptime_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Uptime Target Percentage');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Version');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` SET TAGS ('dbx_subdomain' = 'interface_integration');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `interface_downtime_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Downtime ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `fhir_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Fhir Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `interface_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Channel ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `interface_engine_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Engine ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Detected By User ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `related_prior_interface_downtime_id` SET TAGS ('dbx_business_glossary_term' = 'Related Interface Downtime Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `related_prior_interface_downtime_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `actual_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Actual Uptime Percentage');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `actual_uptime_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `affected_channels_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Channels Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `affected_departments` SET TAGS ('dbx_business_glossary_term' = 'Affected Departments');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `affected_facilities` SET TAGS ('dbx_business_glossary_term' = 'Affected Facilities');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `affected_message_types` SET TAGS ('dbx_business_glossary_term' = 'Affected Message Types');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `affected_message_types` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `business_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Business Impact Description');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `change_request_reference` SET TAGS ('dbx_business_glossary_term' = 'Change Request Reference');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'automated_monitoring|user_reported|scheduled_check|vendor_notification|system_alert');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `downtime_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime Duration Minutes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `downtime_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `downtime_event_number` SET TAGS ('dbx_business_glossary_term' = 'Downtime Event Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `downtime_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `downtime_status` SET TAGS ('dbx_business_glossary_term' = 'Downtime Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `downtime_status` SET TAGS ('dbx_value_regex' = 'active|resolved|investigating|recovering|closed');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `downtime_type` SET TAGS ('dbx_business_glossary_term' = 'Downtime Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `downtime_type` SET TAGS ('dbx_value_regex' = 'planned_maintenance|unplanned_outage|trading_partner_outage|emergency_maintenance|scheduled_upgrade|network_failure');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|management|vendor');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `impact_severity` SET TAGS ('dbx_business_glossary_term' = 'Impact Severity');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `impact_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `incident_ticket_reference` SET TAGS ('dbx_business_glossary_term' = 'Incident Ticket Reference');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `messages_lost_count` SET TAGS ('dbx_business_glossary_term' = 'Messages Lost Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `messages_lost_count` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `messages_queued_count` SET TAGS ('dbx_business_glossary_term' = 'Messages Queued Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `messages_queued_count` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `messages_replayed_count` SET TAGS ('dbx_business_glossary_term' = 'Messages Replayed Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `messages_replayed_count` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `post_incident_review_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Post-Incident Review Completed Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `post_incident_review_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Incident Review Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `preventive_actions` SET TAGS ('dbx_business_glossary_term' = 'Preventive Actions');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `problem_ticket_reference` SET TAGS ('dbx_business_glossary_term' = 'Problem Ticket Reference');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'hardware_failure|software_bug|network_issue|configuration_error|capacity_overload|external_dependency');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `sla_target_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Uptime Percentage');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `sla_target_uptime_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `workaround_description` SET TAGS ('dbx_business_glossary_term' = 'Workaround Description');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `workaround_implemented_flag` SET TAGS ('dbx_business_glossary_term' = 'Workaround Implemented Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` SET TAGS ('dbx_subdomain' = 'standards_terminology');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `terminology_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Terminology Mapping Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `primary_superseded_by_terminology_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Mapping Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Source Code Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Source Code Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Source Code Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `loinc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Source Code Loinc Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Source Code Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `code_set_version_id` SET TAGS ('dbx_business_glossary_term' = 'Source Code Set Version Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Source Code Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `exchange_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Target Exchange Standard Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `tertiary_terminology_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `tertiary_terminology_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `tertiary_terminology_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `alternate_target_code_value` SET TAGS ('dbx_business_glossary_term' = 'Alternate Target Code Value');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `alternate_target_display_name` SET TAGS ('dbx_business_glossary_term' = 'Alternate Target Display Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `error_count` SET TAGS ('dbx_business_glossary_term' = 'Error Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `governance_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Governance Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `governance_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `mapping_code` SET TAGS ('dbx_business_glossary_term' = 'Mapping Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `mapping_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Mapping Confidence Score');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `mapping_method` SET TAGS ('dbx_business_glossary_term' = 'Mapping Method');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `mapping_method` SET TAGS ('dbx_value_regex' = 'manual|automated|hybrid|vendor_supplied');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `mapping_name` SET TAGS ('dbx_business_glossary_term' = 'Mapping Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `mapping_priority` SET TAGS ('dbx_business_glossary_term' = 'Mapping Priority');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `mapping_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `mapping_rationale` SET TAGS ('dbx_business_glossary_term' = 'Mapping Rationale');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `mapping_relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Mapping Relationship Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `mapping_status` SET TAGS ('dbx_business_glossary_term' = 'Mapping Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `mapping_status` SET TAGS ('dbx_value_regex' = 'draft|active|retired|deprecated|under_review');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `mapping_tool_name` SET TAGS ('dbx_business_glossary_term' = 'Mapping Tool Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `source_code_system` SET TAGS ('dbx_business_glossary_term' = 'Source Code System');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `source_code_system_version` SET TAGS ('dbx_business_glossary_term' = 'Source Code System Version');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `source_context` SET TAGS ('dbx_business_glossary_term' = 'Source Context');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `target_code_system` SET TAGS ('dbx_business_glossary_term' = 'Target Code System');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `target_code_system_version` SET TAGS ('dbx_business_glossary_term' = 'Target Code System Version');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `target_code_value` SET TAGS ('dbx_business_glossary_term' = 'Target Code Value');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `target_context` SET TAGS ('dbx_business_glossary_term' = 'Target Context');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `target_display_name` SET TAGS ('dbx_business_glossary_term' = 'Target Display Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `usage_count` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `use_case_category` SET TAGS ('dbx_business_glossary_term' = 'Use Case Category');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|failed_validation|pending_validation');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` SET TAGS ('dbx_subdomain' = 'standards_terminology');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `subscription_topic_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Topic Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `exchange_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Standard Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `interface_engine_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Engine Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `superseded_subscription_topic_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Subscription Topic Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `superseded_subscription_topic_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `audit_logging_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Logging Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `authentication_credential` SET TAGS ('dbx_business_glossary_term' = 'Authentication Credential');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `authentication_credential` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `authentication_credential` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'none|basic_auth|bearer_token|oauth2|mutual_tls|api_key');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `data_sharing_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Agreement Reference');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `data_sharing_agreement_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `encryption_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Encryption Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `event_batch_size` SET TAGS ('dbx_business_glossary_term' = 'Event Batch Size');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `event_batch_window_seconds` SET TAGS ('dbx_business_glossary_term' = 'Event Batch Window Seconds');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `fhir_filter_criteria` SET TAGS ('dbx_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Filter Criteria');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Resource Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `hl7v2_message_type` SET TAGS ('dbx_business_glossary_term' = 'Health Level Seven Version 2 (HL7v2) Message Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `hl7v2_message_type` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `last_error_message` SET TAGS ('dbx_business_glossary_term' = 'Last Error Message');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `last_error_message` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `last_error_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Error Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `last_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Notification Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `max_retry_attempts` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retry Attempts');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `notification_channel_type` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `notification_channel_type` SET TAGS ('dbx_value_regex' = 'rest_hook|websocket|email|fhir_messaging|sms|hl7v2_mllp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `notification_count_total` SET TAGS ('dbx_business_glossary_term' = 'Notification Count Total');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `notification_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Notification Failure Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `patient_consent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Consent Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `payload_content_type` SET TAGS ('dbx_business_glossary_term' = 'Payload Content Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `payload_content_type` SET TAGS ('dbx_value_regex' = 'full_resource|id_only|empty|custom');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `payload_mime_type` SET TAGS ('dbx_business_glossary_term' = 'Payload Multipurpose Internet Mail Extensions (MIME) Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `phi_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Included Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `retry_interval_seconds` SET TAGS ('dbx_business_glossary_term' = 'Retry Interval Seconds');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `retry_policy` SET TAGS ('dbx_business_glossary_term' = 'Retry Policy');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `retry_policy` SET TAGS ('dbx_value_regex' = 'none|exponential_backoff|fixed_interval|immediate_only');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `subscriber_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `subscriber_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `subscriber_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `subscriber_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `subscriber_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `subscriber_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `subscriber_contact_name` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `subscriber_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `subscriber_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `subscriber_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `subscriber_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `subscriber_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `subscriber_endpoint_url` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `subscriber_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Organization Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `subscriber_organization_name` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `subscription_status` SET TAGS ('dbx_business_glossary_term' = 'Subscription Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `subscription_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|error|testing|pending_approval');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `timeout_seconds` SET TAGS ('dbx_business_glossary_term' = 'Timeout Seconds');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `topic_code` SET TAGS ('dbx_business_glossary_term' = 'Subscription Topic Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `topic_name` SET TAGS ('dbx_business_glossary_term' = 'Subscription Topic Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `topic_type` SET TAGS ('dbx_business_glossary_term' = 'Subscription Topic Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `topic_type` SET TAGS ('dbx_value_regex' = 'fhir_subscription|hl7v2_event|cda_notification|custom_event|care_coordination|clinical_alert');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `trigger_event_type` SET TAGS ('dbx_business_glossary_term' = 'Trigger Event Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` SET TAGS ('dbx_subdomain' = 'standards_terminology');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `subscription_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Notification Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Source Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `financial_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Organization Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `interface_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Channel Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `interface_engine_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Engine Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `retried_subscription_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Retried Subscription Notification Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `retried_subscription_notification_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Appointment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `subscription_topic_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `acknowledgment_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Received Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `business_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Business Impact Description');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `delivery_latency_milliseconds` SET TAGS ('dbx_business_glossary_term' = 'Delivery Latency in Milliseconds');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'sent|delivered|failed|retrying|abandoned');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `encryption_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `error_message` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `failure_reason_category` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason Category');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `http_response_code` SET TAGS ('dbx_business_glossary_term' = 'Hypertext Transfer Protocol (HTTP) Response Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `max_retry_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retry Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `next_retry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Retry Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_business_glossary_term' = 'Patient Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `payload_content_type` SET TAGS ('dbx_business_glossary_term' = 'Payload Content Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `payload_content_type` SET TAGS ('dbx_value_regex' = 'application/fhir+json|application/fhir+xml|application/hl7-v2|text/plain|empty');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `payload_reference` SET TAGS ('dbx_business_glossary_term' = 'Payload Reference');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `payload_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Payload Size in Bytes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `phi_transmitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Transmitted Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Notification Priority');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat|asap');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `sla_target_delivery_seconds` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Delivery Time in Seconds');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `subscriber_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `subscriber_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `subscriber_endpoint_url` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `subscription_topic` SET TAGS ('dbx_business_glossary_term' = 'Subscription Topic');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `triggering_event_type` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `triggering_resource_identifier` SET TAGS ('dbx_business_glossary_term' = 'Triggering Resource Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `triggering_resource_type` SET TAGS ('dbx_business_glossary_term' = 'Triggering Resource Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` SET TAGS ('dbx_subdomain' = 'interface_integration');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `onboarding_project_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Project Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `exchange_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Standard Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `interface_engine_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Engine Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `predecessor_onboarding_project_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Onboarding Project Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `predecessor_onboarding_project_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `actual_go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Go-Live Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `build_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Build Phase Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `business_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Business Owner Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|submitted|approved|rejected|not_required');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'ONC|DirectTrust|Carequality|CommonWell|EHNAC|None');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `data_sharing_agreement_date` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Agreement Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `data_sharing_agreement_signed_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Agreement Signed Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `design_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Design Phase Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `discovery_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Phase Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `discovery_start_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Phase Start Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `estimated_message_volume_monthly` SET TAGS ('dbx_business_glossary_term' = 'Estimated Message Volume Monthly');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `estimated_message_volume_monthly` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `integration_testing_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Integration Testing Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `integration_testing_start_date` SET TAGS ('dbx_business_glossary_term' = 'Integration Testing Start Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `interface_type` SET TAGS ('dbx_business_glossary_term' = 'Interface Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `message_type` SET TAGS ('dbx_business_glossary_term' = 'Message Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `message_type` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Project Priority');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `project_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Project Closure Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `project_initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Project Initiation Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Project Phase');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `project_status` SET TAGS ('dbx_value_regex' = 'active|completed|on_hold|cancelled|delayed');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `target_go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Target Go-Live Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `technical_lead_email` SET TAGS ('dbx_business_glossary_term' = 'Technical Lead Email Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `technical_lead_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `technical_lead_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `technical_lead_email` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `technical_lead_name` SET TAGS ('dbx_business_glossary_term' = 'Technical Lead Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `uat_completion_date` SET TAGS ('dbx_business_glossary_term' = 'User Acceptance Testing (UAT) Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `uat_start_date` SET TAGS ('dbx_business_glossary_term' = 'User Acceptance Testing (UAT) Start Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `unit_testing_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Unit Testing Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `unit_testing_start_date` SET TAGS ('dbx_business_glossary_term' = 'Unit Testing Start Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` SET TAGS ('dbx_subdomain' = 'interface_integration');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `conformance_test_id` SET TAGS ('dbx_business_glossary_term' = 'Conformance Test Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `exchange_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Standard Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `fhir_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Endpoint Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `interface_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Channel Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `onboarding_project_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Project Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `retest_conformance_test_id` SET TAGS ('dbx_business_glossary_term' = 'Retest Conformance Test Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `retest_conformance_test_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `certification_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Certification Submission Reference');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `conformance_status` SET TAGS ('dbx_business_glossary_term' = 'Conformance Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `conformance_status` SET TAGS ('dbx_value_regex' = 'Conformant|Non-Conformant|Conditionally Conformant|Pending Review');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `critical_failures_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Failures Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `failure_summary` SET TAGS ('dbx_business_glossary_term' = 'Failure Summary');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Resource Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `go_live_readiness_status` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Readiness Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `go_live_readiness_status` SET TAGS ('dbx_value_regex' = 'Ready|Not Ready|Conditionally Ready|Pending Retest');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `message_event` SET TAGS ('dbx_business_glossary_term' = 'Health Level Seven (HL7) Message Event');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `message_event` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `message_type` SET TAGS ('dbx_business_glossary_term' = 'Health Level Seven (HL7) Message Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `message_type` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `onc_certification_criteria` SET TAGS ('dbx_business_glossary_term' = 'Office of the National Coordinator (ONC) Certification Criteria');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `pass_percentage` SET TAGS ('dbx_business_glossary_term' = 'Pass Percentage');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `pass_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `remediation_notes` SET TAGS ('dbx_business_glossary_term' = 'Remediation Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `retest_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Retest Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `retest_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Scheduled Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_cases_failed` SET TAGS ('dbx_business_glossary_term' = 'Test Cases Failed');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_cases_passed` SET TAGS ('dbx_business_glossary_term' = 'Test Cases Passed');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_cases_skipped` SET TAGS ('dbx_business_glossary_term' = 'Test Cases Skipped');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Test Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_environment` SET TAGS ('dbx_business_glossary_term' = 'Test Environment');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_environment` SET TAGS ('dbx_value_regex' = 'Development|Test|Staging|Pre-Production|Production');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Test Execution Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Execution Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_log_url` SET TAGS ('dbx_business_glossary_term' = 'Test Log Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_report_url` SET TAGS ('dbx_business_glossary_term' = 'Test Report Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'Pass|Fail|Partial Pass|Inconclusive|Error');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_scope` SET TAGS ('dbx_business_glossary_term' = 'Test Scope');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_suite_name` SET TAGS ('dbx_business_glossary_term' = 'Test Suite Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_suite_version` SET TAGS ('dbx_business_glossary_term' = 'Test Suite Version');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `tester_email` SET TAGS ('dbx_business_glossary_term' = 'Tester Email Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `tester_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `tester_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `tester_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `tester_name` SET TAGS ('dbx_business_glossary_term' = 'Tester Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `total_test_cases` SET TAGS ('dbx_business_glossary_term' = 'Total Test Cases');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `transaction_set` SET TAGS ('dbx_business_glossary_term' = 'Transaction Set');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` SET TAGS ('dbx_subdomain' = 'public_reporting');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `promoting_interoperability_id` SET TAGS ('dbx_business_glossary_term' = 'Promoting Interoperability (PI) Record ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Organization ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `prior_promoting_interoperability_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Promoting Interoperability Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `prior_promoting_interoperability_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `apm_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Alternative Payment Model (APM) Participation Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `attestation_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Attestation Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `attestation_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `attestation_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `attestation_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `attestation_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Attestation Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `attestation_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `attestation_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `attestation_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Attestation Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `attestation_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `attestation_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `attestation_date` SET TAGS ('dbx_business_glossary_term' = 'Attestation Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `attestation_method` SET TAGS ('dbx_business_glossary_term' = 'Attestation Method');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `attestation_method` SET TAGS ('dbx_value_regex' = 'cms_web_interface|qpp_portal|ehr_direct_submission|registry|qcdr|api');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `attestation_status` SET TAGS ('dbx_business_glossary_term' = 'Attestation Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `attestation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|submitted|accepted|rejected|pending_review');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `bonus_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Bonus Points Earned');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `cms_program_year` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Program Year');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `data_completeness_percentage` SET TAGS ('dbx_business_glossary_term' = 'Data Completeness Percentage');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `data_completeness_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `denominator_count` SET TAGS ('dbx_business_glossary_term' = 'Denominator Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `ehr_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Health Record (EHR) Certification ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `ehr_product_version` SET TAGS ('dbx_business_glossary_term' = 'Electronic Health Record (EHR) Product Version');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `ehr_vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Electronic Health Record (EHR) Vendor Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `exclusion_count` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `hardship_exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Hardship Exception Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `hardship_exception_reason` SET TAGS ('dbx_business_glossary_term' = 'Hardship Exception Reason');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `measure_category` SET TAGS ('dbx_business_glossary_term' = 'Measure Category');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `measure_identifier` SET TAGS ('dbx_business_glossary_term' = 'Measure Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `measure_name` SET TAGS ('dbx_business_glossary_term' = 'Measure Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `measure_weight` SET TAGS ('dbx_business_glossary_term' = 'Measure Weight');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `mips_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Merit-based Incentive Payment System (MIPS) Participation Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `numerator_count` SET TAGS ('dbx_business_glossary_term' = 'Numerator Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `payment_adjustment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Payment Adjustment Percentage');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `payment_adjustment_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `performance_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Met Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `performance_rate` SET TAGS ('dbx_business_glossary_term' = 'Performance Rate');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Reporting Entity Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_entity_type` SET TAGS ('dbx_value_regex' = 'eligible_clinician|eligible_hospital|critical_access_hospital|group_practice|apm_entity');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `submission_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Confirmation Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Threshold Percentage');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `threshold_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `tin` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `tin` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `tin` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `tin` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `validation_errors` SET TAGS ('dbx_business_glossary_term' = 'Validation Errors');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'not_validated|passed|failed|pending');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` SET TAGS ('dbx_subdomain' = 'public_reporting');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `public_health_report_id` SET TAGS ('dbx_business_glossary_term' = 'Public Health Report Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `public_health_report_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `public_health_report_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Code Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `corrected_public_health_report_id` SET TAGS ('dbx_business_glossary_term' = 'Corrected Public Health Report Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `corrected_public_health_report_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `corrected_public_health_report_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `corrected_public_health_report_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `data_use_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Data Use Agreement Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `exchange_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Standard Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `immunization_id` SET TAGS ('dbx_business_glossary_term' = 'Immunization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `interface_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Channel Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `measure_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `acknowledgment_code` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `acknowledgment_payload` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Payload');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `attestation_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Attestation Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `case_count` SET TAGS ('dbx_business_glossary_term' = 'Case Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `encryption_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `error_description` SET TAGS ('dbx_business_glossary_term' = 'Error Description');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Jurisdiction Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `message_payload` SET TAGS ('dbx_business_glossary_term' = 'Message Payload');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `message_payload` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `message_payload` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `phi_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Included Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `promoting_interoperability_measure` SET TAGS ('dbx_business_glossary_term' = 'Promoting Interoperability Measure');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `report_identifier` SET TAGS ('dbx_business_glossary_term' = 'Report Business Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Public Health Report Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'ELR|IIS|syndromic_surveillance|cancer_registry|vital_records|reportable_condition');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `reporting_agency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Agency Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `reporting_agency_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `reporting_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Reporting Agency Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `reporting_agency_name` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `submission_source_system` SET TAGS ('dbx_business_glossary_term' = 'Submission Source System');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|pending|acknowledged|error');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `transmission_method` SET TAGS ('dbx_business_glossary_term' = 'Transmission Method');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `transmission_method` SET TAGS ('dbx_value_regex' = 'HTTPS|SFTP|Direct|SOAP|REST|MLLP');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` SET TAGS ('dbx_subdomain' = 'public_reporting');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `care_transition_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Care Transition Notification ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Attending Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `hie_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Health Information Exchange (HIE) Transaction ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `interface_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Channel ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `direct_address_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient Direct Address Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `direct_address_id` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `direct_address_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `direct_address_id` SET TAGS ('dbx_pii_contact' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Appointment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `superseded_care_transition_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Care Transition Notification Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `superseded_care_transition_notification_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `acknowledgment_code` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `acknowledgment_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Received Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `actual_delivery_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Minutes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `attending_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Attending Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `attending_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `care_coordination_purpose` SET TAGS ('dbx_business_glossary_term' = 'Care Coordination Purpose');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `cms_interoperability_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Interoperability Compliant Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `delivery_attempt_count` SET TAGS ('dbx_business_glossary_term' = 'Delivery Attempt Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'sent|delivered|failed|pending|acknowledged|rejected');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `discharge_disposition` SET TAGS ('dbx_business_glossary_term' = 'Discharge Disposition');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `encryption_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Encryption Applied Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Admit Discharge Transfer (ADT) Event Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'admission|discharge|transfer|ed_visit|observation_admission|inpatient_admission');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `message_standard` SET TAGS ('dbx_business_glossary_term' = 'Message Standard');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `message_standard` SET TAGS ('dbx_value_regex' = 'hl7v2|fhir_r4|fhir_r5|cda_r2|ccda|proprietary');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `message_standard` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `message_type_code` SET TAGS ('dbx_business_glossary_term' = 'Message Type Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `message_type_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `message_version` SET TAGS ('dbx_business_glossary_term' = 'Message Version');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `message_version` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `notification_content_summary` SET TAGS ('dbx_business_glossary_term' = 'Notification Content Summary');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `notification_control_number` SET TAGS ('dbx_business_glossary_term' = 'Notification Control ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `notification_priority` SET TAGS ('dbx_business_glossary_term' = 'Notification Priority');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `notification_priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat|emergency');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `notification_source_system` SET TAGS ('dbx_business_glossary_term' = 'Notification Source System');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_consent_status` SET TAGS ('dbx_business_glossary_term' = 'Patient Consent Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_consent_status` SET TAGS ('dbx_value_regex' = 'consented|declined|not_required|pending|revoked');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `payload_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Payload Size Bytes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `phi_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Included Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `primary_diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `primary_diagnosis_description` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Description');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `primary_diagnosis_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `primary_diagnosis_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `receiving_party_identifier` SET TAGS ('dbx_business_glossary_term' = 'Receiving Party Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `receiving_party_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Party Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `receiving_party_type` SET TAGS ('dbx_business_glossary_term' = 'Receiving Party Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `sending_facility_npi` SET TAGS ('dbx_business_glossary_term' = 'Sending Facility National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `sending_facility_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `sla_target_delivery_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Delivery Minutes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `transfer_from_location` SET TAGS ('dbx_business_glossary_term' = 'Transfer From Location');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `transfer_to_location` SET TAGS ('dbx_business_glossary_term' = 'Transfer To Location');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` SET TAGS ('dbx_subdomain' = 'health_exchange');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `hie_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Hie Transaction Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Demographics Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `demographics_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `hie_organization_id` SET TAGS ('dbx_business_glossary_term' = 'Hie Organization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `interface_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Channel Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `mapping_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Transformation Rule Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `parent_hie_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Transaction Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `primary_related_prior_hie_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Related Hie Transaction Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `primary_related_prior_hie_transaction_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `acknowledgment_code` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `business_purpose` SET TAGS ('dbx_business_glossary_term' = 'Business Purpose');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `correlation_identifier` SET TAGS ('dbx_business_glossary_term' = 'Correlation Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `destination_system_code` SET TAGS ('dbx_business_glossary_term' = 'Destination System Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `destination_system_name` SET TAGS ('dbx_business_glossary_term' = 'Destination System Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Direction');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Url');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `error_description` SET TAGS ('dbx_business_glossary_term' = 'Error Description');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `is_archived` SET TAGS ('dbx_business_glossary_term' = 'Is Archived');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `message_control_number` SET TAGS ('dbx_business_glossary_term' = 'Message Control Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `message_control_number` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `message_event_code` SET TAGS ('dbx_business_glossary_term' = 'Message Event Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `message_event_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `message_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Message Size Bytes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `message_size_bytes` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `message_standard` SET TAGS ('dbx_business_glossary_term' = 'Message Standard');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `message_standard` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `message_version` SET TAGS ('dbx_business_glossary_term' = 'Message Version');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `message_version` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `processing_duration_ms` SET TAGS ('dbx_business_glossary_term' = 'Processing Duration Ms');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `security_classification` SET TAGS ('dbx_business_glossary_term' = 'Security Classification');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `source_system_name` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `hie_transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `transformation_applied` SET TAGS ('dbx_business_glossary_term' = 'Transformation Applied');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `transmission_protocol` SET TAGS ('dbx_business_glossary_term' = 'Transmission Protocol');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` SET TAGS ('dbx_subdomain' = 'health_exchange');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `data_sharing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Agreement Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `interface_engine_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Engine Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `superseded_data_sharing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Data Sharing Agreement Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `superseded_data_sharing_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `audit_logging_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Logging Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `breach_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Breach Notification Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `breach_notification_timeframe_hours` SET TAGS ('dbx_business_glossary_term' = 'Breach Notification Timeframe Hours');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `compliance_review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Frequency Days');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `consent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `data_categories_shared` SET TAGS ('dbx_business_glossary_term' = 'Data Categories Shared');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `data_exchange_direction` SET TAGS ('dbx_business_glossary_term' = 'Data Exchange Direction');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `data_exchange_standard` SET TAGS ('dbx_business_glossary_term' = 'Data Exchange Standard');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `data_quality_standards` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Standards');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period Days');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `data_use_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Data Use Restrictions');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `encryption_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Encryption Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `hipaa_business_associate_flag` SET TAGS ('dbx_business_glossary_term' = 'Hipaa Business Associate Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `last_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Review Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `next_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Compliance Review Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `partner_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `partner_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `partner_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `partner_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `partner_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `partner_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `partner_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `partner_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `partner_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `phi_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Phi Included Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `purpose_of_use` SET TAGS ('dbx_business_glossary_term' = 'Purpose Of Use');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `renewal_notification_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notification Days');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `security_requirements` SET TAGS ('dbx_business_glossary_term' = 'Security Requirements');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `transmission_frequency` SET TAGS ('dbx_business_glossary_term' = 'Transmission Frequency');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `transmission_method` SET TAGS ('dbx_business_glossary_term' = 'Transmission Method');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` SET TAGS ('dbx_subdomain' = 'health_exchange');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `hie_organization_id` SET TAGS ('dbx_business_glossary_term' = 'Hie Organization Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `parent_hie_organization_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Hie Organization Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `parent_hie_organization_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `authentication_method` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `carequality_participant` SET TAGS ('dbx_business_glossary_term' = 'Carequality Participant');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `commonwell_participant` SET TAGS ('dbx_business_glossary_term' = 'Commonwell Participant');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `data_sharing_agreement_date` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Agreement Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `data_sharing_agreement_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Agreement Expiry Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `data_sharing_agreement_signed` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Agreement Signed');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `direct_trust_bundle_enabled` SET TAGS ('dbx_business_glossary_term' = 'Direct Trust Bundle Enabled');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `endpoint_protocol` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Protocol');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Url');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `hipaa_compliant` SET TAGS ('dbx_business_glossary_term' = 'Hipaa Compliant');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `interface_engine_type` SET TAGS ('dbx_business_glossary_term' = 'Interface Engine Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `last_successful_exchange_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Successful Exchange Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `message_volume_monthly_avg` SET TAGS ('dbx_business_glossary_term' = 'Message Volume Monthly Avg');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `message_volume_monthly_avg` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `organization_identifier` SET TAGS ('dbx_business_glossary_term' = 'Organization Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `organization_name` SET TAGS ('dbx_business_glossary_term' = 'Organization Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `organization_type` SET TAGS ('dbx_business_glossary_term' = 'Organization Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `participation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Participation End Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `participation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Start Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `supported_cda_versions` SET TAGS ('dbx_business_glossary_term' = 'Supported Cda Versions');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `supported_fhir_versions` SET TAGS ('dbx_business_glossary_term' = 'Supported Fhir Versions');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `supported_hl7v2_versions` SET TAGS ('dbx_business_glossary_term' = 'Supported Hl7v2 Versions');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `tefca_qhin_participant` SET TAGS ('dbx_business_glossary_term' = 'Tefca Qhin Participant');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` SET TAGS ('dbx_subdomain' = 'standards_terminology');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `mapping_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Mapping Definition Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `primary_superseded_by_mapping_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Mapping Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `exchange_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Source Exchange Standard Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `bidirectional_flag` SET TAGS ('dbx_business_glossary_term' = 'Bidirectional Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `cardinality_source` SET TAGS ('dbx_business_glossary_term' = 'Cardinality Source');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `cardinality_target` SET TAGS ('dbx_business_glossary_term' = 'Cardinality Target');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `complexity_score` SET TAGS ('dbx_business_glossary_term' = 'Complexity Score');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `conditional_logic` SET TAGS ('dbx_business_glossary_term' = 'Conditional Logic');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `contact_information` SET TAGS ('dbx_business_glossary_term' = 'Contact Information');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `contact_information` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `copyright_notice` SET TAGS ('dbx_business_glossary_term' = 'Copyright Notice');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `default_value` SET TAGS ('dbx_business_glossary_term' = 'Default Value');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation Url');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `equivalence_type` SET TAGS ('dbx_business_glossary_term' = 'Equivalence Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `error_handling_strategy` SET TAGS ('dbx_business_glossary_term' = 'Error Handling Strategy');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `experimental_flag` SET TAGS ('dbx_business_glossary_term' = 'Experimental Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `mapping_code` SET TAGS ('dbx_business_glossary_term' = 'Mapping Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `mapping_name` SET TAGS ('dbx_business_glossary_term' = 'Mapping Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `mapping_status` SET TAGS ('dbx_business_glossary_term' = 'Mapping Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `mapping_type` SET TAGS ('dbx_business_glossary_term' = 'Mapping Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `priority_order` SET TAGS ('dbx_business_glossary_term' = 'Priority Order');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `publisher_organization` SET TAGS ('dbx_business_glossary_term' = 'Publisher Organization');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `purpose_description` SET TAGS ('dbx_business_glossary_term' = 'Purpose Description');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `source_data_type` SET TAGS ('dbx_business_glossary_term' = 'Source Data Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `source_element_path` SET TAGS ('dbx_business_glossary_term' = 'Source Element Path');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `source_standard` SET TAGS ('dbx_business_glossary_term' = 'Source Standard');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `source_version` SET TAGS ('dbx_business_glossary_term' = 'Source Version');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `target_data_type` SET TAGS ('dbx_business_glossary_term' = 'Target Data Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `target_element_path` SET TAGS ('dbx_business_glossary_term' = 'Target Element Path');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `target_standard` SET TAGS ('dbx_business_glossary_term' = 'Target Standard');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `target_version` SET TAGS ('dbx_business_glossary_term' = 'Target Version');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `test_case_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Case Reference');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `transformation_rule` SET TAGS ('dbx_business_glossary_term' = 'Transformation Rule');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `use_context` SET TAGS ('dbx_business_glossary_term' = 'Use Context');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `validation_rule` SET TAGS ('dbx_business_glossary_term' = 'Validation Rule');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` SET TAGS ('dbx_subdomain' = 'health_exchange');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `data_use_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Data Use Agreement Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `superseded_data_use_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Data Use Agreement Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `superseded_data_use_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `audit_rights` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `auto_renewal` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `breach_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Breach Notification Required');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `data_destruction_required` SET TAGS ('dbx_business_glossary_term' = 'Data Destruction Required');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `data_format` SET TAGS ('dbx_business_glossary_term' = 'Data Format');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `data_purpose` SET TAGS ('dbx_business_glossary_term' = 'Data Purpose');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period Days');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `data_scope` SET TAGS ('dbx_business_glossary_term' = 'Data Scope');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `data_transfer_method` SET TAGS ('dbx_business_glossary_term' = 'Data Transfer Method');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `irb_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Irb Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Irb Approval Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `legal_review_completed` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completed');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `permitted_disclosures` SET TAGS ('dbx_business_glossary_term' = 'Permitted Disclosures');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `prohibited_uses` SET TAGS ('dbx_business_glossary_term' = 'Prohibited Uses');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Recipient Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Recipient Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `renewal_eligible` SET TAGS ('dbx_business_glossary_term' = 'Renewal Eligible');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `security_requirements` SET TAGS ('dbx_business_glossary_term' = 'Security Requirements');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `signature_date_healthcare` SET TAGS ('dbx_business_glossary_term' = 'Signature Date Healthcare');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `signature_date_recipient` SET TAGS ('dbx_business_glossary_term' = 'Signature Date Recipient');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `signed_by_healthcare` SET TAGS ('dbx_business_glossary_term' = 'Signed By Healthcare');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `signed_by_healthcare` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `signed_by_healthcare` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `signed_by_recipient` SET TAGS ('dbx_business_glossary_term' = 'Signed By Recipient');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `signed_by_recipient` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `signed_by_recipient` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `data_use_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `transfer_frequency` SET TAGS ('dbx_business_glossary_term' = 'Transfer Frequency');
