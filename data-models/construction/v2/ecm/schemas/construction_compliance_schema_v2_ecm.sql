-- Schema for Domain: compliance | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:09:55

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`compliance` COMMENT 'Regulatory compliance domain owning permit registers, environmental impact assessments, LEED certification tracking, building permit records, and regulatory reporting submissions to OSHA, EPA, and local authorities. Manages GDPR/privacy obligations for workforce and client data and PCI DSS controls for financial transactions. Distinct from safety (which owns incident data) and quality (which owns NCRs).';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`compliance`.`permit_application` (
    `permit_application_id` BIGINT COMMENT 'Unique identifier for the permit application record.',
    `hr_employee_id` BIGINT COMMENT 'add column applicant_employee_id (BIGINT) with FK to hr.hr.employee_id - permit applications need a responsible filing employee',
    `regulatory_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Permit applications result in a compliance permit; linking them avoids data duplication. Overlapping columns are removed from permit_application.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project associated with the permit.',
    `env_impact_assessment_id` BIGINT COMMENT 'Reference to the associated environmental impact assessment record.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Permit applications are often submitted by subcontractors; linking to firm_profile enables audit of applicant compliance.',
    `appeal_deadline` DATE COMMENT 'Last date on which an appeal against a decision can be filed.',
    `appeal_filed_timestamp` TIMESTAMP COMMENT 'Date and time when an appeal was submitted.',
    `application_number` STRING COMMENT 'External reference number assigned to the permit application by the submitting organization.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the authority approved the permit.',
    `compliance_requirements_met` BOOLEAN COMMENT 'Indicates whether the application satisfies all regulatory compliance requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the permit application record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the fee.',
    `decision` STRING COMMENT 'Final decision made by the authority on the application.. Valid values are `approved|rejected|withdrawn|pending`',
    `decision_reason` STRING COMMENT 'Reason or justification provided for the authoritys decision.',
    `permit_application_description` STRING COMMENT 'Narrative description of the work or activity for which the permit is sought.',
    `expiration_timestamp` TIMESTAMP COMMENT 'Date and time when the approved permit expires.',
    `fee_adjustment` DECIMAL(18,2) COMMENT 'Additional adjustments to the base fee such as taxes, surcharges, or discounts.',
    `fee_total` DECIMAL(18,2) COMMENT 'Total amount payable after applying adjustments.',
    `is_resubmission` BOOLEAN COMMENT 'Flag indicating whether the application is a resubmission after a prior rejection or withdrawal.',
    `leeds_certification_level` STRING COMMENT 'LEED sustainability certification level applicable to the project.. Valid values are `certified|silver|gold|platinum`',
    `permit_application_status` STRING COMMENT 'Current lifecycle state of the permit application.. Valid values are `draft|submitted|under_review|approved|rejected|withdrawn`',
    `resubmission_reason` STRING COMMENT 'Explanation provided for why the application is being resubmitted.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the application was formally submitted to the authority.',
    `supporting_document_count` STRING COMMENT 'Number of supporting documents attached to the application.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the permit application record.',
    `validity_end_date` DATE COMMENT 'Last day the permit remains valid.',
    `validity_start_date` DATE COMMENT 'First day the permit becomes effective.',
    `work_scope` STRING COMMENT 'Brief description of the work scope covered by the permit.',
    CONSTRAINT pk_permit_application PRIMARY KEY(`permit_application_id`)
) COMMENT 'Transactional record of each permit application submitted to a regulatory or municipal authority, capturing application reference, submission date, applicant details, supporting documents submitted, application status, authority response, and approval or rejection outcome. Tracks the full lifecycle from initial submission through approval, including resubmissions and appeals.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`compliance`.`permit_condition` (
    `permit_condition_id` BIGINT COMMENT 'Unique identifier for the permit condition record.',
    `regulatory_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Each permit condition belongs to a specific permit; adding permit_id creates the required parent link and eliminates the silo.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Managing permit conditions assigns a specific client contact as the responsible party, needed for condition monitoring and notifications.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Needed for Condition Enforcement process; assigns a specific employee to monitor and report on each permit condition, replacing denormalized name fields.',
    `compliance_deadline` DATE COMMENT 'Date by which the condition must be satisfied.',
    `compliance_evidence_url` STRING COMMENT 'Link to digital evidence supporting compliance.',
    `compliance_status_detail` STRING COMMENT 'Detailed description of the current compliance status.',
    `condition_action_required` STRING COMMENT 'Specific action(s) required to satisfy the condition.',
    `condition_category` STRING COMMENT 'Higher-level grouping of the condition (e.g., environmental, safety).',
    `condition_code` STRING COMMENT 'External code or identifier assigned to the condition by the regulatory authority.',
    `condition_document_reference` STRING COMMENT 'Reference to the official document where the condition is recorded.',
    `condition_fine_amount` DECIMAL(18,2) COMMENT 'Monetary fine associated with non‑compliance, if applicable.',
    `condition_fine_currency` STRING COMMENT 'Currency of the fine amount.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `condition_is_mandatory` BOOLEAN COMMENT 'Indicates whether the condition is mandatory (cannot be waived).',
    `condition_is_waivable` BOOLEAN COMMENT 'Indicates whether the condition can be waived under certain circumstances.',
    `condition_last_updated_by` STRING COMMENT 'User or system that performed the most recent update.',
    `condition_last_updated_by_role` STRING COMMENT 'Role of the user or system that performed the most recent update (e.g., compliance_officer, system).',
    `condition_priority` STRING COMMENT 'Priority level indicating the importance of the condition.. Valid values are `low|medium|high|critical`',
    `condition_reference_number` STRING COMMENT 'Alternate reference number for the condition, if used by the authority.',
    `condition_resolution_date` DATE COMMENT 'Date when the condition was resolved or closed.',
    `condition_resolution_notes` STRING COMMENT 'Notes describing how the condition was resolved.',
    `condition_review_date` DATE COMMENT 'Scheduled date for periodic review of the condition.',
    `condition_status_reason` STRING COMMENT 'Explanation for the current status of the condition.',
    `condition_type` STRING COMMENT 'Category of the condition, such as environmental, safety, financial, schedule, or quality.. Valid values are `environmental|safety|financial|schedule|quality`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the condition record was created.',
    `permit_condition_description` STRING COMMENT 'Full textual description of the condition and its obligations.',
    `effective_date` DATE COMMENT 'Date when the condition becomes effective.',
    `evidence_required` STRING COMMENT 'Description of documentation or evidence needed to prove compliance.',
    `expiry_date` DATE COMMENT 'Date when the condition expires or is no longer applicable (nullable).',
    `inspection_last_date` DATE COMMENT 'Date of the most recent inspection related to the condition.',
    `inspection_next_date` DATE COMMENT 'Planned date for the next required inspection.',
    `inspection_required` BOOLEAN COMMENT 'Indicates whether a physical inspection is required for this condition.',
    `last_report_date` DATE COMMENT 'Date of the most recent compliance report submitted.',
    `next_report_date` DATE COMMENT 'Planned date for the next compliance report.',
    `notes` STRING COMMENT 'Free-form notes related to the condition.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount if the condition is not met.',
    `penalty_currency` STRING COMMENT 'Currency of the penalty amount.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `permit_condition_status` STRING COMMENT 'Current lifecycle status of the condition.. Valid values are `pending|compliant|non_compliant|waived|closed`',
    `reporting_frequency` STRING COMMENT 'How often compliance evidence must be reported.. Valid values are `daily|weekly|monthly|quarterly|annually`',
    `source_agency` STRING COMMENT 'Regulatory authority that issued the condition (e.g., OSHA, EPA).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the condition record.',
    CONSTRAINT pk_permit_condition PRIMARY KEY(`permit_condition_id`)
) COMMENT 'Records individual conditions, restrictions, and obligations attached to an issued permit by the regulatory authority. Each condition has its own compliance obligation, due date, responsible party, and fulfilment status. Enables tracking of permit condition compliance separately from the permit itself, supporting audit readiness and authority inspections.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` (
    `env_impact_assessment_id` BIGINT COMMENT 'Primary key for env_impact_assessment',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Supports Environmental Impact Oversight where an internal compliance officer is accountable for assessment outcomes and regulatory follow‑up.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which this assessment belongs.',
    `approval_date` DATE COMMENT 'Date on which the assessment received formal approval.',
    `approval_status` STRING COMMENT 'Current approval state of the assessment with the regulator.. Valid values are `pending|approved|rejected|withdrawn`',
    `assessment_date` DATE COMMENT 'Date on which the environmental impact assessment was formally conducted.',
    `assessment_number` STRING COMMENT 'External reference number or code assigned to the assessment by the organization or regulator.',
    `assessment_type` STRING COMMENT 'Classification of the assessment (e.g., baseline, impact, post‑construction, ongoing monitoring).. Valid values are `baseline|impact|post_construction|monitoring`',
    `assessment_version` STRING COMMENT 'Version identifier for the assessment document (e.g., v1.0, v2.1).',
    `consultant_email` STRING COMMENT 'Primary email address of the environmental consultant for correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `consultant_name` STRING COMMENT 'Full legal name of the external environmental consultant or firm responsible for the assessment.',
    `corrective_action_taken` STRING COMMENT 'Description of any corrective action triggered by the last exceedance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assessment record was first created in the system.',
    `environmental_category` STRING COMMENT 'Primary environmental domain(s) addressed by the assessment.. Valid values are `air|water|soil|noise|biodiversity|waste`',
    `epa_report_submitted` BOOLEAN COMMENT 'Flag indicating whether the required EPA report for this assessment has been submitted.',
    `findings_summary` STRING COMMENT 'Concise summary of the key findings and conclusions of the assessment.',
    `iso_14001_compliant` BOOLEAN COMMENT 'Indicates compliance with ISO 14001 environmental management system standards.',
    `leeds_certified` BOOLEAN COMMENT 'True if the project has achieved LEED certification related to the assessment.',
    `mitigation_measures` STRING COMMENT 'List of required mitigation actions to address identified environmental impacts.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory review of the assessment.',
    `overall_status` STRING COMMENT 'Current operational status of the assessment record.. Valid values are `active|inactive|closed|on_hold`',
    `project_phase` STRING COMMENT 'Current phase of the construction project associated with the assessment.. Valid values are `planning|design|construction|operation|decommission`',
    `regulatory_submission_ref` STRING COMMENT 'Reference identifier of the submission made to the regulatory authority (e.g., EPA filing number).',
    `review_cycle_months` STRING COMMENT 'Number of months between mandatory review cycles for the assessment.',
    `risk_level` STRING COMMENT 'Risk rating assigned to the assessment based on potential environmental impact.. Valid values are `low|medium|high|critical`',
    `scope_description` STRING COMMENT 'Narrative description of the geographic and functional scope covered by the assessment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assessment record.',
    CONSTRAINT pk_env_impact_assessment PRIMARY KEY(`env_impact_assessment_id`)
) COMMENT 'Master record for Environmental Impact Assessments (EIA), Environmental Management Plans (EMP), and ongoing environmental monitoring programs for construction projects. Captures assessment type, scope, environmental consultant, assessment date, findings summary, mitigation measures required, regulatory submission reference, approval status, and review cycle. Includes full environmental monitoring history: air quality measurements, noise level readings, water discharge sampling, soil contamination checks, dust suppression monitoring, with monitoring date, location, parameter measured, recorded value, regulatory threshold, exceedance flag, and corrective action triggered for each monitoring event. Supports EPA reporting, ISO 14001 surveillance, and demonstrates ongoing environmental compliance through continuous monitoring evidence.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` (
    `env_monitoring_id` BIGINT COMMENT 'Primary key for env_monitoring',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project associated with the monitoring activity.',
    `env_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.env_impact_assessment. Business justification: Environmental monitoring events are performed against a specific impact assessment. Adding env_impact_assessment_id to env_monitoring captures this link.',
    `env_site_construction_project_id` BIGINT COMMENT 'Identifier of the construction site where the monitoring activity occurred.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the employee who logged the monitoring record.',
    `audit_created_by` BIGINT COMMENT 'Employee identifier who initially created the record.',
    `batch_number` STRING COMMENT 'Identifier for the batch of samples or readings, if applicable.',
    `comments` STRING COMMENT 'Free‑text notes or observations related to the monitoring event.',
    `compliance_status` STRING COMMENT 'Overall compliance determination for the measurement.. Valid values are `compliant|non_compliant|pending`',
    `corrective_action` STRING COMMENT 'Description of any corrective action triggered by an exceedance.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action.. Valid values are `pending|completed|not_required`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the monitoring record was first created in the system.',
    `data_quality_flag` STRING COMMENT 'Indicates the quality assessment of the recorded data.. Valid values are `good|questionable|bad`',
    `env_monitoring_status` STRING COMMENT 'Lifecycle status of the monitoring record.. Valid values are `recorded|reviewed|closed`',
    `equipment_serial_number` STRING COMMENT 'Serial number of the equipment used for the measurement.',
    `exceedance_flag` BOOLEAN COMMENT 'Indicates whether the measured value exceeds the regulatory threshold.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the measurement location.',
    `location_description` STRING COMMENT 'Human‑readable description of the monitoring location (e.g., "North perimeter, Zone A").',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the measurement location.',
    `measured_value` DECIMAL(18,2) COMMENT 'Numeric result of the measurement.',
    `measurement_method` STRING COMMENT 'Technique used to obtain the measurement.. Valid values are `sensor|manual|lab`',
    `measurement_unit` STRING COMMENT 'Unit of measure for the recorded value (e.g., µg/m³, dB, pH).',
    `monitoring_timestamp` TIMESTAMP COMMENT 'Date and time when the environmental measurement was taken.',
    `monitoring_type` STRING COMMENT 'Category of environmental parameter being monitored.. Valid values are `air|noise|water|soil|dust|vibration`',
    `parameter` STRING COMMENT 'Specific environmental parameter measured (e.g., PM2.5, dB, pH).',
    `regulatory_body` STRING COMMENT 'Authority whose regulations apply to the measurement.. Valid values are `EPA|OSHA|ISO14001|local|state|federal`',
    `sample_reference` STRING COMMENT 'Unique identifier for the individual sample taken.',
    `sensor_code` BIGINT COMMENT 'Identifier of the sensor or instrument that captured the measurement.',
    `threshold_unit` STRING COMMENT 'Unit of measure for the threshold value.',
    `threshold_value` DECIMAL(18,2) COMMENT 'Regulatory or project-specific limit for the parameter.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the monitoring record.',
    `weather_conditions` STRING COMMENT 'Brief description of weather at the time of measurement (e.g., sunny, windy).',
    CONSTRAINT pk_env_monitoring PRIMARY KEY(`env_monitoring_id`)
) COMMENT 'Transactional records of environmental monitoring activities conducted on construction sites, including air quality measurements, noise level readings, water discharge sampling, soil contamination checks, and dust suppression monitoring. Captures monitoring date, location, parameter measured, recorded value, regulatory threshold, exceedance flag, and corrective action triggered. Supports EPA reporting and ISO 14001 surveillance.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`compliance`.`leed_certification` (
    `leed_certification_id` BIGINT COMMENT 'System-generated unique identifier for the LEED certification record.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Links LEED certification to the employee responsible for ensuring compliance with green building criteria, required for audit trails.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project associated with this LEED certification pursuit.',
    `award_date` DATE COMMENT 'Date the LEED certification was officially granted.',
    `certificate_reference` STRING COMMENT 'Identifier of the issued LEED certificate document.',
    `certification_level_awarded` STRING COMMENT 'Certification level actually awarded after final review; None if not awarded.. Valid values are `Certified|Silver|Gold|Platinum|None`',
    `certification_level_target` STRING COMMENT 'Desired certification level the project aims to achieve (e.g., Certified, Silver, Gold, Platinum).. Valid values are `Certified|Silver|Gold|Platinum`',
    `certification_type` STRING COMMENT 'Specific LEED rating system applicable to the project (e.g., New Construction, Existing Buildings).. Valid values are `New Construction|Existing Buildings|Core and Shell|Commercial Interiors|Neighborhood Development|Homes`',
    `certifying_body` STRING COMMENT 'Organization that issues the LEED certification, typically the U.S. Green Building Council (USGBC).',
    `compliance_review_date` DATE COMMENT 'Date of the most recent compliance verification performed internally.',
    `compliance_status` STRING COMMENT 'Overall compliance status of the project with LEED requirements.. Valid values are `compliant|non_compliant|pending`',
    `evidence_submitted_date` DATE COMMENT 'Date when supporting evidence for credit claims was uploaded to the certification portal.',
    `expiration_date` DATE COMMENT 'Date when the awarded LEED certification expires, if applicable.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp of the last review action performed by the certifying body.',
    `lifecycle_status` STRING COMMENT 'Current state of the certification process.. Valid values are `draft|submitted|under_review|approved|rejected|closed`',
    `notes` STRING COMMENT 'Additional free-form notes related to the certification process.',
    `project_phase` STRING COMMENT 'Current phase of the project relevant to the certification effort.. Valid values are `Planning|Design|Construction|Commissioning|Operation`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the LEED certification record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the LEED certification record.',
    `registration_number` STRING COMMENT 'Official registration number assigned by the certifying body when the project is entered into the LEED system.',
    `registration_status` STRING COMMENT 'Current status of the projects registration in the LEED system (e.g., registered, withdrawn, expired).',
    `renewal_status` STRING COMMENT 'Status of the certification renewal process.. Valid values are `not_due|due|renewed|overdue`',
    `review_status` STRING COMMENT 'Current status of the certifying bodys review of the submitted evidence.. Valid values are `pending|approved|rejected`',
    `reviewer_comments` STRING COMMENT 'Free-text comments provided by the reviewer during the certification assessment.',
    `start_date` DATE COMMENT 'Date when the LEED certification pursuit officially begins.',
    `submission_date` DATE COMMENT 'Date the certification application and supporting documentation were submitted to the certifying body.',
    `submission_reference` STRING COMMENT 'External reference number or code used by the certifying body for the submission package.',
    `target_award_date` DATE COMMENT 'Planned date by which the certification is expected to be awarded.',
    `total_points_available` DECIMAL(18,2) COMMENT 'Maximum number of points that can be earned across all credit categories for this project.',
    `total_points_awarded` DECIMAL(18,2) COMMENT 'Actual number of points earned after the certifying body review.',
    `total_points_targeted` DECIMAL(18,2) COMMENT 'Number of points the project plans to achieve based on credit selection.',
    `updated_by` STRING COMMENT 'User or system identifier that performed the most recent update.',
    `created_by` STRING COMMENT 'User or system identifier that created the certification record.',
    CONSTRAINT pk_leed_certification PRIMARY KEY(`leed_certification_id`)
) COMMENT 'Master record tracking LEED (Leadership in Energy and Environmental Design) certification pursuits for construction projects with full credit-level scorecard management. Captures certification level targeted (Certified, Silver, Gold, Platinum), certifying body, project registration number, and manages individual credits within each credit category (Energy & Atmosphere, Water Efficiency, Indoor Environmental Quality, Materials & Resources, Sustainable Sites, Innovation). Each credit tracks points available, points targeted, points awarded, evidence submitted, review status, and reviewer comments. Also captures submission date, certification award date, and certificate reference. Serves as the SSOT for LEED certification status and granular credit scorecard progress. Supports U.S. Green Building Council reporting.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`compliance`.`leed_credit` (
    `leed_credit_id` BIGINT COMMENT 'Unique identifier for the LEED credit record.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project associated with this credit.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the LEED reviewer who performed the assessment.',
    `leed_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.leed_certification. Business justification: LEED credits are defined within a LEED certification. Adding leed_certification_id to leed_credit models the parent‑child relationship.',
    `compliance_requirements` STRING COMMENT 'Regulatory or LEED prerequisite references applicable to this credit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the credit record was first created.',
    `credit_category` STRING COMMENT 'High‑level LEED credit category (e.g., Energy & Atmosphere, Water Efficiency).',
    `credit_code` STRING COMMENT 'Standard LEED credit identifier code (e.g., EQ‑1, WE‑2).',
    `credit_description` STRING COMMENT 'Detailed description of the credit requirements and intent.',
    `credit_name` STRING COMMENT 'Descriptive name of the specific LEED credit.',
    `documentation_url` STRING COMMENT 'Link to supporting documentation or files stored in the document management system.',
    `eligibility_criteria` STRING COMMENT 'Textual description of the criteria that must be satisfied to be eligible for the credit.',
    `evidence_submission_date` DATE COMMENT 'Date the evidence was submitted to the LEED reviewer.',
    `evidence_submitted` STRING COMMENT 'Reference or description of the evidence package submitted for this credit.',
    `is_eligible` BOOLEAN COMMENT 'Indicates whether the project meets the basic eligibility criteria for this credit.',
    `leed_credit_status` STRING COMMENT 'Current lifecycle status of the credit record.. Valid values are `pending|submitted|approved|rejected|withdrawn`',
    `points_available` DECIMAL(18,2) COMMENT 'Maximum points that can be earned for this credit.',
    `points_awarded` DECIMAL(18,2) COMMENT 'Points actually awarded after review.',
    `points_targeted` DECIMAL(18,2) COMMENT 'Points the project aims to achieve for this credit.',
    `review_date` DATE COMMENT 'Date the review decision was recorded.',
    `review_status` STRING COMMENT 'Result of the most recent review of the submitted evidence.. Valid values are `under_review|approved|rejected|needs_resubmission`',
    `reviewer_comments` STRING COMMENT 'Comments provided by the LEED reviewer.',
    `submission_method` STRING COMMENT 'Method used to submit evidence for the credit.. Valid values are `digital|paper|email`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the credit record.',
    CONSTRAINT pk_leed_credit PRIMARY KEY(`leed_credit_id`)
) COMMENT 'Tracks individual LEED credit categories and specific credits being pursued within a LEED certification effort. Records credit category (e.g., Energy & Atmosphere, Water Efficiency, Indoor Environmental Quality), credit name, points available, points targeted, evidence submitted, review status, points awarded, and reviewer comments. Enables granular tracking of LEED scorecard progress.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` (
    `regulatory_submission_id` BIGINT COMMENT 'System-generated unique identifier for the regulatory submission record.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the person or organization that prepared the submission.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Regulatory Incident Reporting: each safety incident triggers a regulatory submission record filed with authorities.',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Regulatory submissions are made to a specific authority; adding regulatory_authority_id captures this relationship and allows removal of duplicated authority fields.',
    `agreement_id` BIGINT COMMENT 'Identifier of the contract associated with the submission.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project to which the submission relates.',
    `acknowledgement_date` TIMESTAMP COMMENT 'Timestamp of the acknowledgement receipt, if any.',
    `acknowledgement_received` BOOLEAN COMMENT 'Indicates whether an acknowledgement was received from the regulator.',
    `attachment_flag` BOOLEAN COMMENT 'True if any supporting documents are attached.',
    `compliance_category` STRING COMMENT 'High‑level compliance domain the submission addresses.. Valid values are `environmental|safety|quality|financial|privacy`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the submission record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the fee amount.',
    `document_count` STRING COMMENT 'Number of supporting documents attached to the submission.',
    `external_reference_number` STRING COMMENT 'Reference number assigned by the regulatory body.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee charged by the regulatory body for processing the submission.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the submission contains confidential information.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified the record.',
    `regulatory_submission_status` STRING COMMENT 'Current lifecycle status of the submission.. Valid values are `draft|submitted|acknowledged|rejected|approved|closed`',
    `reporting_period_end` DATE COMMENT 'Last day of the period covered by the submission.',
    `reporting_period_start` DATE COMMENT 'First day of the period covered by the submission.',
    `status_reason` STRING COMMENT 'Free‑text explanation for the current status, e.g., reason for rejection.',
    `submission_date` TIMESTAMP COMMENT 'Timestamp when the submission was sent to the regulatory body.',
    `submission_description` STRING COMMENT 'Narrative description of the submission content.',
    `submission_method` STRING COMMENT 'Channel used to deliver the submission.. Valid values are `electronic|paper|portal|email`',
    `submission_notes` STRING COMMENT 'Additional free‑form notes captured at submission time.',
    `submission_number` STRING COMMENT 'External reference number assigned to the submission by the originating system.',
    `submission_type` STRING COMMENT 'Category of regulatory filing, such as annual report or incident notification.. Valid values are `annual_report|incident_notification|permit_renewal|compliance_certificate|other`',
    `submitter_role` STRING COMMENT 'Role of the submitter within the project organization.. Valid values are `contractor|subcontractor|project_manager|safety_officer|engineer`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the submission record.',
    `version_number` STRING COMMENT 'Incremental version for optimistic concurrency control.',
    CONSTRAINT pk_regulatory_submission PRIMARY KEY(`regulatory_submission_id`)
) COMMENT 'Transactional record of formal regulatory submissions made to governing bodies including OSHA, EPA, local building authorities, and environmental agencies. Captures submission type (annual report, incident notification, permit renewal, compliance certificate), submission date, regulatory body, submission reference number, reporting period, submission method, acknowledgement received, and submission status. Serves as the SSOT for all outbound regulatory filings.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` (
    `regulatory_obligation_id` BIGINT COMMENT 'Unique identifier for the regulatory obligation record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Regulatory reporting tracks which client accounts are subject to each obligation, enabling account‑level compliance dashboards.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Obligation‑related expenses are allocated to a cost center, supporting cost‑center level compliance cost analysis.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Regulatory obligations are assigned to subcontractors; the FK tracks which firm must satisfy each obligation.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Penalties or costs arising from obligations are posted to a GL account for accurate financial impact tracking.',
    `hr_org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Assigns each regulatory obligation to a specific organizational unit for accountability and reporting in compliance governance.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the internal party responsible for ensuring compliance.',
    `agreement_id` BIGINT COMMENT 'Identifier of the contract or agreement that references this regulatory obligation.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project to which this regulatory obligation is linked.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Obligations are assigned to specific vendors; linking allows monitoring vendor compliance with regulatory requirements.',
    `compliance_evidence_status` STRING COMMENT 'Current status of the compliance evidence submission.. Valid values are `submitted|approved|rejected|not_started`',
    `compliance_status` STRING COMMENT 'Current compliance status of the obligation.. Valid values are `compliant|non_compliant|pending|exempt|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the obligation record was created in the system.',
    `data_classification` STRING COMMENT 'Classification level of the obligation data per organizational policy.. Valid values are `public|internal|confidential|restricted`',
    `effective_date` DATE COMMENT 'Date when the obligation becomes effective.',
    `evidence_required` STRING COMMENT 'Description of documentation or evidence needed to demonstrate compliance.',
    `expiration_date` DATE COMMENT 'Date when the obligation expires or is no longer applicable, if applicable.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the obligation is currently active (true) or retired (false).',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether compliance with the obligation is mandatory (true) or optional (false).',
    `jurisdiction` STRING COMMENT 'Geographic jurisdiction (country or region) where the obligation applies.',
    `last_review_date` DATE COMMENT 'Date when the obligation was last reviewed for compliance.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next compliance review.',
    `notes` STRING COMMENT 'Free-text field for additional comments or observations about the obligation.',
    `obligation_code` STRING COMMENT 'External reference code or number assigned by the regulatory body or contract.',
    `obligation_title` STRING COMMENT 'Short descriptive title of the regulatory requirement.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount for non-compliance, if applicable.',
    `penalty_currency` STRING COMMENT 'Currency of the penalty amount.. Valid values are `USD|EUR|GBP|CAD|AUD`',
    `penalty_type` STRING COMMENT 'Type of penalty associated with the obligation.. Valid values are `fine|stop_work|license_revocation|other`',
    `regulatory_body` STRING COMMENT 'Governing authority or standard that issued the obligation.. Valid values are `OSHA|EPA|ISO|FIDIC|GDPR|PCI_DSS`',
    `review_frequency_months` STRING COMMENT 'Number of months between mandatory compliance reviews.',
    `risk_level` STRING COMMENT 'Risk level associated with non-compliance of the obligation.. Valid values are `low|medium|high|critical`',
    `scope_business_units` STRING COMMENT 'Business units or divisions affected by the obligation.',
    `scope_projects` STRING COMMENT 'Comma-separated list of project identifiers to which the obligation applies.',
    `source_document_reference` STRING COMMENT 'Reference to the original legal or contractual document that defines the obligation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the obligation record.',
    CONSTRAINT pk_regulatory_obligation PRIMARY KEY(`regulatory_obligation_id`)
) COMMENT 'Master register of all regulatory obligations applicable to the organization and its construction projects, derived from applicable laws, standards, permits, and contractual requirements. Captures obligation source (OSHA 29 CFR, EPA Clean Water Act, IBC/IRC, ISO 45001, GDPR, PCI DSS, FIDIC, local building codes), obligation description, applicable jurisdiction, effective date, review frequency, responsible owner, compliance evidence required, current compliance status, and organizational scope mapping (projects, business units, jurisdictions). Serves as the single compliance obligation inventory underpinning all compliance activities, assessments, calendar deadlines, and regulatory change impact analysis.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`compliance`.`assessment` (
    `assessment_id` BIGINT COMMENT 'System-generated unique identifier for the compliance assessment record.',
    `audit_report_id` BIGINT COMMENT 'Identifier of the detailed audit report linked to this assessment.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which the assessment applies.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the employee or consultant who performed the assessment.',
    `assessment_date` DATE COMMENT 'Date on which the compliance assessment was conducted.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the assessment.. Valid values are `draft|in_progress|completed|approved|rejected`',
    `assessment_type` STRING COMMENT 'Type of compliance assessment performed.. Valid values are `regulatory|internal|external|audit`',
    `assessor_name` STRING COMMENT 'Full legal name of the assessor.',
    `attachment_count` STRING COMMENT 'Number of supporting documents attached to the assessment.',
    `audit_trail_notes` STRING COMMENT 'Free‑form notes capturing audit trail information.',
    `assessment_code` STRING COMMENT 'Human‑readable code assigned to the assessment (e.g., CA‑2023‑001).',
    `compliance_category` STRING COMMENT 'Primary category of compliance (e.g., environmental, safety).. Valid values are `environment|safety|quality|financial|privacy`',
    `compliance_rating` STRING COMMENT 'Overall compliance result based on the assessment.. Valid values are `compliant|non_compliant|partial|not_applicable`',
    `compliance_status_overall` STRING COMMENT 'Aggregated compliance status across all obligations.. Valid values are `compliant|non_compliant|partial`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assessment record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for any monetary values.. Valid values are `[A-Z]{3}`',
    `document_reference` STRING COMMENT 'Reference identifier for supporting documentation (e.g., file ID).',
    `external_audit_firm` STRING COMMENT 'Name of the external firm that conducted the audit.',
    `findings_summary` STRING COMMENT 'High‑level summary of key findings from the assessment.',
    `gaps_identified` STRING COMMENT 'Specific compliance gaps or deficiencies discovered.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the assessment result is considered critical for the project.',
    `is_external_audit` BOOLEAN COMMENT 'True if the assessment was performed by an external auditor.',
    `jurisdiction` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code of the jurisdiction.. Valid values are `[A-Z]{3}`',
    `last_reviewed_by` BIGINT COMMENT 'Identifier of the party who performed the most recent review of the assessment.',
    `last_reviewed_date` DATE COMMENT 'Date of the most recent review.',
    `mitigation_plan` STRING COMMENT 'Planned actions to mitigate identified compliance risks.',
    `next_assessment_due_date` DATE COMMENT 'Planned date for the subsequent compliance assessment.',
    `obligations_assessed` STRING COMMENT 'List or description of regulatory obligations evaluated during the assessment.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty assessed for non‑compliance, if applicable.',
    `project_name` STRING COMMENT 'Human‑readable name of the project.',
    `rating_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing the degree of compliance.',
    `recommended_actions` STRING COMMENT 'Suggested remediation steps to close identified gaps.',
    `regulatory_body` STRING COMMENT 'Regulatory authority or standard governing the assessment.. Valid values are `OSHA|EPA|ISO_9001|ISO_14001|ISO_45001|LEED`',
    `risk_level` STRING COMMENT 'Risk classification associated with the assessment findings.. Valid values are `low|medium|high|critical`',
    `scope_description` STRING COMMENT 'Narrative describing the scope and boundaries of the compliance assessment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assessment record.',
    CONSTRAINT pk_assessment PRIMARY KEY(`assessment_id`)
) COMMENT 'Periodic compliance assessment records evaluating the organizations or a projects adherence to regulatory obligations, internal policies, and permit conditions. Captures assessment date, scope, assessor, obligations assessed, findings, compliance rating, gaps identified, and recommended actions. Distinct from quality NCRs (owned by quality domain) and safety audits (owned by safety domain) — this covers regulatory and legal compliance only.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`compliance`.`authority_notice` (
    `authority_notice_id` BIGINT COMMENT 'System-generated unique identifier for the authority notice record.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project affected by the notice.',
    `document_register_id` BIGINT COMMENT 'Reference to a stored document (e.g., scanned notice) linked to this record.',
    `appeal_date` DATE COMMENT 'Date on which the appeal was lodged.',
    `appeal_lodged_flag` BOOLEAN COMMENT 'Indicates whether an appeal against the notice has been filed.',
    `authority_notice_status` STRING COMMENT 'Current lifecycle status of the notice.. Valid values are `open|closed|appealed|resolved|dismissed`',
    `authority_type` STRING COMMENT 'Classification of the issuing authority by jurisdiction level.. Valid values are `federal|state|local|private`',
    `compliance_category` STRING COMMENT 'High‑level category of the compliance issue.. Valid values are `safety|environment|building|financial`',
    `compliance_officer` STRING COMMENT 'Name of the internal officer responsible for managing the notice response.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the notice record was first captured in the system.',
    `issuing_authority` STRING COMMENT 'Name of the regulatory body that issued the notice (e.g., OSHA, EPA, local council).',
    `notes` STRING COMMENT 'Free-text field for any supplemental information or comments.',
    `notice_date` TIMESTAMP COMMENT 'Date and time when the regulatory authority issued the notice.',
    `notice_number` STRING COMMENT 'External reference number assigned by the issuing authority to the notice.',
    `notice_type` STRING COMMENT 'Category of the notice describing its nature.. Valid values are `infringement|improvement|prohibition|stop_work|directive`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty imposed by the authority, if any.',
    `penalty_currency` STRING COMMENT 'Three‑letter ISO currency code for the penalty amount.',
    `penalty_due_date` DATE COMMENT 'Date by which the penalty must be paid.',
    `regulation_breached` STRING COMMENT 'Specific regulation, code, or standard that was violated.',
    `remediation_required` STRING COMMENT 'Actions required by the authority to remediate the violation.',
    `resolution_date` DATE COMMENT 'Date on which the notice was formally resolved.',
    `resolution_outcome` STRING COMMENT 'Final outcome after the notice was addressed.. Valid values are `complied|non_complied|settled|dismissed`',
    `response_deadline` DATE COMMENT 'Date by which a formal response to the notice must be submitted.',
    `response_submitted_date` DATE COMMENT 'Date on which the response was submitted.',
    `response_submitted_flag` BOOLEAN COMMENT 'Indicates whether a response has been submitted to the authority.',
    `severity_level` STRING COMMENT 'Risk severity assigned to the notice by the authority.. Valid values are `low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the notice record.',
    `violation_description` STRING COMMENT 'Detailed description of the regulatory violation cited in the notice.',
    CONSTRAINT pk_authority_notice PRIMARY KEY(`authority_notice_id`)
) COMMENT 'Records formal notices, orders, infringement notices, improvement notices, prohibition notices, stop-work orders, and directives received from regulatory authorities including OSHA, EPA, local councils, fire marshals, and building inspectors. Captures notice type, severity level, issuing authority, notice date, project or site affected, violation described, applicable regulation breached, required remediation, response deadline, response submitted, appeal lodged flag, and resolution outcome. Critical for legal risk management, regulatory relationship tracking, and insurance notification obligations.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` (
    `privacy_obligation_id` BIGINT COMMENT 'System-generated unique identifier for the privacy obligation record.',
    `privacy_incident_id` BIGINT COMMENT 'Reference to the associated breach incident record.',
    `breach_date` DATE COMMENT 'Date on which the personal data breach occurred.',
    `breach_discovery_method` STRING COMMENT 'How the breach was discovered.. Valid values are `internal_audit|employee_report|customer_report|monitoring|other`',
    `breach_type` STRING COMMENT 'Classification of the breach incident.. Valid values are `unauthorized_access|loss|theft|disclosure|other`',
    `consent_date` DATE COMMENT 'Date when consent was obtained.',
    `consent_method` STRING COMMENT 'Method by which consent was obtained.. Valid values are `written|electronic|verbal|online_form`',
    `consent_required` BOOLEAN COMMENT 'True if explicit consent is required for the processing activity.',
    `consent_status` STRING COMMENT 'Current status of consent for the data subject.. Valid values are `given|withdrawn|not_applicable`',
    `consent_version` STRING COMMENT 'Version identifier of the consent form or policy.',
    `consent_withdrawal_date` DATE COMMENT 'Date when the data subject withdrew consent, if applicable.',
    `cross_border_countries` STRING COMMENT 'Comma‑separated list of ISO‑3 country codes where data is transferred. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|DEU|FRA|... — promote to reference product]',
    `cross_border_transfer` BOOLEAN COMMENT 'Indicates whether the personal data is transferred outside the EU/EEA.',
    `data_category` STRING COMMENT 'Classification of the personal data (e.g., personal, special category, pseudonymised).',
    `data_controller` STRING COMMENT 'Internal department or entity responsible for determining the purposes of processing.',
    `data_processor` STRING COMMENT 'External party that processes personal data on behalf of the controller.',
    `data_subject_category` STRING COMMENT 'Classification of the individuals whose personal data is covered (e.g., employee, subcontractor worker, client contact).. Valid values are `employee|subcontractor|client_contact|vendor|other`',
    `effective_date` DATE COMMENT 'Date when the privacy obligation becomes effective.',
    `expiry_date` DATE COMMENT 'Date when the privacy obligation expires or is no longer applicable (null if open‑ended).',
    `individuals_notified` BOOLEAN COMMENT 'True if affected data subjects were notified.',
    `last_review_date` DATE COMMENT 'Date when the obligation was last reviewed for compliance.',
    `legal_basis` STRING COMMENT 'Lawful basis for processing personal data as defined by GDPR.. Valid values are `consent|contract|legal_obligation|vital_interests|public_task|legitimate_interests`',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information related to the privacy obligation.',
    `notification_date` DATE COMMENT 'Date on which notifications were sent to authorities or individuals.',
    `notification_obligation_triggered` BOOLEAN COMMENT 'True if the 72‑hour breach notification obligation was triggered.',
    `obligation_code` STRING COMMENT 'External reference code or number assigned to the privacy obligation for tracking and reporting.',
    `obligation_type` STRING COMMENT 'Category of the privacy obligation, such as consent management, data retention, breach handling, legal basis documentation, cross‑border transfer, or other.. Valid values are `consent|retention|breach|legal_basis|cross_border|other`',
    `privacy_obligation_status` STRING COMMENT 'Current lifecycle status of the obligation.. Valid values are `active|inactive|revoked|expired`',
    `processing_purpose` STRING COMMENT 'Business purpose for which the personal data is processed under this obligation.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the privacy obligation record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the privacy obligation record.',
    `remediation_action` STRING COMMENT 'Description of corrective actions taken after the breach.',
    `retention_period_days` STRING COMMENT 'Number of days personal data must be retained before deletion or anonymisation.',
    `supervisory_authority_name` STRING COMMENT 'Name of the supervisory authority that was notified.',
    `supervisory_authority_notified` BOOLEAN COMMENT 'Indicates whether the relevant supervisory authority was notified.',
    CONSTRAINT pk_privacy_obligation PRIMARY KEY(`privacy_obligation_id`)
) COMMENT 'Master register of GDPR and privacy obligations for the organizations processing of construction workforce and client personal data, with integrated consent management and incident tracking. Captures data subject categories (employee, subcontractor worker, client contact), processing purposes, legal basis, data retention periods, cross-border transfer requirements. Manages consent records (data subject, consent purpose, date, method, version, withdrawal, processing activities covered) and privacy incident/breach records (incident date, breach type, data subjects affected, categories of personal data involved, discovery method, notification obligations triggered, supervisory authority notification, affected individuals notified, remediation actions). Supports GDPR Article 30 Records of Processing Activities (RoPA), 72-hour breach notification obligations, lawful basis documentation, and consent management for construction workforce data processing.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` (
    `privacy_incident_id` BIGINT COMMENT 'Unique identifier for the privacy incident record.',
    `construction_project_id` BIGINT COMMENT 'Foreign key linking to project.construction_project. Business justification: Privacy Incident Management records the project where the incident occurred for reporting and remediation.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the employee who reported the incident.',
    `breach_severity` STRING COMMENT 'Severity rating of the privacy incident.. Valid values are `low|medium|high|critical`',
    `breach_type` STRING COMMENT 'Nature of the privacy breach.. Valid values are `unauthorized_access|loss|theft|disclosure|malware|phishing`',
    `corrective_action_plan` STRING COMMENT 'Planned actions to prevent recurrence.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for the estimated fine.. Valid values are `^[A-Z]{3}$`',
    `data_category` STRING COMMENT 'Category of personal data involved in the breach.. Valid values are `personal_identifiable|financial|health|employment|contact|location`',
    `data_retention_action` STRING COMMENT 'Action taken regarding retained data after the breach.. Valid values are `deleted|anonymized|archived|retained`',
    `data_subject_name` STRING COMMENT 'Full legal name of the affected individual.',
    `data_subject_reference` BIGINT COMMENT 'Internal identifier of the affected data subject.',
    `data_subject_type` STRING COMMENT 'Classification of the individual whose personal data was affected.. Valid values are `employee|client|subcontractor|vendor|visitor`',
    `data_volume_bytes` BIGINT COMMENT 'Total size in bytes of the data affected.',
    `data_volume_records` BIGINT COMMENT 'Number of individual records affected by the breach.',
    `discovery_method` STRING COMMENT 'How the privacy incident was discovered.. Valid values are `internal_audit|employee_report|customer_report|system_alert|regulatory_notice|third_party`',
    `estimated_fine_amount` DECIMAL(18,2) COMMENT 'Estimated monetary penalty or fine associated with the breach.',
    `impact_assessment` STRING COMMENT 'Assessment of business and regulatory impact resulting from the breach.',
    `incident_closure_date` DATE COMMENT 'Date when the incident was formally closed.',
    `incident_description` STRING COMMENT 'Narrative description of the privacy incident.',
    `incident_number` STRING COMMENT 'External reference number assigned to the privacy incident.',
    `incident_timestamp` TIMESTAMP COMMENT 'Exact date and time when the privacy breach occurred or was discovered.',
    `individuals_notified_flag` BOOLEAN COMMENT 'True if affected individuals were notified.',
    `legal_hold_flag` BOOLEAN COMMENT 'True if the incident is under legal hold.',
    `notification_date` DATE COMMENT 'Date when affected individuals were notified.',
    `notification_obligation_triggered` BOOLEAN COMMENT 'Indicates whether regulatory notification obligations (e.g., GDPR 72‑hour rule) were triggered.',
    `privacy_incident_status` STRING COMMENT 'Current lifecycle status of the privacy incident.. Valid values are `open|investigating|resolved|closed|rejected`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the incident record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the incident record.',
    `regulatory_report_submission_date` DATE COMMENT 'Date the regulatory report was submitted.',
    `regulatory_report_submitted` BOOLEAN COMMENT 'Indicates whether a formal regulatory report has been filed.',
    `remediation_action` STRING COMMENT 'Description of actions taken to remediate the breach.',
    `remediation_status` STRING COMMENT 'Current status of the remediation effort.. Valid values are `planned|in_progress|completed|failed`',
    `reported_by_name` STRING COMMENT 'Full name of the employee who reported the incident.',
    `risk_assessment_score` STRING COMMENT 'Numeric risk score (0‑100) assigned after assessment.',
    `root_cause` STRING COMMENT 'Root cause analysis of why the breach occurred.',
    `supervisory_authority_notified_date` DATE COMMENT 'Date the supervisory authority was notified, if applicable.',
    CONSTRAINT pk_privacy_incident PRIMARY KEY(`privacy_incident_id`)
) COMMENT 'Transactional record of personal data breaches, privacy incidents, and unauthorized disclosures involving workforce or client data. Captures incident date, data subjects affected, categories of personal data involved, breach type, discovery method, notification obligations triggered, supervisory authority notification date, affected individuals notified flag, and remediation actions taken. Supports GDPR 72-hour breach notification obligations.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`compliance`.`consent_record` (
    `consent_record_id` BIGINT COMMENT 'System-generated unique identifier for the consent record.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key to hr.hr.employee_id',
    `privacy_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_obligation. Business justification: Consent records are tied to a privacy obligation; adding privacy_obligation_id links consent to its governing obligation.',
    `consent_category` STRING COMMENT 'High‑level classification of the consent (e.g., personal data, marketing, analytics).. Valid values are `personal_data|marketing|analytics|third_party_sharing|health_safety|financial`',
    `consent_method` STRING COMMENT 'How the consent was obtained (written, electronic, or verbal).. Valid values are `written|electronic|verbal`',
    `consent_record_status` STRING COMMENT 'Current lifecycle status of the consent record.. Valid values are `active|revoked|expired|withdrawn`',
    `consent_reference` STRING COMMENT 'Business-visible reference code for the consent record, used in audits and communications.',
    `consent_timestamp` TIMESTAMP COMMENT 'Exact date and time when the consent was obtained.',
    `consent_version` STRING COMMENT 'Version identifier of the consent form or policy at the time of capture.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consent record was first created in the system.',
    `data_subject_reference` BIGINT COMMENT 'Internal identifier of the person or entity providing consent.',
    `data_subject_type` STRING COMMENT 'Category of the data subject (e.g., employee, subcontractor, client contact).. Valid values are `employee|subcontractor|client|other`',
    `effective_from` DATE COMMENT 'Date when the consent becomes effective for processing activities.',
    `effective_until` DATE COMMENT 'Optional expiry date of the consent; null if consent is open‑ended.',
    `jurisdiction` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code indicating the legal jurisdiction governing the consent.. Valid values are `^[A-Z]{3}$`',
    `legal_basis` STRING COMMENT 'Lawful basis under GDPR or other regulations supporting the processing.. Valid values are `consent|contract|legal_obligation|vital_interests|public_task|legitimate_interests`',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the consent.',
    `processing_activities` STRING COMMENT 'List or description of processing activities (e.g., HR payroll, project reporting) covered by the consent.',
    `purpose` STRING COMMENT 'Specific business purpose(s) for which the data subjects personal data may be processed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the consent record.',
    `withdrawal_timestamp` TIMESTAMP COMMENT 'Timestamp when the data subject withdrew consent, if applicable.',
    CONSTRAINT pk_consent_record PRIMARY KEY(`consent_record_id`)
) COMMENT 'Records explicit consent obtained from data subjects (employees, subcontractor workers, client contacts) for specific personal data processing activities. Captures data subject reference, consent purpose, consent date, consent method (written, electronic, verbal), consent version, withdrawal date if applicable, and processing activities covered. Supports GDPR lawful basis documentation and consent management obligations.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`compliance`.`pci_control` (
    `pci_control_id` BIGINT COMMENT 'Unique identifier for the PCI DSS control record.',
    `construction_project_id` BIGINT COMMENT 'Foreign key linking to project.construction_project. Business justification: PCI Control compliance tracking associates each control with the construction project handling sensitive data.',
    `pci_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.pci_assessment. Business justification: PCI controls are evaluated within a PCI assessment; linking each control to its assessment provides traceability and removes the silo.',
    `assessment_document_reference` STRING COMMENT 'Reference identifier for the ROC, AOC, or other assessment documentation.',
    `assessment_method` STRING COMMENT 'Method used for the most recent assessment.. Valid values are `self_assessment|qsa_audit|penetration_test`',
    `assessment_result` STRING COMMENT 'Outcome of the most recent assessment.. Valid values are `pass|fail|partial`',
    `assessment_version` STRING COMMENT 'Version of the PCI DSS standard against which the control was assessed (e.g., v4.0).',
    `assessor_contact` STRING COMMENT 'Email address of the assessor for follow‑up.',
    `assessor_name` STRING COMMENT 'Name of the person or organization that performed the latest assessment.',
    `compliance_level` STRING COMMENT 'Overall compliance level derived from assessments.. Valid values are `compliant|partial|non_compliant`',
    `compliance_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing compliance maturity.',
    `control_audit_trail` STRING COMMENT 'Append‑only log of changes to the control record for audit purposes.',
    `control_category` STRING COMMENT 'High‑level category grouping the control (e.g., Access Control, Monitoring).',
    `control_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the control record was first created in the system.',
    `control_description` STRING COMMENT 'Full textual description of what the control addresses and how it is applied.',
    `control_family` STRING COMMENT 'One of the six PCI DSS control families to which this control belongs.. Valid values are `Build and Maintain Secure Network|Protect Cardholder Data|Maintain Vulnerability Management Program|Implement Strong Access Control Measures|Regularly Monitor and Test Networks|Maintain an Information Security Policy`',
    `control_frequency` STRING COMMENT 'How often the control is expected to be performed or verified.. Valid values are `continuous|annual|quarterly|monthly`',
    `control_identifier` STRING COMMENT 'Unique code or number identifying the PCI DSS control (e.g., 1.1, 2.3.4).',
    `control_last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the last formal review of the control.',
    `control_name` STRING COMMENT 'Descriptive name of the PCI DSS control.',
    `control_owner` STRING COMMENT 'Name of the individual or team responsible for the controls implementation and upkeep.',
    `control_priority` STRING COMMENT 'Priority level (1‑5) for remediation or review, with 1 being highest.',
    `control_requirement_reference` STRING COMMENT 'Reference to the specific PCI DSS requirement number (e.g., Req 1.2.3).',
    `control_retirement_date` DATE COMMENT 'Date when the control was retired or superseded.',
    `control_risk_rating` STRING COMMENT 'Risk rating assigned to the control based on impact and likelihood.. Valid values are `high|medium|low`',
    `control_source` STRING COMMENT 'Indicates whether the control originates from internal policy or external regulation.. Valid values are `internal|external`',
    `control_status` STRING COMMENT 'Current lifecycle status of the control.. Valid values are `active|inactive|retired`',
    `control_tags` STRING COMMENT 'Comma‑separated list of user‑defined tags for categorization and search.',
    `control_testing_frequency` STRING COMMENT 'Frequency at which the control is tested for effectiveness.. Valid values are `continuous|annual|quarterly|monthly`',
    `control_type` STRING COMMENT 'Indicates whether the control is technical, procedural, or administrative.. Valid values are `technical|procedural|administrative`',
    `control_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the control record.',
    `control_version` STRING COMMENT 'Version identifier for the control definition (e.g., 1.0, 2.1).',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_from` DATE COMMENT 'Date when the control became effective.',
    `effective_until` DATE COMMENT 'Date when the control expires or is superseded (nullable).',
    `evidence_location` STRING COMMENT 'Path or URL where supporting evidence for the control is stored.',
    `findings_summary` STRING COMMENT 'Summary of key findings from the latest assessment.',
    `implementation_status` STRING COMMENT 'Indicates whether the control has been fully implemented, is planned, or not implemented.. Valid values are `implemented|planned|not_implemented`',
    `last_assessment_date` DATE COMMENT 'Date of the most recent assessment of this control.',
    `next_assessment_due` DATE COMMENT 'Planned date for the next assessment of this control.',
    `related_systems` STRING COMMENT 'Comma‑separated list of systems or applications in scope for this control.',
    `remediation_due_date` DATE COMMENT 'Target date for completing remediation actions.',
    `remediation_plan` STRING COMMENT 'Textual description of the remediation steps and responsibilities.',
    `remediation_status` STRING COMMENT 'Current status of any remediation activities for the control.. Valid values are `open|in_progress|completed|deferred`',
    `scope` STRING COMMENT 'Indicates whether the control applies to the cardholder data environment.. Valid values are `in_scope|out_of_scope`',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_pci_control PRIMARY KEY(`pci_control_id`)
) COMMENT 'Master register of PCI DSS (Payment Card Industry Data Security Standard) controls and assessment history for the organizations project payment processing systems, subcontractor payment portals, and client billing platforms. Captures PCI DSS requirement reference, control description, control owner, applicable system or process, implementation status, and full assessment history including SAQ (Self-Assessment Questionnaire) completions, QSA (Qualified Security Assessor) audits, penetration test results, assessment dates, assessors, PCI DSS version assessed against, cardholder data environment scope, findings, compliance level achieved, ROC (Report on Compliance), and AOC (Attestation of Compliance) references. Supports PCI DSS compliance program management for construction financial transaction security including progress payment systems and online payment portals.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` (
    `pci_assessment_id` BIGINT COMMENT 'Unique surrogate key for the PCI DSS assessment record.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which the assessment applies.',
    `hr_org_unit_id` BIGINT COMMENT 'Identifier of the legal entity (company) undergoing the PCI assessment.',
    `assessment_date` DATE COMMENT 'Date on which the PCI DSS assessment was conducted.',
    `assessment_number` STRING COMMENT 'External reference number assigned to the assessment by the organization.',
    `assessment_type` STRING COMMENT 'Type of PCI DSS assessment performed.. Valid values are `SAQ|QSA_Audit|PenTest`',
    `assessor_email` STRING COMMENT 'Email address of the assessor for follow‑up communication.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `assessor_name` STRING COMMENT 'Full legal name of the individual or entity performing the assessment.. Valid values are `^[A-Za-zs]+$`',
    `cardholder_data_scope` STRING COMMENT 'Indicates whether the cardholder data environment (CDE) is fully in scope, out of scope, or partially in scope for the assessment.. Valid values are `In_Scope|Out_of_Scope|Partial`',
    `compliance_cost` DECIMAL(18,2) COMMENT 'Monetary cost associated with performing the PCI DSS assessment.',
    `compliance_level` STRING COMMENT 'PCI DSS compliance level achieved (Level 1‑4) based on the assessment results.. Valid values are `Level1|Level2|Level3|Level4`',
    `control_failed` STRING COMMENT 'Count of controls that did not meet compliance requirements.',
    `control_passed` STRING COMMENT 'Count of controls that met compliance requirements.',
    `control_total` STRING COMMENT 'Number of PCI DSS controls evaluated in the assessment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assessment record was first created in the system.',
    `evidence_url` STRING COMMENT 'Link to supporting evidence files (e.g., screenshots, logs) stored in the document repository.',
    `exception_count` STRING COMMENT 'Number of documented exceptions or compensating controls.',
    `findings_summary` STRING COMMENT 'High‑level summary of compliance findings identified during the assessment.',
    `last_assessment_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent assessment activity (e.g., final sign‑off).',
    `notes` STRING COMMENT 'Free‑form notes captured by the assessor or compliance team.',
    `overall_status` STRING COMMENT 'Overall outcome of the assessment indicating full compliance, non‑compliance, or partial compliance.. Valid values are `Compliant|Non_Compliant|Partial`',
    `pci_assessment_status` STRING COMMENT 'Current lifecycle status of the assessment record.. Valid values are `Draft|In_Progress|Completed|Approved|Rejected`',
    `pci_version` STRING COMMENT 'Version of the PCI DSS standard against which the assessment was performed (e.g., 4.0).',
    `remediation_actions` STRING COMMENT 'Planned or executed remediation steps to address identified gaps.',
    `remediation_due_date` DATE COMMENT 'Target date by which remediation actions must be completed.',
    `report_reference` STRING COMMENT 'Identifier of the ROC or AOC document generated for the assessment.',
    `report_url` STRING COMMENT 'Link to the stored ROC/AOC document.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score (0‑100) derived from assessment findings.',
    `scope_description` STRING COMMENT 'Narrative description of the assessment scope, including systems, networks, and processes covered.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the assessment record.',
    CONSTRAINT pk_pci_assessment PRIMARY KEY(`pci_assessment_id`)
) COMMENT 'Transactional records of PCI DSS compliance assessments and Self-Assessment Questionnaires (SAQ) conducted for financial transaction processing environments. Captures assessment type (SAQ, QSA audit, penetration test), assessment date, assessor, PCI DSS version assessed against, scope of cardholder data environment, findings, compliance level achieved, and Report on Compliance (ROC) or Attestation of Compliance (AOC) reference.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`compliance`.`iso_certification` (
    `iso_certification_id` BIGINT COMMENT 'Unique surrogate key for each ISO certification record.',
    `construction_project_id` BIGINT COMMENT 'Foreign key linking to project.construction_project. Business justification: ISO Certification Management ties certifications to the specific construction project for audit scope.',
    `hr_org_unit_id` BIGINT COMMENT 'Identifier of the legal entity that holds the certification.',
    `audit_notes` STRING COMMENT 'Additional notes or comments from the audit team.',
    `audit_schedule_frequency` STRING COMMENT 'Frequency at which surveillance audits are required.. Valid values are `annual|biennial|triennial`',
    `certificate_number` STRING COMMENT 'Official number assigned by the certifying body to the certification.',
    `certification_type` STRING COMMENT 'ISO standard for which the organization is certified.. Valid values are `ISO 9001|ISO 14001|ISO 45001`',
    `certifying_body` STRING COMMENT 'Organization that issued the ISO certification.',
    `compliance_evidence_url` STRING COMMENT 'Link to supporting evidence (e.g., audit reports, corrective action plans).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification record was first created in the system.',
    `document_url` STRING COMMENT 'Link to the digital copy of the certification document.',
    `effective_from` DATE COMMENT 'Date when the certification becomes effective.',
    `effective_until` DATE COMMENT 'Date when the certification expires or is scheduled to end (null for open‑ended).',
    `expiry_date` DATE COMMENT 'Date the certificate is scheduled to expire.',
    `findings_count` STRING COMMENT 'Count of audit findings identified in the last audit.',
    `iso_certification_status` STRING COMMENT 'Current lifecycle status of the certification.. Valid values are `active|expired|pending_renewal|revoked|suspended`',
    `issue_date` DATE COMMENT 'Date the certificate was originally issued.',
    `jurisdiction` STRING COMMENT 'ISO‑3166‑1 alpha‑3 country code of the jurisdiction governing the certification.. Valid values are `USA|CAN|MEX|GBR|AUS`',
    `last_audit_date` DATE COMMENT 'Date of the most recent audit (internal, surveillance, or recertification).',
    `last_audit_outcome` STRING COMMENT 'Result of the most recent audit.. Valid values are `compliant|non_compliant|conditional`',
    `last_audit_type` STRING COMMENT 'Classification of the most recent audit.. Valid values are `internal|surveillance|recertification`',
    `next_surveillance_audit_date` DATE COMMENT 'Scheduled date for the next surveillance audit required by the standard.',
    `non_conformances_count` STRING COMMENT 'Count of non‑conformances raised during the last audit.',
    `notes` STRING COMMENT 'Free‑form field for any additional remarks.',
    `observations` STRING COMMENT 'Narrative observations recorded by the auditor.',
    `renewal_date` DATE COMMENT 'Target date for completing the renewal process.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether a renewal action is required before expiry.',
    `risk_level` STRING COMMENT 'Risk classification associated with the certification (e.g., impact of non‑compliance).. Valid values are `low|medium|high`',
    `scope` STRING COMMENT 'Description of the business processes, sites, or functions covered by the certification.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the certification record.',
    CONSTRAINT pk_iso_certification PRIMARY KEY(`iso_certification_id`)
) COMMENT 'Master record tracking ISO management system certifications held or pursued by the organization — ISO 9001 (Quality), ISO 14001 (Environmental), and ISO 45001 (OH&S) — with integrated audit history. Captures certification standard, certifying body, certificate number, scope of certification, initial certification date, current certificate expiry, surveillance audit schedule, and certification status. Manages full audit trail including internal audits, surveillance audits, and recertification audits with audit type, date, auditor/certification body, standard audited, scope, findings, non-conformances raised, observations, and audit outcome. Distinct from LEED certification (project-specific) — this covers organizational management system certifications and their ongoing maintenance through the complete audit lifecycle.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`compliance`.`iso_audit` (
    `iso_audit_id` BIGINT COMMENT 'System-generated unique identifier for the ISO audit record.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project associated with the audit.',
    `hr_employee_id` BIGINT COMMENT 'Unique identifier of the auditor in the master party registry.',
    `iso_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.iso_certification. Business justification: Each ISO audit evaluates a specific ISO certification. Adding iso_certification_id to iso_audit captures this relationship.',
    `regulatory_authority_id` BIGINT COMMENT 'Unique identifier of the certification body in the master party registry.',
    `audit_category` STRING COMMENT 'Category of the audit based on focus area.. Valid values are `management|process|product`',
    `audit_comments` STRING COMMENT 'Additional comments recorded by the auditor.',
    `audit_date` DATE COMMENT 'Date on which the audit was performed.',
    `audit_duration_hours` DECIMAL(18,2) COMMENT 'Total time spent on the audit, expressed in hours.',
    `audit_findings_url` STRING COMMENT 'Link to the detailed findings document.',
    `audit_location` STRING COMMENT 'Physical site or facility where the audit was performed.',
    `audit_method` STRING COMMENT 'Methodology used to conduct the audit.. Valid values are `on_site|remote|document_review`',
    `audit_number` STRING COMMENT 'External reference number assigned to the audit by the certification body.',
    `audit_outcome` STRING COMMENT 'Result of the audit: passed, failed, or conditional (requires corrective actions).. Valid values are `passed|failed|conditional`',
    `audit_reference_number` STRING COMMENT 'Reference number used by external parties (e.g., client or regulator).',
    `audit_report_url` STRING COMMENT 'Link to the stored audit report document.',
    `audit_scope_code` STRING COMMENT 'Standardized code representing the audit scope for reporting.',
    `audit_score` DECIMAL(18,2) COMMENT 'Numerical score assigned to the audit based on the scoring methodology.',
    `audit_score_scale` STRING COMMENT 'Scale used for the audit score (e.g., 0‑100 or 1‑5).. Valid values are `0-100|1-5`',
    `audit_source_system` STRING COMMENT 'Source system where the audit record originated (e.g., Procore, SAP).',
    `audit_team_size` STRING COMMENT 'Number of auditors and support staff involved.',
    `audit_type` STRING COMMENT 'Classification of the audit: internal, surveillance, or recertification.. Valid values are `internal|surveillance|recertification`',
    `audit_version` STRING COMMENT 'Version number of the audit record, incremented on revisions.',
    `auditor_name` STRING COMMENT 'Full legal name of the lead auditor or certification body representative.',
    `auditor_role` STRING COMMENT 'Role of the auditor in the audit team.. Valid values are `lead|assistant`',
    `certification_body` STRING COMMENT 'Name of the external certification organization conducting the audit.',
    `certification_body_contact` STRING COMMENT 'Primary contact information (email or phone) for the certification body.',
    `compliance_status` STRING COMMENT 'Overall compliance determination after the audit.. Valid values are `compliant|non_compliant|partial`',
    `corrective_action_due_date` DATE COMMENT 'Deadline by which all corrective actions must be completed.',
    `corrective_action_plan_url` STRING COMMENT 'Link to the corrective action plan associated with the audit.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective actions are required based on audit findings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was first created in the system.',
    `evidence_documents_count` STRING COMMENT 'Number of supporting evidence documents attached to the audit.',
    `findings_summary` STRING COMMENT 'High‑level summary of audit findings and observations.',
    `follow_up_audit_date` DATE COMMENT 'Planned date for the follow‑up audit, if any.',
    `follow_up_audit_scheduled_flag` BOOLEAN COMMENT 'Indicates whether a follow‑up audit has been scheduled.',
    `iso_audit_status` STRING COMMENT 'Current processing state of the audit record.. Valid values are `planned|in_progress|completed|closed`',
    `non_conformances_count` STRING COMMENT 'Number of non‑conformances identified during the audit.',
    `notes` STRING COMMENT 'Free‑form notes captured by the auditor or audit manager.',
    `observations_count` STRING COMMENT 'Number of observations (non‑critical findings) recorded.',
    `risk_level` STRING COMMENT 'Overall risk rating derived from audit findings.. Valid values are `low|medium|high`',
    `scope_description` STRING COMMENT 'Narrative description of the audit scope, including sites, processes, and functions covered.',
    `standard_audited` STRING COMMENT 'ISO management system standard that was audited.. Valid values are `ISO 9001|ISO 14001|ISO 45001`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the audit record.',
    CONSTRAINT pk_iso_audit PRIMARY KEY(`iso_audit_id`)
) COMMENT 'Transactional records of ISO management system surveillance audits, recertification audits, and internal audits conducted against ISO 9001, ISO 14001, and ISO 45001 standards. Captures audit type (internal, surveillance, recertification), audit date, auditor or certification body, standard audited, scope, findings, non-conformances raised, observations, and audit outcome. Supports ongoing ISO certification maintenance.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` (
    `regulatory_authority_id` BIGINT COMMENT 'Unique system-generated identifier for the regulatory authority.',
    `account_id` BIGINT COMMENT '',
    `abbreviation` STRING COMMENT 'Common short name or acronym of the authority.',
    `address` STRING COMMENT 'Physical mailing address of the authority.',
    `classification` STRING COMMENT 'Category type of the authority.. Valid values are `regulatory|environmental|safety|building|utility`',
    `compliance_status` STRING COMMENT 'Overall compliance status of the organization with respect to this authority.. Valid values are `compliant|non_compliant|under_review|not_applicable`',
    `contact_person` STRING COMMENT 'Name of the primary contact person at the authority.',
    `contact_role` STRING COMMENT 'Role of the primary contact person within the authority.. Valid values are `director|manager|officer|coordinator|representative`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the authority record was created in the system.',
    `effective_from` DATE COMMENT 'Date when the authority record became effective for use.',
    `effective_until` DATE COMMENT 'Date when the authority record is no longer effective, if applicable.',
    `email` STRING COMMENT 'Primary contact email address for the authority.',
    `geographic_scope` STRING COMMENT 'Geographic coverage of the authoritys regulatory reach.. Valid values are `global|national|state|city|county`',
    `is_primary` BOOLEAN COMMENT 'Indicates if this authority is the primary regulator for the organization.',
    `jurisdiction_type` STRING COMMENT 'Level of jurisdiction the authority operates under.. Valid values are `federal|state|local|regional|international`',
    `last_contact_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent communication with the authority.',
    `regulatory_authority_name` STRING COMMENT 'Official full name of the regulatory authority.',
    `notes` STRING COMMENT 'Free-text notes or comments about the authority.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the authority.',
    `portal_url` STRING COMMENT 'URL of the electronic portal used for submissions to the authority.',
    `regulatory_authority_status` STRING COMMENT 'Current operational status of the authority record.. Valid values are `active|inactive|suspended|pending`',
    `regulatory_frameworks` STRING COMMENT 'Comma-separated list of regulatory frameworks the authority enforces (e.g., OSHA, EPA, ISO 45001).',
    `relationship_owner` STRING COMMENT 'Internal department or owner responsible for managing the relationship with the authority.. Valid values are `compliance|legal|procurement|project_management|safety`',
    `submission_system` STRING COMMENT 'Name of the electronic submission system or platform used by the authority.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the authority record.',
    `website_url` STRING COMMENT 'Public website URL for the authority.',
    CONSTRAINT pk_regulatory_authority PRIMARY KEY(`regulatory_authority_id`)
) COMMENT 'Reference master of regulatory and governing bodies with whom the organization interacts, including OSHA, EPA, local building departments, environmental agencies, fire marshals, and utility authorities. Captures authority name, jurisdiction type, geographic scope, contact details, applicable regulatory frameworks, portal or submission system reference, and relationship owner. Enables consistent authority identification across permit applications, submissions, and notices.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` (
    `waiver_exemption_id` BIGINT COMMENT 'System-generated unique identifier for the waiver or exemption record.',
    `regulatory_permit_id` BIGINT COMMENT 'Identifier of a related permit that the waiver modifies or supersedes.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which the waiver applies.',
    `agreement_id` BIGINT COMMENT 'Identifier of a contract (e.g., EPC, JV) associated with the waiver.',
    `attached_document_count` STRING COMMENT 'Number of supporting documents linked to the waiver record.',
    `authority_code` STRING COMMENT 'Standard code or identifier for the granting authority (e.g., OSHA, EPA).',
    `compliance_evidence_url` STRING COMMENT 'Link to the repository where ongoing compliance evidence is stored.',
    `compliance_status` STRING COMMENT 'Indicates whether the organization is meeting the waiver’s conditions.. Valid values are `compliant|non_compliant|under_review`',
    `conditions_summary` STRING COMMENT 'Brief list of key conditions the organization must satisfy while the waiver is in effect.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center code used for financial tracking of the waiver.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the waiver record was first entered into the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for the financial impact estimate.. Valid values are `USD|CAD|EUR|GBP|AUD`',
    `effective_from` DATE COMMENT 'Date the waiver becomes legally effective.',
    `effective_until` DATE COMMENT 'Date the waiver expires or is scheduled to terminate (nullable for open‑ended waivers).',
    `evidence_url` STRING COMMENT 'Link to digital evidence demonstrating ongoing compliance with waiver conditions.',
    `financial_impact_estimate` DECIMAL(18,2) COMMENT 'Monetary estimate of the financial impact (savings or cost) resulting from the waiver.',
    `granting_authority` STRING COMMENT 'Name of the regulatory body or agency that issued the waiver.',
    `is_confidential` BOOLEAN COMMENT 'Indicates if the waiver contains confidential or commercially sensitive information.',
    `jurisdiction` STRING COMMENT 'Country or jurisdiction governing the waiver (ISO 3166‑1 alpha‑3 code).. Valid values are `USA|CAN|MEX|GBR|AUS`',
    `last_monitoring_date` DATE COMMENT 'Date of the most recent compliance monitoring activity.',
    `monitoring_frequency` STRING COMMENT 'How often the waiver’s conditions must be monitored or reported.. Valid values are `daily|weekly|monthly|quarterly|annually`',
    `monitoring_requirements` STRING COMMENT 'Detailed description of monitoring, reporting, or audit activities required to maintain compliance.',
    `next_monitoring_date` DATE COMMENT 'Planned date for the next required monitoring activity.',
    `notes` STRING COMMENT 'Additional comments or observations captured by compliance staff.',
    `regulation_section` STRING COMMENT 'Specific code or clause of the regulation that the waiver modifies (e.g., 40 CFR 60.10).',
    `renewal_date` DATE COMMENT 'Planned date for renewal submission, if renewal is required.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether the waiver must be renewed before its expiry.',
    `risk_level` STRING COMMENT 'Risk rating associated with the waiver based on condition severity and exposure.. Valid values are `low|medium|high|critical`',
    `scope_description` STRING COMMENT 'Narrative describing the activities, locations, or systems covered by the waiver.',
    `status_reason` STRING COMMENT 'Explanation for the current status (e.g., reason for revocation).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the waiver record.',
    `waiver_category` STRING COMMENT 'Indicates whether the waiver is temporary, permanent, or conditional on specific actions.. Valid values are `temporary|permanent|conditional`',
    `waiver_exemption_status` STRING COMMENT 'Current lifecycle state of the waiver.. Valid values are `active|inactive|pending|revoked|expired`',
    `waiver_number` STRING COMMENT 'Business-visible reference number assigned by the granting authority.',
    `waiver_type` STRING COMMENT 'Category of the waiver indicating the regulatory domain it addresses.. Valid values are `regulatory|environmental|safety|financial|design`',
    `created_by` STRING COMMENT 'User identifier of the person who created the waiver record.',
    CONSTRAINT pk_waiver_exemption PRIMARY KEY(`waiver_exemption_id`)
) COMMENT 'Records regulatory waivers, exemptions, variances, and alternative compliance methods granted to the organization or specific projects by regulatory authorities, allowing deviation from standard regulatory requirements under defined conditions. Captures waiver type, granting authority, applicable regulation or code section, scope of exemption, conditions attached, monitoring requirements, effective date, expiry date, renewal status, and evidence of ongoing condition compliance. Critical for demonstrating authorized non-standard compliance positions during audits and for ensuring waiver conditions are actively monitored.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` (
    `regulatory_change_id` BIGINT COMMENT 'Unique identifier for the regulatory change record.',
    `construction_project_id` BIGINT COMMENT 'Foreign key linking to project.construction_project. Business justification: Regulatory Change Impact Assessment links each change to affected projects to update compliance plans.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the employee or owner responsible for overseeing implementation.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Regulatory changes can impact particular subcontractors; the FK records which firms must implement the change.',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Regulatory changes are issued by a governing authority; linking them records the source authority.',
    `superseded_regulatory_change_id` BIGINT COMMENT 'Self-referencing FK on regulatory_change (superseded_regulatory_change_id)',
    `affected_jurisdictions` STRING COMMENT 'ISO‑3166‑1 alpha‑3 country or region codes where the change applies (comma‑separated).',
    `affected_obligations` STRING COMMENT 'List or description of specific compliance obligations impacted by the change.',
    `affected_projects` STRING COMMENT 'Identifiers of projects that are impacted by the regulatory change (comma‑separated).',
    `attached_document_count` STRING COMMENT 'Number of supporting documents attached to the regulatory change record.',
    `audit_trail_notes` STRING COMMENT 'Notes capturing audit trail information for compliance verification.',
    `change_authority` STRING COMMENT 'Specific agency or department that authorized the regulatory change.',
    `change_description` STRING COMMENT 'Detailed narrative describing the regulatory change and its provisions.',
    `change_number` STRING COMMENT 'Business identifier or reference number assigned to the regulatory change.',
    `change_review_status` STRING COMMENT 'Current review status of the regulatory change within internal governance.. Valid values are `pending|reviewed|approved|rejected`',
    `change_source` STRING COMMENT 'Origin of the regulatory change (e.g., Federal Register, State Agency).',
    `change_type` STRING COMMENT 'Type of regulatory change: new, amended, or repealed.. Valid values are `new|amended|repealed`',
    `classification` STRING COMMENT 'Broad category of the regulatory change (e.g., environmental, safety, building code).. Valid values are `environmental|safety|building_code|financial|labor|privacy`',
    `compliance_category` STRING COMMENT 'Higher‑level category grouping the change (e.g., regulatory, policy, standard).',
    `compliance_evidence_url` STRING COMMENT 'Link to external evidence or documentation proving compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory change record was created in the system.',
    `effective_date` DATE COMMENT 'Date the regulatory change becomes effective and enforceable.',
    `expiration_date` DATE COMMENT 'Date the regulatory change expires or is superseded, if applicable.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated monetary impact of the regulatory change on the organization.',
    `financial_impact_currency` STRING COMMENT 'Three‑letter ISO currency code for the financial impact amount (e.g., USD).',
    `impact_summary` STRING COMMENT 'High‑level summary of the business impact caused by the regulatory change.',
    `implementation_deadline` DATE COMMENT 'Target date by which the organization must implement the regulatory change.',
    `implementation_status` STRING COMMENT 'Current progress of implementing the regulatory change.. Valid values are `not_started|partial|completed|failed`',
    `implementation_status_date` DATE COMMENT 'Date when the implementation status was last updated.',
    `is_active` BOOLEAN COMMENT 'Flag indicating if the regulatory change is currently active in the system.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether compliance with the change is mandatory (true) or optional (false).',
    `jurisdiction_type` STRING COMMENT 'Level of jurisdiction for the change (federal, state, local).',
    `notes` STRING COMMENT 'Free‑form notes or comments about the regulatory change.',
    `publication_date` DATE COMMENT 'Date the regulatory change was officially published.',
    `regulation_code` STRING COMMENT 'Official code or identifier of the regulation affected by the change (e.g., IBC-2023-01).',
    `regulatory_body` STRING COMMENT 'Governing authority that issued the regulation (e.g., OSHA, EPA).',
    `regulatory_change_status` STRING COMMENT 'Current lifecycle status of the regulatory change within the organization.. Valid values are `pending|in_progress|implemented|deferred|rejected`',
    `required_actions` STRING COMMENT 'Specific actions the organization must take to comply with the change.',
    `review_date` DATE COMMENT 'Date when the regulatory change was last reviewed.',
    `risk_level` STRING COMMENT 'Risk rating assigned to the regulatory change based on impact and likelihood.. Valid values are `low|medium|high|critical`',
    `source_reference` STRING COMMENT 'Document or reference number linking to the original regulatory text.',
    `stakeholder_impact` STRING COMMENT 'Description of how key stakeholders (clients, subcontractors, regulators) are affected.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the regulatory change record.',
    `version_number` STRING COMMENT 'Sequential version number for the regulatory change record.',
    CONSTRAINT pk_regulatory_change PRIMARY KEY(`regulatory_change_id`)
) COMMENT 'Tracks changes to applicable laws, regulations, building codes, environmental standards, and safety requirements that affect the organizations compliance obligations across construction jurisdictions. Captures regulation reference, change type (new, amended, repealed), publication date, effective date, impact assessment summary, affected obligations, affected projects and jurisdictions, required actions, implementation deadline, implementation status, and responsible owner. Supports proactive compliance management as building codes (IBC/IRC), environmental regulations (EPA/Clean Water Act), OSHA safety standards, and local authority requirements evolve.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`compliance`.`finding` (
    `finding_id` BIGINT COMMENT 'Primary key for finding',
    `assessment_id` BIGINT COMMENT '',
    `construction_project_id` BIGINT COMMENT '',
    `hr_employee_id` BIGINT COMMENT 'Unique identifier of the auditor who logged the finding.',
    `source_finding_id` BIGINT COMMENT 'Self-referencing FK on finding (source_finding_id)',
    `compliance_status` STRING COMMENT 'Overall compliance determination for the finding.',
    `corrective_action` STRING COMMENT 'Planned or executed action taken to address the finding.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the finding record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for the impact amount.',
    `finding_description` STRING COMMENT 'Detailed narrative describing the issue, cause, and context.',
    `due_date` DATE COMMENT 'Target date for corrective action completion.',
    `finding_number` STRING COMMENT 'External reference number assigned to the finding.',
    `finding_status` STRING COMMENT 'Current processing state of the finding.',
    `finding_type` STRING COMMENT 'Category of the finding (e.g., safety, environmental).',
    `impact_amount` DECIMAL(18,2) COMMENT 'Estimated monetary impact of the finding.',
    `is_financial_related` BOOLEAN COMMENT 'Indicates whether the finding has financial implications.',
    `is_privacy_related` BOOLEAN COMMENT 'Indicates whether the finding involves privacy or data protection concerns.',
    `location_code` STRING COMMENT 'Code representing the site or facility where the finding originated.',
    `notes` STRING COMMENT 'Free‑form field for any extra information or comments.',
    `regulatory_reference` STRING COMMENT 'Identifier of the regulation, standard, or law applicable to the finding.',
    `reported_by` STRING COMMENT 'Name or identifier of the person who reported the finding.',
    `reported_date` DATE COMMENT 'Date the finding was initially reported.',
    `resolution_date` DATE COMMENT 'Date the finding was resolved or closed.',
    `risk_level` STRING COMMENT 'Risk classification based on severity and impact.',
    `severity_score` DECIMAL(18,2) COMMENT 'Numeric severity rating (0.00‑10.00) assigned by the auditor.',
    `source_record_reference` STRING COMMENT 'Identifier of the original record in the source system.',
    `title` STRING COMMENT 'Concise title summarizing the finding.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the finding record.',
    CONSTRAINT pk_finding PRIMARY KEY(`finding_id`)
) COMMENT 'Master reference table for finding. Referenced by source_finding_id.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`compliance`.`audit_report` (
    `audit_report_id` BIGINT COMMENT 'Primary key for audit_report',
    `parent_audit_report_id` BIGINT COMMENT 'Self-referencing FK on audit_report (parent_audit_report_id)',
    `approval_date` DATE COMMENT 'Date when the audit report was formally approved.',
    `attached_files_count` STRING COMMENT 'Number of supplemental files attached to the audit report.',
    `audit_period_end` DATE COMMENT 'End date of the period covered by the audit.',
    `audit_period_start` DATE COMMENT 'Start date of the period covered by the audit.',
    `audit_report_status` STRING COMMENT 'Current lifecycle status of the audit report.',
    `audit_scope` STRING COMMENT 'Narrative describing the scope and boundaries of the audit.',
    `auditor_email` STRING COMMENT 'Contact email of the primary auditor.',
    `auditor_name` STRING COMMENT 'Name of the primary auditor responsible for the report.',
    `compliance_status` STRING COMMENT 'Overall compliance status determined by the audit.',
    `confidentiality_level` STRING COMMENT 'Data classification level of the audit report content.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the audit report record was first created in the system.',
    `critical_findings_count` STRING COMMENT 'Number of findings classified as critical.',
    `document_path` STRING COMMENT 'File system or storage path to the full audit report document.',
    `findings_summary` STRING COMMENT 'High‑level summary of audit findings.',
    `noncritical_findings_count` STRING COMMENT 'Number of findings classified as non‑critical.',
    `overall_score` DECIMAL(18,2) COMMENT 'Numeric score summarizing audit performance (0‑100).',
    `remediation_due_date` DATE COMMENT 'Date by which identified issues must be remediated.',
    `report_name` STRING COMMENT 'Human‑readable name of the audit report.',
    `report_number` STRING COMMENT 'Unique business identifier assigned to the audit report.',
    `report_type` STRING COMMENT 'Category of audit performed.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned based on audit findings.',
    `total_findings` STRING COMMENT 'Total number of findings identified in the audit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the audit report record.',
    `version_number` STRING COMMENT 'Version identifier for the audit report when revisions occur.',
    CONSTRAINT pk_audit_report PRIMARY KEY(`audit_report_id`)
) COMMENT 'Master reference table for audit_report. Referenced by audit_report_id.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` (
    `regulatory_permit_id` BIGINT COMMENT 'Unique identifier for the permit.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Permit issuance requires linking each permit to the client company that holds it for reporting and compliance tracking.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project associated with the permit.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Permit tracking requires linking each permit to the responsible subcontractor firm for compliance monitoring.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Required for Permit Management process where a designated employee oversees permit issuance and compliance, enabling tracking of responsible staff.',
    `regulatory_authority_id` BIGINT COMMENT 'FK to compliance.regulatory_authority',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Required for Permit Management to record which vendor holds the permit, enabling compliance tracking of contractor responsibilities.',
    `compliance_evidence_url` STRING COMMENT 'Link to stored evidence satisfying permit conditions.',
    `compliance_permit_status` STRING COMMENT 'Current lifecycle status of the permit.. Valid values are `applied|under_review|approved|issued|expired|revoked`',
    `compliance_status` STRING COMMENT 'Aggregated compliance status of all permit conditions.. Valid values are `compliant|non_compliant|partial|pending`',
    `condition_count` STRING COMMENT 'Number of conditions attached to the permit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the permit record was first created.',
    `documents_attached_count` STRING COMMENT 'Number of supporting documents attached to the permit application.',
    `effective_from` DATE COMMENT 'Date from which the permit becomes effective (may differ from issue date).',
    `effective_until` DATE COMMENT 'Date until which the permit remains in effect (nullable for open-ended).',
    `expiry_date` DATE COMMENT 'Date the permit expires or must be renewed.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee associated with the permit.',
    `fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the fee.',
    `fee_paid_date` DATE COMMENT 'Date the permit fee was paid.',
    `fee_paid_flag` BOOLEAN COMMENT 'Indicates whether the permit fee has been paid.',
    `is_active` BOOLEAN COMMENT 'Indicates if the permit is currently active (not expired, revoked, or suspended).',
    `issue_date` DATE COMMENT 'Date the permit was officially issued.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the permit record.',
    `next_condition_due_date` DATE COMMENT 'Earliest due date among pending permit conditions.',
    `notes` STRING COMMENT 'Free-text field for internal comments or observations.',
    `permit_category` STRING COMMENT 'Category of the permit based on ownership or project type.. Valid values are `public|private|joint_venture|government`',
    `permit_number` STRING COMMENT 'Official permit number assigned by issuing authority.',
    `permit_type` STRING COMMENT 'Classifies the kind of permit.. Valid values are `building|excavation|environmental|utility|demolition|occupancy`',
    `renewal_date` DATE COMMENT 'Date by which renewal must be submitted.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether the permit requires renewal.',
    `revocation_date` DATE COMMENT 'Date the permit was revoked, if applicable.',
    `risk_level` STRING COMMENT 'Risk assessment level associated with the permit.. Valid values are `low|medium|high|critical`',
    `submission_date` DATE COMMENT 'Date the permit application was submitted to the authority.',
    `suspension_flag` BOOLEAN COMMENT 'Indicates if the permit is currently suspended.',
    `suspension_reason` STRING COMMENT 'Reason for permit suspension.',
    CONSTRAINT pk_regulatory_permit PRIMARY KEY(`regulatory_permit_id`)
) COMMENT 'Master register of all construction permits across the full lifecycle from application through expiry, including building permits, excavation permits, environmental permits, utility connection permits, demolition permits, and occupancy permits. Tracks application submissions (applicant details, supporting documents, authority response, resubmissions, appeals), authority review and approval/rejection, issuance, individual conditions attached (each with due date, responsible party, fulfilment status, and compliance evidence), condition compliance monitoring, renewal, expiry, revocation, and suspension. Captures permit number, issuing authority, permit type, project association, submission date, issue date, expiry date, renewal requirements, and current status. Serves as the SSOT for permit identity, permit application history, and permit condition compliance across all project sites. [SSOT: distinct source of truth for compliance domain]';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`compliance`.`remediation_action` (
    `remediation_action_id` BIGINT COMMENT 'System-generated unique identifier for the compliance action record.',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Compliance actions (e.g., corrective measures) are assigned to the specific scheduled activity they address, supporting traceability of remediation.',
    `regulatory_permit_id` BIGINT COMMENT 'Identifier of the permit whose condition was breached, if applicable.',
    `construction_project_id` BIGINT COMMENT 'Foreign key linking to project.construction_project. Business justification: Compliance Action Tracking Report requires linking each corrective action to the project it addresses.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Expenses from compliance actions are charged to a specific cost center, enabling cost‑center based reporting of compliance spend.',
    `document_register_id` BIGINT COMMENT 'Reference to the document or file that provides proof of action completion.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Compliance actions (e.g., corrective measures) are owned by a subcontractor; linking records ownership and accountability.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Compliance actions incur costs that must be posted to a GL account for financial reporting; linking ensures accurate expense accounting.',
    `hr_org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Maps compliance actions to the owning org unit, replacing free‑text department field to enable unit‑level performance metrics.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the internal or external party accountable for executing the action.',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: Budgeting of compliance actions is tracked within the project budget to control allocated compliance funds.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Compliance actions address regulatory obligations; many actions can belong to one obligation. Adding regulatory_obligation_id to compliance_action enables this relationship.',
    `iso_audit_id` BIGINT COMMENT 'Identifier of the audit or inspection that uncovered the issue.',
    `finding_id` BIGINT COMMENT 'Reference to the specific finding, observation, or notice that originated the action.',
    `action_number` STRING COMMENT 'Human‑readable identifier assigned to the corrective or preventive action, often used in reports and communications.',
    `action_type` STRING COMMENT 'Classifies the action as corrective, preventive, or improvement.. Valid values are `corrective|preventive|improvement`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the action was formally approved.',
    `closure_evidence_url` STRING COMMENT 'Web link or path to the evidence confirming action closure.',
    `comments` STRING COMMENT 'Free‑form notes or remarks added by stakeholders.',
    `completed_date` DATE COMMENT 'Actual date when the corrective or preventive work was finished.',
    `compliance_action_description` STRING COMMENT 'Detailed description of the corrective or preventive work to be performed.',
    `compliance_action_status` STRING COMMENT 'Current lifecycle state of the compliance action.. Valid values are `open|in_progress|closed|cancelled|deferred`',
    `compliance_area` STRING COMMENT 'Domain of compliance impacted (e.g., safety, environment, quality).. Valid values are `safety|environment|quality|financial|legal|ethics`',
    `corrective_measure` STRING COMMENT 'Specific steps or measures that will address the identified non‑conformance.',
    `cost_actual` DECIMAL(18,2) COMMENT 'Actual monetary cost incurred after action completion.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Projected monetary cost to implement the action.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the compliance action was initially recorded.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.',
    `due_date` DATE COMMENT 'Target date by which the action must be completed to satisfy the compliance requirement.',
    `external_authority_name` STRING COMMENT 'Name of the external regulatory body or agency.',
    `external_notice_date` DATE COMMENT 'Date the external authority issued the notice or citation.',
    `is_external` BOOLEAN COMMENT 'True if the action is driven by an external regulator or agency.',
    `is_repeat_action` BOOLEAN COMMENT 'True if this action is a repeat of a previously recorded issue.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Date‑time when the action record was last reviewed for relevance or accuracy.',
    `mitigation_plan` STRING COMMENT 'Long‑term plan to prevent recurrence of the issue.',
    `monitoring_end_date` DATE COMMENT 'Date when the monitoring period ends.',
    `monitoring_frequency` STRING COMMENT 'How often the post‑action monitoring should occur.. Valid values are `daily|weekly|monthly|quarterly|annually`',
    `monitoring_required` BOOLEAN COMMENT 'True if ongoing monitoring is required after closure.',
    `monitoring_start_date` DATE COMMENT 'Date when the monitoring period begins.',
    `priority` STRING COMMENT 'Business‑defined priority level indicating urgency.. Valid values are `low|medium|high|critical`',
    `regulatory_reference` STRING COMMENT 'Citation of the specific regulation, standard, or permit clause that triggered the action (e.g., OSHA 1910.120).',
    `repeat_action_count` STRING COMMENT 'Number of times the same issue has been recorded.',
    `risk_level` STRING COMMENT 'Assessed risk severity associated with the non‑compliance.. Valid values are `low|medium|high|critical`',
    `root_cause` STRING COMMENT 'Narrative explaining the underlying cause that triggered the compliance action.',
    `sustainability_action_id` BIGINT COMMENT 'Reference to canonical single source of truth sustainability.sustainability_action.sustainability_action_id',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the action record.',
    `verification_date` DATE COMMENT 'Date when the completed action was verified as effective and compliant.',
    CONSTRAINT pk_remediation_action PRIMARY KEY(`remediation_action_id`)
) COMMENT 'Corrective and preventive actions raised as a result of compliance assessments, regulatory findings, permit condition breaches, or authority notices. Tracks action description, root cause, responsible party, due date, priority, completion status, evidence of closure, and verification date. Distinct from safety corrective actions (owned by safety domain via Intelex) — this covers regulatory compliance remediation only. [SSOT: distinct source of truth for compliance domain]';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` (
    `obligation_calendar_id` BIGINT COMMENT 'Unique identifier for the compliance calendar entry.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the person or team accountable for meeting the deadline.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Compliance calendars often contain deadlines specific to a subcontractors obligations; linking ensures timely alerts.',
    `parent_compliance_calendar_id` BIGINT COMMENT 'Self-referencing FK on compliance_calendar (parent_compliance_calendar_id)',
    `agreement_id` BIGINT COMMENT 'Identifier of the contract associated with the compliance requirement.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project to which the compliance deadline applies.',
    `schedule_calendar_id` BIGINT COMMENT 'SSOT reference to canonical schedule.schedule_calendar (single source of truth).',
    `attachment_count` STRING COMMENT 'Number of supporting documents attached to the calendar entry.',
    `completion_date` DATE COMMENT 'Date on which the compliance action was completed.',
    `compliance_calendar_status` STRING COMMENT 'Current lifecycle status of the calendar entry.. Valid values are `pending|completed|overdue|cancelled`',
    `compliance_category` STRING COMMENT 'Broad category of compliance (e.g., Safety, Environment, Quality).. Valid values are `safety|environment|quality|financial|privacy|security`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the calendar entry record was first created.',
    `deadline_date` DATE COMMENT 'Calendar date on which the compliance obligation must be satisfied.',
    `deadline_type` STRING COMMENT 'Classification of the deadline, indicating the nature of the compliance requirement.. Valid values are `permit|certification|audit|report|inspection|training`',
    `entry_code` STRING COMMENT 'Business identifier code for the calendar entry, used for external reference.',
    `escalation_path` STRING COMMENT 'Textual description of the escalation procedure if the deadline is missed.',
    `escalation_triggered_flag` BOOLEAN COMMENT 'Indicates whether the escalation process has been activated.',
    `escalation_triggered_timestamp` TIMESTAMP COMMENT 'Timestamp when the escalation was triggered.',
    `jurisdiction` STRING COMMENT 'Three‑letter country code indicating the jurisdiction governing the obligation.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the calendar entry.',
    `overdue_flag` BOOLEAN COMMENT 'Indicates whether the deadline is past due and not yet completed.',
    `priority` STRING COMMENT 'Business priority assigned to the deadline for resource planning.. Valid values are `low|medium|high|critical`',
    `regulatory_body` STRING COMMENT 'Name of the regulatory agency or body that issued the obligation.',
    `reminder_lead_days` STRING COMMENT 'Number of days prior to the deadline when a reminder should be issued.',
    `reminder_sent_flag` BOOLEAN COMMENT 'Indicates whether the pre‑deadline reminder has been sent.',
    `reminder_sent_timestamp` TIMESTAMP COMMENT 'Timestamp when the reminder was sent to the responsible owner.',
    `risk_level` STRING COMMENT 'Risk rating associated with missing the deadline.. Valid values are `low|medium|high|critical`',
    `source_reference` STRING COMMENT 'Reference code or identifier of the originating regulatory obligation, permit, or certification.',
    `title` STRING COMMENT 'Human‑readable title describing the compliance deadline or event.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the calendar entry.',
    CONSTRAINT pk_obligation_calendar PRIMARY KEY(`obligation_calendar_id`)
) COMMENT 'Operational calendar of compliance deadlines, renewal dates, submission due dates, permit expiry dates, ISO audit schedules, LEED submission windows, and regulatory filing deadlines. Aggregates key dates from permits, certifications, regulatory obligations, and authority notices into a single actionable timeline. Captures deadline date, deadline type, source obligation or permit reference, responsible owner, reminder lead time, escalation path, completion status, and overdue flag. The primary daily operational tool for construction compliance managers ensuring no regulatory deadline is missed across multiple project sites and jurisdictions. [SSOT: distinct source of truth for compliance domain]';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ADD CONSTRAINT `fk_compliance_permit_application_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ADD CONSTRAINT `fk_compliance_permit_application_env_impact_assessment_id` FOREIGN KEY (`env_impact_assessment_id`) REFERENCES `vibe_construction_v1`.`compliance`.`env_impact_assessment`(`env_impact_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ADD CONSTRAINT `fk_compliance_env_monitoring_env_impact_assessment_id` FOREIGN KEY (`env_impact_assessment_id`) REFERENCES `vibe_construction_v1`.`compliance`.`env_impact_assessment`(`env_impact_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ADD CONSTRAINT `fk_compliance_leed_credit_leed_certification_id` FOREIGN KEY (`leed_certification_id`) REFERENCES `vibe_construction_v1`.`compliance`.`leed_certification`(`leed_certification_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ADD CONSTRAINT `fk_compliance_assessment_audit_report_id` FOREIGN KEY (`audit_report_id`) REFERENCES `vibe_construction_v1`.`compliance`.`audit_report`(`audit_report_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ADD CONSTRAINT `fk_compliance_privacy_obligation_privacy_incident_id` FOREIGN KEY (`privacy_incident_id`) REFERENCES `vibe_construction_v1`.`compliance`.`privacy_incident`(`privacy_incident_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ADD CONSTRAINT `fk_compliance_consent_record_privacy_obligation_id` FOREIGN KEY (`privacy_obligation_id`) REFERENCES `vibe_construction_v1`.`compliance`.`privacy_obligation`(`privacy_obligation_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ADD CONSTRAINT `fk_compliance_pci_control_pci_assessment_id` FOREIGN KEY (`pci_assessment_id`) REFERENCES `vibe_construction_v1`.`compliance`.`pci_assessment`(`pci_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ADD CONSTRAINT `fk_compliance_iso_audit_iso_certification_id` FOREIGN KEY (`iso_certification_id`) REFERENCES `vibe_construction_v1`.`compliance`.`iso_certification`(`iso_certification_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ADD CONSTRAINT `fk_compliance_iso_audit_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ADD CONSTRAINT `fk_compliance_waiver_exemption_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_superseded_regulatory_change_id` FOREIGN KEY (`superseded_regulatory_change_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ADD CONSTRAINT `fk_compliance_finding_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `vibe_construction_v1`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ADD CONSTRAINT `fk_compliance_finding_source_finding_id` FOREIGN KEY (`source_finding_id`) REFERENCES `vibe_construction_v1`.`compliance`.`finding`(`finding_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ADD CONSTRAINT `fk_compliance_audit_report_parent_audit_report_id` FOREIGN KEY (`parent_audit_report_id`) REFERENCES `vibe_construction_v1`.`compliance`.`audit_report`(`audit_report_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ADD CONSTRAINT `fk_compliance_regulatory_permit_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_regulatory_permit_id` FOREIGN KEY (`regulatory_permit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_permit`(`regulatory_permit_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `vibe_construction_v1`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_iso_audit_id` FOREIGN KEY (`iso_audit_id`) REFERENCES `vibe_construction_v1`.`compliance`.`iso_audit`(`iso_audit_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_finding_id` FOREIGN KEY (`finding_id`) REFERENCES `vibe_construction_v1`.`compliance`.`finding`(`finding_id`);
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ADD CONSTRAINT `fk_compliance_obligation_calendar_parent_compliance_calendar_id` FOREIGN KEY (`parent_compliance_calendar_id`) REFERENCES `vibe_construction_v1`.`compliance`.`obligation_calendar`(`obligation_calendar_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`compliance` SET TAGS ('pii_division' = 'corporate');
ALTER SCHEMA `vibe_construction_v1`.`compliance` SET TAGS ('pii_domain' = 'compliance');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` SET TAGS ('pii_subdomain' = 'permit_oversight');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `permit_application_id` SET TAGS ('pii_business_glossary_term' = 'Permit Application ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Identifier (PID)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `env_impact_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Environmental Impact Assessment Identifier (EIAI)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `appeal_deadline` SET TAGS ('pii_business_glossary_term' = 'Appeal Deadline Date (ADD)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `appeal_filed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Appeal Filed Timestamp (AFT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `application_number` SET TAGS ('pii_business_glossary_term' = 'Permit Application Number (PAN)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Permit Approval Timestamp (PAT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `compliance_requirements_met` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirements Met Flag (CRM)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `decision` SET TAGS ('pii_business_glossary_term' = 'Authority Decision (ADec)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `decision` SET TAGS ('pii_value_regex' = 'approved|rejected|withdrawn|pending');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `decision_reason` SET TAGS ('pii_business_glossary_term' = 'Decision Reason (DR)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `permit_application_description` SET TAGS ('pii_business_glossary_term' = 'Application Description (AD)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `expiration_timestamp` SET TAGS ('pii_business_glossary_term' = 'Permit Expiration Timestamp (PET)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `fee_adjustment` SET TAGS ('pii_business_glossary_term' = 'Permit Fee Adjustment (PFAJ)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `fee_adjustment` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `fee_total` SET TAGS ('pii_business_glossary_term' = 'Permit Fee Total (PFT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `fee_total` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `is_resubmission` SET TAGS ('pii_business_glossary_term' = 'Resubmission Indicator (RI)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `leeds_certification_level` SET TAGS ('pii_business_glossary_term' = 'LEED Certification Level (LCL)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `leeds_certification_level` SET TAGS ('pii_value_regex' = 'certified|silver|gold|platinum');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `permit_application_status` SET TAGS ('pii_business_glossary_term' = 'Application Lifecycle Status (ALS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `permit_application_status` SET TAGS ('pii_value_regex' = 'draft|submitted|under_review|approved|rejected|withdrawn');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `resubmission_reason` SET TAGS ('pii_business_glossary_term' = 'Resubmission Reason (RR)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Application Submission Timestamp (AST)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `supporting_document_count` SET TAGS ('pii_business_glossary_term' = 'Supporting Document Count (SDC)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp (RUT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `validity_end_date` SET TAGS ('pii_business_glossary_term' = 'Permit Validity End Date (VED)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `validity_start_date` SET TAGS ('pii_business_glossary_term' = 'Permit Validity Start Date (VSD)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_application` ALTER COLUMN `work_scope` SET TAGS ('pii_business_glossary_term' = 'Work Scope Description (WSD)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` SET TAGS ('pii_subdomain' = 'permit_oversight');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `permit_condition_id` SET TAGS ('pii_business_glossary_term' = 'Permit Condition ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `contact_id` SET TAGS ('pii_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `compliance_deadline` SET TAGS ('pii_business_glossary_term' = 'Compliance Deadline (COMP_DEADLINE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `compliance_evidence_url` SET TAGS ('pii_business_glossary_term' = 'Compliance Evidence URL (EVID_URL)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `compliance_status_detail` SET TAGS ('pii_business_glossary_term' = 'Compliance Status Detail (COMP_STATUS_DETAIL)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_action_required` SET TAGS ('pii_business_glossary_term' = 'Action Required (ACTION_REQ)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_category` SET TAGS ('pii_business_glossary_term' = 'Condition Category (COND_CAT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_code` SET TAGS ('pii_business_glossary_term' = 'Condition Code (COND_CD)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_document_reference` SET TAGS ('pii_business_glossary_term' = 'Document Reference (DOC_REF)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_fine_amount` SET TAGS ('pii_business_glossary_term' = 'Fine Amount (FINE_AMT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_fine_currency` SET TAGS ('pii_business_glossary_term' = 'Fine Currency (FINE_CURR)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_fine_currency` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_is_mandatory` SET TAGS ('pii_business_glossary_term' = 'Mandatory Condition Flag (MANDATORY_FLAG)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_is_waivable` SET TAGS ('pii_business_glossary_term' = 'Waivable Condition Flag (WAIVABLE_FLAG)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_last_updated_by` SET TAGS ('pii_business_glossary_term' = 'Last Updated By (LAST_UPDATED_BY)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_last_updated_by_role` SET TAGS ('pii_business_glossary_term' = 'Updater Role (UPDATER_ROLE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_priority` SET TAGS ('pii_business_glossary_term' = 'Condition Priority (COND_PRIORITY)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_priority` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_reference_number` SET TAGS ('pii_business_glossary_term' = 'Reference Number (REF_NUM)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date (RESOLUTION_DT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_resolution_notes` SET TAGS ('pii_business_glossary_term' = 'Resolution Notes (RESOLUTION_NOTES)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_review_date` SET TAGS ('pii_business_glossary_term' = 'Review Date (REVIEW_DT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_status_reason` SET TAGS ('pii_business_glossary_term' = 'Condition Status Reason (STATUS_REASON)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_type` SET TAGS ('pii_business_glossary_term' = 'Condition Type (COND_TYPE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `condition_type` SET TAGS ('pii_value_regex' = 'environmental|safety|financial|schedule|quality');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `permit_condition_description` SET TAGS ('pii_business_glossary_term' = 'Condition Description (COND_DESC)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date (EFF_DT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `evidence_required` SET TAGS ('pii_business_glossary_term' = 'Evidence Required (EVID_REQ)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Expiry Date (EXP_DT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `inspection_last_date` SET TAGS ('pii_business_glossary_term' = 'Last Inspection Date (LAST_INSP_DT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `inspection_next_date` SET TAGS ('pii_business_glossary_term' = 'Next Inspection Date (NEXT_INSP_DT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `inspection_required` SET TAGS ('pii_business_glossary_term' = 'Inspection Required Flag (INSP_REQ)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `last_report_date` SET TAGS ('pii_business_glossary_term' = 'Last Report Date (LAST_RPT_DT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `next_report_date` SET TAGS ('pii_business_glossary_term' = 'Next Report Date (NEXT_RPT_DT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `penalty_amount` SET TAGS ('pii_business_glossary_term' = 'Penalty Amount (PENALTY_AMT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `penalty_currency` SET TAGS ('pii_business_glossary_term' = 'Penalty Currency (PENALTY_CURR)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `penalty_currency` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `permit_condition_status` SET TAGS ('pii_business_glossary_term' = 'Condition Status (COND_STATUS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `permit_condition_status` SET TAGS ('pii_value_regex' = 'pending|compliant|non_compliant|waived|closed');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency (REPORT_FREQ)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_value_regex' = 'daily|weekly|monthly|quarterly|annually');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `source_agency` SET TAGS ('pii_business_glossary_term' = 'Source Regulatory Agency (SRC_AGENCY)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`permit_condition` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` SET TAGS ('pii_subdomain' = 'environmental_standards');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `env_impact_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Env Impact Assessment Identifier');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Officer Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected|withdrawn');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `assessment_date` SET TAGS ('pii_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `assessment_number` SET TAGS ('pii_business_glossary_term' = 'Assessment Number');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `assessment_type` SET TAGS ('pii_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `assessment_type` SET TAGS ('pii_value_regex' = 'baseline|impact|post_construction|monitoring');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `assessment_version` SET TAGS ('pii_business_glossary_term' = 'Assessment Version');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `consultant_email` SET TAGS ('pii_business_glossary_term' = 'Environmental Consultant Email');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `consultant_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `consultant_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `consultant_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `consultant_name` SET TAGS ('pii_business_glossary_term' = 'Environmental Consultant Name');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `consultant_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `consultant_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `corrective_action_taken` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `environmental_category` SET TAGS ('pii_business_glossary_term' = 'Environmental Category');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `environmental_category` SET TAGS ('pii_value_regex' = 'air|water|soil|noise|biodiversity|waste');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `epa_report_submitted` SET TAGS ('pii_business_glossary_term' = 'EPA Report Submitted');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `findings_summary` SET TAGS ('pii_business_glossary_term' = 'Findings Summary');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `iso_14001_compliant` SET TAGS ('pii_business_glossary_term' = 'ISO 14001 Compliant');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `leeds_certified` SET TAGS ('pii_business_glossary_term' = 'LEED Certified');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `mitigation_measures` SET TAGS ('pii_business_glossary_term' = 'Mitigation Measures');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `overall_status` SET TAGS ('pii_business_glossary_term' = 'Overall Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `overall_status` SET TAGS ('pii_value_regex' = 'active|inactive|closed|on_hold');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `project_phase` SET TAGS ('pii_business_glossary_term' = 'Project Phase');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `project_phase` SET TAGS ('pii_value_regex' = 'planning|design|construction|operation|decommission');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `regulatory_submission_ref` SET TAGS ('pii_business_glossary_term' = 'Regulatory Submission Reference');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `review_cycle_months` SET TAGS ('pii_business_glossary_term' = 'Review Cycle (Months)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `scope_description` SET TAGS ('pii_business_glossary_term' = 'Scope Description');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_impact_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` SET TAGS ('pii_subdomain' = 'environmental_standards');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `env_monitoring_id` SET TAGS ('pii_business_glossary_term' = 'Env Monitoring Identifier');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `env_impact_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Env Impact Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `env_site_construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Site ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Recorded By Employee ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `audit_created_by` SET TAGS ('pii_business_glossary_term' = 'Audit Created By Employee ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `audit_created_by` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `audit_created_by` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `corrective_action` SET TAGS ('pii_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `corrective_action_status` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `corrective_action_status` SET TAGS ('pii_value_regex' = 'pending|completed|not_required');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `data_quality_flag` SET TAGS ('pii_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `data_quality_flag` SET TAGS ('pii_value_regex' = 'good|questionable|bad');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `env_monitoring_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `env_monitoring_status` SET TAGS ('pii_value_regex' = 'recorded|reviewed|closed');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `equipment_serial_number` SET TAGS ('pii_business_glossary_term' = 'Equipment Serial Number');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `exceedance_flag` SET TAGS ('pii_business_glossary_term' = 'Exceedance Flag');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `latitude` SET TAGS ('pii_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `location_description` SET TAGS ('pii_business_glossary_term' = 'Location Description');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `longitude` SET TAGS ('pii_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `measured_value` SET TAGS ('pii_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `measurement_method` SET TAGS ('pii_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `measurement_method` SET TAGS ('pii_value_regex' = 'sensor|manual|lab');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `measurement_unit` SET TAGS ('pii_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `monitoring_timestamp` SET TAGS ('pii_business_glossary_term' = 'Monitoring Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `monitoring_type` SET TAGS ('pii_business_glossary_term' = 'Monitoring Type (MT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `monitoring_type` SET TAGS ('pii_value_regex' = 'air|noise|water|soil|dust|vibration');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `parameter` SET TAGS ('pii_business_glossary_term' = 'Measured Parameter');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `regulatory_body` SET TAGS ('pii_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `regulatory_body` SET TAGS ('pii_value_regex' = 'EPA|OSHA|ISO14001|local|state|federal');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `sample_reference` SET TAGS ('pii_business_glossary_term' = 'Sample ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `sensor_code` SET TAGS ('pii_business_glossary_term' = 'Monitoring Sensor ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `threshold_unit` SET TAGS ('pii_business_glossary_term' = 'Threshold Unit');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `threshold_value` SET TAGS ('pii_business_glossary_term' = 'Regulatory Threshold Value');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`env_monitoring` ALTER COLUMN `weather_conditions` SET TAGS ('pii_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` SET TAGS ('pii_subdomain' = 'environmental_standards');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `leed_certification_id` SET TAGS ('pii_business_glossary_term' = 'LEED Certification ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Officer Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `award_date` SET TAGS ('pii_business_glossary_term' = 'Award Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `certificate_reference` SET TAGS ('pii_business_glossary_term' = 'Certificate Reference');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `certification_level_awarded` SET TAGS ('pii_business_glossary_term' = 'Awarded LEED Certification Level');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `certification_level_awarded` SET TAGS ('pii_value_regex' = 'Certified|Silver|Gold|Platinum|None');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `certification_level_target` SET TAGS ('pii_business_glossary_term' = 'Target LEED Certification Level');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `certification_level_target` SET TAGS ('pii_value_regex' = 'Certified|Silver|Gold|Platinum');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `certification_type` SET TAGS ('pii_business_glossary_term' = 'LEED Certification Type');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `certification_type` SET TAGS ('pii_value_regex' = 'New Construction|Existing Buildings|Core and Shell|Commercial Interiors|Neighborhood Development|Homes');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `certifying_body` SET TAGS ('pii_business_glossary_term' = 'Certifying Body');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `compliance_review_date` SET TAGS ('pii_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `evidence_submitted_date` SET TAGS ('pii_business_glossary_term' = 'Evidence Submitted Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Certification Expiration Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_business_glossary_term' = 'LEED Certification Lifecycle Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_value_regex' = 'draft|submitted|under_review|approved|rejected|closed');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'General Notes');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `project_phase` SET TAGS ('pii_business_glossary_term' = 'Project Phase');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `project_phase` SET TAGS ('pii_value_regex' = 'Planning|Design|Construction|Commissioning|Operation');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `registration_number` SET TAGS ('pii_business_glossary_term' = 'LEED Registration Number');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `registration_status` SET TAGS ('pii_business_glossary_term' = 'Registration Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `renewal_status` SET TAGS ('pii_business_glossary_term' = 'Renewal Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `renewal_status` SET TAGS ('pii_value_regex' = 'not_due|due|renewed|overdue');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `review_status` SET TAGS ('pii_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `review_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `reviewer_comments` SET TAGS ('pii_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Certification Start Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `submission_reference` SET TAGS ('pii_business_glossary_term' = 'Submission Reference');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `target_award_date` SET TAGS ('pii_business_glossary_term' = 'Target Award Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `total_points_available` SET TAGS ('pii_business_glossary_term' = 'Total Points Available');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `total_points_awarded` SET TAGS ('pii_business_glossary_term' = 'Total Points Awarded');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `total_points_targeted` SET TAGS ('pii_business_glossary_term' = 'Total Points Targeted');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Record Updated By');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_certification` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` SET TAGS ('pii_subdomain' = 'environmental_standards');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `leed_credit_id` SET TAGS ('pii_business_glossary_term' = 'LEED Credit ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `leed_certification_id` SET TAGS ('pii_business_glossary_term' = 'Leed Certification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `compliance_requirements` SET TAGS ('pii_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `credit_category` SET TAGS ('pii_business_glossary_term' = 'LEED Credit Category');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `credit_code` SET TAGS ('pii_business_glossary_term' = 'LEED Credit Code');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `credit_description` SET TAGS ('pii_business_glossary_term' = 'Credit Description');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `credit_name` SET TAGS ('pii_business_glossary_term' = 'LEED Credit Name');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `documentation_url` SET TAGS ('pii_business_glossary_term' = 'Documentation URL');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `eligibility_criteria` SET TAGS ('pii_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `evidence_submission_date` SET TAGS ('pii_business_glossary_term' = 'Evidence Submission Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `evidence_submitted` SET TAGS ('pii_business_glossary_term' = 'Evidence Submitted');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `is_eligible` SET TAGS ('pii_business_glossary_term' = 'Eligibility Flag');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `leed_credit_status` SET TAGS ('pii_business_glossary_term' = 'LEED Credit Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `leed_credit_status` SET TAGS ('pii_value_regex' = 'pending|submitted|approved|rejected|withdrawn');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `points_available` SET TAGS ('pii_business_glossary_term' = 'Points Available (LEED)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `points_awarded` SET TAGS ('pii_business_glossary_term' = 'Awarded Points (LEED)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `points_targeted` SET TAGS ('pii_business_glossary_term' = 'Targeted Points (LEED)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `review_status` SET TAGS ('pii_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `review_status` SET TAGS ('pii_value_regex' = 'under_review|approved|rejected|needs_resubmission');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `reviewer_comments` SET TAGS ('pii_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `submission_method` SET TAGS ('pii_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `submission_method` SET TAGS ('pii_value_regex' = 'digital|paper|email');
ALTER TABLE `vibe_construction_v1`.`compliance`.`leed_credit` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` SET TAGS ('pii_subdomain' = 'regulatory_governance');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_submission_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Submission ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Submitter ID (SUBMIT_ID)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `incident_id` SET TAGS ('pii_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_authority_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Related Contract ID (CONTRACT_ID)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Related Project ID (PROJ_ID)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `acknowledgement_date` SET TAGS ('pii_business_glossary_term' = 'Acknowledgement Date (ACK_DT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `acknowledgement_received` SET TAGS ('pii_business_glossary_term' = 'Acknowledgement Received (ACK_RCVD)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `attachment_flag` SET TAGS ('pii_business_glossary_term' = 'Attachment Flag (ATTACH_FLG)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `compliance_category` SET TAGS ('pii_business_glossary_term' = 'Compliance Category (COMP_CAT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `compliance_category` SET TAGS ('pii_value_regex' = 'environmental|safety|quality|financial|privacy');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `document_count` SET TAGS ('pii_business_glossary_term' = 'Document Count (DOC_CNT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `external_reference_number` SET TAGS ('pii_business_glossary_term' = 'External Reference Number (EXT_REF)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `fee_amount` SET TAGS ('pii_business_glossary_term' = 'Submission Fee Amount (FEE_AMT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `is_confidential` SET TAGS ('pii_business_glossary_term' = 'Is Confidential (CONF_FLG)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `last_modified_by` SET TAGS ('pii_business_glossary_term' = 'Last Modified By (MOD_BY)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_submission_status` SET TAGS ('pii_business_glossary_term' = 'Submission Status (STATUS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_submission_status` SET TAGS ('pii_value_regex' = 'draft|submitted|acknowledged|rejected|approved|closed');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `reporting_period_end` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date (RPT_END)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `reporting_period_start` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date (RPT_START)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `status_reason` SET TAGS ('pii_business_glossary_term' = 'Status Reason (STATUS_RSN)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date (SUB_DT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_description` SET TAGS ('pii_business_glossary_term' = 'Submission Description (SUB_DESC)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_method` SET TAGS ('pii_business_glossary_term' = 'Submission Method (SUB_METHOD)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_method` SET TAGS ('pii_value_regex' = 'electronic|paper|portal|email');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_notes` SET TAGS ('pii_business_glossary_term' = 'Submission Notes (SUB_NOTES)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_number` SET TAGS ('pii_business_glossary_term' = 'Submission Number (SUB_NUM)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('pii_business_glossary_term' = 'Submission Type (SUB_TYPE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('pii_value_regex' = 'annual_report|incident_notification|permit_renewal|compliance_certificate|other');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submitter_role` SET TAGS ('pii_business_glossary_term' = 'Submitter Role (SUBMIT_ROLE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `submitter_role` SET TAGS ('pii_value_regex' = 'contractor|subcontractor|project_manager|safety_officer|engineer');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_submission` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number (VER_NUM)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` SET TAGS ('pii_subdomain' = 'regulatory_governance');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `hr_org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Owner ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Related Contract ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Related Project ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_evidence_status` SET TAGS ('pii_business_glossary_term' = 'Evidence Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_evidence_status` SET TAGS ('pii_value_regex' = 'submitted|approved|rejected|not_started');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending|exempt|under_review');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `data_classification` SET TAGS ('pii_business_glossary_term' = 'Data Classification');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `data_classification` SET TAGS ('pii_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `evidence_required` SET TAGS ('pii_business_glossary_term' = 'Evidence Required');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `is_mandatory` SET TAGS ('pii_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `jurisdiction` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction (Country/Region)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_code` SET TAGS ('pii_business_glossary_term' = 'Obligation Code (CODE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_title` SET TAGS ('pii_business_glossary_term' = 'Obligation Title');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_amount` SET TAGS ('pii_business_glossary_term' = 'Penalty Amount (USD)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_currency` SET TAGS ('pii_business_glossary_term' = 'Penalty Currency (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_currency` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|AUD');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_type` SET TAGS ('pii_business_glossary_term' = 'Penalty Type');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_type` SET TAGS ('pii_value_regex' = 'fine|stop_work|license_revocation|other');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulatory_body` SET TAGS ('pii_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulatory_body` SET TAGS ('pii_value_regex' = 'OSHA|EPA|ISO|FIDIC|GDPR|PCI_DSS');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `review_frequency_months` SET TAGS ('pii_business_glossary_term' = 'Review Frequency (Months)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `scope_business_units` SET TAGS ('pii_business_glossary_term' = 'Scope Business Units');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `scope_projects` SET TAGS ('pii_business_glossary_term' = 'Scope Projects');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `source_document_reference` SET TAGS ('pii_business_glossary_term' = 'Source Document Reference');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_obligation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` SET TAGS ('pii_subdomain' = 'audit_assurance');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` SET TAGS ('pii_ecm_reviewed' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` SET TAGS ('pii_source' = 'vibe-batch');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `assessment_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Assessment ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `audit_report_id` SET TAGS ('pii_business_glossary_term' = 'Audit Report ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Assessor ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `assessment_date` SET TAGS ('pii_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `assessment_status` SET TAGS ('pii_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `assessment_status` SET TAGS ('pii_value_regex' = 'draft|in_progress|completed|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `assessment_type` SET TAGS ('pii_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `assessment_type` SET TAGS ('pii_value_regex' = 'regulatory|internal|external|audit');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `assessor_name` SET TAGS ('pii_business_glossary_term' = 'Assessor Full Name');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `assessor_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `assessor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `attachment_count` SET TAGS ('pii_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `audit_trail_notes` SET TAGS ('pii_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `assessment_code` SET TAGS ('pii_business_glossary_term' = 'Assessment Code');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `compliance_category` SET TAGS ('pii_business_glossary_term' = 'Compliance Category');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `compliance_category` SET TAGS ('pii_value_regex' = 'environment|safety|quality|financial|privacy');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `compliance_rating` SET TAGS ('pii_business_glossary_term' = 'Compliance Rating');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `compliance_rating` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|partial|not_applicable');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `compliance_status_overall` SET TAGS ('pii_business_glossary_term' = 'Overall Compliance Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `compliance_status_overall` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|partial');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `document_reference` SET TAGS ('pii_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `external_audit_firm` SET TAGS ('pii_business_glossary_term' = 'External Audit Firm');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `findings_summary` SET TAGS ('pii_business_glossary_term' = 'Findings Summary');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `gaps_identified` SET TAGS ('pii_business_glossary_term' = 'Compliance Gaps Identified');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `is_critical` SET TAGS ('pii_business_glossary_term' = 'Critical Assessment Flag');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `is_external_audit` SET TAGS ('pii_business_glossary_term' = 'External Audit Flag');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `jurisdiction` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction Country Code');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `jurisdiction` SET TAGS ('pii_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `last_reviewed_by` SET TAGS ('pii_business_glossary_term' = 'Last Reviewed By ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `last_reviewed_date` SET TAGS ('pii_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `mitigation_plan` SET TAGS ('pii_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `next_assessment_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `obligations_assessed` SET TAGS ('pii_business_glossary_term' = 'Obligations Assessed');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `penalty_amount` SET TAGS ('pii_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `project_name` SET TAGS ('pii_business_glossary_term' = 'Project Name');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `rating_score` SET TAGS ('pii_business_glossary_term' = 'Compliance Rating Score');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `recommended_actions` SET TAGS ('pii_business_glossary_term' = 'Recommended Corrective Actions');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `regulatory_body` SET TAGS ('pii_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `regulatory_body` SET TAGS ('pii_value_regex' = 'OSHA|EPA|ISO_9001|ISO_14001|ISO_45001|LEED');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `scope_description` SET TAGS ('pii_business_glossary_term' = 'Assessment Scope Description');
ALTER TABLE `vibe_construction_v1`.`compliance`.`assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` SET TAGS ('pii_subdomain' = 'regulatory_governance');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `authority_notice_id` SET TAGS ('pii_business_glossary_term' = 'Authority Notice ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID (PROJECT_ID)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `document_register_id` SET TAGS ('pii_business_glossary_term' = 'Attached Document ID (DOC_ID)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `appeal_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Date (APPEAL_DT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `appeal_lodged_flag` SET TAGS ('pii_business_glossary_term' = 'Appeal Lodged Flag (APPEAL_LODGED)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `authority_notice_status` SET TAGS ('pii_business_glossary_term' = 'Notice Status (STATUS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `authority_notice_status` SET TAGS ('pii_value_regex' = 'open|closed|appealed|resolved|dismissed');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `authority_type` SET TAGS ('pii_business_glossary_term' = 'Authority Type (AUTH_TYPE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `authority_type` SET TAGS ('pii_value_regex' = 'federal|state|local|private');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `compliance_category` SET TAGS ('pii_business_glossary_term' = 'Compliance Category (COMPLIANCE_CAT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `compliance_category` SET TAGS ('pii_value_regex' = 'safety|environment|building|financial');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `compliance_officer` SET TAGS ('pii_business_glossary_term' = 'Compliance Officer (COMPLIANCE_OFFICER)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `issuing_authority` SET TAGS ('pii_business_glossary_term' = 'Issuing Authority (ISSUING_AUTH)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `notice_date` SET TAGS ('pii_business_glossary_term' = 'Notice Date (NOTICE_DT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `notice_number` SET TAGS ('pii_business_glossary_term' = 'Notice Number (NOTICE_NO)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `notice_type` SET TAGS ('pii_business_glossary_term' = 'Notice Type (NOTICE_TYPE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `notice_type` SET TAGS ('pii_value_regex' = 'infringement|improvement|prohibition|stop_work|directive');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `penalty_amount` SET TAGS ('pii_business_glossary_term' = 'Penalty Amount (PENALTY_AMT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `penalty_currency` SET TAGS ('pii_business_glossary_term' = 'Penalty Currency (PENALTY_CURR)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `penalty_due_date` SET TAGS ('pii_business_glossary_term' = 'Penalty Due Date (PENALTY_DUE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `regulation_breached` SET TAGS ('pii_business_glossary_term' = 'Regulation Breached (REG_BREACH)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `remediation_required` SET TAGS ('pii_business_glossary_term' = 'Remediation Required (REMEDIATION)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date (RES_DATE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `resolution_outcome` SET TAGS ('pii_business_glossary_term' = 'Resolution Outcome (RES_OUTCOME)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `resolution_outcome` SET TAGS ('pii_value_regex' = 'complied|non_complied|settled|dismissed');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `response_deadline` SET TAGS ('pii_business_glossary_term' = 'Response Deadline (RESP_DEADLINE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `response_submitted_date` SET TAGS ('pii_business_glossary_term' = 'Response Submitted Date (RESP_SUBMIT_DT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `response_submitted_flag` SET TAGS ('pii_business_glossary_term' = 'Response Submitted Flag (RESP_SUBMITTED)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `severity_level` SET TAGS ('pii_business_glossary_term' = 'Severity Level (SEVERITY)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `severity_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`authority_notice` ALTER COLUMN `violation_description` SET TAGS ('pii_business_glossary_term' = 'Violation Description (VIOL_DESC)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` SET TAGS ('pii_subdomain' = 'privacy_protection');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `privacy_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Privacy Obligation ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `privacy_incident_id` SET TAGS ('pii_business_glossary_term' = 'Breach Record Identifier (BREACH_ID)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `breach_date` SET TAGS ('pii_business_glossary_term' = 'Breach Date (BREACH_DATE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `breach_discovery_method` SET TAGS ('pii_business_glossary_term' = 'Breach Discovery Method (DISCOVERY_METHOD)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `breach_discovery_method` SET TAGS ('pii_value_regex' = 'internal_audit|employee_report|customer_report|monitoring|other');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `breach_type` SET TAGS ('pii_business_glossary_term' = 'Breach Type (BREACH_TYPE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `breach_type` SET TAGS ('pii_value_regex' = 'unauthorized_access|loss|theft|disclosure|other');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `consent_date` SET TAGS ('pii_business_glossary_term' = 'Consent Date (CONSENT_DATE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `consent_method` SET TAGS ('pii_business_glossary_term' = 'Consent Method (CONSENT_METHOD)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `consent_method` SET TAGS ('pii_value_regex' = 'written|electronic|verbal|online_form');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `consent_required` SET TAGS ('pii_business_glossary_term' = 'Consent Required Indicator (CONSENT_REQ)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `consent_status` SET TAGS ('pii_business_glossary_term' = 'Consent Status (CONSENT_STATUS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `consent_status` SET TAGS ('pii_value_regex' = 'given|withdrawn|not_applicable');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `consent_version` SET TAGS ('pii_business_glossary_term' = 'Consent Version (CONSENT_VER)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `consent_withdrawal_date` SET TAGS ('pii_business_glossary_term' = 'Consent Withdrawal Date (CONSENT_WITHDRAWAL)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `cross_border_countries` SET TAGS ('pii_business_glossary_term' = 'Cross‑Border Transfer Countries (CROSS_COUNTRIES)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `cross_border_transfer` SET TAGS ('pii_business_glossary_term' = 'Cross‑Border Transfer Indicator (CROSS_BORDER)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `data_category` SET TAGS ('pii_business_glossary_term' = 'Data Category (CATEGORY)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `data_controller` SET TAGS ('pii_business_glossary_term' = 'Data Controller (CONTROLLER)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `data_processor` SET TAGS ('pii_business_glossary_term' = 'Data Processor (PROCESSOR)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `data_subject_category` SET TAGS ('pii_business_glossary_term' = 'Data Subject Category (DSC)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `data_subject_category` SET TAGS ('pii_value_regex' = 'employee|subcontractor|client_contact|vendor|other');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date (EFF_DATE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Expiry Date (EXP_DATE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `individuals_notified` SET TAGS ('pii_business_glossary_term' = 'Individuals Notified Indicator (INDIV_NOTIFIED)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date (REVIEW_DATE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `legal_basis` SET TAGS ('pii_business_glossary_term' = 'Legal Basis for Processing (LEGAL_BASIS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `legal_basis` SET TAGS ('pii_value_regex' = 'consent|contract|legal_obligation|vital_interests|public_task|legitimate_interests');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `notification_date` SET TAGS ('pii_business_glossary_term' = 'Notification Date (NOTIF_DATE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `notification_obligation_triggered` SET TAGS ('pii_business_glossary_term' = 'Notification Obligation Triggered (NOTIF_TRIGGER)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `obligation_code` SET TAGS ('pii_business_glossary_term' = 'Obligation Code (CODE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `obligation_type` SET TAGS ('pii_business_glossary_term' = 'Obligation Type (TYPE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `obligation_type` SET TAGS ('pii_value_regex' = 'consent|retention|breach|legal_basis|cross_border|other');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `privacy_obligation_status` SET TAGS ('pii_business_glossary_term' = 'Obligation Status (STATUS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `privacy_obligation_status` SET TAGS ('pii_value_regex' = 'active|inactive|revoked|expired');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `processing_purpose` SET TAGS ('pii_business_glossary_term' = 'Processing Purpose (PURPOSE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `remediation_action` SET TAGS ('pii_business_glossary_term' = 'Remediation Action Description (REMEDIATION)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `retention_period_days` SET TAGS ('pii_business_glossary_term' = 'Retention Period (Days) (RET_DAYS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `supervisory_authority_name` SET TAGS ('pii_business_glossary_term' = 'Supervisory Authority Name (SUPV_NAME)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_obligation` ALTER COLUMN `supervisory_authority_notified` SET TAGS ('pii_business_glossary_term' = 'Supervisory Authority Notified (SUPV_NOTIFIED)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` SET TAGS ('pii_subdomain' = 'privacy_protection');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `privacy_incident_id` SET TAGS ('pii_business_glossary_term' = 'Privacy Incident ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Reported By ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `breach_severity` SET TAGS ('pii_business_glossary_term' = 'Breach Severity');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `breach_severity` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `breach_type` SET TAGS ('pii_business_glossary_term' = 'Breach Type');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `breach_type` SET TAGS ('pii_value_regex' = 'unauthorized_access|loss|theft|disclosure|malware|phishing');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `corrective_action_plan` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `data_category` SET TAGS ('pii_business_glossary_term' = 'Data Category');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `data_category` SET TAGS ('pii_value_regex' = 'personal_identifiable|financial|health|employment|contact|location');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `data_retention_action` SET TAGS ('pii_business_glossary_term' = 'Data Retention Action');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `data_retention_action` SET TAGS ('pii_value_regex' = 'deleted|anonymized|archived|retained');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `data_subject_name` SET TAGS ('pii_business_glossary_term' = 'Data Subject Full Name');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `data_subject_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `data_subject_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `data_subject_reference` SET TAGS ('pii_business_glossary_term' = 'Data Subject ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `data_subject_reference` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `data_subject_reference` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `data_subject_type` SET TAGS ('pii_business_glossary_term' = 'Data Subject Type');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `data_subject_type` SET TAGS ('pii_value_regex' = 'employee|client|subcontractor|vendor|visitor');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `data_volume_bytes` SET TAGS ('pii_business_glossary_term' = 'Data Volume (Bytes)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `data_volume_records` SET TAGS ('pii_business_glossary_term' = 'Data Volume (Records)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `discovery_method` SET TAGS ('pii_business_glossary_term' = 'Discovery Method');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `discovery_method` SET TAGS ('pii_value_regex' = 'internal_audit|employee_report|customer_report|system_alert|regulatory_notice|third_party');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `estimated_fine_amount` SET TAGS ('pii_business_glossary_term' = 'Estimated Fine Amount');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `estimated_fine_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `impact_assessment` SET TAGS ('pii_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `incident_closure_date` SET TAGS ('pii_business_glossary_term' = 'Incident Closure Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `incident_description` SET TAGS ('pii_business_glossary_term' = 'Incident Description');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `incident_number` SET TAGS ('pii_business_glossary_term' = 'Incident Number');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `incident_timestamp` SET TAGS ('pii_business_glossary_term' = 'Incident Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `individuals_notified_flag` SET TAGS ('pii_business_glossary_term' = 'Individuals Notified Flag');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `legal_hold_flag` SET TAGS ('pii_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `notification_date` SET TAGS ('pii_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `notification_obligation_triggered` SET TAGS ('pii_business_glossary_term' = 'Notification Obligation Triggered');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `privacy_incident_status` SET TAGS ('pii_business_glossary_term' = 'Incident Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `privacy_incident_status` SET TAGS ('pii_value_regex' = 'open|investigating|resolved|closed|rejected');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `regulatory_report_submission_date` SET TAGS ('pii_business_glossary_term' = 'Regulatory Report Submission Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `regulatory_report_submitted` SET TAGS ('pii_business_glossary_term' = 'Regulatory Report Submitted');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `remediation_action` SET TAGS ('pii_business_glossary_term' = 'Remediation Action');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `remediation_status` SET TAGS ('pii_business_glossary_term' = 'Remediation Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `remediation_status` SET TAGS ('pii_value_regex' = 'planned|in_progress|completed|failed');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `reported_by_name` SET TAGS ('pii_business_glossary_term' = 'Reported By Name');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `reported_by_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `reported_by_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `risk_assessment_score` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `root_cause` SET TAGS ('pii_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_construction_v1`.`compliance`.`privacy_incident` ALTER COLUMN `supervisory_authority_notified_date` SET TAGS ('pii_business_glossary_term' = 'Supervisory Authority Notified Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` SET TAGS ('pii_subdomain' = 'privacy_protection');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `consent_record_id` SET TAGS ('pii_business_glossary_term' = 'Consent Record ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `privacy_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Privacy Obligation Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `consent_category` SET TAGS ('pii_business_glossary_term' = 'Consent Category');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `consent_category` SET TAGS ('pii_value_regex' = 'personal_data|marketing|analytics|third_party_sharing|health_safety|financial');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `consent_method` SET TAGS ('pii_business_glossary_term' = 'Consent Method');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `consent_method` SET TAGS ('pii_value_regex' = 'written|electronic|verbal');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `consent_record_status` SET TAGS ('pii_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `consent_record_status` SET TAGS ('pii_value_regex' = 'active|revoked|expired|withdrawn');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `consent_reference` SET TAGS ('pii_business_glossary_term' = 'Consent Reference Code');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `consent_timestamp` SET TAGS ('pii_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `consent_version` SET TAGS ('pii_business_glossary_term' = 'Consent Version');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `data_subject_reference` SET TAGS ('pii_business_glossary_term' = 'Data Subject ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `data_subject_type` SET TAGS ('pii_business_glossary_term' = 'Data Subject Type');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `data_subject_type` SET TAGS ('pii_value_regex' = 'employee|subcontractor|client|other');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `jurisdiction` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction Country Code');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `jurisdiction` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `legal_basis` SET TAGS ('pii_business_glossary_term' = 'Legal Basis for Processing');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `legal_basis` SET TAGS ('pii_value_regex' = 'consent|contract|legal_obligation|vital_interests|public_task|legitimate_interests');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Consent Notes');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `processing_activities` SET TAGS ('pii_business_glossary_term' = 'Processing Activities');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `purpose` SET TAGS ('pii_business_glossary_term' = 'Processing Purpose');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`consent_record` ALTER COLUMN `withdrawal_timestamp` SET TAGS ('pii_business_glossary_term' = 'Withdrawal Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` SET TAGS ('pii_subdomain' = 'privacy_protection');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `pci_control_id` SET TAGS ('pii_business_glossary_term' = 'PCI Control ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `pci_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Pci Assessment Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `assessment_document_reference` SET TAGS ('pii_business_glossary_term' = 'Assessment Document Reference (ASSESS_DOC_REF)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `assessment_method` SET TAGS ('pii_business_glossary_term' = 'Assessment Method (ASSESS_METHOD)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `assessment_method` SET TAGS ('pii_value_regex' = 'self_assessment|qsa_audit|penetration_test');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `assessment_result` SET TAGS ('pii_business_glossary_term' = 'Assessment Result (ASSESS_RESULT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `assessment_result` SET TAGS ('pii_value_regex' = 'pass|fail|partial');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `assessment_version` SET TAGS ('pii_business_glossary_term' = 'PCI DSS Version Assessed (PCI_VERSION)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `assessor_contact` SET TAGS ('pii_business_glossary_term' = 'Assessor Contact Email (ASSESSOR_EMAIL)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `assessor_contact` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `assessor_contact` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `assessor_name` SET TAGS ('pii_business_glossary_term' = 'Assessor Name (ASSESSOR_NAME)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `compliance_level` SET TAGS ('pii_business_glossary_term' = 'Compliance Level (COMPLIANCE_LEVEL)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `compliance_level` SET TAGS ('pii_value_regex' = 'compliant|partial|non_compliant');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `compliance_score` SET TAGS ('pii_business_glossary_term' = 'Compliance Score (COMPLIANCE_SCORE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_audit_trail` SET TAGS ('pii_business_glossary_term' = 'Control Audit Trail (AUDIT_TRAIL)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_category` SET TAGS ('pii_business_glossary_term' = 'Control Category (CTRL_CAT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Control Record Created Timestamp (CREATED_TS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_description` SET TAGS ('pii_business_glossary_term' = 'Control Description (CTRL_DESC)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_family` SET TAGS ('pii_business_glossary_term' = 'PCI DSS Control Family (PCI_FAMILY)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_family` SET TAGS ('pii_value_regex' = 'Build and Maintain Secure Network|Protect Cardholder Data|Maintain Vulnerability Management Program|Implement Strong Access Control Measures|Regularly Monitor and Test Networks|Maintain an Information Security Policy');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_frequency` SET TAGS ('pii_business_glossary_term' = 'Control Frequency (CTRL_FREQ)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_frequency` SET TAGS ('pii_value_regex' = 'continuous|annual|quarterly|monthly');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_identifier` SET TAGS ('pii_business_glossary_term' = 'Control Identifier (CTRL_ID)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_last_review_timestamp` SET TAGS ('pii_business_glossary_term' = 'Control Last Review Timestamp (LAST_REVIEW_TS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_name` SET TAGS ('pii_business_glossary_term' = 'Control Name (CTRL_NAME)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_owner` SET TAGS ('pii_business_glossary_term' = 'Control Owner (CTRL_OWNER)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_priority` SET TAGS ('pii_business_glossary_term' = 'Control Priority (CTRL_PRIORITY)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_requirement_reference` SET TAGS ('pii_business_glossary_term' = 'PCI DSS Requirement Reference (PCI_REQ_REF)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_retirement_date` SET TAGS ('pii_business_glossary_term' = 'Control Retirement Date (RETIRE_DATE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_risk_rating` SET TAGS ('pii_business_glossary_term' = 'Control Risk Rating (RISK_RATING)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_risk_rating` SET TAGS ('pii_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_source` SET TAGS ('pii_business_glossary_term' = 'Control Source (CTRL_SOURCE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_source` SET TAGS ('pii_value_regex' = 'internal|external');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_status` SET TAGS ('pii_business_glossary_term' = 'Control Status (CTRL_STATUS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_status` SET TAGS ('pii_value_regex' = 'active|inactive|retired');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_tags` SET TAGS ('pii_business_glossary_term' = 'Control Tags (CTRL_TAGS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_testing_frequency` SET TAGS ('pii_business_glossary_term' = 'Control Testing Frequency (CTRL_TEST_FREQ)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_testing_frequency` SET TAGS ('pii_value_regex' = 'continuous|annual|quarterly|monthly');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_type` SET TAGS ('pii_business_glossary_term' = 'Control Type (Technical/Procedural/Administrative) (CTRL_TYPE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_type` SET TAGS ('pii_value_regex' = 'technical|procedural|administrative');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Control Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `control_version` SET TAGS ('pii_business_glossary_term' = 'Control Version (CTRL_VER)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date (EFFECTIVE_FROM)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until Date (EFFECTIVE_UNTIL)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `evidence_location` SET TAGS ('pii_business_glossary_term' = 'Evidence Location (EVIDENCE_LOC)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `findings_summary` SET TAGS ('pii_business_glossary_term' = 'Findings Summary (FINDINGS_SUMMARY)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `implementation_status` SET TAGS ('pii_business_glossary_term' = 'Implementation Status (IMPL_STATUS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `implementation_status` SET TAGS ('pii_value_regex' = 'implemented|planned|not_implemented');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `last_assessment_date` SET TAGS ('pii_business_glossary_term' = 'Last Assessment Date (LAST_ASSESS_DATE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `next_assessment_due` SET TAGS ('pii_business_glossary_term' = 'Next Assessment Due Date (NEXT_ASSESS_DUE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `related_systems` SET TAGS ('pii_business_glossary_term' = 'Related Systems (RELATED_SYSTEMS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `remediation_due_date` SET TAGS ('pii_business_glossary_term' = 'Remediation Due Date (REMEDIATION_DUE_DATE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `remediation_plan` SET TAGS ('pii_business_glossary_term' = 'Remediation Plan (REMEDIATION_PLAN)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `remediation_status` SET TAGS ('pii_business_glossary_term' = 'Remediation Status (REMEDIATION_STATUS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `remediation_status` SET TAGS ('pii_value_regex' = 'open|in_progress|completed|deferred');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `scope` SET TAGS ('pii_business_glossary_term' = 'Scope of Control (SCOPE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `scope` SET TAGS ('pii_value_regex' = 'in_scope|out_of_scope');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_control` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` SET TAGS ('pii_subdomain' = 'privacy_protection');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `pci_assessment_id` SET TAGS ('pii_business_glossary_term' = 'PCI Assessment ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `hr_org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Organization ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `assessment_date` SET TAGS ('pii_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `assessment_number` SET TAGS ('pii_business_glossary_term' = 'Assessment Number');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `assessment_type` SET TAGS ('pii_business_glossary_term' = 'Assessment Type (SAQ, QSA Audit, Penetration Test)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `assessment_type` SET TAGS ('pii_value_regex' = 'SAQ|QSA_Audit|PenTest');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `assessor_email` SET TAGS ('pii_business_glossary_term' = 'Assessor Email Address');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `assessor_email` SET TAGS ('pii_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `assessor_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `assessor_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `assessor_name` SET TAGS ('pii_business_glossary_term' = 'Assessor Full Name');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `assessor_name` SET TAGS ('pii_value_regex' = '^[A-Za-zs]+$');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `assessor_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `assessor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `cardholder_data_scope` SET TAGS ('pii_business_glossary_term' = 'Cardholder Data Environment Scope');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `cardholder_data_scope` SET TAGS ('pii_value_regex' = 'In_Scope|Out_of_Scope|Partial');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `compliance_cost` SET TAGS ('pii_business_glossary_term' = 'Compliance Cost (USD)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `compliance_cost` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `compliance_cost` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `compliance_level` SET TAGS ('pii_business_glossary_term' = 'Compliance Level');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `compliance_level` SET TAGS ('pii_value_regex' = 'Level1|Level2|Level3|Level4');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `control_failed` SET TAGS ('pii_business_glossary_term' = 'Controls Failed');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `control_passed` SET TAGS ('pii_business_glossary_term' = 'Controls Passed');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `control_total` SET TAGS ('pii_business_glossary_term' = 'Total Controls Assessed');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `evidence_url` SET TAGS ('pii_business_glossary_term' = 'Evidence URL');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `exception_count` SET TAGS ('pii_business_glossary_term' = 'Exception Count');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `findings_summary` SET TAGS ('pii_business_glossary_term' = 'Findings Summary');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `last_assessment_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Assessment Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `overall_status` SET TAGS ('pii_business_glossary_term' = 'Overall Compliance Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `overall_status` SET TAGS ('pii_value_regex' = 'Compliant|Non_Compliant|Partial');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `pci_assessment_status` SET TAGS ('pii_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `pci_assessment_status` SET TAGS ('pii_value_regex' = 'Draft|In_Progress|Completed|Approved|Rejected');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `pci_version` SET TAGS ('pii_business_glossary_term' = 'PCI DSS Version');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `remediation_actions` SET TAGS ('pii_business_glossary_term' = 'Remediation Actions');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `remediation_due_date` SET TAGS ('pii_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `report_reference` SET TAGS ('pii_business_glossary_term' = 'Report of Compliance (ROC) / Attestation of Compliance (AOC) Reference');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `report_url` SET TAGS ('pii_business_glossary_term' = 'Report URL');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `scope_description` SET TAGS ('pii_business_glossary_term' = 'Scope Description');
ALTER TABLE `vibe_construction_v1`.`compliance`.`pci_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` SET TAGS ('pii_subdomain' = 'environmental_standards');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `iso_certification_id` SET TAGS ('pii_business_glossary_term' = 'ISO Certification ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `hr_org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Organization ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `audit_notes` SET TAGS ('pii_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `audit_schedule_frequency` SET TAGS ('pii_business_glossary_term' = 'Audit Schedule Frequency');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `audit_schedule_frequency` SET TAGS ('pii_value_regex' = 'annual|biennial|triennial');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `certificate_number` SET TAGS ('pii_business_glossary_term' = 'Certificate Number (CERT_NO)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `certification_type` SET TAGS ('pii_business_glossary_term' = 'Certification Type (ISO Standard)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `certification_type` SET TAGS ('pii_value_regex' = 'ISO 9001|ISO 14001|ISO 45001');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `certifying_body` SET TAGS ('pii_business_glossary_term' = 'Certifying Body (Certification Authority)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `compliance_evidence_url` SET TAGS ('pii_business_glossary_term' = 'Compliance Evidence URL');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `document_url` SET TAGS ('pii_business_glossary_term' = 'Certificate Document URL');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `findings_count` SET TAGS ('pii_business_glossary_term' = 'Number of Findings');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `iso_certification_status` SET TAGS ('pii_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `iso_certification_status` SET TAGS ('pii_value_regex' = 'active|expired|pending_renewal|revoked|suspended');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `issue_date` SET TAGS ('pii_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `jurisdiction` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction (Country Code)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `jurisdiction` SET TAGS ('pii_value_regex' = 'USA|CAN|MEX|GBR|AUS');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `last_audit_date` SET TAGS ('pii_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `last_audit_outcome` SET TAGS ('pii_business_glossary_term' = 'Last Audit Outcome');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `last_audit_outcome` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|conditional');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `last_audit_type` SET TAGS ('pii_business_glossary_term' = 'Last Audit Type');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `last_audit_type` SET TAGS ('pii_value_regex' = 'internal|surveillance|recertification');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `next_surveillance_audit_date` SET TAGS ('pii_business_glossary_term' = 'Next Surveillance Audit Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `non_conformances_count` SET TAGS ('pii_business_glossary_term' = 'Number of Non-Conformances');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'General Notes');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `observations` SET TAGS ('pii_business_glossary_term' = 'Audit Observations');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `renewal_date` SET TAGS ('pii_business_glossary_term' = 'Planned Renewal Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `renewal_required_flag` SET TAGS ('pii_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `scope` SET TAGS ('pii_business_glossary_term' = 'Scope of Certification (Scope Description)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` SET TAGS ('pii_subdomain' = 'environmental_standards');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `iso_audit_id` SET TAGS ('pii_business_glossary_term' = 'ISO Audit Identifier');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Identifier (PROJECT_ID)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Auditor Identifier (AUDITOR_ID)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `iso_certification_id` SET TAGS ('pii_business_glossary_term' = 'Iso Certification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `regulatory_authority_id` SET TAGS ('pii_business_glossary_term' = 'Certification Body Identifier (CERT_BODY_ID)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `audit_category` SET TAGS ('pii_business_glossary_term' = 'Audit Category (CATEGORY)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `audit_category` SET TAGS ('pii_value_regex' = 'management|process|product');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `audit_comments` SET TAGS ('pii_business_glossary_term' = 'Audit Comments (COMMENTS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `audit_date` SET TAGS ('pii_business_glossary_term' = 'Audit Date (AUDIT_DT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `audit_duration_hours` SET TAGS ('pii_business_glossary_term' = 'Audit Duration (HOURS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `audit_findings_url` SET TAGS ('pii_business_glossary_term' = 'Findings Document URL (FINDINGS_URL)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `audit_location` SET TAGS ('pii_business_glossary_term' = 'Audit Location (LOCATION)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `audit_method` SET TAGS ('pii_business_glossary_term' = 'Audit Method (METHOD)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `audit_method` SET TAGS ('pii_value_regex' = 'on_site|remote|document_review');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `audit_number` SET TAGS ('pii_business_glossary_term' = 'Audit Number (AUDIT_NO)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `audit_outcome` SET TAGS ('pii_business_glossary_term' = 'Audit Outcome (OUTCOME)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `audit_outcome` SET TAGS ('pii_value_regex' = 'passed|failed|conditional');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `audit_reference_number` SET TAGS ('pii_business_glossary_term' = 'Audit External Reference Number (EXT_REF_NO)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `audit_report_url` SET TAGS ('pii_business_glossary_term' = 'Audit Report URL (REPORT_URL)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `audit_scope_code` SET TAGS ('pii_business_glossary_term' = 'Audit Scope Code (SCOPE_CODE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `audit_score` SET TAGS ('pii_business_glossary_term' = 'Audit Score (SCORE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `audit_score_scale` SET TAGS ('pii_business_glossary_term' = 'Audit Score Scale (SCORE_SCALE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `audit_score_scale` SET TAGS ('pii_value_regex' = '0-100|1-5');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `audit_source_system` SET TAGS ('pii_business_glossary_term' = 'Audit Source System (SOURCE_SYS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `audit_team_size` SET TAGS ('pii_business_glossary_term' = 'Audit Team Size (TEAM_SIZE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `audit_type` SET TAGS ('pii_business_glossary_term' = 'Audit Type (AUDIT_TYPE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `audit_type` SET TAGS ('pii_value_regex' = 'internal|surveillance|recertification');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `audit_version` SET TAGS ('pii_business_glossary_term' = 'Audit Version (VERSION)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `auditor_name` SET TAGS ('pii_business_glossary_term' = 'Auditor Full Name (AUDITOR_NAME)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `auditor_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `auditor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `auditor_role` SET TAGS ('pii_business_glossary_term' = 'Auditor Role (AUDITOR_ROLE)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `auditor_role` SET TAGS ('pii_value_regex' = 'lead|assistant');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `certification_body` SET TAGS ('pii_business_glossary_term' = 'Certification Body (CERT_BODY)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `certification_body_contact` SET TAGS ('pii_business_glossary_term' = 'Certification Body Contact (CERT_BODY_CONTACT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|partial');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `corrective_action_due_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Due Date (CA_DUE_DT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `corrective_action_plan_url` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan URL (CAP_URL)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required Flag (CA_REQUIRED)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `evidence_documents_count` SET TAGS ('pii_business_glossary_term' = 'Evidence Documents Count (EVID_COUNT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `findings_summary` SET TAGS ('pii_business_glossary_term' = 'Findings Summary (FINDINGS_SUM)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `follow_up_audit_date` SET TAGS ('pii_business_glossary_term' = 'Follow‑Up Audit Date (FOLLOWUP_DT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `follow_up_audit_scheduled_flag` SET TAGS ('pii_business_glossary_term' = 'Follow‑Up Audit Scheduled Flag (FOLLOWUP_SCH)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `iso_audit_status` SET TAGS ('pii_business_glossary_term' = 'Audit Lifecycle Status (STATUS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `iso_audit_status` SET TAGS ('pii_value_regex' = 'planned|in_progress|completed|closed');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `non_conformances_count` SET TAGS ('pii_business_glossary_term' = 'Non‑Conformances Count (NC_COUNT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Audit Notes (NOTES)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `observations_count` SET TAGS ('pii_business_glossary_term' = 'Observations Count (OBS_COUNT)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level (RISK_LVL)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `scope_description` SET TAGS ('pii_business_glossary_term' = 'Audit Scope Description (SCOPE_DESC)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `standard_audited` SET TAGS ('pii_business_glossary_term' = 'Standard Audited (STD_AUDITED)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `standard_audited` SET TAGS ('pii_value_regex' = 'ISO 9001|ISO 14001|ISO 45001');
ALTER TABLE `vibe_construction_v1`.`compliance`.`iso_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` SET TAGS ('pii_subdomain' = 'permit_oversight');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `regulatory_authority_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority Identifier');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Account Id');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `abbreviation` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority Abbreviation');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `address` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority Address');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `classification` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority Classification');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `classification` SET TAGS ('pii_value_regex' = 'regulatory|environmental|safety|building|utility');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Overall Compliance Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|under_review|not_applicable');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `contact_person` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority Contact Person');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `contact_role` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority Contact Role');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `contact_role` SET TAGS ('pii_value_regex' = 'director|manager|officer|coordinator|representative');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `email` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority Email Address');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `geographic_scope` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope (Coverage)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `geographic_scope` SET TAGS ('pii_value_regex' = 'global|national|state|city|county');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `is_primary` SET TAGS ('pii_business_glossary_term' = 'Primary Authority Indicator');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `jurisdiction_type` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction Type (Level)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `jurisdiction_type` SET TAGS ('pii_value_regex' = 'federal|state|local|regional|international');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `last_contact_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Contact Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `regulatory_authority_name` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority Name');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority Notes');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority Phone Number');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `phone_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `portal_url` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority Portal URL');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `regulatory_authority_status` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `regulatory_authority_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `regulatory_frameworks` SET TAGS ('pii_business_glossary_term' = 'Applicable Regulatory Frameworks');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `relationship_owner` SET TAGS ('pii_business_glossary_term' = 'Internal Relationship Owner');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `relationship_owner` SET TAGS ('pii_value_regex' = 'compliance|legal|procurement|project_management|safety');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `submission_system` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority Submission System');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_authority` ALTER COLUMN `website_url` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority Website URL');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` SET TAGS ('pii_subdomain' = 'permit_oversight');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `waiver_exemption_id` SET TAGS ('pii_business_glossary_term' = 'Waiver Exemption ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Related Permit ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Related Contract ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `attached_document_count` SET TAGS ('pii_business_glossary_term' = 'Attached Document Count');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `authority_code` SET TAGS ('pii_business_glossary_term' = 'Authority Code');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `compliance_evidence_url` SET TAGS ('pii_business_glossary_term' = 'Compliance Evidence URL');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `conditions_summary` SET TAGS ('pii_business_glossary_term' = 'Conditions Summary');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|CAD|EUR|GBP|AUD');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `evidence_url` SET TAGS ('pii_business_glossary_term' = 'Evidence URL');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `financial_impact_estimate` SET TAGS ('pii_business_glossary_term' = 'Financial Impact Estimate');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `granting_authority` SET TAGS ('pii_business_glossary_term' = 'Granting Authority');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `is_confidential` SET TAGS ('pii_business_glossary_term' = 'Confidential Flag');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `jurisdiction` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `jurisdiction` SET TAGS ('pii_value_regex' = 'USA|CAN|MEX|GBR|AUS');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `last_monitoring_date` SET TAGS ('pii_business_glossary_term' = 'Last Monitoring Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `monitoring_frequency` SET TAGS ('pii_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `monitoring_frequency` SET TAGS ('pii_value_regex' = 'daily|weekly|monthly|quarterly|annually');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `monitoring_requirements` SET TAGS ('pii_business_glossary_term' = 'Monitoring Requirements');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `next_monitoring_date` SET TAGS ('pii_business_glossary_term' = 'Next Monitoring Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `regulation_section` SET TAGS ('pii_business_glossary_term' = 'Regulation Section');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `renewal_date` SET TAGS ('pii_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `renewal_required_flag` SET TAGS ('pii_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `scope_description` SET TAGS ('pii_business_glossary_term' = 'Scope Description');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `status_reason` SET TAGS ('pii_business_glossary_term' = 'Status Reason');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `waiver_category` SET TAGS ('pii_business_glossary_term' = 'Waiver Category');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `waiver_category` SET TAGS ('pii_value_regex' = 'temporary|permanent|conditional');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `waiver_exemption_status` SET TAGS ('pii_business_glossary_term' = 'Waiver Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `waiver_exemption_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|revoked|expired');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `waiver_number` SET TAGS ('pii_business_glossary_term' = 'Waiver Number');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `waiver_type` SET TAGS ('pii_business_glossary_term' = 'Waiver Type');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `waiver_type` SET TAGS ('pii_value_regex' = 'regulatory|environmental|safety|financial|design');
ALTER TABLE `vibe_construction_v1`.`compliance`.`waiver_exemption` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` SET TAGS ('pii_subdomain' = 'regulatory_governance');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_change_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Change ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Owner ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_authority_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `superseded_regulatory_change_id` SET TAGS ('pii_business_glossary_term' = 'Superseded Regulatory Change Id');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `superseded_regulatory_change_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `affected_jurisdictions` SET TAGS ('pii_business_glossary_term' = 'Affected Jurisdictions');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `affected_obligations` SET TAGS ('pii_business_glossary_term' = 'Affected Obligations');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `affected_projects` SET TAGS ('pii_business_glossary_term' = 'Affected Projects');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `attached_document_count` SET TAGS ('pii_business_glossary_term' = 'Attached Document Count');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `audit_trail_notes` SET TAGS ('pii_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `change_authority` SET TAGS ('pii_business_glossary_term' = 'Change Authority');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `change_description` SET TAGS ('pii_business_glossary_term' = 'Change Description');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `change_number` SET TAGS ('pii_business_glossary_term' = 'Change Number');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `change_review_status` SET TAGS ('pii_business_glossary_term' = 'Change Review Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `change_review_status` SET TAGS ('pii_value_regex' = 'pending|reviewed|approved|rejected');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `change_source` SET TAGS ('pii_business_glossary_term' = 'Change Source');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `change_type` SET TAGS ('pii_business_glossary_term' = 'Change Type');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `change_type` SET TAGS ('pii_value_regex' = 'new|amended|repealed');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `classification` SET TAGS ('pii_business_glossary_term' = 'Regulatory Change Classification');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `classification` SET TAGS ('pii_value_regex' = 'environmental|safety|building_code|financial|labor|privacy');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `compliance_category` SET TAGS ('pii_business_glossary_term' = 'Compliance Category');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `compliance_evidence_url` SET TAGS ('pii_business_glossary_term' = 'Compliance Evidence URL');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `financial_impact_amount` SET TAGS ('pii_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `financial_impact_currency` SET TAGS ('pii_business_glossary_term' = 'Financial Impact Currency');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `impact_summary` SET TAGS ('pii_business_glossary_term' = 'Impact Summary');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_deadline` SET TAGS ('pii_business_glossary_term' = 'Implementation Deadline');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_status` SET TAGS ('pii_business_glossary_term' = 'Implementation Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_status` SET TAGS ('pii_value_regex' = 'not_started|partial|completed|failed');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_status_date` SET TAGS ('pii_business_glossary_term' = 'Implementation Status Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `is_mandatory` SET TAGS ('pii_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `jurisdiction_type` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction Type');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `publication_date` SET TAGS ('pii_business_glossary_term' = 'Publication Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulation_code` SET TAGS ('pii_business_glossary_term' = 'Regulation Code');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_body` SET TAGS ('pii_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_change_status` SET TAGS ('pii_business_glossary_term' = 'Regulatory Change Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_change_status` SET TAGS ('pii_value_regex' = 'pending|in_progress|implemented|deferred|rejected');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `required_actions` SET TAGS ('pii_business_glossary_term' = 'Required Actions');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `source_reference` SET TAGS ('pii_business_glossary_term' = 'Source Reference');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `stakeholder_impact` SET TAGS ('pii_business_glossary_term' = 'Stakeholder Impact');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_change` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` SET TAGS ('pii_subdomain' = 'audit_assurance');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `finding_id` SET TAGS ('pii_business_glossary_term' = 'Finding Identifier');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `assessment_id` SET TAGS ('pii_business_glossary_term' = 'Assessment Id');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project Id');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `source_finding_id` SET TAGS ('pii_business_glossary_term' = 'Source Finding Id');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `source_finding_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `corrective_action` SET TAGS ('pii_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `finding_description` SET TAGS ('pii_business_glossary_term' = 'Description');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `finding_number` SET TAGS ('pii_business_glossary_term' = 'Finding Number');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `finding_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `finding_type` SET TAGS ('pii_business_glossary_term' = 'Type');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `impact_amount` SET TAGS ('pii_business_glossary_term' = 'Impact Amount');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `is_financial_related` SET TAGS ('pii_business_glossary_term' = 'Is Financial Related');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `is_privacy_related` SET TAGS ('pii_business_glossary_term' = 'Is Privacy Related');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `location_code` SET TAGS ('pii_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `reported_by` SET TAGS ('pii_business_glossary_term' = 'Reported By');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `reported_date` SET TAGS ('pii_business_glossary_term' = 'Reported Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `resolution_date` SET TAGS ('pii_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `severity_score` SET TAGS ('pii_business_glossary_term' = 'Severity Score');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `source_record_reference` SET TAGS ('pii_business_glossary_term' = 'Source Record Reference');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Title');
ALTER TABLE `vibe_construction_v1`.`compliance`.`finding` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` SET TAGS ('pii_subdomain' = 'audit_assurance');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `audit_report_id` SET TAGS ('pii_business_glossary_term' = 'Audit Report Identifier');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `parent_audit_report_id` SET TAGS ('pii_business_glossary_term' = 'Parent Audit Report Id');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `parent_audit_report_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `attached_files_count` SET TAGS ('pii_business_glossary_term' = 'Attached Files Count');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `audit_period_end` SET TAGS ('pii_business_glossary_term' = 'Audit Period End');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `audit_period_start` SET TAGS ('pii_business_glossary_term' = 'Audit Period Start');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `audit_report_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `audit_scope` SET TAGS ('pii_business_glossary_term' = 'Audit Scope');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `auditor_email` SET TAGS ('pii_business_glossary_term' = 'Auditor Email');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `auditor_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `auditor_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `auditor_name` SET TAGS ('pii_business_glossary_term' = 'Auditor Name');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `auditor_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `auditor_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `critical_findings_count` SET TAGS ('pii_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `document_path` SET TAGS ('pii_business_glossary_term' = 'Document Path');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `findings_summary` SET TAGS ('pii_business_glossary_term' = 'Findings Summary');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `noncritical_findings_count` SET TAGS ('pii_business_glossary_term' = 'Noncritical Findings Count');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `overall_score` SET TAGS ('pii_business_glossary_term' = 'Overall Score');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `remediation_due_date` SET TAGS ('pii_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `report_name` SET TAGS ('pii_business_glossary_term' = 'Report Name');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `report_number` SET TAGS ('pii_business_glossary_term' = 'Report Number');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `report_type` SET TAGS ('pii_business_glossary_term' = 'Report Type');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `risk_rating` SET TAGS ('pii_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `total_findings` SET TAGS ('pii_business_glossary_term' = 'Total Findings');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`audit_report` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` SET TAGS ('pii_subdomain' = 'permit_oversight');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` SET TAGS ('pii_ssot_role' = 'master');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` SET TAGS ('pii_ssot_resolved_against' = 'site.site_permit');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` SET TAGS ('pii_ssot_distinct' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` SET TAGS ('pii_ssot_scope' = 'compliance');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` SET TAGS ('pii_ssot_counterpart' = 'site.site_permit');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` SET TAGS ('pii_ssot_master' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Permit ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Permit Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `regulatory_authority_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority Id');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `regulatory_authority_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `compliance_evidence_url` SET TAGS ('pii_business_glossary_term' = 'Compliance Evidence URL');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `compliance_permit_status` SET TAGS ('pii_business_glossary_term' = 'Permit Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `compliance_permit_status` SET TAGS ('pii_value_regex' = 'applied|under_review|approved|issued|expired|revoked');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Overall Compliance Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|partial|pending');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `condition_count` SET TAGS ('pii_business_glossary_term' = 'Condition Count');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_ssot_source' = 'site.site_permit');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `documents_attached_count` SET TAGS ('pii_business_glossary_term' = 'Attached Documents Count');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `expiry_date` SET TAGS ('pii_ssot_source' = 'site.site_permit');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `fee_amount` SET TAGS ('pii_business_glossary_term' = 'Permit Fee Amount');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `fee_amount` SET TAGS ('pii_ssot_source' = 'site.site_permit');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `fee_currency` SET TAGS ('pii_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `fee_currency` SET TAGS ('pii_ssot_source' = 'site.site_permit');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `fee_paid_date` SET TAGS ('pii_business_glossary_term' = 'Fee Paid Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `fee_paid_flag` SET TAGS ('pii_business_glossary_term' = 'Fee Paid Flag');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `issue_date` SET TAGS ('pii_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `next_condition_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Condition Due Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `permit_category` SET TAGS ('pii_business_glossary_term' = 'Permit Category');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `permit_category` SET TAGS ('pii_value_regex' = 'public|private|joint_venture|government');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `permit_category` SET TAGS ('pii_ssot_source' = 'site.site_permit');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `permit_number` SET TAGS ('pii_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `permit_number` SET TAGS ('pii_ssot_source' = 'site.site_permit');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `permit_type` SET TAGS ('pii_business_glossary_term' = 'Permit Type (e.g., Building, Excavation, Environmental, Utility, Demolition, Occupancy)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `permit_type` SET TAGS ('pii_value_regex' = 'building|excavation|environmental|utility|demolition|occupancy');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `permit_type` SET TAGS ('pii_ssot_source' = 'site.site_permit');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `renewal_date` SET TAGS ('pii_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `renewal_required_flag` SET TAGS ('pii_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `revocation_date` SET TAGS ('pii_business_glossary_term' = 'Revocation Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Permit Risk Level');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `suspension_flag` SET TAGS ('pii_business_glossary_term' = 'Suspension Flag');
ALTER TABLE `vibe_construction_v1`.`compliance`.`regulatory_permit` ALTER COLUMN `suspension_reason` SET TAGS ('pii_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` SET TAGS ('pii_subdomain' = 'audit_assurance');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` SET TAGS ('pii_ssot_role' = 'master');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` SET TAGS ('pii_ssot_resolved_against' = 'sustainability.sustainability_action');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` SET TAGS ('pii_ssot_distinct' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` SET TAGS ('pii_ssot_scope' = 'compliance');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` SET TAGS ('pii_ssot_counterpart' = 'sustainability.sustainability_action');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` SET TAGS ('pii_ssot_master' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `remediation_action_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Action ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Related Permit ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `document_register_id` SET TAGS ('pii_business_glossary_term' = 'Evidence Document ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `gl_account_id` SET TAGS ('pii_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `hr_org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Owner Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Party ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `project_budget_id` SET TAGS ('pii_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `iso_audit_id` SET TAGS ('pii_business_glossary_term' = 'Related Audit ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `finding_id` SET TAGS ('pii_business_glossary_term' = 'Source Finding ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `action_number` SET TAGS ('pii_business_glossary_term' = 'Action Number (ACT_NO)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `action_type` SET TAGS ('pii_business_glossary_term' = 'Action Type');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `action_type` SET TAGS ('pii_value_regex' = 'corrective|preventive|improvement');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `closure_evidence_url` SET TAGS ('pii_business_glossary_term' = 'Closure Evidence URL');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Action Comments');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `completed_date` SET TAGS ('pii_business_glossary_term' = 'Action Completion Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `compliance_action_description` SET TAGS ('pii_business_glossary_term' = 'Action Description');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `compliance_action_status` SET TAGS ('pii_business_glossary_term' = 'Action Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `compliance_action_status` SET TAGS ('pii_value_regex' = 'open|in_progress|closed|cancelled|deferred');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `compliance_area` SET TAGS ('pii_business_glossary_term' = 'Compliance Area');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `compliance_area` SET TAGS ('pii_value_regex' = 'safety|environment|quality|financial|legal|ethics');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `corrective_measure` SET TAGS ('pii_business_glossary_term' = 'Corrective Measure');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `cost_actual` SET TAGS ('pii_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `cost_estimate` SET TAGS ('pii_business_glossary_term' = 'Cost Estimate');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Action Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `currency_code` SET TAGS ('pii_ssot_source' = 'sustainability.sustainability_action');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Action Due Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `external_authority_name` SET TAGS ('pii_business_glossary_term' = 'External Authority Name');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `external_notice_date` SET TAGS ('pii_business_glossary_term' = 'External Notice Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `is_external` SET TAGS ('pii_business_glossary_term' = 'External Authority Indicator');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `is_repeat_action` SET TAGS ('pii_business_glossary_term' = 'Repeat Action Indicator');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `mitigation_plan` SET TAGS ('pii_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `monitoring_end_date` SET TAGS ('pii_business_glossary_term' = 'Monitoring End Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `monitoring_frequency` SET TAGS ('pii_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `monitoring_frequency` SET TAGS ('pii_value_regex' = 'daily|weekly|monthly|quarterly|annually');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `monitoring_required` SET TAGS ('pii_business_glossary_term' = 'Monitoring Required Indicator');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `monitoring_start_date` SET TAGS ('pii_business_glossary_term' = 'Monitoring Start Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Action Priority');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `priority` SET TAGS ('pii_ssot_source' = 'sustainability.sustainability_action');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `repeat_action_count` SET TAGS ('pii_business_glossary_term' = 'Repeat Action Count');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `root_cause` SET TAGS ('pii_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `sustainability_action_id` SET TAGS ('pii_business_glossary_term' = 'Sustainability Action Id');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `sustainability_action_id` SET TAGS ('pii_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Action Last Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`remediation_action` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Action Verification Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` SET TAGS ('pii_subdomain' = 'audit_assurance');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` SET TAGS ('pii_ssot_role' = 'reference');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` SET TAGS ('pii_ssot_master' = 'schedule.schedule_calendar');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` SET TAGS ('pii_ssot_resolved_against' = 'schedule.schedule_calendar');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` SET TAGS ('pii_ssot' = 'compliance.compliance_calendar');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` SET TAGS ('pii_ssot_distinct' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` SET TAGS ('pii_ssot_scope' = 'compliance');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` SET TAGS ('pii_ssot_counterpart' = 'schedule.schedule_calendar');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `obligation_calendar_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Calendar Entry ID');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Owner Identifier');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `parent_compliance_calendar_id` SET TAGS ('pii_business_glossary_term' = 'Parent Compliance Calendar Id');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `parent_compliance_calendar_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Related Contract Identifier');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Related Project Identifier');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `schedule_calendar_id` SET TAGS ('pii_business_glossary_term' = 'Schedule Calendar Id');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `schedule_calendar_id` SET TAGS ('pii_ssot_reference' = 'true');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `attachment_count` SET TAGS ('pii_business_glossary_term' = 'Attachment Count');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `completion_date` SET TAGS ('pii_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `compliance_calendar_status` SET TAGS ('pii_business_glossary_term' = 'Entry Status');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `compliance_calendar_status` SET TAGS ('pii_value_regex' = 'pending|completed|overdue|cancelled');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `compliance_category` SET TAGS ('pii_business_glossary_term' = 'Compliance Category');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `compliance_category` SET TAGS ('pii_value_regex' = 'safety|environment|quality|financial|privacy|security');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `created_timestamp` SET TAGS ('pii_ssot_source' = 'schedule.schedule_calendar');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `deadline_date` SET TAGS ('pii_business_glossary_term' = 'Deadline Date');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `deadline_type` SET TAGS ('pii_business_glossary_term' = 'Deadline Type (e.g., Permit, Certification, Audit, Report, Inspection, Training)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `deadline_type` SET TAGS ('pii_value_regex' = 'permit|certification|audit|report|inspection|training');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `entry_code` SET TAGS ('pii_business_glossary_term' = 'Calendar Entry Code');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `escalation_path` SET TAGS ('pii_business_glossary_term' = 'Escalation Path Description');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `escalation_triggered_flag` SET TAGS ('pii_business_glossary_term' = 'Escalation Triggered Flag');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `escalation_triggered_timestamp` SET TAGS ('pii_business_glossary_term' = 'Escalation Triggered Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `jurisdiction` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `jurisdiction` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `overdue_flag` SET TAGS ('pii_business_glossary_term' = 'Overdue Flag');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `priority` SET TAGS ('pii_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `priority` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `regulatory_body` SET TAGS ('pii_business_glossary_term' = 'Regulatory Authority Name');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `reminder_lead_days` SET TAGS ('pii_business_glossary_term' = 'Reminder Lead Time (Days)');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `reminder_sent_flag` SET TAGS ('pii_business_glossary_term' = 'Reminder Sent Flag');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `reminder_sent_timestamp` SET TAGS ('pii_business_glossary_term' = 'Reminder Sent Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `source_reference` SET TAGS ('pii_business_glossary_term' = 'Source Obligation or Permit Reference');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Calendar Entry Title');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`compliance`.`obligation_calendar` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_ssot_source' = 'schedule.schedule_calendar');
