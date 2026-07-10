-- Schema for Domain: safeguarding | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 18:48:26

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`safeguarding` COMMENT 'Manages Protection from Sexual Exploitation and Abuse (PSEA), child safeguarding, staff conduct investigations, survivor support, and organizational safeguarding policies and incident tracking';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` (
    `psea_policy_id` BIGINT COMMENT 'Unique identifier for the PSEA policy record. Primary key.',
    `org_unit_id` BIGINT COMMENT 'add column org_unit_id (BIGINT) with FK to workforce.org_unit.org_unit_id - PSEA policies are owned by specific organizational units and this ownership link is missing',
    `primary_superseded_policy_psea_policy_id` BIGINT COMMENT 'Reference to the previous policy version that this policy replaces. Null if this is the first version.',
    `acknowledgment_audience` STRING COMMENT 'Target audience required to acknowledge the policy (e.g., All Staff, Field Staff, Volunteers, Partners, Board Members).',
    `acknowledgment_deadline_days` STRING COMMENT 'Number of days from policy effective date or staff onboarding within which acknowledgment must be completed.',
    `approval_authority` STRING COMMENT 'Name or title of the individual or body that approved the policy (e.g., Board of Directors, Executive Director, Country Director).',
    `approval_date` DATE COMMENT 'Date when the policy was formally approved by the designated authority.',
    `psea_policy_category` STRING COMMENT 'Functional category of the policy within the safeguarding framework.. Valid values are `Prevention|Response|Investigation|Accountability|Training|Reporting`',
    `compliance_standard` STRING COMMENT 'Industry or humanitarian standards the policy aligns with (e.g., CHS, Sphere, HAP, Keeping Children Safe).',
    `confidentiality_clause` STRING COMMENT 'Summary of confidentiality and data protection provisions within the policy.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for country-specific policies. Null for global policies.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the policy record was first created in the system.',
    `psea_policy_description` STRING COMMENT 'Detailed summary of the policy purpose, scope, and key provisions.',
    `document_language` STRING COMMENT 'ISO 639-1 two-letter language code of the policy document (e.g., en, fr, es, ar).. Valid values are `^[a-z]{2}$`',
    `document_url` STRING COMMENT 'URL or file path to the full policy document stored in the document management system.',
    `effective_date` DATE COMMENT 'Date when the policy becomes binding and enforceable across the organization.',
    `expiration_date` DATE COMMENT 'Date when the policy is scheduled to expire or be reviewed. Null for policies without expiration.',
    `last_modified_by` STRING COMMENT 'Name or identifier of the individual who last modified the policy record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the policy record was last updated in the system.',
    `legal_framework_reference` STRING COMMENT 'Citation of relevant legal or regulatory frameworks that inform the policy (e.g., UN Convention on the Rights of the Child, local child protection laws).',
    `mandatory_acknowledgment_flag` BOOLEAN COMMENT 'Indicates whether staff, volunteers, or partners are required to formally acknowledge and sign this policy.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory policy review.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the policy document or its implementation.',
    `number` STRING COMMENT 'Externally-known unique identifier for the policy document, typically following organizational numbering convention (e.g., PSEA-2024-001).. Valid values are `^[A-Z]{2,4}-[0-9]{4}-[0-9]{3}$`',
    `owner` STRING COMMENT 'Department or role responsible for maintaining and updating the policy (e.g., Safeguarding Team, Human Resources, Compliance).',
    `reporting_mechanism_description` STRING COMMENT 'Description of the reporting channels and procedures outlined in the policy for safeguarding concerns or violations.',
    `review_cycle_months` STRING COMMENT 'Frequency in months at which the policy must be reviewed and updated (e.g., 12, 24, 36).',
    `sanctions_description` STRING COMMENT 'Description of disciplinary actions or sanctions for policy violations.',
    `scope` STRING COMMENT 'Geographic or organizational scope of policy applicability (global, country-specific, program-specific).. Valid values are `Global|Regional|Country|Program|Project`',
    `psea_policy_status` STRING COMMENT 'Current lifecycle status of the policy document.. Valid values are `Draft|Under Review|Approved|Active|Superseded|Archived`',
    `title` STRING COMMENT 'Official title of the PSEA, child safeguarding, or code of conduct policy document.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether formal training is required for this policy.',
    `translation_available_flag` BOOLEAN COMMENT 'Indicates whether translations of the policy are available in other languages.',
    `psea_policy_type` STRING COMMENT 'Classification of the safeguarding policy document type. [ENUM-REF-CANDIDATE: PSEA|Child Safeguarding|Code of Conduct|Whistleblower|Survivor Support|Beneficiary Protection|Staff Conduct — 7 candidates stripped; promote to reference product]',
    `version_number` STRING COMMENT 'Version identifier of the policy document (e.g., 1.0, 2.1).. Valid values are `^[0-9]+.[0-9]+$`',
    `created_by` STRING COMMENT 'Name or identifier of the individual who created the policy record.',
    CONSTRAINT pk_psea_policy PRIMARY KEY(`psea_policy_id`)
) COMMENT 'Master catalog of organizational Protection from Sexual Exploitation and Abuse (PSEA) policies, child safeguarding policies, and staff code of conduct documents. Captures policy version, effective date, scope (global, country, program), approval authority, mandatory acknowledgment requirements, and review cycle. Serves as the authoritative reference for all safeguarding policy obligations across the organization.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` (
    `safeguarding_incident_id` BIGINT COMMENT 'Unique identifier for the safeguarding incident record. Primary key for the safeguarding incident entity.',
    `focal_point_id` BIGINT COMMENT 'Foreign key linking to safeguarding.focal_point. Business justification: Safeguarding incidents must be assigned to designated safeguarding focal points for case management and response coordination. Currently safeguarding_incident has investigator_name as STRING but no FK',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Safeguarding incidents in grant-funded programs must link to the specific award for donor notification requirements (often 24-72 hours), compliance reporting, risk management, and potential award modi',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Incidents occur within organizational units tracked as cost centers. Incident response costs (investigation, survivor support, legal) must be allocated to the responsible cost center for budget tracki',
    `country_office_id` BIGINT COMMENT 'Identifier of the country office responsible for managing and investigating this safeguarding incident.',
    `intervention_id` BIGINT COMMENT 'Identifier of the program or project context in which the safeguarding incident occurred, if applicable.',
    `parent_safeguarding_incident_id` BIGINT COMMENT 'Self-referencing FK on safeguarding_incident (linked_safeguarding_incident_id)',
    `partnership_agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Safeguarding incidents occurring under partnership agreements must be tracked for partner performance reviews, donor reporting obligations, and agreement renewal decisions. Essential for accountabilit',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse. Business justification: Safeguarding incidents frequently occur at warehouse facilities (staff misconduct, beneficiary contact at storage sites). Required for incident location tracking, facility-specific risk assessment, an',
    `alleged_perpetrator_name` STRING COMMENT 'The name of the alleged perpetrator, if known. Highly sensitive and access-restricted during investigation.',
    `alleged_perpetrator_type` STRING COMMENT 'The category of the alleged perpetrator: staff member, volunteer, partner organization personnel, contractor, beneficiary, external party, or unknown. [ENUM-REF-CANDIDATE: staff|volunteer|partner|contractor|beneficiary|external|unknown — 7 candidates stripped; promote to reference product]',
    `anonymization_flag` BOOLEAN COMMENT 'Indicates whether the incident report has been anonymized to protect the identity of the reporter or survivor. True if anonymized, False if identifiable information is retained.',
    `corrective_action_plan` STRING COMMENT 'Description of organizational corrective actions, policy changes, or systemic improvements implemented in response to this incident to prevent recurrence.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this safeguarding incident record was first created in the system.',
    `safeguarding_incident_date` DATE COMMENT 'The date when the safeguarding incident occurred or is alleged to have occurred. This is the business event date, distinct from reporting date.',
    `safeguarding_incident_description` STRING COMMENT 'Detailed narrative description of the safeguarding incident, including circumstances, alleged actions, and context. Highly sensitive and access-restricted.',
    `disciplinary_action_taken` STRING COMMENT 'Description of disciplinary or corrective action taken as a result of the investigation (e.g., termination, suspension, warning, training, policy change).',
    `donor_notification_required_flag` BOOLEAN COMMENT 'Indicates whether donor notification is required per grant agreement terms for this type and severity of safeguarding incident. True if notification required, False otherwise.',
    `donor_notified_date` DATE COMMENT 'The date when the donor was formally notified of the safeguarding incident, if notification was required.',
    `investigation_completion_date` DATE COMMENT 'The date when the investigation was completed and findings were documented.',
    `investigation_outcome` STRING COMMENT 'The final outcome of the investigation: substantiated (evidence supports allegation), unsubstantiated (insufficient evidence), inconclusive, withdrawn by reporter, or pending completion.. Valid values are `substantiated|unsubstantiated|inconclusive|withdrawn|pending`',
    `investigation_required_flag` BOOLEAN COMMENT 'Indicates whether a formal investigation is required for this incident. True if investigation needed, False if incident can be resolved through other means.',
    `investigation_start_date` DATE COMMENT 'The date when the formal investigation of the safeguarding incident was initiated.',
    `investigator_name` STRING COMMENT 'The name of the lead investigator assigned to this safeguarding incident case.',
    `law_enforcement_notified_flag` BOOLEAN COMMENT 'Indicates whether local law enforcement or legal authorities were notified of this incident. True if notified, False otherwise.',
    `lessons_learned` STRING COMMENT 'Key lessons learned from this safeguarding incident and its investigation, used for organizational learning and safeguarding policy improvement.',
    `location_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the safeguarding incident occurred.. Valid values are `^[A-Z]{3}$`',
    `location_district` STRING COMMENT 'The district or locality where the incident occurred, providing more granular geographic context.',
    `location_region` STRING COMMENT 'The administrative region, province, or state where the incident occurred within the country.',
    `location_site` STRING COMMENT 'The specific site, facility, or field location where the incident occurred (e.g., distribution center, health clinic, office, camp).',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this safeguarding incident record was last updated or modified.',
    `number` STRING COMMENT 'Externally-visible unique reference number for the safeguarding incident, used for tracking and communication with stakeholders.. Valid values are `^SGI-[0-9]{8}$`',
    `referral_made_flag` BOOLEAN COMMENT 'Indicates whether the survivor or case was referred to external services (health, legal, protection, psychosocial support). True if referral made, False otherwise.',
    `reported_date` DATE COMMENT 'The date when the safeguarding incident was first reported to the organization through any channel.',
    `reporter_contact` STRING COMMENT 'Contact information (phone or email) for the reporter, if provided and consent given for follow-up communication.',
    `reporter_name` STRING COMMENT 'The full name of the person who reported the safeguarding incident, if known and consent provided. May be null for anonymous reports.',
    `reporter_type` STRING COMMENT 'The category of person who reported the incident: beneficiary, staff member, volunteer, partner organization staff, community member, or anonymous reporter.. Valid values are `beneficiary|staff|volunteer|partner|community_member|anonymous`',
    `reporting_channel` STRING COMMENT 'The channel or mechanism through which the safeguarding incident was reported (hotline, direct report to manager, community feedback mechanism, email, anonymous reporting box, third-party reporting).. Valid values are `hotline|direct_report|community_feedback|email|anonymous_box|third_party`',
    `severity_level` STRING COMMENT 'Initial severity classification of the safeguarding incident based on potential harm, organizational risk, and urgency of response required.. Valid values are `critical|high|medium|low`',
    `safeguarding_incident_status` STRING COMMENT 'Current lifecycle status of the safeguarding incident in the investigation and resolution workflow.. Valid values are `reported|under_review|investigation|resolved|closed|dismissed`',
    `subtype` STRING COMMENT 'Detailed sub-classification of the incident type providing additional specificity (e.g., sexual harassment, physical abuse, financial fraud, conflict of interest).',
    `survivor_age_group` STRING COMMENT 'Age group classification of the survivor to support child safeguarding analysis without revealing precise age. Used for statistical reporting and risk assessment.. Valid values are `child_0_5|child_6_12|child_13_17|adult_18_59|elderly_60_plus|unknown`',
    `survivor_gender` STRING COMMENT 'Gender of the survivor, used for Gender-Based Violence (GBV) analysis and safeguarding pattern identification.. Valid values are `male|female|non_binary|prefer_not_to_say|unknown`',
    `survivor_involved_flag` BOOLEAN COMMENT 'Indicates whether there is an identified survivor or victim involved in this safeguarding incident. True if survivor identified, False if no survivor or incident does not involve a victim.',
    `survivor_support_provided_flag` BOOLEAN COMMENT 'Indicates whether survivor support services (medical, psychosocial, legal, safety) were provided. True if support provided, False otherwise.',
    `time` TIMESTAMP COMMENT 'The precise timestamp when the safeguarding incident occurred, if known. Provides time-of-day precision beyond the incident date.',
    `safeguarding_incident_type` STRING COMMENT 'Primary classification of the safeguarding incident: Sexual Exploitation and Abuse (SEA), child safeguarding violations, harassment, fraud, staff misconduct, or other protection breaches.. Valid values are `SEA|child_abuse|harassment|fraud|staff_misconduct|other`',
    CONSTRAINT pk_safeguarding_incident PRIMARY KEY(`safeguarding_incident_id`)
) COMMENT 'Core transactional record for every reported safeguarding incident including sexual exploitation and abuse (SEA), child safeguarding violations, harassment, staff misconduct, and protection breaches. Captures incident date, location, incident type (SEA, child abuse, harassment, fraud, other), reporting channel (hotline, direct report, community feedback), initial severity classification, anonymization flag, and current investigation status. SSOT for all safeguarding incident intake across the organization.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` (
    `investigation_id` BIGINT COMMENT 'Unique identifier for the safeguarding investigation record. Primary key.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Investigations of safeguarding incidents in grant contexts require award linkage for donor notification obligations, compliance with special award conditions, and tracking investigation costs against ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Investigations are conducted by specific departments/units represented as cost centers. Investigation costs (staff time, travel, external investigators) must be allocated to the responsible cost cente',
    `constituent_id` BIGINT COMMENT 'Foreign key linking to donor.constituent. Business justification: Investigations may involve donors as subjects or witnesses. Critical for managing reputational risk, informing gift acceptance decisions, and coordinating between safeguarding and development teams wh',
    `parent_investigation_id` BIGINT COMMENT 'Self-referencing FK on investigation (linked_investigation_id)',
    `user_account_id` BIGINT COMMENT 'Reference to the user who last modified the investigation record.',
    `safeguarding_incident_id` BIGINT COMMENT 'Reference to the safeguarding incident that triggered this investigation. Links to the incident intake record.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or external investigator assigned as the lead for this investigation.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse. Business justification: Investigations of warehouse-based safeguarding incidents require facility-specific context. Required for facility security reviews, staff conduct investigations at storage sites, and warehouse-level c',
    `actual_completion_date` DATE COMMENT 'Actual date when the investigation was completed and final findings were documented. Null if investigation is still in progress.',
    `investigation_category` STRING COMMENT 'Primary safeguarding category under investigation: Protection from Sexual Exploitation and Abuse (PSEA), child safeguarding, staff misconduct, Gender-Based Violence (GBV), fraud, or harassment.. Valid values are `psea|child_safeguarding|staff_misconduct|gbv|fraud|harassment`',
    `closure_notes` STRING COMMENT 'Final notes and comments recorded at the time of investigation closure, including any outstanding issues, limitations, or contextual information.',
    `confidentiality_level` STRING COMMENT 'Classification level for the investigation record and findings: public (anonymized summary), internal (staff access), confidential (management only), or restricted (need-to-know basis).. Valid values are `public|internal|confidential|restricted`',
    `cost_usd` DECIMAL(18,2) COMMENT 'Total cost of conducting the investigation in USD, including investigator fees, travel, translation, legal counsel, and administrative expenses. Confidential business information.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the investigation record was first created in the system.',
    `disciplinary_action_taken` STRING COMMENT 'Description of disciplinary actions taken against subjects of the investigation, including warnings, suspension, termination, or referral to law enforcement. Confidential business information.',
    `evidence_items_collected_count` STRING COMMENT 'Total number of evidence items collected and catalogued during the investigation, including documents, photographs, recordings, and physical evidence.',
    `external_reporting_date` DATE COMMENT 'Date when investigation findings were reported to external parties, if required. Null if no external reporting was required or if not yet reported.',
    `external_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether the investigation findings must be reported to external parties such as donors, UN agencies, law enforcement, or regulatory bodies.',
    `final_determination` STRING COMMENT 'Final determination of the investigation: substantiated (allegations proven), unsubstantiated (allegations not proven), inconclusive (insufficient evidence), or partially substantiated (some allegations proven).. Valid values are `substantiated|unsubstantiated|inconclusive|partially_substantiated`',
    `findings_summary` STRING COMMENT 'Executive summary of the investigation findings, including key facts established, credibility assessments, and analysis of evidence. Confidential business information.',
    `follow_up_actions_required` STRING COMMENT 'Description of ongoing follow-up actions required after investigation closure, including monitoring of corrective actions, policy implementation, or survivor support continuation.',
    `interviews_conducted_count` STRING COMMENT 'Total number of formal interviews conducted during the investigation, including complainants, witnesses, subjects, and key informants.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the investigation record was last updated or modified.',
    `law_enforcement_referral_date` DATE COMMENT 'Date when the case was referred to law enforcement authorities. Null if no referral was made.',
    `law_enforcement_referral_flag` BOOLEAN COMMENT 'Indicates whether the investigation findings were referred to law enforcement or criminal justice authorities for potential prosecution.',
    `lessons_learned` STRING COMMENT 'Key lessons learned from the investigation process and findings, used to inform organizational learning, policy updates, and prevention strategies.',
    `methodology` STRING COMMENT 'Description of the investigative approach and methods used, including interviews, document review, site visits, forensic analysis, and evidence collection procedures.',
    `policy_violations_identified` STRING COMMENT 'Comma-separated list of specific organizational policies, codes of conduct, or standards that were found to have been violated during the investigation.',
    `recommended_actions` STRING COMMENT 'Detailed recommendations for corrective actions, disciplinary measures, policy changes, or systemic improvements based on investigation findings. Confidential business information.',
    `reference_number` STRING COMMENT 'Externally-known unique reference number for the investigation, used in all official documentation and correspondence. Format: INV-YYYY-NNNNNN.. Valid values are `^INV-[0-9]{4}-[0-9]{6}$`',
    `report_document_url` STRING COMMENT 'URL or file path to the formal investigation report document stored in the document management system. Confidential business information.',
    `scope` STRING COMMENT 'Detailed description of the boundaries and focus areas of the investigation, including specific allegations, time periods, locations, and individuals involved.',
    `start_date` DATE COMMENT 'Date when the formal investigation was officially opened and investigative activities commenced.',
    `investigation_status` STRING COMMENT 'Current lifecycle status of the investigation: pending assignment of investigator, active investigation in progress, suspended pending additional information, completed with findings, or closed.. Valid values are `pending_assignment|active|suspended|completed|closed`',
    `survivor_support_provided` STRING COMMENT 'Description of support services provided to survivors or complainants, including Psychosocial Support (PSS), medical care, legal assistance, and safe accommodation.',
    `target_completion_date` DATE COMMENT 'Planned or target date by which the investigation is expected to be completed and findings delivered, based on organizational policy or donor requirements.',
    `team_members` STRING COMMENT 'Comma-separated list of staff IDs or names of additional team members supporting the investigation, including subject matter experts, translators, and support staff.',
    `terms_of_reference` STRING COMMENT 'Formal Terms of Reference (ToR) document outlining the investigation mandate, objectives, methodology, timeline, reporting requirements, and confidentiality protocols.',
    `investigation_type` STRING COMMENT 'Classification of the investigation approach: internal (conducted by organizational staff), external (third-party investigator), joint with UN/OCHA, joint with partner organization, or independent external review.. Valid values are `internal|external|joint_un_ocha|joint_partner|independent`',
    CONSTRAINT pk_investigation PRIMARY KEY(`investigation_id`)
) COMMENT 'Master record for each formal safeguarding investigation opened in response to a reported incident. Captures investigation reference number, investigation type (internal, external, joint with UN/OCHA), lead investigator assignment, investigation scope, terms of reference (ToR), start date, target completion date, actual completion date, findings summary, and final determination (substantiated, unsubstantiated, inconclusive). Distinct from the incident intake record — represents the formal investigative process lifecycle.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` (
    `investigation_action_id` BIGINT COMMENT 'Unique identifier for each investigation action record. Primary key for the investigation action entity.',
    `alleged_perpetrator_id` BIGINT COMMENT 'Foreign key linking to safeguarding.alleged_perpetrator. Business justification: Investigation actions often target or involve specific alleged perpetrators (interviews, evidence collection, interim measures). Currently investigation_action only links to investigation but not to t',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Individual investigation actions (interviews, site visits, evidence collection) incur direct costs tracked via action_cost_amount. These costs must be allocated to the cost center conducting the actio',
    `investigation_id` BIGINT COMMENT 'Reference to the parent safeguarding investigation case to which this action belongs. Links action to the overarching investigation.',
    `predecessor_investigation_action_id` BIGINT COMMENT 'Self-referencing FK on investigation_action (predecessor_investigation_action_id)',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or investigator responsible for executing this investigation action. Links to workforce or investigator master data.',
    `user_account_id` BIGINT COMMENT 'Identifier of the system user who created this investigation action record. Supports accountability and audit trail.',
    `survivor_record_id` BIGINT COMMENT 'Foreign key linking to safeguarding.survivor_record. Business justification: Investigation actions frequently involve survivors (witness interviews, support coordination, consent collection). Currently investigation_action has witness_statement_flag and survivor_support_provid',
    `approval_date` DATE COMMENT 'Date on which the investigation action was formally approved. Supports audit trail and compliance verification.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this investigation action requires formal approval before execution or closure. True if approval is needed, false otherwise.',
    `compliance_notes` STRING COMMENT 'Notes documenting compliance with organizational safeguarding policies, donor requirements, or regulatory standards during this action.',
    `confidentiality_level` STRING COMMENT 'Data classification level for this investigation action record. Determines access controls and handling requirements (public, internal, confidential, restricted).. Valid values are `public|internal|confidential|restricted`',
    `cost_amount` DECIMAL(18,2) COMMENT 'Direct cost incurred for this investigation action (e.g., travel expenses, expert consultation fees, translation services). Supports budget tracking and financial accountability.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the action cost amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this investigation action record was first created in the system. Audit field for data lineage and record lifecycle tracking.',
    `investigation_action_date` DATE COMMENT 'The date on which the investigation action was performed or is scheduled to be performed. Represents the principal business event timestamp for this action.',
    `investigation_action_description` STRING COMMENT 'Detailed narrative description of the investigation action taken. Captures the specifics of what was done, who was involved, and any relevant context.',
    `duration_minutes` STRING COMMENT 'Total duration of the investigation action in minutes. Calculated from start and end timestamps or manually recorded for resource tracking and workload analysis.',
    `end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the investigation action was completed. Used for duration calculation and workflow tracking.',
    `evidence_collected_flag` BOOLEAN COMMENT 'Indicates whether physical or documentary evidence was collected during this investigation action. True if evidence was gathered, false otherwise.',
    `evidence_reference_number` STRING COMMENT 'Reference identifier for evidence collected during this action. Links to evidence management system or document repository.',
    `external_authority_notified_flag` BOOLEAN COMMENT 'Indicates whether external authorities (e.g., law enforcement, regulatory bodies, United Nations Office for the Coordination of Humanitarian Affairs (OCHA)) were notified as part of this action.',
    `interim_measure_applied` STRING COMMENT 'Description of any interim protective or administrative measures applied during this action (e.g., suspension, reassignment, access restriction, no-contact order).',
    `location` STRING COMMENT 'Physical or virtual location where the investigation action took place (e.g., field office, remote interview, headquarters, community site).',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this investigation action record was last modified. Audit field for change tracking and data governance.',
    `next_action_description` STRING COMMENT 'Brief description of the next planned action or step in the investigation workflow. Provides continuity and planning context.',
    `next_action_due_date` DATE COMMENT 'Scheduled date by which the next investigation action or follow-up step is due. Supports case management workflow and ensures timely progression of the investigation.',
    `notification_date` DATE COMMENT 'Date on which external authorities or stakeholders were notified. Supports regulatory compliance and audit trail.',
    `number` STRING COMMENT 'Human-readable business identifier for the investigation action, typically formatted as a sequential or hierarchical code within the investigation (e.g., INV-2024-001-A01).',
    `outcome_notes` STRING COMMENT 'Confidential notes documenting the outcome, findings, or results of the investigation action. Captures key observations, evidence gathered, or conclusions reached.',
    `participant_count` STRING COMMENT 'Number of individuals who participated in or were present during the investigation action (e.g., number of interviewees, witnesses, or observers).',
    `priority_level` STRING COMMENT 'Priority classification of the investigation action. Indicates urgency and resource allocation needs (critical, high, medium, low).. Valid values are `critical|high|medium|low`',
    `referral_made_flag` BOOLEAN COMMENT 'Indicates whether a referral to external services or authorities was made as part of this action (e.g., referral to Psychosocial Support (PSS), legal services, or law enforcement).',
    `referral_organization` STRING COMMENT 'Name of the organization or service provider to which a referral was made (e.g., Civil Society Organization (CSO), Community-Based Organization (CBO), government agency).',
    `responsible_party_name` STRING COMMENT 'Name of the individual or team responsible for the investigation action. Provides human-readable identification of the action owner.',
    `risk_level` STRING COMMENT 'Risk assessment classification for this investigation action. Indicates potential harm, reputational risk, or safety concerns associated with the action.. Valid values are `critical|high|medium|low|minimal`',
    `start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the investigation action commenced. Used for detailed audit trail and duration tracking.',
    `investigation_action_status` STRING COMMENT 'Current lifecycle status of the investigation action. Tracks whether the action is planned, in progress, completed, cancelled, deferred, or pending review.. Valid values are `planned|in_progress|completed|cancelled|deferred|pending_review`',
    `survivor_support_provided_flag` BOOLEAN COMMENT 'Indicates whether survivor-centered support services were provided during or as a result of this investigation action (e.g., Psychosocial Support (PSS), medical care, legal assistance).',
    `investigation_action_type` STRING COMMENT 'Classification of the investigation action taken. Defines the nature of the investigative step performed (e.g., interview conducted, evidence collected, witness statement taken, referral made, interim measure applied). [ENUM-REF-CANDIDATE: interview_conducted|evidence_collected|witness_statement_taken|referral_made|interim_measure_applied|site_visit|document_review|expert_consultation|risk_assessment|follow_up_action — 10 candidates stripped; promote to reference product]',
    `witness_statement_flag` BOOLEAN COMMENT 'Indicates whether a formal witness statement was taken during this investigation action. True if statement was recorded, false otherwise.',
    CONSTRAINT pk_investigation_action PRIMARY KEY(`investigation_action_id`)
) COMMENT 'Transactional log of individual actions, steps, and milestones taken within a safeguarding investigation. Captures action type (interview conducted, evidence collected, witness statement taken, referral made, interim measure applied), action date, responsible party, outcome notes, and next action due date. Provides the operational audit trail for investigation progress and supports case management workflows.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` (
    `survivor_record_id` BIGINT COMMENT 'Unique identifier for the survivor record. Primary key for confidential safeguarding case tracking.',
    `registrant_id` BIGINT COMMENT 'Foreign key linking to beneficiary.registrant. Business justification: When consent and confidentiality protocols permit, linking survivor_record to registrant enables integrated case management across safeguarding and program systems, coordinates protection flags, ensur',
    `duplicate_of_survivor_record_id` BIGINT COMMENT 'Self-referencing FK on survivor_record (duplicate_of_survivor_record_id)',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member assigned as the primary support focal point for this survivor. Responsible for coordinating survivor-centered support services and case management.',
    `safeguarding_incident_id` BIGINT COMMENT 'Reference to the safeguarding incident record associated with this survivor. Links survivor support to the formal incident investigation and response.',
    `tertiary_survivor_last_modified_by_staff_staff_member_id` BIGINT COMMENT 'Identifier of the staff member who last modified this survivor record. Supports accountability and audit trail for sensitive data handling.',
    `access_restriction_level` STRING COMMENT 'Level of access control applied to this survivor record. Determines which staff roles can view or edit the record, enforcing need-to-know principle.. Valid values are `highly_restricted|restricted|confidential`',
    `age_group` STRING COMMENT 'Age bracket of the survivor at the time of incident reporting. Stored as range rather than exact age to reduce re-identification risk while enabling age-appropriate support planning.. Valid values are `child_0_5|child_6_11|child_12_17|adult_18_24|adult_25_59|elderly_60_plus`',
    `case_closure_notes` STRING COMMENT 'Confidential notes documenting the circumstances and outcomes at case closure. Supports case management quality assurance and learning.',
    `case_closure_reason` STRING COMMENT 'Reason for closing the survivor support case. Provides accountability and learning for case management quality.. Valid values are `support_completed|survivor_request|lost_contact|transferred_to_partner|other`',
    `confidentiality_breach_flag` BOOLEAN COMMENT 'Indicates whether a confidentiality breach has been identified in the handling of this survivors case. Triggers corrective action and accountability measures.',
    `consent_date` DATE COMMENT 'Date when the survivors consent status was documented or last updated. Essential for audit trail and ensuring time-bound consent validity.',
    `consent_status` STRING COMMENT 'Current status of survivors consent for information sharing with internal teams, external partners, or authorities. Governs data access and case coordination boundaries per survivor-centered approach.. Valid values are `full_consent|partial_consent|no_consent|consent_withdrawn|minor_guardian_consent`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this survivor record was first created in the system. Audit trail for data governance and case timeline tracking.',
    `data_retention_expiry_date` DATE COMMENT 'Date when this survivor record is scheduled for review or deletion per data retention policy. Ensures compliance with data minimization and survivor privacy obligations.',
    `economic_support_provided` BOOLEAN COMMENT 'Indicates whether economic assistance (cash, livelihood support, etc.) has been provided to the survivor. Supports survivor resilience and recovery.',
    `external_referral_made` BOOLEAN COMMENT 'Indicates whether the survivor has been referred to external service providers (health, legal, psychosocial, etc.). Tracks multi-agency coordination.',
    `gender` STRING COMMENT 'Self-identified gender of the survivor. Critical for Gender-Based Violence (GBV) analysis and ensuring gender-sensitive support services.. Valid values are `female|male|non_binary|prefer_not_to_say|other`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this survivor record was last updated. Critical for audit trail and ensuring data currency in active cases.',
    `legal_support_provided` BOOLEAN COMMENT 'Indicates whether legal assistance or referral to legal services has been provided to the survivor. Tracks access to justice pathways.',
    `medical_support_provided` BOOLEAN COMMENT 'Indicates whether medical or health services have been provided or facilitated for the survivor. Essential for comprehensive survivor care tracking.',
    `preferred_contact_method` STRING COMMENT 'Survivors preferred method for follow-up communication. Respects survivor autonomy and safety considerations in contact planning.. Valid values are `phone|email|in_person|community_focal_point|no_contact|other`',
    `psychosocial_support_provided` BOOLEAN COMMENT 'Indicates whether Psychosocial Support (PSS) services have been provided to the survivor as part of the response. Critical for tracking holistic survivor care.',
    `referral_source` STRING COMMENT 'Channel or source through which the survivor case was reported or referred to the safeguarding team. Important for understanding reporting pathways and community awareness.. Valid values are `self_reported|community_member|staff_member|partner_organization|hotline|other`',
    `safe_contact_email` STRING COMMENT 'Email address designated by survivor as safe for contact. Used only with explicit consent and when email is the preferred contact method.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `safe_contact_phone` STRING COMMENT 'Phone number designated by survivor as safe for contact. May differ from primary phone to protect confidentiality and safety.',
    `safety_plan_in_place` BOOLEAN COMMENT 'Indicates whether a formal safety plan has been developed and agreed with the survivor. Critical for survivor protection and risk mitigation.',
    `support_end_date` DATE COMMENT 'Date when survivor support services were concluded or case was closed. Nullable for ongoing support cases.',
    `support_start_date` DATE COMMENT 'Date when formal survivor support services were initiated. Marks the beginning of the organizations survivor-centered response.',
    `support_status` STRING COMMENT 'Current stage of survivor support services. Tracks progression through the survivor-centered response pathway from initial contact through case closure.. Valid values are `initial_contact|assessment_in_progress|active_support|support_completed|case_closed|declined_support`',
    `survivor_code` STRING COMMENT 'Pseudonymized or anonymized identifier assigned to protect survivor identity while enabling case tracking across systems. Used in place of real name to maintain confidentiality per PSEA protocols.',
    `survivor_type` STRING COMMENT 'Classification of the survivors relationship to the organization at the time of the incident. Determines applicable safeguarding protocols and support pathways.. Valid values are `beneficiary|staff|volunteer|community_member|child|partner_staff`',
    `vulnerability_notes` STRING COMMENT 'Confidential notes documenting specific vulnerabilities, risks, or special considerations for this survivor. Used to inform tailored support planning and risk mitigation.',
    CONSTRAINT pk_survivor_record PRIMARY KEY(`survivor_record_id`)
) COMMENT 'Confidential master record for each survivor or alleged victim involved in a safeguarding incident. Captures anonymized or pseudonymized identity (survivor code), age group, gender, survivor type (beneficiary, staff, community member, child), consent status for information sharing, preferred contact method, assigned survivor support focal point, and current support status. Maintained separately from beneficiary and staff records to enforce strict data access controls and confidentiality obligations under PSEA standards.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` (
    `survivor_support_plan_id` BIGINT COMMENT 'Unique identifier for the survivor support plan record. Primary key.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Survivor support services funded by specific grants must track the award for cost allocation, budget monitoring, donor reporting of safeguarding response activities, and demonstrating appropriate use ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Support plans are managed by specific organizational units (protection teams, case management units) tracked as cost centers. Costs for delivering support services must be allocated to the responsible',
    `country_office_id` BIGINT COMMENT 'Reference to the country office responsible for overseeing this survivor support plan and coordinating local service delivery.',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Survivor support services (psychosocial, medical, legal, housing) are funded from specific restricted or unrestricted funds. Donors require detailed tracking of fund usage for survivor assistance to e',
    `intervention_id` BIGINT COMMENT 'Reference to the safeguarding or protection program under which this survivor support plan is managed and funded.',
    `partner_org_id` BIGINT COMMENT 'Reference to the primary organization or partner responsible for delivering support services to the survivor.',
    `user_account_id` BIGINT COMMENT 'Reference to the staff user who initially created this survivor support plan record.',
    `revised_survivor_support_plan_id` BIGINT COMMENT 'Self-referencing FK on survivor_support_plan (revised_survivor_support_plan_id)',
    `safeguarding_incident_id` BIGINT COMMENT 'Reference to the safeguarding incident that triggered this support plan.',
    `staff_member_id` BIGINT COMMENT 'Reference to the primary case manager or social worker responsible for coordinating the survivor support plan and ensuring continuity of care.',
    `survivor_record_id` BIGINT COMMENT 'Reference to the survivor beneficiary receiving support services. Confidential identifier linking to beneficiary registry.',
    `closure_notes` STRING COMMENT 'Detailed notes documenting the circumstances and outcomes at the time of plan closure, including final status of services and any follow-up recommendations.',
    `closure_reason` STRING COMMENT 'Reason for closing or completing the survivor support plan, documenting the circumstances of plan conclusion.. Valid values are `goals_achieved|survivor_request|lost_contact|transferred|other`',
    `confidentiality_level` STRING COMMENT 'Classification of confidentiality and data protection requirements for this survivor support plan, determining access restrictions and information sharing protocols.. Valid values are `standard|high|maximum`',
    `consent_date` DATE COMMENT 'Date when informed consent was obtained from the survivor for the support plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this survivor support plan record was first created in the system.',
    `education_service_description` STRING COMMENT 'Detailed description of education support services to be provided, including school enrollment assistance, tutoring, vocational training, and educational materials.',
    `education_support_required` BOOLEAN COMMENT 'Indicates whether educational services and support are included in the survivor support plan.',
    `end_date` DATE COMMENT 'Planned or actual date when the survivor support plan is scheduled to conclude or was completed.',
    `goals` STRING COMMENT 'Documented goals and objectives of the survivor support plan as agreed with the survivor, outlining desired outcomes and recovery milestones.',
    `housing_service_description` STRING COMMENT 'Detailed description of safe housing services to be provided, including temporary shelter, relocation assistance, or long-term housing support.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this survivor support plan record was most recently updated or modified.',
    `last_review_date` DATE COMMENT 'Date when the survivor support plan was most recently reviewed and updated.',
    `legal_aid_required` BOOLEAN COMMENT 'Indicates whether legal assistance and advocacy services are included in the survivor support plan.',
    `legal_service_description` STRING COMMENT 'Detailed description of legal aid services to be provided, including legal representation, rights information, and justice system navigation support.',
    `livelihood_service_description` STRING COMMENT 'Detailed description of livelihood support services to be provided, including skills training, cash assistance, income generation activities, and employment support.',
    `livelihood_support_required` BOOLEAN COMMENT 'Indicates whether economic empowerment and livelihood assistance services are included in the survivor support plan.',
    `medical_referral_required` BOOLEAN COMMENT 'Indicates whether medical care or health services referral is included in the survivor support plan.',
    `medical_service_description` STRING COMMENT 'Detailed description of medical services to be provided or referred, including clinical care, reproductive health services, and ongoing treatment needs.',
    `needs_assessment_date` DATE COMMENT 'Date when the comprehensive needs assessment was conducted with the survivor to identify required support services.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of the survivor support plan with the survivor and service providers.',
    `progress_notes` STRING COMMENT 'Ongoing narrative documentation of progress toward plan goals, service delivery updates, and any adjustments made to the support plan.',
    `pss_service_description` STRING COMMENT 'Detailed description of psychosocial support services to be provided, including counseling, peer support groups, and mental health interventions.',
    `psychosocial_support_required` BOOLEAN COMMENT 'Indicates whether psychosocial support services are included in the survivor support plan.',
    `reference_number` STRING COMMENT 'Human-readable unique reference number for the survivor support plan, formatted as SSP-YYYY-NNNNNN.. Valid values are `^SSP-[0-9]{4}-[0-9]{6}$`',
    `referral_pathway_used` STRING COMMENT 'Name or identifier of the inter-agency referral pathway or service directory used to connect the survivor with appropriate service providers.',
    `review_frequency` STRING COMMENT 'Scheduled frequency for reviewing and updating the survivor support plan to ensure services remain appropriate and effective.. Valid values are `weekly|biweekly|monthly|quarterly|as_needed`',
    `safe_housing_required` BOOLEAN COMMENT 'Indicates whether safe shelter or housing assistance is included in the survivor support plan.',
    `safety_plan_included` BOOLEAN COMMENT 'Indicates whether a personalized safety plan has been developed and included as part of the survivor support plan.',
    `start_date` DATE COMMENT 'Date when the survivor support plan becomes active and service delivery begins.',
    `survivor_support_plan_status` STRING COMMENT 'Current lifecycle status of the survivor support plan. Tracks progression from initial draft through active service delivery to completion.. Valid values are `draft|active|under_review|on_hold|completed|closed`',
    `survivor_centered_approach` BOOLEAN COMMENT 'Indicates whether the support plan was developed using survivor-centered principles, prioritizing the survivors autonomy, safety, and expressed needs.',
    `survivor_consent_obtained` BOOLEAN COMMENT 'Indicates whether informed consent was obtained from the survivor for the support plan and associated service delivery.',
    `survivor_support_plan_type` STRING COMMENT 'Classification of the support plan based on scope and duration of services provided.. Valid values are `comprehensive|emergency|short_term|long_term|specialized`',
    CONSTRAINT pk_survivor_support_plan PRIMARY KEY(`survivor_support_plan_id`)
) COMMENT 'Structured support plan developed for each survivor following a safeguarding incident. Captures support needs assessment findings, agreed support services (psychosocial support, medical referral, legal aid, safe housing, livelihood support), service provider assignments, plan start and end dates, review schedule, and plan status. Tracks the holistic survivor-centered response and ensures continuity of care across service providers.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` (
    `support_service_referral_id` BIGINT COMMENT 'Unique identifier for the support service referral record. Primary key for this entity.',
    `case_record_id` BIGINT COMMENT 'Reference to the safeguarding case record that generated this referral. Links the referral to the originating incident or survivor case.',
    `onward_support_service_referral_id` BIGINT COMMENT 'Self-referencing FK on support_service_referral (onward_support_service_referral_id)',
    `registrant_id` BIGINT COMMENT 'Reference to the survivor or beneficiary being referred. Identifies the individual receiving support services.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or case worker who initiated the referral. Used for accountability and follow-up coordination.',
    `survivor_record_id` BIGINT COMMENT 'Foreign key linking to safeguarding.survivor_record. Business justification: support_service_referral currently links to beneficiary.registrant (general beneficiary record) and beneficiary.case_record (general case management). However, in the safeguarding domain, survivors ha',
    `actual_service_start_date` DATE COMMENT 'Actual date when the survivor began receiving the referred service. Null if service has not yet started.',
    `channel` STRING COMMENT 'Communication channel or mechanism used to transmit the referral to the service provider.. Valid values are `in_person|phone|email|secure_platform|interagency_system`',
    `confidentiality_level` STRING COMMENT 'Classification of confidentiality requirements for this referral. Safeguarding referrals typically require enhanced confidentiality controls.. Valid values are `standard|high|maximum`',
    `consent_date` DATE COMMENT 'Date when informed consent was obtained from the survivor for this referral. Null if consent was not obtained or not applicable.',
    `consent_method` STRING COMMENT 'Method by which consent was obtained. Distinguishes between verbal, written, digital signature, or guardian consent for minors.. Valid values are `verbal|written|digital|guardian`',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether informed consent was obtained from the survivor before making the referral. Critical for ethical safeguarding practice.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost of the referred service if applicable. Used for budgeting and financial planning. Null if service is provided at no cost.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the referral was made and service will be delivered. Used for geographic reporting and compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this referral record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the cost estimate. Null if no cost is associated with the referral.. Valid values are `^[A-Z]{3}$`',
    `support_service_referral_date` DATE COMMENT 'The date when the referral was formally made to the service provider. Represents the principal business event timestamp for this transaction.',
    `decline_reason` STRING COMMENT 'Explanation provided if the referral was declined by the service provider or the survivor. Used for learning and pathway improvement.',
    `expected_service_start_date` DATE COMMENT 'Anticipated date when the survivor will begin receiving the referred service. Used for planning and follow-up.',
    `follow_up_completed_flag` BOOLEAN COMMENT 'Indicates whether the scheduled follow-up was completed. Used for monitoring and accountability.',
    `follow_up_date` DATE COMMENT 'Scheduled date for follow-up contact with the survivor or service provider to assess progress and outcomes.',
    `follow_up_outcome` STRING COMMENT 'Summary of the follow-up findings, including survivor feedback and service delivery status. Confidential survivor information.',
    `funding_source` STRING COMMENT 'Identification of the grant, donor, or budget line covering the cost of the referred service. Used for financial tracking and donor reporting.',
    `information_sharing_consent` STRING COMMENT 'Level of consent provided by the survivor for sharing their information with the service provider. Governs what details can be disclosed.. Valid values are `full|limited|none`',
    `interagency_referral_flag` BOOLEAN COMMENT 'Indicates whether this referral is part of an interagency coordination mechanism or referral pathway. Used for humanitarian coordination reporting.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the system user who last updated this referral record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this referral record was last updated in the system. Audit trail for record modifications.',
    `location_name` STRING COMMENT 'Name of the city, district, or field location where the service will be provided. Supports geographic tracking and coordination.',
    `notes` STRING COMMENT 'Additional confidential notes or context about the referral. May include special considerations, survivor preferences, or coordination details.',
    `number` STRING COMMENT 'Externally-visible unique business identifier for the referral. Used for tracking and communication with service providers.. Valid values are `^REF-[0-9]{8}$`',
    `pathway_name` STRING COMMENT 'Name of the formal referral pathway or protocol being followed. Common in coordinated humanitarian response contexts.',
    `reason` STRING COMMENT 'Brief explanation of why the referral was made and what needs the service is intended to address. Confidential case information.',
    `receiving_organization_name` STRING COMMENT 'Name of the external or internal organization receiving the referral and providing the service.',
    `receiving_organization_type` STRING COMMENT 'Classification of the service provider organization. Distinguishes between internal departments, partner organizations, government services, and other provider types.. Valid values are `internal|partner_ngo|government|un_agency|private_provider|community_based`',
    `referring_department` STRING COMMENT 'Department or program unit within the organization that initiated the referral. Used for internal coordination and reporting.',
    `service_completion_date` DATE COMMENT 'Date when the referred service was completed or concluded. Null if service is ongoing or not yet started.',
    `service_description` STRING COMMENT 'Detailed description of the specific support service or intervention being referred. Provides context for the receiving provider.',
    `service_provider_contact_name` STRING COMMENT 'Name of the specific individual or focal point at the receiving organization responsible for this referral.',
    `service_provider_email` STRING COMMENT 'Email address for the service provider or focal point. Used for formal referral documentation and communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `service_provider_phone` STRING COMMENT 'Contact phone number for the service provider or focal point. Used for coordination and follow-up.',
    `service_type` STRING COMMENT 'Category of support service being referred. Classifies the nature of assistance the survivor requires.. Valid values are `medical|psychosocial|legal|shelter|livelihood|education`',
    `support_service_referral_status` STRING COMMENT 'Current lifecycle state of the referral. Tracks progression from initial referral through service delivery completion or closure.. Valid values are `pending|accepted|in_progress|completed|declined|cancelled`',
    `urgency` STRING COMMENT 'Priority level of the referral indicating how quickly the survivor needs to access the service. Guides provider response time.. Valid values are `routine|urgent|emergency`',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created this referral record. Used for audit trail and accountability.',
    CONSTRAINT pk_support_service_referral PRIMARY KEY(`support_service_referral_id`)
) COMMENT 'Transactional record of each formal referral of a survivor to an external or internal support service provider. Captures referral date, service type (medical, psychosocial, legal, shelter, livelihood), receiving organization or service provider, referral urgency, consent obtained flag, referral status (pending, accepted, completed, declined), and follow-up date. Distinct from the general beneficiary referral — this entity is restricted to safeguarding survivor support pathways with enhanced confidentiality controls.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` (
    `alleged_perpetrator_id` BIGINT COMMENT 'Unique identifier for the alleged perpetrator record. Primary key for the alleged perpetrator entity.',
    `constituent_id` BIGINT COMMENT 'Foreign key linking to donor.constituent. Business justification: Donors can be alleged perpetrators (e.g., harassment at fundraising events, misconduct during site visits). Essential for safeguarding enforcement, event access restrictions, and gift acceptance polic',
    `investigation_id` BIGINT COMMENT 'Foreign key linking to safeguarding.investigation. Business justification: Alleged perpetrators must be linked to the formal investigation(s) conducted about them. Currently alleged_perpetrator has investigation_status, investigation_start_date, investigation_completion_date',
    `partner_org_id` BIGINT COMMENT 'Reference to the partner organization if the alleged perpetrator is partner staff or contractor. Nullable for internal staff or community members.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Investigation scope determination and organizational risk assessment require linking alleged perpetrator to their position at incident time. Tracks supervision chain, role-specific vulnerabilities (be',
    `staff_member_id` BIGINT COMMENT 'Employee or volunteer identifier if the alleged perpetrator is or was a member of the workforce. Nullable for external perpetrators. Maintained separately from workforce records to enforce investigation integrity.',
    `safeguarding_incident_id` BIGINT COMMENT 'Reference to the safeguarding incident in which this individual is alleged to be the perpetrator.',
    `same_as_alleged_perpetrator_id` BIGINT COMMENT 'Self-referencing FK on alleged_perpetrator (same_as_alleged_perpetrator_id)',
    `access_restriction_level` STRING COMMENT 'Data classification level controlling who can access this alleged perpetrator record. Strictly access-controlled to enforce investigation integrity and protect due process.. Valid values are `none|restricted|confidential`',
    `allegation_date` DATE COMMENT 'Date when the allegation against this individual was formally recorded in the safeguarding system.',
    `allegation_severity` STRING COMMENT 'Severity classification of the allegation based on organizational risk assessment framework.. Valid values are `critical|high|medium|low`',
    `allegation_type` STRING COMMENT 'Primary category of the allegation against this individual. Aligns with organizational safeguarding policy categories. [ENUM-REF-CANDIDATE: sexual_exploitation|sexual_abuse|child_abuse|harassment|bullying|fraud|other — 7 candidates stripped; promote to reference product]',
    `case_notes` STRING COMMENT 'Confidential notes documenting key investigation milestones, decisions, and rationale. Strictly controlled access.',
    `case_outcome` STRING COMMENT 'Final organizational action taken against the alleged perpetrator following investigation conclusion. Cleared indicates no wrongdoing found. [ENUM-REF-CANDIDATE: dismissed|written_warning|final_warning|termination|criminal_referral|cleared|pending — 7 candidates stripped; promote to reference product]',
    `alleged_perpetrator_code` STRING COMMENT 'Anonymized unique code assigned to the alleged perpetrator to protect identity during investigation. Format: AP-NNNNNN.. Valid values are `^AP-[0-9]{6}$`',
    `country_office_at_incident` STRING COMMENT 'Three-letter ISO country code of the country office where the alleged perpetrator was based at the time of the incident.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this alleged perpetrator record was first created in the system.',
    `criminal_referral_authority` STRING COMMENT 'Name of the law enforcement agency or criminal justice authority to which the case was referred, if applicable.',
    `criminal_referral_date` DATE COMMENT 'Date when the case was referred to law enforcement, if applicable. Nullable if no referral made.',
    `criminal_referral_made` BOOLEAN COMMENT 'Indicates whether the case was referred to law enforcement or criminal justice authorities.',
    `disciplinary_action_date` DATE COMMENT 'Date when disciplinary action was formally applied, if applicable. Nullable if no action taken or case pending.',
    `employment_status_at_incident` STRING COMMENT 'Employment or engagement status of the alleged perpetrator at the time the incident occurred. Critical for determining organizational liability and jurisdiction.. Valid values are `active|suspended|terminated|contract_ended|never_employed|unknown`',
    `interim_measures_applied` STRING COMMENT 'Administrative measures applied to the alleged perpetrator pending investigation outcome. Multiple measures may be concatenated.. Valid values are `none|suspension|restricted_duties|administrative_leave|reassignment|access_revoked`',
    `investigation_completion_date` DATE COMMENT 'Date when the investigation was formally concluded. Nullable if investigation is ongoing.',
    `investigation_outcome` STRING COMMENT 'Final determination of the investigation. Substantiated means evidence supports the allegation; unsubstantiated means insufficient evidence; inconclusive means investigation could not reach a determination.. Valid values are `substantiated|unsubstantiated|inconclusive|dismissed|pending`',
    `investigation_start_date` DATE COMMENT 'Date when the formal investigation into the allegations against this individual commenced.',
    `investigation_status` STRING COMMENT 'Current status of the investigation into the allegations against this individual.. Valid values are `pending|under_investigation|investigation_complete|closed|dismissed`',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the individual who last modified this alleged perpetrator record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this alleged perpetrator record was last modified.',
    `misconduct_database_report_date` DATE COMMENT 'Date when the case was reported to inter-agency misconduct databases, if applicable.',
    `misconduct_database_reported` BOOLEAN COMMENT 'Indicates whether the case was reported to inter-agency misconduct disclosure schemes or databases (e.g., UN ClearCheck, Misconduct Disclosure Scheme).',
    `rehire_eligibility` STRING COMMENT 'Determination of whether the individual is eligible for future employment or engagement with the organization or its partners.. Valid values are `eligible|ineligible|conditional|under_review`',
    `relationship_to_organization` STRING COMMENT 'The alleged perpetrators relationship to the organization at the time of the incident. Determines investigation jurisdiction and accountability mechanisms.. Valid values are `staff|volunteer|partner_staff|contractor|community_member|beneficiary`',
    `suspension_end_date` DATE COMMENT 'Date when suspension or administrative leave ended, if applicable. Nullable if suspension is ongoing or not applied.',
    `suspension_start_date` DATE COMMENT 'Date when suspension or administrative leave commenced, if applicable. Nullable if no suspension applied.',
    `termination_date` DATE COMMENT 'Date of employment or engagement termination if termination was the case outcome. Nullable if not terminated.',
    `created_by` STRING COMMENT 'User ID or system identifier of the individual who created this alleged perpetrator record.',
    CONSTRAINT pk_alleged_perpetrator PRIMARY KEY(`alleged_perpetrator_id`)
) COMMENT 'Confidential master record for each alleged perpetrator named in a safeguarding investigation. Captures perpetrator code (anonymized), relationship to organization (staff, volunteer, partner staff, contractor, community member), employment or engagement status at time of incident, interim administrative measures applied (suspension, restricted duties), and final case outcome (dismissed, disciplinary action, criminal referral, cleared). Strictly access-controlled and maintained separately from workforce records to enforce investigation integrity.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` (
    `disciplinary_outcome_id` BIGINT COMMENT 'Unique identifier for the disciplinary outcome record. Primary key for this entity.',
    `alleged_perpetrator_id` BIGINT COMMENT 'Foreign key linking to safeguarding.alleged_perpetrator. Business justification: Disciplinary outcomes are applied TO alleged perpetrators following investigation findings. Currently disciplinary_outcome links to investigation but not to the perpetrator directly. Adding alleged_pe',
    `appealed_disciplinary_outcome_id` BIGINT COMMENT 'Self-referencing FK on disciplinary_outcome (appealed_disciplinary_outcome_id)',
    `country_office_id` BIGINT COMMENT 'Identifier of the country office where this disciplinary outcome was issued and managed.',
    `constituent_id` BIGINT COMMENT 'Foreign key linking to donor.constituent. Business justification: When donors are subject to disciplinary outcomes (banned from events, restricted field visit access, gift refusal), this link enables enforcement across fundraising operations and ensures consistent a',
    `investigation_action_id` BIGINT COMMENT 'add column investigation_action_id (BIGINT) with FK to safeguarding.investigation_action.investigation_action_id - disciplinary outcomes result from specific investigation actions',
    `investigation_id` BIGINT COMMENT 'Reference to the safeguarding investigation that resulted in this disciplinary outcome.',
    `user_account_id` BIGINT COMMENT 'Identifier of the system user who created this disciplinary outcome record.',
    `separation_event_id` BIGINT COMMENT 'Foreign key linking to workforce.separation_event. Business justification: Disciplinary terminations must link to separation_event for final settlement calculation, rehire eligibility enforcement, reference check flagging, and mandatory donor/regulatory reporting (IRS Form 9',
    `aggravating_factors` STRING COMMENT 'Description of any aggravating circumstances or factors that influenced the disciplinary outcome decision toward greater severity.',
    `appeal_decision_date` DATE COMMENT 'The date on which the appeal decision was finalized and communicated, if applicable.',
    `appeal_filed_date` DATE COMMENT 'The date on which the appeal was formally filed by the subject employee, if applicable.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether the subject employee filed a formal appeal against this disciplinary outcome.',
    `appeal_outcome` STRING COMMENT 'The result of the appeal process, if an appeal was filed. Includes upheld, denied, partially upheld, withdrawn, pending, or not applicable.. Valid values are `upheld|denied|partially_upheld|withdrawn|pending|not_applicable`',
    `confidentiality_level` STRING COMMENT 'The data classification level for this disciplinary outcome record, determining access and disclosure restrictions.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this disciplinary outcome record was first created in the system.',
    `criminal_charges_filed_flag` BOOLEAN COMMENT 'Indicates whether criminal charges were filed against the subject as a result of this case.',
    `disciplinary_outcome_date` DATE COMMENT 'The date on which the disciplinary outcome decision was formally issued and communicated to the subject.',
    `decision_authority` STRING COMMENT 'The role or title of the individual or committee who authorized and issued this disciplinary outcome (e.g., Country Director, HR Director, Disciplinary Panel).',
    `document_url` STRING COMMENT 'Secure URL or file path to the formal disciplinary outcome decision document.',
    `effective_date` DATE COMMENT 'The date on which the disciplinary action becomes effective and enforceable.',
    `external_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether external reporting to regulatory bodies, law enforcement, or other authorities is required for this outcome.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this disciplinary outcome record was most recently updated or modified.',
    `law_enforcement_agency` STRING COMMENT 'The name of the law enforcement or criminal justice agency to which the case was referred, if applicable.',
    `law_enforcement_referral_date` DATE COMMENT 'The date on which the case was formally referred to law enforcement authorities, if applicable.',
    `law_enforcement_referral_flag` BOOLEAN COMMENT 'Indicates whether the case was referred to law enforcement or criminal justice authorities.',
    `lessons_learned` STRING COMMENT 'Summary of organizational lessons learned from this case, used for continuous improvement of safeguarding policies and procedures.',
    `mds_reference_number` STRING COMMENT 'The unique reference number assigned by the Inter-Agency Misconduct Disclosure Scheme (MDS) for this reported case.',
    `mds_report_date` DATE COMMENT 'The date on which the case was reported to the Inter-Agency Misconduct Disclosure Scheme (MDS), if applicable.',
    `mds_reported_flag` BOOLEAN COMMENT 'Indicates whether this case was reported to the Inter-Agency Misconduct Disclosure Scheme (MDS) or equivalent external reporting mechanism.',
    `mitigating_factors` STRING COMMENT 'Description of any mitigating circumstances or factors that influenced the disciplinary outcome decision in favor of leniency.',
    `policy_violations` STRING COMMENT 'Comma-separated list or description of the specific organizational policies that were violated, leading to this disciplinary outcome.',
    `rationale` STRING COMMENT 'Detailed explanation of the reasoning and justification for the disciplinary outcome decision, including mitigating and aggravating factors considered.',
    `reference_check_flag` BOOLEAN COMMENT 'Indicates whether this outcome will be disclosed in future employment reference checks for the subject.',
    `reference_number` STRING COMMENT 'Externally-known unique reference number for this disciplinary outcome, used for tracking and reporting purposes.. Valid values are `^[A-Z]{2,4}-[0-9]{4}-[0-9]{6}$`',
    `rehabilitation_plan_required_flag` BOOLEAN COMMENT 'Indicates whether a formal rehabilitation or performance improvement plan is required as part of the disciplinary outcome.',
    `restitution_amount_usd` DECIMAL(18,2) COMMENT 'The monetary amount of restitution required from the subject, expressed in United States Dollars (USD).',
    `restitution_required_flag` BOOLEAN COMMENT 'Indicates whether the subject is required to provide financial or other restitution as part of the disciplinary outcome.',
    `severity_level` STRING COMMENT 'The assessed severity level of the misconduct that led to this disciplinary outcome.. Valid values are `minor|moderate|serious|severe|critical`',
    `disciplinary_outcome_status` STRING COMMENT 'Current status of the disciplinary outcome in its lifecycle, including pending, finalized, under appeal, appeal upheld, appeal denied, or overturned.. Valid values are `pending|finalized|under_appeal|appeal_upheld|appeal_denied|overturned`',
    `training_completion_deadline` DATE COMMENT 'The deadline by which required training must be completed, if applicable.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether mandatory training (e.g., safeguarding, code of conduct, ethics) is required as part of the disciplinary outcome.',
    `disciplinary_outcome_type` STRING COMMENT 'The type of disciplinary or administrative action applied following the substantiated investigation. Includes written warning, final warning, demotion, suspension, termination, criminal referral, or no action. [ENUM-REF-CANDIDATE: written_warning|final_warning|demotion|suspension|termination|criminal_referral|no_action — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_disciplinary_outcome PRIMARY KEY(`disciplinary_outcome_id`)
) COMMENT 'Transactional record of the formal disciplinary or administrative outcome applied following a substantiated safeguarding investigation. Captures outcome type (written warning, final warning, demotion, termination, criminal referral, no action), outcome date, decision authority, appeal filed flag, appeal outcome, and whether the case was reported to the Inter-Agency Misconduct Disclosure Scheme (MDS) or equivalent. Complements workforce.disciplinary_case by capturing the safeguarding-specific outcome details and external reporting obligations.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` (
    `training_program_id` BIGINT COMMENT 'Unique identifier for the safeguarding training program. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Training programs are delivered by specific departments (HR, safeguarding units) tracked as cost centers. Program development and delivery costs (cost_per_participant_usd) must be allocated to the res',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Safeguarding training programs (PSEA, code of conduct, child protection) are delivered through LMS platforms. Organizations need this link for user provisioning, completion tracking integration, certi',
    `primary_superseded_program_training_program_id` BIGINT COMMENT 'Identifier of the previous version of this training program that this version replaces. Null if this is the first version.',
    `user_account_id` BIGINT COMMENT 'Identifier of the user who created this training program record.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: Training programs are mapped to job profiles to define mandatory safeguarding training by role type (all staff, managers, beneficiary-facing, designated roles). Enables systematic compliance tracking,',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member or department responsible for maintaining and updating this training program.',
    `accrediting_body` STRING COMMENT 'Name of the external organization or internal department that accredits or certifies this training program.',
    `assessment_required_flag` BOOLEAN COMMENT 'Indicates whether participants must complete an assessment to receive certification. True if assessment required, False otherwise.',
    `available_languages` STRING COMMENT 'Comma-separated list of two-letter ISO 639-1 language codes for all languages in which this training is available.',
    `certification_issued_flag` BOOLEAN COMMENT 'Indicates whether a formal certificate is issued upon successful completion. True if certificate issued, False otherwise.',
    `training_program_code` STRING COMMENT 'Externally-known unique code for the training program, used for registration and tracking purposes.. Valid values are `^[A-Z0-9]{6,12}$`',
    `compliance_framework` STRING COMMENT 'Name of the regulatory or industry compliance framework that this training program addresses (e.g., Core Humanitarian Standard, PSEA Framework, Sphere Standards).',
    `content_url` STRING COMMENT 'Web address or file path where the training content, materials, or Learning Management System (LMS) course can be accessed.',
    `cost_per_participant_usd` DECIMAL(18,2) COMMENT 'Cost in United States Dollars to deliver the training program per participant, including materials, instructor fees, and platform costs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training program record was first created in the system.',
    `delivery_modality` STRING COMMENT 'Method by which the training is delivered to participants.. Valid values are `in_person|e_learning|blended|virtual_instructor_led|self_paced`',
    `training_program_description` STRING COMMENT 'Detailed description of the training program content, objectives, and expected learning outcomes.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the training program measured in hours, including all modules and assessments.',
    `effective_date` DATE COMMENT 'Date from which this version of the training program becomes active and available for enrollment.',
    `enrollment_capacity` STRING COMMENT 'Maximum number of participants that can be enrolled in a single session or cohort of this training program. Null indicates unlimited capacity.',
    `expiration_date` DATE COMMENT 'Date on which this version of the training program is retired and no longer available for new enrollments. Null indicates no expiration.',
    `facilitator_qualifications` STRING COMMENT 'Required qualifications, certifications, or experience for individuals authorized to facilitate this training program.',
    `facilitator_required_flag` BOOLEAN COMMENT 'Indicates whether a trained facilitator or instructor is required to deliver this training. True if facilitator required, False for self-paced programs.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the primary language in which the training is delivered.. Valid values are `^[a-z]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this training program record was last updated.',
    `last_review_date` DATE COMMENT 'Date when the training program content was last reviewed for accuracy, relevance, and compliance.',
    `learning_objectives` STRING COMMENT 'Specific, measurable learning objectives that participants will achieve upon completion of the training.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether completion of this training is mandatory for the target audience. True if mandatory, False if optional.',
    `materials_description` STRING COMMENT 'Description of the training materials provided to participants, including format (digital, printed) and content overview.',
    `materials_provided_flag` BOOLEAN COMMENT 'Indicates whether training materials (handouts, guides, reference documents) are provided to participants. True if materials provided, False otherwise.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of the training program content.',
    `notes` STRING COMMENT 'Additional notes, comments, or administrative information about the training program not captured in other fields.',
    `passing_score_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage score required to pass the assessment and receive certification. Null if no assessment required.',
    `prerequisites` STRING COMMENT 'Any prerequisite training programs, certifications, or experience required before enrolling in this program.',
    `review_cycle_months` STRING COMMENT 'Frequency in months at which the training program content is reviewed and updated to ensure relevance and compliance.',
    `training_program_status` STRING COMMENT 'Current lifecycle status of the training program. Determines availability for enrollment.. Valid values are `active|inactive|under_review|retired|draft`',
    `target_audience` STRING COMMENT 'Primary audience group for whom this training program is designed. [ENUM-REF-CANDIDATE: all_staff|field_staff|management|volunteers|partners|new_hires|investigators — 7 candidates stripped; promote to reference product]',
    `title` STRING COMMENT 'Full title of the safeguarding training program as displayed to learners and in catalogs.',
    `training_type` STRING COMMENT 'Category of safeguarding training. Defines the primary focus area of the program.. Valid values are `psea_awareness|child_safeguarding|code_of_conduct|bystander_intervention|survivor_centered_approach|investigation_skills`',
    `translation_available_flag` BOOLEAN COMMENT 'Indicates whether the training program is available in additional languages beyond the primary language. True if translations exist, False otherwise.',
    `validity_period_months` STRING COMMENT 'Number of months the training certification remains valid before renewal or refresher training is required. Null indicates no expiration.',
    `version_number` STRING COMMENT 'Version number of the training program content, following semantic versioning (major.minor format).. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_training_program PRIMARY KEY(`training_program_id`)
) COMMENT 'Catalog of mandatory and optional safeguarding training programs available to staff, volunteers, and partners. Captures training title, training type (PSEA awareness, child safeguarding, code of conduct, bystander intervention, survivor-centered approach), delivery modality (in-person, e-learning, blended), duration, target audience, mandatory flag, validity period (months before renewal required), and accrediting body. Distinct from volunteer.training and workforce.learning_course — this catalog is owned by the safeguarding function and governs compliance training obligations.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` (
    `safeguarding_training_completion_id` BIGINT COMMENT 'Unique identifier for the training completion record. Primary key for this transactional record of safeguarding training completion.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: When safeguarding training is a donor condition or grant-funded activity, linking to the award enables compliance monitoring against special award conditions, cost allocation, and donor reporting of c',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Training delivery costs (cost_usd field) are allocated to the cost center responsible for conducting the training event. Essential for tracking training expenditures against budget and calculating tru',
    `country_office_id` BIGINT COMMENT 'Reference to the country office or field location where the participant is based. Used for geographic compliance reporting and regional safeguarding oversight.',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project the participant is associated with at the time of training. Supports program-level safeguarding compliance tracking and donor reporting.',
    `learning_course_id` BIGINT COMMENT 'Reference to the safeguarding training course that was completed. Links to the course catalog entry defining the training content, duration, and requirements.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Partner organization staff complete safeguarding training as partnership prerequisite. Tracks which partners employees completed mandatory PSEA training for capacity assessment scoring and partnershi',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Safeguarding training requirements are position-specific (beneficiary-facing roles, supervisory positions, field deployments). Links training compliance to position eligibility for deployment clearanc',
    `user_account_id` BIGINT COMMENT 'Identifier of the system user or administrator who created this training completion record. Supports accountability and audit requirements.',
    `refresher_of_safeguarding_training_completion_id` BIGINT COMMENT 'Self-referencing FK on safeguarding_training_completion (refresher_of_safeguarding_training_completion_id)',
    `staff_member_id` BIGINT COMMENT 'Reference to the individual who completed the training. Links to staff, volunteer, or partner personnel record depending on participant type.',
    `training_program_id` BIGINT COMMENT 'Foreign key linking to safeguarding.training_program. Business justification: training_completion currently links to workforce.learning_course (general LMS course catalog). However, training_program is the safeguarding-specific catalog of PSEA and safeguarding training programs',
    `volunteer_training_completion_id` BIGINT COMMENT 'FK to SSOT owner volunteer.volunteer_training_completion for entity training_completion',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numeric score achieved by the participant on the training assessment or quiz. Expressed as a percentage (0.00 to 100.00) to measure comprehension of safeguarding principles.',
    `attempts_count` STRING COMMENT 'Number of attempts the participant made to pass the training assessment. Used to identify individuals requiring additional support or remedial training.',
    `certificate_expiry_date` DATE COMMENT 'Date when the training certificate expires and the participant must complete refresher training. Critical for tracking mandatory recertification obligations under PSEA and safeguarding policies.',
    `certificate_issue_date` DATE COMMENT 'Date when the completion certificate was officially issued to the participant. May differ from completion date due to administrative processing time.',
    `certificate_issued_flag` BOOLEAN COMMENT 'Indicates whether a completion certificate was issued to the participant. True when certificate has been generated and delivered; false otherwise.',
    `certificate_number` STRING COMMENT 'Unique certificate identifier issued upon successful completion. Used for verification of training credentials by HR, partners, or external auditors.',
    `channel` STRING COMMENT 'Delivery method or platform through which the training was completed. Distinguishes between Learning Management System (LMS) online courses, in-person classroom sessions, and other modalities.. Valid values are `lms_online|in_person_classroom|virtual_instructor_led|self_paced_online|blended|workshop`',
    `compliance_deadline_date` DATE COMMENT 'Date by which the participant was required to complete the training to meet organizational or donor compliance obligations. Used to identify overdue training and non-compliance risk.',
    `cost_usd` DECIMAL(18,2) COMMENT 'Direct cost incurred for this training completion, including instructor fees, materials, venue, and participant travel. Expressed in United States Dollars for financial reporting and budget tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training completion record was first created in the system. Used for audit trail and data lineage tracking.',
    `safeguarding_training_completion_date` DATE COMMENT 'Date when the participant successfully completed the safeguarding training course. Principal business event timestamp for compliance tracking and certificate issuance.',
    `enrollment_date` DATE COMMENT 'Date when the participant was enrolled or registered for the training course. Used to track time-to-completion and identify overdue training obligations.',
    `external_provider_name` STRING COMMENT 'Name of the external training provider or consultancy that delivered the course, if not conducted in-house. Null for internally-delivered training.',
    `feedback_comments` STRING COMMENT 'Free-text comments provided by the participant about the training experience. Captures suggestions for improvement, content gaps, or delivery issues.',
    `feedback_rating` STRING COMMENT 'Participant satisfaction rating for the training course, typically on a scale of 1 to 5. Used for continuous improvement of safeguarding training quality.',
    `funding_source` STRING COMMENT 'Grant, donor, or budget line that funded this training activity. Used for cost allocation and donor reporting on capacity-building investments.',
    `instructor_name` STRING COMMENT 'Name of the facilitator or instructor who delivered the training for in-person or virtual instructor-led sessions. Null for self-paced online courses.',
    `language` STRING COMMENT 'Language in which the training content was delivered to the participant. Supports multilingual training delivery and ensures comprehension in local contexts.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this training completion record was last updated. Tracks changes to status, scores, or certificate information over the records lifecycle.',
    `lms_course_code` STRING COMMENT 'External identifier from the Learning Management System where the training was delivered. Used for integration and reconciliation with LMS platforms such as Workday Learning.',
    `mandatory_training_flag` BOOLEAN COMMENT 'Indicates whether this training was mandatory for the participant based on their role, location, or organizational policy. True for required safeguarding training; false for optional professional development.',
    `next_refresher_due_date` DATE COMMENT 'Date when the participant must complete refresher training to maintain current certification. Calculated based on certificate expiry date and organizational recertification policies.',
    `notes` STRING COMMENT 'Additional contextual information about this training completion. May include special circumstances, accommodations provided, or follow-up actions required.',
    `overdue_flag` BOOLEAN COMMENT 'Indicates whether the training completion occurred after the compliance deadline. True when completed late or still incomplete past deadline; false when completed on time.',
    `participant_type` STRING COMMENT 'Classification of the individual completing the training. Determines compliance obligations and reporting requirements under organizational safeguarding policies.. Valid values are `staff|volunteer|partner_staff|consultant|board_member|intern`',
    `pass_fail_status` STRING COMMENT 'Binary outcome of the training assessment. Determines whether the participant met the minimum competency requirements for safeguarding knowledge.. Valid values are `pass|fail|not_assessed|waived`',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the training assessment at the time of completion. Captured to support historical audit when passing thresholds change over time.',
    `reference_number` STRING COMMENT 'Business identifier for this training completion record. Used for audit trails, certificate references, and external reporting to donors or regulators.',
    `refresher_required_flag` BOOLEAN COMMENT 'Indicates whether this completion record requires a future refresher training. True for certifications with expiry dates; false for one-time orientation training.',
    `safeguarding_training_completion_status` STRING COMMENT 'Current status of the training completion record. Tracks whether the participant successfully completed, is still in progress, failed assessment, or had training waived by authorized personnel.. Valid values are `completed|in_progress|failed|expired|waived`',
    `training_duration_hours` DECIMAL(18,2) COMMENT 'Total number of hours the participant spent completing the training. Used for professional development tracking and compliance with donor-mandated training hour requirements.',
    `training_location` STRING COMMENT 'Physical location or virtual platform where the training was conducted. Examples include country office name, city, or virtual meeting platform (Zoom, Teams).',
    `waiver_approval_date` DATE COMMENT 'Date when the training waiver was officially approved. Used for audit trail and compliance documentation.',
    `waiver_approved_by` STRING COMMENT 'Name or identifier of the authorized individual who approved the training waiver. Typically a safeguarding focal point, HR director, or country director.',
    `waiver_granted_flag` BOOLEAN COMMENT 'Indicates whether the training requirement was waived for this participant by authorized personnel. True when waiver approved; false for standard completion path.',
    `waiver_reason` STRING COMMENT 'Business justification for granting a training waiver. Examples include prior equivalent training, role exemption, or short-term assignment. Required when waiver_granted_flag is true.',
    CONSTRAINT pk_safeguarding_training_completion PRIMARY KEY(`safeguarding_training_completion_id`)
) COMMENT 'Transactional record of an individual staff member, volunteer, or partner staff completing a safeguarding training course. Captures participant type (staff, volunteer, partner), participant reference, training course, completion date, assessment score, pass/fail status, certificate issued flag, certificate expiry date, and completion channel (LMS, in-person register). Serves as the compliance evidence record for mandatory safeguarding training obligations and supports audit readiness.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` (
    `safeguarding_policy_acknowledgment_id` BIGINT COMMENT 'Unique identifier for the policy acknowledgment record. Primary key.',
    `learning_course_id` BIGINT COMMENT 'Identifier of the safeguarding training course completed by the acknowledger, if applicable.',
    `user_account_id` BIGINT COMMENT 'Identifier of the system user or administrator who created this acknowledgment record.',
    `primary_superseded_acknowledgment_safeguarding_policy_acknowledgment_id` BIGINT COMMENT 'Identifier of the previous acknowledgment record that this acknowledgment supersedes, if applicable (e.g., when a new policy version is acknowledged).',
    `psea_policy_id` BIGINT COMMENT 'Identifier of the safeguarding policy or code of conduct being acknowledged.',
    `staff_member_id` BIGINT COMMENT 'Identifier of the individual who acknowledged the policy. References staff, volunteer, partner staff, or contractor depending on acknowledger type.',
    `safeguarding_acknowledging_staff_member_id` BIGINT COMMENT 'Employee or personnel identifier for the acknowledger, if applicable (staff, contractor, consultant).',
    `volunteer_policy_acknowledgment_id` BIGINT COMMENT 'FK to SSOT owner volunteer.volunteer_policy_acknowledgment for entity policy_acknowledgment',
    `acknowledging_staff_member_id` BIGINT COMMENT '',
    `acknowledger_email` STRING COMMENT 'Email address of the individual acknowledging the policy, used for notification and audit trail.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `acknowledger_name` STRING COMMENT 'Full legal name of the individual acknowledging the policy.',
    `acknowledger_type` STRING COMMENT 'Category of individual acknowledging the policy: staff, volunteer, partner staff, contractor, consultant, or board member.. Valid values are `staff|volunteer|partner_staff|contractor|consultant|board_member`',
    `consent_to_process_data_flag` BOOLEAN COMMENT 'Indicates whether the acknowledger provided consent for their acknowledgment data to be processed and stored (True/False).',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the acknowledgment was completed.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this acknowledgment record was first created in the system.',
    `safeguarding_policy_acknowledgment_date` DATE COMMENT 'Date on which the individual formally acknowledged the policy.',
    `device_identifier` STRING COMMENT 'Unique identifier of the device used to submit the acknowledgment (e.g., device ID, MAC address), if captured.',
    `digital_signature` STRING COMMENT 'Encrypted digital signature or hash captured during electronic acknowledgment, if applicable.',
    `document_url` STRING COMMENT 'Uniform Resource Locator (URL) or file path to the stored acknowledgment document or scanned signature, if applicable.. Valid values are `^https?://.*$`',
    `ip_address` STRING COMMENT 'Internet Protocol (IP) address from which the digital acknowledgment was submitted, for audit trail purposes.. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$`',
    `language` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language in which the policy was acknowledged.. Valid values are `^[a-z]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this acknowledgment record was last modified in the system.',
    `lms_confirmation_code` STRING COMMENT 'Unique confirmation identifier from the Learning Management System (LMS) if acknowledgment was captured via LMS.',
    `location` STRING COMMENT 'Physical or organizational location where the acknowledgment was completed (e.g., headquarters, field office, training venue).',
    `method` STRING COMMENT 'Method by which the acknowledgment was captured: digital signature, wet signature (physical), Learning Management System (LMS) confirmation, email confirmation, verbal recorded, or paper form.. Valid values are `digital_signature|wet_signature|lms_confirmation|email_confirmation|verbal_recorded|paper_form`',
    `next_renewal_due_date` DATE COMMENT 'Date by which the next renewal acknowledgment is due.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the acknowledgment, including any special circumstances or exceptions.',
    `policy_title` STRING COMMENT 'Title of the safeguarding policy or code of conduct acknowledged.',
    `policy_version_number` STRING COMMENT 'Version number of the policy document acknowledged (e.g., 1.0, 2.1, 3.0.1).. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `reference_number` STRING COMMENT 'Externally-visible unique reference number for this acknowledgment record, used for audit trail and compliance reporting.. Valid values are `^ACK-[A-Z0-9]{8,12}$`',
    `reminder_sent_date` DATE COMMENT 'Date on which the most recent renewal reminder was sent to the acknowledger.',
    `reminder_sent_flag` BOOLEAN COMMENT 'Indicates whether a renewal reminder has been sent to the acknowledger (True/False).',
    `renewal_frequency_months` STRING COMMENT 'Number of months between required renewals of acknowledgment, if renewal is required.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether periodic renewal of acknowledgment is required (True/False).',
    `safeguarding_policy_acknowledgment_status` STRING COMMENT 'Current lifecycle status of the acknowledgment: current (valid), expired (past validity period), superseded (new version acknowledged), revoked (acknowledgment withdrawn), or pending (awaiting confirmation).. Valid values are `current|expired|superseded|revoked|pending`',
    `timestamp` TIMESTAMP COMMENT 'Precise timestamp when the acknowledgment was recorded in the system, including time zone.',
    `training_completion_date` DATE COMMENT 'Date on which the acknowledger completed the required safeguarding training, if applicable.',
    `training_completion_required_flag` BOOLEAN COMMENT 'Indicates whether completion of safeguarding training was required before acknowledgment (True/False).',
    `valid_from_date` DATE COMMENT 'Date from which this acknowledgment becomes effective and valid.',
    `valid_until_date` DATE COMMENT 'Date until which this acknowledgment remains valid; after this date, re-acknowledgment may be required.',
    `witness_name` STRING COMMENT 'Full name of the witness who observed the acknowledgment, if applicable (e.g., for wet signatures or verbal acknowledgments).',
    `witness_role` STRING COMMENT 'Organizational role or title of the witness (e.g., HR Manager, Supervisor, Compliance Officer).',
    CONSTRAINT pk_safeguarding_policy_acknowledgment PRIMARY KEY(`safeguarding_policy_acknowledgment_id`)
) COMMENT 'Transactional record capturing each individuals formal acknowledgment of a safeguarding policy or code of conduct. Captures acknowledger type (staff, volunteer, partner staff, contractor), acknowledger reference, policy version acknowledged, acknowledgment date, acknowledgment method (digital signature, wet signature, LMS confirmation), and whether acknowledgment is current or expired. Provides the compliance audit trail for organizational safeguarding policy adherence.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` (
    `risk_assessment_id` BIGINT COMMENT 'Unique identifier for the safeguarding risk assessment record. Primary key.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Safeguarding risk assessments for grant-funded programs must link to awards for due diligence documentation, donor reporting requirements, compliance with special award conditions requiring risk mitig',
    `community_id` BIGINT COMMENT 'Foreign key linking to beneficiary.community. Business justification: Safeguarding risk assessments at community level evaluate power dynamics, vulnerability exposure, and protection risks in community-based programming contexts. Linking to beneficiary.community enables',
    `country_office_id` BIGINT COMMENT 'Reference to the country office where the risk assessment was conducted or that is the subject of the assessment.',
    `intervention_id` BIGINT COMMENT 'Reference to the program being assessed for safeguarding risks, if the assessment is program-specific.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Safeguarding risk assessments are conducted at organizational unit level (departments, field offices, country programs) to evaluate structural controls, resource allocation, and capacity gaps. Essenti',
    `partner_org_id` BIGINT COMMENT 'Reference to the partner organization being assessed for safeguarding risks, if the assessment focuses on a partner entity.',
    `previous_risk_assessment_id` BIGINT COMMENT 'Self-referencing FK on risk_assessment (previous_risk_assessment_id)',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or consultant who led the safeguarding risk assessment.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse. Business justification: Warehouse safeguarding risk assessments evaluate facility access controls, staff-beneficiary contact points, and vulnerable population exposure. Required for facility risk management, pre-operational ',
    `accountability_mechanism_risk_rating` STRING COMMENT 'Risk rating for the adequacy and accessibility of accountability mechanisms, feedback channels, and complaint response systems for safeguarding concerns.. Valid values are `low|medium|high|critical`',
    `approval_authority` STRING COMMENT 'Name or title of the individual or committee with authority to approve the risk assessment and authorize implementation of mitigation measures (e.g., Country Director, Safeguarding Committee).',
    `approval_date` DATE COMMENT 'Date when the safeguarding risk assessment was formally approved by the designated approval authority.',
    `beneficiary_consultation_conducted` BOOLEAN COMMENT 'Flag indicating whether beneficiaries and affected populations were directly consulted as part of the risk assessment process.',
    `community_trust_risk_rating` STRING COMMENT 'Risk rating for community trust and perception of the organization, which impacts willingness to report safeguarding concerns.. Valid values are `low|medium|high|critical`',
    `control_gaps_identified` STRING COMMENT 'Specific gaps, weaknesses, or deficiencies identified in existing safeguarding controls and risk mitigation measures.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk assessment record was first created in the system.',
    `risk_assessment_date` DATE COMMENT 'Date when the safeguarding risk assessment was conducted or completed. Primary business event timestamp for the assessment.',
    `estimated_mitigation_cost_usd` DECIMAL(18,2) COMMENT 'Estimated cost in United States Dollars (USD) to implement all recommended safeguarding risk mitigation measures.',
    `existing_controls_assessment` STRING COMMENT 'Evaluation of existing safeguarding controls, policies, procedures, and mechanisms currently in place and their effectiveness.',
    `key_risks_identified` STRING COMMENT 'Summary of the most significant safeguarding risks identified during the assessment, including specific vulnerabilities and threat scenarios.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who last modified the risk assessment record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk assessment record was last modified in the system.',
    `lessons_learned` STRING COMMENT 'Key lessons learned from the risk assessment process and findings, contributing to organizational learning and continuous improvement in safeguarding practices.',
    `methodology` STRING COMMENT 'Description of the methodology, framework, and tools used to conduct the safeguarding risk assessment (e.g., interviews, Focus Group Discussions (FGD), Key Informant Interviews (KII), document review).',
    `mitigation_plan_status` STRING COMMENT 'Current implementation status of the safeguarding risk mitigation plan developed from this assessment.. Valid values are `not_started|in_progress|partially_implemented|fully_implemented|ongoing_monitoring`',
    `notes` STRING COMMENT 'Additional notes, context, or observations related to the safeguarding risk assessment not captured in other structured fields.',
    `operational_environment_risk_rating` STRING COMMENT 'Risk rating for the operational environment including conflict, displacement, humanitarian crisis conditions that may elevate safeguarding risks.. Valid values are `low|medium|high|critical`',
    `overall_safeguarding_risk_level` STRING COMMENT 'Composite overall safeguarding risk level determined by aggregating individual risk category ratings and applying organizational risk assessment methodology.. Valid values are `low|medium|high|critical`',
    `partner_due_diligence_risk_rating` STRING COMMENT 'Risk rating for partner organization safeguarding capacity, policies, and due diligence processes.. Valid values are `low|medium|high|critical`',
    `power_imbalance_risk_rating` STRING COMMENT 'Risk rating for power imbalance between staff/volunteers and beneficiaries, a key safeguarding risk category under Protection from Sexual Exploitation and Abuse (PSEA) frameworks.. Valid values are `low|medium|high|critical`',
    `priority_actions` STRING COMMENT 'High-priority immediate actions required to address critical safeguarding risks identified in the assessment.',
    `reassessment_due_date` DATE COMMENT 'Date by which the safeguarding risk assessment should be repeated or reviewed to ensure continued relevance and effectiveness of controls.',
    `reassessment_frequency_months` STRING COMMENT 'Recommended frequency in months for conducting reassessments, typically based on the overall risk level (e.g., critical risks require more frequent reassessment).',
    `recommended_mitigations` STRING COMMENT 'Detailed recommendations for mitigating identified safeguarding risks, including policy enhancements, training, process improvements, and resource allocation.',
    `reference_number` STRING COMMENT 'Human-readable unique reference number for the risk assessment, typically following organizational numbering convention (e.g., RA-USA-2024-0001).. Valid values are `^RA-[A-Z]{3}-[0-9]{4}-[0-9]{4}$`',
    `report_document_url` STRING COMMENT 'URL or file path to the full safeguarding risk assessment report document stored in the organizational document management system.',
    `resource_requirements` STRING COMMENT 'Description of resources (financial, human, technical) required to implement recommended safeguarding risk mitigation measures.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score calculated using organizational risk matrix, typically ranging from 0 to 100, used to prioritize mitigation efforts.',
    `scope_description` STRING COMMENT 'Detailed description of the scope, boundaries, and focus areas covered by this safeguarding risk assessment, including specific programs, locations, or activities evaluated.',
    `staff_conduct_risk_rating` STRING COMMENT 'Risk rating for staff and volunteer conduct, including adherence to code of conduct, safeguarding policies, and ethical standards.. Valid values are `low|medium|high|critical`',
    `stakeholders_consulted` STRING COMMENT 'List of stakeholder groups consulted during the assessment including staff, beneficiaries, community leaders, partners, and local authorities.',
    `risk_assessment_status` STRING COMMENT 'Current lifecycle status of the risk assessment, tracking its progression from initiation through completion and approval.. Valid values are `draft|in_progress|under_review|approved|completed|superseded`',
    `team_members` STRING COMMENT 'Comma-separated list of staff IDs or names of team members who participated in conducting the risk assessment.',
    `risk_assessment_type` STRING COMMENT 'Type of safeguarding risk assessment conducted, indicating the scope and focus area of the assessment.. Valid values are `program|project|country_office|partner|event|field_operation`',
    `vulnerable_population_access_risk_rating` STRING COMMENT 'Risk rating for staff and volunteer access to vulnerable populations including children, women, Internally Displaced Persons (IDP), and Persons of Concern (PoC).. Valid values are `low|medium|high|critical`',
    `created_by` STRING COMMENT 'Username or identifier of the user who created the risk assessment record in the system.',
    CONSTRAINT pk_risk_assessment PRIMARY KEY(`risk_assessment_id`)
) COMMENT 'Structured safeguarding risk assessment record conducted at the program, project, or country office level. Captures assessment date, scope (program, country, partner, event), risk categories assessed (power imbalance, access to vulnerable populations, community trust, accountability mechanisms), risk rating per category, overall safeguarding risk level (low, medium, high, critical), recommended mitigations, and reassessment due date. Informs program design and operational safeguarding planning.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` (
    `reporting_channel_id` BIGINT COMMENT 'Unique identifier for the safeguarding reporting channel. Primary key.',
    `country_office_id` BIGINT COMMENT 'Identifier of the country office that manages and oversees this reporting channel. Links channel to organizational structure for accountability.',
    `escalation_reporting_channel_id` BIGINT COMMENT 'Self-referencing FK on reporting_channel (escalation_reporting_channel_id)',
    `intervention_id` BIGINT COMMENT 'Identifier of the specific program or project associated with this reporting channel, if the channel is program-specific rather than organization-wide.',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member designated as the primary focal point responsible for monitoring, maintaining, and responding to reports received through this channel.',
    `user_account_id` BIGINT COMMENT 'Identifier of the system user who created this reporting channel record. Supports accountability and audit requirements.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Online reporting channels (hotlines, web forms, mobile apps) are hosted on specific technology platforms. Organizations need this link for platform maintenance scheduling, security assessments, uptime',
    `access_method_description` STRING COMMENT 'Detailed instructions on how to access and use the reporting channel, including phone numbers, URLs, physical locations, or contact procedures.',
    `accessibility_accommodations` STRING COMMENT 'Description of accommodations provided to ensure the channel is accessible to persons with disabilities, including visual, hearing, mobility, or cognitive impairments.',
    `activation_date` DATE COMMENT 'Date when the channel became operationally active and began accepting reports. May differ from establishment date if there was a pilot or testing phase.',
    `additional_languages_supported` STRING COMMENT 'Comma-separated list of ISO 639-3 language codes for additional languages supported by the channel, enabling multilingual access for diverse affected populations.',
    `anonymity_supported_flag` BOOLEAN COMMENT 'Indicates whether the channel allows anonymous reporting without requiring reporter identification. Critical for Protection from Sexual Exploitation and Abuse (PSEA) compliance.',
    `average_response_time_hours` DECIMAL(18,2) COMMENT 'Mean time in hours from report receipt to initial acknowledgment or response through this channel. Key performance indicator for channel responsiveness.',
    `reporting_channel_code` STRING COMMENT 'Unique business identifier code for the reporting channel, used for external reference and reporting to Protection from Sexual Exploitation and Abuse (PSEA) networks.. Valid values are `^[A-Z0-9]{6,12}$`',
    `confidentiality_level` STRING COMMENT 'Level of confidentiality protection applied to reports received through this channel. Determines access controls and data handling protocols.. Valid values are `public|restricted|confidential`',
    `contact_email_address` STRING COMMENT 'Dedicated email address for receiving safeguarding reports and complaints through this channel.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone_number` STRING COMMENT 'Primary phone number for hotline-based reporting channels, including country code and extension if applicable.',
    `cost_annual_usd` DECIMAL(18,2) COMMENT 'Estimated annual operating cost of maintaining this reporting channel in United States Dollars, including technology, staffing, and third-party service fees.',
    `country_codes_served` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where this channel is operational and accessible to affected populations and staff.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this reporting channel record was first created in the system. Audit trail field.',
    `data_retention_policy` STRING COMMENT 'Description of how long reports received through this channel are retained, including archival and destruction procedures in compliance with data protection regulations.',
    `deactivation_date` DATE COMMENT 'Date when the channel was deactivated or decommissioned and stopped accepting new reports. Null for currently active channels.',
    `establishment_date` DATE COMMENT 'Date when the reporting channel was officially established and made available to users. Supports tracking of channel maturity and historical analysis.',
    `external_reporting_integration_flag` BOOLEAN COMMENT 'Indicates whether this channel is integrated with external reporting systems such as United Nations Office for the Coordination of Humanitarian Affairs (OCHA) or donor-mandated platforms.',
    `geographic_coverage` STRING COMMENT 'Description of the geographic scope where this channel is accessible and promoted, such as specific countries, regions, field offices, or program areas.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this reporting channel record. Audit trail field.',
    `last_review_date` DATE COMMENT 'Date of the most recent review or assessment of the channels effectiveness, accessibility, and compliance with safeguarding standards.',
    `reporting_channel_name` STRING COMMENT 'Descriptive name of the reporting channel as communicated to affected populations and staff.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the channel to ensure continued effectiveness and compliance with Protection from Sexual Exploitation and Abuse (PSEA) requirements.',
    `notes` STRING COMMENT 'Additional free-text notes, observations, or context about the reporting channel not captured in structured fields.',
    `online_form_url` STRING COMMENT 'Web address of the online reporting form for digital submission channels. Must be secure (HTTPS) to protect reporter confidentiality.',
    `operating_hours_description` STRING COMMENT 'Textual description of when the channel is available for receiving reports, including days of week, time ranges, and timezone information.',
    `physical_location_address` STRING COMMENT 'Physical address where suggestion boxes or in-person reporting facilities are located, including building name, street, and office number.',
    `primary_language` STRING COMMENT 'ISO 639-3 three-letter code for the primary language in which the channel operates and receives reports.. Valid values are `^[A-Z]{3}$`',
    `promotion_materials_available_flag` BOOLEAN COMMENT 'Indicates whether information, education, and communication materials about this channel are available and distributed to target audiences.',
    `psea_network_registered_flag` BOOLEAN COMMENT 'Indicates whether this channel is registered with the inter-agency Protection from Sexual Exploitation and Abuse (PSEA) network for coordinated reporting and referral.',
    `reports_received_count` STRING COMMENT 'Cumulative number of safeguarding reports and complaints received through this channel since activation. Used for channel effectiveness analysis.',
    `review_frequency_months` STRING COMMENT 'Number of months between scheduled reviews of the reporting channel. Typical values are 6 or 12 months depending on organizational policy and channel risk profile.',
    `reporting_channel_status` STRING COMMENT 'Current operational status of the reporting channel. Active channels are available for receiving complaints and reports.. Valid values are `active|inactive|suspended|pilot|decommissioned`',
    `target_audience` STRING COMMENT 'Primary intended user group for this reporting channel. Determines communication strategy and accessibility requirements.. Valid values are `beneficiaries|staff|partners|community_members|all`',
    `third_party_provider_name` STRING COMMENT 'Name of the external organization or service provider operating the reporting channel on behalf of the organization, if applicable.',
    `translation_service_available_flag` BOOLEAN COMMENT 'Indicates whether real-time or on-demand translation services are available through this channel to support reporters who speak languages not directly supported.',
    `twenty_four_seven_availability_flag` BOOLEAN COMMENT 'Indicates whether the channel operates continuously without time restrictions. True for always-available channels such as online forms or third-party platforms.',
    `reporting_channel_type` STRING COMMENT 'Classification of the reporting mechanism type. Determines the mode of access and operational requirements for the channel.. Valid values are `hotline|suggestion_box|online_form|community_liaison|direct_report_to_manager|third_party_platform`',
    CONSTRAINT pk_reporting_channel PRIMARY KEY(`reporting_channel_id`)
) COMMENT 'Master catalog of all safeguarding reporting and complaints channels established by the organization. Captures channel name, channel type (hotline, suggestion box, online form, community liaison, direct report to manager, third-party reporting platform), operating hours, language support, anonymity supported flag, geographic coverage, responsible focal point, and channel status (active, inactive). Supports accountability to affected populations (AAP) and PSEA network reporting obligations.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` (
    `focal_point_id` BIGINT COMMENT 'Unique identifier for the safeguarding focal point assignment record.',
    `country_office_id` BIGINT COMMENT 'Reference to the field office for field-level focal points.',
    `focal_assigned_country_office_id` BIGINT COMMENT 'Reference to the country office for country-level focal points.',
    `intervention_id` BIGINT COMMENT 'Reference to the specific program for program-level focal points.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Focal point designation is tied to specific positions with defined safeguarding responsibilities in organizational structure, not just individuals. Essential for succession planning when position beco',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member designated as backup or alternate focal point for continuity of safeguarding coverage.',
    `primary_successor_focal_point_id` BIGINT COMMENT 'Reference to the focal point record that succeeded this assignment.',
    `tertiary_focal_reporting_line_staff_staff_member_id` BIGINT COMMENT 'Reference to the staff member to whom the focal point reports for safeguarding matters.',
    `tertiary_quinary_focal_last_modified_by_staff_staff_member_id` BIGINT COMMENT 'Reference to the staff member who last modified this focal point assignment record.',
    `assigned_country_office_id` BIGINT COMMENT '',
    `appointment_date` DATE COMMENT 'Date when the staff member was officially appointed to the focal point role.',
    `availability_hours` STRING COMMENT 'Description of the focal points availability hours for safeguarding support (e.g., 24/7, business hours, on-call).',
    `certification_date` DATE COMMENT 'Date when the focal point completed required safeguarding training and received certification.',
    `certification_expiry_date` DATE COMMENT 'Date when the focal points safeguarding training certification expires and renewal is required.',
    `focal_point_code` STRING COMMENT 'Business identifier for the focal point assignment, typically formatted as FP-[COUNTRY]-[NUMBER].. Valid values are `^FP-[A-Z]{3}-[0-9]{4}$`',
    `confidential_hotline` STRING COMMENT 'Dedicated confidential hotline number for reporting safeguarding incidents to the focal point.',
    `contact_email` STRING COMMENT 'Primary email address for contacting the focal point for safeguarding concerns.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for contacting the focal point for safeguarding concerns.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for country-level focal points.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this focal point assignment record was first created in the system.',
    `designation_type` STRING COMMENT 'Type of safeguarding focal point designation. PSEA = Protection from Sexual Exploitation and Abuse, GBV = Gender-Based Violence.. Valid values are `PSEA|child_safeguarding|GBV|general|disability_inclusion|elder_protection`',
    `external_reporting_authority` BOOLEAN COMMENT 'Flag indicating whether the focal point has authority to report incidents to external authorities or donors.',
    `handover_completed_flag` BOOLEAN COMMENT 'Flag indicating whether a formal handover to a successor focal point has been completed.',
    `handover_date` DATE COMMENT 'Date when the formal handover to a successor focal point was completed.',
    `incident_response_authority` BOOLEAN COMMENT 'Flag indicating whether the focal point has authority to initiate incident response actions without escalation.',
    `incidents_handled_count` STRING COMMENT 'Total number of safeguarding incidents handled by this focal point during their term.',
    `investigation_authority` BOOLEAN COMMENT 'Flag indicating whether the focal point has authority to lead or participate in safeguarding investigations.',
    `language_proficiency` STRING COMMENT 'Languages in which the focal point can provide safeguarding support, comma-separated.',
    `last_incident_date` DATE COMMENT 'Date of the most recent safeguarding incident handled by this focal point.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this focal point assignment record was last modified.',
    `notes` STRING COMMENT 'Additional notes or comments about the focal point assignment, responsibilities, or performance.',
    `performance_rating` STRING COMMENT 'Most recent performance rating for the focal points execution of safeguarding responsibilities.. Valid values are `outstanding|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `performance_review_date` DATE COMMENT 'Date of the most recent performance review for the focal points safeguarding responsibilities.',
    `primary_responsibility_description` STRING COMMENT 'Detailed description of the focal points primary safeguarding responsibilities and accountabilities.',
    `region_code` STRING COMMENT 'Code identifying the geographic region of responsibility for regional focal points.',
    `scope_type` STRING COMMENT 'Type of organizational or geographic scope for which the focal point has responsibility.. Valid values are `country|region|program|project|global|field_office`',
    `focal_point_status` STRING COMMENT 'Current status of the focal point assignment in its lifecycle.. Valid values are `active|inactive|on_leave|suspended|terminated`',
    `term_end_date` DATE COMMENT 'Date when the focal point term of service ends. Nullable for open-ended assignments.',
    `term_start_date` DATE COMMENT 'Date when the focal point term of service begins.',
    `termination_reason` STRING COMMENT 'Reason for termination or end of the focal point assignment (e.g., end of term, staff departure, reassignment, performance issues).',
    `training_certification_status` STRING COMMENT 'Current status of required safeguarding training certification for the focal point.. Valid values are `certified|pending|expired|not_required`',
    `training_provider` STRING COMMENT 'Name of the organization or institution that provided the safeguarding training certification.',
    CONSTRAINT pk_focal_point PRIMARY KEY(`focal_point_id`)
) COMMENT 'Master record for designated safeguarding focal points across the organization including country-level PSEA focal points, child safeguarding officers, and regional safeguarding leads. Captures focal point designation type (PSEA, child safeguarding, GBV, general), geographic or organizational scope of responsibility, appointment date, term end date, training certification status, and backup focal point assignment. Distinct from workforce.staff_member — this entity captures the safeguarding role assignment and accountability structure.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` (
    `psea_network_membership_id` BIGINT COMMENT 'Unique identifier for the PSEA network membership record. Primary key for this entity.',
    `country_office_id` BIGINT COMMENT 'Reference to the country office responsible for managing this network membership.',
    `predecessor_psea_network_membership_id` BIGINT COMMENT 'Self-referencing FK on psea_network_membership (predecessor_psea_network_membership_id)',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member designated as the organizations focal point or representative to the network.',
    `user_account_id` BIGINT COMMENT 'Reference to the user who created this membership record.',
    `psea_network_id` BIGINT COMMENT 'Reference to the inter-agency PSEA network or safeguarding coordination body that the organization is a member of.',
    `tertiary_psea_focal_point_staff_staff_member_id` BIGINT COMMENT 'FK to workforce.staff_member',
    `approval_date` DATE COMMENT 'Date when the organizations membership application was formally approved by the network.',
    `approved_by` STRING COMMENT 'Name or title of the network authority or committee that approved the membership.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the network operates. For regional networks, this may represent the primary country of coordination.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this membership record was first created in the system.',
    `end_date` DATE COMMENT 'Date when the organizations membership in the network ended or is scheduled to end. Null for active memberships.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Annual or periodic membership fee amount required by the network, if applicable.',
    `fee_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the membership fee.. Valid values are `^[A-Z]{3}$`',
    `fee_required_flag` BOOLEAN COMMENT 'Indicates whether the network requires a membership fee or financial contribution from member organizations.',
    `incident_reporting_protocol_adopted_flag` BOOLEAN COMMENT 'Indicates whether the organization has adopted the networks standardized incident reporting protocol.',
    `information_sharing_consent_flag` BOOLEAN COMMENT 'Indicates whether the organization has consented to share safeguarding incident information with network members in accordance with confidentiality protocols.',
    `joint_training_participation_flag` BOOLEAN COMMENT 'Indicates whether the organization participates in joint PSEA and safeguarding training activities organized by the network.',
    `key_commitments` STRING COMMENT 'Description of the key commitments and obligations the organization has made under the networks terms of reference, such as information sharing, joint training, incident reporting protocols, and survivor support coordination.',
    `last_fee_payment_date` DATE COMMENT 'Date when the organization last paid the membership fee.',
    `last_meeting_attendance_date` DATE COMMENT 'Date of the most recent network meeting attended by the organizations representative.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this membership record was last modified.',
    `meeting_attendance_frequency` STRING COMMENT 'Expected frequency of the organizations attendance at network coordination meetings.. Valid values are `Monthly|Quarterly|Bi-Annual|Annual|Ad-Hoc|As Needed`',
    `network_coordinator_contact_email` STRING COMMENT 'Email address of the network coordinator for administrative and coordination purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `network_coordinator_organization` STRING COMMENT 'Name of the lead organization or agency coordinating the network.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the membership, including special arrangements, conditions, or historical context.',
    `reference_number` STRING COMMENT 'External reference number or code assigned by the network to identify this organizations membership.',
    `region` STRING COMMENT 'Geographic region where the network operates (e.g., East Africa, Middle East, Asia-Pacific). Applicable for regional or multi-country networks.',
    `renewal_date` DATE COMMENT 'Date when the membership is due for renewal or review, if the network requires periodic renewal.',
    `start_date` DATE COMMENT 'Date when the organizations membership in the network became effective.',
    `psea_network_membership_status` STRING COMMENT 'Current status of the organizations membership in the network. Indicates whether the membership is active, pending approval, suspended, or terminated.. Valid values are `Active|Pending|Suspended|Inactive|Withdrawn|Expired`',
    `survivor_referral_pathway_adopted_flag` BOOLEAN COMMENT 'Indicates whether the organization has adopted the networks survivor-centered referral pathway for support services.',
    `suspension_reason` STRING COMMENT 'Reason for suspension of the organizations membership, if applicable (e.g., non-compliance with network standards, failure to meet commitments).',
    `suspension_start_date` DATE COMMENT 'Date when the membership suspension became effective.',
    `terms_of_reference_acceptance_date` DATE COMMENT 'Date when the organization formally accepted the networks terms of reference.',
    `terms_of_reference_accepted_flag` BOOLEAN COMMENT 'Indicates whether the organization has formally accepted the networks terms of reference and membership obligations.',
    `withdrawal_reason` STRING COMMENT 'Reason for the organizations withdrawal or termination from the network, if applicable.',
    CONSTRAINT pk_psea_network_membership PRIMARY KEY(`psea_network_membership_id`)
) COMMENT 'Association record capturing the organizations membership and participation in inter-agency PSEA networks, safeguarding working groups, and coordination bodies at country or regional level. Captures network name, network type (PSEA network, safeguarding cluster, inter-agency working group), country or region, membership start date, membership status, focal point assigned, and key commitments made under the networks terms of reference. Supports inter-agency accountability and information sharing obligations.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` (
    `misconduct_disclosure_id` BIGINT COMMENT 'Unique identifier for the misconduct disclosure record. Primary key for the misconduct disclosure entity.',
    `alleged_perpetrator_id` BIGINT COMMENT 'Foreign key linking to safeguarding.alleged_perpetrator. Business justification: Misconduct disclosures (Inter-Agency Misconduct Disclosure Scheme) are about specific individuals who are alleged perpetrators. Currently misconduct_disclosure has subject_full_name, subject_identifie',
    `country_office_id` BIGINT COMMENT 'Foreign key reference to the country office or field location that initiated the disclosure request or is processing the response. Used for geographic reporting and accountability.',
    `user_account_id` BIGINT COMMENT 'Foreign key reference to the user who created this disclosure record. Used for accountability and audit trail.',
    `prior_misconduct_disclosure_id` BIGINT COMMENT 'Self-referencing FK on misconduct_disclosure (prior_misconduct_disclosure_id)',
    `recruitment_requisition_id` BIGINT COMMENT 'Foreign key reference to the recruitment or vetting process that triggered this misconduct disclosure request. Links disclosure to the hiring or partner vetting workflow.',
    `staff_member_id` BIGINT COMMENT 'Foreign key reference to the staff member who initiated the disclosure request or processed the inbound response. Used for accountability and audit trail.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Misconduct disclosure requests must identify position held by subject for role-specific risk assessment (child contact roles, beneficiary-facing positions, supervisory authority). Required for inter-a',
    `action_taken_by_requesting_org` STRING COMMENT 'Action taken by the requesting organization based on the disclosure response: candidate rejected (not hired/engaged), candidate accepted with conditions (hired with additional safeguarding measures), additional vetting required, no action (disclosure did not impact decision), or pending review.. Valid values are `candidate_rejected|candidate_accepted_with_conditions|additional_vetting_required|no_action|pending_review`',
    `beneficiary_facing_role_flag` BOOLEAN COMMENT 'Boolean indicator of whether the position involves direct contact with beneficiaries, particularly vulnerable populations. True if beneficiary-facing, False if back-office or non-beneficiary-facing role. Critical for safeguarding risk assessment.',
    `channel` STRING COMMENT 'Communication channel through which the disclosure request or response was transmitted: Misconduct Disclosure Scheme (MDS) platform, email, secure portal, phone, in-person, or other.. Valid values are `mds_platform|email|secure_portal|phone|in_person|other`',
    `child_contact_role_flag` BOOLEAN COMMENT 'Boolean indicator of whether the position involves direct contact with children (individuals under 18 years of age). True if child-contact role, False otherwise. Triggers enhanced child safeguarding vetting requirements.',
    `confidentiality_level` STRING COMMENT 'Data classification level for this disclosure record: restricted (highest confidentiality, limited access), confidential (sensitive, controlled access), or internal (organization-wide access). Determines access controls and data retention policies.. Valid values are `restricted|confidential|internal`',
    `consent_date` DATE COMMENT 'Date when the subject provided informed consent for the disclosure. Null if consent was not obtained or not applicable.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Boolean indicator of whether the subject provided informed consent for the disclosure of their information. True if consent obtained, False if consent not obtained or not applicable (e.g., mandatory disclosure per policy).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this misconduct disclosure record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_retention_expiry_date` DATE COMMENT 'Date when this disclosure record is scheduled for archival or deletion per organizational data retention policies and legal requirements. Ensures compliance with data protection regulations.',
    `direction` STRING COMMENT 'Direction of the disclosure transaction: outbound request (organization requesting information about a candidate), inbound response (organization providing information in response to another organizations request), or bilateral exchange (mutual information sharing).. Valid values are `outbound_request|inbound_response|bilateral_exchange`',
    `disciplinary_action_taken` STRING COMMENT 'Description of disciplinary action taken by the responding organization in response to the confirmed misconduct (e.g., termination, suspension, written warning, mandatory training). Free-text field to capture organizational response.',
    `employment_period_end_date` DATE COMMENT 'End date of the subjects employment or engagement with the responding organization. Null if currently employed or engagement is ongoing.',
    `employment_period_start_date` DATE COMMENT 'Start date of the subjects employment or engagement with the responding organization. Used to establish timeline context for misconduct incidents.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this misconduct disclosure record was last updated. Used for audit trail and change tracking.',
    `law_enforcement_referral_flag` BOOLEAN COMMENT 'Boolean indicator of whether the misconduct case was referred to law enforcement authorities. True if referred, False if not referred.',
    `misconduct_category` STRING COMMENT 'Primary category of confirmed misconduct disclosed: sexual exploitation, sexual abuse, child abuse, harassment, fraud, theft, violence, or other. Populated only if misconduct was confirmed. [ENUM-REF-CANDIDATE: sexual_exploitation|sexual_abuse|child_abuse|harassment|fraud|theft|violence|other — 8 candidates stripped; promote to reference product]',
    `misconduct_confirmed_flag` BOOLEAN COMMENT 'Boolean indicator of whether prior misconduct was confirmed in the disclosure response. True if misconduct confirmed, False if no misconduct found or not applicable.',
    `misconduct_incident_date` DATE COMMENT 'Date when the disclosed misconduct incident occurred. May be approximate if exact date is unknown. Populated only if misconduct was confirmed.',
    `misconduct_severity_level` STRING COMMENT 'Severity classification of the confirmed misconduct: critical (immediate threat to beneficiaries or staff), high (serious policy violation), medium (moderate violation), low (minor infraction).. Valid values are `critical|high|medium|low`',
    `notes` STRING COMMENT 'Free-text field for additional context, observations, or follow-up actions related to the disclosure. May include details about the disclosure process, communication with the responding organization, or internal decision-making rationale.',
    `reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this disclosure transaction within the Inter-Agency Misconduct Disclosure Scheme or equivalent reference check mechanism. Format: MDS-{ORG}-{SEQUENCE}.. Valid values are `^MDS-[A-Z]{3}-[0-9]{6}$`',
    `request_date` DATE COMMENT 'Date when the misconduct disclosure request was initiated or received. Represents the principal business event timestamp for this transaction.',
    `requesting_organization_country` STRING COMMENT 'Country where the requesting or responding organization is headquartered or registered, represented as a 3-letter ISO country code.. Valid values are `^[A-Z]{3}$`',
    `requesting_organization_name` STRING COMMENT 'Name of the organization requesting misconduct disclosure information (for outbound requests) or the organization from which information is being requested (for inbound responses).',
    `requesting_organization_type` STRING COMMENT 'Type of organization requesting or providing disclosure information: International Non-Governmental Organization (INGO), Civil Society Organization (CSO), Community-Based Organization (CBO), United Nations (UN) agency, government, donor, or private sector. [ENUM-REF-CANDIDATE: ingo|cso|cbo|un_agency|government|donor|private_sector — 7 candidates stripped; promote to reference product]',
    `response_date` DATE COMMENT 'Date when the disclosure response was provided or received. Null if no response has been received or provided yet.',
    `response_received_flag` BOOLEAN COMMENT 'Boolean indicator of whether a response has been received for an outbound disclosure request. True if response received, False if pending or no response.',
    `response_turnaround_days` STRING COMMENT 'Number of calendar days between the disclosure request date and the response date. Used to track compliance with Inter-Agency Misconduct Disclosure Scheme (MDS) response time standards.',
    `misconduct_disclosure_status` STRING COMMENT 'Current lifecycle status of the disclosure transaction: pending (request initiated but not yet processed), in progress (under review), completed (response received or provided), no response (request timed out), declined (organization declined to provide information).. Valid values are `pending|in_progress|completed|no_response|declined`',
    `subject_reference_type` STRING COMMENT 'Type of individual or entity that is the subject of the misconduct disclosure: staff candidate (prospective employee), volunteer candidate, consultant, partner organization, or vendor.. Valid values are `staff_candidate|volunteer_candidate|consultant|partner_organization|vendor`',
    `termination_for_cause_flag` BOOLEAN COMMENT 'Boolean indicator of whether the subjects employment was terminated for cause related to the disclosed misconduct. True if terminated for cause, False otherwise.',
    `misconduct_disclosure_type` STRING COMMENT 'Category of misconduct being disclosed: prior misconduct (general misconduct history), Sexual Exploitation and Abuse (SEA) finding, disciplinary termination, safeguarding concern, Protection from Sexual Exploitation and Abuse (PSEA) violation, or child safeguarding breach.. Valid values are `prior_misconduct|sea_finding|disciplinary_termination|safeguarding_concern|psea_violation|child_safeguarding_breach`',
    CONSTRAINT pk_misconduct_disclosure PRIMARY KEY(`misconduct_disclosure_id`)
) COMMENT 'Transactional record of disclosures made to or received from the Inter-Agency Misconduct Disclosure Scheme (MDS) or equivalent reference check mechanisms during staff recruitment or partner vetting. Captures disclosure direction (outbound request, inbound response), subject reference, requesting organization, disclosure date, disclosure type (prior misconduct, SEA finding, disciplinary termination), response received flag, and action taken. Supports the humanitarian sectors commitment to preventing perpetrator mobility.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`audit` (
    `audit_id` BIGINT COMMENT 'Unique identifier for the safeguarding audit record. Primary key for the audit entity.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Safeguarding audits frequently assess technology systems that handle sensitive data (case management platforms, incident reporting tools, survivor databases). Auditors need to link audit scope to spec',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Safeguarding audits of grant-funded programs must link to awards for compliance verification, donor reporting of audit findings, tracking audit costs against grant budgets, and demonstrating adherence',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Safeguarding audits examine specific organizational units (country offices, departments). Audit costs (audit_cost_amount) must be allocated to the audited cost center for budget tracking and to ensure',
    `country_office_id` BIGINT COMMENT 'Identifier of the primary country office or operational location that is the subject of this safeguarding audit. Null if the audit covers multiple countries or is organization-wide.',
    `intervention_id` BIGINT COMMENT 'Identifier of the specific program or project that is the subject of this safeguarding audit. Null if the audit is organization-wide or covers multiple programs.',
    `previous_audit_id` BIGINT COMMENT 'Self-referencing FK on audit (previous_audit_id)',
    `user_account_id` BIGINT COMMENT 'Identifier of the system user who most recently modified this safeguarding audit record. Supports accountability and audit trail requirements.',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member or consultant serving as the lead auditor responsible for planning, executing, and reporting on this safeguarding audit.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse. Business justification: Safeguarding audits assess warehouse-level compliance with PSEA policies, staff conduct, and facility safeguarding controls. Required for facility-level safeguarding maturity assessment, compliance ve',
    `actual_completion_date` DATE COMMENT 'The actual date when the safeguarding audit was completed and the final report was issued. Null if the audit is still in progress.',
    `audit_category` STRING COMMENT 'Thematic focus area of the safeguarding audit. Indicates whether the audit covers Protection from Sexual Exploitation and Abuse (PSEA), child safeguarding, staff conduct, organizational policy compliance, incident management processes, survivor support mechanisms, or a comprehensive review across all safeguarding domains. [ENUM-REF-CANDIDATE: psea|child_safeguarding|staff_conduct|organizational_policy|incident_management|survivor_support|comprehensive — 7 candidates stripped; promote to reference product]',
    `commissioning_organization` STRING COMMENT 'Name of the organization or entity that commissioned or requested this safeguarding audit. May be internal (e.g., Board of Directors, Executive Leadership) or external (e.g., donor agency, regulatory body, inter-agency network).',
    `compliance_score` DECIMAL(18,2) COMMENT 'Quantitative compliance score or percentage representing the organizations adherence to safeguarding standards and requirements assessed in this audit. Scale and methodology defined by the audit framework.',
    `confidentiality_level` STRING COMMENT 'Classification level governing access to and distribution of this safeguarding audit report and findings. Determines who may view the audit results and under what conditions.. Valid values are `public|internal|confidential|restricted`',
    `corrective_action_plan_required_flag` BOOLEAN COMMENT 'Indicates whether a formal corrective action plan is required in response to this safeguarding audit findings. True if management must develop and implement a structured action plan.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for conducting this safeguarding audit, including auditor fees, travel expenses, and other direct costs. Used for budget tracking and cost-benefit analysis.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the audit cost amount. Indicates the currency in which audit expenses were incurred and recorded.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this safeguarding audit record was first created in the system. Audit trail for data governance and record-keeping.',
    `critical_findings_count` STRING COMMENT 'Number of critical or high-severity findings identified in this safeguarding audit that require immediate management attention and corrective action.',
    `documents_reviewed_count` STRING COMMENT 'Total number of policies, procedures, incident reports, training records, and other documents reviewed during this safeguarding audit.',
    `external_reporting_date` DATE COMMENT 'Date when the safeguarding audit results were reported to external stakeholders such as donors, regulatory authorities, or inter-agency coordination bodies.',
    `external_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether the results of this safeguarding audit must be reported to external stakeholders such as donors, regulatory bodies, or inter-agency networks. True if external reporting is mandatory.',
    `findings_summary` STRING COMMENT 'Executive summary of the key findings, observations, strengths, and areas for improvement identified during this safeguarding audit. High-level overview of audit results.',
    `follow_up_audit_required_flag` BOOLEAN COMMENT 'Indicates whether a follow-up audit is required to verify implementation of corrective actions and recommendations from this safeguarding audit. True if follow-up review is mandated.',
    `follow_up_audit_scheduled_date` DATE COMMENT 'Planned date for the follow-up audit to verify implementation of corrective actions and recommendations from this safeguarding audit.',
    `good_practices_identified_count` STRING COMMENT 'Number of good practices, strengths, or exemplary safeguarding approaches identified during this audit that can be shared and replicated across the organization.',
    `interviews_conducted_count` STRING COMMENT 'Total number of interviews conducted with staff, beneficiaries, partners, and other stakeholders as part of this safeguarding audit fieldwork.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this safeguarding audit record was most recently updated in the system. Audit trail for data governance and change tracking.',
    `lead_auditor_name` STRING COMMENT 'Full name of the lead auditor responsible for this safeguarding audit. Captured for reporting and accountability purposes.',
    `lessons_learned` STRING COMMENT 'Key lessons learned and insights gained from this safeguarding audit that can inform future audits, organizational learning, and continuous improvement of safeguarding systems.',
    `major_findings_count` STRING COMMENT 'Number of major or medium-severity findings identified in this safeguarding audit that represent significant gaps or risks requiring corrective action.',
    `management_response_date` DATE COMMENT 'Date when management submitted their formal response to the safeguarding audit findings and recommendations, including action plans and timelines.',
    `management_response_received_flag` BOOLEAN COMMENT 'Indicates whether management has provided a formal response to the audit findings and recommendations. True if management response has been received and documented.',
    `methodology` STRING COMMENT 'Description of the audit approach, techniques, and standards applied during this safeguarding audit. May include document review, interviews, site visits, beneficiary consultations, and compliance testing methods.',
    `minor_findings_count` STRING COMMENT 'Number of minor or low-severity findings identified in this safeguarding audit that represent opportunities for improvement but do not pose significant risk.',
    `overall_safeguarding_maturity_rating` STRING COMMENT 'Overall assessment of the organizations safeguarding maturity level based on this audit. Uses a capability maturity model scale from initial (Level 1) to optimized (Level 5), reflecting the sophistication and effectiveness of safeguarding systems, policies, and culture.. Valid values are `level_1_initial|level_2_developing|level_3_established|level_4_advanced|level_5_optimized|not_rated`',
    `period_end_date` DATE COMMENT 'The ending date of the time period under review by this safeguarding audit. Defines the conclusion of the operational period being assessed for safeguarding compliance and effectiveness.',
    `period_start_date` DATE COMMENT 'The beginning date of the time period under review by this safeguarding audit. Defines the start of the operational period being assessed for safeguarding compliance and effectiveness.',
    `planned_completion_date` DATE COMMENT 'The target date by which the safeguarding audit is scheduled to be completed, including final report issuance. Used for planning and resource allocation.',
    `recommendations_count` STRING COMMENT 'Total number of recommendations for improvement issued as part of this safeguarding audit. Includes all severity levels and action items proposed to strengthen safeguarding systems.',
    `reference_number` STRING COMMENT 'Externally-known unique reference number or code assigned to this safeguarding audit for tracking and reporting purposes.',
    `report_document_url` STRING COMMENT 'URL or file path to the final safeguarding audit report document stored in the organizations document management system. Provides access to the complete audit report with detailed findings and recommendations.',
    `scope` STRING COMMENT 'Detailed description of the boundaries, focus areas, organizational units, programs, and geographic locations covered by this safeguarding audit. Defines what is included and excluded from the audit review.',
    `site_visits_conducted_count` STRING COMMENT 'Total number of field offices, program sites, or operational locations physically visited by the audit team during this safeguarding audit.',
    `start_date` DATE COMMENT 'The date when the safeguarding audit fieldwork and assessment activities commenced. Distinct from the audit period start date; this represents when the audit team began their review.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the safeguarding audit. Tracks progression from planning through fieldwork, reporting, and closure. [ENUM-REF-CANDIDATE: planned|in_progress|fieldwork_complete|draft_report|final_report_issued|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `team_members` STRING COMMENT 'Comma-separated list or narrative description of all team members, consultants, and subject matter experts who participated in conducting this safeguarding audit.',
    `audit_type` STRING COMMENT 'Classification of the safeguarding audit by its commissioning authority and purpose. Distinguishes between internal self-assessments, donor-commissioned reviews, inter-agency peer reviews, CHS safeguarding commitment audits, external independent audits, and regulatory compliance audits.. Valid values are `internal_self_assessment|donor_commissioned_review|inter_agency_peer_review|chs_safeguarding_commitment_audit|external_independent_audit|regulatory_compliance_audit`',
    CONSTRAINT pk_audit PRIMARY KEY(`audit_id`)
) COMMENT 'Master record for periodic organizational safeguarding audits, PSEA self-assessments, and external safeguarding reviews. Captures audit type (internal self-assessment, donor-commissioned review, inter-agency peer review, CHS safeguarding commitment audit), audit scope, audit period, lead auditor, key findings summary, overall safeguarding maturity rating, and number of recommendations raised. Distinct from compliance.chs_self_assessment — this entity is owned by the safeguarding function and covers safeguarding-specific audit cycles.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` (
    `audit_recommendation_id` BIGINT COMMENT 'Unique identifier for the audit recommendation record. Primary key for the audit recommendation entity.',
    `audit_id` BIGINT COMMENT 'Reference to the parent safeguarding audit, Protection from Sexual Exploitation and Abuse (PSEA) assessment, or investigation review that generated this recommendation.',
    `country_office_id` BIGINT COMMENT 'Reference to the country office where this recommendation applies. Enables tracking of safeguarding improvements by geographic location.',
    `intervention_id` BIGINT COMMENT 'Reference to the specific program if the recommendation is program-specific rather than organization-wide.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member who is accountable for implementing this recommendation and ensuring completion by the target date.',
    `psea_policy_id` BIGINT COMMENT 'Reference to the Protection from Sexual Exploitation and Abuse (PSEA) policy or safeguarding policy that this recommendation relates to or requires updating.',
    `superseded_audit_recommendation_id` BIGINT COMMENT 'Self-referencing FK on audit_recommendation (superseded_audit_recommendation_id)',
    `tertiary_audit_created_by_staff_staff_member_id` BIGINT COMMENT 'Reference to the staff member who created this recommendation record, typically the lead auditor or investigator.',
    `tertiary_quinary_audit_responsible_owner_staff_staff_member_id` BIGINT COMMENT 'FK to workforce.staff_member',
    `actual_completion_date` DATE COMMENT 'Date when the recommendation was actually completed and verified. Null if not yet completed.',
    `budget_allocated_flag` BOOLEAN COMMENT 'Indicates whether budget has been allocated to implement this recommendation. Critical for tracking resource constraints that may delay implementation.',
    `audit_recommendation_category` STRING COMMENT 'Safeguarding domain category that this recommendation addresses: Protection from Sexual Exploitation and Abuse (PSEA), child safeguarding, staff conduct, survivor support, reporting mechanism, or investigation process.. Valid values are `psea|child_safeguarding|staff_conduct|survivor_support|reporting_mechanism|investigation_process`',
    `closure_notes` STRING COMMENT 'Final notes documenting the completion, verification, and closure of the recommendation, including any outstanding considerations or follow-up requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this recommendation record was first created in the system, typically immediately following the audit or investigation report finalization.',
    `days_overdue` STRING COMMENT 'Number of days past the target completion date if the recommendation remains incomplete. Calculated as current date minus target completion date when status is overdue.',
    `deferral_reason` STRING COMMENT 'Justification provided when a recommendation is deferred, including resource constraints, competing priorities, or external dependencies that prevent immediate implementation.',
    `deferred_until_date` DATE COMMENT 'New target date when a deferred recommendation is expected to be addressed.',
    `donor_reported_date` DATE COMMENT 'Date when the recommendation and its status were reported to donors or oversight bodies.',
    `donor_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this recommendation and its implementation status must be reported to donors or oversight bodies as part of safeguarding accountability requirements.',
    `evidence_document_url` STRING COMMENT 'Link to the document management system location where supporting evidence of recommendation completion is stored.',
    `evidence_of_completion` STRING COMMENT 'Description of the evidence provided to verify that the recommendation has been fully implemented (e.g., updated policy document, training records, system screenshots, process documentation).',
    `follow_up_action_required_flag` BOOLEAN COMMENT 'Indicates whether additional follow-up actions or monitoring are required after initial implementation to ensure sustained compliance.',
    `implementation_cost_usd` DECIMAL(18,2) COMMENT 'Estimated or actual cost in United States Dollars to implement the recommendation, including staff time, training, system changes, or policy development costs.',
    `implementation_progress_percentage` STRING COMMENT 'Estimated percentage of completion for the recommendation implementation, ranging from 0 to 100. Used to track progress for in-progress recommendations.',
    `implementation_status` STRING COMMENT 'Current state of recommendation implementation. Open indicates not yet started; in progress indicates active work underway; completed indicates fully implemented with evidence; overdue indicates past target date without completion; deferred indicates postponed with justification; cancelled indicates no longer applicable.. Valid values are `open|in_progress|completed|overdue|deferred|cancelled`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this recommendation record was last updated, reflecting status changes, progress updates, or evidence submission.',
    `lessons_learned` STRING COMMENT 'Key insights, challenges, and best practices identified during the implementation of this recommendation that can inform future safeguarding improvements.',
    `management_acceptance_status` STRING COMMENT 'Indicates whether management has accepted the recommendation. Accepted indicates full agreement and commitment to implement; partially accepted indicates agreement with modifications; not accepted indicates disagreement with recommendation; under review indicates management is still evaluating.. Valid values are `accepted|partially_accepted|not_accepted|under_review`',
    `management_response` STRING COMMENT 'Official response from management regarding the recommendation, including acceptance, planned actions, timeline, and any concerns or resource constraints.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review or monitoring check of the implemented recommendation to ensure sustained effectiveness.',
    `number` STRING COMMENT 'Business identifier for the recommendation, typically formatted as audit number plus sequential recommendation number (e.g., AUD-2024-001-R01).',
    `priority_level` STRING COMMENT 'Urgency and importance classification of the recommendation. Critical indicates immediate action required to address severe safeguarding risk; high indicates significant risk requiring prompt action; medium indicates moderate risk with reasonable timeframe; low indicates minor improvement with flexible timeline.. Valid values are `critical|high|medium|low`',
    `responsible_department` STRING COMMENT 'Organizational department or unit responsible for implementing the recommendation (e.g., Human Resources, Programs, Finance, Safeguarding).',
    `risk_level` STRING COMMENT 'Assessment of the safeguarding risk level if the recommendation is not implemented. Reflects potential harm to beneficiaries, staff, or organizational reputation.. Valid values are `critical|high|medium|low`',
    `target_completion_date` DATE COMMENT 'Planned date by which the recommendation should be fully implemented. Set based on priority level and complexity of the action required.',
    `text` STRING COMMENT 'Full detailed text of the recommendation describing the required action, improvement, or corrective measure to address the identified safeguarding gap or risk.',
    `title` STRING COMMENT 'Short descriptive title summarizing the recommendation action or improvement area.',
    `audit_recommendation_type` STRING COMMENT 'Classification of the recommendation by the nature of the improvement required: policy change, process enhancement, training requirement, system upgrade, structural change, behavioral change, or compliance action. [ENUM-REF-CANDIDATE: policy|process|training|system|structural|behavioral|compliance — 7 candidates stripped; promote to reference product]',
    `verification_date` DATE COMMENT 'Date when the recommendation implementation was independently verified by audit or safeguarding team.',
    `verification_outcome` STRING COMMENT 'Result of the independent verification process. Verified indicates full implementation confirmed; partially verified indicates incomplete implementation; not verified indicates implementation not confirmed; pending verification indicates verification scheduled but not yet completed.. Valid values are `verified|partially_verified|not_verified|pending_verification`',
    `verification_required_flag` BOOLEAN COMMENT 'Indicates whether independent verification or audit follow-up is required to confirm recommendation implementation. True for critical and high priority recommendations.',
    CONSTRAINT pk_audit_recommendation PRIMARY KEY(`audit_recommendation_id`)
) COMMENT 'Transactional record of individual recommendations arising from safeguarding audits, PSEA assessments, or investigation reviews. Captures recommendation number, recommendation text, priority level (critical, high, medium, low), responsible owner, target completion date, implementation status (open, in progress, completed, overdue), and evidence of completion. Enables tracking of safeguarding improvement actions and demonstrates organizational accountability to donors and oversight bodies.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` (
    `donor_safeguarding_requirement_id` BIGINT COMMENT 'Unique identifier for the donor safeguarding requirement record. Primary key.',
    `award_id` BIGINT COMMENT 'Identifier of the specific grant or funding mechanism to which this safeguarding requirement applies. May be null if requirement applies across multiple grants or at donor relationship level.',
    `constituent_id` BIGINT COMMENT 'Identifier of the donor imposing this safeguarding requirement. Links to the donor master entity.',
    `psea_policy_id` BIGINT COMMENT 'Identifier of the internal safeguarding policy that addresses or fulfills this donor requirement. Links to the PSEA policy or other safeguarding policy master.',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member responsible for ensuring compliance with this safeguarding requirement.',
    `superseded_donor_safeguarding_requirement_id` BIGINT COMMENT 'Self-referencing FK on donor_safeguarding_requirement (superseded_donor_safeguarding_requirement_id)',
    `tertiary_donor_last_modified_by_staff_staff_member_id` BIGINT COMMENT 'Identifier of the staff member who last modified this donor safeguarding requirement record.',
    `applicable_country_codes` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where this safeguarding requirement applies. May be null if requirement applies globally across all operations.',
    `applicable_program_ids` STRING COMMENT 'Comma-separated list of program identifiers to which this safeguarding requirement applies. May be null if requirement applies organization-wide.',
    `approval_date` DATE COMMENT 'Date when the donor formally approved or accepted the submitted safeguarding requirement evidence.',
    `compliance_notes` STRING COMMENT 'Free-text notes documenting compliance activities, challenges, communications with donor, or other relevant information regarding this safeguarding requirement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this donor safeguarding requirement record was first created in the system.',
    `donor_safeguarding_requirement_description` STRING COMMENT 'Detailed description of the safeguarding requirement, including specific deliverables, evidence formats, and donor expectations.',
    `donor_contact_email` STRING COMMENT 'Email address of the donor representative for correspondence regarding this safeguarding requirement.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `donor_contact_name` STRING COMMENT 'Name of the donor representative or contact person responsible for this safeguarding requirement.',
    `due_date` DATE COMMENT 'Date by which the safeguarding requirement must be fulfilled and submitted to the donor.',
    `effective_date` DATE COMMENT 'Date from which this safeguarding requirement becomes effective and applicable to the organization.',
    `evidence_document_url` STRING COMMENT 'URL or file path to the stored evidence document or deliverable that fulfills this safeguarding requirement.',
    `expiry_date` DATE COMMENT 'Date when this safeguarding requirement is no longer applicable, typically aligned with grant end date or superseded by updated requirements.',
    `frequency` STRING COMMENT 'Recurrence pattern for this safeguarding requirement. Indicates whether it is a one-time submission, recurring periodic requirement, or triggered by specific events. [ENUM-REF-CANDIDATE: one_time|annual|semi_annual|quarterly|monthly|upon_incident|continuous — 7 candidates stripped; promote to reference product]',
    `incident_reporting_timeframe_hours` STRING COMMENT 'For incident reporting requirements, the maximum number of hours within which safeguarding incidents must be reported to the donor. Common values include 24, 48, or 72 hours.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this donor safeguarding requirement record was last updated.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this safeguarding requirement is mandatory for grant award or continuation. True if non-compliance would result in grant suspension or termination.',
    `next_due_date` DATE COMMENT 'For recurring requirements, the next scheduled due date after the current submission cycle.',
    `non_compliance_consequence` STRING COMMENT 'Description of the consequences specified by the donor for failure to meet this safeguarding requirement, such as grant suspension, funding withholding, or termination.',
    `non_compliance_risk_level` STRING COMMENT 'Assessment of the organizational risk level if this safeguarding requirement is not met. Critical level may indicate risk of grant suspension or reputational damage.. Valid values are `low|medium|high|critical`',
    `reference_number` STRING COMMENT 'External reference number or code assigned by the donor to this safeguarding requirement for tracking and correspondence purposes.',
    `responsible_department` STRING COMMENT 'Name of the organizational department or unit responsible for fulfilling this safeguarding requirement.',
    `donor_safeguarding_requirement_status` STRING COMMENT 'Current compliance status of the safeguarding requirement. Tracks progression from pending through submission to approval or identifies overdue or waived requirements. [ENUM-REF-CANDIDATE: pending|in_progress|submitted|approved|rejected|overdue|waived — 7 candidates stripped; promote to reference product]',
    `submission_date` DATE COMMENT 'Actual date when the safeguarding requirement evidence or deliverable was submitted to the donor.',
    `submission_format` STRING COMMENT 'Required format or method for submitting the safeguarding requirement evidence to the donor. [ENUM-REF-CANDIDATE: pdf_document|online_portal|email|certified_letter|audit_report|training_certificate|policy_document — 7 candidates stripped; promote to reference product]',
    `submission_method` STRING COMMENT 'Channel or mechanism through which the safeguarding requirement must be submitted to the donor.. Valid values are `donor_portal|email|postal_mail|in_person|secure_file_transfer`',
    `title` STRING COMMENT 'Short descriptive title of the safeguarding requirement as specified by the donor.',
    `donor_safeguarding_requirement_type` STRING COMMENT 'Category of safeguarding compliance requirement imposed by the donor. Examples include PSEA policy submission, training completion evidence, incident reporting within specified timeframe, annual safeguarding report, background check verification, or safeguarding audit.. Valid values are `psea_policy_submission|training_completion_evidence|incident_reporting_protocol|annual_safeguarding_report|background_check_verification|safeguarding_audit`',
    `waiver_expiry_date` DATE COMMENT 'Date when the granted waiver expires and the safeguarding requirement becomes mandatory again.',
    `waiver_granted_flag` BOOLEAN COMMENT 'Indicates whether the donor has granted a waiver or exemption for this safeguarding requirement.',
    `waiver_reason` STRING COMMENT 'Explanation or justification for why a waiver was granted by the donor for this safeguarding requirement.',
    CONSTRAINT pk_donor_safeguarding_requirement PRIMARY KEY(`donor_safeguarding_requirement_id`)
) COMMENT 'Reference master capturing donor-specific safeguarding compliance requirements imposed on the organization as conditions of grant awards. Captures donor name, requirement type (PSEA policy submission, training completion evidence, incident reporting within 72 hours, annual safeguarding report), applicable grant or funding mechanism, due date, submission format, and compliance status. Complements grant.donor_condition by focusing specifically on safeguarding obligations with their own tracking and evidence management workflow.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` (
    `partner_psea_assessment_id` BIGINT COMMENT 'Unique identifier for the partner PSEA assessment record. Primary key.',
    `capacity_assessment_id` BIGINT COMMENT 'Foreign key linking to partnership.capacity_assessment. Business justification: General capacity assessments trigger specialized PSEA assessments when safeguarding gaps identified. Links overall partner capacity evaluation to safeguarding-specific deep-dive. Required for comprehe',
    `capacity_building_plan_id` BIGINT COMMENT 'Identifier of the capacity-building plan created to address PSEA gaps identified in this assessment.',
    `country_office_id` BIGINT COMMENT 'Identifier of the country office responsible for conducting or overseeing this PSEA assessment.',
    `intervention_id` BIGINT COMMENT 'Identifier of the program for which this partner PSEA assessment was conducted, if assessment is program-specific.',
    `partner_org_id` BIGINT COMMENT 'Identifier of the implementing partner organization being assessed for PSEA capacity.',
    `previous_partner_psea_assessment_id` BIGINT COMMENT 'Self-referencing FK on partner_psea_assessment (previous_partner_psea_assessment_id)',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member who conducted or led the PSEA assessment.',
    `tertiary_partner_created_by_staff_staff_member_id` BIGINT COMMENT 'Identifier of the staff member who created this PSEA assessment record.',
    `approval_date` DATE COMMENT 'Date when the PSEA assessment results and partnership decision were formally approved.',
    `capacity_building_plan_triggered_flag` BOOLEAN COMMENT 'Indicates whether the assessment findings triggered the requirement for a formal capacity-building plan to address identified gaps.',
    `capacity_score` DECIMAL(18,2) COMMENT 'Numerical score representing the partners PSEA capacity, calculated using the assessment tools scoring methodology.',
    `completion_date` DATE COMMENT 'Date when the PSEA assessment was finalized and results documented.',
    `conditional_approval_requirements` STRING COMMENT 'Specific conditions and milestones that must be met if the partnership was conditionally approved pending PSEA capacity improvements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this PSEA assessment record was first created in the system.',
    `critical_gap_flag` BOOLEAN COMMENT 'Indicates whether critical safeguarding gaps were identified that pose immediate risk and require urgent remediation before partnership can proceed.',
    `partner_psea_assessment_date` DATE COMMENT 'Date when the PSEA capacity assessment was conducted or completed.',
    `expiry_date` DATE COMMENT 'Date when this PSEA assessment expires and a new assessment must be conducted.',
    `investigation_capacity_rating` STRING COMMENT 'Rating of the partners capacity to conduct fair, timely, and survivor-centered investigations of safeguarding incidents.. Valid values are `compliant|partially_compliant|non_compliant|not_assessed`',
    `key_gaps_identified` STRING COMMENT 'Summary of the main safeguarding and PSEA capacity gaps identified during the assessment that require remediation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this PSEA assessment record was last updated.',
    `maximum_possible_score` DECIMAL(18,2) COMMENT 'Maximum score achievable in the PSEA assessment tool used, providing context for the capacity score.',
    `methodology_description` STRING COMMENT 'Description of the specific methodology, tools, and approach used to conduct the PSEA assessment.',
    `notes` STRING COMMENT 'Additional notes, observations, or context related to the PSEA assessment process and findings.',
    `overall_capacity_rating` STRING COMMENT 'Overall rating of the partners safeguarding and PSEA capacity based on the assessment findings.. Valid values are `high|medium|low|inadequate|not_assessed`',
    `partnership_approval_status` STRING COMMENT 'Decision on whether the partner is approved for partnership engagement based on PSEA assessment results.. Valid values are `approved|conditional_approval|not_approved|pending_review`',
    `policy_existence_rating` STRING COMMENT 'Rating of whether the partner has adequate PSEA and safeguarding policies in place.. Valid values are `compliant|partially_compliant|non_compliant|not_assessed`',
    `reassessment_due_date` DATE COMMENT 'Date by which the partner must undergo a follow-up PSEA assessment to verify capacity improvements.',
    `reassessment_required_flag` BOOLEAN COMMENT 'Indicates whether a follow-up reassessment is required to verify implementation of capacity-building actions.',
    `recommendations` STRING COMMENT 'Detailed recommendations for improving the partners PSEA and safeguarding capacity based on assessment findings.',
    `reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this PSEA assessment for tracking and reporting purposes.',
    `report_document_url` STRING COMMENT 'URL or file path to the detailed PSEA assessment report document.',
    `reporting_mechanism_rating` STRING COMMENT 'Rating of the adequacy and accessibility of the partners safeguarding incident reporting mechanisms.. Valid values are `compliant|partially_compliant|non_compliant|not_assessed`',
    `staff_training_rating` STRING COMMENT 'Rating of the partners PSEA and safeguarding training programs for staff and volunteers.. Valid values are `compliant|partially_compliant|non_compliant|not_assessed`',
    `start_date` DATE COMMENT 'Date when the PSEA assessment process was initiated.',
    `partner_psea_assessment_status` STRING COMMENT 'Current lifecycle status of the PSEA assessment process. [ENUM-REF-CANDIDATE: scheduled|in_progress|completed|under_review|approved|rejected|expired — 7 candidates stripped; promote to reference product]',
    `survivor_support_rating` STRING COMMENT 'Rating of the partners capacity to provide survivor-centered support and referral services.. Valid values are `compliant|partially_compliant|non_compliant|not_assessed`',
    `team_members` STRING COMMENT 'Names or identifiers of additional team members who participated in conducting the PSEA assessment.',
    `partner_psea_assessment_type` STRING COMMENT 'Type of safeguarding assessment tool or methodology used to evaluate the partners PSEA capacity.. Valid values are `psea_organizational_assessment|safeguarding_checklist|chs_self_assessment|due_diligence_review|capacity_verification|follow_up_assessment`',
    `validity_period_months` STRING COMMENT 'Number of months for which this PSEA assessment remains valid before a new assessment is required.',
    CONSTRAINT pk_partner_psea_assessment PRIMARY KEY(`partner_psea_assessment_id`)
) COMMENT 'Transactional record of safeguarding capacity assessments conducted on implementing partners prior to or during partnership engagement. Captures assessment date, assessment tool used (PSEA organizational assessment, safeguarding checklist, CHS self-assessment), overall safeguarding capacity rating, key gaps identified, capacity-building plan triggered flag, and reassessment due date. Complements partnership.capacity_assessment by focusing exclusively on safeguarding and PSEA dimensions with their own scoring methodology and follow-up obligations.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` (
    `community_awareness_session_id` BIGINT COMMENT 'Unique identifier for the community awareness session record. Primary key for this entity.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Community safeguarding awareness sessions funded by specific grants must track the award for activity reporting, cost allocation, demonstrating community engagement requirements, and reporting benefic',
    `community_id` BIGINT COMMENT 'Identifier of the beneficiary community or settlement where the awareness session was conducted.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Community awareness sessions are conducted by field offices/program units tracked as cost centers. Session costs (facilitator time, materials, venue) must be allocated to the responsible cost center f',
    `country_office_id` BIGINT COMMENT 'Identifier of the country office responsible for organizing and conducting this community awareness session.',
    `distribution_plan_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_plan. Business justification: PSEA awareness sessions are conducted during distribution planning/execution to inform beneficiaries of complaint mechanisms and safeguarding standards. Required for beneficiary awareness, complaint m',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Community sessions are often funded by specific grants with safeguarding/protection components. Tracking which fund covers session costs is required for donor reporting on safeguarding activities and ',
    `followup_community_awareness_session_id` BIGINT COMMENT 'Self-referencing FK on community_awareness_session (followup_community_awareness_session_id)',
    `intervention_id` BIGINT COMMENT 'Identifier of the program under which this community awareness session was conducted, linking the session to broader programmatic activities.',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member who facilitated or led the community awareness session.',
    `tertiary_community_created_by_staff_staff_member_id` BIGINT COMMENT 'Identifier of the staff member who created this community awareness session record in the system.',
    `volunteer_id` BIGINT COMMENT 'add column volunteer_id (BIGINT) with FK to volunteer.volunteer.volunteer_id - community awareness sessions are frequently delivered by volunteers and this link is missing',
    `attendance_sheet_document_url` STRING COMMENT 'URL or file path to the attendance sheet or participant registration document for audit and verification purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this community awareness session record was first created in the system.',
    `community_awareness_session_date` DATE COMMENT 'The date on which the community awareness session was conducted or is scheduled to be conducted.',
    `duration_minutes` STRING COMMENT 'Total duration of the community awareness session measured in minutes from start to end.',
    `end_time` TIMESTAMP COMMENT 'The timestamp when the community awareness session ended, capturing the precise completion time of the activity.',
    `feedback_received` STRING COMMENT 'Summary of feedback, questions, concerns, or suggestions received from community participants during or after the session.',
    `follow_up_actions_required` STRING COMMENT 'Description of any follow-up actions, additional sessions, or support activities identified as necessary based on session outcomes and participant feedback.',
    `follow_up_due_date` DATE COMMENT 'Target date by which identified follow-up actions should be completed or reviewed.',
    `incident_reported_flag` BOOLEAN COMMENT 'Indicates whether any safeguarding incident or concern was reported by participants during the awareness session.',
    `key_messages_delivered` STRING COMMENT 'Summary of the key safeguarding messages, topics, and information delivered during the community awareness session.',
    `language_used` STRING COMMENT 'Primary language in which the community awareness session was conducted to ensure accessibility and understanding.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this community awareness session record was last updated or modified in the system.',
    `location_country_code` STRING COMMENT 'Three-letter ISO country code indicating the country where the community awareness session was conducted.. Valid values are `^[A-Z]{3}$`',
    `location_district` STRING COMMENT 'District or sub-regional administrative area where the session was conducted.',
    `location_region` STRING COMMENT 'Administrative region or province where the community awareness session took place.',
    `location_site_name` STRING COMMENT 'Name of the specific site, community center, camp, or settlement where the awareness session was held.',
    `materials_distributed` STRING COMMENT 'Description of information, education, and communication (IEC) materials distributed to participants during the session, such as brochures, posters, or handouts.',
    `notes` STRING COMMENT 'Additional notes, observations, or contextual information recorded by the facilitator about the session dynamics, challenges, or successes.',
    `participant_satisfaction_rating` STRING COMMENT 'Overall satisfaction rating provided by participants regarding the quality and relevance of the awareness session.. Valid values are `Very Satisfied|Satisfied|Neutral|Dissatisfied|Very Dissatisfied`',
    `participants_adults_18_to_59` STRING COMMENT 'Number of adult participants aged 18 to 59 years who attended the session.',
    `participants_children_under_18` STRING COMMENT 'Number of child participants under 18 years of age who attended the session, supporting age-disaggregated reporting.',
    `participants_elderly_60_plus` STRING COMMENT 'Number of elderly participants aged 60 years and above who attended the session.',
    `participants_female` STRING COMMENT 'Number of female participants who attended the session, supporting gender-disaggregated reporting.',
    `participants_male` STRING COMMENT 'Number of male participants who attended the session, supporting gender-disaggregated reporting.',
    `participants_other_gender` STRING COMMENT 'Number of participants who identify as other gender or prefer not to disclose, ensuring inclusive data collection.',
    `participants_with_disabilities` STRING COMMENT 'Number of participants with disabilities who attended the session, supporting inclusion monitoring.',
    `reference_number` STRING COMMENT 'Externally-known unique reference number or code assigned to this community awareness session for tracking and reporting purposes.',
    `referral_made_flag` BOOLEAN COMMENT 'Indicates whether any participant was referred to support services, case management, or other assistance as a result of the session.',
    `report_document_url` STRING COMMENT 'URL or file path to the detailed session report documenting activities, outcomes, and participant engagement.',
    `start_time` TIMESTAMP COMMENT 'The timestamp when the community awareness session started, capturing the precise beginning time of the activity.',
    `community_awareness_session_status` STRING COMMENT 'Current lifecycle status of the community awareness session indicating whether it is planned, completed, or cancelled.. Valid values are `Planned|Scheduled|Completed|Cancelled|Postponed`',
    `total_participants` STRING COMMENT 'Total number of community members who attended and participated in the awareness session.',
    `translation_provided_flag` BOOLEAN COMMENT 'Indicates whether translation or interpretation services were provided during the session to accommodate multilingual participants.',
    `community_awareness_session_type` STRING COMMENT 'Type or category of safeguarding awareness session conducted with the community. Indicates the primary focus area of the sensitization activity.. Valid values are `PSEA Awareness|Child Safeguarding|Reporting Channels Orientation|Rights and Entitlements|GBV Prevention|Community Feedback Mechanism`',
    CONSTRAINT pk_community_awareness_session PRIMARY KEY(`community_awareness_session_id`)
) COMMENT 'Transactional record of community-level safeguarding awareness and PSEA sensitization sessions conducted with beneficiary communities. Captures session date, location, facilitator, session type (PSEA awareness, child safeguarding, reporting channels orientation, rights and entitlements), number of participants (disaggregated by gender and age group), key messages delivered, feedback received, and follow-up actions. Supports accountability to affected populations (AAP) and community-based prevention programming.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` (
    `psea_network_id` BIGINT COMMENT 'Primary key for psea_network',
    `country_id` BIGINT COMMENT 'add column country_id (BIGINT) with FK to field.country.country_id - psea_network only has a self-ref and one inbound from psea_network_membership; networks operate in specific countries',
    `parent_psea_network_id` BIGINT COMMENT 'Self-referencing FK on psea_network (parent_psea_network_id)',
    `accreditation_status` STRING COMMENT 'Accreditation or certification status of the PSEA network by relevant governing bodies.',
    `psea_network_code` STRING COMMENT 'Unique alphanumeric code assigned to the PSEA network for system identification and reporting.',
    `community_engagement_approach` STRING COMMENT 'Description of the PSEA networks approach to community engagement and awareness raising.',
    `coordination_level` STRING COMMENT 'Level of coordination provided by the PSEA network among member organizations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this PSEA network record was first created in the system.',
    `establishment_date` DATE COMMENT 'Date when the PSEA network was officially established or formed.',
    `focal_point_email` STRING COMMENT 'Primary email address for the PSEA network focal point.',
    `focal_point_name` STRING COMMENT 'Full name of the primary contact person or focal point for the PSEA network.',
    `focal_point_phone` STRING COMMENT 'Primary contact phone number for the PSEA network focal point.',
    `funding_source` STRING COMMENT 'Primary funding source or donor supporting the PSEA network operations.',
    `geographic_scope` STRING COMMENT 'Geographic coverage area of the PSEA network operations.',
    `investigation_capacity` STRING COMMENT 'Level of investigation capacity available within the PSEA network.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the PSEA network record is currently active in the system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this PSEA network record was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date when the PSEA networks operations, mandate, or effectiveness was last reviewed.',
    `lead_organization` STRING COMMENT 'Name of the organization serving as the lead or coordinator for the PSEA network.',
    `mandate_description` STRING COMMENT 'Detailed description of the PSEA networks mandate, objectives, and scope of work.',
    `meeting_frequency` STRING COMMENT 'Regular frequency at which the PSEA network convenes meetings.',
    `member_count` STRING COMMENT 'Total number of member organizations participating in the PSEA network.',
    `psea_network_name` STRING COMMENT 'Official name of the PSEA network or coalition.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of the PSEA networks operations and effectiveness.',
    `notes` STRING COMMENT 'Additional notes, comments, or contextual information about the PSEA network.',
    `region` STRING COMMENT 'Geographic region or administrative area where the network operates.',
    `reporting_mechanism_available` BOOLEAN COMMENT 'Indicates whether the PSEA network has an established reporting mechanism for SEA allegations.',
    `reporting_mechanism_type` STRING COMMENT 'Type of reporting mechanism used by the PSEA network for receiving complaints.',
    `psea_network_status` STRING COMMENT 'Current operational status of the PSEA network.',
    `survivor_assistance_available` BOOLEAN COMMENT 'Indicates whether the PSEA network provides or coordinates survivor assistance services.',
    `terms_of_reference_url` STRING COMMENT 'Web link to the official terms of reference document for the PSEA network.',
    `training_program_available` BOOLEAN COMMENT 'Indicates whether the PSEA network offers training programs on safeguarding and PSEA.',
    `psea_network_type` STRING COMMENT 'Classification of the PSEA network based on its scope and organizational structure.',
    `website_url` STRING COMMENT 'Official website address for the PSEA network.',
    CONSTRAINT pk_psea_network PRIMARY KEY(`psea_network_id`)
) COMMENT 'Master reference table for psea_network. Referenced by network_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ADD CONSTRAINT `fk_safeguarding_psea_policy_primary_superseded_policy_psea_policy_id` FOREIGN KEY (`primary_superseded_policy_psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ADD CONSTRAINT `fk_safeguarding_safeguarding_incident_focal_point_id` FOREIGN KEY (`focal_point_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`focal_point`(`focal_point_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ADD CONSTRAINT `fk_safeguarding_safeguarding_incident_parent_safeguarding_incident_id` FOREIGN KEY (`parent_safeguarding_incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`(`safeguarding_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ADD CONSTRAINT `fk_safeguarding_investigation_parent_investigation_id` FOREIGN KEY (`parent_investigation_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`investigation`(`investigation_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ADD CONSTRAINT `fk_safeguarding_investigation_safeguarding_incident_id` FOREIGN KEY (`safeguarding_incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`(`safeguarding_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ADD CONSTRAINT `fk_safeguarding_investigation_action_alleged_perpetrator_id` FOREIGN KEY (`alleged_perpetrator_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator`(`alleged_perpetrator_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ADD CONSTRAINT `fk_safeguarding_investigation_action_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`investigation`(`investigation_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ADD CONSTRAINT `fk_safeguarding_investigation_action_predecessor_investigation_action_id` FOREIGN KEY (`predecessor_investigation_action_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`investigation_action`(`investigation_action_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ADD CONSTRAINT `fk_safeguarding_investigation_action_survivor_record_id` FOREIGN KEY (`survivor_record_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`survivor_record`(`survivor_record_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ADD CONSTRAINT `fk_safeguarding_survivor_record_duplicate_of_survivor_record_id` FOREIGN KEY (`duplicate_of_survivor_record_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`survivor_record`(`survivor_record_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ADD CONSTRAINT `fk_safeguarding_survivor_record_safeguarding_incident_id` FOREIGN KEY (`safeguarding_incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`(`safeguarding_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ADD CONSTRAINT `fk_safeguarding_survivor_support_plan_revised_survivor_support_plan_id` FOREIGN KEY (`revised_survivor_support_plan_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan`(`survivor_support_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ADD CONSTRAINT `fk_safeguarding_survivor_support_plan_safeguarding_incident_id` FOREIGN KEY (`safeguarding_incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`(`safeguarding_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ADD CONSTRAINT `fk_safeguarding_survivor_support_plan_survivor_record_id` FOREIGN KEY (`survivor_record_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`survivor_record`(`survivor_record_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ADD CONSTRAINT `fk_safeguarding_support_service_referral_onward_support_service_referral_id` FOREIGN KEY (`onward_support_service_referral_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`support_service_referral`(`support_service_referral_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ADD CONSTRAINT `fk_safeguarding_support_service_referral_survivor_record_id` FOREIGN KEY (`survivor_record_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`survivor_record`(`survivor_record_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ADD CONSTRAINT `fk_safeguarding_alleged_perpetrator_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`investigation`(`investigation_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ADD CONSTRAINT `fk_safeguarding_alleged_perpetrator_safeguarding_incident_id` FOREIGN KEY (`safeguarding_incident_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident`(`safeguarding_incident_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ADD CONSTRAINT `fk_safeguarding_alleged_perpetrator_same_as_alleged_perpetrator_id` FOREIGN KEY (`same_as_alleged_perpetrator_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator`(`alleged_perpetrator_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ADD CONSTRAINT `fk_safeguarding_disciplinary_outcome_alleged_perpetrator_id` FOREIGN KEY (`alleged_perpetrator_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator`(`alleged_perpetrator_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ADD CONSTRAINT `fk_safeguarding_disciplinary_outcome_appealed_disciplinary_outcome_id` FOREIGN KEY (`appealed_disciplinary_outcome_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome`(`disciplinary_outcome_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ADD CONSTRAINT `fk_safeguarding_disciplinary_outcome_investigation_action_id` FOREIGN KEY (`investigation_action_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`investigation_action`(`investigation_action_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ADD CONSTRAINT `fk_safeguarding_disciplinary_outcome_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`investigation`(`investigation_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ADD CONSTRAINT `fk_safeguarding_training_program_primary_superseded_program_training_program_id` FOREIGN KEY (`primary_superseded_program_training_program_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`training_program`(`training_program_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ADD CONSTRAINT `fk_safeguarding_safeguarding_training_completion_refresher_of_safeguarding_training_completion_id` FOREIGN KEY (`refresher_of_safeguarding_training_completion_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion`(`safeguarding_training_completion_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ADD CONSTRAINT `fk_safeguarding_safeguarding_training_completion_training_program_id` FOREIGN KEY (`training_program_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`training_program`(`training_program_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ADD CONSTRAINT `fk_safeguarding_safeguarding_policy_acknowledgment_primary_superseded_acknowledgment_safeguarding_policy_acknowledgment_id` FOREIGN KEY (`primary_superseded_acknowledgment_safeguarding_policy_acknowledgment_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment`(`safeguarding_policy_acknowledgment_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ADD CONSTRAINT `fk_safeguarding_safeguarding_policy_acknowledgment_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ADD CONSTRAINT `fk_safeguarding_risk_assessment_previous_risk_assessment_id` FOREIGN KEY (`previous_risk_assessment_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ADD CONSTRAINT `fk_safeguarding_reporting_channel_escalation_reporting_channel_id` FOREIGN KEY (`escalation_reporting_channel_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`reporting_channel`(`reporting_channel_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ADD CONSTRAINT `fk_safeguarding_focal_point_primary_successor_focal_point_id` FOREIGN KEY (`primary_successor_focal_point_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`focal_point`(`focal_point_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ADD CONSTRAINT `fk_safeguarding_psea_network_membership_predecessor_psea_network_membership_id` FOREIGN KEY (`predecessor_psea_network_membership_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_network_membership`(`psea_network_membership_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ADD CONSTRAINT `fk_safeguarding_psea_network_membership_psea_network_id` FOREIGN KEY (`psea_network_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_network`(`psea_network_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ADD CONSTRAINT `fk_safeguarding_misconduct_disclosure_alleged_perpetrator_id` FOREIGN KEY (`alleged_perpetrator_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator`(`alleged_perpetrator_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ADD CONSTRAINT `fk_safeguarding_misconduct_disclosure_prior_misconduct_disclosure_id` FOREIGN KEY (`prior_misconduct_disclosure_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure`(`misconduct_disclosure_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ADD CONSTRAINT `fk_safeguarding_audit_previous_audit_id` FOREIGN KEY (`previous_audit_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`audit`(`audit_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ADD CONSTRAINT `fk_safeguarding_audit_recommendation_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`audit`(`audit_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ADD CONSTRAINT `fk_safeguarding_audit_recommendation_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ADD CONSTRAINT `fk_safeguarding_audit_recommendation_superseded_audit_recommendation_id` FOREIGN KEY (`superseded_audit_recommendation_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`audit_recommendation`(`audit_recommendation_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ADD CONSTRAINT `fk_safeguarding_donor_safeguarding_requirement_psea_policy_id` FOREIGN KEY (`psea_policy_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_policy`(`psea_policy_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ADD CONSTRAINT `fk_safeguarding_donor_safeguarding_requirement_superseded_donor_safeguarding_requirement_id` FOREIGN KEY (`superseded_donor_safeguarding_requirement_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement`(`donor_safeguarding_requirement_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ADD CONSTRAINT `fk_safeguarding_partner_psea_assessment_previous_partner_psea_assessment_id` FOREIGN KEY (`previous_partner_psea_assessment_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment`(`partner_psea_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ADD CONSTRAINT `fk_safeguarding_community_awareness_session_followup_community_awareness_session_id` FOREIGN KEY (`followup_community_awareness_session_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`community_awareness_session`(`community_awareness_session_id`);
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ADD CONSTRAINT `fk_safeguarding_psea_network_parent_psea_network_id` FOREIGN KEY (`parent_psea_network_id`) REFERENCES `vibe_ngo_v1`.`safeguarding`.`psea_network`(`psea_network_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`safeguarding` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_ngo_v1`.`safeguarding` SET TAGS ('dbx_domain' = 'safeguarding');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` SET TAGS ('dbx_subdomain' = 'policy_compliance');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `psea_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Protection from Sexual Exploitation and Abuse (PSEA) Policy ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `primary_superseded_policy_psea_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Policy ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `acknowledgment_audience` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Audience');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `acknowledgment_deadline_days` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Deadline in Days');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `psea_policy_category` SET TAGS ('dbx_business_glossary_term' = 'Policy Category');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `psea_policy_category` SET TAGS ('dbx_value_regex' = 'Prevention|Response|Investigation|Accountability|Training|Reporting');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `confidentiality_clause` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `psea_policy_description` SET TAGS ('dbx_business_glossary_term' = 'Policy Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `document_language` SET TAGS ('dbx_business_glossary_term' = 'Document Language');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `document_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `document_language` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `legal_framework_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Framework Reference');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `mandatory_acknowledgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Acknowledgment Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4}-[0-9]{3}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `reporting_mechanism_description` SET TAGS ('dbx_business_glossary_term' = 'Reporting Mechanism Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle in Months');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `sanctions_description` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Policy Scope');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `scope` SET TAGS ('dbx_value_regex' = 'Global|Regional|Country|Program|Project');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `psea_policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `psea_policy_status` SET TAGS ('dbx_value_regex' = 'Draft|Under Review|Approved|Active|Superseded|Archived');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Policy Title');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `translation_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Translation Available Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `psea_policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_policy` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` SET TAGS ('dbx_subdomain' = 'incident_investigation');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `safeguarding_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Safeguarding Incident ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `focal_point_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Focal Point Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `parent_safeguarding_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Safeguarding Incident Id');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `parent_safeguarding_incident_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `partnership_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `alleged_perpetrator_name` SET TAGS ('dbx_business_glossary_term' = 'Alleged Perpetrator Name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `alleged_perpetrator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `alleged_perpetrator_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `alleged_perpetrator_type` SET TAGS ('dbx_business_glossary_term' = 'Alleged Perpetrator Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `anonymization_flag` SET TAGS ('dbx_business_glossary_term' = 'Anonymization Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `safeguarding_incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Occurrence Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `safeguarding_incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `safeguarding_incident_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `disciplinary_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Taken');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `disciplinary_action_taken` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `donor_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Notification Required Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `donor_notified_date` SET TAGS ('dbx_business_glossary_term' = 'Donor Notified Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `investigation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Investigation Outcome');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `investigation_outcome` SET TAGS ('dbx_value_regex' = 'substantiated|unsubstantiated|inconclusive|withdrawn|pending');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `investigation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Investigation Required Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Investigator Name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `investigator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `investigator_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `law_enforcement_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Notified Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `location_country` SET TAGS ('dbx_business_glossary_term' = 'Incident Location Country Code');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `location_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `location_district` SET TAGS ('dbx_business_glossary_term' = 'Incident Location District');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `location_region` SET TAGS ('dbx_business_glossary_term' = 'Incident Location Region');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `location_site` SET TAGS ('dbx_business_glossary_term' = 'Incident Location Site');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Incident Reference Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `number` SET TAGS ('dbx_value_regex' = '^SGI-[0-9]{8}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `referral_made_flag` SET TAGS ('dbx_business_glossary_term' = 'External Referral Made Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Reported Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `reporter_contact` SET TAGS ('dbx_business_glossary_term' = 'Reporter Contact Information');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `reporter_contact` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `reporter_contact` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `reporter_name` SET TAGS ('dbx_business_glossary_term' = 'Reporter Full Name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `reporter_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `reporter_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `reporter_type` SET TAGS ('dbx_business_glossary_term' = 'Reporter Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `reporter_type` SET TAGS ('dbx_value_regex' = 'beneficiary|staff|volunteer|partner|community_member|anonymous');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `reporting_channel` SET TAGS ('dbx_business_glossary_term' = 'Reporting Channel');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `reporting_channel` SET TAGS ('dbx_value_regex' = 'hotline|direct_report|community_feedback|email|anonymous_box|third_party');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Incident Severity Level');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `safeguarding_incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Investigation Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `safeguarding_incident_status` SET TAGS ('dbx_value_regex' = 'reported|under_review|investigation|resolved|closed|dismissed');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Incident Subtype');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `survivor_age_group` SET TAGS ('dbx_business_glossary_term' = 'Survivor Age Group');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `survivor_age_group` SET TAGS ('dbx_value_regex' = 'child_0_5|child_6_12|child_13_17|adult_18_59|elderly_60_plus|unknown');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `survivor_age_group` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `survivor_age_group` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `survivor_gender` SET TAGS ('dbx_business_glossary_term' = 'Survivor Gender');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `survivor_gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_say|unknown');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `survivor_gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `survivor_gender` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `survivor_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'Survivor Involved Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `survivor_support_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Survivor Support Provided Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `time` SET TAGS ('dbx_business_glossary_term' = 'Incident Occurrence Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `safeguarding_incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type Classification');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_incident` ALTER COLUMN `safeguarding_incident_type` SET TAGS ('dbx_value_regex' = 'SEA|child_abuse|harassment|fraud|staff_misconduct|other');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` SET TAGS ('dbx_subdomain' = 'incident_investigation');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Constituent Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `parent_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Investigation Id');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `parent_investigation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `user_account_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `safeguarding_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Investigator Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `investigation_category` SET TAGS ('dbx_business_glossary_term' = 'Investigation Category');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `investigation_category` SET TAGS ('dbx_value_regex' = 'psea|child_safeguarding|staff_misconduct|gbv|fraud|harassment');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Closure Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Investigation Cost in United States Dollars (USD)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `disciplinary_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Taken');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `disciplinary_action_taken` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `evidence_items_collected_count` SET TAGS ('dbx_business_glossary_term' = 'Evidence Items Collected Count');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `external_reporting_date` SET TAGS ('dbx_business_glossary_term' = 'External Reporting Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `external_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'External Reporting Required Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `final_determination` SET TAGS ('dbx_business_glossary_term' = 'Final Determination');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `final_determination` SET TAGS ('dbx_value_regex' = 'substantiated|unsubstantiated|inconclusive|partially_substantiated');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `findings_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `follow_up_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Actions Required');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `interviews_conducted_count` SET TAGS ('dbx_business_glossary_term' = 'Interviews Conducted Count');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `law_enforcement_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `law_enforcement_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Investigation Methodology');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `policy_violations_identified` SET TAGS ('dbx_business_glossary_term' = 'Policy Violations Identified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `recommended_actions` SET TAGS ('dbx_business_glossary_term' = 'Recommended Actions');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `recommended_actions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Investigation Reference Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^INV-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `report_document_url` SET TAGS ('dbx_business_glossary_term' = 'Investigation Report Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `report_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Investigation Scope');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'pending_assignment|active|suspended|completed|closed');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `survivor_support_provided` SET TAGS ('dbx_business_glossary_term' = 'Survivor Support Provided');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `survivor_support_provided` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `team_members` SET TAGS ('dbx_business_glossary_term' = 'Investigation Team Members');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `terms_of_reference` SET TAGS ('dbx_business_glossary_term' = 'Terms of Reference (ToR)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `investigation_type` SET TAGS ('dbx_business_glossary_term' = 'Investigation Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation` ALTER COLUMN `investigation_type` SET TAGS ('dbx_value_regex' = 'internal|external|joint_un_ocha|joint_partner|independent');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` SET TAGS ('dbx_subdomain' = 'incident_investigation');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `investigation_action_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Action Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `alleged_perpetrator_id` SET TAGS ('dbx_business_glossary_term' = 'Alleged Perpetrator Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `predecessor_investigation_action_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Investigation Action Id');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `predecessor_investigation_action_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Staff Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `user_account_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `survivor_record_id` SET TAGS ('dbx_business_glossary_term' = 'Survivor Record Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Action Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Action Cost Currency Code');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `investigation_action_date` SET TAGS ('dbx_business_glossary_term' = 'Action Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `investigation_action_description` SET TAGS ('dbx_business_glossary_term' = 'Action Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration in Minutes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Action End Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `evidence_collected_flag` SET TAGS ('dbx_business_glossary_term' = 'Evidence Collected Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `evidence_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Evidence Reference Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `evidence_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `external_authority_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'External Authority Notified Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `interim_measure_applied` SET TAGS ('dbx_business_glossary_term' = 'Interim Measure Applied');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `interim_measure_applied` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Action Location');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `next_action_description` SET TAGS ('dbx_business_glossary_term' = 'Next Action Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `next_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Action Due Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Action Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `outcome_notes` SET TAGS ('dbx_business_glossary_term' = 'Outcome Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `outcome_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `participant_count` SET TAGS ('dbx_business_glossary_term' = 'Participant Count');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `referral_made_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Made Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `referral_organization` SET TAGS ('dbx_business_glossary_term' = 'Referral Organization');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|minimal');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Action Start Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `investigation_action_status` SET TAGS ('dbx_business_glossary_term' = 'Action Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `investigation_action_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|deferred|pending_review');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `survivor_support_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Survivor Support Provided Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `investigation_action_type` SET TAGS ('dbx_business_glossary_term' = 'Action Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`investigation_action` ALTER COLUMN `witness_statement_flag` SET TAGS ('dbx_business_glossary_term' = 'Witness Statement Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` SET TAGS ('dbx_subdomain' = 'survivor_support');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `survivor_record_id` SET TAGS ('dbx_business_glossary_term' = 'Survivor Record ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Registrant Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `duplicate_of_survivor_record_id` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Of Survivor Record Id');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `duplicate_of_survivor_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Support Focal Point Staff ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `safeguarding_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Safeguarding Incident ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `tertiary_survivor_last_modified_by_staff_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By Staff ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `tertiary_survivor_last_modified_by_staff_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `tertiary_survivor_last_modified_by_staff_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `access_restriction_level` SET TAGS ('dbx_business_glossary_term' = 'Access Restriction Level');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `access_restriction_level` SET TAGS ('dbx_value_regex' = 'highly_restricted|restricted|confidential');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `age_group` SET TAGS ('dbx_business_glossary_term' = 'Survivor Age Group');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `age_group` SET TAGS ('dbx_value_regex' = 'child_0_5|child_6_11|child_12_17|adult_18_24|adult_25_59|elderly_60_plus');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `age_group` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `age_group` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `case_closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Case Closure Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `case_closure_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `case_closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Case Closure Reason');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `case_closure_reason` SET TAGS ('dbx_value_regex' = 'support_completed|survivor_request|lost_contact|transferred_to_partner|other');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `confidentiality_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Breach Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Recorded Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Information Sharing Consent Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'full_consent|partial_consent|no_consent|consent_withdrawn|minor_guardian_consent');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `data_retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `economic_support_provided` SET TAGS ('dbx_business_glossary_term' = 'Economic Support Provided Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `external_referral_made` SET TAGS ('dbx_business_glossary_term' = 'External Referral Made Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Survivor Gender');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'female|male|non_binary|prefer_not_to_say|other');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `gender` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `legal_support_provided` SET TAGS ('dbx_business_glossary_term' = 'Legal Support Provided Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `medical_support_provided` SET TAGS ('dbx_business_glossary_term' = 'Medical Support Provided Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `medical_support_provided` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `medical_support_provided` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `medical_support_provided` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'phone|email|in_person|community_focal_point|no_contact|other');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `psychosocial_support_provided` SET TAGS ('dbx_business_glossary_term' = 'Psychosocial Support (PSS) Provided Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `referral_source` SET TAGS ('dbx_value_regex' = 'self_reported|community_member|staff_member|partner_organization|hotline|other');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `safe_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Safe Contact Email Address');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `safe_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `safe_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `safe_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `safe_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Safe Contact Phone Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `safe_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `safe_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `safety_plan_in_place` SET TAGS ('dbx_business_glossary_term' = 'Safety Plan In Place Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `support_end_date` SET TAGS ('dbx_business_glossary_term' = 'Support Services End Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `support_start_date` SET TAGS ('dbx_business_glossary_term' = 'Support Services Start Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `support_status` SET TAGS ('dbx_business_glossary_term' = 'Survivor Support Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `support_status` SET TAGS ('dbx_value_regex' = 'initial_contact|assessment_in_progress|active_support|support_completed|case_closed|declined_support');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `survivor_code` SET TAGS ('dbx_business_glossary_term' = 'Survivor Anonymized Code');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `survivor_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `survivor_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `survivor_type` SET TAGS ('dbx_business_glossary_term' = 'Survivor Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `survivor_type` SET TAGS ('dbx_value_regex' = 'beneficiary|staff|volunteer|community_member|child|partner_staff');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `vulnerability_notes` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_record` ALTER COLUMN `vulnerability_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` SET TAGS ('dbx_subdomain' = 'survivor_support');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `survivor_support_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Survivor Support Plan ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Service Provider Organization ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `user_account_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `revised_survivor_support_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Revised Survivor Support Plan Id');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `revised_survivor_support_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `safeguarding_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Safeguarding Incident ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Case Manager Staff ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `survivor_record_id` SET TAGS ('dbx_business_glossary_term' = 'Survivor Beneficiary ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `survivor_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `survivor_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `closure_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Plan Closure Reason');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `closure_reason` SET TAGS ('dbx_value_regex' = 'goals_achieved|survivor_request|lost_contact|transferred|other');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'standard|high|maximum');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `education_service_description` SET TAGS ('dbx_business_glossary_term' = 'Education Service Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `education_service_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `education_support_required` SET TAGS ('dbx_business_glossary_term' = 'Education Support Required');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan End Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `goals` SET TAGS ('dbx_business_glossary_term' = 'Support Plan Goals');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `goals` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `housing_service_description` SET TAGS ('dbx_business_glossary_term' = 'Housing Service Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `housing_service_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `legal_aid_required` SET TAGS ('dbx_business_glossary_term' = 'Legal Aid Required');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `legal_service_description` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `legal_service_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `livelihood_service_description` SET TAGS ('dbx_business_glossary_term' = 'Livelihood Service Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `livelihood_service_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `livelihood_support_required` SET TAGS ('dbx_business_glossary_term' = 'Livelihood Support Required');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `medical_referral_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Referral Required');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `medical_referral_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `medical_referral_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `medical_referral_required` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `medical_service_description` SET TAGS ('dbx_business_glossary_term' = 'Medical Service Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `medical_service_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `medical_service_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `needs_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Needs Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `progress_notes` SET TAGS ('dbx_business_glossary_term' = 'Progress Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `progress_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `pss_service_description` SET TAGS ('dbx_business_glossary_term' = 'Psychosocial Support (PSS) Service Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `pss_service_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `psychosocial_support_required` SET TAGS ('dbx_business_glossary_term' = 'Psychosocial Support (PSS) Required');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Support Plan Reference Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^SSP-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `referral_pathway_used` SET TAGS ('dbx_business_glossary_term' = 'Referral Pathway Used');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Plan Review Frequency');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly|as_needed');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `safe_housing_required` SET TAGS ('dbx_business_glossary_term' = 'Safe Housing Required');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `safety_plan_included` SET TAGS ('dbx_business_glossary_term' = 'Safety Plan Included');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Start Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `survivor_support_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Support Plan Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `survivor_support_plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|under_review|on_hold|completed|closed');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `survivor_centered_approach` SET TAGS ('dbx_business_glossary_term' = 'Survivor-Centered Approach Applied');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `survivor_consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Survivor Informed Consent Obtained');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `survivor_support_plan_type` SET TAGS ('dbx_business_glossary_term' = 'Support Plan Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`survivor_support_plan` ALTER COLUMN `survivor_support_plan_type` SET TAGS ('dbx_value_regex' = 'comprehensive|emergency|short_term|long_term|specialized');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` SET TAGS ('dbx_subdomain' = 'survivor_support');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `support_service_referral_id` SET TAGS ('dbx_business_glossary_term' = 'Support Service Referral ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `case_record_id` SET TAGS ('dbx_business_glossary_term' = 'Case Record ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `onward_support_service_referral_id` SET TAGS ('dbx_business_glossary_term' = 'Onward Support Service Referral Id');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `onward_support_service_referral_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Registrant ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `registrant_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `registrant_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Staff ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `survivor_record_id` SET TAGS ('dbx_business_glossary_term' = 'Survivor Record Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `actual_service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Service Start Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Referral Channel');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'in_person|phone|email|secure_platform|interagency_system');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'standard|high|maximum');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'verbal|written|digital|guardian');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `support_service_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `decline_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `expected_service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Service Start Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `follow_up_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Completed Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `follow_up_outcome` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Outcome');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `follow_up_outcome` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `information_sharing_consent` SET TAGS ('dbx_business_glossary_term' = 'Information Sharing Consent');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `information_sharing_consent` SET TAGS ('dbx_value_regex' = 'full|limited|none');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `interagency_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Interagency Referral Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `interagency_referral_flag` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `location_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Referral Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `number` SET TAGS ('dbx_value_regex' = '^REF-[0-9]{8}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `pathway_name` SET TAGS ('dbx_business_glossary_term' = 'Referral Pathway Name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `pathway_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Referral Reason');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `receiving_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Organization Name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `receiving_organization_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `receiving_organization_type` SET TAGS ('dbx_business_glossary_term' = 'Receiving Organization Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `receiving_organization_type` SET TAGS ('dbx_value_regex' = 'internal|partner_ngo|government|un_agency|private_provider|community_based');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `referring_department` SET TAGS ('dbx_business_glossary_term' = 'Referring Department');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `service_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Service Completion Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `service_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `service_provider_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Service Provider Contact Name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `service_provider_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `service_provider_contact_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `service_provider_email` SET TAGS ('dbx_business_glossary_term' = 'Service Provider Email Address');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `service_provider_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `service_provider_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `service_provider_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `service_provider_phone` SET TAGS ('dbx_business_glossary_term' = 'Service Provider Phone Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `service_provider_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `service_provider_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'medical|psychosocial|legal|shelter|livelihood|education');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `support_service_referral_status` SET TAGS ('dbx_business_glossary_term' = 'Referral Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `support_service_referral_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|in_progress|completed|declined|cancelled');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `urgency` SET TAGS ('dbx_business_glossary_term' = 'Referral Urgency');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `urgency` SET TAGS ('dbx_value_regex' = 'routine|urgent|emergency');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`support_service_referral` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` SET TAGS ('dbx_subdomain' = 'incident_investigation');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `alleged_perpetrator_id` SET TAGS ('dbx_business_glossary_term' = 'Alleged Perpetrator ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Constituent Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Staff ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `safeguarding_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `same_as_alleged_perpetrator_id` SET TAGS ('dbx_business_glossary_term' = 'Same As Alleged Perpetrator Id');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `same_as_alleged_perpetrator_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `access_restriction_level` SET TAGS ('dbx_business_glossary_term' = 'Access Restriction Level');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `access_restriction_level` SET TAGS ('dbx_value_regex' = 'none|restricted|confidential');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `allegation_date` SET TAGS ('dbx_business_glossary_term' = 'Allegation Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `allegation_severity` SET TAGS ('dbx_business_glossary_term' = 'Allegation Severity');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `allegation_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `allegation_type` SET TAGS ('dbx_business_glossary_term' = 'Allegation Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `case_notes` SET TAGS ('dbx_business_glossary_term' = 'Case Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `case_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `case_outcome` SET TAGS ('dbx_business_glossary_term' = 'Case Outcome');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `alleged_perpetrator_code` SET TAGS ('dbx_business_glossary_term' = 'Perpetrator Code');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `alleged_perpetrator_code` SET TAGS ('dbx_value_regex' = '^AP-[0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `alleged_perpetrator_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `country_office_at_incident` SET TAGS ('dbx_business_glossary_term' = 'Country Office at Incident');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `country_office_at_incident` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `criminal_referral_authority` SET TAGS ('dbx_business_glossary_term' = 'Criminal Referral Authority');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `criminal_referral_authority` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `criminal_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Criminal Referral Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `criminal_referral_made` SET TAGS ('dbx_business_glossary_term' = 'Criminal Referral Made');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `disciplinary_action_date` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `employment_status_at_incident` SET TAGS ('dbx_business_glossary_term' = 'Employment Status at Incident');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `employment_status_at_incident` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|contract_ended|never_employed|unknown');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `interim_measures_applied` SET TAGS ('dbx_business_glossary_term' = 'Interim Measures Applied');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `interim_measures_applied` SET TAGS ('dbx_value_regex' = 'none|suspension|restricted_duties|administrative_leave|reassignment|access_revoked');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `investigation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Investigation Outcome');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `investigation_outcome` SET TAGS ('dbx_value_regex' = 'substantiated|unsubstantiated|inconclusive|dismissed|pending');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'pending|under_investigation|investigation_complete|closed|dismissed');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `misconduct_database_report_date` SET TAGS ('dbx_business_glossary_term' = 'Misconduct Database Report Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `misconduct_database_reported` SET TAGS ('dbx_business_glossary_term' = 'Misconduct Database Reported');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `rehire_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligibility');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `rehire_eligibility` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|conditional|under_review');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `relationship_to_organization` SET TAGS ('dbx_business_glossary_term' = 'Relationship to Organization');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `relationship_to_organization` SET TAGS ('dbx_value_regex' = 'staff|volunteer|partner_staff|contractor|community_member|beneficiary');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`alleged_perpetrator` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` SET TAGS ('dbx_subdomain' = 'incident_investigation');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `disciplinary_outcome_id` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Outcome ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `alleged_perpetrator_id` SET TAGS ('dbx_business_glossary_term' = 'Alleged Perpetrator Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `appealed_disciplinary_outcome_id` SET TAGS ('dbx_business_glossary_term' = 'Appealed Disciplinary Outcome Id');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `appealed_disciplinary_outcome_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Constituent Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `user_account_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `separation_event_id` SET TAGS ('dbx_business_glossary_term' = 'Separation Event Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `aggravating_factors` SET TAGS ('dbx_business_glossary_term' = 'Aggravating Factors');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'upheld|denied|partially_upheld|withdrawn|pending|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `criminal_charges_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Criminal Charges Filed Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `disciplinary_outcome_date` SET TAGS ('dbx_business_glossary_term' = 'Outcome Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `decision_authority` SET TAGS ('dbx_business_glossary_term' = 'Decision Authority');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Outcome Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `external_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'External Reporting Required Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `law_enforcement_agency` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Agency');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `law_enforcement_agency` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `law_enforcement_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `law_enforcement_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `mds_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Misconduct Disclosure Scheme (MDS) Reference Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `mds_report_date` SET TAGS ('dbx_business_glossary_term' = 'Misconduct Disclosure Scheme (MDS) Report Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `mds_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Misconduct Disclosure Scheme (MDS) Reported Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `mitigating_factors` SET TAGS ('dbx_business_glossary_term' = 'Mitigating Factors');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `policy_violations` SET TAGS ('dbx_business_glossary_term' = 'Policy Violations');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `rationale` SET TAGS ('dbx_business_glossary_term' = 'Outcome Rationale');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `reference_check_flag` SET TAGS ('dbx_business_glossary_term' = 'Reference Check Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Outcome Reference Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `rehabilitation_plan_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Plan Required Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `restitution_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Restitution Amount (United States Dollar)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `restitution_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Restitution Required Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'minor|moderate|serious|severe|critical');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `disciplinary_outcome_status` SET TAGS ('dbx_business_glossary_term' = 'Outcome Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `disciplinary_outcome_status` SET TAGS ('dbx_value_regex' = 'pending|finalized|under_appeal|appeal_upheld|appeal_denied|overturned');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `training_completion_deadline` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Deadline');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`disciplinary_outcome` ALTER COLUMN `disciplinary_outcome_type` SET TAGS ('dbx_business_glossary_term' = 'Outcome Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` SET TAGS ('dbx_subdomain' = 'training_awareness');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `training_program_id` SET TAGS ('dbx_business_glossary_term' = 'Training Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `system_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Platform System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `primary_superseded_program_training_program_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Training Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `user_account_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Required For Job Profile Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Program Owner Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `accrediting_body` SET TAGS ('dbx_business_glossary_term' = 'Accrediting Body');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `assessment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Assessment Required Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `available_languages` SET TAGS ('dbx_business_glossary_term' = 'Available Languages');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `available_languages` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `certification_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `training_program_code` SET TAGS ('dbx_business_glossary_term' = 'Training Program Code');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `training_program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `content_url` SET TAGS ('dbx_business_glossary_term' = 'Training Content Uniform Resource Locator (URL)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `cost_per_participant_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Participant in United States Dollars (USD)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `delivery_modality` SET TAGS ('dbx_business_glossary_term' = 'Delivery Modality');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `delivery_modality` SET TAGS ('dbx_value_regex' = 'in_person|e_learning|blended|virtual_instructor_led|self_paced');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `training_program_description` SET TAGS ('dbx_business_glossary_term' = 'Training Program Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Duration in Hours');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `enrollment_capacity` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Capacity');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `facilitator_qualifications` SET TAGS ('dbx_business_glossary_term' = 'Facilitator Qualifications');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `facilitator_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Facilitator Required Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Training Language Code');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `learning_objectives` SET TAGS ('dbx_business_glossary_term' = 'Learning Objectives');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Training Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `materials_description` SET TAGS ('dbx_business_glossary_term' = 'Training Materials Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `materials_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Materials Provided Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Training Program Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `passing_score_percentage` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Percentage');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `passing_score_percentage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `prerequisites` SET TAGS ('dbx_business_glossary_term' = 'Training Prerequisites');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle in Months');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `training_program_status` SET TAGS ('dbx_business_glossary_term' = 'Training Program Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `training_program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|retired|draft');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Training Program Title');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `training_type` SET TAGS ('dbx_value_regex' = 'psea_awareness|child_safeguarding|code_of_conduct|bystander_intervention|survivor_centered_approach|investigation_skills');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `translation_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Translation Available Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `validity_period_months` SET TAGS ('dbx_business_glossary_term' = 'Validity Period in Months');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Training Program Version Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`training_program` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` SET TAGS ('dbx_subdomain' = 'training_awareness');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `safeguarding_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `learning_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `user_account_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `refresher_of_safeguarding_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Refresher Of Safeguarding Training Completion Id');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `refresher_of_safeguarding_training_completion_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Participant ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `training_program_id` SET TAGS ('dbx_business_glossary_term' = 'Training Program Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `attempts_count` SET TAGS ('dbx_business_glossary_term' = 'Attempts Count');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `certificate_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Completion Channel');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'lms_online|in_person_classroom|virtual_instructor_led|self_paced_online|blended|workshop');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `compliance_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Training Cost United States Dollars (USD)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `safeguarding_training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `external_provider_name` SET TAGS ('dbx_business_glossary_term' = 'External Provider Name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `external_provider_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `feedback_comments` SET TAGS ('dbx_business_glossary_term' = 'Feedback Comments');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `feedback_rating` SET TAGS ('dbx_business_glossary_term' = 'Feedback Rating');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `instructor_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Training Language');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `language` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `lms_course_code` SET TAGS ('dbx_business_glossary_term' = 'Learning Management System (LMS) Course ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `mandatory_training_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Training Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `next_refresher_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Refresher Due Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Completion Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `overdue_flag` SET TAGS ('dbx_business_glossary_term' = 'Overdue Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `participant_type` SET TAGS ('dbx_business_glossary_term' = 'Participant Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `participant_type` SET TAGS ('dbx_value_regex' = 'staff|volunteer|partner_staff|consultant|board_member|intern');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass or Fail Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_assessed|waived');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Completion Reference Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `refresher_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Refresher Required Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `safeguarding_training_completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `safeguarding_training_completion_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|failed|expired|waived');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `training_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Duration Hours');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `waiver_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approval Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `waiver_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_training_completion` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` SET TAGS ('dbx_subdomain' = 'policy_compliance');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `safeguarding_policy_acknowledgment_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Acknowledgment ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `learning_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `user_account_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `primary_superseded_acknowledgment_safeguarding_policy_acknowledgment_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Acknowledgment ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `psea_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Acknowledger ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `safeguarding_acknowledging_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Acknowledger Employee ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `safeguarding_acknowledging_staff_member_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `safeguarding_acknowledging_staff_member_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `acknowledging_staff_member_id` SET TAGS ('dbx_renamed_from' = 'staff_member_id');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `acknowledger_email` SET TAGS ('dbx_business_glossary_term' = 'Acknowledger Email Address');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `acknowledger_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `acknowledger_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `acknowledger_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `acknowledger_name` SET TAGS ('dbx_business_glossary_term' = 'Acknowledger Full Name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `acknowledger_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `acknowledger_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `acknowledger_type` SET TAGS ('dbx_business_glossary_term' = 'Acknowledger Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `acknowledger_type` SET TAGS ('dbx_value_regex' = 'staff|volunteer|partner_staff|contractor|consultant|board_member');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `consent_to_process_data_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent to Process Data Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `safeguarding_policy_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `device_identifier` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `device_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `device_identifier` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `digital_signature` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `digital_signature` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `digital_signature` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `document_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Language');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `language` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `lms_confirmation_code` SET TAGS ('dbx_business_glossary_term' = 'Learning Management System (LMS) Confirmation ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Location');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Method');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'digital_signature|wet_signature|lms_confirmation|email_confirmation|verbal_recorded|paper_form');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `next_renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Due Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `policy_title` SET TAGS ('dbx_business_glossary_term' = 'Policy Title');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `policy_version_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `policy_version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Reference Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^ACK-[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `reminder_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Reminder Sent Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `reminder_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Reminder Sent Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency Months');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `safeguarding_policy_acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `safeguarding_policy_acknowledgment_status` SET TAGS ('dbx_value_regex' = 'current|expired|superseded|revoked|pending');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `training_completion_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Required Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Valid From Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `valid_until_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Valid Until Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `witness_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`safeguarding_policy_acknowledgment` ALTER COLUMN `witness_role` SET TAGS ('dbx_business_glossary_term' = 'Witness Role');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` SET TAGS ('dbx_subdomain' = 'policy_compliance');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `community_id` SET TAGS ('dbx_business_glossary_term' = 'Community Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `previous_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Risk Assessment Id');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `previous_risk_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Assessor ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `accountability_mechanism_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Accountability Mechanism Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `accountability_mechanism_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `beneficiary_consultation_conducted` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Consultation Conducted');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `community_trust_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Community Trust Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `community_trust_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `control_gaps_identified` SET TAGS ('dbx_business_glossary_term' = 'Control Gaps Identified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `risk_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `estimated_mitigation_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Mitigation Cost (USD)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `existing_controls_assessment` SET TAGS ('dbx_business_glossary_term' = 'Existing Controls Assessment');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `key_risks_identified` SET TAGS ('dbx_business_glossary_term' = 'Key Risks Identified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Assessment Methodology');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `mitigation_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `mitigation_plan_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|partially_implemented|fully_implemented|ongoing_monitoring');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `operational_environment_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Operational Environment Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `operational_environment_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `overall_safeguarding_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Overall Safeguarding Risk Level');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `overall_safeguarding_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `partner_due_diligence_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Partner Due Diligence Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `partner_due_diligence_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `power_imbalance_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Power Imbalance Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `power_imbalance_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `priority_actions` SET TAGS ('dbx_business_glossary_term' = 'Priority Actions');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `reassessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Reassessment Due Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `reassessment_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Reassessment Frequency (Months)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `recommended_mitigations` SET TAGS ('dbx_business_glossary_term' = 'Recommended Mitigations');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Reference Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^RA-[A-Z]{3}-[0-9]{4}-[0-9]{4}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `report_document_url` SET TAGS ('dbx_business_glossary_term' = 'Assessment Report Document URL');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `report_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `resource_requirements` SET TAGS ('dbx_business_glossary_term' = 'Resource Requirements');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Assessment Scope Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `staff_conduct_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Staff Conduct Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `staff_conduct_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `stakeholders_consulted` SET TAGS ('dbx_business_glossary_term' = 'Stakeholders Consulted');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `risk_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `risk_assessment_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|under_review|approved|completed|superseded');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `team_members` SET TAGS ('dbx_business_glossary_term' = 'Assessment Team Members');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `risk_assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `risk_assessment_type` SET TAGS ('dbx_value_regex' = 'program|project|country_office|partner|event|field_operation');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `vulnerable_population_access_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Vulnerable Population Access Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `vulnerable_population_access_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`risk_assessment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` SET TAGS ('dbx_subdomain' = 'policy_compliance');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `reporting_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Channel ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `escalation_reporting_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reporting Channel Id');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `escalation_reporting_channel_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Focal Point Staff ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `user_account_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `system_platform_id` SET TAGS ('dbx_business_glossary_term' = 'System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `access_method_description` SET TAGS ('dbx_business_glossary_term' = 'Access Method Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `accessibility_accommodations` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Accommodations');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `additional_languages_supported` SET TAGS ('dbx_business_glossary_term' = 'Additional Languages Supported');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `additional_languages_supported` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `anonymity_supported_flag` SET TAGS ('dbx_business_glossary_term' = 'Anonymity Supported Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `average_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Average Response Time Hours');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `average_response_time_hours` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `reporting_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `reporting_channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|restricted|confidential');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_pii_contact' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_pii_contact' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `cost_annual_usd` SET TAGS ('dbx_business_glossary_term' = 'Channel Cost Annual United States Dollars (USD)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `cost_annual_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `country_codes_served` SET TAGS ('dbx_business_glossary_term' = 'Country Codes Served');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Policy');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `establishment_date` SET TAGS ('dbx_business_glossary_term' = 'Establishment Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `external_reporting_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'External Reporting Integration Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `reporting_channel_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `reporting_channel_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `online_form_url` SET TAGS ('dbx_business_glossary_term' = 'Online Form Uniform Resource Locator (URL)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `operating_hours_description` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `physical_location_address` SET TAGS ('dbx_business_glossary_term' = 'Physical Location Address');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `physical_location_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `physical_location_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `primary_language` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `promotion_materials_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Materials Available Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `psea_network_registered_flag` SET TAGS ('dbx_business_glossary_term' = 'Protection from Sexual Exploitation and Abuse (PSEA) Network Registered Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `reports_received_count` SET TAGS ('dbx_business_glossary_term' = 'Reports Received Count');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Months');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `reporting_channel_status` SET TAGS ('dbx_business_glossary_term' = 'Channel Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `reporting_channel_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pilot|decommissioned');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `target_audience` SET TAGS ('dbx_value_regex' = 'beneficiaries|staff|partners|community_members|all');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `third_party_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Third Party Provider Name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `third_party_provider_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `translation_service_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Translation Service Available Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `twenty_four_seven_availability_flag` SET TAGS ('dbx_business_glossary_term' = '24/7 Availability Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `reporting_channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`reporting_channel` ALTER COLUMN `reporting_channel_type` SET TAGS ('dbx_value_regex' = 'hotline|suggestion_box|online_form|community_liaison|direct_report_to_manager|third_party_platform');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` SET TAGS ('dbx_subdomain' = 'policy_compliance');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `focal_point_id` SET TAGS ('dbx_business_glossary_term' = 'Focal Point ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Field Office ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `focal_assigned_country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Backup Focal Point Staff ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `primary_successor_focal_point_id` SET TAGS ('dbx_business_glossary_term' = 'Successor Focal Point ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `tertiary_focal_reporting_line_staff_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Line Staff ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `tertiary_focal_reporting_line_staff_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `tertiary_focal_reporting_line_staff_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `tertiary_quinary_focal_last_modified_by_staff_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Staff ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `tertiary_quinary_focal_last_modified_by_staff_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `tertiary_quinary_focal_last_modified_by_staff_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `assigned_country_office_id` SET TAGS ('dbx_renamed_from' = 'country_office_id');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `appointment_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `availability_hours` SET TAGS ('dbx_business_glossary_term' = 'Availability Hours');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `focal_point_code` SET TAGS ('dbx_business_glossary_term' = 'Focal Point Code');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `focal_point_code` SET TAGS ('dbx_value_regex' = '^FP-[A-Z]{3}-[0-9]{4}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `confidential_hotline` SET TAGS ('dbx_business_glossary_term' = 'Confidential Hotline');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `confidential_hotline` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `confidential_hotline` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `designation_type` SET TAGS ('dbx_business_glossary_term' = 'Designation Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `designation_type` SET TAGS ('dbx_value_regex' = 'PSEA|child_safeguarding|GBV|general|disability_inclusion|elder_protection');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `external_reporting_authority` SET TAGS ('dbx_business_glossary_term' = 'External Reporting Authority');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `handover_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Handover Completed Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `handover_date` SET TAGS ('dbx_business_glossary_term' = 'Handover Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `incident_response_authority` SET TAGS ('dbx_business_glossary_term' = 'Incident Response Authority');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `incidents_handled_count` SET TAGS ('dbx_business_glossary_term' = 'Incidents Handled Count');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `investigation_authority` SET TAGS ('dbx_business_glossary_term' = 'Investigation Authority');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `language_proficiency` SET TAGS ('dbx_business_glossary_term' = 'Language Proficiency');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `language_proficiency` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `last_incident_date` SET TAGS ('dbx_business_glossary_term' = 'Last Incident Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'outstanding|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `primary_responsibility_description` SET TAGS ('dbx_business_glossary_term' = 'Primary Responsibility Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `scope_type` SET TAGS ('dbx_business_glossary_term' = 'Scope Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `scope_type` SET TAGS ('dbx_value_regex' = 'country|region|program|project|global|field_office');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `focal_point_status` SET TAGS ('dbx_business_glossary_term' = 'Focal Point Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `focal_point_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|suspended|terminated');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `term_end_date` SET TAGS ('dbx_business_glossary_term' = 'Term End Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `term_start_date` SET TAGS ('dbx_business_glossary_term' = 'Term Start Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `training_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Training Certification Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `training_certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending|expired|not_required');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`focal_point` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` SET TAGS ('dbx_subdomain' = 'partner_accountability');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `psea_network_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Protection from Sexual Exploitation and Abuse (PSEA) Network Membership ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `predecessor_psea_network_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Psea Network Membership Id');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `predecessor_psea_network_membership_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Focal Point Staff ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `user_account_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `psea_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `tertiary_psea_focal_point_staff_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Psea Focal Point Staff Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `tertiary_psea_focal_point_staff_staff_member_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Approval Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Membership Approved By');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Membership End Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Membership Fee Amount');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Membership Fee Currency Code');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `fee_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Membership Fee Required Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `incident_reporting_protocol_adopted_flag` SET TAGS ('dbx_business_glossary_term' = 'Incident Reporting Protocol Adopted Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `information_sharing_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Information Sharing Consent Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `joint_training_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Joint Training Participation Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `key_commitments` SET TAGS ('dbx_business_glossary_term' = 'Key Commitments');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `last_fee_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Fee Payment Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `last_meeting_attendance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Meeting Attendance Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `meeting_attendance_frequency` SET TAGS ('dbx_business_glossary_term' = 'Meeting Attendance Frequency');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `meeting_attendance_frequency` SET TAGS ('dbx_value_regex' = 'Monthly|Quarterly|Bi-Annual|Annual|Ad-Hoc|As Needed');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `network_coordinator_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Network Coordinator Contact Email');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `network_coordinator_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `network_coordinator_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `network_coordinator_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `network_coordinator_organization` SET TAGS ('dbx_business_glossary_term' = 'Network Coordinator Organization');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Membership Reference Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Start Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `psea_network_membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `psea_network_membership_status` SET TAGS ('dbx_value_regex' = 'Active|Pending|Suspended|Inactive|Withdrawn|Expired');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `survivor_referral_pathway_adopted_flag` SET TAGS ('dbx_business_glossary_term' = 'Survivor Referral Pathway Adopted Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `terms_of_reference_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Terms of Reference (ToR) Acceptance Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `terms_of_reference_accepted_flag` SET TAGS ('dbx_business_glossary_term' = 'Terms of Reference (ToR) Accepted Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network_membership` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` SET TAGS ('dbx_subdomain' = 'partner_accountability');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `misconduct_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Misconduct Disclosure ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `alleged_perpetrator_id` SET TAGS ('dbx_business_glossary_term' = 'Alleged Perpetrator Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `user_account_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `prior_misconduct_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Misconduct Disclosure Id');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `prior_misconduct_disclosure_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `recruitment_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Process ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Staff ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Position Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `action_taken_by_requesting_org` SET TAGS ('dbx_business_glossary_term' = 'Action Taken by Requesting Organization');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `action_taken_by_requesting_org` SET TAGS ('dbx_value_regex' = 'candidate_rejected|candidate_accepted_with_conditions|additional_vetting_required|no_action|pending_review');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `beneficiary_facing_role_flag` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary-Facing Role Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Channel');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'mds_platform|email|secure_portal|phone|in_person|other');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `child_contact_role_flag` SET TAGS ('dbx_business_glossary_term' = 'Child Contact Role Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `data_retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Direction');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'outbound_request|inbound_response|bilateral_exchange');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `disciplinary_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Taken');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `disciplinary_action_taken` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `employment_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Employment Period End Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `employment_period_end_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `employment_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Employment Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `employment_period_start_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `law_enforcement_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `law_enforcement_referral_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `misconduct_category` SET TAGS ('dbx_business_glossary_term' = 'Misconduct Category');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `misconduct_category` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `misconduct_confirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Misconduct Confirmed Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `misconduct_confirmed_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `misconduct_incident_date` SET TAGS ('dbx_business_glossary_term' = 'Misconduct Incident Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `misconduct_incident_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `misconduct_severity_level` SET TAGS ('dbx_business_glossary_term' = 'Misconduct Severity Level');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `misconduct_severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `misconduct_severity_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Misconduct Disclosure Scheme (MDS) Reference Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^MDS-[A-Z]{3}-[0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Request Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `requesting_organization_country` SET TAGS ('dbx_business_glossary_term' = 'Requesting Organization Country');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `requesting_organization_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `requesting_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Requesting Organization Name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `requesting_organization_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `requesting_organization_type` SET TAGS ('dbx_business_glossary_term' = 'Requesting Organization Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Response Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `response_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Response Received Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `response_turnaround_days` SET TAGS ('dbx_business_glossary_term' = 'Response Turnaround Days');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `misconduct_disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `misconduct_disclosure_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|no_response|declined');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `subject_reference_type` SET TAGS ('dbx_business_glossary_term' = 'Subject Reference Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `subject_reference_type` SET TAGS ('dbx_value_regex' = 'staff_candidate|volunteer_candidate|consultant|partner_organization|vendor');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `termination_for_cause_flag` SET TAGS ('dbx_business_glossary_term' = 'Termination for Cause Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `termination_for_cause_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `misconduct_disclosure_type` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`misconduct_disclosure` ALTER COLUMN `misconduct_disclosure_type` SET TAGS ('dbx_value_regex' = 'prior_misconduct|sea_finding|disciplinary_termination|safeguarding_concern|psea_violation|child_safeguarding_breach');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` SET TAGS ('dbx_subdomain' = 'partner_accountability');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `system_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Audited System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `previous_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Audit Id');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `previous_audit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `user_account_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Staff ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `audit_category` SET TAGS ('dbx_business_glossary_term' = 'Audit Category');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `commissioning_organization` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Organization');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `corrective_action_plan_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Required Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Currency Code');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `documents_reviewed_count` SET TAGS ('dbx_business_glossary_term' = 'Documents Reviewed Count');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `external_reporting_date` SET TAGS ('dbx_business_glossary_term' = 'External Reporting Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `external_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'External Reporting Required Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `follow_up_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Required Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `follow_up_audit_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Scheduled Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `good_practices_identified_count` SET TAGS ('dbx_business_glossary_term' = 'Good Practices Identified Count');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `interviews_conducted_count` SET TAGS ('dbx_business_glossary_term' = 'Interviews Conducted Count');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `management_response_date` SET TAGS ('dbx_business_glossary_term' = 'Management Response Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `management_response_date` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `management_response_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Management Response Received Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `management_response_received_flag` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Audit Methodology');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `overall_safeguarding_maturity_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Safeguarding Maturity Rating');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `overall_safeguarding_maturity_rating` SET TAGS ('dbx_value_regex' = 'level_1_initial|level_2_developing|level_3_established|level_4_advanced|level_5_optimized|not_rated');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `recommendations_count` SET TAGS ('dbx_business_glossary_term' = 'Recommendations Count');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Reference Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `report_document_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Document URL');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `report_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `site_visits_conducted_count` SET TAGS ('dbx_business_glossary_term' = 'Site Visits Conducted Count');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Start Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `team_members` SET TAGS ('dbx_business_glossary_term' = 'Audit Team Members');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal_self_assessment|donor_commissioned_review|inter_agency_peer_review|chs_safeguarding_commitment_audit|external_independent_audit|regulatory_compliance_audit');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` SET TAGS ('dbx_subdomain' = 'partner_accountability');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `audit_recommendation_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Recommendation Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner Staff Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `psea_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Related Policy Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `superseded_audit_recommendation_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Audit Recommendation Id');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `superseded_audit_recommendation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `tertiary_audit_created_by_staff_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Staff Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `tertiary_audit_created_by_staff_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `tertiary_audit_created_by_staff_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `tertiary_quinary_audit_responsible_owner_staff_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Quinary Audit Responsible Owner Staff Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `tertiary_quinary_audit_responsible_owner_staff_staff_member_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `budget_allocated_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `audit_recommendation_category` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Category');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `audit_recommendation_category` SET TAGS ('dbx_value_regex' = 'psea|child_safeguarding|staff_conduct|survivor_support|reporting_mechanism|investigation_process');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `days_overdue` SET TAGS ('dbx_business_glossary_term' = 'Days Overdue');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `deferral_reason` SET TAGS ('dbx_business_glossary_term' = 'Deferral Reason');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `deferred_until_date` SET TAGS ('dbx_business_glossary_term' = 'Deferred Until Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `donor_reported_date` SET TAGS ('dbx_business_glossary_term' = 'Donor Reported Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `donor_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Reporting Required Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `evidence_document_url` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `evidence_of_completion` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Completion');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `follow_up_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Action Required Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `implementation_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Implementation Cost United States Dollars (USD)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `implementation_progress_percentage` SET TAGS ('dbx_business_glossary_term' = 'Implementation Progress Percentage');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `implementation_progress_percentage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `implementation_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|overdue|deferred|cancelled');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `management_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Management Acceptance Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `management_acceptance_status` SET TAGS ('dbx_value_regex' = 'accepted|partially_accepted|not_accepted|under_review');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `management_acceptance_status` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `management_response` SET TAGS ('dbx_business_glossary_term' = 'Management Response');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `management_response` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `text` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Text');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Title');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `audit_recommendation_type` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `verification_outcome` SET TAGS ('dbx_business_glossary_term' = 'Verification Outcome');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `verification_outcome` SET TAGS ('dbx_value_regex' = 'verified|partially_verified|not_verified|pending_verification');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`audit_recommendation` ALTER COLUMN `verification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Verification Required Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` SET TAGS ('dbx_subdomain' = 'partner_accountability');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `donor_safeguarding_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Safeguarding Requirement ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `psea_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Policy ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Staff ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `superseded_donor_safeguarding_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Donor Safeguarding Requirement Id');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `superseded_donor_safeguarding_requirement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `tertiary_donor_last_modified_by_staff_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Staff ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `tertiary_donor_last_modified_by_staff_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `tertiary_donor_last_modified_by_staff_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `applicable_country_codes` SET TAGS ('dbx_business_glossary_term' = 'Applicable Country Codes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `applicable_program_ids` SET TAGS ('dbx_business_glossary_term' = 'Applicable Program IDs');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `donor_safeguarding_requirement_description` SET TAGS ('dbx_business_glossary_term' = 'Requirement Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Donor Contact Email');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Donor Contact Name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `evidence_document_url` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document URL');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `evidence_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `incident_reporting_timeframe_hours` SET TAGS ('dbx_business_glossary_term' = 'Incident Reporting Timeframe Hours');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `non_compliance_consequence` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Consequence');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `non_compliance_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Risk Level');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `non_compliance_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Requirement Reference Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `donor_safeguarding_requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Requirement Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `submission_format` SET TAGS ('dbx_business_glossary_term' = 'Submission Format');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'donor_portal|email|postal_mail|in_person|secure_file_transfer');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Requirement Title');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `donor_safeguarding_requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Requirement Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `donor_safeguarding_requirement_type` SET TAGS ('dbx_value_regex' = 'psea_policy_submission|training_completion_evidence|incident_reporting_protocol|annual_safeguarding_report|background_check_verification|safeguarding_audit');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `waiver_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `waiver_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`donor_safeguarding_requirement` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` SET TAGS ('dbx_subdomain' = 'partner_accountability');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `partner_psea_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Protection from Sexual Exploitation and Abuse (PSEA) Assessment ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `capacity_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `capacity_building_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Building Plan ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `previous_partner_psea_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Partner Psea Assessment Id');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `previous_partner_psea_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Staff ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `tertiary_partner_created_by_staff_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Staff ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `tertiary_partner_created_by_staff_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `tertiary_partner_created_by_staff_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `capacity_building_plan_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Capacity Building Plan Triggered Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `capacity_score` SET TAGS ('dbx_business_glossary_term' = 'Capacity Score');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Completion Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `conditional_approval_requirements` SET TAGS ('dbx_business_glossary_term' = 'Conditional Approval Requirements');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `critical_gap_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Gap Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `partner_psea_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `investigation_capacity_rating` SET TAGS ('dbx_business_glossary_term' = 'Investigation Capacity Rating');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `investigation_capacity_rating` SET TAGS ('dbx_value_regex' = 'compliant|partially_compliant|non_compliant|not_assessed');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `key_gaps_identified` SET TAGS ('dbx_business_glossary_term' = 'Key Gaps Identified');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `maximum_possible_score` SET TAGS ('dbx_business_glossary_term' = 'Maximum Possible Score');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `methodology_description` SET TAGS ('dbx_business_glossary_term' = 'Assessment Methodology Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `overall_capacity_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Safeguarding Capacity Rating');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `overall_capacity_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low|inadequate|not_assessed');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `partnership_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Partnership Approval Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `partnership_approval_status` SET TAGS ('dbx_value_regex' = 'approved|conditional_approval|not_approved|pending_review');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `policy_existence_rating` SET TAGS ('dbx_business_glossary_term' = 'Policy Existence Rating');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `policy_existence_rating` SET TAGS ('dbx_value_regex' = 'compliant|partially_compliant|non_compliant|not_assessed');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `reassessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Reassessment Due Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `reassessment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reassessment Required Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `recommendations` SET TAGS ('dbx_business_glossary_term' = 'Recommendations');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Reference Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `report_document_url` SET TAGS ('dbx_business_glossary_term' = 'Assessment Report Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `report_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `reporting_mechanism_rating` SET TAGS ('dbx_business_glossary_term' = 'Reporting Mechanism Rating');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `reporting_mechanism_rating` SET TAGS ('dbx_value_regex' = 'compliant|partially_compliant|non_compliant|not_assessed');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `staff_training_rating` SET TAGS ('dbx_business_glossary_term' = 'Staff Training Rating');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `staff_training_rating` SET TAGS ('dbx_value_regex' = 'compliant|partially_compliant|non_compliant|not_assessed');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Start Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `partner_psea_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `survivor_support_rating` SET TAGS ('dbx_business_glossary_term' = 'Survivor Support Rating');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `survivor_support_rating` SET TAGS ('dbx_value_regex' = 'compliant|partially_compliant|non_compliant|not_assessed');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `team_members` SET TAGS ('dbx_business_glossary_term' = 'Assessment Team Members');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `partner_psea_assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `partner_psea_assessment_type` SET TAGS ('dbx_value_regex' = 'psea_organizational_assessment|safeguarding_checklist|chs_self_assessment|due_diligence_review|capacity_verification|follow_up_assessment');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`partner_psea_assessment` ALTER COLUMN `validity_period_months` SET TAGS ('dbx_business_glossary_term' = 'Assessment Validity Period Months');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` SET TAGS ('dbx_subdomain' = 'training_awareness');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `community_awareness_session_id` SET TAGS ('dbx_business_glossary_term' = 'Community Awareness Session ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `community_id` SET TAGS ('dbx_business_glossary_term' = 'Community ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `distribution_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `followup_community_awareness_session_id` SET TAGS ('dbx_business_glossary_term' = 'Followup Community Awareness Session Id');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `followup_community_awareness_session_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Facilitator Staff ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `tertiary_community_created_by_staff_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Staff ID');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `tertiary_community_created_by_staff_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `tertiary_community_created_by_staff_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `attendance_sheet_document_url` SET TAGS ('dbx_business_glossary_term' = 'Attendance Sheet Document URL');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `community_awareness_session_date` SET TAGS ('dbx_business_glossary_term' = 'Session Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration in Minutes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Session End Time');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `feedback_received` SET TAGS ('dbx_business_glossary_term' = 'Feedback Received');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `follow_up_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Actions Required');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `incident_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Incident Reported Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `key_messages_delivered` SET TAGS ('dbx_business_glossary_term' = 'Key Messages Delivered');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `key_messages_delivered` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `language_used` SET TAGS ('dbx_business_glossary_term' = 'Language Used');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `language_used` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `location_country_code` SET TAGS ('dbx_business_glossary_term' = 'Location Country Code');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `location_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `location_district` SET TAGS ('dbx_business_glossary_term' = 'Location District');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `location_region` SET TAGS ('dbx_business_glossary_term' = 'Location Region');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `location_site_name` SET TAGS ('dbx_business_glossary_term' = 'Location Site Name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `location_site_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `materials_distributed` SET TAGS ('dbx_business_glossary_term' = 'Materials Distributed');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Session Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `participant_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Participant Satisfaction Rating');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `participant_satisfaction_rating` SET TAGS ('dbx_value_regex' = 'Very Satisfied|Satisfied|Neutral|Dissatisfied|Very Dissatisfied');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `participants_adults_18_to_59` SET TAGS ('dbx_business_glossary_term' = 'Participants Adults 18 to 59');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `participants_children_under_18` SET TAGS ('dbx_business_glossary_term' = 'Participants Children Under 18');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `participants_elderly_60_plus` SET TAGS ('dbx_business_glossary_term' = 'Participants Elderly 60 Plus');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `participants_female` SET TAGS ('dbx_business_glossary_term' = 'Participants Female');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `participants_male` SET TAGS ('dbx_business_glossary_term' = 'Participants Male');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `participants_other_gender` SET TAGS ('dbx_business_glossary_term' = 'Participants Other Gender');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `participants_other_gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `participants_other_gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `participants_other_gender` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `participants_with_disabilities` SET TAGS ('dbx_business_glossary_term' = 'Participants with Disabilities');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Session Reference Number');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `referral_made_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Made Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `report_document_url` SET TAGS ('dbx_business_glossary_term' = 'Session Report Document URL');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Session Start Time');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `community_awareness_session_status` SET TAGS ('dbx_business_glossary_term' = 'Session Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `community_awareness_session_status` SET TAGS ('dbx_value_regex' = 'Planned|Scheduled|Completed|Cancelled|Postponed');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `total_participants` SET TAGS ('dbx_business_glossary_term' = 'Total Participants');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `translation_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Translation Provided Flag');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `community_awareness_session_type` SET TAGS ('dbx_business_glossary_term' = 'Session Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`community_awareness_session` ALTER COLUMN `community_awareness_session_type` SET TAGS ('dbx_value_regex' = 'PSEA Awareness|Child Safeguarding|Reporting Channels Orientation|Rights and Entitlements|GBV Prevention|Community Feedback Mechanism');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` SET TAGS ('dbx_subdomain' = 'partner_accountability');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `psea_network_id` SET TAGS ('dbx_business_glossary_term' = 'Psea Network Identifier');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `parent_psea_network_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Psea Network Id');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `parent_psea_network_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `psea_network_code` SET TAGS ('dbx_business_glossary_term' = 'Network Code');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `community_engagement_approach` SET TAGS ('dbx_business_glossary_term' = 'Community Engagement Approach');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `community_engagement_approach` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `coordination_level` SET TAGS ('dbx_business_glossary_term' = 'Coordination Level');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `establishment_date` SET TAGS ('dbx_business_glossary_term' = 'Establishment Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `focal_point_email` SET TAGS ('dbx_business_glossary_term' = 'Focal Point Email');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `focal_point_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `focal_point_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `focal_point_name` SET TAGS ('dbx_business_glossary_term' = 'Focal Point Name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `focal_point_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `focal_point_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `focal_point_phone` SET TAGS ('dbx_business_glossary_term' = 'Focal Point Phone');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `focal_point_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `focal_point_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `investigation_capacity` SET TAGS ('dbx_business_glossary_term' = 'Investigation Capacity');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `lead_organization` SET TAGS ('dbx_business_glossary_term' = 'Lead Organization');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `mandate_description` SET TAGS ('dbx_business_glossary_term' = 'Mandate Description');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `meeting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Meeting Frequency');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Member Count');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `psea_network_name` SET TAGS ('dbx_business_glossary_term' = 'Network Name');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `psea_network_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `reporting_mechanism_available` SET TAGS ('dbx_business_glossary_term' = 'Reporting Mechanism Available');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `reporting_mechanism_type` SET TAGS ('dbx_business_glossary_term' = 'Reporting Mechanism Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `psea_network_status` SET TAGS ('dbx_business_glossary_term' = 'Network Status');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `survivor_assistance_available` SET TAGS ('dbx_business_glossary_term' = 'Survivor Assistance Available');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `terms_of_reference_url` SET TAGS ('dbx_business_glossary_term' = 'Terms Of Reference Url');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `training_program_available` SET TAGS ('dbx_business_glossary_term' = 'Training Program Available');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `psea_network_type` SET TAGS ('dbx_business_glossary_term' = 'Network Type');
ALTER TABLE `vibe_ngo_v1`.`safeguarding`.`psea_network` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Url');
