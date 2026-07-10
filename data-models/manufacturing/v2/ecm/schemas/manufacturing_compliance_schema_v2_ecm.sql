-- Schema for Domain: compliance | Business: Manufacturing | Version: v2_ecm
-- Generated on: 2026-07-03 05:59:30

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`compliance` COMMENT 'Regulatory compliance and environmental health and safety domain managing ISO 14001 environmental records, ISO 45001 safety incidents, OSHA reporting, EPA emissions data, CE/UL product certifications, IEC 62443 cybersecurity compliance, audit management, regulatory filings, and corrective actions.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` (
    `regulatory_requirement_id` BIGINT COMMENT 'Unique surrogate key for each regulatory requirement record.',
    `adoption_status` STRING COMMENT 'Current internal adoption state of the requirement.. Valid values are `adopted|planned|not_adopted|under_review`',
    `applicability_scope` STRING COMMENT 'Scope of applicability (e.g., plant, product line, business unit, global).',
    `audit_frequency_months` STRING COMMENT 'How often internal audits must be performed for this requirement.',
    `authority_code` STRING COMMENT 'Standard abbreviation or code for the issuing authority (e.g., ISO, OSHA).',
    `authority_name` STRING COMMENT 'Name of the organization or body that issued the requirement (e.g., ISO, OSHA, EPA).',
    `compliance_category` STRING COMMENT 'High‑level domain category of the requirement.. Valid values are `environmental|occupational|product|cybersecurity|financial|quality`',
    `compliance_deadline` DATE COMMENT 'Latest date by which the organization must achieve compliance.',
    `compliance_level` STRING COMMENT 'Degree to which compliance is required by law or policy.. Valid values are `mandatory|optional|recommended`',
    `compliance_status` STRING COMMENT 'Current compliance state of the organization with respect to this requirement.. Valid values are `compliant|non_compliant|partial|unknown`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory requirement record was first created in the data lake.',
    `document_last_updated` TIMESTAMP COMMENT 'Timestamp of the most recent amendment to the requirement document.',
    `document_release_date` DATE COMMENT 'Date the current version of the requirement document was released.',
    `document_version` STRING COMMENT 'Version identifier of the official requirement document.',
    `effective_date` DATE COMMENT 'Date on which the requirement becomes effective.',
    `expiration_date` DATE COMMENT 'Date on which the requirement expires or is superseded, if applicable.',
    `jurisdiction` STRING COMMENT 'Geographic jurisdiction to which the requirement applies, expressed as a three‑letter ISO country code.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `last_reviewed_date` DATE COMMENT 'Date when the requirement was last reviewed for relevance or changes.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty associated with non‑compliance, if defined.',
    `penalty_currency` STRING COMMENT 'Three‑letter ISO currency code for the penalty amount.',
    `regulatory_requirement_description` STRING COMMENT 'Full textual description of the requirement, including scope and key obligations.',
    `regulatory_requirement_status` STRING COMMENT 'Current lifecycle status of the requirement within the organization.. Valid values are `active|inactive|pending|retired`',
    `reporting_requirements` STRING COMMENT 'Specific reporting obligations (e.g., quarterly emissions report).',
    `requirement_code` STRING COMMENT 'Unique business identifier or code assigned by the issuing authority (e.g., ISO‑9001, OSHA‑1910).',
    `requirement_name` STRING COMMENT 'Human‑readable name or title of the regulation, standard, or directive.',
    `requirement_type` STRING COMMENT 'Category describing the nature of the requirement.. Valid values are `law|standard|regulation|directive|policy|guideline`',
    `review_frequency_months` STRING COMMENT 'Number of months between mandatory compliance reviews.',
    `risk_level` STRING COMMENT 'Risk rating associated with non‑compliance.. Valid values are `low|medium|high|critical`',
    `source_url` STRING COMMENT 'Web link to the official source or full text of the requirement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the regulatory requirement record.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_regulatory_requirement PRIMARY KEY(`regulatory_requirement_id`)
) COMMENT 'Master catalog of all applicable laws, regulations, standards, and compliance obligations governing Manufacturing operations across all jurisdictions. Encompasses ISO 9001, ISO 14001, ISO 45001, ISO 50001, IEC 62443, OSHA, EPA, CE Marking, UL, ANSI, REACH, RoHS, and jurisdiction-specific requirements. Each record defines the regulation source, issuing authority, jurisdiction (federal, state, local, EU, international), applicability scope (plant, product line, geography), effective date, mandatory compliance deadline, review frequency, and current adoption status. Serves as the single authoritative legal register and compliance universe from which all specific obligations, permits, and filings are derived.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` (
    `obligation_id` BIGINT COMMENT 'Primary key for obligation',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for budgeting: each compliance obligation is charged to a cost center for cost tracking and reporting.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Internal orders are used to fund corrective actions for obligations; linking provides order‑level cost control.',
    `org_unit_id` BIGINT COMMENT 'Internal department accountable for fulfilling the obligation.',
    `employee_id` BIGINT COMMENT 'Person responsible for the control that satisfies the obligation.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Obligations affect profit performance; linking to profit center enables profit‑center based compliance cost analysis.',
    `regulatory_requirement_id` BIGINT COMMENT 'Reference to the master regulatory requirement that drives this obligation.',
    `facility_id` BIGINT COMMENT 'Facility or plant to which the obligation is tied.',
    `family_id` BIGINT COMMENT 'Product line or family associated with the obligation.',
    `audit_findings_count` STRING COMMENT 'Number of audit findings recorded for this obligation.',
    `audit_status` STRING COMMENT 'Current status of any audit linked to the obligation.. Valid values are `open|in_progress|closed|reopened`',
    `obligation_code` STRING COMMENT 'Human‑readable code assigned to the obligation for reference in reports and audits.',
    `compliance_category` STRING COMMENT 'High‑level classification of the obligation for reporting and analytics.. Valid values are `environment|safety|quality|cybersecurity|financial|operational`',
    `compliance_status` STRING COMMENT 'Result of the most recent compliance assessment.. Valid values are `compliant|partially_compliant|non_compliant|not_assessed|deferred`',
    `corrective_action_due_date` DATE COMMENT 'Target date for completing the corrective action.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the obligation record was first created in the system.',
    `obligation_description` STRING COMMENT '',
    `due_date` DATE COMMENT 'Deadline by which compliance must be demonstrated.',
    `effective_from` DATE COMMENT 'Date when the obligation becomes binding.',
    `effective_until` DATE COMMENT 'Date when the obligation expires, if applicable.',
    `evidence_document_url` STRING COMMENT 'Link to electronic evidence supporting compliance (e.g., certificates, test reports).',
    `evidence_type` STRING COMMENT 'Category of the supporting evidence attached to the obligation.. Valid values are `document|test_result|certification|photo|video`',
    `external_reference_number` STRING COMMENT 'Identifier used in external regulatory filings or partner systems.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the obligation is mandatory (true) or optional (false).',
    `jurisdiction` STRING COMMENT 'Geographic or legal jurisdiction (e.g., country code) to which the obligation applies.',
    `last_assessment_date` DATE COMMENT 'Date of the most recent compliance assessment.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `next_assessment_due` DATE COMMENT 'Planned date for the next compliance assessment.',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the obligation.',
    `obligation_status` STRING COMMENT 'Current lifecycle state of the obligation.. Valid values are `active|inactive|pending|closed|expired`',
    `obligation_type` STRING COMMENT 'Category of the regulatory requirement the obligation satisfies.. Valid values are `environmental|safety|cybersecurity|quality|financial`',
    `owner_name` STRING COMMENT '',
    `recurrence_schedule` STRING COMMENT 'Frequency with which the obligation must be reassessed or renewed.. Valid values are `annual|semi-annual|quarterly|monthly|one-time|ad-hoc`',
    `remediation_action` STRING COMMENT 'Planned corrective action to address a non‑compliant status.',
    `risk_rating` DECIMAL(18,2) COMMENT 'Numeric risk score (e.g., 0.00‑10.00) derived from severity and likelihood.',
    `risk_severity` STRING COMMENT 'Qualitative severity of the risk if the obligation is not met.. Valid values are `low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the obligation record.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_obligation PRIMARY KEY(`obligation_id`)
) COMMENT 'Operational compliance obligation instance record assigning a specific regulatory requirement to a designated organizational unit, facility, product line, or process within Manufacturing. Each obligation represents a concrete compliance task or demonstration requirement derived from the regulatory_requirement master catalog. Tracks obligation owner, responsible department, due date, recurrence schedule, current compliance status (compliant, partially compliant, non-compliant, not yet assessed), evidence of compliance (linked documents, test results, certifications), last assessment date, next assessment due, and linkage to the governing regulatory requirement. Enables compliance gap analysis, obligation coverage reporting, and proactive deadline management across all jurisdictions and standards.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` (
    `audit_plan_id` BIGINT COMMENT 'Unique identifier for the audit plan record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Links audit plan to the employee acting as lead auditor, needed for audit scheduling and responsibility tracking.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Audit plans are created for projects to assess compliance with standards and regulations.',
    `regulatory_requirement_id` BIGINT COMMENT '',
    `applicable_standards` STRING COMMENT 'Standards, regulations, or certifications the audit addresses (e.g., ISO 14001, ISO 45001, IEC 62443).',
    `audit_frequency` STRING COMMENT 'Planned recurrence of the audit (e.g., annual, semi‑annual, quarterly, monthly, ad‑hoc).. Valid values are `annual|semi_annual|quarterly|monthly|ad_hoc`',
    `audit_methodology` STRING COMMENT 'Methodological approach used for the audit (e.g., checklist, interview, sampling).',
    `audit_objectives` STRING COMMENT 'Key objectives and goals the audit intends to achieve.',
    `audit_plan_status` STRING COMMENT 'Current lifecycle status of the audit plan.. Valid values are `planned|in_progress|completed|cancelled|postponed|deferred`',
    `audit_scope` STRING COMMENT '',
    `audit_score` DECIMAL(18,2) COMMENT 'Overall audit performance score (e.g., 0‑100 scale).',
    `audit_team` STRING COMMENT 'Comma‑separated list of auditors assigned to execute the audit.',
    `audit_type` STRING COMMENT 'Classification of the audit (internal, external, supplier, regulatory, certification).. Valid values are `internal|external|supplier|regulatory|certification`',
    `audit_plan_code` STRING COMMENT '',
    `compliance_score` DECIMAL(18,2) COMMENT 'Aggregated compliance rating derived from audit findings.',
    `corrective_action_due_date` DATE COMMENT 'Deadline by which identified corrective actions must be completed.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `creation_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit plan record was first created in the system.',
    `audit_plan_description` STRING COMMENT '',
    `effective_from` DATE COMMENT 'Date when the audit plan becomes effective.',
    `effective_until` DATE COMMENT 'Date when the audit plan expires or is no longer active (nullable for open‑ended plans).',
    `findings_count` STRING COMMENT 'Total count of audit findings recorded for the plan.',
    `frequency_months` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the audit plan record.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `plan_code` STRING COMMENT 'External business identifier or code used to reference the audit plan.',
    `planned_end_date` TIMESTAMP COMMENT '',
    `planned_start_date` TIMESTAMP COMMENT '',
    `risk_level` STRING COMMENT 'Risk rating assigned to the audit based on potential impact and likelihood.. Valid values are `low|medium|high|critical`',
    `scheduled_end_date` DATE COMMENT 'Planned calendar date when the audit is expected to conclude.',
    `scheduled_start_date` DATE COMMENT 'Planned calendar date when the audit is to commence.',
    `scope_description` STRING COMMENT 'Narrative description of the audit scope, including processes, facilities, and products covered.',
    `target_facilities` STRING COMMENT 'Facilities, plants, or operational units that are subject to the audit.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_audit_plan PRIMARY KEY(`audit_plan_id`)
) COMMENT 'Planned internal or external audit program record defining the audit scope, type (ISO surveillance, OSHA inspection, IEC 62443 cybersecurity, supplier audit, internal quality audit, management system review), scheduled dates, lead auditor, audit team, applicable standards, and target facilities or processes. Serves as the master schedule and compliance calendar for all audit and periodic evaluation activities across Manufacturing.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` (
    `audit_event_id` BIGINT COMMENT 'System-generated unique identifier for the audit event record.',
    `audit_plan_id` BIGINT COMMENT 'Reference to the audit plan that scheduled this event.',
    `compliance_audit_finding_id` BIGINT COMMENT 'Link to the collection of findings generated from this audit.',
    `device_registry_id` BIGINT COMMENT 'Foreign key linking to automation.device_registry. Business justification: Audit Event records need to reference the specific automation device audited for regulatory compliance reporting.',
    `employee_id` BIGINT COMMENT 'System identifier for the auditor (links to party master data).',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Audit events are logged against the project they audit, supporting traceability and reporting.',
    `assessment_method` STRING COMMENT 'Technique used to conduct the audit.. Valid values are `on_site|remote|document_review|observation|testing|checklist`',
    `assessment_type` STRING COMMENT 'Category of the audit activity (e.g., certification_audit, regulatory_inspection, internal_audit, periodic_evaluation, safety_inspection, cybersecurity_assessment, management_review). [ENUM-REF-CANDIDATE: certification_audit|regulatory_inspection|internal_audit|periodic_evaluation|safety_inspection|cybersecurity_assessment|management_review — promote to reference product]',
    `audit_date` TIMESTAMP COMMENT '',
    `audit_event_status` STRING COMMENT 'Current lifecycle state of the audit event record.. Valid values are `open|closed|in_progress|cancelled`',
    `auditor_name` STRING COMMENT 'Name of the individual who performed the audit.',
    `certification_body` STRING COMMENT 'External organization that issued a certification (e.g., ISO, UL, CE).',
    `audit_event_code` STRING COMMENT '',
    `corrective_action_due_date` DATE COMMENT 'Target date for completion of required corrective actions.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether a corrective action plan is mandated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit event record was first created in the system.',
    `department` STRING COMMENT 'Organizational department responsible for the audited area.',
    `audit_event_description` STRING COMMENT '',
    `documentation_link` STRING COMMENT 'URL or path to supporting audit documentation and evidence.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the audit or inspection was performed.',
    `evidence_attached` TIMESTAMP COMMENT 'True if supporting evidence files are attached to the audit record.',
    `findings_count` STRING COMMENT '',
    `follow_up_action` STRING COMMENT 'Planned follow‑up activity after the audit closure.',
    `hazards_identified` STRING COMMENT 'List of safety or health hazards discovered during the audit.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `location` STRING COMMENT 'Physical location or facility where the audit took place.',
    `notes` STRING COMMENT '',
    `outcome` STRING COMMENT 'Result of the audit after evaluation.. Valid values are `conforming|nonconformance|observation|pass|fail`',
    `regulatory_agency` STRING COMMENT 'Government or industry agency responsible for the inspection (e.g., OSHA, EPA).',
    `result_rating` STRING COMMENT '',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk rating derived from severity and likelihood (0.00‑10.00).',
    `scope` STRING COMMENT 'Defined boundaries of the audit (facility, zone, process, system, etc.).',
    `severity_rating` STRING COMMENT 'Risk severity assigned to any non‑conformance or observation.. Valid values are `critical|high|medium|low|informational`',
    `summary` STRING COMMENT 'Free‑text summary of the audit findings and observations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the audit event record.',
    `vulnerabilities_identified` STRING COMMENT 'Security or process vulnerabilities uncovered, especially for cybersecurity assessments.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_audit_event PRIMARY KEY(`audit_event_id`)
) COMMENT 'Unified execution record of any compliance assessment, verification, or inspection activity conducted at Manufacturing. Encompasses formal certification audits (ISO 9001, ISO 14001, ISO 45001, IEC 62443), regulatory inspections (OSHA, EPA), internal quality audits, periodic compliance evaluations (ISO 14001 Clause 9.1.2, ISO 45001 Clause 9.1.2), workplace safety inspections and walkthroughs (routine, pre-startup, LOTO verification, fire safety, ergonomic), cybersecurity risk assessments (IEC 62443-3-2 zone/conduit analysis, NIST CSF), and management system reviews. Captures assessment type (certification_audit, regulatory_inspection, internal_audit, periodic_evaluation, safety_inspection, cybersecurity_assessment, management_review), actual dates, assessor/auditor names, assessment method (on-site, remote, document review, observation, testing, checklist), scope (facility, zone, process, system, area), overall outcome (conforming, nonconformance, observation, pass/fail), severity/risk rating, summary narrative, hazards or vulnerabilities identified, and certification body or regulatory agency involved. Links to the governing audit_plan and generates audit_findings. Serves as the single authoritative transactional record for ALL compliance verification activities at Manufacturing.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` (
    `compliance_audit_finding_id` BIGINT COMMENT 'Unique identifier for the audit finding record.',
    `control_system_id` BIGINT COMMENT 'Foreign key linking to automation.control_system. Business justification: Audit findings often target a specific control system; linking enables traceability for corrective actions.',
    `controlled_document_id` BIGINT COMMENT 'Identifier of the supporting evidence document linked to the finding.',
    `prior_finding_id` BIGINT COMMENT 'Identifier of the prior related finding, if any.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Findings are linked to the project they affect to drive corrective actions within that project.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Assigns a responsible employee for corrective action on each finding, essential for CAPA tracking.',
    `audit_event_id` BIGINT COMMENT 'Identifier of the audit event that generated this finding.',
    `actual_resolution_date` DATE COMMENT 'Date when the finding was actually resolved.',
    `affected_process` STRING COMMENT 'Business process impacted by the finding.. Valid values are `design|production|procurement|quality|maintenance|customer_service`',
    `audit_finding_number` STRING COMMENT 'Human‑readable identifier for the finding used in reports.. Valid values are `^AF-d{6}$`',
    `clause_violated` STRING COMMENT 'Specific clause or requirement that was violated.',
    `closure_date` TIMESTAMP COMMENT '',
    `compliance_audit_finding_description` STRING COMMENT 'Detailed narrative of the audit finding.',
    `compliance_audit_finding_status` STRING COMMENT 'Current lifecycle status of the finding.. Valid values are `open|in_progress|closed|deferred|rejected`',
    `corrective_action_description` STRING COMMENT 'Description of the corrective action to be taken.',
    `corrective_action_due_date` TIMESTAMP COMMENT '',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether a corrective action is mandated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the finding record was created in the system.',
    `discovery_date` DATE COMMENT 'Date when the finding was identified.',
    `finding_code` STRING COMMENT '',
    `finding_description` STRING COMMENT '',
    `finding_type` STRING COMMENT 'Category of the audit finding indicating its nature.. Valid values are `major_nonconformance|minor_nonconformance|observation|opportunity_for_improvement`',
    `impact_area` STRING COMMENT 'Primary business area impacted by the finding.. Valid values are `safety|environment|quality|cost|schedule|regulatory`',
    `is_repeat_finding` BOOLEAN COMMENT 'Indicates if this finding repeats a previously recorded issue.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT 'Free‑form notes related to the finding.',
    `regulatory_reference` STRING COMMENT 'Reference to the regulatory standard or clause associated with the finding.',
    `reported_by` STRING COMMENT 'Name or identifier of the person who reported the finding.',
    `risk_rating` STRING COMMENT 'Overall risk rating associated with the finding.. Valid values are `high|medium|low`',
    `root_cause_analysis` STRING COMMENT 'Analysis of the underlying cause of the finding.',
    `severity` STRING COMMENT 'Severity rating of the finding based on impact.. Valid values are `critical|high|medium|low|informational`',
    `target_resolution_date` DATE COMMENT 'Planned date for corrective action completion.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the finding record.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_compliance_audit_finding PRIMARY KEY(`compliance_audit_finding_id`)
) COMMENT 'Individual finding record raised during a compliance audit, capturing finding type (major nonconformance, minor nonconformance, observation, opportunity for improvement), the specific clause or requirement violated, affected process or area, finding description, severity, and required response timeline. Each finding is linked to an audit event and may trigger a CAPA record. Serves as the authoritative record of audit outcomes requiring corrective action.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` (
    `compliance_capa_record_id` BIGINT COMMENT 'Unique identifier for the CAPA record.',
    `compliance_audit_finding_id` BIGINT COMMENT 'Identifier of the audit finding that triggered this CAPA.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CAPA costs are allocated to cost centers for overhead accounting and compliance cost visibility.',
    `customer_complaint_id` BIGINT COMMENT 'Identifier of the customer complaint that led to this CAPA.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for the CAPA.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: CAPA corrective actions are funded through internal orders; the link tracks spend per corrective action.',
    `ncr_id` BIGINT COMMENT 'Identifier of the NCR linked to this CAPA.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: CAPA records address issues identified in project audits and must be tied to the originating project.',
    `regulatory_requirement_id` BIGINT COMMENT 'Identifier of the regulatory citation associated with this CAPA.',
    `abatement_deadline` DATE COMMENT 'Date by which the penalty must be paid or remedial action completed.',
    `action_plan` STRING COMMENT '',
    `actual_completion_date` TIMESTAMP COMMENT '',
    `capa_number` STRING COMMENT 'Business identifier assigned to the CAPA record.',
    `capa_type` STRING COMMENT '',
    `citation_reference` STRING COMMENT 'Reference number or identifier of the regulatory citation.',
    `closure_date` DATE COMMENT 'Date when the CAPA record was formally closed.',
    `closure_status` STRING COMMENT 'Final status indicating how the CAPA was concluded.. Valid values are `completed|cancelled|deferred`',
    `compliance_capa_record_status` STRING COMMENT 'Current lifecycle status of the CAPA.. Valid values are `open|in_progress|closed|rejected`',
    `compliance_framework` STRING COMMENT 'Compliance framework(s) relevant to the CAPA.. Valid values are `iso_9001|iso_14001|iso_45001|osha|epa|iec_62443`',
    `corrective_action_description` STRING COMMENT 'Description of the corrective action to address the root cause.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the CAPA record was created in the system.',
    `department_responsible` STRING COMMENT 'Department accountable for executing the CAPA.. Valid values are `quality|production|engineering|safety|procurement|other`',
    `compliance_capa_record_description` STRING COMMENT '',
    `documentation_reference` STRING COMMENT 'Reference to supporting documentation for the CAPA.',
    `effectiveness_review_outcome` STRING COMMENT 'Result of the effectiveness review after verification.. Valid values are `effective|partially_effective|ineffective|not_verified`',
    `effectiveness_score` DECIMAL(18,2) COMMENT 'Numeric rating (0‑100) indicating the effectiveness of the corrective action after verification.',
    `effectiveness_verified_flag` BOOLEAN COMMENT '',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp when the CAPA was initiated.',
    `is_external_citation` BOOLEAN COMMENT 'Indicates whether the citation originates from an external regulator.',
    `issuing_agency` BOOLEAN COMMENT 'Agency that issued the regulatory citation prompting the CAPA.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `last_review_date` DATE COMMENT 'Date of the most recent effectiveness review.',
    `notes` STRING COMMENT 'Free‑form field for any additional information or comments.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty associated with the regulatory citation.',
    `penalty_currency` STRING COMMENT 'Currency code of the penalty amount, following ISO 4217.',
    `preventive_action_description` STRING COMMENT 'Description of the preventive action to avoid recurrence.',
    `priority` STRING COMMENT 'Priority level assigned to the CAPA.. Valid values are `low|medium|high|critical`',
    `review_frequency` STRING COMMENT 'Frequency at which the CAPA effectiveness is reviewed.. Valid values are `weekly|monthly|quarterly|annually`',
    `risk_level` STRING COMMENT 'Overall risk level associated with the CAPA.. Valid values are `low|medium|high`',
    `root_cause` STRING COMMENT '',
    `root_cause_description` STRING COMMENT 'Detailed description of the identified root cause.',
    `root_cause_method` STRING COMMENT 'Method used to determine the root cause of the issue.. Valid values are `5-why|fishbone|8d|fmea|other`',
    `severity` STRING COMMENT 'Severity of the issue addressed by the CAPA.. Valid values are `minor|major|critical`',
    `target_completion_date` DATE COMMENT 'Planned date by which the corrective and preventive actions should be completed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the CAPA record.',
    `verification_method` STRING COMMENT 'Method used to verify that the corrective action was effective.. Valid values are `inspection|test|audit|review|other`',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_compliance_capa_record PRIMARY KEY(`compliance_capa_record_id`)
) COMMENT 'Corrective and Preventive Action (CAPA) record managing the full lifecycle of corrective actions arising from audit findings, safety incidents, enforcement actions, NCRs, customer complaints, or regulatory citations. Captures root cause analysis method (5-Why, Fishbone, 8D, FMEA), root cause description, corrective action plan, preventive action plan, responsible owner, target completion date, verification method, effectiveness review outcome, and closure status. Also accommodates enforcement action details (issuing agency, citation reference, penalty amount, abatement deadline) when the CAPA originates from a regulatory citation. Aligns with ISO 9001 Clause 10.2 and APQP CAPA requirements.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` (
    `safety_incident_id` BIGINT COMMENT 'Primary key for safety_incident',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Incident management requires associating each safety incident with the specific site for root cause analysis and regulatory reporting.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee (worker) involved or affected by the incident.',
    `equipment_register_id` BIGINT COMMENT 'Identifier of the equipment or asset involved in the incident.',
    `facility_id` BIGINT COMMENT '',
    `previous_incident_safety_incident_id` BIGINT COMMENT 'Identifier of the prior incident if this is a repeat.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Safety incidents occurring on a project site are linked to that project for reporting and trend analysis.',
    `area_code` STRING COMMENT 'Code for the specific area or zone within the plant.',
    `body_part_affected` STRING COMMENT 'Body part(s) impacted by the injury.. Valid values are `head|neck|torso|upper_extremity|lower_extremity|multiple`',
    `corrective_action_due_date` DATE COMMENT 'Target date for completion of corrective actions.',
    `corrective_action_status` STRING COMMENT 'Current status of the longer‑term corrective action plan.. Valid values are `planned|in_progress|completed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident record was first created in the system.',
    `days_away_from_work` STRING COMMENT 'Number of workdays the employee was unable to work due to the incident.',
    `safety_incident_description` STRING COMMENT '',
    `equipment_name` STRING COMMENT 'Human‑readable name of the equipment involved.',
    `immediate_corrective_action` STRING COMMENT 'Actions taken immediately after the incident to mitigate impact.',
    `incident_description` STRING COMMENT 'Detailed narrative of what happened.',
    `incident_location` STRING COMMENT 'Free-text description of the physical location where the incident occurred.',
    `incident_number` STRING COMMENT 'Business identifier assigned to the incident, used for tracking and reporting.',
    `incident_report_number` STRING COMMENT 'External report number assigned by regulatory bodies.',
    `incident_status` STRING COMMENT 'Current lifecycle status of the incident.. Valid values are `open|investigating|closed|reopened`',
    `incident_timestamp` TIMESTAMP COMMENT 'Date and time when the incident occurred.',
    `incident_type` STRING COMMENT 'Classification of the incident according to regulatory definitions.. Valid values are `recordable|lost_time|near_miss|property_damage|first_aid`',
    `injury_flag` BOOLEAN COMMENT '',
    `injury_type` STRING COMMENT 'Specific type of injury or illness sustained.. Valid values are `fracture|burn|laceration|sprain|concussion|other`',
    `investigation_completed_date` DATE COMMENT 'Date when the investigation was formally closed.',
    `investigation_status` STRING COMMENT 'Lifecycle status of the incident investigation.. Valid values are `not_started|in_progress|completed`',
    `is_repeat_incident` BOOLEAN COMMENT 'Indicates whether this incident is a repeat of a prior incident.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `lost_time_flag` BOOLEAN COMMENT 'Indicates whether the incident resulted in lost work time.',
    `lost_time_hours` DECIMAL(18,2) COMMENT '',
    `medical_treatment_required` BOOLEAN COMMENT 'True if medical treatment beyond first aid was required.',
    `notes` STRING COMMENT '',
    `osha_300_log_classification` STRING COMMENT 'Classification of the incident for OSHA 300 reporting.. Valid values are `recordable|non_recordable`',
    `plant_code` STRING COMMENT 'Code identifying the manufacturing plant where the incident happened.',
    `regulatory_report_submission_date` DATE COMMENT 'Date the regulatory report was filed.',
    `regulatory_report_submitted_flag` BOOLEAN COMMENT 'True if the incident has been submitted to required regulators.',
    `reportable_to_iso_flag` BOOLEAN COMMENT 'Indicates if the incident must be reported under ISO 45001.',
    `reportable_to_osha_flag` BOOLEAN COMMENT 'Indicates if the incident must be reported to OSHA.',
    `reported_by` STRING COMMENT 'Name of the person who reported the incident.',
    `reported_by_name` STRING COMMENT '',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was reported.',
    `risk_rating` STRING COMMENT 'Risk rating assigned during incident assessment.. Valid values are `low|medium|high|critical`',
    `root_cause` STRING COMMENT 'Narrative description of the underlying cause(s) of the incident.',
    `severity` STRING COMMENT '',
    `severity_level` STRING COMMENT 'Overall severity rating of the incident.. Valid values are `minor|moderate|severe|critical`',
    `shift` STRING COMMENT 'Work shift during which the incident occurred.. Valid values are `day|swing|night`',
    `safety_incident_status` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the incident record.',
    `witness_count` STRING COMMENT 'Number of witnesses to the incident.',
    `witness_names` STRING COMMENT 'Comma‑separated list of witness names.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_safety_incident PRIMARY KEY(`safety_incident_id`)
) COMMENT 'ISO 45001 and OSHA occupational health and safety incident record capturing workplace injuries, illnesses, near-misses, dangerous occurrences, and first-aid events. Records incident date/time, location, affected worker(s), incident type (OSHA recordable, lost-time, near-miss, property damage), injury/illness description, body part affected, days away from work, OSHA 300 log classification, root cause, and immediate corrective actions taken. Primary source for OSHA 300/300A/301 regulatory reporting.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` (
    `safety_inspection_id` BIGINT COMMENT 'System-generated unique identifier for each safety inspection record.',
    `device_registry_id` BIGINT COMMENT 'Foreign key linking to automation.device_registry. Business justification: Safety inspections must record which automation device was inspected to satisfy OSHA safety compliance.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee or contractor who performed the inspection.',
    `facility_id` BIGINT COMMENT '',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Safety inspections are performed for each construction/upgrade project; required for safety compliance reports.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Safety inspections are performed to satisfy regulatory requirements; linking to regulatory_requirement provides context and eliminates need for separate regulatory reference fields.',
    `safety_checklist_id` BIGINT COMMENT 'Reference to the checklist template used for this inspection.',
    `area` STRING COMMENT 'Specific area, zone, or work cell within the facility that was inspected.',
    `average_score` DECIMAL(18,2) COMMENT 'Weighted average score derived from checklist item results (0‑100 scale).',
    `compliance_status` STRING COMMENT 'Result of the inspection against regulatory and internal safety standards.. Valid values are `compliant|non_compliant|conditional`',
    `corrective_action_deadline` DATE COMMENT 'Final date by which all corrective actions must be closed.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether any immediate corrective actions are mandated.',
    `corrective_action_summary` STRING COMMENT 'Brief description of the corrective actions to be taken.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `safety_inspection_description` STRING COMMENT '',
    `documents_attached` TIMESTAMP COMMENT 'True if supporting photos, reports, or certificates are attached to the record.',
    `emergency_exit_accessible` BOOLEAN COMMENT 'True if all emergency exits were clear and unobstructed.',
    `fire_extinguisher_checked` BOOLEAN COMMENT 'Indicates whether fire extinguishers were inspected and found serviceable.',
    `follow_up_date` DATE COMMENT 'Planned date by which corrective actions must be completed.',
    `hazards_identified` STRING COMMENT 'Number of distinct safety hazards observed during the inspection.',
    `inspection_date` TIMESTAMP COMMENT '',
    `inspection_duration_minutes` DECIMAL(18,2) COMMENT 'Total time spent on the inspection, measured in minutes.',
    `inspection_number` STRING COMMENT 'Human‑readable business identifier for the inspection, often used in reports and work orders.',
    `inspection_timestamp` TIMESTAMP COMMENT 'Date‑time when the inspection was actually performed on the facility/area.',
    `inspection_type` STRING COMMENT 'Classification of the inspection purpose or trigger.. Valid values are `routine|pre_startup|loto_verification|fire_safety|ergonomic|environmental`',
    `inspector_name` STRING COMMENT '',
    `is_loto_verified` BOOLEAN COMMENT 'True if lock‑out/tag‑out procedures were verified during the inspection.',
    `items_failed` STRING COMMENT 'Count of checklist items that were non‑compliant or required corrective action.',
    `items_passed` STRING COMMENT 'Count of checklist items that met the required safety criteria.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT 'Free‑form observations, comments, or remarks recorded by the inspector.',
    `pass_flag` BOOLEAN COMMENT '',
    `ppe_compliance` BOOLEAN COMMENT 'Indicates whether required PPE was observed being used by personnel.',
    `record_created_timestamp` TIMESTAMP COMMENT 'System timestamp when the inspection record was first created in the lakehouse.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the inspection record.',
    `reported_by` STRING COMMENT 'Name of the person who reported the safety issue or initiated the inspection.',
    `reported_timestamp` TIMESTAMP COMMENT 'Date‑time when the inspection request or incident was logged.',
    `result_rating` STRING COMMENT '',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned based on identified hazards and severity.. Valid values are `low|medium|high|critical`',
    `root_cause_analysis` STRING COMMENT 'Narrative description of the underlying cause(s) of identified hazards.',
    `safety_inspection_status` STRING COMMENT 'Current lifecycle state of the inspection record.. Valid values are `scheduled|in_progress|completed|closed|cancelled`',
    `safety_score` DECIMAL(18,2) COMMENT 'Composite safety performance metric for the inspected area.',
    `total_items_checked` DECIMAL(18,2) COMMENT 'Number of individual checklist items evaluated during the inspection.',
    `training_due_date` DATE COMMENT 'Target date by which required safety training must be completed.',
    `training_required` BOOLEAN COMMENT 'True if the inspection identified a need for additional safety training.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_safety_inspection PRIMARY KEY(`safety_inspection_id`)
) COMMENT 'Workplace safety inspection record capturing scheduled and ad-hoc safety walkthroughs, hazard assessments, and safety audits conducted under ISO 45001 and OSHA requirements. Records inspection date, inspector, facility/area inspected, inspection type (routine, pre-startup, LOTO verification, fire safety, ergonomic), checklist items evaluated, hazards identified, risk rating, and immediate corrective actions. Distinct from audit_event which covers formal certification audits.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` (
    `environmental_aspect_id` BIGINT COMMENT 'Unique system-generated identifier for each environmental aspect record.',
    `facility_id` BIGINT COMMENT '',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Environmental aspects are assessed per project for regulatory reporting and impact tracking.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Environmental aspects are tracked against specific regulatory requirements; FK replaces duplicated legal requirement reference fields.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Assigns an employee responsible for each environmental aspect, required for environmental compliance reporting.',
    `actual_value` DECIMAL(18,2) COMMENT 'Most recent measured value for the aspect.',
    `aspect_category` STRING COMMENT 'High‑level classification of the aspect (e.g., air emission, waste).. Valid values are `air_emission|water_effluent|waste|energy_use|noise|soil_contamination`',
    `aspect_code` STRING COMMENT 'Business identifier or code used to reference the aspect in reports and systems.',
    `aspect_name` STRING COMMENT 'Human‑readable name describing the environmental aspect (e.g., "CO2 Emissions from Furnace").',
    `aspect_type` STRING COMMENT '',
    `baseline_value` DECIMAL(18,2) COMMENT 'Historical or reference value against which current performance is compared.',
    `compliance_status` STRING COMMENT 'Current compliance state of the aspect against legal requirements.. Valid values are `compliant|non_compliant|partial`',
    `control_measure_description` STRING COMMENT 'Description of the control or mitigation measure applied to the aspect.',
    `control_measures` STRING COMMENT '',
    `corrective_action_description` STRING COMMENT 'Description of the corrective action to address non‑compliance.',
    `corrective_action_due_date` DATE COMMENT 'Target date for completion of the corrective action.',
    `corrective_action_required` BOOLEAN COMMENT 'Flag indicating if a corrective action is needed.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_source_system` STRING COMMENT 'Originating operational system (e.g., SAP S/4HANA, Aveva SCADA).',
    `environmental_aspect_description` STRING COMMENT '',
    `effective_date` DATE COMMENT 'Date when the aspect record became effective.',
    `environmental_impact` STRING COMMENT '',
    `impact_type` STRING COMMENT 'Primary environmental medium affected by the aspect.. Valid values are `air|water|soil|noise|energy`',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the aspect is deemed critical to environmental compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the aspect record.. Valid values are `active|inactive|retired|pending`',
    `measurement_unit` STRING COMMENT 'Unit of measure for the aspect’s quantitative values.. Valid values are `kg_co2e|m3|kwh|db|kg|l`',
    `monitoring_frequency` STRING COMMENT 'How often the aspect is measured or reviewed.. Valid values are `daily|weekly|monthly|quarterly|annually`',
    `monitoring_method` STRING COMMENT 'Technique or instrument used to monitor the aspect (e.g., continuous emission monitoring system).',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the aspect.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the aspect record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the aspect record.',
    `responsible_department` STRING COMMENT 'Organizational department accountable for managing the aspect.',
    `review_date` DATE COMMENT 'Scheduled date for the next formal review of the aspect.',
    `significance_rating` STRING COMMENT 'Business‑defined importance of the aspect to the organization’s environmental impact.. Valid values are `high|medium|low`',
    `environmental_aspect_status` STRING COMMENT '',
    `target_value` DECIMAL(18,2) COMMENT 'Regulatory or internal target for the aspect.',
    `variance` DECIMAL(18,2) COMMENT 'Difference between actual and target values (actual – target).',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_environmental_aspect PRIMARY KEY(`environmental_aspect_id`)
) COMMENT 'ISO 14001 environmental aspect and impact register record identifying the environmental aspects of Manufacturing operations (emissions, effluents, waste, energy use, noise, land contamination) and their associated environmental impacts. Captures aspect description, activity or process generating the aspect, significance rating, applicable legal requirements, control measures in place, and monitoring obligations. Serves as the foundation for the ISO 14001 Environmental Management System (EMS).';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` (
    `emissions_record_id` BIGINT COMMENT 'Unique identifier for the emissions record.',
    `device_registry_id` BIGINT COMMENT 'Identifier of the device that captured the measurement.',
    `emission_source_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who recorded or verified the measurement.',
    `facility_id` BIGINT COMMENT '',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Emissions measurements are tied to specific projects to monitor environmental impact and meet permits.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Emissions records are governed by regulatory limits; linking to the governing requirement removes the duplicated limit column.',
    `source_emission_source_id` BIGINT COMMENT 'Identifier of the emission source (e.g., plant, stack, equipment).',
    `calibration_date` DATE COMMENT 'Date when the measurement device was last calibrated.',
    `calibration_status` DECIMAL(18,2) COMMENT 'Current calibration status of the measurement device.',
    `carbon_intensity` DECIMAL(18,2) COMMENT 'Amount of CO₂e emitted per unit of production output.',
    `comments` STRING COMMENT 'Free‑form notes or remarks about the measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the emissions record was first created in the system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Score (0‑100) indicating confidence in the measurement data.',
    `data_source_system` STRING COMMENT 'Source system that provided the emission measurement (e.g., SAP, SCADA).',
    `emissions_record_description` STRING COMMENT '',
    `emission_factor` DECIMAL(18,2) COMMENT 'Factor used to convert activity data to emissions (e.g., kg CO2 per unit).',
    `emission_quantity` DECIMAL(18,2) COMMENT '',
    `emission_uom` STRING COMMENT '',
    `exceedance_flag` BOOLEAN COMMENT 'Indicates whether the measured value exceeds the regulatory limit.',
    `facility_address` STRING COMMENT 'Physical address of the facility.',
    `greenhouse_gas_equivalent` DECIMAL(18,2) COMMENT 'CO₂‑equivalent value of the measured pollutant.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the facility.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the facility.',
    `measured_value` DECIMAL(18,2) COMMENT 'Numeric value of the measured emission.',
    `measurement_date` TIMESTAMP COMMENT '',
    `measurement_device_type` STRING COMMENT 'Type or model of the measurement device.',
    `measurement_method` STRING COMMENT 'Method used to obtain the emission measurement.. Valid values are `continuous|periodic|calculated|modelled`',
    `measurement_status` STRING COMMENT 'Quality status of the measurement.. Valid values are `valid|invalid|pending|rejected`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the emission measurement was taken.',
    `notes` STRING COMMENT '',
    `operational_shift` DECIMAL(18,2) COMMENT 'Shift during which the measurement was taken.',
    `permit_limit_quantity` DECIMAL(18,2) COMMENT '',
    `pollutant_type` STRING COMMENT 'Type of pollutant measured.. Valid values are `CO2|NOx|SOx|VOC|PM2.5|PM10`',
    `report_status` STRING COMMENT 'Current status of the regulatory report.. Valid values are `submitted|approved|rejected|pending`',
    `report_submission_date` DATE COMMENT 'Date the emission report was submitted to the agency.',
    `reported_to_agency` STRING COMMENT 'Regulatory agency to which this emission data is reported.. Valid values are `EPA|State|Local|None`',
    `reporting_period_end` DATE COMMENT 'End date of the reporting period for this emission record.',
    `reporting_period_start` DATE COMMENT 'Start date of the reporting period for this emission record.',
    `reporting_quarter` STRING COMMENT 'Quarter of the reporting period.. Valid values are `Q1|Q2|Q3|Q4`',
    `reporting_year` STRING COMMENT 'Calendar year of the reporting period.',
    `source_category` STRING COMMENT 'Category describing the nature of the emission source.. Valid values are `stationary|mobile|process|fugitive`',
    `emissions_record_status` STRING COMMENT '',
    `unit_of_measure` STRING COMMENT 'Unit in which the measured value is expressed.. Valid values are `kg|ton|kgCO2e|lb|g|ppm`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the emissions record.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_emissions_record PRIMARY KEY(`emissions_record_id`)
) COMMENT 'EPA and ISO 14001 emissions monitoring record capturing measured air emissions, greenhouse gas (GHG) data, wastewater discharge, and hazardous waste generation at Manufacturing facilities. Records emission source, pollutant type (CO2, NOx, SOx, VOCs, particulates), measurement method (continuous monitoring, periodic sampling, calculated), measured value, unit of measure, regulatory limit, exceedance flag, and reporting period. Primary source for EPA regulatory filings and GHG inventory reporting.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` (
    `compliance_product_certification_id` BIGINT COMMENT 'System-generated unique identifier for each product certification record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Designates the employee overseeing product certification, required for certification management and audit trails.',
    `device_registry_id` BIGINT COMMENT 'Foreign key linking to automation.device_registry. Business justification: Product certifications (e.g., UL) are granted to specific automation devices; linking tracks certification status.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Certification costs are posted to a GL account; linking enables financial reporting of certification expenses.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Product certifications are required for components used in a specific project to meet regulatory standards.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Product certifications reference the regulatory requirement they satisfy; FK consolidates this relationship.',
    `sku_master_id` BIGINT COMMENT 'FK to product.sku_master',
    `attached_document_path` STRING COMMENT 'File system or storage reference to the digital copy of the certificate.',
    `certificate_number` STRING COMMENT 'Unique number assigned by the certifying body to this certification.',
    `certification_cost` DECIMAL(18,2) COMMENT 'Monetary cost incurred to obtain the certification.',
    `certification_name` STRING COMMENT 'Human‑readable name of the certification (e.g., CE Marking for Model X).',
    `certification_number` STRING COMMENT '',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification.. Valid values are `active|expired|revoked|pending|suspended`',
    `certification_type` STRING COMMENT 'Category of certification indicating the standard or scheme applied.. Valid values are `CE|UL|IEC|RoHS|REACH|Other`',
    `certifying_body` STRING COMMENT 'Organization that issued the certification. [ENUM-REF-CANDIDATE: EU|US|UL|IEC|ISO|CE|Other — 7 candidates stripped; promote to reference product]',
    `compliance_audit_date` DATE COMMENT 'Date the latest compliance audit was performed.',
    `compliance_audit_status` STRING COMMENT 'Result of the most recent compliance audit.. Valid values are `passed|failed|pending|not_applicable`',
    `compliance_category` STRING COMMENT 'High‑level classification of the certification purpose.. Valid values are `Safety|Environmental|Cybersecurity|Quality|Other`',
    `compliance_region` STRING COMMENT 'Geographic region for which the certification is valid.. Valid values are `USA|EU|APAC|MEA|LATAM|Other`',
    `compliance_risk_level` STRING COMMENT 'Risk rating associated with the certification status or upcoming expiry.. Valid values are `low|medium|high|critical`',
    `compliance_status_date` DATE COMMENT 'Date when the certification status was last updated.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for certification cost.. Valid values are `USD|EUR|GBP|JPY|CNY|Other`',
    `compliance_product_certification_description` STRING COMMENT '',
    `effective_from` DATE COMMENT 'Date from which the certification is considered effective.',
    `effective_until` DATE COMMENT 'Date until which the certification remains effective (may be null for open‑ended).',
    `expiry_date` DATE COMMENT 'Date the certification becomes invalid unless renewed.',
    `export_control_category` STRING COMMENT 'Classification of export control regime applicable to the product.. Valid values are `EAR|ITAR|None|Other`',
    `is_export_controlled` BOOLEAN COMMENT 'Indicates whether the product is subject to export control regulations.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the certification is mandatory for market entry or regulatory compliance.',
    `issue_date` TIMESTAMP COMMENT 'Date the certification was officially issued.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection that validated the certification.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `next_inspection_due` DATE COMMENT 'Planned date for the next compliance inspection.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the certification.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the certification record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the certification record.',
    `renewal_date` DATE COMMENT 'Planned date for renewal activities.',
    `renewal_required` BOOLEAN COMMENT 'Indicates whether the certification must be renewed before expiry.',
    `scope_description` STRING COMMENT 'Textual description of the product scope covered by the certification.',
    `compliance_product_certification_status` STRING COMMENT '',
    `test_standard` STRING COMMENT 'Standard or test method used to achieve the certification.. Valid values are `IEC 61010|IEC 61508|ISO 9001|ISO 14001|ISO 45001|Other`',
    `version_number` STRING COMMENT 'Version identifier for the certification record (e.g., v1, v2).',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_compliance_product_certification PRIMARY KEY(`compliance_product_certification_id`)
) COMMENT 'Product safety and regulatory certification master record tracking CE Marking, UL certification, IEC compliance, RoHS, REACH, and other product-level certifications for manufactured automation systems, electrification solutions, and smart infrastructure components. Captures certification type, certifying body, certificate number, issue date, expiry date, applicable product scope, test standard, and certification status. Distinct from asset.asset_certification which covers equipment/facility certifications.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` (
    `regulatory_filing_id` BIGINT COMMENT 'Unique surrogate key for each regulatory filing record.',
    `automation_project_id` BIGINT COMMENT 'Foreign key linking to automation.automation_project. Business justification: Regulatory filings are submitted for specific automation projects; linking ties filing to project for audit.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Regulatory filings are filed by a legal entity; company_code links filing to the responsible entity for audit trails.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal party responsible for the document.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Regulatory filings are made against specific regulatory requirements; FK replaces the agency reference field.',
    `sku_master_id` BIGINT COMMENT 'Identifier of the product to which the filing pertains.',
    `project_header_id` BIGINT COMMENT 'Identifier of the project associated with the filing, if any.',
    `acknowledgment_reference` STRING COMMENT 'Reference number or code returned by the agency confirming receipt.',
    `applicable_standard` STRING COMMENT 'Standard or regulation that the document satisfies (e.g., ISO 14001).',
    `approval_date` DATE COMMENT 'Date the document received final approval.',
    `approval_status` STRING COMMENT 'Result of the formal approval workflow.. Valid values are `approved|rejected|under_review`',
    `attached_file_path` STRING COMMENT 'File system or storage location of the attached document.',
    `authority_name` STRING COMMENT '',
    `comments` STRING COMMENT 'Free‑form notes or remarks about the filing.',
    `compliance_area` STRING COMMENT 'Domain of compliance addressed by the filing.. Valid values are `environmental|safety|quality|cybersecurity|product_safety`',
    `confidentiality_level` STRING COMMENT 'Classification of the documents sensitivity.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the filing record was first created in the system.',
    `regulatory_filing_description` STRING COMMENT '',
    `distribution_scope` STRING COMMENT 'Scope of distribution for the document.. Valid values are `internal|external|global|regional`',
    `document_description` STRING COMMENT 'Free‑text description of the documents purpose and scope.',
    `document_number` STRING COMMENT 'Business identifier assigned to the document (e.g., ISO‑9001‑DOC‑001).',
    `document_type` STRING COMMENT 'Classification of the document indicating its purpose within compliance.. Valid values are `external_submission|internal_procedure|work_instruction|plan|program|record`',
    `due_date` TIMESTAMP COMMENT '',
    `effective_date` DATE COMMENT 'Date the document becomes effective for the organization.',
    `expiration_date` DATE COMMENT 'Date the document expires or is superseded, if applicable.',
    `file_checksum` STRING COMMENT 'Checksum (e.g., SHA‑256) for integrity verification of the attached file.',
    `file_size_bytes` BIGINT COMMENT 'Size of the attached file in bytes.',
    `filing_date` TIMESTAMP COMMENT '',
    `filing_number` STRING COMMENT '',
    `filing_period` STRING COMMENT 'Reporting period the filing covers.. Valid values are `annual|quarterly|monthly|biannual|ad_hoc`',
    `filing_status` STRING COMMENT 'Current processing status of the external filing.. Valid values are `submitted|accepted|rejected|pending|closed`',
    `filing_type` STRING COMMENT '',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the filing is required by law or regulation.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent review activity.',
    `next_review_timestamp` TIMESTAMP COMMENT 'Planned timestamp for the upcoming review.',
    `notes` STRING COMMENT '',
    `regulatory_filing_status` STRING COMMENT 'Current lifecycle state of the document.. Valid values are `draft|pending|approved|rejected|archived`',
    `retention_period_days` STRING COMMENT 'Number of days the document must be retained according to policy.',
    `review_due_date` DATE COMMENT 'Scheduled date for the next mandatory review of the document.',
    `revision_number` STRING COMMENT 'Version label for the document (e.g., A, B, 1.0, 2.1).',
    `risk_level` STRING COMMENT 'Risk rating associated with non‑compliance.. Valid values are `low|medium|high`',
    `submission_date` DATE COMMENT 'Date the filing was submitted to the external regulatory agency.',
    `submission_method` STRING COMMENT 'Mechanism used to submit the filing.. Valid values are `electronic|paper|portal|email`',
    `submission_status` STRING COMMENT '',
    `title` STRING COMMENT 'Human‑readable title of the filing or compliance document.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the filing record.',
    `version_number` STRING COMMENT 'Sequential numeric version of the document.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_regulatory_filing PRIMARY KEY(`regulatory_filing_id`)
) COMMENT 'Unified compliance document and regulatory submission master record serving as the single source of truth for: (1) all mandatory regulatory filings, disclosures, and notifications submitted to external bodies including EPA, OSHA, ISO certification bodies, CE notified bodies, and government agencies; and (2) all controlled internal compliance documents including ISO management system procedures, work instructions, environmental management plans, safety programs, audit reports, and certification records. Captures document/filing type (external_submission, internal_procedure, work_instruction, plan, program, record), document number, revision level, applicable standard or regulation, document owner, approval workflow status, effective date, review due date, retention period, distribution scope, and for external filings: submission date, regulatory agency, filing period, submission method, acknowledgment reference, and filing status. Supports ISO 9001 Clause 7.5 document control requirements and serves as the compliance submission calendar and document audit trail.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`compliance`.`permit` (
    `permit_id` BIGINT COMMENT 'Unique system-generated identifier for the permit record.',
    `company_code_id` BIGINT COMMENT 'Identifier of the party (person or organization) that holds the permit.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Links permit oversight to a compliance officer employee, needed for permit compliance monitoring.',
    `device_registry_id` BIGINT COMMENT 'Foreign key linking to automation.device_registry. Business justification: Regulatory permits are often issued per automation device; linking ensures permit compliance tracking.',
    `facility_id` BIGINT COMMENT '',
    `node_id` BIGINT COMMENT 'Identifier of the manufacturing facility to which the permit applies.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Permits are issued for individual projects (construction, operation) and must be linked for compliance tracking.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Permits are issued to satisfy regulatory requirements; linking provides direct association.',
    `activity_description` STRING COMMENT 'Narrative of the activity or operation authorized by the permit.',
    `amendment_date` DATE COMMENT 'Date when the latest amendment was filed.',
    `amendment_number` STRING COMMENT 'Sequential number of the most recent amendment to the permit.',
    `attached_documents` STRING COMMENT 'Reference to supporting documents (e.g., PDFs) stored in the document management system.',
    `compliance_status` STRING COMMENT 'Current compliance determination for the permit.. Valid values are `compliant|non_compliant|under_review`',
    `condition` STRING COMMENT 'Specific condition, limitation, or requirement imposed by the authority.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the permit record was first created in the system.',
    `permit_description` STRING COMMENT '',
    `expiration_notice_sent` DECIMAL(18,2) COMMENT 'Indicates whether a renewal/expiration notice has been sent to the responsible party.',
    `expiry_date` DATE COMMENT 'Date the permit expires or becomes invalid unless renewed.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee associated with obtaining or renewing the permit.',
    `fee_currency` DECIMAL(18,2) COMMENT 'Currency of the permit fee.',
    `fee_due_date` TIMESTAMP COMMENT 'Date by which the permit fee must be paid.',
    `inspection_outcome` STRING COMMENT 'Result of the last inspection.. Valid values are `pass|fail|conditional`',
    `issue_date` TIMESTAMP COMMENT 'Date the permit was officially issued by the authority.',
    `issuing_authority` BOOLEAN COMMENT 'Regulatory body or agency that issued the permit.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection related to the permit.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `limit_unit` STRING COMMENT 'Unit of measure for the limit value.. Valid values are `tons_per_year|kg_per_day|cfm|lb_per_hour|gallons_per_day`',
    `limit_value` DECIMAL(18,2) COMMENT 'Numeric limit associated with the permit (e.g., emission limit).',
    `monitoring_frequency` STRING COMMENT 'How often compliance monitoring must be performed.. Valid values are `monthly|quarterly|annually|continuous`',
    `next_monitoring_date` DATE COMMENT 'Scheduled date for the next required monitoring activity.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the permit.',
    `number` STRING COMMENT 'Official permit number or code assigned by the issuing authority.',
    `permit_number` STRING COMMENT '',
    `permit_status` STRING COMMENT 'Current lifecycle status of the permit.. Valid values are `active|inactive|expired|suspended|pending|revoked`',
    `permit_type` STRING COMMENT 'Category of the permit (e.g., air emissions, wastewater discharge, hazardous waste, building, operating license).. Valid values are `air|water|hazardous|building|operating`',
    `renewal_deadline` DATE COMMENT 'Last date to submit renewal application before expiration.',
    `renewal_status` STRING COMMENT 'Renewal state indicating if renewal is due, completed, not required, or pending.. Valid values are `due|renewed|not_required|pending`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the permit record.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_permit PRIMARY KEY(`permit_id`)
) COMMENT 'Environmental and operational permit master record tracking all permits required for Manufacturing facility operations, including EPA air permits, wastewater discharge permits (NPDES), hazardous waste permits (RCRA), building permits, and operating licenses. Captures permit type, issuing authority, permit number, facility, permitted activity, conditions and limits, issue date, expiry date, renewal status, and associated monitoring obligations. Enables proactive permit renewal management.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` (
    `cybersecurity_control_id` BIGINT COMMENT 'Unique system-generated identifier for the cybersecurity control record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Assigns a responsible employee to each control, required for control ownership accountability reports.',
    `control_system_id` BIGINT COMMENT 'Foreign key linking to automation.control_system. Business justification: Cybersecurity controls are implemented on specific control systems; linking supports compliance reporting.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Security controls are applied to project assets and need linkage for audit and compliance.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Cybersecurity controls are defined to meet regulatory cybersecurity standards; FK adds the governing requirement.',
    `audit_findings_count` STRING COMMENT 'Number of audit findings associated with this control.',
    `compliance_status` STRING COMMENT 'Current compliance state of the control against its target level.. Valid values are `compliant|non_compliant|partial|exempt`',
    `control_applicability_scope` STRING COMMENT 'Industrial automation domains the control applies to (e.g., PLC, SCADA, DCS, HMI, IIoT).',
    `control_category` STRING COMMENT 'High‑level classification of the control. [ENUM-REF-CANDIDATE: access_control|network_segmentation|patch_management|incident_response|monitoring|authentication|authorization|encryption|audit|physical_security — promote to reference product]. Valid values are `access_control|network_segmentation|patch_management|incident_response|monitoring|authentication`',
    `control_code` STRING COMMENT 'Standardized code or identifier for the control as defined in IEC 62443 or related standards.',
    `control_cost` DECIMAL(18,2) COMMENT 'Estimated or actual cost associated with implementing the control.',
    `control_description` STRING COMMENT 'Detailed description of what the control does and its scope.',
    `control_evidence_reference` STRING COMMENT 'Link or reference to documentation/evidence proving control implementation.',
    `control_family` STRING COMMENT '',
    `control_mechanism` STRING COMMENT 'Technical or procedural mechanism used to enforce the control.',
    `control_name` STRING COMMENT 'Human‑readable name of the security control.',
    `control_objective` STRING COMMENT 'Business or security objective that the control is intended to achieve.',
    `control_priority` STRING COMMENT 'Business‑assigned priority (1 = highest) for implementing or maintaining the control.',
    `control_source` STRING COMMENT 'Standard or framework from which the control originates (e.g., IEC 62443, NIST SP 800‑53).',
    `control_subcategory` STRING COMMENT 'More detailed classification within the main control category.',
    `control_type` STRING COMMENT 'Strategic type of the control: preventive, detective, or corrective.. Valid values are `preventive|detective|corrective`',
    `control_version` STRING COMMENT 'Version identifier of the control definition.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the control record was first created in the system.',
    `cybersecurity_control_description` STRING COMMENT '',
    `effective_date` DATE COMMENT 'Date when the control became effective.',
    `implementation_status` STRING COMMENT 'Current implementation phase of the control.. Valid values are `planned|in_progress|implemented|not_applicable|decommissioned`',
    `last_assessment_date` DATE COMMENT 'Date of the most recent security assessment for the control.',
    `last_maintenance_date` DATE COMMENT 'Date when the control was last maintained or verified.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `last_reviewed_date` TIMESTAMP COMMENT '',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle state of the control.. Valid values are `active|inactive|retired|pending`',
    `maintenance_frequency_days` STRING COMMENT 'Number of days between required maintenance activities for the control.',
    `maturity_level` STRING COMMENT '',
    `next_maintenance_date` DATE COMMENT 'Planned date for the next maintenance activity.',
    `next_review_date` DATE COMMENT 'Planned date for the next formal review of the control.',
    `notes` STRING COMMENT '',
    `owner_department` STRING COMMENT 'Organizational department that the control owner belongs to.',
    `remediation_deadline` DATE COMMENT 'Latest date by which identified deficiencies must be remediated.',
    `retirement_date` DATE COMMENT 'Date when the control was retired or decommissioned, if applicable.',
    `risk_rating` STRING COMMENT 'Risk rating associated with the control based on its effectiveness and exposure.. Valid values are `low|medium|high|critical`',
    `security_level_achieved` STRING COMMENT 'Current IEC 62443 security level actually achieved by the control.. Valid values are `SL1|SL2|SL3|SL4|SL5`',
    `security_level_target` STRING COMMENT 'Targeted IEC 62443 security level the control aims to achieve.. Valid values are `SL1|SL2|SL3|SL4|SL5`',
    `cybersecurity_control_status` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the control record.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_cybersecurity_control PRIMARY KEY(`cybersecurity_control_id`)
) COMMENT 'IEC 62443 industrial cybersecurity control master record defining the security controls, countermeasures, and safeguards implemented across Manufacturings industrial automation and control systems (IACS), including PLCs, SCADA, DCS, HMI, and IIoT infrastructure. Captures control identifier, IEC 62443 security level target (SL-T), security level achieved (SL-A), control category (access control, network segmentation, patch management, incident response), implementation status, and responsible owner.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` (
    `cybersecurity_assessment_id` BIGINT COMMENT 'Unique identifier for the cybersecurity assessment record.',
    `cybersecurity_control_id` BIGINT COMMENT '',
    `device_registry_id` BIGINT COMMENT 'Foreign key linking to automation.device_registry. Business justification: Assessment evaluates security posture of a particular automation device; linking enables tracking of findings.',
    `employee_id` BIGINT COMMENT 'Identifier of the business owner responsible for the assessed system.',
    `equipment_register_id` BIGINT COMMENT 'Identifier of the asset (e.g., PLC, SCADA server) assessed.',
    `location_id` BIGINT COMMENT 'Identifier of the physical location where the assessed system resides.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Cybersecurity assessments are performed for project systems to ensure security compliance.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Cybersecurity assessments evaluate compliance with specific regulatory requirements; FK replaces the reference field.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the assessment was approved by authority.',
    `assessed_zone` STRING COMMENT 'Name or identifier of the industrial control system zone or asset assessed.',
    `assessment_date` TIMESTAMP COMMENT 'Date and time when the assessment was performed.',
    `assessment_methodology` STRING COMMENT 'Methodology used for the cybersecurity assessment.. Valid values are `IEC 62443-3-2|NIST CSF|ISO 27001`',
    `assessment_number` STRING COMMENT 'Human-readable identifier for the assessment, often used in reports.',
    `assessment_scope` STRING COMMENT 'Scope description covering assets, processes, and boundaries evaluated.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the assessment.. Valid values are `draft|in_review|completed|approved|rejected`',
    `assessment_type` STRING COMMENT '',
    `assessment_version` STRING COMMENT 'Version identifier of the assessment methodology or report.',
    `assessor_contact` STRING COMMENT 'Email address of the assessor for follow-up.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `assessor_name` STRING COMMENT 'Name of the individual or team conducting the assessment.',
    `audit_trail_notes` STRING COMMENT 'Free-text notes capturing audit trail comments and changes.',
    `compliance_framework` STRING COMMENT 'Regulatory or standards framework applied.. Valid values are `IEC 62443|NIST CSF|ISO 27001`',
    `control_gap_summary` STRING COMMENT 'Summary of gaps between required and existing security controls.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assessment record was first created in the system.',
    `cybersecurity_assessment_description` STRING COMMENT '',
    `document_link` STRING COMMENT 'URL or path to the detailed assessment report document.',
    `evidence_attached` TIMESTAMP COMMENT 'Indicates whether supporting evidence files are attached.',
    `external_auditor_contact` STRING COMMENT 'Contact email for the external auditor.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `external_auditor_name` STRING COMMENT 'Name of the external auditor organization or individual.',
    `finding_count` STRING COMMENT '',
    `is_critical_asset` BOOLEAN COMMENT 'Indicates whether the assessed asset is classified as critical to operations.',
    `is_external_assessment` BOOLEAN COMMENT 'Indicates if the assessment was performed by an external third party.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `last_reviewed_date` DATE COMMENT 'Date when the assessment was last reviewed for updates.',
    `notes` STRING COMMENT '',
    `overall_risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score calculated from assessment (0-100).',
    `recommended_remediation_actions` STRING COMMENT 'Suggested actions to mitigate identified vulnerabilities.',
    `remediation_due_date` DATE COMMENT 'Target date by which recommended remediation actions should be completed.',
    `remediation_status` STRING COMMENT 'Current status of remediation implementation.. Valid values are `not_started|in_progress|completed|deferred`',
    `risk_justification` STRING COMMENT 'Narrative justification for the assigned risk rating.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned based on identified vulnerabilities.. Valid values are `low|medium|high|critical`',
    `risk_score` DECIMAL(18,2) COMMENT '',
    `security_level_gap` STRING COMMENT 'Difference between required and actual security level per IEC 62443.',
    `cybersecurity_assessment_status` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assessment record.',
    `vulnerabilities_identified` STRING COMMENT 'List or description of vulnerabilities discovered during the assessment.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_cybersecurity_assessment PRIMARY KEY(`cybersecurity_assessment_id`)
) COMMENT 'IEC 62443 cybersecurity risk assessment and vulnerability assessment record for Manufacturings industrial control systems and OT networks. Captures assessment date, assessed system or zone, assessment methodology (IEC 62443-3-2 zone and conduit analysis, NIST CSF), identified vulnerabilities, risk rating, security level gap analysis, recommended remediation actions, and assessment outcome. Drives the cybersecurity CAPA and control improvement roadmap.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` (
    `hazardous_substance_id` BIGINT COMMENT 'System-generated unique identifier for the hazardous substance record.',
    `supplier_id` BIGINT COMMENT 'Enterprise identifier for the supplier of the substance.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Hazardous substances are regulated; linking to the applicable requirement removes duplicated regulatory list/status columns.',
    `cas_number` STRING COMMENT 'Unique numeric identifier assigned by the CAS registry for the chemical.',
    `chemical_family` STRING COMMENT 'Broad chemical family or class (e.g., halogenated, aromatic).',
    `comments` STRING COMMENT 'Free‑form notes or remarks about the substance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the hazardous substance record was created.',
    `hazardous_substance_description` STRING COMMENT '',
    `disposal_method` STRING COMMENT 'Approved method for disposing of the substance (e.g., incineration, landfill).',
    `emergency_contact_name` STRING COMMENT 'Name of the person or team to contact in case of an incident.',
    `emergency_contact_phone` STRING COMMENT 'Phone number for emergency response related to the substance.',
    `expiration_date` DATE COMMENT 'Date after which the substance is considered expired or unsuitable for use.',
    `handling_requirements` STRING COMMENT 'Specific handling instructions (e.g., temperature control, ventilation).',
    `hazard_class` STRING COMMENT '',
    `hazard_classification` STRING COMMENT 'Primary GHS hazard class for the substance.. Valid values are `explosive|flammable|oxidizer|corrosive|toxic|environmental`',
    `hazard_statements` STRING COMMENT 'Standardized statements describing the nature of the hazards.',
    `hazardous_substance_status` STRING COMMENT 'Lifecycle status of the record (e.g., active, inactive, retired).. Valid values are `active|inactive|retired|pending`',
    `internal_code` STRING COMMENT 'Enterprise‑specific code used to reference the substance in internal systems.',
    `is_controlled_substance` BOOLEAN COMMENT 'True if the substance is subject to additional controls (e.g., dual‑use, export restrictions).',
    `is_hazardous` BOOLEAN COMMENT 'Indicates whether the substance is classified as hazardous under GHS.',
    `is_reportable` BOOLEAN COMMENT 'True if the substance quantity exceeds reporting thresholds for EPA or OSHA.',
    `last_inventory_date` DATE COMMENT 'Date when the substance quantity was last physically verified.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `molecular_formula` STRING COMMENT 'Standard chemical formula representing the composition of the substance.',
    `molecular_weight` DECIMAL(18,2) COMMENT 'Molecular weight of the substance expressed in grams per mole.',
    `hazardous_substance_name` STRING COMMENT 'Common or trade name of the hazardous chemical.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next regulatory or safety review.',
    `notes` STRING COMMENT '',
    `personal_protective_equipment` STRING COMMENT 'Recommended PPE for safe handling of the substance.',
    `precautionary_statements` STRING COMMENT 'Recommended safety measures and handling instructions.',
    `procurement_date` DATE COMMENT 'Date the substance was purchased or received.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'Current inventory amount of the substance at the facility.',
    `reporting_threshold_exceeded` BOOLEAN COMMENT 'Indicates whether current quantity exceeds the regulatory threshold quantity.',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk rating derived from hazard class, quantity, and exposure potential.',
    `sds_reference` STRING COMMENT '',
    `sds_url` STRING COMMENT 'Link to the electronic Safety Data Sheet for the substance.',
    `signal_word` STRING COMMENT 'GHS signal word indicating the level of hazard (Danger or Warning).. Valid values are `Danger|Warning`',
    `storage_location` STRING COMMENT 'Physical location (e.g., warehouse, cabinet) where the substance is stored.',
    `substance_code` STRING COMMENT '',
    `substance_name` STRING COMMENT '',
    `threshold_quantity` DECIMAL(18,2) COMMENT 'Quantity that triggers regulatory reporting (e.g., TPQ, SARA 313 threshold).',
    `un_number` STRING COMMENT '',
    `unit_of_measure` STRING COMMENT 'Unit used for quantity_on_hand and threshold_quantity (e.g., kg, L).. Valid values are `kg|g|lb|l|ml|mol`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the record.',
    `waste_code` STRING COMMENT 'Regulatory waste code (e.g., D001) associated with the substance.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_hazardous_substance PRIMARY KEY(`hazardous_substance_id`)
) COMMENT 'Hazardous substance and chemical master record tracking all hazardous materials used, stored, or generated at Manufacturing facilities, supporting OSHA HazCom (GHS), EPA EPCRA Tier II, REACH, and RoHS compliance. Captures substance name, CAS number, chemical family, physical/chemical properties, GHS hazard classification, SDS reference, storage quantity, threshold planning quantity (TPQ), and applicable regulatory lists (SARA 313, SVHC). Serves as the chemical inventory for regulatory reporting.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` (
    `waste_record_id` BIGINT COMMENT 'System-generated unique identifier for the waste record.',
    `employee_id` BIGINT COMMENT 'System identifier of the reporting employee.',
    `facility_id` BIGINT COMMENT '',
    `hazardous_substance_id` BIGINT COMMENT '',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Waste generation is recorded per project to manage disposal compliance and reporting.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Waste records are subject to regulatory reporting; FK provides direct link to the governing requirement.',
    `family_id` BIGINT COMMENT 'Identifier of the product line associated with the waste.',
    `stock_location_id` BIGINT COMMENT 'Reference to the facility or area where waste is stored.',
    `supplier_id` BIGINT COMMENT 'System identifier for the disposal contractor.',
    `approved_by` STRING COMMENT 'Name of the employee who approved the waste record for reporting.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the waste record was approved.',
    `chain_of_custody_document` STRING COMMENT 'Reference (URL or file name) to the chain‑of‑custody record.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the waste record.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the waste record was first created in the system.',
    `waste_record_description` STRING COMMENT '',
    `disposal_contractor` STRING COMMENT 'Licensed contractor responsible for waste disposal.',
    `disposal_date` DATE COMMENT 'Date the waste was disposed or transferred to a licensed contractor.',
    `disposal_method` STRING COMMENT 'Method used to dispose of the waste.. Valid values are `incineration|landfill|recycling|treatment|export`',
    `disposal_site` STRING COMMENT 'Name of the off‑site location where waste was disposed.',
    `disposal_site_address` STRING COMMENT 'Street address of the disposal site.',
    `disposal_site_city` STRING COMMENT 'City of the disposal site.',
    `disposal_site_country` STRING COMMENT 'Three‑letter ISO country code of the disposal site.',
    `disposal_site_state` STRING COMMENT 'State or province of the disposal site.',
    `disposal_site_zip` STRING COMMENT 'Postal code of the disposal site.',
    `epa_waste_code` STRING COMMENT 'Four‑character EPA hazardous waste code (RCRA).. Valid values are `^[A-Z]{4}$`',
    `generation_date` DATE COMMENT 'Date the waste was generated on site.',
    `hazard_classification` STRING COMMENT 'Specific hazard class of the waste material.. Valid values are `flammable|corrosive|toxic|reactive|radioactive|other`',
    `is_hazardous` BOOLEAN COMMENT 'True if the waste is classified as hazardous under EPA/ISO standards.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `manifest_number` STRING COMMENT 'EPA manifest number linking the waste to transportation documentation.. Valid values are `^[A-Z0-9]{8,12}$`',
    `notes` STRING COMMENT 'Free‑form comments or observations about the waste event.',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of waste generated, expressed in the selected unit of measure.',
    `related_facility_code` BIGINT COMMENT 'Identifier of the facility where the waste was generated.',
    `reported_by` STRING COMMENT 'Name of the employee who recorded the waste event.',
    `storage_location` STRING COMMENT 'Name or description of the on‑site storage area for the waste.',
    `transport_distance_km` DECIMAL(18,2) COMMENT 'Distance traveled for waste transport, expressed in kilometers.',
    `transport_emission_kg_co2` DECIMAL(18,2) COMMENT 'Estimated CO₂ emissions from waste transport, in kilograms.',
    `transport_mode` STRING COMMENT 'Mode of transportation used to move waste to the disposal site.. Valid values are `truck|rail|ship|air`',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity field.. Valid values are `kg|lb|gal|l`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the waste record.',
    `waste_category` STRING COMMENT 'High‑level category describing the waste material.. Valid values are `chemical|metal|organic|radioactive|other`',
    `waste_identifier` STRING COMMENT 'Business identifier such as a manifest or tracking number assigned to the waste event.',
    `waste_manifest_number` STRING COMMENT '',
    `waste_origin` STRING COMMENT 'Business process that generated the waste.. Valid values are `production|maintenance|R&D|cleanup`',
    `waste_quantity` DECIMAL(18,2) COMMENT '',
    `waste_record_status` STRING COMMENT 'Current lifecycle status of the waste record.. Valid values are `generated|stored|disposed|closed`',
    `waste_type` STRING COMMENT 'Classification of waste by regulatory definition.. Valid values are `hazardous|non_hazardous|universal|special`',
    `waste_uom` STRING COMMENT '',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_waste_record PRIMARY KEY(`waste_record_id`)
) COMMENT 'Hazardous and non-hazardous waste generation, storage, and disposal record supporting EPA RCRA compliance and ISO 14001 waste management objectives. Captures waste generation date, waste type (hazardous, universal, non-hazardous), EPA waste code, quantity generated, storage location, disposal method, licensed disposal contractor, manifest number, disposal date, and chain-of-custody documentation. Primary source for EPA biennial hazardous waste report and waste minimization tracking.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` (
    `periodic_evaluation_id` BIGINT COMMENT 'Primary key for periodic_evaluation',
    `obligation_id` BIGINT COMMENT 'Reference to the specific compliance obligation evaluated.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee or external auditor who performed the assessment.',
    `location_id` BIGINT COMMENT 'Reference to the physical site or facility where the assessment was performed.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department accountable for the assessed obligation.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Periodic compliance evaluations are conducted per project to verify ongoing conformance.',
    `regulatory_requirement_id` BIGINT COMMENT '',
    `assessment_code` STRING COMMENT 'Human‑readable code assigned to the evaluation for tracking and reference.',
    `assessment_date` DATE COMMENT 'Date on which the compliance assessment was performed.',
    `assessment_method` STRING COMMENT 'Technique used to conduct the evaluation.. Valid values are `document_review|interview|observation|testing`',
    `assessment_scope` STRING COMMENT 'Narrative describing the functional or regulatory scope covered by the assessment.',
    `assessor_name` STRING COMMENT 'Full legal name of the person conducting the assessment.',
    `conformance_rating` DECIMAL(18,2) COMMENT 'Numeric rating (0‑100) reflecting the degree of compliance.',
    `conformance_status` STRING COMMENT 'Overall result of the assessment against the regulation.. Valid values are `compliant|partially_compliant|non_compliant`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the evaluation record was first created in the system.',
    `periodic_evaluation_description` STRING COMMENT '',
    `evaluation_code` STRING COMMENT '',
    `evaluation_date` TIMESTAMP COMMENT '',
    `evaluation_type` STRING COMMENT '',
    `evidence_documentation` STRING COMMENT 'Link or reference to the primary evidence supporting the assessment.',
    `frequency_months` STRING COMMENT '',
    `gaps_identified` STRING COMMENT 'Summary of compliance gaps discovered during the evaluation.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `next_assessment_due` DATE COMMENT 'Planned date for the subsequent periodic evaluation.',
    `next_evaluation_date` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT 'Free‑form comments or observations captured by the assessor.',
    `periodic_evaluation_status` STRING COMMENT 'Current processing state of the evaluation record.. Valid values are `draft|in_progress|completed|approved|rejected`',
    `recommended_actions` STRING COMMENT 'Suggested remediation steps to address identified gaps.',
    `regulation_code` STRING COMMENT 'Standardized code of the regulation or legal requirement (e.g., ISO14001‑9.1.2).',
    `regulation_name` STRING COMMENT 'Full name of the regulation or standard being assessed.',
    `result_rating` STRING COMMENT '',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score derived from severity and likelihood.',
    `risk_severity` STRING COMMENT 'Severity level of the risk associated with the identified gaps.. Valid values are `low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the evaluation record.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_periodic_evaluation PRIMARY KEY(`periodic_evaluation_id`)
) COMMENT 'Periodic compliance evaluation record assessing Manufacturings conformance with specific legal register entries or regulatory requirements. Captures assessment date, assessor, assessed obligation or regulation, assessment method (document review, interview, observation, testing), conformance status (compliant, partially compliant, non-compliant), evidence reviewed, gaps identified, and recommended actions. Supports ISO 14001 Clause 9.1.2 and ISO 45001 Clause 9.1.2 compliance evaluation requirements.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` (
    `controlled_document_id` BIGINT COMMENT 'Primary key for controlled_document',
    `employee_id` BIGINT COMMENT 'Identifier of the individual who approved the document.',
    `regulatory_requirement_id` BIGINT COMMENT '',
    `controlled_related_regulation_regulatory_requirement_id` BIGINT COMMENT 'Reference to the regulatory requirement linked to this document.',
    `device_registry_id` BIGINT COMMENT 'Foreign key linking to automation.device_registry. Business justification: Controlled documents (SOPs, manuals) often reference a specific automation device; linking supports document control.',
    `primary_controlled_employee_id` BIGINT COMMENT 'Identifier of the internal party responsible for the document.',
    `project_header_id` BIGINT COMMENT 'Foreign key linking to project.project_header. Business justification: Controlled documents (SOPs, procedures) are associated with specific projects for compliance control.',
    `applicable_standard` STRING COMMENT 'Regulatory or industry standard to which the document applies. [ENUM-REF-CANDIDATE: ISO 9001|ISO 14001|ISO 45001|IEC 62443|OSHA|EPA|UL|CE — 8 candidates stripped; promote to reference product]',
    `approval_date` DATE COMMENT 'Date when the document was approved.',
    `approval_status` STRING COMMENT 'Current approval status of the document.. Valid values are `pending|approved|rejected`',
    `archive_location` STRING COMMENT 'Physical or digital location where the archived document is stored.',
    `change_reason` STRING COMMENT 'Reason for the most recent change or revision.',
    `checksum` STRING COMMENT 'Checksum (e.g., SHA-256) for file integrity verification.',
    `compliance_status` STRING COMMENT 'Current compliance status of the document with respect to its applicable standard.. Valid values are `compliant|non_compliant|partial|not_applicable`',
    `confidentiality_level` STRING COMMENT 'Data classification level of the document.. Valid values are `public|internal|confidential|restricted`',
    `controlled_document_status` STRING COMMENT 'Current lifecycle status of the document.. Valid values are `draft|review|approved|obsolete|retracted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the document record was created.',
    `controlled_document_description` STRING COMMENT '',
    `distribution_scope` STRING COMMENT 'Scope of distribution for the document.. Valid values are `global|regional|site|department|external`',
    `document_language` STRING COMMENT 'Language in which the document is written.. Valid values are `en|es|de|fr|zh|ja`',
    `document_number` STRING COMMENT 'Unique identifier assigned to the document within the organization.',
    `document_status` STRING COMMENT '',
    `document_title` STRING COMMENT '',
    `document_type` STRING COMMENT 'Category of the controlled document. [ENUM-REF-CANDIDATE: procedure|work_instruction|policy|plan|form|specification|record — 7 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'Date when the document becomes effective for use.',
    `expiration_date` DATE COMMENT 'Date after which the document is no longer valid.',
    `file_path` STRING COMMENT 'Path to the electronic file of the document.',
    `file_size_bytes` BIGINT COMMENT 'Size of the document file in bytes.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the document is currently active.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent review of the document.',
    `notes` STRING COMMENT '',
    `retention_end_date` DATE COMMENT 'Date when the documents retention period expires.',
    `retention_period_days` STRING COMMENT 'Number of days the document must be retained per policy.',
    `review_date` TIMESTAMP COMMENT '',
    `review_due_date` DATE COMMENT 'Date by which the document must be reviewed for continued relevance.',
    `revision_date` DATE COMMENT 'Date when the current revision was released.',
    `revision_level` STRING COMMENT '',
    `revision_number` STRING COMMENT 'Alphanumeric identifier of the document revision.',
    `title` STRING COMMENT 'Descriptive title of the controlled document.',
    `updated_by` BIGINT COMMENT 'Identifier of the user who performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the document record.',
    `version` STRING COMMENT 'Version label combining revision number and date.',
    `created_by` BIGINT COMMENT 'Identifier of the user who created the record.',
    CONSTRAINT pk_controlled_document PRIMARY KEY(`controlled_document_id`)
) COMMENT 'Controlled compliance document master record managing the document control lifecycle for all compliance-critical documents including ISO management system procedures, work instructions, environmental plans, safety programs, regulatory submissions, and certification records. Captures document title, document number, revision level, document type, applicable standard or regulation, owner, approval status, effective date, review due date, and distribution scope. Supports ISO document control requirements (ISO 9001 Clause 7.5).';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` (
    `process_hazard_id` BIGINT COMMENT 'Primary key for process_hazard',
    `facility_id` BIGINT COMMENT '',
    `parent_process_hazard_id` BIGINT COMMENT 'Self-referencing FK on process_hazard (parent_process_hazard_id)',
    `associated_processes` STRING COMMENT 'Comma‑separated list of business processes impacted by the hazard.',
    `compliance_status` STRING COMMENT 'Current compliance status of the hazard with relevant regulations.',
    `control_measures` STRING COMMENT 'Mitigation actions or engineering controls applied to reduce the hazard.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the hazard record was first created in the system.',
    `process_hazard_description` STRING COMMENT 'Detailed narrative describing the nature, cause, and potential impact of the hazard.',
    `effective_date` DATE COMMENT 'Date when the hazard record became effective.',
    `emergency_response_procedure` STRING COMMENT 'Reference to the emergency response procedure for the hazard.',
    `expiry_date` DATE COMMENT 'Date when the hazard record expires or is superseded, if applicable.',
    `exposure_limit_unit` STRING COMMENT 'Unit of measure for the exposure limit.',
    `exposure_limit_value` DECIMAL(18,2) COMMENT 'Maximum allowable exposure level for the hazard.',
    `hazard_category` STRING COMMENT 'High‑level classification of the hazard type.',
    `hazard_code` STRING COMMENT 'Unique alphanumeric code assigned to the hazard for quick reference.',
    `hazard_description` STRING COMMENT '',
    `hazard_name` STRING COMMENT 'Descriptive name of the hazard as used in safety documentation.',
    `hazard_owner` STRING COMMENT 'Department or individual responsible for managing the hazard.',
    `hazard_subcategory` STRING COMMENT 'More specific classification within the main hazard category.',
    `hazard_type` STRING COMMENT '',
    `incident_history_flag` BOOLEAN COMMENT 'True if historical incidents have been recorded for this hazard.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the hazard is currently active and applicable.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of the hazard.',
    `likelihood_level` STRING COMMENT 'Estimated probability of occurrence for the hazard.',
    `likelihood_rating` STRING COMMENT '',
    `mitigation_measures` STRING COMMENT '',
    `mitigation_plan` STRING COMMENT 'Detailed plan outlining steps to mitigate or eliminate the hazard.',
    `monitoring_method` STRING COMMENT 'Method used to monitor the hazard.',
    `monitoring_required` BOOLEAN COMMENT 'Indicates whether continuous monitoring is required for this hazard.',
    `notes` STRING COMMENT 'Free‑form field for any additional information or comments.',
    `regulatory_standard` STRING COMMENT 'Applicable regulatory or industry standards governing the hazard (e.g., ISO 14001, OSHA, EPA, IEC 62443).',
    `review_frequency_months` STRING COMMENT 'Planned interval in months between hazard reviews.',
    `risk_priority_number` STRING COMMENT '',
    `risk_rating` STRING COMMENT 'Combined risk rating derived from severity and likelihood.',
    `severity_level` STRING COMMENT 'Potential impact severity if the hazard materializes.',
    `severity_rating` STRING COMMENT '',
    `process_hazard_status` STRING COMMENT '',
    `training_program` STRING COMMENT 'Name or identifier of the training program associated with the hazard.',
    `training_required` BOOLEAN COMMENT 'Indicates if specific training is required for personnel handling the hazard.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the hazard record.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_process_hazard PRIMARY KEY(`process_hazard_id`)
) COMMENT 'Master reference table for process_hazard. Referenced by process_hazard_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` (
    `emission_source_id` BIGINT COMMENT 'Primary key for emission_source',
    `facility_id` BIGINT COMMENT 'Identifier of the facility or plant where the emission source is located.',
    `parent_emission_source_id` BIGINT COMMENT 'Self-referencing FK on emission_source (parent_emission_source_id)',
    `active_flag` BOOLEAN COMMENT 'Indicates whether the source is currently active (true) or not (false).',
    `emission_source_category` STRING COMMENT 'Broad environmental category of the emissions produced.',
    `compliance_certification_code` STRING COMMENT 'Code of any certification or permit associated with the source (e.g., EPA permit number).',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the emission source.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `decommission_date` DATE COMMENT 'Date on which the emission source was permanently shut down.',
    `emission_source_description` STRING COMMENT 'Detailed free‑text description of the source, its function, and any relevant notes.',
    `emission_factor` DECIMAL(18,2) COMMENT 'Quantitative factor representing emissions per unit of activity (e.g., kg CO₂e per MWh).',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `last_reported_timestamp` TIMESTAMP COMMENT 'Date‑time when the most recent emission report for this source was submitted.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the emission source (decimal degrees).',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the emission source (decimal degrees).',
    `emission_source_name` STRING COMMENT 'Human‑readable name of the emission source (e.g., Boiler A, Paint Shop).',
    `next_report_due_date` DATE COMMENT 'Calendar date by which the next emission report must be filed.',
    `notes` STRING COMMENT '',
    `permitted_flag` BOOLEAN COMMENT '',
    `plant_location` STRING COMMENT 'Physical address or site name of the plant housing the source.',
    `pollutant_types` STRING COMMENT '',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the emission source record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the emission source record.',
    `regulatory_agency` STRING COMMENT 'Primary agency overseeing the sources emissions.',
    `reporting_frequency` STRING COMMENT 'How often emissions from this source are reported.',
    `source_code` STRING COMMENT 'Business‑assigned code used to reference the emission source in reports and regulatory filings.',
    `source_name` STRING COMMENT '',
    `source_operating_company` STRING COMMENT 'External or internal company that operates the emission source.',
    `source_owner` STRING COMMENT 'Business unit or department responsible for the emission source.',
    `source_type` STRING COMMENT '',
    `stack_height_meters` DECIMAL(18,2) COMMENT '',
    `emission_source_status` STRING COMMENT 'Current operational status of the emission source.',
    `emission_source_type` STRING COMMENT 'Classification of the source based on its physical or operational characteristics.',
    `unit_of_measure` STRING COMMENT 'Unit used for the emission factor (e.g., kilograms CO₂e).',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_emission_source PRIMARY KEY(`emission_source_id`)
) COMMENT 'Master reference table for emission_source. Referenced by source_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`compliance`.`facility` (
    `facility_id` BIGINT COMMENT 'Primary key for facility',
    `parent_facility_id` BIGINT COMMENT 'Identifier of the parent facility in a hierarchical location structure, if applicable.',
    `address_line` STRING COMMENT '',
    `address_line1` STRING COMMENT 'Primary street address of the facility.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `audit_status` STRING COMMENT 'Current status of internal or external audits.',
    `backup_generator_present` BOOLEAN COMMENT 'Indicates whether a backup generator is installed on site.',
    `capacity_units` STRING COMMENT 'Units used to express the facilitys production or storage capacity (e.g., units per day, pallets).',
    `city` STRING COMMENT 'City where the facility is located.',
    `facility_code` STRING COMMENT 'External or legacy code used to identify the facility in enterprise systems.',
    `compliance_iec_62443_certified` BOOLEAN COMMENT 'Indicates whether the facility meets IEC 62443 cybersecurity standards for industrial automation.',
    `compliance_iso_14001_certified` BOOLEAN COMMENT 'Indicates whether the facility is certified to ISO 14001 environmental management standards.',
    `compliance_iso_45001_certified` BOOLEAN COMMENT 'Indicates whether the facility is certified to ISO 45001 occupational health and safety standards.',
    `country` STRING COMMENT '',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the facility resides. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|DEU|FRA|CHN|JPN|IND|BRA — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the facility record was first created in the system.',
    `facility_description` STRING COMMENT '',
    `emergency_contact_phone` STRING COMMENT 'Phone number to use for emergency communications.',
    `emissions_co2_tons` DECIMAL(18,2) COMMENT 'Annual carbon dioxide emissions from the facility in metric tons.',
    `energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Total electricity consumption of the facility measured in megawatt‑hours for the reporting period.',
    `epa_permit_expiry` DATE COMMENT 'Expiration date of the EPA permit.',
    `epa_permit_number` STRING COMMENT 'Environmental Protection Agency permit identifier for emissions or waste handling.',
    `facility_type` STRING COMMENT 'Category of the facility indicating its primary function.',
    `fire_suppression_type` STRING COMMENT 'Type of fire suppression system installed (e.g., sprinkler, FM‑200).',
    `hazardous_material_storage` BOOLEAN COMMENT 'Indicates whether the facility stores hazardous materials.',
    `hvac_type` STRING COMMENT 'Heating, ventilation, and air‑conditioning system type used.',
    `inspection_status` STRING COMMENT 'Result of the most recent inspection.',
    `insurance_expiry_date` DATE COMMENT 'Date when the current insurance policy expires.',
    `insurance_policy_number` STRING COMMENT 'Reference number of the facilitys insurance coverage.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or safety inspection.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the facility (decimal degrees).',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the facility (decimal degrees).',
    `facility_name` STRING COMMENT 'Human‑readable name of the facility.',
    `next_inspection_due` DATE COMMENT 'Scheduled date for the next required inspection.',
    `notes` STRING COMMENT '',
    `operational_status` DECIMAL(18,2) COMMENT '',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the facility address.',
    `power_source` STRING COMMENT 'Primary source of electrical power (e.g., grid, solar, generator).',
    `primary_contact_email` STRING COMMENT 'Email address for the primary facility contact.',
    `primary_contact_name` STRING COMMENT 'Name of the main facility contact person.',
    `primary_contact_phone` STRING COMMENT 'Phone number for the primary facility contact.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the facility.',
    `security_level` STRING COMMENT 'Security classification of the facility based on risk assessment.',
    `size_sqft` DECIMAL(18,2) COMMENT 'Total usable floor area of the facility in square feet.',
    `state_province` STRING COMMENT 'State or province of the facility location.',
    `facility_status` STRING COMMENT 'Current operational status of the facility.',
    `tax_id_number` STRING COMMENT 'Government‑issued tax identifier for the facility.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the facility record.',
    `waste_generated_tons` DECIMAL(18,2) COMMENT 'Total waste generated on site measured in metric tons.',
    `water_usage_m3` DECIMAL(18,2) COMMENT 'Volume of water consumed by the facility in cubic metres.',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_facility PRIMARY KEY(`facility_id`)
) COMMENT 'Master reference table for facility. Referenced by related_facility_id.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` (
    `safety_checklist_id` BIGINT COMMENT 'Primary key for safety_checklist',
    `parent_safety_checklist_id` BIGINT COMMENT 'Self-referencing FK on safety_checklist (parent_safety_checklist_id)',
    `safety_inspection_id` BIGINT COMMENT '',
    `applicable_regulation` STRING COMMENT 'Regulatory framework(s) to which the checklist complies.',
    `approval_status` STRING COMMENT 'Current approval state of the checklist.',
    `approved_by` STRING COMMENT 'Identifier of the user who approved the checklist.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the checklist was approved.',
    `attachment_flag` BOOLEAN COMMENT 'True if supporting attachments (e.g., diagrams) are associated.',
    `audit_trail` STRING COMMENT 'Free‑text log of significant audit events for the checklist.',
    `safety_checklist_category` STRING COMMENT 'Higher‑level grouping of the checklist for reporting.',
    `checklist_code` STRING COMMENT '',
    `checklist_items_count` STRING COMMENT 'Total count of individual items/questions in the checklist.',
    `checklist_name` STRING COMMENT '',
    `checklist_type` STRING COMMENT 'Category that defines the nature of the checklist.',
    `safety_checklist_code` STRING COMMENT 'Business code used to reference the checklist in external systems.',
    `confidentiality_level` STRING COMMENT 'Data classification level for the checklist record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the checklist record was first created.',
    `safety_checklist_description` STRING COMMENT 'Detailed description of the checklist purpose and scope.',
    `document_url` STRING COMMENT 'Link to the electronic version of the checklist document.',
    `effective_date` DATE COMMENT 'Date when the checklist becomes applicable.',
    `expiration_date` DATE COMMENT 'Date when the checklist is no longer valid (nullable).',
    `failed_items` STRING COMMENT '',
    `is_mandatory` BOOLEAN COMMENT 'True if the checklist must be completed for compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `last_review_date` DATE COMMENT 'Date when the checklist was last reviewed.',
    `safety_checklist_name` STRING COMMENT 'Human‑readable name of the checklist.',
    `next_review_date` DATE COMMENT 'Planned date for the next review.',
    `notes` STRING COMMENT '',
    `passed_items` STRING COMMENT '',
    `required_training` BOOLEAN COMMENT 'Indicates whether specific training is required to complete the checklist.',
    `review_frequency_days` STRING COMMENT 'Number of days between mandatory reviews of the checklist.',
    `risk_level` STRING COMMENT 'Assessed risk level associated with the checklist items.',
    `safety_checklist_status` STRING COMMENT 'Current lifecycle status of the checklist.',
    `total_items` DECIMAL(18,2) COMMENT '',
    `updated_by` STRING COMMENT 'Identifier of the user who last updated the checklist record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the checklist record.',
    `version_number` STRING COMMENT 'Version identifier of the checklist (e.g., 1.0, 2.1).',
    `created_by` STRING COMMENT 'Identifier of the user who created the checklist record.',
    CONSTRAINT pk_safety_checklist PRIMARY KEY(`safety_checklist_id`)
) COMMENT 'Master reference table for safety_checklist. Referenced by checklist_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`facility`(`facility_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ADD CONSTRAINT `fk_compliance_audit_plan_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ADD CONSTRAINT `fk_compliance_audit_event_audit_plan_id` FOREIGN KEY (`audit_plan_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`audit_plan`(`audit_plan_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ADD CONSTRAINT `fk_compliance_audit_event_compliance_audit_finding_id` FOREIGN KEY (`compliance_audit_finding_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding`(`compliance_audit_finding_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ADD CONSTRAINT `fk_compliance_compliance_audit_finding_controlled_document_id` FOREIGN KEY (`controlled_document_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`controlled_document`(`controlled_document_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ADD CONSTRAINT `fk_compliance_compliance_audit_finding_prior_finding_id` FOREIGN KEY (`prior_finding_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding`(`compliance_audit_finding_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ADD CONSTRAINT `fk_compliance_compliance_audit_finding_audit_event_id` FOREIGN KEY (`audit_event_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`audit_event`(`audit_event_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ADD CONSTRAINT `fk_compliance_compliance_capa_record_compliance_audit_finding_id` FOREIGN KEY (`compliance_audit_finding_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding`(`compliance_audit_finding_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ADD CONSTRAINT `fk_compliance_compliance_capa_record_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ADD CONSTRAINT `fk_compliance_safety_incident_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`facility`(`facility_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ADD CONSTRAINT `fk_compliance_safety_incident_previous_incident_safety_incident_id` FOREIGN KEY (`previous_incident_safety_incident_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`safety_incident`(`safety_incident_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ADD CONSTRAINT `fk_compliance_safety_inspection_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`facility`(`facility_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ADD CONSTRAINT `fk_compliance_safety_inspection_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ADD CONSTRAINT `fk_compliance_safety_inspection_safety_checklist_id` FOREIGN KEY (`safety_checklist_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`safety_checklist`(`safety_checklist_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ADD CONSTRAINT `fk_compliance_environmental_aspect_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`facility`(`facility_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ADD CONSTRAINT `fk_compliance_environmental_aspect_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ADD CONSTRAINT `fk_compliance_emissions_record_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`emission_source`(`emission_source_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ADD CONSTRAINT `fk_compliance_emissions_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`facility`(`facility_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ADD CONSTRAINT `fk_compliance_emissions_record_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ADD CONSTRAINT `fk_compliance_emissions_record_source_emission_source_id` FOREIGN KEY (`source_emission_source_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`emission_source`(`emission_source_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ADD CONSTRAINT `fk_compliance_compliance_product_certification_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`facility`(`facility_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ADD CONSTRAINT `fk_compliance_cybersecurity_control_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ADD CONSTRAINT `fk_compliance_cybersecurity_assessment_cybersecurity_control_id` FOREIGN KEY (`cybersecurity_control_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control`(`cybersecurity_control_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ADD CONSTRAINT `fk_compliance_cybersecurity_assessment_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ADD CONSTRAINT `fk_compliance_hazardous_substance_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ADD CONSTRAINT `fk_compliance_waste_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`facility`(`facility_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ADD CONSTRAINT `fk_compliance_waste_record_hazardous_substance_id` FOREIGN KEY (`hazardous_substance_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`hazardous_substance`(`hazardous_substance_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ADD CONSTRAINT `fk_compliance_waste_record_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ADD CONSTRAINT `fk_compliance_periodic_evaluation_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ADD CONSTRAINT `fk_compliance_periodic_evaluation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ADD CONSTRAINT `fk_compliance_controlled_document_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ADD CONSTRAINT `fk_compliance_controlled_document_controlled_related_regulation_regulatory_requirement_id` FOREIGN KEY (`controlled_related_regulation_regulatory_requirement_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ADD CONSTRAINT `fk_compliance_process_hazard_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`facility`(`facility_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ADD CONSTRAINT `fk_compliance_process_hazard_parent_process_hazard_id` FOREIGN KEY (`parent_process_hazard_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`process_hazard`(`process_hazard_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ADD CONSTRAINT `fk_compliance_emission_source_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`facility`(`facility_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ADD CONSTRAINT `fk_compliance_emission_source_parent_emission_source_id` FOREIGN KEY (`parent_emission_source_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`emission_source`(`emission_source_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ADD CONSTRAINT `fk_compliance_facility_parent_facility_id` FOREIGN KEY (`parent_facility_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`facility`(`facility_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ADD CONSTRAINT `fk_compliance_safety_checklist_parent_safety_checklist_id` FOREIGN KEY (`parent_safety_checklist_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`safety_checklist`(`safety_checklist_id`);
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ADD CONSTRAINT `fk_compliance_safety_checklist_safety_inspection_id` FOREIGN KEY (`safety_inspection_id`) REFERENCES `vibe_manufacturing_v1`.`compliance`.`safety_inspection`(`safety_inspection_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_manufacturing_v1`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement ID');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `adoption_status` SET TAGS ('dbx_business_glossary_term' = 'Adoption Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `adoption_status` SET TAGS ('dbx_value_regex' = 'adopted|planned|not_adopted|under_review');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `applicability_scope` SET TAGS ('dbx_business_glossary_term' = 'Applicability Scope');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency (Months)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `authority_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Code');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `authority_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Name');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `authority_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `authority_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_category` SET TAGS ('dbx_value_regex' = 'environmental|occupational|product|cybersecurity|financial|quality');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_level` SET TAGS ('dbx_business_glossary_term' = 'Compliance Level');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_level` SET TAGS ('dbx_value_regex' = 'mandatory|optional|recommended');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial|unknown');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `document_last_updated` SET TAGS ('dbx_business_glossary_term' = 'Document Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `document_release_date` SET TAGS ('dbx_business_glossary_term' = 'Document Release Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (Country/Region)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_requirement_description` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Description');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_requirement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `reporting_requirements` SET TAGS ('dbx_business_glossary_term' = 'Reporting Requirements');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Code');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Name');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Type (TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_value_regex' = 'law|standard|regulation|directive|policy|guideline');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Months)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `source_url` SET TAGS ('dbx_business_glossary_term' = 'Source URL');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_requirement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department Identifier (RDI)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Control Owner Identifier (COI)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Identifier (RRI)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Related Facility Identifier (RFI)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Related Product Line Identifier (RPLI)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `audit_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Count (AFC)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status (AS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|reopened');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Code (OC)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category (CC)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `compliance_category` SET TAGS ('dbx_value_regex' = 'environment|safety|quality|cybersecurity|financial|operational');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (CS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|partially_compliant|non_compliant|not_assessed|deferred');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date (CADD)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Obligation Due Date (ODD)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFD)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EUD)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `evidence_document_url` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document URL (EDU)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `evidence_type` SET TAGS ('dbx_business_glossary_term' = 'Evidence Type (ET)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `evidence_type` SET TAGS ('dbx_value_regex' = 'document|test_result|certification|photo|video');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number (ERN)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Flag (IMF)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (JUR)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Date (LAD)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `next_assessment_due` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date (NADD)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Obligation Notes (ON)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Status (OS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed|expired');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type (OT)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'environmental|safety|cybersecurity|quality|financial');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `owner_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `owner_name` SET TAGS ('dbx_mask' = 'nonprod');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `recurrence_schedule` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Schedule (RS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `recurrence_schedule` SET TAGS ('dbx_value_regex' = 'annual|semi-annual|quarterly|monthly|one-time|ad-hoc');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action (RA)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating (RR)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `risk_severity` SET TAGS ('dbx_business_glossary_term' = 'Risk Severity (RSV)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `risk_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`obligation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `audit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Plan ID');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `applicable_standards` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standards (AS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency (AF)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|ad_hoc');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `audit_methodology` SET TAGS ('dbx_business_glossary_term' = 'Audit Methodology (AM)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `audit_objectives` SET TAGS ('dbx_business_glossary_term' = 'Audit Objectives (AO)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `audit_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Plan Status (APS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `audit_plan_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|postponed|deferred');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score (ASCR)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `audit_team` SET TAGS ('dbx_business_glossary_term' = 'Audit Team Members (ATM)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type (AT)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal|external|supplier|regulatory|certification');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score (CSCR)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date (CADD)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (ESD)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EED)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `findings_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Findings (NF)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (RUT)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (AN)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Audit Plan Code (APC)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (RL)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date (SED)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date (SSD)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description (SD)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_plan` ALTER COLUMN `target_facilities` SET TAGS ('dbx_business_glossary_term' = 'Target Facilities (TF)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_event_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Event Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Plan Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `compliance_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'on_site|remote|document_review|observation|testing|checklist');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type (Audit Classification)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_event_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Event Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `audit_event_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Full Name');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `auditor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `auditor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `auditor_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `auditor_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `auditor_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Audit Department');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `documentation_link` SET TAGS ('dbx_business_glossary_term' = 'Documentation Link');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Event Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `evidence_attached` SET TAGS ('dbx_business_glossary_term' = 'Evidence Attached Flag');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `follow_up_action` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Action');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `hazards_identified` SET TAGS ('dbx_business_glossary_term' = 'Hazards Identified');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Audit Location');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Audit Outcome');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'conforming|nonconformance|observation|pass|fail');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `severity_rating` SET TAGS ('dbx_business_glossary_term' = 'Severity Rating');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `severity_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `summary` SET TAGS ('dbx_business_glossary_term' = 'Audit Summary Narrative');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`audit_event` ALTER COLUMN `vulnerabilities_identified` SET TAGS ('dbx_business_glossary_term' = 'Vulnerabilities Identified');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `compliance_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Finding ID');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `control_system_id` SET TAGS ('dbx_business_glossary_term' = 'Control System Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document ID');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `prior_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Finding ID');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `audit_event_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Event ID');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `actual_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `affected_process` SET TAGS ('dbx_business_glossary_term' = 'Affected Process');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `affected_process` SET TAGS ('dbx_value_regex' = 'design|production|procurement|quality|maintenance|customer_service');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `audit_finding_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Number');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `audit_finding_number` SET TAGS ('dbx_value_regex' = '^AF-d{6}$');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `clause_violated` SET TAGS ('dbx_business_glossary_term' = 'Violated Clause');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `compliance_audit_finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `compliance_audit_finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `compliance_audit_finding_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|deferred|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'major_nonconformance|minor_nonconformance|observation|opportunity_for_improvement');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `impact_area` SET TAGS ('dbx_business_glossary_term' = 'Impact Area');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `impact_area` SET TAGS ('dbx_value_regex' = 'safety|environment|quality|cost|schedule|regulatory');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `is_repeat_finding` SET TAGS ('dbx_business_glossary_term' = 'Repeat Finding Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_audit_finding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `compliance_capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'CAPA Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `compliance_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Related Audit Finding ID');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `customer_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Related Customer Complaint ID');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner Employee ID');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Related Non-Conformance Report ID');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Related Regulatory Citation ID');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `abatement_deadline` SET TAGS ('dbx_business_glossary_term' = 'Abatement Deadline Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `capa_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Number');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `citation_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation Reference');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'CAPA Closure Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `closure_status` SET TAGS ('dbx_business_glossary_term' = 'CAPA Closure Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `closure_status` SET TAGS ('dbx_value_regex' = 'completed|cancelled|deferred');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `compliance_capa_record_status` SET TAGS ('dbx_business_glossary_term' = 'CAPA Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `compliance_capa_record_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Applicable Compliance Framework');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_value_regex' = 'iso_9001|iso_14001|iso_45001|osha|epa|iec_62443');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `department_responsible` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `department_responsible` SET TAGS ('dbx_value_regex' = 'quality|production|engineering|safety|procurement|other');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Documentation Reference (e.g., Document ID or URL)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `effectiveness_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Outcome');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `effectiveness_review_outcome` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective|not_verified');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `effectiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Score (Numeric Rating)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'CAPA Initiation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `is_external_citation` SET TAGS ('dbx_business_glossary_term' = 'Is External Citation Flag');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Issuing Agency');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency (ISO 4217 Code)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `preventive_action_description` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Description');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'CAPA Priority');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|annually');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'CAPA Risk Level');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `root_cause_method` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Method');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `root_cause_method` SET TAGS ('dbx_value_regex' = '5-why|fishbone|8d|fmea|other');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'CAPA Severity');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'minor|major|critical');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_capa_record` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'inspection|test|audit|review|other');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` SET TAGS ('dbx_subdomain' = 'safety_health');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID (EMPLOYEE_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID (EQUIPMENT_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `previous_incident_safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Incident ID (PREVIOUS_INCIDENT_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `area_code` SET TAGS ('dbx_business_glossary_term' = 'Area Code (AREA_CODE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `body_part_affected` SET TAGS ('dbx_business_glossary_term' = 'Body Part Affected (BODY_PART_AFFECTED)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `body_part_affected` SET TAGS ('dbx_value_regex' = 'head|neck|torso|upper_extremity|lower_extremity|multiple');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date (CORRECTIVE_ACTION_DUE_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status (CORRECTIVE_ACTION_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `days_away_from_work` SET TAGS ('dbx_business_glossary_term' = 'Days Away From Work (DAYS_AWAY_FROM_WORK)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `equipment_name` SET TAGS ('dbx_business_glossary_term' = 'Equipment Name (EQUIPMENT_NAME)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `equipment_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `equipment_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `immediate_corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Immediate Corrective Action (IMMEDIATE_CORRECTIVE_ACTION)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description (INCIDENT_DESCRIPTION)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `incident_location` SET TAGS ('dbx_business_glossary_term' = 'Incident Location (INCIDENT_LOCATION)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number (INCIDENT_NUMBER)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `incident_report_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Report Number (INCIDENT_REPORT_NUMBER)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status (INCIDENT_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'open|investigating|closed|reopened');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `incident_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Timestamp (INCIDENT_TIMESTAMP)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type (INCIDENT_TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'recordable|lost_time|near_miss|property_damage|first_aid');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `injury_type` SET TAGS ('dbx_business_glossary_term' = 'Injury Type (INJURY_TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `injury_type` SET TAGS ('dbx_value_regex' = 'fracture|burn|laceration|sprain|concussion|other');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `investigation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completed Date (INVESTIGATION_COMPLETED_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status (INVESTIGATION_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `is_repeat_incident` SET TAGS ('dbx_business_glossary_term' = 'Repeat Incident Flag (IS_REPEAT_INCIDENT)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `lost_time_flag` SET TAGS ('dbx_business_glossary_term' = 'Lost Time Flag (LOST_TIME_FLAG)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `medical_treatment_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Treatment Required Flag (MEDICAL_TREATMENT_REQUIRED)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `medical_treatment_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `medical_treatment_required` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `osha_300_log_classification` SET TAGS ('dbx_business_glossary_term' = 'OSHA 300 Log Classification (OSHA_300_LOG_CLASSIFICATION)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `osha_300_log_classification` SET TAGS ('dbx_value_regex' = 'recordable|non_recordable');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code (PLANT_CODE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `regulatory_report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submission Date (REGULATORY_REPORT_SUBMISSION_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `regulatory_report_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submitted Flag (REGULATORY_REPORT_SUBMITTED_FLAG)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `reportable_to_iso_flag` SET TAGS ('dbx_business_glossary_term' = 'Reportable to ISO Flag (REPORTABLE_TO_ISO_FLAG)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `reportable_to_osha_flag` SET TAGS ('dbx_business_glossary_term' = 'Reportable to OSHA Flag (REPORTABLE_TO_OSHA_FLAG)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By (REPORTED_BY)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `reported_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `reported_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `reported_by_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `reported_by_name` SET TAGS ('dbx_mask' = 'nonprod');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp (REPORTED_TIMESTAMP)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating (RISK_RATING)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause (ROOT_CAUSE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level (SEVERITY_LEVEL)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'minor|moderate|severe|critical');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Shift (SHIFT)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|swing|night');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `witness_count` SET TAGS ('dbx_business_glossary_term' = 'Witness Count (WITNESS_COUNT)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `witness_names` SET TAGS ('dbx_business_glossary_term' = 'Witness Names (WITNESS_NAMES)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `witness_names` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `witness_names` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_incident` ALTER COLUMN `witness_names` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` SET TAGS ('dbx_subdomain' = 'safety_health');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `safety_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Inspection Identifier (SI_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Identifier (INS_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `safety_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Checklist Identifier (CL_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `area` SET TAGS ('dbx_business_glossary_term' = 'Inspection Area (IA)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `average_score` SET TAGS ('dbx_business_glossary_term' = 'Average Checklist Score (ACS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (CS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditional');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `corrective_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline (CAD)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required (CAR)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `corrective_action_summary` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Summary (CAS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `documents_attached` SET TAGS ('dbx_business_glossary_term' = 'Documents Attached Flag (DAF)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `emergency_exit_accessible` SET TAGS ('dbx_business_glossary_term' = 'Emergency Exit Accessible (EEA)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `fire_extinguisher_checked` SET TAGS ('dbx_business_glossary_term' = 'Fire Extinguisher Checked (FEC)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Date (FUD)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `hazards_identified` SET TAGS ('dbx_business_glossary_term' = 'Hazards Identified (HI)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `inspection_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Duration (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number (IN)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event Timestamp (IET)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type (IT)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'routine|pre_startup|loto_verification|fire_safety|ergonomic|environmental');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_mask' = 'nonprod');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `is_loto_verified` SET TAGS ('dbx_business_glossary_term' = 'LOTO Verification Flag (LVF)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `items_failed` SET TAGS ('dbx_business_glossary_term' = 'Items Failed (IF)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `items_passed` SET TAGS ('dbx_business_glossary_term' = 'Items Passed (IP)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes (IN)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `ppe_compliance` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment Compliance (PPE_C)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By (RB)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Timestamp (RT)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating (RR)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `safety_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lifecycle Status (ILS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `safety_inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|closed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `safety_score` SET TAGS ('dbx_business_glossary_term' = 'Safety Score (SS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `total_items_checked` SET TAGS ('dbx_business_glossary_term' = 'Total Items Checked (TIC)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `training_due_date` SET TAGS ('dbx_business_glossary_term' = 'Training Due Date (TDD)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_inspection` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag (TRF)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` SET TAGS ('dbx_subdomain' = 'environmental_stewardship');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `environmental_aspect_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Aspect Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Value (ACTUAL)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `aspect_category` SET TAGS ('dbx_business_glossary_term' = 'Environmental Aspect Category (CATEGORY)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `aspect_category` SET TAGS ('dbx_value_regex' = 'air_emission|water_effluent|waste|energy_use|noise|soil_contamination');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `aspect_code` SET TAGS ('dbx_business_glossary_term' = 'Environmental Aspect Code');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `aspect_name` SET TAGS ('dbx_business_glossary_term' = 'Environmental Aspect Name');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `aspect_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `aspect_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value (BASE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `control_measure_description` SET TAGS ('dbx_business_glossary_term' = 'Control Measure Description (DESC)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description (CORR_ACTION_DESC)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date (CORR_DUE_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required (CORR_ACTION_REQ)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System (SOURCE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFF_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `impact_type` SET TAGS ('dbx_business_glossary_term' = 'Impact Type (TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `impact_type` SET TAGS ('dbx_value_regex' = 'air|water|soil|noise|energy');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Flag (CRITICAL)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit (UNIT)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'kg_co2e|m3|kwh|db|kg|l');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency (FREQ)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Method (METHOD)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department (DEPT)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date (REVIEW_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `significance_rating` SET TAGS ('dbx_business_glossary_term' = 'Significance Rating (RATING)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `significance_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value (TARGET)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`environmental_aspect` ALTER COLUMN `variance` SET TAGS ('dbx_business_glossary_term' = 'Variance (VAR)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` SET TAGS ('dbx_subdomain' = 'environmental_stewardship');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `emissions_record_id` SET TAGS ('dbx_business_glossary_term' = 'Emissions Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Device ID');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `source_emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source ID');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `carbon_intensity` SET TAGS ('dbx_business_glossary_term' = 'Carbon Intensity');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `emission_factor` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `exceedance_flag` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Flag');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `facility_address` SET TAGS ('dbx_business_glossary_term' = 'Facility Address');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `facility_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `facility_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `facility_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `facility_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `greenhouse_gas_equivalent` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas Equivalent');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `measurement_device_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Device Type');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'continuous|periodic|calculated|modelled');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'valid|invalid|pending|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `operational_shift` SET TAGS ('dbx_business_glossary_term' = 'Operational Shift');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `pollutant_type` SET TAGS ('dbx_business_glossary_term' = 'Pollutant Type');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `pollutant_type` SET TAGS ('dbx_value_regex' = 'CO2|NOx|SOx|VOC|PM2.5|PM10');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'submitted|approved|rejected|pending');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Report Submission Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `reported_to_agency` SET TAGS ('dbx_business_glossary_term' = 'Reported To Agency');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `reported_to_agency` SET TAGS ('dbx_value_regex' = 'EPA|State|Local|None');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `reporting_quarter` SET TAGS ('dbx_business_glossary_term' = 'Reporting Quarter');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `reporting_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `source_category` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Category');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `source_category` SET TAGS ('dbx_value_regex' = 'stationary|mobile|process|fugitive');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|ton|kgCO2e|lb|g|ppm');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emissions_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `compliance_product_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Certification ID');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `attached_document_path` SET TAGS ('dbx_business_glossary_term' = 'Attached Document Path');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `certification_cost` SET TAGS ('dbx_business_glossary_term' = 'Certification Cost');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|revoked|pending|suspended');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'CE|UL|IEC|RoHS|REACH|Other');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `compliance_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `compliance_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `compliance_audit_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_applicable');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `compliance_category` SET TAGS ('dbx_value_regex' = 'Safety|Environmental|Cybersecurity|Quality|Other');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `compliance_region` SET TAGS ('dbx_business_glossary_term' = 'Compliance Region');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `compliance_region` SET TAGS ('dbx_value_regex' = 'USA|EU|APAC|MEA|LATAM|Other');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `compliance_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Compliance Risk Level');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `compliance_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `compliance_status_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY|Other');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `export_control_category` SET TAGS ('dbx_business_glossary_term' = 'Export Control Category');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `export_control_category` SET TAGS ('dbx_value_regex' = 'EAR|ITAR|None|Other');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `is_export_controlled` SET TAGS ('dbx_business_glossary_term' = 'Export Controlled Flag');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Certification Flag');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Issue Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `next_inspection_due` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Notes');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Renewal Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope Description');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `test_standard` SET TAGS ('dbx_business_glossary_term' = 'Test Standard');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `test_standard` SET TAGS ('dbx_value_regex' = 'IEC 61010|IEC 61508|ISO 9001|ISO 14001|ISO 45001|Other');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`compliance_product_certification` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `automation_project_id` SET TAGS ('dbx_business_glossary_term' = 'Automation Project Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Document Owner Identifier (OWNER_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Related Product Identifier (PRODUCT_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Related Project Identifier (PROJECT_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `acknowledgment_reference` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Reference (ACK_REF)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `applicable_standard` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standard (STD)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (APPROVAL_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APPROVAL_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|under_review');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `attached_file_path` SET TAGS ('dbx_business_glossary_term' = 'Attached File Path (FILE_PATH)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `authority_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments (COMMENTS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `compliance_area` SET TAGS ('dbx_business_glossary_term' = 'Compliance Area (AREA)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `compliance_area` SET TAGS ('dbx_value_regex' = 'environmental|safety|quality|cybersecurity|product_safety');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level (CONF_LEVEL)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `distribution_scope` SET TAGS ('dbx_business_glossary_term' = 'Distribution Scope (DIST_SCOPE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `distribution_scope` SET TAGS ('dbx_value_regex' = 'internal|external|global|regional');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description (DESCRIPTION)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number (DOC_NUM)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type (DOC_TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'external_submission|internal_procedure|work_instruction|plan|program|record');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFF_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXP_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `file_checksum` SET TAGS ('dbx_business_glossary_term' = 'File Checksum (CHECKSUM)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (SIZE_BYTES)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_period` SET TAGS ('dbx_business_glossary_term' = 'Filing Period (PERIOD)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_period` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|biannual|ad_hoc');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status (FILING_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'submitted|accepted|rejected|pending|closed');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Flag (MANDATORY)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp (LAST_REVIEWED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `next_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Review Timestamp (NEXT_REVIEW_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_status` SET TAGS ('dbx_business_glossary_term' = 'Document Lifecycle Status (STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|rejected|archived');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (RETENTION_DAYS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date (REVIEW_DUE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number (REV_NUM)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (RISK)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date (SUBMIT_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method (METHOD)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|portal|email');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Document Title (TITLE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`regulatory_filing` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VERSION)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit ID');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Holder Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `node_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Permitted Activity Description');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `attached_documents` SET TAGS ('dbx_business_glossary_term' = 'Attached Documents');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `condition` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `expiration_notice_sent` SET TAGS ('dbx_business_glossary_term' = 'Expiration Notice Sent');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Permit Fee Amount');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Permit Fee Currency');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `fee_due_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Fee Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_business_glossary_term' = 'Inspection Outcome');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Issue Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `limit_unit` SET TAGS ('dbx_business_glossary_term' = 'Permit Limit Unit');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `limit_unit` SET TAGS ('dbx_value_regex' = 'tons_per_year|kg_per_day|cfm|lb_per_hour|gallons_per_day');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `limit_value` SET TAGS ('dbx_business_glossary_term' = 'Permit Limit Value');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|continuous');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `next_monitoring_date` SET TAGS ('dbx_business_glossary_term' = 'Next Monitoring Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Permit Notes');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|suspended|pending|revoked');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'air|water|hazardous|building|operating');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `renewal_deadline` SET TAGS ('dbx_business_glossary_term' = 'Renewal Deadline');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Renewal Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'due|renewed|not_required|pending');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`permit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` SET TAGS ('dbx_subdomain' = 'cybersecurity_governance');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `cybersecurity_control_id` SET TAGS ('dbx_business_glossary_term' = 'Cybersecurity Control ID');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Control Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `control_system_id` SET TAGS ('dbx_business_glossary_term' = 'Control System Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `audit_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Count (AUDIT_FINDINGS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial|exempt');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `control_applicability_scope` SET TAGS ('dbx_business_glossary_term' = 'Control Applicability Scope (CTRL_SCOPE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `control_category` SET TAGS ('dbx_business_glossary_term' = 'Control Category (CTRL_CAT)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `control_category` SET TAGS ('dbx_value_regex' = 'access_control|network_segmentation|patch_management|incident_response|monitoring|authentication');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `control_code` SET TAGS ('dbx_business_glossary_term' = 'Control Code (CTRL_CODE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `control_cost` SET TAGS ('dbx_business_glossary_term' = 'Control Cost (CTRL_COST)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `control_description` SET TAGS ('dbx_business_glossary_term' = 'Control Description (CTRL_DESC)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `control_evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Control Evidence Reference (CTRL_EVID_REF)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `control_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Control Mechanism (CTRL_MECH)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `control_name` SET TAGS ('dbx_business_glossary_term' = 'Control Name (CTRL_NAME)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `control_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `control_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `control_objective` SET TAGS ('dbx_business_glossary_term' = 'Control Objective (CTRL_OBJ)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `control_priority` SET TAGS ('dbx_business_glossary_term' = 'Control Priority (CTRL_PRIORITY)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `control_source` SET TAGS ('dbx_business_glossary_term' = 'Control Source (CTRL_SRC)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `control_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Control Subcategory (CTRL_SUBCAT)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type (CTRL_TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'preventive|detective|corrective');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `control_version` SET TAGS ('dbx_business_glossary_term' = 'Control Version (CTRL_VER)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFFECTIVE_DT)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status (IMPL_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `implementation_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|implemented|not_applicable|decommissioned');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Date (LAST_ASSESS_DT)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date (LAST_MAINT_DT)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LIFECYCLE_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `maintenance_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Frequency (MAINT_FREQ_DAYS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Date (NEXT_MAINT_DT)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date (NEXT_REVIEW_DT)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department (OWNER_DEPT)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `remediation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Remediation Deadline (REMEDIATION_DL)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date (RETIRE_DT)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating (RISK_RATING)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `security_level_achieved` SET TAGS ('dbx_business_glossary_term' = 'Security Level Achieved (SL‑A)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `security_level_achieved` SET TAGS ('dbx_value_regex' = 'SL1|SL2|SL3|SL4|SL5');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `security_level_target` SET TAGS ('dbx_business_glossary_term' = 'Security Level Target (SL‑T)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `security_level_target` SET TAGS ('dbx_value_regex' = 'SL1|SL2|SL3|SL4|SL5');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_control` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` SET TAGS ('dbx_subdomain' = 'cybersecurity_governance');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `cybersecurity_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Cybersecurity Assessment ID');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'System Owner ID');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assessment Approval Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `assessed_zone` SET TAGS ('dbx_business_glossary_term' = 'Assessed Zone or System');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date (Timestamp)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `assessment_methodology` SET TAGS ('dbx_business_glossary_term' = 'Assessment Methodology');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `assessment_methodology` SET TAGS ('dbx_value_regex' = 'IEC 62443-3-2|NIST CSF|ISO 27001');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number (ID)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `assessment_scope` SET TAGS ('dbx_business_glossary_term' = 'Assessment Scope');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|completed|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `assessment_version` SET TAGS ('dbx_business_glossary_term' = 'Assessment Version');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `assessor_contact` SET TAGS ('dbx_business_glossary_term' = 'Assessor Contact Email');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `assessor_contact` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `assessor_contact` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `assessor_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_value_regex' = 'IEC 62443|NIST CSF|ISO 27001');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `control_gap_summary` SET TAGS ('dbx_business_glossary_term' = 'Control Gap Summary');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `document_link` SET TAGS ('dbx_business_glossary_term' = 'Assessment Document Link');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `evidence_attached` SET TAGS ('dbx_business_glossary_term' = 'Evidence Attached Flag');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `external_auditor_contact` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Contact Email');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `external_auditor_contact` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `external_auditor_contact` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `external_auditor_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `external_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Name');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `external_auditor_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `external_auditor_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `is_critical_asset` SET TAGS ('dbx_business_glossary_term' = 'Critical Asset Flag');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `is_external_assessment` SET TAGS ('dbx_business_glossary_term' = 'External Assessment Flag');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `overall_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Risk Score');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `recommended_remediation_actions` SET TAGS ('dbx_business_glossary_term' = 'Recommended Remediation Actions');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|deferred');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `risk_justification` SET TAGS ('dbx_business_glossary_term' = 'Risk Justification');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `security_level_gap` SET TAGS ('dbx_business_glossary_term' = 'Security Level Gap');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`cybersecurity_assessment` ALTER COLUMN `vulnerabilities_identified` SET TAGS ('dbx_business_glossary_term' = 'Identified Vulnerabilities');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` SET TAGS ('dbx_subdomain' = 'environmental_stewardship');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `hazardous_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Substance Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `chemical_family` SET TAGS ('dbx_business_glossary_term' = 'Chemical Family');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `handling_requirements` SET TAGS ('dbx_business_glossary_term' = 'Handling Requirements');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'GHS Hazard Classification');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_value_regex' = 'explosive|flammable|oxidizer|corrosive|toxic|environmental');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `hazard_statements` SET TAGS ('dbx_business_glossary_term' = 'GHS Hazard Statements');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `hazardous_substance_status` SET TAGS ('dbx_business_glossary_term' = 'Substance Record Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `hazardous_substance_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `internal_code` SET TAGS ('dbx_business_glossary_term' = 'Internal Substance Code');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `is_controlled_substance` SET TAGS ('dbx_business_glossary_term' = 'Is Controlled Substance Flag');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `is_hazardous` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous Flag');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `is_reportable` SET TAGS ('dbx_business_glossary_term' = 'Is Reportable Flag');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `last_inventory_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inventory Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `molecular_formula` SET TAGS ('dbx_business_glossary_term' = 'Molecular Formula');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `molecular_weight` SET TAGS ('dbx_business_glossary_term' = 'Molecular Weight (g/mol)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `hazardous_substance_name` SET TAGS ('dbx_business_glossary_term' = 'Substance Name');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `hazardous_substance_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `hazardous_substance_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `personal_protective_equipment` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `precautionary_statements` SET TAGS ('dbx_business_glossary_term' = 'GHS Precautionary Statements');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `procurement_date` SET TAGS ('dbx_business_glossary_term' = 'Procurement Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `reporting_threshold_exceeded` SET TAGS ('dbx_business_glossary_term' = 'Reporting Threshold Exceeded');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `sds_url` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) URL');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `signal_word` SET TAGS ('dbx_business_glossary_term' = 'GHS Signal Word');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `signal_word` SET TAGS ('dbx_value_regex' = 'Danger|Warning');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `substance_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `threshold_quantity` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Threshold Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|g|lb|l|ml|mol');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`hazardous_substance` ALTER COLUMN `waste_code` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Code');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` SET TAGS ('dbx_subdomain' = 'environmental_stewardship');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `waste_record_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By ID (REPORTER_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Related Product Line ID (PRODUCT_LINE_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID (LOC_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Contractor ID (CONTRACTOR_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (APPROVER)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `chain_of_custody_document` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Document (COC_DOC)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `disposal_contractor` SET TAGS ('dbx_business_glossary_term' = 'Disposal Contractor (CONTRACTOR)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date (DISPOSAL_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method (METHOD)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'incineration|landfill|recycling|treatment|export');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `disposal_site` SET TAGS ('dbx_business_glossary_term' = 'Disposal Site (SITE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `disposal_site_address` SET TAGS ('dbx_business_glossary_term' = 'Disposal Site Address (SITE_ADDR)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `disposal_site_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `disposal_site_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `disposal_site_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `disposal_site_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `disposal_site_city` SET TAGS ('dbx_business_glossary_term' = 'Disposal Site City (SITE_CITY)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `disposal_site_country` SET TAGS ('dbx_business_glossary_term' = 'Disposal Site Country (SITE_COUNTRY)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `disposal_site_state` SET TAGS ('dbx_business_glossary_term' = 'Disposal Site State (SITE_STATE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `disposal_site_zip` SET TAGS ('dbx_business_glossary_term' = 'Disposal Site ZIP/Postal Code (SITE_ZIP)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `epa_waste_code` SET TAGS ('dbx_business_glossary_term' = 'EPA Waste Code (EPA_CODE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `epa_waste_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `generation_date` SET TAGS ('dbx_business_glossary_term' = 'Generation Date (GEN_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification (HAZ_CLASS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_value_regex' = 'flammable|corrosive|toxic|reactive|radioactive|other');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `is_hazardous` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous (HAZARDOUS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `manifest_number` SET TAGS ('dbx_business_glossary_term' = 'Manifest Number (MANIFEST_NO)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `manifest_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity (QTY)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `related_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Related Facility ID (FACILITY_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By (REPORTER)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location (LOCATION)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `transport_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Transport Distance (DIST_KM)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `transport_emission_kg_co2` SET TAGS ('dbx_business_glossary_term' = 'Transport Emission CO₂ (EMISSION_KG_CO2)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode (TRANSPORT_MODE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'truck|rail|ship|air');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|gal|l');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `waste_category` SET TAGS ('dbx_business_glossary_term' = 'Waste Category (CATEGORY)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `waste_category` SET TAGS ('dbx_value_regex' = 'chemical|metal|organic|radioactive|other');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `waste_identifier` SET TAGS ('dbx_business_glossary_term' = 'Waste Record Identifier (WASTE_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `waste_origin` SET TAGS ('dbx_business_glossary_term' = 'Waste Origin (ORIGIN)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `waste_origin` SET TAGS ('dbx_value_regex' = 'production|maintenance|R&D|cleanup');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `waste_record_status` SET TAGS ('dbx_business_glossary_term' = 'Waste Record Status (STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `waste_record_status` SET TAGS ('dbx_value_regex' = 'generated|stored|disposed|closed');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `waste_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Type (TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`waste_record` ALTER COLUMN `waste_type` SET TAGS ('dbx_value_regex' = 'hazardous|non_hazardous|universal|special');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `periodic_evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Periodic Evaluation Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Assessed Obligation Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `assessment_code` SET TAGS ('dbx_business_glossary_term' = 'Assessment Code (AC)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method (AM)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'document_review|interview|observation|testing');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `assessment_scope` SET TAGS ('dbx_business_glossary_term' = 'Assessment Scope');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Full Name (AFN)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `assessor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `assessor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `assessor_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `assessor_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `conformance_rating` SET TAGS ('dbx_business_glossary_term' = 'Conformance Rating (CR)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `conformance_status` SET TAGS ('dbx_business_glossary_term' = 'Conformance Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `conformance_status` SET TAGS ('dbx_value_regex' = 'compliant|partially_compliant|non_compliant');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `evidence_documentation` SET TAGS ('dbx_business_glossary_term' = 'Evidence Documentation URL');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `gaps_identified` SET TAGS ('dbx_business_glossary_term' = 'Identified Gaps');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `next_assessment_due` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `periodic_evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Lifecycle Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `periodic_evaluation_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|completed|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `recommended_actions` SET TAGS ('dbx_business_glossary_term' = 'Recommended Corrective Actions');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `regulation_code` SET TAGS ('dbx_business_glossary_term' = 'Regulation Code (RC)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `regulation_name` SET TAGS ('dbx_business_glossary_term' = 'Regulation Name');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `regulation_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `regulation_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `risk_severity` SET TAGS ('dbx_business_glossary_term' = 'Risk Severity');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `risk_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`periodic_evaluation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Controlled Document Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Document Approver ID (APPROVER_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `controlled_related_regulation_regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Related Regulation ID (REGUL_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `device_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registry Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `primary_controlled_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Document Owner ID (OWNER_ID)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `primary_controlled_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `primary_controlled_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `project_header_id` SET TAGS ('dbx_business_glossary_term' = 'Project Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `applicable_standard` SET TAGS ('dbx_business_glossary_term' = 'Applicable Standard (STD)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (APPROVAL_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APPROVAL_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `archive_location` SET TAGS ('dbx_business_glossary_term' = 'Archive Location (ARCHIVE_LOC)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason (CHANGE_REASON)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `checksum` SET TAGS ('dbx_business_glossary_term' = 'File Checksum (CHECKSUM)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial|not_applicable');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level (CONF_LEVEL)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `controlled_document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status (STATUS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `controlled_document_status` SET TAGS ('dbx_value_regex' = 'draft|review|approved|obsolete|retracted');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CREATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `distribution_scope` SET TAGS ('dbx_business_glossary_term' = 'Distribution Scope (DIST_SCOPE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `distribution_scope` SET TAGS ('dbx_value_regex' = 'global|regional|site|department|external');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `document_language` SET TAGS ('dbx_business_glossary_term' = 'Document Language (LANG)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `document_language` SET TAGS ('dbx_value_regex' = 'en|es|de|fr|zh|ja');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number (DOC_NO)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type (TYPE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFF_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXP_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'File Path (FILE_PATH)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (BYTES)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active (ACTIVE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp (LAST_REVIEWED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `retention_end_date` SET TAGS ('dbx_business_glossary_term' = 'Retention End Date (RET_END)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (DAYS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date (REVIEW_DUE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date (REV_DATE)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number (REV_NO)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Document Title (DT)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By (UPDATED_BY)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Document Version (VERSION)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`controlled_document` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (CREATED_BY)');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` SET TAGS ('dbx_subdomain' = 'safety_health');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `process_hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Process Hazard Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `parent_process_hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Process Hazard Id');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `parent_process_hazard_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `associated_processes` SET TAGS ('dbx_business_glossary_term' = 'Associated Processes');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `control_measures` SET TAGS ('dbx_business_glossary_term' = 'Control Measures');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `process_hazard_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `emergency_response_procedure` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Procedure');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `exposure_limit_unit` SET TAGS ('dbx_business_glossary_term' = 'Exposure Limit Unit');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `exposure_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Exposure Limit Value');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `hazard_category` SET TAGS ('dbx_business_glossary_term' = 'Hazard Category');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `hazard_code` SET TAGS ('dbx_business_glossary_term' = 'Hazard Code');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `hazard_name` SET TAGS ('dbx_business_glossary_term' = 'Hazard Name');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `hazard_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `hazard_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `hazard_owner` SET TAGS ('dbx_business_glossary_term' = 'Hazard Owner');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `hazard_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Hazard Subcategory');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `incident_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Incident History Flag');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `likelihood_level` SET TAGS ('dbx_business_glossary_term' = 'Likelihood Level');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Method');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `monitoring_required` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Required');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `regulatory_standard` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Standard');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Months');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `training_program` SET TAGS ('dbx_business_glossary_term' = 'Training Program');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Training Required');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`process_hazard` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` SET TAGS ('dbx_subdomain' = 'environmental_stewardship');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `parent_emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Emission Source Id');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `parent_emission_source_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `emission_source_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `compliance_certification_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Code');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `emission_source_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `emission_factor` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `last_reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reported Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `emission_source_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `emission_source_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `emission_source_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `next_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Report Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `plant_location` SET TAGS ('dbx_business_glossary_term' = 'Plant Location');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `source_code` SET TAGS ('dbx_business_glossary_term' = 'Source Code');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `source_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `source_operating_company` SET TAGS ('dbx_business_glossary_term' = 'Source Operating Company');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `source_owner` SET TAGS ('dbx_business_glossary_term' = 'Source Owner');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `emission_source_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `emission_source_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`emission_source` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` SET TAGS ('dbx_subdomain' = 'environmental_stewardship');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `parent_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Facility Id');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `address_line` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `address_line` SET TAGS ('dbx_mask' = 'nonprod');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `backup_generator_present` SET TAGS ('dbx_business_glossary_term' = 'Backup Generator Present');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Capacity Units');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `compliance_iec_62443_certified` SET TAGS ('dbx_business_glossary_term' = 'Compliance Iec 62443 Certified');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `compliance_iso_14001_certified` SET TAGS ('dbx_business_glossary_term' = 'Compliance Iso 14001 Certified');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `compliance_iso_45001_certified` SET TAGS ('dbx_business_glossary_term' = 'Compliance Iso 45001 Certified');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `emissions_co2_tons` SET TAGS ('dbx_business_glossary_term' = 'Emissions Co2 Tons');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `energy_consumption_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Mwh');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `epa_permit_expiry` SET TAGS ('dbx_business_glossary_term' = 'Epa Permit Expiry');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `epa_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Epa Permit Number');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `epa_permit_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `fire_suppression_type` SET TAGS ('dbx_business_glossary_term' = 'Fire Suppression Type');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `hazardous_material_storage` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Storage');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `hvac_type` SET TAGS ('dbx_business_glossary_term' = 'Hvac Type');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `next_inspection_due` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `power_source` SET TAGS ('dbx_business_glossary_term' = 'Power Source');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `size_sqft` SET TAGS ('dbx_business_glossary_term' = 'Size Sqft');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `facility_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Id Number');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `waste_generated_tons` SET TAGS ('dbx_business_glossary_term' = 'Waste Generated Tons');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`facility` ALTER COLUMN `water_usage_m3` SET TAGS ('dbx_business_glossary_term' = 'Water Usage M3');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` SET TAGS ('dbx_subdomain' = 'safety_health');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `safety_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Checklist Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `parent_safety_checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Safety Checklist Id');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `parent_safety_checklist_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `applicable_regulation` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulation');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `attachment_flag` SET TAGS ('dbx_business_glossary_term' = 'Attachment Flag');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `safety_checklist_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `checklist_items_count` SET TAGS ('dbx_business_glossary_term' = 'Checklist Items Count');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `checklist_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `checklist_type` SET TAGS ('dbx_business_glossary_term' = 'Checklist Type');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `safety_checklist_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `safety_checklist_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document Url');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `safety_checklist_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `safety_checklist_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `safety_checklist_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `required_training` SET TAGS ('dbx_business_glossary_term' = 'Required Training');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Days');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `safety_checklist_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_manufacturing_v1`.`compliance`.`safety_checklist` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
