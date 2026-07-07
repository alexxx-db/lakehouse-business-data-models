-- Schema for Domain: interoperability | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 06:46:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`interoperability` COMMENT 'Manages healthcare data exchange standards (HL7v2, FHIR, CDA), HIE participation, interface engine configurations, message tracking, and data transformation mappings for interoperability with external systems and health information exchanges.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` (
    `exchange_standard_id` BIGINT COMMENT 'Unique identifier for the exchange standard record.',
    `superseded_exchange_standard_id` BIGINT COMMENT 'Reference to the prior version that this standard supersedes.',
    `backward_compatibility` BOOLEAN COMMENT 'Indicates if this version is backward compatible with prior versions.',
    `certification_date` DATE COMMENT 'Date the standard version was certified by the governing body.',
    `certification_status` STRING COMMENT 'Current certification status (Certified, Pending, Expired).. Valid values are `certified|pending|not_required|failed`',
    `character_set` STRING COMMENT 'Character encoding used (UTF-8, ASCII, ISO-8859-1).',
    `conformance_profile` STRING COMMENT 'Specific conformance profile or implementation guide (e.g., US Core, C-CDA 2.1).',
    `contact_email` STRING COMMENT 'Email address of the standard maintainer or contact person.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_person` STRING COMMENT 'Name of the person responsible for the standard within the organization.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `documentation_url` STRING COMMENT 'URL to the official documentation or specification.',
    `effective_date` DATE COMMENT 'Date when the standard version became effective.',
    `encoding_format` STRING COMMENT 'Message encoding format (XML, JSON, pipe-delimited).. Valid values are `pipe_delimited|xml|json|edi|binary`',
    `end_date` DATE COMMENT 'Date when the standard version was deprecated or retired.',
    `exchange_standard_status` STRING COMMENT 'Lifecycle status (Active, Deprecated, Retired).. Valid values are `active|deprecated|retired|planned|testing`',
    `governing_body` STRING COMMENT 'Organization that governs the standard (HL7, NCPDP, X12).',
    `hie_participation` STRING COMMENT 'HIE networks that require or support this standard.',
    `interface_engine_support` STRING COMMENT 'Interface engines that support this standard version.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates if the standard is mandatory for regulatory compliance.',
    `message_types_supported` STRING COMMENT 'Comma-separated list of message types (ADT, ORM, ORU, etc.).',
    `migration_path` STRING COMMENT 'Recommended migration path to newer versions.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability exchange standard record.',
    `notes` STRING COMMENT 'Additional notes or comments.',
    `publication_date` DATE COMMENT 'Date the standard version was officially published.',
    `regulatory_requirement` STRING COMMENT 'Regulatory programs that require this standard (ONC, CMS, Meaningful Use).',
    `resource_types_supported` STRING COMMENT 'FHIR resource types supported (Patient, Observation, Condition).',
    `security_profile` STRING COMMENT 'Security profile or authentication method (SMART on FHIR, OAuth 2.0).',
    `specification_url` STRING COMMENT 'URL to the formal specification document.',
    `standard_code` STRING COMMENT 'Short code for the standard (HL7V2, FHIR, CDA, X12).',
    `standard_name` STRING COMMENT 'Full name of the standard (e.g., HL7 Version 2.5.1).',
    `standard_type` STRING COMMENT 'Type of standard (Messaging, Document, Terminology, Transport).. Valid values are `messaging|document|transaction|imaging|api`',
    `standard_version` STRING COMMENT 'The standard version of the interoperability exchange standard record.',
    `terminology_binding` STRING COMMENT 'Required terminology bindings (SNOMED CT, LOINC, RxNorm).',
    `testing_tool` STRING COMMENT 'Recommended testing or validation tool.',
    `transport_protocol` STRING COMMENT 'Transport protocol (MLLP, HTTPS, SFTP, Direct).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last updated.',
    `use_case_description` STRING COMMENT 'Description of primary use cases for this standard.',
    `validation_rules` STRING COMMENT 'Validation rules or schematron files.',
    `version` STRING COMMENT 'Version number of the standard (e.g., 2.5.1, R4, 2.1).',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_exchange_standard PRIMARY KEY(`exchange_standard_id`)
) COMMENT 'Registry of healthcare data exchange standards (HL7 v2, FHIR, CDA, X12) with version tracking, certification status, and conformance profiles.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` (
    `trading_partner_id` BIGINT COMMENT 'Unique identifier for the trading partner.',
    `interface_engine_id` BIGINT COMMENT 'Interface engine used for connectivity.',
    `org_provider_id` BIGINT COMMENT 'Link to the provider organization if the partner is a provider.',
    `parent_trading_partner_id` BIGINT COMMENT 'Reference to the parent trading partner for hierarchical relationships.',
    `active_flag` BOOLEAN COMMENT 'Indicates if the trading partner relationship is currently active.',
    `address_line_1` STRING COMMENT 'Street address line 1.',
    `address_line_2` STRING COMMENT 'Street address line 2.',
    `cda_endpoint_url` STRING COMMENT 'URL for CDA document exchange.',
    `certification_expiration_date` DATE COMMENT 'Date when the partners certification expires.',
    `certification_status` STRING COMMENT 'Certification status (Certified, Pending, Expired).. Valid values are `not_certified|in_certification|certified|expired`',
    `city` STRING COMMENT 'The city of the interoperability trading partner record.',
    `country_code` STRING COMMENT 'ISO country code.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `data_sharing_agreement_reference` STRING COMMENT 'Reference to the executed data sharing agreement.',
    `data_transformation_mapping_reference` STRING COMMENT 'Reference to the data transformation mapping document.',
    `direct_address` STRING COMMENT 'Direct messaging address.',
    `effective_end_date` DATE COMMENT 'Date when the trading partner relationship ended.',
    `effective_start_date` DATE COMMENT 'Date when the trading partner relationship began.',
    `exchange_volume_last_30_days` STRING COMMENT 'Number of messages exchanged in the last 30 days.',
    `fhir_endpoint_url` STRING COMMENT 'URL for FHIR API endpoint.',
    `hie_network_name` STRING COMMENT 'Name of the HIE network the partner participates in.',
    `hie_participation_flag` BOOLEAN COMMENT 'Indicates if the partner participates in an HIE.',
    `hl7v2_endpoint_url` STRING COMMENT 'URL or IP address for HL7 v2 messaging.',
    `last_successful_exchange_timestamp` TIMESTAMP COMMENT 'Timestamp of the last successful message exchange.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last updated.',
    `message_tracking_enabled_flag` BOOLEAN COMMENT 'Indicates if message tracking is enabled for this partner.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability trading partner record.',
    `notes` STRING COMMENT 'Additional notes or comments.',
    `npi` STRING COMMENT 'National Provider Identifier.. Valid values are `^[0-9]{10}$`',
    `oid` STRING COMMENT 'Object Identifier for the trading partner.',
    `onboarding_status` STRING COMMENT 'Current onboarding status (Planning, Testing, Live).. Valid values are `planning|in_progress|testing|active|suspended|terminated`',
    `operational_contact_email` STRING COMMENT 'Email address of the operational contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `operational_contact_name` STRING COMMENT 'Name of the operational contact.',
    `operational_contact_phone` STRING COMMENT 'Phone number of the operational contact.',
    `partner_name` STRING COMMENT 'Name of the trading partner organization.',
    `partner_type` STRING COMMENT 'Type of partner (HIE, Payer, Lab, Referring Provider, Pharmacy).',
    `postal_code` STRING COMMENT 'The postal code value classifying the interoperability trading partner record.',
    `sla_response_time_hours` DECIMAL(18,2) COMMENT 'SLA response time in hours.',
    `state_province` STRING COMMENT 'State or province.',
    `trading_partner_status` STRING COMMENT 'The trading partner status value classifying the interoperability trading partner record.',
    `supported_standards` STRING COMMENT 'Comma-separated list of supported standards.',
    `technical_contact_email` STRING COMMENT 'Email address of the technical contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `technical_contact_name` STRING COMMENT 'Name of the technical contact.',
    `technical_contact_phone` STRING COMMENT 'Phone number of the technical contact.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the interoperability trading partner record.',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the interoperability trading partner record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_trading_partner PRIMARY KEY(`trading_partner_id`)
) COMMENT 'Registry of external organizations that exchange data with the health system, including HIE participants, payers, labs, and referring providers.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` (
    `interface_engine_id` BIGINT COMMENT 'Unique identifier for the interface engine.',
    `care_site_id` BIGINT COMMENT 'Care site where the engine is deployed.',
    `replaced_interface_engine_id` BIGINT COMMENT 'Reference to the engine that this engine replaced.',
    `admin_url` STRING COMMENT 'URL to the administrative console.',
    `audit_logging_enabled` BOOLEAN COMMENT 'Indicates if audit logging is enabled.',
    `cloud_provider` STRING COMMENT 'Cloud provider if hosted in the cloud (AWS, Azure, GCP).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `decommission_date` DATE COMMENT 'Date when the engine was decommissioned.',
    `deployment_environment` STRING COMMENT 'Environment (Production, Test, Development).. Valid values are `production|staging|development|test|disaster_recovery|sandbox`',
    `disaster_recovery_enabled` BOOLEAN COMMENT 'Indicates if disaster recovery is enabled.',
    `encryption_enabled` BOOLEAN COMMENT 'Indicates if encryption is enabled.',
    `engine_code` STRING COMMENT 'Short code for the engine.',
    `engine_name` STRING COMMENT 'Name of the interface engine.',
    `fhir_version_support` STRING COMMENT 'FHIR versions supported (R4, STU3).',
    `go_live_date` DATE COMMENT 'Date when the engine went live.',
    `high_availability_enabled` BOOLEAN COMMENT 'Indicates if high availability is enabled.',
    `hipaa_compliant` BOOLEAN COMMENT 'Indicates if the engine is HIPAA compliant.',
    `hitrust_certified` BOOLEAN COMMENT 'Indicates if the engine is HITRUST certified.',
    `hl7_version_support` STRING COMMENT 'HL7 v2 versions supported (2.3, 2.5.1).',
    `hosting_model` STRING COMMENT 'Hosting model (On-Premise, Cloud, Hybrid).. Valid values are `on_premise|cloud|hybrid|saas|paas|iaas`',
    `installation_date` DATE COMMENT 'Date when the engine was installed.',
    `last_maintenance_date` DATE COMMENT 'Date of the last maintenance activity.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last updated.',
    `license_expiration_date` DATE COMMENT 'Date when the license expires.',
    `license_type` STRING COMMENT 'Type of license (Perpetual, Subscription).. Valid values are `perpetual|subscription|open_source|enterprise|community|trial`',
    `max_concurrent_connections` STRING COMMENT 'Maximum number of concurrent connections.',
    `message_throughput_capacity` STRING COMMENT 'Maximum message throughput per hour.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability interface engine record.',
    `next_scheduled_maintenance_date` DATE COMMENT 'Date of the next scheduled maintenance.',
    `notes` STRING COMMENT 'Additional notes or comments.',
    `operational_status` STRING COMMENT 'Current operational status (Active, Inactive, Maintenance).. Valid values are `active|inactive|maintenance|decommissioned|planned|suspended`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary contact.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary contact.',
    `primary_hostname` STRING COMMENT 'Primary hostname or FQDN.',
    `primary_ip_address` STRING COMMENT 'The primary ip address of the interoperability interface engine record.',
    `product_name` STRING COMMENT 'Product name (Rhapsody, Mirth, Cloverleaf, Ensemble).',
    `responsible_team` STRING COMMENT 'Team responsible for the engine.',
    `interface_engine_status` STRING COMMENT 'The interface engine status value classifying the interoperability interface engine record.',
    `support_contract_expiration_date` DATE COMMENT 'Date when the support contract expires.',
    `support_contract_status` STRING COMMENT 'Status of the support contract (Active, Expired).. Valid values are `active|expired|pending_renewal|not_applicable`',
    `supported_protocols` STRING COMMENT 'Comma-separated list of supported protocols (MLLP, HTTPS, SFTP).',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the interoperability interface engine record.',
    `vendor_name` STRING COMMENT 'The vendor name of the interoperability interface engine record.',
    `version` STRING COMMENT 'Version number of the engine.',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_interface_engine PRIMARY KEY(`interface_engine_id`)
) COMMENT 'Registry of interface engines (middleware platforms) that route, transform, and monitor healthcare data exchanges.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` (
    `interface_channel_id` BIGINT COMMENT 'Unique identifier for the interface channel configuration. Primary key for the interface channel master record.',
    `exchange_standard_id` BIGINT COMMENT 'Foreign key linking to interoperability.exchange_standard. Business justification: Interface channels implement specific exchange standards (HL7v2, FHIR, CDA, X12, etc.). Currently this is captured as STRING columns message_standard and message_version. Adding exchange_standard_id F',
    `interface_engine_id` BIGINT COMMENT 'FK to interface engine',
    `replaced_interface_channel_id` BIGINT COMMENT 'Self-referencing FK on interface_channel (replaced_interface_channel_id)',
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
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability interface channel record.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this interface channel configuration, performance, and business requirements.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special configuration details, known issues, or business context related to this interface channel.',
    `phi_transmitted_flag` BOOLEAN COMMENT 'Indicates whether this interface channel transmits Protected Health Information subject to HIPAA privacy and security regulations, requiring enhanced monitoring and audit controls.',
    `retry_interval_seconds` STRING COMMENT 'Time interval in seconds between automatic retry attempts for failed message transmissions.',
    `sla_tier` STRING COMMENT 'Priority tier assigned to this interface channel defining expected uptime, response time, and support escalation procedures. Critical tier for life-safety interfaces (e.g., ED admissions), standard for routine reporting.. Valid values are `critical|high|standard|low`',
    `sla_uptime_target_percent` DECIMAL(18,2) COMMENT 'Target uptime percentage defined in the service level agreement for this interface channel (e.g., 99.9% for critical interfaces, 99.0% for standard).',
    `source_facility_identifier` STRING COMMENT 'Identifier of the source facility or organization sending messages, often corresponding to the MSH-4 sending facility field in HL7v2 messages.',
    `source_system_identifier` STRING COMMENT 'Technical identifier or code for the source system as configured in the interface engine, often corresponding to the MSH-3 sending application field in HL7v2 messages.',
    `source_system_name` STRING COMMENT 'Name of the originating system or application that sends messages through this interface channel (e.g., Epic EHR, Cerner Millennium, MEDITECH, PACS).',
    `interface_channel_status` STRING COMMENT 'The interface channel status value classifying the interoperability interface channel record.',
    `support_contact_email` STRING COMMENT 'Primary email address for technical support escalation and incident notification related to this interface channel.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `support_contact_phone` STRING COMMENT 'Primary phone number for technical support escalation and incident notification related to this interface channel.',
    `technical_owner_name` STRING COMMENT 'Name of the technical team or individual responsible for configuration, maintenance, and troubleshooting of this interface channel.',
    `transformation_map_name` STRING COMMENT 'Name of the data transformation or mapping configuration applied to messages passing through this channel to convert between different formats, vocabularies, or data structures.',
    `transport_protocol` STRING COMMENT 'Network transport protocol used by the interface channel to transmit messages between source and destination systems. MLLP (Minimal Lower Layer Protocol) is standard for HL7v2, while HTTP/HTTPS/REST are common for FHIR. [ENUM-REF-CANDIDATE: MLLP|HTTP|HTTPS|SFTP|FTP|SOAP|REST|TCP|DICOM — 9 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this interface channel record was last modified.',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
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
    `message_status` STRING COMMENT 'The message status value classifying the interoperability message log record.',
    `message_timestamp` TIMESTAMP COMMENT 'The date and time when the message was originally created by the sending system. Corresponds to MSH-7 in HL7 v2.x. This is the business event timestamp, distinct from processing timestamps.',
    `message_type` STRING COMMENT 'The type and trigger event of the healthcare message in standard format (e.g., ADT^A01 for patient admission, ORU^R01 for observation result, DFT^P03 for charge posting, SIU^S12 for appointment notification). Corresponds to MSH-9 in HL7 v2.x.',
    `message_version` STRING COMMENT 'Version of the messaging standard used (e.g., 2.3, 2.5.1, 2.7 for HL7 v2.x; R4, STU3 for FHIR; Release 2 for CDA). Corresponds to MSH-12 in HL7 v2.x.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability message log record.',
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
    `message_log_status` STRING COMMENT 'The message log status value classifying the interoperability message log record.',
    `transformation_applied` BOOLEAN COMMENT 'Indicates whether data transformation or mapping rules were applied to the message during processing (e.g., code set translation, field mapping, data enrichment). True if transformations were applied, False if message was passed through unchanged.',
    `transport_protocol` STRING COMMENT 'The network transport protocol used to transmit the message. MLLP=Minimal Lower Layer Protocol (standard for HL7 v2.x), HTTP/HTTPS for FHIR REST APIs, SFTP/FTP for batch file transfers, SOAP for legacy web services. [ENUM-REF-CANDIDATE: MLLP|HTTP|HTTPS|SFTP|FTP|REST|SOAP — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this message log record was last modified in the data warehouse. Updated when message status changes (e.g., from processing to processed, or when retry attempts occur).',
    `validation_errors` STRING COMMENT 'Detailed list of validation errors or warnings encountered during message validation. Includes schema violations, missing required fields, invalid code values, and business rule failures. Used for data quality monitoring and sender feedback.',
    `validation_status` STRING COMMENT 'Result of message validation against the applicable standard schema and business rules. Passed=all validations successful, Failed=validation errors prevent processing, Warning=non-critical validation issues, Not_Validated=validation was skipped.. Valid values are `passed|failed|warning|not_validated`',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the interoperability message log record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_message_log PRIMARY KEY(`message_log_id`)
) COMMENT 'Transactional log of every healthcare message processed through the interface engine infrastructure. Captures message control ID, message type (ADT^A01, ORU^R01, etc.), sending facility, receiving facility, message timestamp, processing status (received/processed/acknowledged/errored/rejected), ACK code, error description, payload size, and processing latency. Serves as the operational audit trail for all HL7v2, FHIR, CDA, and X12 message traffic. Critical for SLA monitoring, error investigation, and compliance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` (
    `message_error_id` BIGINT COMMENT 'Unique identifier for the message error record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the interface analyst, support engineer, or team member assigned to investigate and resolve the error.',
    `interface_channel_id` BIGINT COMMENT 'Reference to the interface engine channel or route where the error occurred.',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: Every message error is associated with a specific message log entry. Currently message_error uses message_control_id (STRING) to reference the message, but this is a weak reference. Adding message_log',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Interface error resolution workflows require patient context to assess clinical impact and prioritize remediation. Patient safety investigations trace errors to affected patients. message_error has pa',
    `parent_message_error_id` BIGINT COMMENT 'Self-referencing FK on message_error (related_message_error_id)',
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
    `error_type` STRING COMMENT 'The error type value classifying the interoperability message error record.',
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
    `message_error_status` STRING COMMENT 'The message error status value classifying the interoperability message error record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the interoperability message error record.',
    `validation_rule_violated` STRING COMMENT 'The specific business or technical validation rule that was violated, causing the error (e.g., required field missing, invalid code value, referential integrity failure).',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
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
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability fhir endpoint record.',
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
    `fhir_endpoint_status` STRING COMMENT 'The fhir endpoint status value classifying the interoperability fhir endpoint record.',
    `supported_resource_types` STRING COMMENT 'Comma-separated list of FHIR resource types supported by this endpoint (e.g., Patient, Observation, Condition, MedicationRequest, Encounter, Coverage, ExplanationOfBenefit). Derived from the CapabilityStatement.',
    `total_requests_last_30_days` BIGINT COMMENT 'Total number of API requests received by this endpoint in the last 30 days. Used for usage analytics and capacity planning.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the interoperability fhir endpoint record.',
    `uptime_percentage` DECIMAL(18,2) COMMENT 'Calculated uptime percentage for this endpoint over a defined measurement period (typically 30 days). Used for Service Level Agreement (SLA) tracking and performance reporting.',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_fhir_endpoint PRIMARY KEY(`fhir_endpoint_id`)
) COMMENT 'Master record for every FHIR API endpoint registered and managed by the organization, including patient-facing SMART on FHIR apps, payer FHIR APIs (CMS Interoperability Rule), provider directory endpoints, and internal FHIR server instances. Captures endpoint URL, FHIR version (R4/STU3), capability statement URL, supported resource types, authentication method (OAuth2/SMART/API key), rate limits, CMS compliance flag (21st Century Cures Act), and operational status. SSOT for FHIR API inventory.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` (
    `fhir_resource_log_id` BIGINT COMMENT 'Unique identifier for each FHIR resource operation log entry. Primary key for the FHIR resource log.',
    `demographics_id` BIGINT COMMENT 'The Medical Record Number (MRN) or FHIR Patient resource ID representing the patient whose data is the subject of the API operation. Empty for non-patient-specific operations (e.g., Practitioner lookup). Required for Protected Health Information (PHI) access auditing per HIPAA.',
    `employee_id` BIGINT COMMENT 'Identifier of the end user or practitioner who initiated the FHIR API request through the client application. May be a National Provider Identifier (NPI), employee ID, or patient portal user ID. Critical for HIPAA audit trail and access accountability.',
    `fhir_endpoint_id` BIGINT COMMENT 'Foreign key linking to interoperability.fhir_endpoint. Business justification: FHIR resource operations are executed against specific FHIR endpoints. Linking fhir_resource_log to fhir_endpoint enables tracking which endpoint served each request, monitoring endpoint-specific perf',
    `parent_fhir_resource_log_id` BIGINT COMMENT 'Self-referencing FK on fhir_resource_log (related_fhir_resource_log_id)',
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
    `resource_type` STRING COMMENT 'The resource type value classifying the interoperability fhir resource log record.',
    `response_body_size_bytes` STRING COMMENT 'The size of the HTTP response body payload in bytes. Used for bandwidth monitoring and identifying large resource retrievals.',
    `response_time_ms` STRING COMMENT 'The elapsed time in milliseconds between request receipt and response transmission. Key performance indicator for FHIR API latency and service level agreement (SLA) monitoring.',
    `response_timestamp` TIMESTAMP COMMENT 'The date and time when the FHIR API response was sent back to the client. Used to calculate response time and monitor API performance.',
    `search_parameters` STRING COMMENT 'The query string parameters used in FHIR search operations (e.g., _id, _lastUpdated, patient, code). Captured for search pattern analysis and optimization.',
    `search_result_count` STRING COMMENT 'The number of FHIR resources returned in response to a search operation. Used to analyze search effectiveness and identify overly broad queries.',
    `source_ip_address` STRING COMMENT 'The IP address of the client that originated the FHIR API request. Used for security monitoring, access control, and geographic analysis. May be considered personally identifiable information (PII) in some jurisdictions.',
    `fhir_resource_log_status` STRING COMMENT 'The fhir resource log status value classifying the interoperability fhir resource log record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the interoperability fhir resource log record.',
    `user_agent` STRING COMMENT 'The HTTP User-Agent header value identifying the client software, operating system, and device type. Used for client compatibility analysis and troubleshooting.',
    `validation_errors` STRING COMMENT 'Detailed error messages or codes returned by the FHIR validator when conformance validation fails. Used for troubleshooting and data quality improvement.',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
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
    `mapping_rule_status` STRING COMMENT 'The mapping rule status value classifying the interoperability mapping rule record.',
    `target_code_system` STRING COMMENT 'The terminology or code system used in the target field. Examples: ICD-10, SNOMED CT, LOINC, NDC, CPT. Used for terminology mapping and value set translation.',
    `target_data_type` STRING COMMENT 'The data type of the target field as defined in the target system schema or message specification. Used for type conversion and validation.',
    `target_expression` STRING COMMENT 'The target field path, XPath, JSONPath, or HL7 segment/field reference that identifies where the transformed value should be written. May include assignment logic or functions.',
    `test_case_reference` STRING COMMENT 'Reference to the test case or test suite that validates this transformation rule. Links rule to quality assurance artifacts for regression testing and validation.',
    `transformation_function` STRING COMMENT 'The function, method, or algorithm applied to convert the source value to the target format. May reference built-in interface engine functions, custom scripts, or standard conversion routines.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the interoperability mapping rule record.',
    `validation_rule` STRING COMMENT 'Post-transformation validation expression or constraint that the target value must satisfy. Used to ensure data quality and conformance to target system requirements.',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
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
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability hie participation record.',
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
    `hie_participation_status` STRING COMMENT 'The hie participation status value classifying the interoperability hie participation record.',
    `supported_standards` STRING COMMENT 'List of interoperability standards supported for this HIE participation (e.g., HL7 v2.5.1, FHIR R4, CDA R2, Direct 1.1, IHE XDS).',
    `suspension_reason` STRING COMMENT 'Reason for suspension or termination of HIE participation (e.g., compliance violation, technical issues, voluntary withdrawal, contract expiration).',
    `technical_connection_type` STRING COMMENT 'Technical method used to connect to the HIE: Direct Messaging (SMTP/S-MIME), FHIR API, HL7v2 interface, CDA document exchange, or proprietary protocol.. Valid values are `direct_messaging|fhir_api|hl7v2_interface|cda_exchange|proprietary`',
    `technical_contact_email` STRING COMMENT 'Email address of the technical contact for HIE interface support.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `technical_contact_name` STRING COMMENT 'Name of the technical contact responsible for interface configuration and troubleshooting.',
    `technical_contact_phone` STRING COMMENT 'Phone number of the technical contact for HIE interface support.',
    `termination_date` DATE COMMENT 'Date when the organization formally ended participation in the HIE network.',
    `transaction_fee_model` STRING COMMENT 'Pricing model for HIE transactions: flat rate, per-transaction fee, tiered pricing based on volume, or no fee.. Valid values are `flat_rate|per_transaction|tiered|no_fee`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this HIE participation record was last updated in the system.',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_added` STRING COMMENT 'Added by VIBE mutation to satisfy target entity touch requirement',
    `vibe_mutation_marker` STRING COMMENT 'Marker added by VIBE mutator',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_hie_participation PRIMARY KEY(`hie_participation_id`)
) COMMENT 'Master record documenting the healthcare organizations formal participation in Health Information Exchanges (HIEs), including state HIEs, regional HIEs (CommonWell, Carequality, eHealth Exchange), and national networks. Captures HIE name, network type, participation tier (query/contribute/both), onboarding date, data sharing scope, patient consent model (opt-in/opt-out), technical connection type, compliance attestation date, and participation status. SSOT for HIE network membership.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` (
    `hie_query_id` BIGINT COMMENT 'Unique identifier for the hie query within the interoperability hie query record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the interoperability hie query record.',
    `consent_policy_id` BIGINT COMMENT 'Unique identifier for the consent policy within the interoperability hie query record.',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the interoperability hie query record.',
    `follow_up_hie_query_id` BIGINT COMMENT 'Unique identifier for the follow up hie query within the interoperability hie query record.',
    `hie_organization_id` BIGINT COMMENT 'Unique identifier for the hie organization within the interoperability hie query record.',
    `hie_participation_id` BIGINT COMMENT 'Unique identifier for the hie participation within the interoperability hie query record.',
    `interface_engine_id` BIGINT COMMENT 'Unique identifier for the interface engine within the interoperability hie query record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the primary hie care site within the interoperability hie query record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the interoperability hie query record.',
    `audit_logged` BOOLEAN COMMENT 'The audit logged of the interoperability hie query record.',
    `clinical_purpose_code` STRING COMMENT 'The clinical purpose code value classifying the interoperability hie query record.',
    `consent_verified` BOOLEAN COMMENT 'The consent verified of the interoperability hie query record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the interoperability hie query record.',
    `data_sensitivity_level` STRING COMMENT 'The data sensitivity level of the interoperability hie query record.',
    `documents_returned_count` STRING COMMENT 'The documents returned count of the interoperability hie query record.',
    `error_code` STRING COMMENT 'The error code value classifying the interoperability hie query record.',
    `error_message` STRING COMMENT 'The error message of the interoperability hie query record.',
    `hie_transaction_code` STRING COMMENT 'The hie transaction code value classifying the interoperability hie query record.',
    `initiating_facility_npi` STRING COMMENT 'The initiating facility npi of the interoperability hie query record.',
    `match_algorithm` STRING COMMENT 'The match algorithm of the interoperability hie query record.',
    `match_confidence_score` DECIMAL(18,2) COMMENT 'The match confidence score of the interoperability hie query record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability hie query record.',
    `notes` STRING COMMENT 'The notes of the interoperability hie query record.',
    `patient_date_of_birth` DATE COMMENT 'The patient date of birth of the interoperability hie query record.',
    `patient_first_name` STRING COMMENT 'The patient first name of the interoperability hie query record.',
    `patient_gender` STRING COMMENT 'The patient gender of the interoperability hie query record.',
    `patient_last_name` STRING COMMENT 'The patient last name of the interoperability hie query record.',
    `patient_mrn` STRING COMMENT 'The patient mrn of the interoperability hie query record.',
    `patient_ssn_last_four` STRING COMMENT 'The patient ssn last four of the interoperability hie query record.',
    `patient_zip_code` STRING COMMENT 'The patient zip code value classifying the interoperability hie query record.',
    `query_message_control_number` STRING COMMENT 'The query message control number of the interoperability hie query record.',
    `query_priority` STRING COMMENT 'The query priority of the interoperability hie query record.',
    `query_protocol` STRING COMMENT 'The query protocol of the interoperability hie query record.',
    `query_response_time_seconds` DECIMAL(18,2) COMMENT 'The query response time seconds of the interoperability hie query record.',
    `query_source_system` STRING COMMENT 'The query source system of the interoperability hie query record.',
    `query_status` STRING COMMENT 'The query status value classifying the interoperability hie query record.',
    `query_timestamp` TIMESTAMP COMMENT 'The query timestamp of the interoperability hie query record.',
    `query_type` STRING COMMENT 'The query type value classifying the interoperability hie query record.',
    `requesting_provider_npi` STRING COMMENT 'The requesting provider npi of the interoperability hie query record.',
    `responding_facility_npi` STRING COMMENT 'The responding facility npi of the interoperability hie query record.',
    `response_timestamp` TIMESTAMP COMMENT 'The response timestamp of the interoperability hie query record.',
    `retry_count` STRING COMMENT 'The retry count of the interoperability hie query record.',
    `hie_query_status` STRING COMMENT 'The hie query status value classifying the interoperability hie query record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the interoperability hie query record.',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutator to ensure change detection',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_hie_query PRIMARY KEY(`hie_query_id`)
) COMMENT 'Transactional record of every patient record query submitted to or received from an HIE network. Captures query timestamp, query type (patient discovery/document query/document retrieve), initiating facility, responding facility, patient demographics used for matching, match confidence score, number of documents returned, query response time, query status, and clinical purpose code. Supports care coordination analytics, HIE utilization reporting, and patient consent enforcement.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` (
    `cda_document_id` BIGINT COMMENT 'Unique identifier for the cda document within the interoperability cda document record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the author clinician within the interoperability cda document record.',
    `care_plan_id` BIGINT COMMENT 'Unique identifier for the care plan within the interoperability cda document record.',
    `consent_reference_id` BIGINT COMMENT 'Unique identifier for the consent reference within the interoperability cda document record.',
    `org_provider_id` BIGINT COMMENT 'Unique identifier for the custodian org provider within the interoperability cda document record.',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the interoperability cda document record.',
    `interface_channel_id` BIGINT COMMENT 'Unique identifier for the interface channel within the interoperability cda document record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the primary cda care site within the interoperability cda document record.',
    `superseded_cda_document_id` BIGINT COMMENT 'Unique identifier for the superseded cda document within the interoperability cda document record.',
    `trading_partner_id` BIGINT COMMENT 'Unique identifier for the trading partner within the interoperability cda document record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the interoperability cda document record.',
    `acknowledgment_status` STRING COMMENT 'The acknowledgment status value classifying the interoperability cda document record.',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'The acknowledgment timestamp of the interoperability cda document record.',
    `cda_version` STRING COMMENT 'The cda version of the interoperability cda document record.',
    `confidentiality_code` STRING COMMENT 'The confidentiality code value classifying the interoperability cda document record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the interoperability cda document record.',
    `document_creation_timestamp` TIMESTAMP COMMENT 'The document creation timestamp of the interoperability cda document record.',
    `document_hash` STRING COMMENT 'The document hash of the interoperability cda document record.',
    `document_size_bytes` BIGINT COMMENT 'The document size bytes of the interoperability cda document record.',
    `document_status` STRING COMMENT 'The document status value classifying the interoperability cda document record.',
    `document_title` STRING COMMENT 'The document title of the interoperability cda document record.',
    `document_type` STRING COMMENT 'The document type value classifying the interoperability cda document record.',
    `document_type_code` STRING COMMENT 'The document type code value classifying the interoperability cda document record.',
    `document_type_name` STRING COMMENT 'The document type name of the interoperability cda document record.',
    `document_unique_identifier` STRING COMMENT 'The document unique identifier of the interoperability cda document record.',
    `document_version_number` STRING COMMENT 'The document version number of the interoperability cda document record.',
    `exchange_direction` STRING COMMENT 'The exchange direction of the interoperability cda document record.',
    `hipaa_compliant_flag` BOOLEAN COMMENT 'The hipaa compliant flag of the interoperability cda document record.',
    `language_code` STRING COMMENT 'The language code value classifying the interoperability cda document record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability cda document record.',
    `notes` STRING COMMENT 'The notes of the interoperability cda document record.',
    `patient_mrn` STRING COMMENT 'The patient mrn of the interoperability cda document record.',
    `purpose_of_use_code` STRING COMMENT 'The purpose of use code value classifying the interoperability cda document record.',
    `receipt_timestamp` TIMESTAMP COMMENT 'The receipt timestamp of the interoperability cda document record.',
    `service_end_date` DATE COMMENT 'Timestamp capturing the service end date associated with the interoperability cda document record.',
    `service_start_date` DATE COMMENT 'Timestamp capturing the service start date associated with the interoperability cda document record.',
    `source_system_code` STRING COMMENT 'The source system code value classifying the interoperability cda document record.',
    `source_system_name` STRING COMMENT 'The source system name of the interoperability cda document record.',
    `cda_document_status` STRING COMMENT 'The cda document status value classifying the interoperability cda document record.',
    `storage_location_uri` STRING COMMENT 'The storage location uri of the interoperability cda document record.',
    `transmission_timestamp` TIMESTAMP COMMENT 'The transmission timestamp of the interoperability cda document record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the interoperability cda document record.',
    `validation_error_count` STRING COMMENT 'The validation error count of the interoperability cda document record.',
    `validation_status` STRING COMMENT 'The validation status value classifying the interoperability cda document record.',
    `validation_timestamp` TIMESTAMP COMMENT 'The validation timestamp of the interoperability cda document record.',
    `validation_warning_count` STRING COMMENT 'The validation warning count of the interoperability cda document record.',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutator to ensure change detection',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_cda_document PRIMARY KEY(`cda_document_id`)
) COMMENT 'Master record for every CDA (Clinical Document Architecture) document generated, received, or exchanged through the interoperability layer. Captures document type (CCD, C-CDA, QRDA I/III, Referral Note, Discharge Summary), document unique ID (OID), document creation timestamp, author facility, patient reference, CDA version, document status (draft/final/amended/deprecated), exchange direction (inbound/outbound), source system, and storage reference. SSOT for CDA document inventory.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` (
    `cda_validation_result_id` BIGINT COMMENT 'Unique identifier for the cda validation result within the interoperability cda validation result record.',
    `cda_document_id` BIGINT COMMENT 'Unique identifier for the cda document within the interoperability cda validation result record.',
    `revalidated_cda_validation_result_id` BIGINT COMMENT 'Unique identifier for the revalidated cda validation result within the interoperability cda validation result record.',
    `trading_partner_id` BIGINT COMMENT 'Unique identifier for the trading partner within the interoperability cda validation result record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the interoperability cda validation result record.',
    `certification_requirement_met` BOOLEAN COMMENT 'The certification requirement met of the interoperability cda validation result record.',
    `conformance_profile` STRING COMMENT 'The conformance profile of the interoperability cda validation result record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the interoperability cda validation result record.',
    `critical_error_list` STRING COMMENT 'The critical error list of the interoperability cda validation result record.',
    `destination_system` STRING COMMENT 'The destination system of the interoperability cda validation result record.',
    `document_author_npi` STRING COMMENT 'The document author npi of the interoperability cda validation result record.',
    `document_size_kb` DECIMAL(18,2) COMMENT 'The document size kb of the interoperability cda validation result record.',
    `document_type` STRING COMMENT 'The document type value classifying the interoperability cda validation result record.',
    `finding_details` STRING COMMENT 'The finding details of the interoperability cda validation result record.',
    `hie_network_name` STRING COMMENT 'The hie network name of the interoperability cda validation result record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the interoperability cda validation result record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability cda validation result record.',
    `notes` STRING COMMENT 'The notes of the interoperability cda validation result record.',
    `patient_mrn` STRING COMMENT 'The patient mrn of the interoperability cda validation result record.',
    `regulatory_submission_type` STRING COMMENT 'The regulatory submission type value classifying the interoperability cda validation result record.',
    `remediation_assigned_to` STRING COMMENT 'The remediation assigned to of the interoperability cda validation result record.',
    `remediation_completed_timestamp` TIMESTAMP COMMENT 'The remediation completed timestamp of the interoperability cda validation result record.',
    `remediation_required_flag` BOOLEAN COMMENT 'The remediation required flag of the interoperability cda validation result record.',
    `retry_count` STRING COMMENT 'The retry count of the interoperability cda validation result record.',
    `schema_validation_passed` BOOLEAN COMMENT 'The schema validation passed of the interoperability cda validation result record.',
    `schematron_validation_passed` BOOLEAN COMMENT 'The schematron validation passed of the interoperability cda validation result record.',
    `cda_validation_result_status` STRING COMMENT 'The cda validation result status value classifying the interoperability cda validation result record.',
    `structural_validation_passed` BOOLEAN COMMENT 'The structural validation passed of the interoperability cda validation result record.',
    `submission_readiness_flag` BOOLEAN COMMENT 'The submission readiness flag of the interoperability cda validation result record.',
    `total_error_count` STRING COMMENT 'The total error count of the interoperability cda validation result record.',
    `total_informational_count` STRING COMMENT 'The total informational count of the interoperability cda validation result record.',
    `total_warning_count` STRING COMMENT 'The total warning count of the interoperability cda validation result record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the interoperability cda validation result record.',
    `validation_execution_time_ms` STRING COMMENT 'The validation execution time ms of the interoperability cda validation result record.',
    `validation_initiated_by` STRING COMMENT 'The validation initiated by of the interoperability cda validation result record.',
    `validation_purpose` STRING COMMENT 'The validation purpose of the interoperability cda validation result record.',
    `validation_status` STRING COMMENT 'The validation status value classifying the interoperability cda validation result record.',
    `validation_timestamp` TIMESTAMP COMMENT 'The validation timestamp of the interoperability cda validation result record.',
    `validator_tool_name` STRING COMMENT 'The validator tool name of the interoperability cda validation result record.',
    `validator_tool_version` STRING COMMENT 'The validator tool version of the interoperability cda validation result record.',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutator to ensure change detection',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `vocabulary_validation_passed` BOOLEAN COMMENT 'The vocabulary validation passed of the interoperability cda validation result record.',
    CONSTRAINT pk_cda_validation_result PRIMARY KEY(`cda_validation_result_id`)
) COMMENT 'Transactional record of CDA document conformance validation results produced by schematron validators and C-CDA validators. Captures validation timestamp, document reference, validator tool used, conformance profile tested (C-CDA 2.1, QRDA I, etc.), total errors, total warnings, total informational findings, overall pass/fail status, and structured finding details. Supports document quality assurance, trading partner onboarding, and regulatory submission readiness.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` (
    `patient_identity_match_id` BIGINT COMMENT 'Unique identifier for the patient identity match within the interoperability patient identity match record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the interoperability patient identity match record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee within the interoperability patient identity match record.',
    `hie_organization_id` BIGINT COMMENT 'Unique identifier for the hie organization within the interoperability patient identity match record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the patient matched empi mpi record within the interoperability patient identity match record.',
    `patient_mpi_record_id` BIGINT COMMENT 'Unique identifier for the patient mpi record within the interoperability patient identity match record.',
    `superseded_patient_identity_match_id` BIGINT COMMENT 'Unique identifier for the superseded patient identity match within the interoperability patient identity match record.',
    `candidate_count` STRING COMMENT 'The candidate count of the interoperability patient identity match record.',
    `consent_override_flag` BOOLEAN COMMENT 'The consent override flag of the interoperability patient identity match record.',
    `consent_override_reason` STRING COMMENT 'The consent override reason of the interoperability patient identity match record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the interoperability patient identity match record.',
    `duplicate_record_flag` BOOLEAN COMMENT 'The duplicate record flag of the interoperability patient identity match record.',
    `error_code` STRING COMMENT 'The error code value classifying the interoperability patient identity match record.',
    `error_message` STRING COMMENT 'The error message of the interoperability patient identity match record.',
    `hie_transaction_code` STRING COMMENT 'The hie transaction code value classifying the interoperability patient identity match record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the interoperability patient identity match record.',
    `manual_review_assigned_to` STRING COMMENT 'The manual review assigned to of the interoperability patient identity match record.',
    `manual_review_completed_timestamp` TIMESTAMP COMMENT 'The manual review completed timestamp of the interoperability patient identity match record.',
    `manual_review_notes` STRING COMMENT 'The manual review notes of the interoperability patient identity match record.',
    `manual_review_outcome` STRING COMMENT 'The manual review outcome of the interoperability patient identity match record.',
    `manual_review_required_flag` BOOLEAN COMMENT 'The manual review required flag of the interoperability patient identity match record.',
    `match_algorithm_code` STRING COMMENT 'The match algorithm code value classifying the interoperability patient identity match record.',
    `match_algorithm_version` STRING COMMENT 'The match algorithm version of the interoperability patient identity match record.',
    `match_confidence_level` STRING COMMENT 'The match confidence level of the interoperability patient identity match record.',
    `match_method` STRING COMMENT 'The match method of the interoperability patient identity match record.',
    `match_processing_time_ms` STRING COMMENT 'The match processing time ms of the interoperability patient identity match record.',
    `match_request_timestamp` TIMESTAMP COMMENT 'The match request timestamp of the interoperability patient identity match record.',
    `match_result_status` STRING COMMENT 'The match result status value classifying the interoperability patient identity match record.',
    `match_score` DECIMAL(18,2) COMMENT 'The match score of the interoperability patient identity match record.',
    `match_status` STRING COMMENT 'The match status value classifying the interoperability patient identity match record.',
    `matched_date_of_birth` DATE COMMENT 'The matched date of birth of the interoperability patient identity match record.',
    `matched_patient_first_name` STRING COMMENT 'The matched patient first name of the interoperability patient identity match record.',
    `matched_patient_last_name` STRING COMMENT 'The matched patient last name of the interoperability patient identity match record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability patient identity match record.',
    `requesting_user_npi` STRING COMMENT 'The requesting user npi of the interoperability patient identity match record.',
    `source_system_code` BIGINT COMMENT 'The source system code value classifying the interoperability patient identity match record.',
    `source_system_name` STRING COMMENT 'The source system name of the interoperability patient identity match record.',
    `patient_identity_match_status` STRING COMMENT 'The patient identity match status value classifying the interoperability patient identity match record.',
    `submitted_address_line_1` STRING COMMENT 'The submitted address line 1 of the interoperability patient identity match record.',
    `submitted_city` STRING COMMENT 'The submitted city of the interoperability patient identity match record.',
    `submitted_date_of_birth` DATE COMMENT 'The submitted date of birth of the interoperability patient identity match record.',
    `submitted_gender` STRING COMMENT 'The submitted gender of the interoperability patient identity match record.',
    `submitted_mrn` STRING COMMENT 'The submitted mrn of the interoperability patient identity match record.',
    `submitted_patient_first_name` STRING COMMENT 'The submitted patient first name of the interoperability patient identity match record.',
    `submitted_patient_last_name` STRING COMMENT 'The submitted patient last name of the interoperability patient identity match record.',
    `submitted_phone_number` STRING COMMENT 'The submitted phone number of the interoperability patient identity match record.',
    `submitted_postal_code` STRING COMMENT 'The submitted postal code value classifying the interoperability patient identity match record.',
    `submitted_ssn` STRING COMMENT 'The submitted ssn of the interoperability patient identity match record.',
    `submitted_state` STRING COMMENT 'The submitted state of the interoperability patient identity match record.',
    `transaction_type` STRING COMMENT 'The transaction type value classifying the interoperability patient identity match record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the interoperability patient identity match record.',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutator to ensure change detection',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_patient_identity_match PRIMARY KEY(`patient_identity_match_id`)
) COMMENT 'Transactional record of patient identity matching events performed during cross-organizational data exchange, including MPI (Master Patient Index) lookups, EMPI matching, and IHE PIX/PDQ transactions. Captures match request timestamp, source system, match algorithm used, candidate patient identifiers submitted, match score, match result (match/possible match/no match), matched MPI record reference, and manual review flag. Critical for preventing patient data mismatches during HIE queries and care transitions.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` (
    `direct_message_id` BIGINT COMMENT 'Unique identifier for the direct message within the interoperability direct message record.',
    `interface_engine_id` BIGINT COMMENT 'Unique identifier for the interface engine within the interoperability direct message record.',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the interoperability direct message record.',
    `replied_to_direct_message_id` BIGINT COMMENT 'Unique identifier for the replied to direct message within the interoperability direct message record.',
    `direct_address_id` BIGINT COMMENT 'Unique identifier for the sender direct address within the interoperability direct message record.',
    `trading_partner_id` BIGINT COMMENT 'Unique identifier for the trading partner within the interoperability direct message record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the interoperability direct message record.',
    `acknowledgment_code` STRING COMMENT 'The acknowledgment code value classifying the interoperability direct message record.',
    `attachment_count` STRING COMMENT 'The attachment count of the interoperability direct message record.',
    `attachment_types` STRING COMMENT 'The attachment types of the interoperability direct message record.',
    `certificate_validation_result` STRING COMMENT 'The certificate validation result of the interoperability direct message record.',
    `clinical_document_reference` STRING COMMENT 'The clinical document reference of the interoperability direct message record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the interoperability direct message record.',
    `delivery_status` STRING COMMENT 'The delivery status value classifying the interoperability direct message record.',
    `delivery_timestamp` TIMESTAMP COMMENT 'The delivery timestamp of the interoperability direct message record.',
    `encryption_algorithm` STRING COMMENT 'The encryption algorithm of the interoperability direct message record.',
    `encryption_status` STRING COMMENT 'The encryption status value classifying the interoperability direct message record.',
    `failure_reason` STRING COMMENT 'The failure reason of the interoperability direct message record.',
    `hie_network_name` STRING COMMENT 'The hie network name of the interoperability direct message record.',
    `hipaa_compliant` BOOLEAN COMMENT 'The hipaa compliant of the interoperability direct message record.',
    `meaningful_use_eligible` BOOLEAN COMMENT 'The meaningful use eligible of the interoperability direct message record.',
    `message_control_number` STRING COMMENT 'The message control number of the interoperability direct message record.',
    `message_priority` STRING COMMENT 'The message priority of the interoperability direct message record.',
    `message_size_bytes` BIGINT COMMENT 'The message size bytes of the interoperability direct message record.',
    `message_status` STRING COMMENT 'The message status value classifying the interoperability direct message record.',
    `message_type` STRING COMMENT 'The message type value classifying the interoperability direct message record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability direct message record.',
    `notes` STRING COMMENT 'The notes of the interoperability direct message record.',
    `patient_mrn` STRING COMMENT 'The patient mrn of the interoperability direct message record.',
    `read_receipt_received` BOOLEAN COMMENT 'The read receipt received of the interoperability direct message record.',
    `read_receipt_requested` BOOLEAN COMMENT 'The read receipt requested of the interoperability direct message record.',
    `read_timestamp` TIMESTAMP COMMENT 'The read timestamp of the interoperability direct message record.',
    `recipient_certificate_serial_number` STRING COMMENT 'The recipient certificate serial number of the interoperability direct message record.',
    `recipient_direct_address` STRING COMMENT 'The recipient direct address of the interoperability direct message record.',
    `recipient_npi` STRING COMMENT 'The recipient npi of the interoperability direct message record.',
    `recipient_organization_name` STRING COMMENT 'The recipient organization name of the interoperability direct message record.',
    `retry_count` STRING COMMENT 'The retry count of the interoperability direct message record.',
    `send_timestamp` TIMESTAMP COMMENT 'The send timestamp of the interoperability direct message record.',
    `sender_certificate_serial_number` STRING COMMENT 'The sender certificate serial number of the interoperability direct message record.',
    `direct_message_status` STRING COMMENT 'The direct message status value classifying the interoperability direct message record.',
    `subject_line` STRING COMMENT 'The subject line of the interoperability direct message record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the interoperability direct message record.',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutator to ensure change detection',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `workflow_status` STRING COMMENT 'The workflow status value classifying the interoperability direct message record.',
    CONSTRAINT pk_direct_message PRIMARY KEY(`direct_message_id`)
) COMMENT 'Transactional record of every Direct Secure Messaging transaction exchanged via the Direct Protocol (DirectTrust). Captures message ID, sender Direct address, recipient Direct address, message type (referral, care summary, lab result, discharge notification), send timestamp, delivery status (sent/delivered/failed/bounced), message size, encryption status, certificate validation result, and associated clinical document reference. Supports care coordination, referral workflows, and Meaningful Use/Promoting Interoperability attestation.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` (
    `direct_address_id` BIGINT COMMENT 'Unique identifier for the direct address within the interoperability direct address record.',
    `care_site_id` BIGINT COMMENT 'Unique identifier for the care site within the interoperability direct address record.',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the clinician within the interoperability direct address record.',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the demographics within the interoperability direct address record.',
    `replaced_direct_address_id` BIGINT COMMENT 'Unique identifier for the replaced direct address within the interoperability direct address record.',
    `activation_date` DATE COMMENT 'Timestamp capturing the activation date associated with the interoperability direct address record.',
    `address_status` STRING COMMENT 'The address status value classifying the interoperability direct address record.',
    `address_type` STRING COMMENT 'The address type value classifying the interoperability direct address record.',
    `administrative_contact_email` STRING COMMENT 'The administrative contact email of the interoperability direct address record.',
    `administrative_contact_name` STRING COMMENT 'The administrative contact name of the interoperability direct address record.',
    `administrative_contact_phone` STRING COMMENT 'The administrative contact phone of the interoperability direct address record.',
    `auto_renewal_enabled_flag` BOOLEAN COMMENT 'The auto renewal enabled flag of the interoperability direct address record.',
    `certificate_expiration_date` DATE COMMENT 'Timestamp capturing the certificate expiration date associated with the interoperability direct address record.',
    `certificate_issue_date` DATE COMMENT 'Timestamp capturing the certificate issue date associated with the interoperability direct address record.',
    `certificate_issuer_dn` STRING COMMENT 'The certificate issuer dn of the interoperability direct address record.',
    `certificate_serial_number` STRING COMMENT 'The certificate serial number of the interoperability direct address record.',
    `certificate_status` STRING COMMENT 'The certificate status value classifying the interoperability direct address record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the interoperability direct address record.',
    `deactivation_date` DATE COMMENT 'Timestamp capturing the deactivation date associated with the interoperability direct address record.',
    `department_name` STRING COMMENT 'The department name of the interoperability direct address record.',
    `direct_address` STRING COMMENT 'The direct address of the interoperability direct address record.',
    `display_name` STRING COMMENT 'The display name of the interoperability direct address record.',
    `encryption_algorithm` STRING COMMENT 'The encryption algorithm of the interoperability direct address record.',
    `hipaa_compliant_flag` BOOLEAN COMMENT 'The hipaa compliant flag of the interoperability direct address record.',
    `hisp_domain` STRING COMMENT 'The hisp domain of the interoperability direct address record.',
    `hisp_name` STRING COMMENT 'The hisp name of the interoperability direct address record.',
    `hitrust_certified_flag` BOOLEAN COMMENT 'The hitrust certified flag of the interoperability direct address record.',
    `last_message_received_timestamp` TIMESTAMP COMMENT 'The last message received timestamp of the interoperability direct address record.',
    `last_message_sent_timestamp` TIMESTAMP COMMENT 'The last message sent timestamp of the interoperability direct address record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the interoperability direct address record.',
    `message_volume_last_30_days` STRING COMMENT 'The message volume last 30 days of the interoperability direct address record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability direct address record.',
    `notes` STRING COMMENT 'The notes of the interoperability direct address record.',
    `notification_email` STRING COMMENT 'The notification email of the interoperability direct address record.',
    `npi` STRING COMMENT 'The npi of the interoperability direct address record.',
    `primary_use_case` STRING COMMENT 'The primary use case of the interoperability direct address record.',
    `signature_algorithm` STRING COMMENT 'The signature algorithm of the interoperability direct address record.',
    `specialty` STRING COMMENT 'The specialty of the interoperability direct address record.',
    `direct_address_status` STRING COMMENT 'The direct address status value classifying the interoperability direct address record.',
    `trust_bundle_membership_status` STRING COMMENT 'The trust bundle membership status value classifying the interoperability direct address record.',
    `trust_bundle_name` STRING COMMENT 'The trust bundle name of the interoperability direct address record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the interoperability direct address record.',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutator to ensure change detection',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_direct_address PRIMARY KEY(`direct_address_id`)
) COMMENT 'Master record for all Direct Secure Messaging addresses managed by or registered with the organization, including provider Direct addresses, facility Direct addresses, and patient Direct addresses. Captures Direct address (FQDN format), address type (provider/facility/patient), associated NPI or facility ID, certificate status, certificate expiration date, HISP (Health Information Service Provider) name, trust bundle membership, and activation status. SSOT for Direct address inventory.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` (
    `interface_sla_id` BIGINT COMMENT 'Unique identifier for the interface sla within the interoperability interface sla record.',
    `interface_channel_id` BIGINT COMMENT 'Unique identifier for the interface channel within the interoperability interface sla record.',
    `superseded_interface_sla_id` BIGINT COMMENT 'Unique identifier for the superseded interface sla within the interoperability interface sla record.',
    `trading_partner_id` BIGINT COMMENT 'Unique identifier for the trading partner within the interoperability interface sla record.',
    `alert_threshold_percent` DECIMAL(18,2) COMMENT 'The alert threshold percent of the interoperability interface sla record.',
    `auto_escalation_enabled_flag` BOOLEAN COMMENT 'The auto escalation enabled flag of the interoperability interface sla record.',
    `business_criticality` STRING COMMENT 'The business criticality of the interoperability interface sla record.',
    `compliance_framework` STRING COMMENT 'The compliance framework of the interoperability interface sla record.',
    `contract_reference` STRING COMMENT 'The contract reference of the interoperability interface sla record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the interoperability interface sla record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the interoperability interface sla record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the interoperability interface sla record.',
    `escalation_contact_email` STRING COMMENT 'The escalation contact email of the interoperability interface sla record.',
    `escalation_contact_name` STRING COMMENT 'The escalation contact name of the interoperability interface sla record.',
    `escalation_contact_phone` STRING COMMENT 'The escalation contact phone of the interoperability interface sla record.',
    `escalation_path` STRING COMMENT 'The escalation path of the interoperability interface sla record.',
    `last_review_date` DATE COMMENT 'Timestamp capturing the last review date associated with the interoperability interface sla record.',
    `max_error_rate_percent` DECIMAL(18,2) COMMENT 'The max error rate percent of the interoperability interface sla record.',
    `max_latency_ms` STRING COMMENT 'The max latency ms of the interoperability interface sla record.',
    `measurement_window_hours` STRING COMMENT 'The measurement window hours of the interoperability interface sla record.',
    `message_throughput_target` DECIMAL(18,2) COMMENT 'The message throughput target of the interoperability interface sla record.',
    `modified_by` STRING COMMENT 'The modified by of the interoperability interface sla record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability interface sla record.',
    `monitoring_enabled_flag` BOOLEAN COMMENT 'The monitoring enabled flag of the interoperability interface sla record.',
    `next_review_date` DATE COMMENT 'Timestamp capturing the next review date associated with the interoperability interface sla record.',
    `notes` STRING COMMENT 'The notes of the interoperability interface sla record.',
    `notification_email_list` STRING COMMENT 'The notification email list of the interoperability interface sla record.',
    `penalty_clause` STRING COMMENT 'The penalty clause of the interoperability interface sla record.',
    `primary_contact_email` STRING COMMENT 'The primary contact email of the interoperability interface sla record.',
    `primary_contact_name` STRING COMMENT 'The primary contact name of the interoperability interface sla record.',
    `primary_contact_phone` STRING COMMENT 'The primary contact phone of the interoperability interface sla record.',
    `reporting_frequency` STRING COMMENT 'The reporting frequency of the interoperability interface sla record.',
    `sla_code` STRING COMMENT 'The sla code value classifying the interoperability interface sla record.',
    `sla_name` STRING COMMENT 'The sla name of the interoperability interface sla record.',
    `sla_status` STRING COMMENT 'The sla status value classifying the interoperability interface sla record.',
    `sla_type` STRING COMMENT 'The sla type value classifying the interoperability interface sla record.',
    `interface_sla_status` STRING COMMENT 'The interface sla status value classifying the interoperability interface sla record.',
    `throughput_unit` STRING COMMENT 'The throughput unit of the interoperability interface sla record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the interoperability interface sla record.',
    `uptime_target_percent` DECIMAL(18,2) COMMENT 'The uptime target percent of the interoperability interface sla record.',
    `version` STRING COMMENT 'The version of the interoperability interface sla record.',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutator to ensure change detection',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `created_by` STRING COMMENT 'The created by of the interoperability interface sla record.',
    CONSTRAINT pk_interface_sla PRIMARY KEY(`interface_sla_id`)
) COMMENT 'Master record defining Service Level Agreement (SLA) targets for each interface channel or trading partner connection. Captures SLA name, associated channel or partner, message throughput target (messages/hour), maximum acceptable latency (ms), maximum error rate threshold (%), uptime target (%), alerting thresholds, escalation path, measurement window, and effective date. Enables proactive interface performance management and SLA breach alerting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` (
    `interface_downtime_id` BIGINT COMMENT 'Unique identifier for the interface downtime within the interoperability interface downtime record.',
    `fhir_endpoint_id` BIGINT COMMENT 'Unique identifier for the fhir endpoint within the interoperability interface downtime record.',
    `interface_channel_id` BIGINT COMMENT 'Unique identifier for the interface channel within the interoperability interface downtime record.',
    `interface_engine_id` BIGINT COMMENT 'Unique identifier for the interface engine within the interoperability interface downtime record.',
    `parent_interface_downtime_id` BIGINT COMMENT 'Unique identifier for the parent interface downtime within the interoperability interface downtime record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the primary interface employee within the interoperability interface downtime record.',
    `trading_partner_id` BIGINT COMMENT 'Unique identifier for the trading partner within the interoperability interface downtime record.',
    `actual_uptime_percentage` DECIMAL(18,2) COMMENT 'The actual uptime percentage of the interoperability interface downtime record.',
    `affected_channels_count` STRING COMMENT 'The affected channels count of the interoperability interface downtime record.',
    `affected_departments` STRING COMMENT 'The affected departments of the interoperability interface downtime record.',
    `affected_facilities` STRING COMMENT 'The affected facilities of the interoperability interface downtime record.',
    `affected_message_types` STRING COMMENT 'The affected message types of the interoperability interface downtime record.',
    `business_impact_description` STRING COMMENT 'The business impact description of the interoperability interface downtime record.',
    `change_request_reference` STRING COMMENT 'The change request reference of the interoperability interface downtime record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the interoperability interface downtime record.',
    `detection_method` STRING COMMENT 'The detection method of the interoperability interface downtime record.',
    `downtime_duration_minutes` DECIMAL(18,2) COMMENT 'The downtime duration minutes of the interoperability interface downtime record.',
    `downtime_end_timestamp` TIMESTAMP COMMENT 'The downtime end timestamp of the interoperability interface downtime record.',
    `downtime_event_number` STRING COMMENT 'The downtime event number of the interoperability interface downtime record.',
    `downtime_reason` STRING COMMENT 'The downtime reason of the interoperability interface downtime record.',
    `downtime_start_timestamp` TIMESTAMP COMMENT 'The downtime start timestamp of the interoperability interface downtime record.',
    `downtime_status` STRING COMMENT 'The downtime status value classifying the interoperability interface downtime record.',
    `downtime_type` STRING COMMENT 'The downtime type value classifying the interoperability interface downtime record.',
    `escalation_flag` BOOLEAN COMMENT 'The escalation flag of the interoperability interface downtime record.',
    `escalation_level` STRING COMMENT 'The escalation level of the interoperability interface downtime record.',
    `escalation_timestamp` TIMESTAMP COMMENT 'The escalation timestamp of the interoperability interface downtime record.',
    `impact_severity` STRING COMMENT 'The impact severity of the interoperability interface downtime record.',
    `incident_ticket_reference` STRING COMMENT 'The incident ticket reference of the interoperability interface downtime record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the interoperability interface downtime record.',
    `messages_lost_count` BIGINT COMMENT 'The messages lost count of the interoperability interface downtime record.',
    `messages_queued_count` BIGINT COMMENT 'The messages queued count of the interoperability interface downtime record.',
    `messages_replayed_count` BIGINT COMMENT 'The messages replayed count of the interoperability interface downtime record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability interface downtime record.',
    `notes` STRING COMMENT 'The notes of the interoperability interface downtime record.',
    `notification_sent_flag` BOOLEAN COMMENT 'The notification sent flag of the interoperability interface downtime record.',
    `notification_timestamp` TIMESTAMP COMMENT 'The notification timestamp of the interoperability interface downtime record.',
    `post_incident_review_completed_flag` BOOLEAN COMMENT 'The post incident review completed flag of the interoperability interface downtime record.',
    `post_incident_review_date` DATE COMMENT 'Timestamp capturing the post incident review date associated with the interoperability interface downtime record.',
    `preventive_actions` STRING COMMENT 'The preventive actions of the interoperability interface downtime record.',
    `problem_ticket_reference` STRING COMMENT 'The problem ticket reference of the interoperability interface downtime record.',
    `resolution_notes` STRING COMMENT 'The resolution notes of the interoperability interface downtime record.',
    `resolution_timestamp` TIMESTAMP COMMENT 'The resolution timestamp of the interoperability interface downtime record.',
    `root_cause_category` STRING COMMENT 'The root cause category of the interoperability interface downtime record.',
    `root_cause_description` STRING COMMENT 'The root cause description of the interoperability interface downtime record.',
    `sla_breach_flag` BOOLEAN COMMENT 'The sla breach flag of the interoperability interface downtime record.',
    `sla_target_uptime_percentage` DECIMAL(18,2) COMMENT 'The sla target uptime percentage of the interoperability interface downtime record.',
    `interface_downtime_status` STRING COMMENT 'The interface downtime status value classifying the interoperability interface downtime record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the interoperability interface downtime record.',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutator to ensure change detection',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `workaround_description` STRING COMMENT 'The workaround description of the interoperability interface downtime record.',
    `workaround_implemented_flag` BOOLEAN COMMENT 'The workaround implemented flag of the interoperability interface downtime record.',
    CONSTRAINT pk_interface_downtime PRIMARY KEY(`interface_downtime_id`)
) COMMENT 'Transactional record of every planned and unplanned interface downtime event affecting interface channels or trading partner connections. Captures downtime start timestamp, downtime end timestamp, downtime type (planned maintenance/unplanned outage/trading partner outage), affected channels, root cause, impact severity, messages queued during downtime, messages replayed after recovery, and incident ticket reference. Supports SLA reporting, root cause analysis, and operational resilience tracking.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` (
    `terminology_mapping_id` BIGINT COMMENT 'Unique identifier for the terminology mapping within the interoperability terminology mapping record.',
    `mapping_definition_id` BIGINT COMMENT 'Unique identifier for the mapping definition within the interoperability terminology mapping record.',
    `primary_superseded_by_terminology_mapping_id` BIGINT COMMENT 'Unique identifier for the primary superseded by terminology mapping within the interoperability terminology mapping record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the primary terminology employee within the interoperability terminology mapping record.',
    `cpt_code_id` BIGINT COMMENT 'Unique identifier for the source code cpt code within the interoperability terminology mapping record.',
    `hcpcs_code_id` BIGINT COMMENT 'Unique identifier for the source code hcpcs code within the interoperability terminology mapping record.',
    `icd_code_id` BIGINT COMMENT 'Unique identifier for the source code icd code within the interoperability terminology mapping record.',
    `loinc_code_id` BIGINT COMMENT 'Unique identifier for the source code loinc code within the interoperability terminology mapping record.',
    `ndc_drug_id` BIGINT COMMENT 'Unique identifier for the source code ndc drug within the interoperability terminology mapping record.',
    `code_set_version_id` BIGINT COMMENT 'Unique identifier for the source code set version within the interoperability terminology mapping record.',
    `snomed_concept_id` BIGINT COMMENT 'Unique identifier for the source code snomed concept within the interoperability terminology mapping record.',
    `target_code_set_version_id` BIGINT COMMENT 'Unique identifier for the target code set version within the interoperability terminology mapping record.',
    `exchange_standard_id` BIGINT COMMENT 'Unique identifier for the target exchange standard within the interoperability terminology mapping record.',
    `tertiary_terminology_modified_by_user_employee_id` BIGINT COMMENT 'Unique identifier for the tertiary terminology modified by user employee within the interoperability terminology mapping record.',
    `alternate_target_code_value` DECIMAL(18,2) COMMENT 'The alternate target code value of the interoperability terminology mapping record.',
    `alternate_target_display_name` STRING COMMENT 'The alternate target display name of the interoperability terminology mapping record.',
    `approval_timestamp` TIMESTAMP COMMENT 'The approval timestamp of the interoperability terminology mapping record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the interoperability terminology mapping record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the interoperability terminology mapping record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the interoperability terminology mapping record.',
    `equivalence_type` STRING COMMENT 'The equivalence type value classifying the interoperability terminology mapping record.',
    `error_count` BIGINT COMMENT 'The error count of the interoperability terminology mapping record.',
    `governance_approval_status` STRING COMMENT 'The governance approval status value classifying the interoperability terminology mapping record.',
    `is_bidirectional` BOOLEAN COMMENT 'Boolean flag indicating the is bidirectional status of the interoperability terminology mapping record.',
    `is_deprecated` BOOLEAN COMMENT 'Boolean flag indicating the is deprecated status of the interoperability terminology mapping record.',
    `last_review_date` DATE COMMENT 'Timestamp capturing the last review date associated with the interoperability terminology mapping record.',
    `map_confidence_score` DECIMAL(18,2) COMMENT 'The map confidence score of the interoperability terminology mapping record.',
    `mapping_code` STRING COMMENT 'The mapping code value classifying the interoperability terminology mapping record.',
    `mapping_confidence_score` DECIMAL(18,2) COMMENT 'The mapping confidence score of the interoperability terminology mapping record.',
    `mapping_method` STRING COMMENT 'The mapping method of the interoperability terminology mapping record.',
    `mapping_name` STRING COMMENT 'The mapping name of the interoperability terminology mapping record.',
    `mapping_priority` STRING COMMENT 'The mapping priority of the interoperability terminology mapping record.',
    `mapping_rationale` STRING COMMENT 'The mapping rationale of the interoperability terminology mapping record.',
    `mapping_relationship_type` STRING COMMENT 'The mapping relationship type value classifying the interoperability terminology mapping record.',
    `mapping_status` STRING COMMENT 'The mapping status value classifying the interoperability terminology mapping record.',
    `mapping_tool_name` STRING COMMENT 'The mapping tool name of the interoperability terminology mapping record.',
    `mapping_version` STRING COMMENT 'The mapping version of the interoperability terminology mapping record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability terminology mapping record.',
    `next_review_date` DATE COMMENT 'Timestamp capturing the next review date associated with the interoperability terminology mapping record.',
    `notes` STRING COMMENT 'The notes of the interoperability terminology mapping record.',
    `review_status` STRING COMMENT 'The review status value classifying the interoperability terminology mapping record.',
    `reviewed_by` STRING COMMENT 'The reviewed by of the interoperability terminology mapping record.',
    `reviewed_timestamp` TIMESTAMP COMMENT 'The reviewed timestamp of the interoperability terminology mapping record.',
    `source_code` STRING COMMENT 'The source code value classifying the interoperability terminology mapping record.',
    `source_code_display` STRING COMMENT 'The source code display of the interoperability terminology mapping record.',
    `source_code_system` STRING COMMENT 'The source code system of the interoperability terminology mapping record.',
    `source_code_system_version` STRING COMMENT 'The source code system version of the interoperability terminology mapping record.',
    `source_context` STRING COMMENT 'The source context of the interoperability terminology mapping record.',
    `terminology_mapping_status` STRING COMMENT 'The terminology mapping status value classifying the interoperability terminology mapping record.',
    `target_code` STRING COMMENT 'The target code value classifying the interoperability terminology mapping record.',
    `target_code_display` STRING COMMENT 'The target code display of the interoperability terminology mapping record.',
    `target_code_system` STRING COMMENT 'The target code system of the interoperability terminology mapping record.',
    `target_code_system_version` STRING COMMENT 'The target code system version of the interoperability terminology mapping record.',
    `target_code_value` DECIMAL(18,2) COMMENT 'The target code value of the interoperability terminology mapping record.',
    `target_context` STRING COMMENT 'The target context of the interoperability terminology mapping record.',
    `target_display_name` STRING COMMENT 'The target display name of the interoperability terminology mapping record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the interoperability terminology mapping record.',
    `usage_count` BIGINT COMMENT 'The usage count of the interoperability terminology mapping record.',
    `use_case_category` STRING COMMENT 'The use case category of the interoperability terminology mapping record.',
    `validation_status` STRING COMMENT 'The validation status value classifying the interoperability terminology mapping record.',
    `validation_timestamp` TIMESTAMP COMMENT 'The validation timestamp of the interoperability terminology mapping record.',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutator to ensure change detection',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_terminology_mapping PRIMARY KEY(`terminology_mapping_id`)
) COMMENT 'Master record for enterprise terminology translation mappings between local codes and standard terminologies (SNOMED CT, LOINC, RxNorm, ICD-10, CPT, CVX). Captures source code system, source code value, source display name, target code system, target code value, target display name, mapping relationship type (equivalent/broader/narrower/related), mapping confidence, effective date, expiration date, and governance approval status. Distinct from data_mapping (field-level) — this is value-level code translation.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` (
    `subscription_topic_id` BIGINT COMMENT 'Primary key',
    `fhir_endpoint_id` BIGINT COMMENT 'FK to FHIR endpoint',
    `superseded_subscription_topic_id` BIGINT COMMENT 'Unique identifier for the superseded subscription topic within the interoperability subscription topic record.',
    `trading_partner_id` BIGINT COMMENT 'Unique identifier for the trading partner within the interoperability subscription topic record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `subscription_topic_description` STRING COMMENT 'The subscription topic description of the interoperability subscription topic record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the interoperability subscription topic record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the interoperability subscription topic record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the interoperability subscription topic record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the interoperability subscription topic record.',
    `filter_criteria` STRING COMMENT 'The filter criteria of the interoperability subscription topic record.',
    `is_active_flag` BOOLEAN COMMENT 'Boolean flag indicating the is active flag status of the interoperability subscription topic record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability subscription topic record.',
    `notes` STRING COMMENT 'The notes of the interoperability subscription topic record.',
    `notification_shape` STRING COMMENT 'The notification shape of the interoperability subscription topic record.',
    `resource_type` STRING COMMENT 'FHIR resource type',
    `subscription_topic_status` STRING COMMENT 'Topic status',
    `topic_code` STRING COMMENT 'The topic code value classifying the interoperability subscription topic record.',
    `topic_description` STRING COMMENT 'The topic description of the interoperability subscription topic record.',
    `topic_name` STRING COMMENT 'The topic name of the interoperability subscription topic record.',
    `topic_status` STRING COMMENT 'The topic status value classifying the interoperability subscription topic record.',
    `topic_url` STRING COMMENT 'Subscription topic URL',
    `topic_version` STRING COMMENT 'The topic version of the interoperability subscription topic record.',
    `trigger_event` STRING COMMENT 'The trigger event of the interoperability subscription topic record.',
    `trigger_type` STRING COMMENT 'The trigger type value classifying the interoperability subscription topic record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the interoperability subscription topic record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_subscription_topic PRIMARY KEY(`subscription_topic_id`)
) COMMENT 'Master record for FHIR Subscription topics and HL7v2 event subscriptions configured to push notifications to external systems when specific clinical events occur (e.g., ADT notifications, lab result availability, care gap alerts). Captures topic name, trigger event type, FHIR resource filter criteria, notification channel type (REST-hook/websocket/email/FHIR messaging), subscriber endpoint, payload type (full-resource/id-only/empty), and subscription status. Supports event-driven interoperability and care coordination notifications.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` (
    `subscription_notification_id` BIGINT COMMENT 'Primary key',
    `fhir_endpoint_id` BIGINT COMMENT 'FK to FHIR endpoint',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the mpi record within the interoperability subscription notification record.',
    `parent_subscription_notification_id` BIGINT COMMENT 'Unique identifier for the parent subscription notification within the interoperability subscription notification record.',
    `subscription_topic_id` BIGINT COMMENT 'FK to subscription topic',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the interoperability subscription notification record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `delivery_status` STRING COMMENT 'The delivery status value classifying the interoperability subscription notification record.',
    `delivery_timestamp` TIMESTAMP COMMENT 'The delivery timestamp of the interoperability subscription notification record.',
    `error_code` STRING COMMENT 'Error code if failed',
    `error_message` STRING COMMENT 'The error message of the interoperability subscription notification record.',
    `event_focus_resource_type` STRING COMMENT 'The event focus resource type value classifying the interoperability subscription notification record.',
    `event_number` BIGINT COMMENT 'The event number of the interoperability subscription notification record.',
    `http_status_code` STRING COMMENT 'The http status code value classifying the interoperability subscription notification record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability subscription notification record.',
    `notes` STRING COMMENT 'The notes of the interoperability subscription notification record.',
    `notification_channel` STRING COMMENT 'The notification channel of the interoperability subscription notification record.',
    `notification_payload_type` STRING COMMENT 'The notification payload type value classifying the interoperability subscription notification record.',
    `notification_status` STRING COMMENT 'The notification status value classifying the interoperability subscription notification record.',
    `notification_timestamp` TIMESTAMP COMMENT 'The notification timestamp of the interoperability subscription notification record.',
    `notification_type` STRING COMMENT 'Type of notification',
    `patient_mrn` STRING COMMENT 'The patient mrn of the interoperability subscription notification record.',
    `payload_size_bytes` BIGINT COMMENT 'The payload size bytes of the interoperability subscription notification record.',
    `payload_type` STRING COMMENT 'The payload type value classifying the interoperability subscription notification record.',
    `resource_reference` STRING COMMENT 'FHIR resource ID',
    `resource_type` STRING COMMENT 'FHIR resource type',
    `retry_count` STRING COMMENT 'Number of retries',
    `subscription_notification_status` STRING COMMENT 'The subscription notification status value classifying the interoperability subscription notification record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the interoperability subscription notification record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_subscription_notification PRIMARY KEY(`subscription_notification_id`)
) COMMENT 'Transactional record of every event-driven notification dispatched to a subscriber endpoint via FHIR Subscription or HL7 event notification. Captures notification timestamp, subscription topic reference, triggering event type, triggering resource ID, subscriber endpoint, delivery status (sent/delivered/failed/retrying), HTTP response code, retry count, and payload reference. Enables monitoring of event-driven interoperability workflows and subscriber delivery reliability.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` (
    `onboarding_project_id` BIGINT COMMENT 'Unique identifier for the onboarding project within the interoperability onboarding project record.',
    `exchange_standard_id` BIGINT COMMENT 'Unique identifier for the exchange standard within the interoperability onboarding project record.',
    `hie_organization_id` BIGINT COMMENT 'Unique identifier for the hie organization within the interoperability onboarding project record.',
    `interface_engine_id` BIGINT COMMENT 'Unique identifier for the interface engine within the interoperability onboarding project record.',
    `org_provider_id` BIGINT COMMENT 'Unique identifier for the org provider within the interoperability onboarding project record.',
    `predecessor_onboarding_project_id` BIGINT COMMENT 'Unique identifier for the predecessor onboarding project within the interoperability onboarding project record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the project manager employee within the interoperability onboarding project record.',
    `trading_partner_id` BIGINT COMMENT 'Unique identifier for the trading partner within the interoperability onboarding project record.',
    `actual_cost` DECIMAL(18,2) COMMENT 'The actual cost of the interoperability onboarding project record.',
    `actual_go_live_date` DATE COMMENT 'Timestamp capturing the actual go live date associated with the interoperability onboarding project record.',
    `actual_start_date` DATE COMMENT 'Timestamp capturing the actual start date associated with the interoperability onboarding project record.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The budget amount of the interoperability onboarding project record.',
    `build_completion_date` DATE COMMENT 'Timestamp capturing the build completion date associated with the interoperability onboarding project record.',
    `business_owner_name` STRING COMMENT 'The business owner name of the interoperability onboarding project record.',
    `certification_date` DATE COMMENT 'Timestamp capturing the certification date associated with the interoperability onboarding project record.',
    `certification_required_flag` BOOLEAN COMMENT 'The certification required flag of the interoperability onboarding project record.',
    `certification_status` STRING COMMENT 'The certification status value classifying the interoperability onboarding project record.',
    `certification_type` STRING COMMENT 'The certification type value classifying the interoperability onboarding project record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the interoperability onboarding project record.',
    `data_sharing_agreement_date` DATE COMMENT 'Timestamp capturing the data sharing agreement date associated with the interoperability onboarding project record.',
    `data_sharing_agreement_signed_flag` BOOLEAN COMMENT 'The data sharing agreement signed flag of the interoperability onboarding project record.',
    `design_completion_date` DATE COMMENT 'Timestamp capturing the design completion date associated with the interoperability onboarding project record.',
    `discovery_completion_date` DATE COMMENT 'Timestamp capturing the discovery completion date associated with the interoperability onboarding project record.',
    `discovery_start_date` DATE COMMENT 'Timestamp capturing the discovery start date associated with the interoperability onboarding project record.',
    `estimated_budget` DECIMAL(18,2) COMMENT 'The estimated budget of the interoperability onboarding project record.',
    `estimated_message_volume_monthly` STRING COMMENT 'The estimated message volume monthly of the interoperability onboarding project record.',
    `integration_testing_completion_date` DATE COMMENT 'Timestamp capturing the integration testing completion date associated with the interoperability onboarding project record.',
    `integration_testing_start_date` DATE COMMENT 'Timestamp capturing the integration testing start date associated with the interoperability onboarding project record.',
    `interface_type` STRING COMMENT 'The interface type value classifying the interoperability onboarding project record.',
    `lessons_learned` STRING COMMENT 'The lessons learned of the interoperability onboarding project record.',
    `message_type` STRING COMMENT 'The message type value classifying the interoperability onboarding project record.',
    `mitigation_plan` STRING COMMENT 'The mitigation plan of the interoperability onboarding project record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability onboarding project record.',
    `notes` STRING COMMENT 'The notes of the interoperability onboarding project record.',
    `percent_complete` DECIMAL(18,2) COMMENT 'The percent complete of the interoperability onboarding project record.',
    `planned_go_live_date` DATE COMMENT 'Timestamp capturing the planned go live date associated with the interoperability onboarding project record.',
    `planned_start_date` DATE COMMENT 'Timestamp capturing the planned start date associated with the interoperability onboarding project record.',
    `priority` STRING COMMENT 'The priority of the interoperability onboarding project record.',
    `project_closure_date` DATE COMMENT 'Timestamp capturing the project closure date associated with the interoperability onboarding project record.',
    `project_code` STRING COMMENT 'The project code value classifying the interoperability onboarding project record.',
    `project_initiation_date` DATE COMMENT 'Timestamp capturing the project initiation date associated with the interoperability onboarding project record.',
    `project_manager_name` STRING COMMENT 'The project manager name of the interoperability onboarding project record.',
    `project_name` STRING COMMENT 'The project name of the interoperability onboarding project record.',
    `project_phase` STRING COMMENT 'The project phase of the interoperability onboarding project record.',
    `project_status` STRING COMMENT 'The project status value classifying the interoperability onboarding project record.',
    `risk_description` STRING COMMENT 'The risk description of the interoperability onboarding project record.',
    `risk_level` STRING COMMENT 'The risk level of the interoperability onboarding project record.',
    `scope_description` STRING COMMENT 'The scope description of the interoperability onboarding project record.',
    `onboarding_project_status` STRING COMMENT 'The onboarding project status value classifying the interoperability onboarding project record.',
    `target_go_live_date` DATE COMMENT 'Timestamp capturing the target go live date associated with the interoperability onboarding project record.',
    `technical_lead_email` STRING COMMENT 'The technical lead email of the interoperability onboarding project record.',
    `technical_lead_name` STRING COMMENT 'The technical lead name of the interoperability onboarding project record.',
    `uat_completion_date` DATE COMMENT 'Timestamp capturing the uat completion date associated with the interoperability onboarding project record.',
    `uat_start_date` DATE COMMENT 'Timestamp capturing the uat start date associated with the interoperability onboarding project record.',
    `unit_testing_completion_date` DATE COMMENT 'Timestamp capturing the unit testing completion date associated with the interoperability onboarding project record.',
    `unit_testing_start_date` DATE COMMENT 'Timestamp capturing the unit testing start date associated with the interoperability onboarding project record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the interoperability onboarding project record.',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutator to ensure change detection',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_onboarding_project PRIMARY KEY(`onboarding_project_id`)
) COMMENT 'Master record for every trading partner or interface onboarding project managed by the interoperability team. Captures project name, trading partner reference, interface type being onboarded, project phase (discovery/design/build/testing/go-live/post-live), project manager, target go-live date, actual go-live date, testing milestone dates, certification requirements (ONC, DirectTrust, Carequality), and project status. Enables portfolio management of the organizations interface onboarding pipeline.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` (
    `conformance_test_id` BIGINT COMMENT 'Primary key',
    `exchange_standard_id` BIGINT COMMENT 'FK to exchange standard',
    `fhir_endpoint_id` BIGINT COMMENT 'FK to FHIR endpoint',
    `interface_channel_id` BIGINT COMMENT 'FK to interface channel',
    `retested_conformance_test_id` BIGINT COMMENT 'Unique identifier for the retested conformance test within the interoperability conformance test record.',
    `trading_partner_id` BIGINT COMMENT 'Unique identifier for the trading partner within the interoperability conformance test record.',
    `actual_result` STRING COMMENT 'The actual result of the interoperability conformance test record.',
    `certification_program` STRING COMMENT 'The certification program of the interoperability conformance test record.',
    `certification_relevant_flag` BOOLEAN COMMENT 'The certification relevant flag of the interoperability conformance test record.',
    `conformance_profile` STRING COMMENT 'The conformance profile of the interoperability conformance test record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `error_count` STRING COMMENT 'Number of errors',
    `executed_by` STRING COMMENT 'The executed by of the interoperability conformance test record.',
    `execution_timestamp` TIMESTAMP COMMENT 'The execution timestamp of the interoperability conformance test record.',
    `expected_result` STRING COMMENT 'The expected result of the interoperability conformance test record.',
    `failed_assertion_count` STRING COMMENT 'The failed assertion count of the interoperability conformance test record.',
    `failure_reason` STRING COMMENT 'The failure reason of the interoperability conformance test record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability conformance test record.',
    `notes` STRING COMMENT 'The notes of the interoperability conformance test record.',
    `pass_fail_status` STRING COMMENT 'The pass fail status value classifying the interoperability conformance test record.',
    `passed_assertion_count` STRING COMMENT 'The passed assertion count of the interoperability conformance test record.',
    `conformance_test_status` STRING COMMENT 'The conformance test status value classifying the interoperability conformance test record.',
    `test_category` STRING COMMENT 'The test category of the interoperability conformance test record.',
    `test_code` STRING COMMENT 'The test code value classifying the interoperability conformance test record.',
    `test_date` DATE COMMENT 'Date test executed',
    `test_details` STRING COMMENT 'Detailed test results',
    `test_name` STRING COMMENT 'Name of conformance test',
    `test_result` STRING COMMENT 'The test result of the interoperability conformance test record.',
    `test_scenario` STRING COMMENT 'The test scenario of the interoperability conformance test record.',
    `test_status` STRING COMMENT 'The test status value classifying the interoperability conformance test record.',
    `test_tool_name` STRING COMMENT 'The test tool name of the interoperability conformance test record.',
    `test_tool_version` STRING COMMENT 'The test tool version of the interoperability conformance test record.',
    `test_type` STRING COMMENT 'Type of test',
    `tester_name` STRING COMMENT 'Name of tester',
    `total_assertion_count` STRING COMMENT 'The total assertion count of the interoperability conformance test record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the interoperability conformance test record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `warning_count` STRING COMMENT 'Number of warnings',
    CONSTRAINT pk_conformance_test PRIMARY KEY(`conformance_test_id`)
) COMMENT 'Transactional record of conformance and interoperability testing activities conducted for interface channels, FHIR endpoints, and trading partner connections. Captures test execution date, test suite used (ONC Certification, Touchstone, Inferno, HL7 Conformance Tester), test scope (message type/FHIR resource/transaction set), pass/fail result, number of test cases executed, number passed, number failed, critical failures, and certification submission reference. Supports ONC Health IT Certification and trading partner go-live readiness.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` (
    `promoting_interoperability_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `clinician_id` BIGINT COMMENT 'FK to clinician',
    `measure_id` BIGINT COMMENT 'PI measure ID',
    `org_provider_id` BIGINT COMMENT 'Unique identifier for the org provider within the interoperability promoting interoperability record.',
    `prior_promoting_interoperability_id` BIGINT COMMENT 'Unique identifier for the prior promoting interoperability within the interoperability promoting interoperability record.',
    `attestation_date` DATE COMMENT 'Timestamp capturing the attestation date associated with the interoperability promoting interoperability record.',
    `attestation_status` STRING COMMENT 'The attestation status value classifying the interoperability promoting interoperability record.',
    `attested_by` STRING COMMENT 'The attested by of the interoperability promoting interoperability record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `denominator_count` STRING COMMENT 'The denominator count of the interoperability promoting interoperability record.',
    `denominator_value` BIGINT COMMENT 'The denominator value of the interoperability promoting interoperability record.',
    `exclusion_claimed` BOOLEAN COMMENT 'The exclusion claimed of the interoperability promoting interoperability record.',
    `exclusion_flag` BOOLEAN COMMENT 'The exclusion flag of the interoperability promoting interoperability record.',
    `exclusion_reason` STRING COMMENT 'The exclusion reason of the interoperability promoting interoperability record.',
    `measure_score` DECIMAL(18,2) COMMENT 'The measure score of the interoperability promoting interoperability record.',
    `measure_set` STRING COMMENT 'The measure set of the interoperability promoting interoperability record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability promoting interoperability record.',
    `notes` STRING COMMENT 'The notes of the interoperability promoting interoperability record.',
    `numerator_count` STRING COMMENT 'The numerator count of the interoperability promoting interoperability record.',
    `numerator_value` BIGINT COMMENT 'The numerator value of the interoperability promoting interoperability record.',
    `performance_rate` DECIMAL(18,2) COMMENT 'The performance rate of the interoperability promoting interoperability record.',
    `program_year` STRING COMMENT 'The program year of the interoperability promoting interoperability record.',
    `reporting_period_end` DATE COMMENT 'The reporting period end of the interoperability promoting interoperability record.',
    `reporting_period_end_date` DATE COMMENT 'Timestamp capturing the reporting period end date associated with the interoperability promoting interoperability record.',
    `reporting_period_start` DATE COMMENT 'The reporting period start of the interoperability promoting interoperability record.',
    `reporting_period_start_date` DATE COMMENT 'Timestamp capturing the reporting period start date associated with the interoperability promoting interoperability record.',
    `reporting_year` STRING COMMENT 'The reporting year of the interoperability promoting interoperability record.',
    `promoting_interoperability_status` STRING COMMENT 'The promoting interoperability status value classifying the interoperability promoting interoperability record.',
    `submission_method` STRING COMMENT 'The submission method of the interoperability promoting interoperability record.',
    `submission_status` STRING COMMENT 'The submission status value classifying the interoperability promoting interoperability record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the interoperability promoting interoperability record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_promoting_interoperability PRIMARY KEY(`promoting_interoperability_id`)
) COMMENT 'Transactional record tracking the organizations performance on CMS Promoting Interoperability (PI) program measures (formerly Meaningful Use), including electronic prescribing rates, health information exchange rates, provider-to-patient exchange rates, public health reporting rates, and clinical data registry reporting rates. Captures reporting period, eligible clinician or hospital reference, measure identifier, numerator count, denominator count, exclusion count, performance rate, and attestation status. Supports CMS PI attestation and value-based program compliance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` (
    `public_health_report_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `interface_channel_id` BIGINT COMMENT 'FK to interface channel',
    `mpi_record_id` BIGINT COMMENT 'FK to patient',
    `resubmitted_public_health_report_id` BIGINT COMMENT 'Unique identifier for the resubmitted public health report within the interoperability public health report record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the interoperability public health report record.',
    `acknowledgment_code` STRING COMMENT 'The acknowledgment code value classifying the interoperability public health report record.',
    `acknowledgment_received` BOOLEAN COMMENT 'The acknowledgment received of the interoperability public health report record.',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'The acknowledgment timestamp of the interoperability public health report record.',
    `condition_code` STRING COMMENT 'Reportable condition code',
    `condition_name` STRING COMMENT 'Reportable condition name',
    `condition_reported` STRING COMMENT 'The condition reported of the interoperability public health report record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `error_code` STRING COMMENT 'The error code value classifying the interoperability public health report record.',
    `error_message` STRING COMMENT 'The error message of the interoperability public health report record.',
    `event_date` DATE COMMENT 'Timestamp capturing the event date associated with the interoperability public health report record.',
    `jurisdiction` STRING COMMENT 'The jurisdiction of the interoperability public health report record.',
    `message_control_number` STRING COMMENT 'The message control number of the interoperability public health report record.',
    `message_format` STRING COMMENT 'The message format of the interoperability public health report record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability public health report record.',
    `notes` STRING COMMENT 'The notes of the interoperability public health report record.',
    `patient_mrn` STRING COMMENT 'The patient mrn of the interoperability public health report record.',
    `receiving_agency_code` STRING COMMENT 'The receiving agency code value classifying the interoperability public health report record.',
    `receiving_agency_name` STRING COMMENT 'The receiving agency name of the interoperability public health report record.',
    `registry_name` STRING COMMENT 'The registry name of the interoperability public health report record.',
    `report_category` STRING COMMENT 'The report category of the interoperability public health report record.',
    `report_date` DATE COMMENT 'Timestamp capturing the report date associated with the interoperability public health report record.',
    `report_generated_timestamp` TIMESTAMP COMMENT 'The report generated timestamp of the interoperability public health report record.',
    `report_status` STRING COMMENT 'The report status value classifying the interoperability public health report record.',
    `report_type` STRING COMMENT 'Type of public health report',
    `reporting_jurisdiction` STRING COMMENT 'The reporting jurisdiction of the interoperability public health report record.',
    `reporting_program` STRING COMMENT 'The reporting program of the interoperability public health report record.',
    `retry_count` STRING COMMENT 'The retry count of the interoperability public health report record.',
    `public_health_report_status` STRING COMMENT 'The public health report status value classifying the interoperability public health report record.',
    `submission_status` STRING COMMENT 'The submission status value classifying the interoperability public health report record.',
    `submission_timestamp` TIMESTAMP COMMENT 'The submission timestamp of the interoperability public health report record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the interoperability public health report record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_public_health_report PRIMARY KEY(`public_health_report_id`)
) COMMENT 'Transactional record of every public health reporting submission made to state and federal public health agencies, including electronic lab reporting (ELR), immunization registry submissions (IIS), syndromic surveillance (BioSense), cancer registry reporting, and vital records reporting. Captures report type, reporting agency, submission timestamp, reporting period, message standard used (HL7v2 2.5.1, FHIR), submission status (accepted/rejected/pending), acknowledgment code, and case count. Supports Promoting Interoperability public health measures.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` (
    `care_transition_notification_id` BIGINT COMMENT 'Primary key',
    `interface_channel_id` BIGINT COMMENT 'FK to interface channel',
    `direct_message_id` BIGINT COMMENT 'Message identifier',
    `mpi_record_id` BIGINT COMMENT 'FK to patient',
    `parent_care_transition_notification_id` BIGINT COMMENT 'Unique identifier for the parent care transition notification within the interoperability care transition notification record.',
    `care_site_id` BIGINT COMMENT 'Receiving facility',
    `org_provider_id` BIGINT COMMENT 'Unique identifier for the receiving org provider within the interoperability care transition notification record.',
    `sending_care_site_id` BIGINT COMMENT 'Sending facility',
    `visit_id` BIGINT COMMENT 'FK to encounter',
    `acknowledgment_received` BOOLEAN COMMENT 'The acknowledgment received of the interoperability care transition notification record.',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'The acknowledgment timestamp of the interoperability care transition notification record.',
    `admission_reason` STRING COMMENT 'The admission reason of the interoperability care transition notification record.',
    `attending_provider_npi` STRING COMMENT 'The attending provider npi of the interoperability care transition notification record.',
    `cms_adt_notification_compliant` BOOLEAN COMMENT 'The cms adt notification compliant of the interoperability care transition notification record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `delivery_status` STRING COMMENT 'The delivery status value classifying the interoperability care transition notification record.',
    `delivery_timestamp` TIMESTAMP COMMENT 'The delivery timestamp of the interoperability care transition notification record.',
    `discharge_disposition` STRING COMMENT 'The discharge disposition of the interoperability care transition notification record.',
    `disposition` STRING COMMENT 'The disposition of the interoperability care transition notification record.',
    `error_message` STRING COMMENT 'The error message of the interoperability care transition notification record.',
    `event_timestamp` TIMESTAMP COMMENT 'The event timestamp of the interoperability care transition notification record.',
    `event_type` STRING COMMENT 'ADT event type',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability care transition notification record.',
    `notes` STRING COMMENT 'The notes of the interoperability care transition notification record.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'When notification sent',
    `notification_status` STRING COMMENT 'The notification status value classifying the interoperability care transition notification record.',
    `notification_type` STRING COMMENT 'Type of notification',
    `patient_date_of_birth` DATE COMMENT 'The patient date of birth of the interoperability care transition notification record.',
    `patient_first_name` STRING COMMENT 'The patient first name of the interoperability care transition notification record.',
    `patient_last_name` STRING COMMENT 'The patient last name of the interoperability care transition notification record.',
    `patient_mrn` STRING COMMENT 'The patient mrn of the interoperability care transition notification record.',
    `pcp_notified_flag` BOOLEAN COMMENT 'The pcp notified flag of the interoperability care transition notification record.',
    `retry_count` STRING COMMENT 'The retry count of the interoperability care transition notification record.',
    `care_transition_notification_status` STRING COMMENT 'The care transition notification status value classifying the interoperability care transition notification record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the interoperability care transition notification record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_care_transition_notification PRIMARY KEY(`care_transition_notification_id`)
) COMMENT 'Transactional record of every care transition notification (ADT notification) sent to care team members, PCPs, payers, and ACO partners when a patient is admitted, discharged, or transferred. Captures notification timestamp, event type (admission/discharge/transfer/ED visit), sending facility, receiving party type (PCP/specialist/payer/ACO), delivery channel (Direct/FHIR/HL7v2/API), delivery status, patient reference, encounter reference, and acknowledgment receipt. Supports CMS Interoperability Rule ADT notification requirements and care coordination.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` (
    `hie_transaction_id` BIGINT COMMENT 'Primary key',
    `hie_organization_id` BIGINT COMMENT 'Unique identifier for the hie organization within the interoperability hie transaction record.',
    `hie_participation_id` BIGINT COMMENT 'FK to HIE participation',
    `hie_query_id` BIGINT COMMENT 'FK to HIE query',
    `mpi_record_id` BIGINT COMMENT 'FK to patient',
    `parent_hie_transaction_id` BIGINT COMMENT 'Unique identifier for the parent hie transaction within the interoperability hie transaction record.',
    `visit_id` BIGINT COMMENT 'Unique identifier for the visit within the interoperability hie transaction record.',
    `consent_verified_flag` BOOLEAN COMMENT 'The consent verified flag of the interoperability hie transaction record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `destination_organization_oid` STRING COMMENT 'The destination organization oid of the interoperability hie transaction record.',
    `document_count` STRING COMMENT 'Number of documents',
    `document_type` STRING COMMENT 'Document type exchanged',
    `error_code` STRING COMMENT 'Error code if failed',
    `error_message` STRING COMMENT 'The error message of the interoperability hie transaction record.',
    `initiating_system` STRING COMMENT 'The initiating system of the interoperability hie transaction record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability hie transaction record.',
    `notes` STRING COMMENT 'The notes of the interoperability hie transaction record.',
    `patient_mrn` STRING COMMENT 'The patient mrn of the interoperability hie transaction record.',
    `payload_size_bytes` BIGINT COMMENT 'The payload size bytes of the interoperability hie transaction record.',
    `purpose_of_use_code` STRING COMMENT 'The purpose of use code value classifying the interoperability hie transaction record.',
    `responding_system` STRING COMMENT 'The responding system of the interoperability hie transaction record.',
    `response_time_ms` STRING COMMENT 'Response time in ms',
    `response_timestamp` TIMESTAMP COMMENT 'The response timestamp of the interoperability hie transaction record.',
    `retry_count` STRING COMMENT 'The retry count of the interoperability hie transaction record.',
    `source_organization_oid` STRING COMMENT 'The source organization oid of the interoperability hie transaction record.',
    `hie_transaction_status` STRING COMMENT 'The hie transaction status value classifying the interoperability hie transaction record.',
    `transaction_code` STRING COMMENT 'The transaction code value classifying the interoperability hie transaction record.',
    `transaction_direction` STRING COMMENT 'Inbound or outbound',
    `transaction_fee` DECIMAL(18,2) COMMENT 'The transaction fee of the interoperability hie transaction record.',
    `transaction_status` STRING COMMENT 'The transaction status value classifying the interoperability hie transaction record.',
    `transaction_timestamp` TIMESTAMP COMMENT 'The transaction timestamp of the interoperability hie transaction record.',
    `transaction_type` STRING COMMENT 'Type of transaction',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the interoperability hie transaction record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_hie_transaction PRIMARY KEY(`hie_transaction_id`)
) COMMENT 'Master reference table for hie_transaction. Referenced by hie_transaction_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` (
    `data_sharing_agreement_id` BIGINT COMMENT 'Primary key',
    `business_associate_agreement_id` BIGINT COMMENT 'Unique identifier for the business associate agreement within the interoperability data sharing agreement record.',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `hie_organization_id` BIGINT COMMENT 'FK to HIE organization',
    `org_provider_id` BIGINT COMMENT 'Unique identifier for the org provider within the interoperability data sharing agreement record.',
    `superseded_data_sharing_agreement_id` BIGINT COMMENT 'Unique identifier for the superseded data sharing agreement within the interoperability data sharing agreement record.',
    `trading_partner_id` BIGINT COMMENT 'FK to trading partner',
    `agreement_code` STRING COMMENT 'The agreement code value classifying the interoperability data sharing agreement record.',
    `agreement_name` STRING COMMENT 'The agreement name of the interoperability data sharing agreement record.',
    `agreement_status` STRING COMMENT 'The agreement status value classifying the interoperability data sharing agreement record.',
    `agreement_type` STRING COMMENT 'Type of agreement',
    `agreement_version` STRING COMMENT 'The agreement version of the interoperability data sharing agreement record.',
    `auto_renewal_flag` BOOLEAN COMMENT 'The auto renewal flag of the interoperability data sharing agreement record.',
    `breach_notification_hours` STRING COMMENT 'The breach notification hours of the interoperability data sharing agreement record.',
    `counterparty_contact_email` STRING COMMENT 'The counterparty contact email of the interoperability data sharing agreement record.',
    `counterparty_contact_name` STRING COMMENT 'The counterparty contact name of the interoperability data sharing agreement record.',
    `counterparty_contact_phone` STRING COMMENT 'The counterparty contact phone of the interoperability data sharing agreement record.',
    `counterparty_name` STRING COMMENT 'The counterparty name of the interoperability data sharing agreement record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `data_categories_shared` STRING COMMENT 'The data categories shared of the interoperability data sharing agreement record.',
    `data_sharing_scope` STRING COMMENT 'The data sharing scope of the interoperability data sharing agreement record.',
    `document_uri` STRING COMMENT 'The document uri of the interoperability data sharing agreement record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the interoperability data sharing agreement record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the interoperability data sharing agreement record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the interoperability data sharing agreement record.',
    `execution_date` DATE COMMENT 'Timestamp capturing the execution date associated with the interoperability data sharing agreement record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the interoperability data sharing agreement record.',
    `governing_framework` STRING COMMENT 'The governing framework of the interoperability data sharing agreement record.',
    `hipaa_baa_included` BOOLEAN COMMENT 'The hipaa baa included of the interoperability data sharing agreement record.',
    `legal_review_date` DATE COMMENT 'Timestamp capturing the legal review date associated with the interoperability data sharing agreement record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability data sharing agreement record.',
    `notes` STRING COMMENT 'The notes of the interoperability data sharing agreement record.',
    `permitted_uses` STRING COMMENT 'Permitted data uses',
    `prohibited_uses` STRING COMMENT 'The prohibited uses of the interoperability data sharing agreement record.',
    `renewal_date` DATE COMMENT 'Timestamp capturing the renewal date associated with the interoperability data sharing agreement record.',
    `security_requirements` STRING COMMENT 'The security requirements of the interoperability data sharing agreement record.',
    `signatory_name` STRING COMMENT 'The signatory name of the interoperability data sharing agreement record.',
    `data_sharing_agreement_status` STRING COMMENT 'The data sharing agreement status value classifying the interoperability data sharing agreement record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the interoperability data sharing agreement record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the interoperability data sharing agreement record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    CONSTRAINT pk_data_sharing_agreement PRIMARY KEY(`data_sharing_agreement_id`)
) COMMENT 'Master reference table for data_sharing_agreement. Referenced by data_sharing_agreement_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` (
    `hie_organization_id` BIGINT COMMENT 'Primary key',
    `financial_entity_id` BIGINT COMMENT 'Unique identifier for the financial entity within the interoperability hie organization record.',
    `parent_hie_organization_id` BIGINT COMMENT 'Parent HIE organization',
    `address_line1` STRING COMMENT 'The address line1 of the interoperability hie organization record.',
    `address_line_1` STRING COMMENT 'The address line 1 of the interoperability hie organization record.',
    `address_line_2` STRING COMMENT 'The address line 2 of the interoperability hie organization record.',
    `carequality_participant_flag` BOOLEAN COMMENT 'The carequality participant flag of the interoperability hie organization record.',
    `city` STRING COMMENT 'The city of the interoperability hie organization record.',
    `commonwell_participant_flag` BOOLEAN COMMENT 'The commonwell participant flag of the interoperability hie organization record.',
    `country_code` STRING COMMENT 'The country code value classifying the interoperability hie organization record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `geographic_coverage` STRING COMMENT 'Geographic coverage area',
    `go_live_date` DATE COMMENT 'Timestamp capturing the go live date associated with the interoperability hie organization record.',
    `home_community_oid` STRING COMMENT 'The home community oid of the interoperability hie organization record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability hie organization record.',
    `network_type` STRING COMMENT 'The network type value classifying the interoperability hie organization record.',
    `notes` STRING COMMENT 'The notes of the interoperability hie organization record.',
    `npi` STRING COMMENT 'NPI if applicable',
    `oid` STRING COMMENT 'Organization OID',
    `onboarding_date` DATE COMMENT 'Date onboarded',
    `operational_status` STRING COMMENT 'The operational status value classifying the interoperability hie organization record.',
    `organization_code` STRING COMMENT 'The organization code value classifying the interoperability hie organization record.',
    `organization_name` STRING COMMENT 'The organization name of the interoperability hie organization record.',
    `organization_type` STRING COMMENT 'Type of HIE organization',
    `participant_count` STRING COMMENT 'The participant count of the interoperability hie organization record.',
    `participation_status` STRING COMMENT 'The participation status value classifying the interoperability hie organization record.',
    `postal_code` STRING COMMENT 'The postal code value classifying the interoperability hie organization record.',
    `primary_contact_email` STRING COMMENT 'The primary contact email of the interoperability hie organization record.',
    `primary_contact_name` STRING COMMENT 'The primary contact name of the interoperability hie organization record.',
    `primary_contact_phone` STRING COMMENT 'The primary contact phone of the interoperability hie organization record.',
    `state_code` STRING COMMENT 'The state code value classifying the interoperability hie organization record.',
    `state_province` STRING COMMENT 'The state province of the interoperability hie organization record.',
    `hie_organization_status` STRING COMMENT 'The hie organization status value classifying the interoperability hie organization record.',
    `supported_standards` STRING COMMENT 'The supported standards of the interoperability hie organization record.',
    `technical_contact_email` STRING COMMENT 'The technical contact email of the interoperability hie organization record.',
    `technical_contact_name` STRING COMMENT 'The technical contact name of the interoperability hie organization record.',
    `tefca_qhin_flag` BOOLEAN COMMENT 'The tefca qhin flag of the interoperability hie organization record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the interoperability hie organization record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `website_url` STRING COMMENT 'The website url of the interoperability hie organization record.',
    CONSTRAINT pk_hie_organization PRIMARY KEY(`hie_organization_id`)
) COMMENT 'Master reference table for hie_organization. Referenced by hie_organization_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` (
    `mapping_definition_id` BIGINT COMMENT 'Unique identifier for the mapping definition within the interoperability mapping definition record.',
    `interface_engine_id` BIGINT COMMENT 'Unique identifier for the interface engine within the interoperability mapping definition record.',
    `exchange_standard_id` BIGINT COMMENT 'Unique identifier for the mapping exchange standard within the interoperability mapping definition record.',
    `source_exchange_standard_id` BIGINT COMMENT 'Unique identifier for the source exchange standard within the interoperability mapping definition record.',
    `superseded_by_mapping_definition_id` BIGINT COMMENT 'Unique identifier for the superseded by mapping definition within the interoperability mapping definition record.',
    `target_exchange_standard_id` BIGINT COMMENT 'Unique identifier for the target exchange standard within the interoperability mapping definition record.',
    `approved_by` STRING COMMENT 'The approved by of the interoperability mapping definition record.',
    `approved_timestamp` TIMESTAMP COMMENT 'The approved timestamp of the interoperability mapping definition record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the interoperability mapping definition record.',
    `definition_name` STRING COMMENT 'The definition name of the interoperability mapping definition record.',
    `definition_status` STRING COMMENT 'The definition status value classifying the interoperability mapping definition record.',
    `definition_type` STRING COMMENT 'The definition type value classifying the interoperability mapping definition record.',
    `mapping_definition_description` STRING COMMENT 'The mapping definition description of the interoperability mapping definition record.',
    `direction` STRING COMMENT 'The direction of the interoperability mapping definition record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the interoperability mapping definition record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the interoperability mapping definition record.',
    `is_active_flag` BOOLEAN COMMENT 'Boolean flag indicating the is active flag status of the interoperability mapping definition record.',
    `mapping_code` STRING COMMENT 'The mapping code value classifying the interoperability mapping definition record.',
    `mapping_name` STRING COMMENT 'The mapping name of the interoperability mapping definition record.',
    `mapping_status` STRING COMMENT 'The mapping status value classifying the interoperability mapping definition record.',
    `mapping_type` STRING COMMENT 'The mapping type value classifying the interoperability mapping definition record.',
    `mapping_version` STRING COMMENT 'The mapping version of the interoperability mapping definition record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability mapping definition record.',
    `notes` STRING COMMENT 'The notes of the interoperability mapping definition record.',
    `rule_count` STRING COMMENT 'The rule count of the interoperability mapping definition record.',
    `source_format` STRING COMMENT 'The source format of the interoperability mapping definition record.',
    `source_schema_reference` STRING COMMENT 'The source schema reference of the interoperability mapping definition record.',
    `mapping_definition_status` STRING COMMENT 'The mapping definition status value classifying the interoperability mapping definition record.',
    `target_format` STRING COMMENT 'The target format of the interoperability mapping definition record.',
    `target_schema_reference` STRING COMMENT 'The target schema reference of the interoperability mapping definition record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the interoperability mapping definition record.',
    `version` STRING COMMENT 'The version of the interoperability mapping definition record.',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_marker` STRING COMMENT 'Added by VIBE mutator to ensure change detection',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
    `created_by` STRING COMMENT 'The created by of the interoperability mapping definition record.',
    CONSTRAINT pk_mapping_definition PRIMARY KEY(`mapping_definition_id`)
) COMMENT 'Master reference table for mapping_definition. Referenced by mapping_definition_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` (
    `data_use_agreement_id` BIGINT COMMENT 'Primary key',
    `care_site_id` BIGINT COMMENT 'FK to care site',
    `data_sharing_agreement_id` BIGINT COMMENT 'Unique identifier for the data sharing agreement within the interoperability data use agreement record.',
    `hie_organization_id` BIGINT COMMENT 'Unique identifier for the hie organization within the interoperability data use agreement record.',
    `research_study_id` BIGINT COMMENT 'FK to research study',
    `superseded_data_use_agreement_id` BIGINT COMMENT 'Unique identifier for the superseded data use agreement within the interoperability data use agreement record.',
    `trading_partner_id` BIGINT COMMENT 'FK to trading partner',
    `agreement_code` STRING COMMENT 'The agreement code value classifying the interoperability data use agreement record.',
    `agreement_name` STRING COMMENT 'The agreement name of the interoperability data use agreement record.',
    `agreement_status` STRING COMMENT 'The agreement status value classifying the interoperability data use agreement record.',
    `agreement_type` STRING COMMENT 'Type of DUA',
    `agreement_version` STRING COMMENT 'The agreement version of the interoperability data use agreement record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `data_categories` STRING COMMENT 'The data categories of the interoperability data use agreement record.',
    `data_description` STRING COMMENT 'Description of data',
    `data_destruction_required_flag` BOOLEAN COMMENT 'The data destruction required flag of the interoperability data use agreement record.',
    `data_retention_period_months` STRING COMMENT 'The data retention period months of the interoperability data use agreement record.',
    `deidentification_method` STRING COMMENT 'The deidentification method of the interoperability data use agreement record.',
    `deidentification_required_flag` BOOLEAN COMMENT 'The deidentification required flag of the interoperability data use agreement record.',
    `destruction_date` DATE COMMENT 'Data destruction date',
    `document_uri` STRING COMMENT 'The document uri of the interoperability data use agreement record.',
    `effective_date` DATE COMMENT 'Timestamp capturing the effective date associated with the interoperability data use agreement record.',
    `effective_end_date` DATE COMMENT 'Timestamp capturing the effective end date associated with the interoperability data use agreement record.',
    `effective_start_date` DATE COMMENT 'Timestamp capturing the effective start date associated with the interoperability data use agreement record.',
    `execution_date` DATE COMMENT 'Timestamp capturing the execution date associated with the interoperability data use agreement record.',
    `expiration_date` DATE COMMENT 'Timestamp capturing the expiration date associated with the interoperability data use agreement record.',
    `irb_approval_required` BOOLEAN COMMENT 'The irb approval required of the interoperability data use agreement record.',
    `limited_data_set_flag` BOOLEAN COMMENT 'Limited data set',
    `minimum_necessary_flag` BOOLEAN COMMENT 'The minimum necessary flag of the interoperability data use agreement record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp of the interoperability data use agreement record.',
    `notes` STRING COMMENT 'The notes of the interoperability data use agreement record.',
    `permitted_purposes` STRING COMMENT 'The permitted purposes of the interoperability data use agreement record.',
    `permitted_uses` STRING COMMENT 'The permitted uses of the interoperability data use agreement record.',
    `prohibited_purposes` STRING COMMENT 'The prohibited purposes of the interoperability data use agreement record.',
    `prohibited_uses` STRING COMMENT 'The prohibited uses of the interoperability data use agreement record.',
    `recipient_contact_email` STRING COMMENT 'The recipient contact email of the interoperability data use agreement record.',
    `recipient_contact_name` STRING COMMENT 'The recipient contact name of the interoperability data use agreement record.',
    `recipient_organization_name` STRING COMMENT 'The recipient organization name of the interoperability data use agreement record.',
    `signatory_name` STRING COMMENT 'The signatory name of the interoperability data use agreement record.',
    `data_use_agreement_status` STRING COMMENT 'The data use agreement status value classifying the interoperability data use agreement record.',
    `termination_date` DATE COMMENT 'Timestamp capturing the termination date associated with the interoperability data use agreement record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vibe_interop_domain_marker` STRING COMMENT 'Marker attribute confirming interoperability domain product set.',
    `vibe_mutation_marker` STRING COMMENT 'The vibe mutation marker of the interoperability data use agreement record.',
    `vibe_structure_marker` STRING COMMENT 'structure enforcement marker',
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
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ADD CONSTRAINT `fk_interoperability_message_log_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ADD CONSTRAINT `fk_interoperability_message_log_mapping_rule_id` FOREIGN KEY (`mapping_rule_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`mapping_rule`(`mapping_rule_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ADD CONSTRAINT `fk_interoperability_message_log_original_message_log_id` FOREIGN KEY (`original_message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ADD CONSTRAINT `fk_interoperability_message_error_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ADD CONSTRAINT `fk_interoperability_message_error_message_log_id` FOREIGN KEY (`message_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_log`(`message_log_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ADD CONSTRAINT `fk_interoperability_message_error_parent_message_error_id` FOREIGN KEY (`parent_message_error_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`message_error`(`message_error_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ADD CONSTRAINT `fk_interoperability_fhir_endpoint_data_sharing_agreement_id` FOREIGN KEY (`data_sharing_agreement_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement`(`data_sharing_agreement_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ADD CONSTRAINT `fk_interoperability_fhir_endpoint_superseded_fhir_endpoint_id` FOREIGN KEY (`superseded_fhir_endpoint_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint`(`fhir_endpoint_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ADD CONSTRAINT `fk_interoperability_fhir_endpoint_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ADD CONSTRAINT `fk_interoperability_fhir_resource_log_fhir_endpoint_id` FOREIGN KEY (`fhir_endpoint_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint`(`fhir_endpoint_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ADD CONSTRAINT `fk_interoperability_fhir_resource_log_parent_fhir_resource_log_id` FOREIGN KEY (`parent_fhir_resource_log_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log`(`fhir_resource_log_id`);
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
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ADD CONSTRAINT `fk_interoperability_interface_downtime_parent_interface_downtime_id` FOREIGN KEY (`parent_interface_downtime_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_downtime`(`interface_downtime_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ADD CONSTRAINT `fk_interoperability_interface_downtime_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ADD CONSTRAINT `fk_interoperability_terminology_mapping_mapping_definition_id` FOREIGN KEY (`mapping_definition_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`mapping_definition`(`mapping_definition_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ADD CONSTRAINT `fk_interoperability_terminology_mapping_primary_superseded_by_terminology_mapping_id` FOREIGN KEY (`primary_superseded_by_terminology_mapping_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`terminology_mapping`(`terminology_mapping_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ADD CONSTRAINT `fk_interoperability_terminology_mapping_exchange_standard_id` FOREIGN KEY (`exchange_standard_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`exchange_standard`(`exchange_standard_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ADD CONSTRAINT `fk_interoperability_subscription_topic_fhir_endpoint_id` FOREIGN KEY (`fhir_endpoint_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint`(`fhir_endpoint_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ADD CONSTRAINT `fk_interoperability_subscription_topic_superseded_subscription_topic_id` FOREIGN KEY (`superseded_subscription_topic_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`subscription_topic`(`subscription_topic_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ADD CONSTRAINT `fk_interoperability_subscription_topic_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ADD CONSTRAINT `fk_interoperability_subscription_notification_fhir_endpoint_id` FOREIGN KEY (`fhir_endpoint_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint`(`fhir_endpoint_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ADD CONSTRAINT `fk_interoperability_subscription_notification_parent_subscription_notification_id` FOREIGN KEY (`parent_subscription_notification_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`subscription_notification`(`subscription_notification_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ADD CONSTRAINT `fk_interoperability_subscription_notification_subscription_topic_id` FOREIGN KEY (`subscription_topic_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`subscription_topic`(`subscription_topic_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ADD CONSTRAINT `fk_interoperability_onboarding_project_exchange_standard_id` FOREIGN KEY (`exchange_standard_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`exchange_standard`(`exchange_standard_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ADD CONSTRAINT `fk_interoperability_onboarding_project_hie_organization_id` FOREIGN KEY (`hie_organization_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`hie_organization`(`hie_organization_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ADD CONSTRAINT `fk_interoperability_onboarding_project_interface_engine_id` FOREIGN KEY (`interface_engine_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_engine`(`interface_engine_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ADD CONSTRAINT `fk_interoperability_onboarding_project_predecessor_onboarding_project_id` FOREIGN KEY (`predecessor_onboarding_project_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`onboarding_project`(`onboarding_project_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ADD CONSTRAINT `fk_interoperability_onboarding_project_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ADD CONSTRAINT `fk_interoperability_conformance_test_exchange_standard_id` FOREIGN KEY (`exchange_standard_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`exchange_standard`(`exchange_standard_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ADD CONSTRAINT `fk_interoperability_conformance_test_fhir_endpoint_id` FOREIGN KEY (`fhir_endpoint_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint`(`fhir_endpoint_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ADD CONSTRAINT `fk_interoperability_conformance_test_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ADD CONSTRAINT `fk_interoperability_conformance_test_retested_conformance_test_id` FOREIGN KEY (`retested_conformance_test_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`conformance_test`(`conformance_test_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ADD CONSTRAINT `fk_interoperability_conformance_test_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ADD CONSTRAINT `fk_interoperability_promoting_interoperability_prior_promoting_interoperability_id` FOREIGN KEY (`prior_promoting_interoperability_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability`(`promoting_interoperability_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ADD CONSTRAINT `fk_interoperability_public_health_report_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ADD CONSTRAINT `fk_interoperability_public_health_report_resubmitted_public_health_report_id` FOREIGN KEY (`resubmitted_public_health_report_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`public_health_report`(`public_health_report_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ADD CONSTRAINT `fk_interoperability_care_transition_notification_interface_channel_id` FOREIGN KEY (`interface_channel_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_channel`(`interface_channel_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ADD CONSTRAINT `fk_interoperability_care_transition_notification_direct_message_id` FOREIGN KEY (`direct_message_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`direct_message`(`direct_message_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ADD CONSTRAINT `fk_interoperability_care_transition_notification_parent_care_transition_notification_id` FOREIGN KEY (`parent_care_transition_notification_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`care_transition_notification`(`care_transition_notification_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ADD CONSTRAINT `fk_interoperability_hie_transaction_hie_organization_id` FOREIGN KEY (`hie_organization_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`hie_organization`(`hie_organization_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ADD CONSTRAINT `fk_interoperability_hie_transaction_hie_participation_id` FOREIGN KEY (`hie_participation_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`hie_participation`(`hie_participation_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ADD CONSTRAINT `fk_interoperability_hie_transaction_hie_query_id` FOREIGN KEY (`hie_query_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`hie_query`(`hie_query_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ADD CONSTRAINT `fk_interoperability_hie_transaction_parent_hie_transaction_id` FOREIGN KEY (`parent_hie_transaction_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`hie_transaction`(`hie_transaction_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ADD CONSTRAINT `fk_interoperability_data_sharing_agreement_hie_organization_id` FOREIGN KEY (`hie_organization_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`hie_organization`(`hie_organization_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ADD CONSTRAINT `fk_interoperability_data_sharing_agreement_superseded_data_sharing_agreement_id` FOREIGN KEY (`superseded_data_sharing_agreement_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement`(`data_sharing_agreement_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ADD CONSTRAINT `fk_interoperability_data_sharing_agreement_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ADD CONSTRAINT `fk_interoperability_hie_organization_parent_hie_organization_id` FOREIGN KEY (`parent_hie_organization_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`hie_organization`(`hie_organization_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ADD CONSTRAINT `fk_interoperability_mapping_definition_interface_engine_id` FOREIGN KEY (`interface_engine_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`interface_engine`(`interface_engine_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ADD CONSTRAINT `fk_interoperability_mapping_definition_exchange_standard_id` FOREIGN KEY (`exchange_standard_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`exchange_standard`(`exchange_standard_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ADD CONSTRAINT `fk_interoperability_mapping_definition_source_exchange_standard_id` FOREIGN KEY (`source_exchange_standard_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`exchange_standard`(`exchange_standard_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ADD CONSTRAINT `fk_interoperability_mapping_definition_superseded_by_mapping_definition_id` FOREIGN KEY (`superseded_by_mapping_definition_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`mapping_definition`(`mapping_definition_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ADD CONSTRAINT `fk_interoperability_mapping_definition_target_exchange_standard_id` FOREIGN KEY (`target_exchange_standard_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`exchange_standard`(`exchange_standard_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ADD CONSTRAINT `fk_interoperability_data_use_agreement_data_sharing_agreement_id` FOREIGN KEY (`data_sharing_agreement_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement`(`data_sharing_agreement_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ADD CONSTRAINT `fk_interoperability_data_use_agreement_hie_organization_id` FOREIGN KEY (`hie_organization_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`hie_organization`(`hie_organization_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ADD CONSTRAINT `fk_interoperability_data_use_agreement_superseded_data_use_agreement_id` FOREIGN KEY (`superseded_data_use_agreement_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`data_use_agreement`(`data_use_agreement_id`);
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ADD CONSTRAINT `fk_interoperability_data_use_agreement_trading_partner_id` FOREIGN KEY (`trading_partner_id`) REFERENCES `vibe_healthcare_v1`.`interoperability`.`trading_partner`(`trading_partner_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`interoperability` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`interoperability` SET TAGS ('pii_domain' = 'interoperability');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` SET TAGS ('pii_subdomain' = 'health_exchange');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` SET TAGS ('pii_interoperability' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` SET TAGS ('pii_standards' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` SET TAGS ('pii_messaging' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `exchange_standard_id` SET TAGS ('pii_business_glossary_term' = 'Exchange Standard Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `superseded_exchange_standard_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Exchange Standard ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `backward_compatibility` SET TAGS ('pii_business_glossary_term' = 'Backward Compatibility Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `certification_date` SET TAGS ('pii_business_glossary_term' = 'Certification Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `certification_status` SET TAGS ('pii_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `certification_status` SET TAGS ('pii_value_regex' = 'certified|pending|not_required|failed');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `character_set` SET TAGS ('pii_business_glossary_term' = 'Character Set');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `conformance_profile` SET TAGS ('pii_business_glossary_term' = 'Conformance Profile');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `contact_email` SET TAGS ('pii_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `contact_person` SET TAGS ('pii_business_glossary_term' = 'Contact Person');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `contact_person` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `documentation_url` SET TAGS ('pii_business_glossary_term' = 'Documentation URL');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `encoding_format` SET TAGS ('pii_business_glossary_term' = 'Encoding Format');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `encoding_format` SET TAGS ('pii_value_regex' = 'pipe_delimited|xml|json|edi|binary');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `exchange_standard_status` SET TAGS ('pii_business_glossary_term' = 'Exchange Standard Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `exchange_standard_status` SET TAGS ('pii_value_regex' = 'active|deprecated|retired|planned|testing');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `governing_body` SET TAGS ('pii_business_glossary_term' = 'Governing Body');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `hie_participation` SET TAGS ('pii_business_glossary_term' = 'HIE Participation');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `interface_engine_support` SET TAGS ('pii_business_glossary_term' = 'Interface Engine Support');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `is_mandatory` SET TAGS ('pii_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `message_types_supported` SET TAGS ('pii_business_glossary_term' = 'Message Types Supported');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `migration_path` SET TAGS ('pii_business_glossary_term' = 'Migration Path');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `publication_date` SET TAGS ('pii_business_glossary_term' = 'Publication Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `regulatory_requirement` SET TAGS ('pii_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `resource_types_supported` SET TAGS ('pii_business_glossary_term' = 'Resource Types Supported');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `security_profile` SET TAGS ('pii_business_glossary_term' = 'Security Profile');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `specification_url` SET TAGS ('pii_business_glossary_term' = 'Specification URL');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `standard_code` SET TAGS ('pii_business_glossary_term' = 'Standard Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `standard_name` SET TAGS ('pii_business_glossary_term' = 'Standard Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `standard_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `standard_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `standard_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `standard_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `standard_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `standard_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `standard_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `standard_type` SET TAGS ('pii_business_glossary_term' = 'Standard Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `standard_type` SET TAGS ('pii_value_regex' = 'messaging|document|transaction|imaging|api');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `terminology_binding` SET TAGS ('pii_business_glossary_term' = 'Terminology Binding');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `testing_tool` SET TAGS ('pii_business_glossary_term' = 'Testing Tool');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `testing_tool` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `testing_tool` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `testing_tool` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `testing_tool` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `testing_tool` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `testing_tool` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `testing_tool` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `transport_protocol` SET TAGS ('pii_business_glossary_term' = 'Transport Protocol');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `use_case_description` SET TAGS ('pii_business_glossary_term' = 'Use Case Description');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `validation_rules` SET TAGS ('pii_business_glossary_term' = 'Validation Rules');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`exchange_standard` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Version');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` SET TAGS ('pii_subdomain' = 'partner_governance');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` SET TAGS ('pii_interoperability' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` SET TAGS ('pii_trading_partner' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` SET TAGS ('pii_hie' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `trading_partner_id` SET TAGS ('pii_business_glossary_term' = 'Trading Partner Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `interface_engine_id` SET TAGS ('pii_business_glossary_term' = 'Interface Engine ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `org_provider_id` SET TAGS ('pii_business_glossary_term' = 'Organization Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `parent_trading_partner_id` SET TAGS ('pii_business_glossary_term' = 'Parent Trading Partner ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `active_flag` SET TAGS ('pii_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `address_line_1` SET TAGS ('pii_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `address_line_1` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `address_line_1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `address_line_1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `address_line_1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `address_line_1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `address_line_1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `address_line_1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `address_line_2` SET TAGS ('pii_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `address_line_2` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `address_line_2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `address_line_2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `address_line_2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `address_line_2` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `address_line_2` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `address_line_2` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `cda_endpoint_url` SET TAGS ('pii_business_glossary_term' = 'CDA Endpoint URL');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `certification_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Certification Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `certification_status` SET TAGS ('pii_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `certification_status` SET TAGS ('pii_value_regex' = 'not_certified|in_certification|certified|expired');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `city` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `city` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `city` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `city` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `data_sharing_agreement_reference` SET TAGS ('pii_business_glossary_term' = 'Data Sharing Agreement Reference');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `data_transformation_mapping_reference` SET TAGS ('pii_business_glossary_term' = 'Data Transformation Mapping Reference');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `direct_address` SET TAGS ('pii_business_glossary_term' = 'Direct Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `direct_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `direct_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `direct_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `direct_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `direct_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `direct_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `direct_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `exchange_volume_last_30_days` SET TAGS ('pii_business_glossary_term' = 'Exchange Volume Last 30 Days');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `fhir_endpoint_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Endpoint URL');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `hie_network_name` SET TAGS ('pii_business_glossary_term' = 'HIE Network Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `hie_network_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `hie_network_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `hie_network_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `hie_network_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `hie_network_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `hie_network_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `hie_network_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `hie_participation_flag` SET TAGS ('pii_business_glossary_term' = 'HIE Participation Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `hl7v2_endpoint_url` SET TAGS ('pii_business_glossary_term' = 'HL7 V2 Endpoint URL');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `last_successful_exchange_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Successful Exchange Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `message_tracking_enabled_flag` SET TAGS ('pii_business_glossary_term' = 'Message Tracking Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `npi` SET TAGS ('pii_business_glossary_term' = 'NPI');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `oid` SET TAGS ('pii_business_glossary_term' = 'OID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `onboarding_status` SET TAGS ('pii_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `onboarding_status` SET TAGS ('pii_value_regex' = 'planning|in_progress|testing|active|suspended|terminated');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_email` SET TAGS ('pii_business_glossary_term' = 'Operational Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_name` SET TAGS ('pii_business_glossary_term' = 'Operational Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Operational Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `operational_contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `partner_name` SET TAGS ('pii_business_glossary_term' = 'Partner Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `partner_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `partner_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `partner_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `partner_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `partner_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `partner_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `partner_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `partner_type` SET TAGS ('pii_business_glossary_term' = 'Partner Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `postal_code` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `postal_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `postal_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `postal_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `sla_response_time_hours` SET TAGS ('pii_business_glossary_term' = 'SLA Response Time Hours');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `state_province` SET TAGS ('pii_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `state_province` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `state_province` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `state_province` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `state_province` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `state_province` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `state_province` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `state_province` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `supported_standards` SET TAGS ('pii_business_glossary_term' = 'Supported Standards');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_business_glossary_term' = 'Technical Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_name` SET TAGS ('pii_business_glossary_term' = 'Technical Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Technical Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `technical_contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`trading_partner` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` SET TAGS ('pii_subdomain' = 'interface_operations');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` SET TAGS ('pii_interoperability' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` SET TAGS ('pii_interface_engine' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` SET TAGS ('pii_middleware' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `interface_engine_id` SET TAGS ('pii_business_glossary_term' = 'Interface Engine Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `replaced_interface_engine_id` SET TAGS ('pii_business_glossary_term' = 'Replaced Interface Engine ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `admin_url` SET TAGS ('pii_business_glossary_term' = 'Admin URL');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `audit_logging_enabled` SET TAGS ('pii_business_glossary_term' = 'Audit Logging Enabled');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `cloud_provider` SET TAGS ('pii_business_glossary_term' = 'Cloud Provider');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `decommission_date` SET TAGS ('pii_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `deployment_environment` SET TAGS ('pii_business_glossary_term' = 'Deployment Environment');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `deployment_environment` SET TAGS ('pii_value_regex' = 'production|staging|development|test|disaster_recovery|sandbox');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `disaster_recovery_enabled` SET TAGS ('pii_business_glossary_term' = 'Disaster Recovery Enabled');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `encryption_enabled` SET TAGS ('pii_business_glossary_term' = 'Encryption Enabled');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `engine_code` SET TAGS ('pii_business_glossary_term' = 'Engine Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `engine_name` SET TAGS ('pii_business_glossary_term' = 'Engine Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `engine_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `engine_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `engine_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `engine_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `engine_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `engine_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `engine_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `fhir_version_support` SET TAGS ('pii_business_glossary_term' = 'FHIR Version Support');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `go_live_date` SET TAGS ('pii_business_glossary_term' = 'Go Live Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `high_availability_enabled` SET TAGS ('pii_business_glossary_term' = 'High Availability Enabled');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `hipaa_compliant` SET TAGS ('pii_business_glossary_term' = 'HIPAA Compliant');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `hitrust_certified` SET TAGS ('pii_business_glossary_term' = 'HITRUST Certified');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `hl7_version_support` SET TAGS ('pii_business_glossary_term' = 'HL7 Version Support');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `hosting_model` SET TAGS ('pii_business_glossary_term' = 'Hosting Model');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `hosting_model` SET TAGS ('pii_value_regex' = 'on_premise|cloud|hybrid|saas|paas|iaas');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `hosting_model` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `hosting_model` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `hosting_model` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `hosting_model` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `hosting_model` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `hosting_model` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `hosting_model` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `installation_date` SET TAGS ('pii_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `last_maintenance_date` SET TAGS ('pii_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `license_expiration_date` SET TAGS ('pii_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `license_type` SET TAGS ('pii_business_glossary_term' = 'License Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `license_type` SET TAGS ('pii_value_regex' = 'perpetual|subscription|open_source|enterprise|community|trial');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `max_concurrent_connections` SET TAGS ('pii_business_glossary_term' = 'Max Concurrent Connections');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `message_throughput_capacity` SET TAGS ('pii_business_glossary_term' = 'Message Throughput Capacity');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `message_throughput_capacity` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `message_throughput_capacity` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `message_throughput_capacity` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `message_throughput_capacity` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `message_throughput_capacity` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `message_throughput_capacity` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('pii_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `operational_status` SET TAGS ('pii_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `operational_status` SET TAGS ('pii_value_regex' = 'active|inactive|maintenance|decommissioned|planned|suspended');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_hostname` SET TAGS ('pii_business_glossary_term' = 'Primary Hostname');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_hostname` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_hostname` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_hostname` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_hostname` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_hostname` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_hostname` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_ip_address` SET TAGS ('pii_business_glossary_term' = 'Primary IP Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_ip_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_ip_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_ip_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_ip_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_ip_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_ip_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `primary_ip_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `product_name` SET TAGS ('pii_business_glossary_term' = 'Product Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `product_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `product_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `product_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `product_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `product_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `product_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `product_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `responsible_team` SET TAGS ('pii_business_glossary_term' = 'Responsible Team');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `support_contract_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Support Contract Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `support_contract_status` SET TAGS ('pii_business_glossary_term' = 'Support Contract Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `support_contract_status` SET TAGS ('pii_value_regex' = 'active|expired|pending_renewal|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `supported_protocols` SET TAGS ('pii_business_glossary_term' = 'Supported Protocols');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `vendor_name` SET TAGS ('pii_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `vendor_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `vendor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `vendor_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `vendor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `vendor_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `vendor_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `vendor_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_engine` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Version');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` SET TAGS ('pii_subdomain' = 'interface_operations');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `interface_channel_id` SET TAGS ('pii_business_glossary_term' = 'Interface Channel Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `exchange_standard_id` SET TAGS ('pii_business_glossary_term' = 'Exchange Standard Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `replaced_interface_channel_id` SET TAGS ('pii_business_glossary_term' = 'Replaced Interface Channel Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `replaced_interface_channel_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `acknowledgment_required` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `acknowledgment_timeout_seconds` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Timeout in Seconds');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `audit_logging_enabled` SET TAGS ('pii_business_glossary_term' = 'Audit Logging Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `authentication_method` SET TAGS ('pii_business_glossary_term' = 'Authentication Method');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `authentication_method` SET TAGS ('pii_value_regex' = 'none|basic|certificate|oauth|saml|mutual_tls');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `business_owner_name` SET TAGS ('pii_business_glossary_term' = 'Business Owner Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `business_owner_name` SET TAGS ('pii_category' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `business_owner_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `business_owner_name` SET TAGS ('pii_subtype' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `business_owner_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `business_owner_name` SET TAGS ('pii_mask_nonprod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `business_owner_name` SET TAGS ('pii_classification' = 'PII');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `business_owner_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `business_owner_name` SET TAGS ('pii_pattern' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `business_owner_name` SET TAGS ('pii_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `business_owner_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `business_owner_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `business_owner_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `business_owner_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `channel_code` SET TAGS ('pii_business_glossary_term' = 'Interface Channel Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `channel_name` SET TAGS ('pii_business_glossary_term' = 'Interface Channel Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `channel_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `channel_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `channel_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `channel_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `channel_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `channel_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `channel_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `channel_status` SET TAGS ('pii_business_glossary_term' = 'Interface Channel Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `channel_status` SET TAGS ('pii_value_regex' = 'active|inactive|testing|suspended|maintenance|error');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `channel_type` SET TAGS ('pii_business_glossary_term' = 'Interface Channel Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `channel_type` SET TAGS ('pii_value_regex' = 'inbound|outbound|bidirectional');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `connection_host` SET TAGS ('pii_business_glossary_term' = 'Connection Host Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `connection_host` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `connection_port` SET TAGS ('pii_business_glossary_term' = 'Connection Port Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `connection_port` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `decommission_date` SET TAGS ('pii_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_facility_identifier` SET TAGS ('pii_business_glossary_term' = 'Destination Facility Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_facility_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_facility_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_facility_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_facility_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_facility_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_facility_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_facility_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_system_identifier` SET TAGS ('pii_business_glossary_term' = 'Destination System Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_system_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_system_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_system_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_system_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_system_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_system_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_system_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_system_name` SET TAGS ('pii_business_glossary_term' = 'Destination System Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_system_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_system_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_system_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_system_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_system_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_system_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_system_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_system_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `destination_system_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `encryption_enabled` SET TAGS ('pii_business_glossary_term' = 'Encryption Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `encryption_protocol` SET TAGS ('pii_business_glossary_term' = 'Encryption Protocol');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `go_live_date` SET TAGS ('pii_business_glossary_term' = 'Go-Live Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `hie_network_name` SET TAGS ('pii_business_glossary_term' = 'Health Information Exchange (HIE) Network Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `hie_network_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `hie_network_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `hie_network_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `hie_network_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `hie_network_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `hie_network_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `hie_network_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `hie_participant_flag` SET TAGS ('pii_business_glossary_term' = 'Health Information Exchange (HIE) Participant Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `last_tested_date` SET TAGS ('pii_business_glossary_term' = 'Last Tested Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `max_message_size_kb` SET TAGS ('pii_business_glossary_term' = 'Maximum Message Size in Kilobytes (KB)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `message_archival_days` SET TAGS ('pii_business_glossary_term' = 'Message Archival Retention Days');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `message_encoding` SET TAGS ('pii_business_glossary_term' = 'Message Encoding Format');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `message_encoding` SET TAGS ('pii_value_regex' = 'ER7|XML|JSON|PIPE|FIXED');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `message_event_type` SET TAGS ('pii_business_glossary_term' = 'Message Event Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `message_retry_count` SET TAGS ('pii_business_glossary_term' = 'Message Retry Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Interface Channel Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `phi_transmitted_flag` SET TAGS ('pii_business_glossary_term' = 'Protected Health Information (PHI) Transmitted Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `retry_interval_seconds` SET TAGS ('pii_business_glossary_term' = 'Retry Interval in Seconds');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `sla_tier` SET TAGS ('pii_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `sla_tier` SET TAGS ('pii_value_regex' = 'critical|high|standard|low');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `sla_uptime_target_percent` SET TAGS ('pii_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Target Percentage');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_facility_identifier` SET TAGS ('pii_business_glossary_term' = 'Source Facility Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_facility_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_facility_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_facility_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_facility_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_facility_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_facility_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_facility_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_system_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_system_name` SET TAGS ('pii_business_glossary_term' = 'Source System Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_system_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_system_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_system_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_system_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_system_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_system_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `source_system_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `support_contact_email` SET TAGS ('pii_business_glossary_term' = 'Support Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `support_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `support_contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `support_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `support_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `support_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `support_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `support_contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `support_contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `support_contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `support_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Support Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `support_contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `support_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `support_contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `support_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `support_contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `support_contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `support_contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `support_contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `technical_owner_name` SET TAGS ('pii_business_glossary_term' = 'Technical Owner Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `technical_owner_name` SET TAGS ('pii_category' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `technical_owner_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `technical_owner_name` SET TAGS ('pii_subtype' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `technical_owner_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `technical_owner_name` SET TAGS ('pii_mask_nonprod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `technical_owner_name` SET TAGS ('pii_classification' = 'PII');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `technical_owner_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `technical_owner_name` SET TAGS ('pii_pattern' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `technical_owner_name` SET TAGS ('pii_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `technical_owner_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `technical_owner_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `technical_owner_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `technical_owner_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `transformation_map_name` SET TAGS ('pii_business_glossary_term' = 'Transformation Map Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `transformation_map_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `transformation_map_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `transformation_map_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `transformation_map_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `transformation_map_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `transformation_map_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `transformation_map_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `transport_protocol` SET TAGS ('pii_business_glossary_term' = 'Transport Protocol');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_channel` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` SET TAGS ('pii_subdomain' = 'interface_operations');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_log_id` SET TAGS ('pii_business_glossary_term' = 'Message Log ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `interface_channel_id` SET TAGS ('pii_business_glossary_term' = 'Interface Channel Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `mapping_rule_id` SET TAGS ('pii_business_glossary_term' = 'Transformation Rule Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `original_message_log_id` SET TAGS ('pii_business_glossary_term' = 'Original Message Log ID Reference');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Sending Facility Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `receiving_facility_care_site_id` SET TAGS ('pii_business_glossary_term' = 'Receiving Facility Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `ack_code` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment (ACK) Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `ack_code` SET TAGS ('pii_value_regex' = 'AA|AE|AR|CA|CE|CR');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `ack_timestamp` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Received Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `business_event_type` SET TAGS ('pii_business_glossary_term' = 'Business Event Type Classification');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `destination_ip_address` SET TAGS ('pii_business_glossary_term' = 'Destination Internet Protocol (IP) Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `destination_ip_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `destination_ip_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `destination_ip_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `destination_ip_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `destination_ip_address` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `destination_ip_address` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `destination_ip_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `destination_ip_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `destination_ip_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `destination_ip_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `duplicate_check_performed` SET TAGS ('pii_business_glossary_term' = 'Duplicate Message Check Performed Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `encryption_applied` SET TAGS ('pii_business_glossary_term' = 'Encryption Applied Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `error_code` SET TAGS ('pii_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `error_description` SET TAGS ('pii_business_glossary_term' = 'Error Description Text');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `error_severity` SET TAGS ('pii_business_glossary_term' = 'Error Severity Level');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `error_severity` SET TAGS ('pii_value_regex' = 'information|warning|error|fatal');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `hie_transaction_code` SET TAGS ('pii_business_glossary_term' = 'Health Information Exchange (HIE) Transaction ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `is_duplicate` SET TAGS ('pii_business_glossary_term' = 'Duplicate Message Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_control_number` SET TAGS ('pii_business_glossary_term' = 'Message Control ID (MSH-10)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_priority` SET TAGS ('pii_business_glossary_term' = 'Message Processing Priority');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_priority` SET TAGS ('pii_value_regex' = 'routine|urgent|stat|asap');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_sequence_number` SET TAGS ('pii_business_glossary_term' = 'Message Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_standard` SET TAGS ('pii_business_glossary_term' = 'Message Standard Protocol');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_standard` SET TAGS ('pii_value_regex' = 'HL7v2|FHIR|CDA|X12|NCPDP|DICOM');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_timestamp` SET TAGS ('pii_business_glossary_term' = 'Message Creation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_type` SET TAGS ('pii_business_glossary_term' = 'Message Type Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `message_version` SET TAGS ('pii_business_glossary_term' = 'Message Standard Version');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `patient_mrn` SET TAGS ('pii_business_glossary_term' = 'Patient Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `patient_mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `patient_mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `patient_mrn` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `patient_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `patient_mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `patient_mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `patient_mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `patient_mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `patient_mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `payload_size_bytes` SET TAGS ('pii_business_glossary_term' = 'Message Payload Size in Bytes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `phi_present` SET TAGS ('pii_business_glossary_term' = 'Protected Health Information (PHI) Present Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `processing_end_timestamp` SET TAGS ('pii_business_glossary_term' = 'Processing End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `processing_latency_ms` SET TAGS ('pii_business_glossary_term' = 'Processing Latency in Milliseconds');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `processing_start_timestamp` SET TAGS ('pii_business_glossary_term' = 'Processing Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `processing_status` SET TAGS ('pii_business_glossary_term' = 'Message Processing Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `received_timestamp` SET TAGS ('pii_business_glossary_term' = 'Message Received Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `receiving_application` SET TAGS ('pii_business_glossary_term' = 'Receiving Application Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `retry_count` SET TAGS ('pii_business_glossary_term' = 'Retry Attempt Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `sending_application` SET TAGS ('pii_business_glossary_term' = 'Sending Application Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `sla_met` SET TAGS ('pii_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `sla_threshold_ms` SET TAGS ('pii_business_glossary_term' = 'Service Level Agreement (SLA) Threshold in Milliseconds');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `source_ip_address` SET TAGS ('pii_business_glossary_term' = 'Source Internet Protocol (IP) Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `source_ip_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `source_ip_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `source_ip_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `source_ip_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `source_ip_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `source_ip_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `source_ip_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `source_ip_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `transformation_applied` SET TAGS ('pii_business_glossary_term' = 'Data Transformation Applied Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `transport_protocol` SET TAGS ('pii_business_glossary_term' = 'Transport Protocol Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `validation_errors` SET TAGS ('pii_business_glossary_term' = 'Validation Error Details');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `validation_status` SET TAGS ('pii_business_glossary_term' = 'Message Validation Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `validation_status` SET TAGS ('pii_value_regex' = 'passed|failed|warning|not_validated');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_log` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_vibe_mutation' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` SET TAGS ('pii_subdomain' = 'interface_operations');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `message_error_id` SET TAGS ('pii_business_glossary_term' = 'Message Error ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Resolver ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `interface_channel_id` SET TAGS ('pii_business_glossary_term' = 'Interface Channel ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `message_log_id` SET TAGS ('pii_business_glossary_term' = 'Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `mpi_record_id` SET TAGS ('pii_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `parent_message_error_id` SET TAGS ('pii_business_glossary_term' = 'Related Message Error Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `parent_message_error_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `visit_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `visit_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `acknowledgment_code` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `acknowledgment_code` SET TAGS ('pii_value_regex' = 'AA|AE|AR|CA|CE|CR');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `actual_resolution_minutes` SET TAGS ('pii_business_glossary_term' = 'Actual Resolution Minutes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `business_impact_description` SET TAGS ('pii_business_glossary_term' = 'Business Impact Description');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `error_category` SET TAGS ('pii_business_glossary_term' = 'Error Category');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `error_code` SET TAGS ('pii_business_glossary_term' = 'Error Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `error_description` SET TAGS ('pii_business_glossary_term' = 'Error Description');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `error_severity` SET TAGS ('pii_business_glossary_term' = 'Error Severity');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `error_severity` SET TAGS ('pii_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `error_stack_trace` SET TAGS ('pii_business_glossary_term' = 'Error Stack Trace');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `error_stack_trace` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `error_timestamp` SET TAGS ('pii_business_glossary_term' = 'Error Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `escalation_flag` SET TAGS ('pii_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `escalation_timestamp` SET TAGS ('pii_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `field_position_error` SET TAGS ('pii_business_glossary_term' = 'Field Position Error');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `interface_engine_version` SET TAGS ('pii_business_glossary_term' = 'Interface Engine Version');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `message_segment_error` SET TAGS ('pii_business_glossary_term' = 'Message Segment Error');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `notification_sent_flag` SET TAGS ('pii_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `patient_mrn` SET TAGS ('pii_business_glossary_term' = 'Patient Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `patient_mrn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `patient_mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `patient_mrn` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `patient_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `patient_mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `patient_mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `patient_mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `patient_mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `patient_mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `raw_message_payload` SET TAGS ('pii_business_glossary_term' = 'Raw Message Payload');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `raw_message_payload` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `raw_message_payload` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `resolution_notes` SET TAGS ('pii_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `resolution_status` SET TAGS ('pii_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `resolution_timestamp` SET TAGS ('pii_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `retry_count` SET TAGS ('pii_business_glossary_term' = 'Retry Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `retry_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Retry Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `root_cause_category` SET TAGS ('pii_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `sla_breach_flag` SET TAGS ('pii_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `sla_target_resolution_minutes` SET TAGS ('pii_business_glossary_term' = 'Service Level Agreement (SLA) Target Resolution Minutes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`message_error` ALTER COLUMN `validation_rule_violated` SET TAGS ('pii_business_glossary_term' = 'Validation Rule Violated');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` SET TAGS ('pii_subdomain' = 'interface_operations');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `fhir_endpoint_id` SET TAGS ('pii_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Endpoint Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `data_sharing_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Data Sharing Agreement Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `org_provider_id` SET TAGS ('pii_business_glossary_term' = 'Managing Organization Identifier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `superseded_fhir_endpoint_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Fhir Endpoint Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `superseded_fhir_endpoint_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `trading_partner_id` SET TAGS ('pii_business_glossary_term' = 'Trading Partner Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `authentication_method` SET TAGS ('pii_business_glossary_term' = 'Authentication Method');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `authentication_method` SET TAGS ('pii_value_regex' = 'oauth2|smart_on_fhir|api_key|basic_auth|mutual_tls|none');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `average_response_time_ms` SET TAGS ('pii_business_glossary_term' = 'Average Response Time Milliseconds');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `bulk_data_export_support_flag` SET TAGS ('pii_business_glossary_term' = 'Bulk Data Export Support Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `capability_statement_url` SET TAGS ('pii_business_glossary_term' = 'Capability Statement Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `capability_statement_url` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `capability_statement_url` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `capability_statement_url` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `capability_statement_url` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `capability_statement_url` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `capability_statement_url` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `cms_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `connection_type` SET TAGS ('pii_business_glossary_term' = 'Connection Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `connection_type` SET TAGS ('pii_value_regex' = 'hl7_fhir_rest|hl7_fhir_messaging|direct|ihe_xds|hl7_v2|custom');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_email` SET TAGS ('pii_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_name` SET TAGS ('pii_business_glossary_term' = 'Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_phone` SET TAGS ('pii_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `deprecation_date` SET TAGS ('pii_business_glossary_term' = 'Deprecation Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `documentation_url` SET TAGS ('pii_business_glossary_term' = 'Documentation Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `endpoint_name` SET TAGS ('pii_business_glossary_term' = 'Endpoint Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `endpoint_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `endpoint_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `endpoint_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `endpoint_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `endpoint_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `endpoint_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `endpoint_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `endpoint_type` SET TAGS ('pii_business_glossary_term' = 'Endpoint Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `endpoint_type` SET TAGS ('pii_value_regex' = 'patient_facing|payer_api|provider_directory|internal_server|hie_gateway|research_api');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `endpoint_url` SET TAGS ('pii_business_glossary_term' = 'Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `endpoint_url` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `environment` SET TAGS ('pii_business_glossary_term' = 'Environment');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `environment` SET TAGS ('pii_value_regex' = 'production|staging|testing|development|sandbox');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Version');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `fhir_version` SET TAGS ('pii_value_regex' = 'R4|STU3|DSTU2|R5');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `hie_network_name` SET TAGS ('pii_business_glossary_term' = 'Health Information Exchange (HIE) Network Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `hie_network_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `hie_network_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `hie_network_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `hie_network_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `hie_network_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `hie_network_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `hie_network_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `hie_participant_flag` SET TAGS ('pii_business_glossary_term' = 'Health Information Exchange (HIE) Participant Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `last_availability_check_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Availability Check Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `last_availability_status` SET TAGS ('pii_business_glossary_term' = 'Last Availability Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `last_availability_status` SET TAGS ('pii_value_regex' = 'available|unavailable|degraded|timeout|error');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `oauth_authorization_url` SET TAGS ('pii_business_glossary_term' = 'OAuth Authorization Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `oauth_authorization_url` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `oauth_token_url` SET TAGS ('pii_business_glossary_term' = 'OAuth Token Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `oauth_token_url` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `onc_certification_flag` SET TAGS ('pii_business_glossary_term' = 'Office of the National Coordinator (ONC) Certification Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `operational_status` SET TAGS ('pii_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `operational_status` SET TAGS ('pii_value_regex' = 'active|inactive|testing|maintenance|deprecated|retired');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `patient_access_api_flag` SET TAGS ('pii_business_glossary_term' = 'Patient Access Application Programming Interface (API) Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `patient_access_api_flag` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `payer_to_payer_api_flag` SET TAGS ('pii_business_glossary_term' = 'Payer to Payer Application Programming Interface (API) Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `provider_access_api_flag` SET TAGS ('pii_business_glossary_term' = 'Provider Access Application Programming Interface (API) Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `public_endpoint_flag` SET TAGS ('pii_business_glossary_term' = 'Public Endpoint Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `rate_limit_requests_per_day` SET TAGS ('pii_business_glossary_term' = 'Rate Limit Requests Per Day');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `rate_limit_requests_per_minute` SET TAGS ('pii_business_glossary_term' = 'Rate Limit Requests Per Minute');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `registration_date` SET TAGS ('pii_business_glossary_term' = 'Registration Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `retirement_date` SET TAGS ('pii_business_glossary_term' = 'Retirement Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `security_certificate_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Security Certificate Expiry Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `smart_app_launch_support_flag` SET TAGS ('pii_business_glossary_term' = 'Substitutable Medical Applications Reusable Technologies (SMART) App Launch Support Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `supported_resource_types` SET TAGS ('pii_business_glossary_term' = 'Supported Resource Types');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `total_requests_last_30_days` SET TAGS ('pii_business_glossary_term' = 'Total Requests Last 30 Days');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_endpoint` ALTER COLUMN `uptime_percentage` SET TAGS ('pii_business_glossary_term' = 'Uptime Percentage');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` SET TAGS ('pii_subdomain' = 'interface_operations');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `fhir_resource_log_id` SET TAGS ('pii_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Resource Log ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `demographics_id` SET TAGS ('pii_business_glossary_term' = 'Patient Context ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `demographics_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `demographics_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Requesting User ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `fhir_endpoint_id` SET TAGS ('pii_business_glossary_term' = 'Fhir Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `parent_fhir_resource_log_id` SET TAGS ('pii_business_glossary_term' = 'Related Fhir Resource Log Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `parent_fhir_resource_log_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `visit_id` SET TAGS ('pii_business_glossary_term' = 'Encounter Context ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `access_decision` SET TAGS ('pii_business_glossary_term' = 'Access Decision');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `access_decision` SET TAGS ('pii_value_regex' = 'granted|denied|conditional');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `authorization_scope` SET TAGS ('pii_business_glossary_term' = 'Authorization Scope');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `conformance_validation_result` SET TAGS ('pii_business_glossary_term' = 'Conformance Validation Result');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `conformance_validation_result` SET TAGS ('pii_value_regex' = 'passed|failed|not_validated');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `consent_policy_applied` SET TAGS ('pii_business_glossary_term' = 'Consent Policy Applied');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `cures_act_exception_flag` SET TAGS ('pii_business_glossary_term' = '21st Century Cures Act Exception Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `data_segmentation_applied` SET TAGS ('pii_business_glossary_term' = 'Data Segmentation Applied Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `denial_reason` SET TAGS ('pii_business_glossary_term' = 'Denial Reason');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `exception_reason` SET TAGS ('pii_business_glossary_term' = 'Exception Reason');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Profile Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Resource ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Resource Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'Fast Healthcare Interoperability Resources (FHIR) Version ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `hie_transaction_code` SET TAGS ('pii_business_glossary_term' = 'Health Information Exchange (HIE) Transaction ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `http_status_code` SET TAGS ('pii_business_glossary_term' = 'Hypertext Transfer Protocol (HTTP) Status Code');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `operation_outcome` SET TAGS ('pii_business_glossary_term' = 'Operation Outcome');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `operation_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Operation Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `request_body_size_bytes` SET TAGS ('pii_business_glossary_term' = 'Request Body Size in Bytes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `request_method` SET TAGS ('pii_business_glossary_term' = 'Hypertext Transfer Protocol (HTTP) Request Method');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `request_method` SET TAGS ('pii_value_regex' = 'GET|POST|PUT|PATCH|DELETE');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `request_timestamp` SET TAGS ('pii_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `request_url` SET TAGS ('pii_business_glossary_term' = 'Request Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `requesting_application_code` SET TAGS ('pii_business_glossary_term' = 'Requesting Application ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `requesting_application_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `requesting_application_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `requesting_application_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `requesting_application_code` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `requesting_application_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `requesting_application_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `requesting_application_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `requesting_client_code` SET TAGS ('pii_business_glossary_term' = 'Requesting Client ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `requesting_client_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `requesting_client_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `requesting_client_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `requesting_client_code` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `requesting_client_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `requesting_client_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `requesting_client_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `response_body_size_bytes` SET TAGS ('pii_business_glossary_term' = 'Response Body Size in Bytes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `response_time_ms` SET TAGS ('pii_business_glossary_term' = 'Response Time in Milliseconds');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `response_timestamp` SET TAGS ('pii_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `search_parameters` SET TAGS ('pii_business_glossary_term' = 'FHIR Search Parameters');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `search_result_count` SET TAGS ('pii_business_glossary_term' = 'Search Result Count');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `source_ip_address` SET TAGS ('pii_business_glossary_term' = 'Source Internet Protocol (IP) Address');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `source_ip_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `source_ip_address` SET TAGS ('pii_ip' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `source_ip_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `source_ip_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `source_ip_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `source_ip_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `source_ip_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `source_ip_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `source_ip_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `user_agent` SET TAGS ('pii_business_glossary_term' = 'User Agent String');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `user_agent` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `user_agent` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`fhir_resource_log` ALTER COLUMN `validation_errors` SET TAGS ('pii_business_glossary_term' = 'Validation Errors');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` SET TAGS ('pii_subdomain' = 'health_exchange');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `mapping_rule_id` SET TAGS ('pii_business_glossary_term' = 'Mapping Rule Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `fallback_mapping_rule_id` SET TAGS ('pii_business_glossary_term' = 'Fallback Mapping Rule Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `fallback_mapping_rule_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `mapping_definition_id` SET TAGS ('pii_business_glossary_term' = 'Mapping Definition Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `crosswalk_id` SET TAGS ('pii_business_glossary_term' = 'Source Crosswalk Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `exchange_standard_id` SET TAGS ('pii_business_glossary_term' = 'Source Exchange Standard Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `condition_expression` SET TAGS ('pii_business_glossary_term' = 'Condition Expression');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `condition_expression` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `condition_expression` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `condition_expression` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `condition_expression` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `condition_expression` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `condition_expression` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `condition_expression` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `data_type_conversion` SET TAGS ('pii_business_glossary_term' = 'Data Type Conversion Logic');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `default_value` SET TAGS ('pii_business_glossary_term' = 'Default Value');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `equivalence_type` SET TAGS ('pii_business_glossary_term' = 'Equivalence Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `error_handling_action` SET TAGS ('pii_business_glossary_term' = 'Error Handling Action');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `error_handling_action` SET TAGS ('pii_value_regex' = 'abort|log|skip|retry|default');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `is_mandatory` SET TAGS ('pii_business_glossary_term' = 'Is Mandatory Flag');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Rule Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `null_handling_strategy` SET TAGS ('pii_business_glossary_term' = 'Null Handling Strategy');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `null_handling_strategy` SET TAGS ('pii_value_regex' = 'skip|default|error|empty_string|preserve_null');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `rule_description` SET TAGS ('pii_business_glossary_term' = 'Rule Description');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_business_glossary_term' = 'Rule Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `rule_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `rule_priority` SET TAGS ('pii_business_glossary_term' = 'Rule Priority');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `rule_sequence` SET TAGS ('pii_business_glossary_term' = 'Rule Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `rule_status` SET TAGS ('pii_business_glossary_term' = 'Rule Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `rule_status` SET TAGS ('pii_value_regex' = 'draft|active|inactive|deprecated|testing');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `rule_version` SET TAGS ('pii_business_glossary_term' = 'Rule Version');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `source_data_type` SET TAGS ('pii_business_glossary_term' = 'Source Data Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `source_expression` SET TAGS ('pii_business_glossary_term' = 'Source Expression');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `target_code_system` SET TAGS ('pii_business_glossary_term' = 'Target Code System');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `target_data_type` SET TAGS ('pii_business_glossary_term' = 'Target Data Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `target_expression` SET TAGS ('pii_business_glossary_term' = 'Target Expression');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `test_case_reference` SET TAGS ('pii_business_glossary_term' = 'Test Case Reference');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `transformation_function` SET TAGS ('pii_business_glossary_term' = 'Transformation Function');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `validation_rule` SET TAGS ('pii_business_glossary_term' = 'Validation Rule Expression');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_rule` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` SET TAGS ('pii_subdomain' = 'health_exchange');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `hie_participation_id` SET TAGS ('pii_business_glossary_term' = 'Health Information Exchange (HIE) Participation ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `business_associate_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Business Associate Agreement (BAA) ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `financial_entity_id` SET TAGS ('pii_business_glossary_term' = 'Organization ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `hie_organization_id` SET TAGS ('pii_business_glossary_term' = 'Health Information Exchange (HIE) Organization ID');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `interface_engine_id` SET TAGS ('pii_business_glossary_term' = 'Interface Engine Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `org_provider_id` SET TAGS ('pii_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `renewed_hie_participation_id` SET TAGS ('pii_business_glossary_term' = 'Renewed Hie Participation Id');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `renewed_hie_participation_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `annual_participation_fee` SET TAGS ('pii_business_glossary_term' = 'Annual Participation Fee');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `annual_participation_fee` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `compliance_attestation_date` SET TAGS ('pii_business_glossary_term' = 'Compliance Attestation Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `compliance_attestation_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Compliance Attestation Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `contribution_volume_monthly_avg` SET TAGS ('pii_business_glossary_term' = 'Contribution Volume Monthly Average');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `data_sharing_scope` SET TAGS ('pii_business_glossary_term' = 'Data Sharing Scope');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `data_use_agreement_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Data Use Agreement (DUA) Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `data_use_agreement_signed_date` SET TAGS ('pii_business_glossary_term' = 'Data Use Agreement (DUA) Signed Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `go_live_date` SET TAGS ('pii_business_glossary_term' = 'Go-Live Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `hie_network_name` SET TAGS ('pii_business_glossary_term' = 'Health Information Exchange (HIE) Network Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `hie_network_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `hie_network_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `hie_network_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `hie_network_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `hie_network_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `hie_network_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `hie_network_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `hie_network_type` SET TAGS ('pii_business_glossary_term' = 'Health Information Exchange (HIE) Network Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `hie_network_type` SET TAGS ('pii_value_regex' = 'state|regional|national|private|vendor');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `interface_engine_endpoint` SET TAGS ('pii_business_glossary_term' = 'Interface Engine Endpoint');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `interface_engine_endpoint` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `last_audit_date` SET TAGS ('pii_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `next_audit_date` SET TAGS ('pii_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `npi` SET TAGS ('pii_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `onboarding_date` SET TAGS ('pii_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `participation_status` SET TAGS ('pii_business_glossary_term' = 'Participation Status');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `participation_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|pending_onboarding|terminated');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `participation_tier` SET TAGS ('pii_business_glossary_term' = 'Participation Tier');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `participation_tier` SET TAGS ('pii_value_regex' = 'query_only|contribute_only|query_and_contribute|full_bidirectional');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `patient_consent_model` SET TAGS ('pii_business_glossary_term' = 'Patient Consent Model');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `patient_consent_model` SET TAGS ('pii_value_regex' = 'opt_in|opt_out|no_consent_required|emergency_only');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `patient_consent_model` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `query_volume_monthly_avg` SET TAGS ('pii_business_glossary_term' = 'Query Volume Monthly Average');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `supported_standards` SET TAGS ('pii_business_glossary_term' = 'Supported Standards');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `suspension_reason` SET TAGS ('pii_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_connection_type` SET TAGS ('pii_business_glossary_term' = 'Technical Connection Type');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_connection_type` SET TAGS ('pii_value_regex' = 'direct_messaging|fhir_api|hl7v2_interface|cda_exchange|proprietary');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_business_glossary_term' = 'Technical Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_name` SET TAGS ('pii_business_glossary_term' = 'Technical Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Technical Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `technical_contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `transaction_fee_model` SET TAGS ('pii_business_glossary_term' = 'Transaction Fee Model');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `transaction_fee_model` SET TAGS ('pii_value_regex' = 'flat_rate|per_transaction|tiered|no_fee');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_participation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` SET TAGS ('pii_subdomain' = 'health_exchange');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` SET TAGS ('pii_vibe_mutation_applied' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` SET TAGS ('pii_vibe_target_touched' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `clinical_purpose_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `clinical_purpose_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `clinical_purpose_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `clinical_purpose_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `clinical_purpose_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `clinical_purpose_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `clinical_purpose_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `initiating_facility_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `initiating_facility_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `initiating_facility_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `initiating_facility_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `initiating_facility_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `initiating_facility_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `initiating_facility_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `initiating_facility_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_date_of_birth` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_date_of_birth` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_date_of_birth` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_first_name` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_first_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_first_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_first_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_first_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_first_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_first_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_first_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_gender` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_gender` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_gender` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_gender` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_last_name` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_last_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_last_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_last_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_last_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_last_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_last_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_last_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_mrn` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_ssn_last_four` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_ssn_last_four` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_ssn_last_four` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_ssn_last_four` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_ssn_last_four` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_ssn_last_four` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_ssn_last_four` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_ssn_last_four` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_ssn_last_four` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_zip_code` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_zip_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_zip_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_zip_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_zip_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_zip_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_zip_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `patient_zip_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `requesting_provider_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `requesting_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `requesting_provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `requesting_provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `requesting_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `requesting_provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `requesting_provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `requesting_provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `responding_facility_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `responding_facility_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `responding_facility_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `responding_facility_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `responding_facility_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `responding_facility_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `responding_facility_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `responding_facility_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_query` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_mutation_marker' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` SET TAGS ('pii_subdomain' = 'health_exchange');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` SET TAGS ('pii_vibe_mutation_applied' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` SET TAGS ('pii_vibe_target_touched' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `document_type_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `document_type_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `document_type_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `document_type_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `document_type_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `document_type_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `document_type_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `document_unique_identifier` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `document_unique_identifier` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `document_unique_identifier` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `document_unique_identifier` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `document_unique_identifier` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `document_unique_identifier` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `document_unique_identifier` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `patient_mrn` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `patient_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `patient_mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `patient_mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `patient_mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `patient_mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `patient_mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `patient_mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `source_system_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `source_system_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `source_system_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `source_system_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `source_system_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `source_system_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `source_system_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_document` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_mutation_marker' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` SET TAGS ('pii_subdomain' = 'health_exchange');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` SET TAGS ('pii_vibe_mutation_applied' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` SET TAGS ('pii_vibe_target_touched' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `destination_system` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `destination_system` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `destination_system` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `destination_system` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `destination_system` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `destination_system` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `destination_system` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `document_author_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `document_author_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `document_author_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `document_author_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `document_author_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `document_author_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `document_author_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `document_author_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `hie_network_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `hie_network_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `hie_network_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `hie_network_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `hie_network_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `hie_network_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `hie_network_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `patient_mrn` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `patient_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `patient_mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `patient_mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `patient_mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `patient_mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `patient_mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `patient_mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `validator_tool_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `validator_tool_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `validator_tool_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `validator_tool_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `validator_tool_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `validator_tool_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `validator_tool_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`cda_validation_result` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_mutation_marker' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` SET TAGS ('pii_subdomain' = 'health_exchange');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` SET TAGS ('pii_vibe_mutation_applied' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` SET TAGS ('pii_vibe_target_touched' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `patient_identity_match_id` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `superseded_patient_identity_match_id` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_date_of_birth` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_date_of_birth` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_patient_first_name` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_patient_first_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_patient_first_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_patient_first_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_patient_first_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_patient_first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_patient_first_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_patient_first_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_patient_first_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_patient_last_name` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_patient_last_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_patient_last_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_patient_last_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_patient_last_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_patient_last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_patient_last_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_patient_last_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `matched_patient_last_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `requesting_user_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `requesting_user_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `requesting_user_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `requesting_user_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `requesting_user_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `requesting_user_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `requesting_user_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `requesting_user_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `source_system_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `source_system_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `source_system_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `source_system_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `source_system_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `source_system_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `source_system_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_address_line_1` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_address_line_1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_address_line_1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_address_line_1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_address_line_1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_address_line_1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_address_line_1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_city` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_city` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_city` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_date_of_birth` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_date_of_birth` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_gender` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_gender` SET TAGS ('pii_person' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_mrn` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_patient_first_name` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_patient_first_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_patient_first_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_patient_first_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_patient_first_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_patient_first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_patient_first_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_patient_first_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_patient_first_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_patient_last_name` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_patient_last_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_patient_last_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_patient_last_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_patient_last_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_patient_last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_patient_last_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_patient_last_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_patient_last_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_phone_number` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_phone_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_phone_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_phone_number` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_phone_number` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_phone_number` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_postal_code` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_postal_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_postal_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_postal_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_ssn` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_ssn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_ssn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_ssn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_ssn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_ssn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_ssn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_ssn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_state` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_state` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_state` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `submitted_state` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`patient_identity_match` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_mutation_marker' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` SET TAGS ('pii_subdomain' = 'interface_operations');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` SET TAGS ('pii_vibe_mutation_applied' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` SET TAGS ('pii_vibe_target_touched' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `direct_address_id` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `direct_address_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `direct_address_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `direct_address_id` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `direct_address_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `direct_address_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `direct_address_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `clinical_document_reference` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `clinical_document_reference` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `clinical_document_reference` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `clinical_document_reference` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `clinical_document_reference` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `clinical_document_reference` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `clinical_document_reference` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `hie_network_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `hie_network_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `hie_network_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `hie_network_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `hie_network_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `hie_network_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `hie_network_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `patient_mrn` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `patient_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `patient_mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `patient_mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `patient_mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `patient_mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `patient_mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `patient_mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_direct_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_direct_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_direct_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_direct_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_direct_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_direct_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_direct_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_organization_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_organization_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_organization_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_organization_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_organization_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_organization_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `recipient_organization_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_message` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_mutation_marker' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` SET TAGS ('pii_subdomain' = 'interface_operations');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` SET TAGS ('pii_vibe_mutation_applied' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` SET TAGS ('pii_vibe_target_touched' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address_id` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address_id` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `replaced_direct_address_id` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `replaced_direct_address_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `replaced_direct_address_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `replaced_direct_address_id` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `replaced_direct_address_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `replaced_direct_address_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `replaced_direct_address_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `address_status` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `address_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `address_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `address_status` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `address_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `address_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `address_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `address_type` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `address_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `address_type` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `address_type` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `address_type` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `address_type` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `address_type` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `administrative_contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `deactivation_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `deactivation_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `deactivation_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `deactivation_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `deactivation_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `deactivation_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `deactivation_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `department_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `department_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `department_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `department_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `department_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `department_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `department_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `display_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `display_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `display_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `display_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `display_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `display_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `display_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `hisp_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `hisp_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `hisp_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `hisp_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `hisp_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `hisp_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `hisp_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `notification_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `notification_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `notification_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `notification_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `notification_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `notification_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `notification_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address_status` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address_status` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `direct_address_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `trust_bundle_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `trust_bundle_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `trust_bundle_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `trust_bundle_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `trust_bundle_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `trust_bundle_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `trust_bundle_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`direct_address` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_mutation_marker' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` SET TAGS ('pii_subdomain' = 'partner_governance');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` SET TAGS ('pii_vibe_mutation_applied' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` SET TAGS ('pii_vibe_target_touched' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `escalation_contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `notification_email_list` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `notification_email_list` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `notification_email_list` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `notification_email_list` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `notification_email_list` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `notification_email_list` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `notification_email_list` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `sla_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `sla_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `sla_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `sla_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `sla_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `sla_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `sla_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_sla` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_mutation_marker' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` SET TAGS ('pii_subdomain' = 'interface_operations');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` SET TAGS ('pii_vibe_mutation_applied' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` SET TAGS ('pii_vibe_target_touched' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `problem_ticket_reference` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `problem_ticket_reference` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `problem_ticket_reference` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `problem_ticket_reference` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `problem_ticket_reference` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `problem_ticket_reference` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `problem_ticket_reference` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`interface_downtime` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_mutation_marker' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` SET TAGS ('pii_subdomain' = 'health_exchange');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` SET TAGS ('pii_vibe_mutation_applied' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` SET TAGS ('pii_vibe_target_touched' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `tertiary_terminology_modified_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `tertiary_terminology_modified_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `alternate_target_display_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `alternate_target_display_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `alternate_target_display_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `alternate_target_display_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `alternate_target_display_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `alternate_target_display_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `mapping_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `mapping_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `mapping_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `mapping_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `mapping_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `mapping_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `mapping_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `mapping_tool_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `mapping_tool_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `mapping_tool_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `mapping_tool_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `mapping_tool_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `mapping_tool_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `target_display_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `target_display_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `target_display_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `target_display_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `target_display_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `target_display_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`terminology_mapping` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_mutation_marker' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` SET TAGS ('pii_subdomain' = 'interface_operations');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` SET TAGS ('pii_vibe_mutation_applied' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` SET TAGS ('pii_vibe_target_touched' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `topic_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `topic_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `topic_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `topic_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `topic_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `topic_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_topic` ALTER COLUMN `topic_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` SET TAGS ('pii_subdomain' = 'interface_operations');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` SET TAGS ('pii_vibe_mutation_applied' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` SET TAGS ('pii_vibe_target_touched' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `patient_mrn` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `patient_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `patient_mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `patient_mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `patient_mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `patient_mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `patient_mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`subscription_notification` ALTER COLUMN `patient_mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` SET TAGS ('pii_subdomain' = 'partner_governance');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` SET TAGS ('pii_vibe_mutation_applied' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` SET TAGS ('pii_vibe_target_touched' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `business_owner_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `business_owner_name` SET TAGS ('pii_subtype' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `business_owner_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `business_owner_name` SET TAGS ('pii_category' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `business_owner_name` SET TAGS ('pii_mask_nonprod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `business_owner_name` SET TAGS ('pii_classification' = 'PII');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `business_owner_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `business_owner_name` SET TAGS ('pii_pattern' = 'person_name');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `business_owner_name` SET TAGS ('pii_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `business_owner_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `business_owner_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `business_owner_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `business_owner_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `integration_testing_completion_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `integration_testing_completion_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `integration_testing_completion_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `integration_testing_completion_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `integration_testing_completion_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `integration_testing_completion_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `integration_testing_completion_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `integration_testing_start_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `integration_testing_start_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `integration_testing_start_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `integration_testing_start_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `integration_testing_start_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `integration_testing_start_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `integration_testing_start_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `project_manager_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `project_manager_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `project_manager_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `project_manager_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `project_manager_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `project_manager_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `project_manager_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `project_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `project_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `project_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `project_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `project_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `project_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `project_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `technical_lead_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `technical_lead_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `technical_lead_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `technical_lead_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `technical_lead_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `technical_lead_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `technical_lead_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `technical_lead_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `technical_lead_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `technical_lead_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `technical_lead_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `technical_lead_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `technical_lead_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `technical_lead_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `unit_testing_completion_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `unit_testing_completion_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `unit_testing_completion_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `unit_testing_completion_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `unit_testing_completion_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `unit_testing_completion_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `unit_testing_completion_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `unit_testing_start_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `unit_testing_start_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `unit_testing_start_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `unit_testing_start_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `unit_testing_start_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `unit_testing_start_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `unit_testing_start_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`onboarding_project` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_mutation_marker' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` SET TAGS ('pii_subdomain' = 'health_exchange');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` SET TAGS ('pii_vibe_mutation_applied' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` SET TAGS ('pii_vibe_target_touched' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_result` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_result` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_result` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_result` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_result` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_result` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_result` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_tool_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_tool_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_tool_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_tool_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_tool_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_tool_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `test_tool_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `tester_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `tester_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `tester_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `tester_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `tester_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`conformance_test` ALTER COLUMN `tester_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` SET TAGS ('pii_subdomain' = 'regulatory_reporting');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` SET TAGS ('pii_vibe_mutation_applied' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` SET TAGS ('pii_vibe_target_touched' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `promoting_interoperability_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `promoting_interoperability_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `promoting_interoperability_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `promoting_interoperability_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `promoting_interoperability_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `promoting_interoperability_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `promoting_interoperability_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `promoting_interoperability_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `prior_promoting_interoperability_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `prior_promoting_interoperability_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `prior_promoting_interoperability_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `prior_promoting_interoperability_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `prior_promoting_interoperability_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `prior_promoting_interoperability_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `prior_promoting_interoperability_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_year` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_year` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_year` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_year` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_year` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_year` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `reporting_year` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `promoting_interoperability_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `promoting_interoperability_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `promoting_interoperability_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `promoting_interoperability_status` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `promoting_interoperability_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `promoting_interoperability_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`promoting_interoperability` ALTER COLUMN `promoting_interoperability_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` SET TAGS ('pii_subdomain' = 'regulatory_reporting');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` SET TAGS ('pii_vibe_mutation_applied' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` SET TAGS ('pii_vibe_target_touched' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` SET TAGS ('pii_vibe_domain_created' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_primary_key' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `public_health_report_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `resubmitted_public_health_report_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `resubmitted_public_health_report_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `resubmitted_public_health_report_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `resubmitted_public_health_report_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `resubmitted_public_health_report_id` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `resubmitted_public_health_report_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `resubmitted_public_health_report_id` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `resubmitted_public_health_report_id` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `resubmitted_public_health_report_id` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `condition_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `condition_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `condition_code` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `condition_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `condition_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `condition_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `condition_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `condition_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `condition_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `condition_name` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `condition_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `condition_name` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `condition_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `condition_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `condition_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `condition_reported` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `condition_reported` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `condition_reported` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `condition_reported` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `condition_reported` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `condition_reported` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `condition_reported` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `patient_mrn` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `patient_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `patient_mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `patient_mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `patient_mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `patient_mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `patient_mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `patient_mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `receiving_agency_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `receiving_agency_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `receiving_agency_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `receiving_agency_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `receiving_agency_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `receiving_agency_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `receiving_agency_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `registry_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `registry_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `registry_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `registry_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `registry_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `registry_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `reporting_jurisdiction` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `reporting_jurisdiction` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `reporting_jurisdiction` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `reporting_jurisdiction` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `reporting_jurisdiction` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `reporting_jurisdiction` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `reporting_jurisdiction` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `reporting_program` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `reporting_program` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `reporting_program` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `reporting_program` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `reporting_program` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `reporting_program` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `reporting_program` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `public_health_report_status` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `public_health_report_status` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `public_health_report_status` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `public_health_report_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `public_health_report_status` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `public_health_report_status` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`public_health_report` ALTER COLUMN `public_health_report_status` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` SET TAGS ('pii_subdomain' = 'health_exchange');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` SET TAGS ('pii_vibe_mutation_applied' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` SET TAGS ('pii_vibe_target_touched' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `attending_provider_npi` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `attending_provider_npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `attending_provider_npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `attending_provider_npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `attending_provider_npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `attending_provider_npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `attending_provider_npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `attending_provider_npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_date_of_birth` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_date_of_birth` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_date_of_birth` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_first_name` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_first_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_first_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_first_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_first_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_first_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_first_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_first_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_last_name` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_last_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_last_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_last_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_last_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_last_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_last_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_last_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_mrn` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`care_transition_notification` ALTER COLUMN `patient_mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` SET TAGS ('pii_subdomain' = 'health_exchange');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` SET TAGS ('pii_vibe_mutation_applied' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` SET TAGS ('pii_vibe_target_touched' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` SET TAGS ('pii_vibe_mutated' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `destination_organization_oid` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `destination_organization_oid` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `destination_organization_oid` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `destination_organization_oid` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `destination_organization_oid` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `destination_organization_oid` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `destination_organization_oid` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `initiating_system` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `initiating_system` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `initiating_system` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `initiating_system` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `initiating_system` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `initiating_system` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `initiating_system` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `patient_mrn` SET TAGS ('pii_sensitivity' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `patient_mrn` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `patient_mrn` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `patient_mrn` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `patient_mrn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `patient_mrn` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `patient_mrn` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_transaction` ALTER COLUMN `patient_mrn` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` SET TAGS ('pii_subdomain' = 'partner_governance');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` SET TAGS ('pii_vibe_mutation_applied' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` SET TAGS ('pii_vibe_target_touched' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `agreement_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `agreement_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `agreement_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `agreement_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `agreement_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `agreement_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `agreement_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `counterparty_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `signatory_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `signatory_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `signatory_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `signatory_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `signatory_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `signatory_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_sharing_agreement` ALTER COLUMN `signatory_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` SET TAGS ('pii_subdomain' = 'partner_governance');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` SET TAGS ('pii_vibe_mutation_applied' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` SET TAGS ('pii_vibe_target_touched' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line_1` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line_1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line_1` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line_1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line_1` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line_1` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line_1` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line_2` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line_2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line_2` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line_2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line_2` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line_2` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `address_line_2` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `city` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `city` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `city` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `city` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `geographic_coverage` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `geographic_coverage` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `geographic_coverage` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `geographic_coverage` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `geographic_coverage` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `geographic_coverage` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `npi` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `npi` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `npi` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `npi` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `npi` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `npi` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `organization_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `organization_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `organization_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `organization_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `organization_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `organization_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `organization_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `postal_code` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `postal_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `postal_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `postal_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `postal_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `state_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `state_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `state_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `state_code` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `state_code` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `state_code` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `state_province` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `state_province` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `state_province` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `state_province` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `state_province` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `state_province` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `technical_contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `technical_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `technical_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `technical_contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `technical_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `technical_contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `technical_contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`hie_organization` ALTER COLUMN `technical_contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` SET TAGS ('pii_subdomain' = 'health_exchange');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` SET TAGS ('pii_vibe_mutation_applied' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` SET TAGS ('pii_vibe_target_touched' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `definition_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `definition_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `definition_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `definition_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `definition_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `definition_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `mapping_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `mapping_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `mapping_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `mapping_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `mapping_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `mapping_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `mapping_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`mapping_definition` ALTER COLUMN `vibe_mutation_marker` SET TAGS ('pii_mutation_marker' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` SET TAGS ('pii_subdomain' = 'partner_governance');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` SET TAGS ('pii_vibe_mutation_applied' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` SET TAGS ('pii_vibe_target_touched' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` SET TAGS ('pii_structure_enforced' = 'v22domains');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `agreement_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `agreement_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `agreement_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `agreement_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `agreement_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `agreement_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `agreement_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_contact_email` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_contact_email` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_contact_email` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_contact_email` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_contact_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_contact_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_contact_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_contact_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_organization_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_organization_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_organization_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_organization_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_organization_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_organization_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `recipient_organization_name` SET TAGS ('pii_mask_non_prod' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `signatory_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `signatory_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `signatory_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `signatory_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `signatory_name` SET TAGS ('pii_unity_catalog_tag' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `signatory_name` SET TAGS ('pii_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`interoperability`.`data_use_agreement` ALTER COLUMN `signatory_name` SET TAGS ('pii_mask_non_prod' = 'true');
