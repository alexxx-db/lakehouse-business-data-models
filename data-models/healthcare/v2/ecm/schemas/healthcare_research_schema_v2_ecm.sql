-- Schema for Domain: research | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 14:11:20

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`research` COMMENT 'Clinical research and medical research operations. Owns clinical trial protocols, IRB (Institutional Review Board) approvals, study enrollment, investigational drug/device tracking, informed consent, adverse event reporting, research billing compliance, research data governance, de-identified data access for population health studies, and translational research. Supports academic medical centers under FDA 21 CFR Part 11.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`research_study` (
    `research_study_id` BIGINT COMMENT 'Unique identifier for the research study. Primary key for the research study entity.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Studies are conducted at primary coordinating facilities. Site performance tracking, regulatory reporting, and operational planning require identifying the lead facility for each protocol. Essential f',
    `compliance_program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Clinical trials operate under compliance programs (IRB oversight, GCP, HIPAA research provisions). Research governance requires linking studies to governing compliance frameworks for audit trails and ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Research studies are conducted within institutional departments tracked as cost centers for budget allocation, expense tracking, and financial performance reporting. Essential for departmental account',
    `exchange_standard_id` BIGINT COMMENT 'Foreign key linking to interoperability.exchange_standard. Business justification: Research studies must document which data exchange standards (HL7 v2, FHIR, CDA) are used for regulatory submissions to FDA and data sharing with sponsors/registries per 21 CFR Part 11 compliance requ',
    `osha_safety_program_id` BIGINT COMMENT 'Foreign key linking to compliance.osha_safety_program. Business justification: Research studies involving hazardous materials, radiation, or biohazards operate under OSHA safety programs. EHS compliance requirement for laboratory and clinical research.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Clinical trials often have payer sponsors or require payer coverage analysis for billing determination. Research billing events reference payer relationships for standard-of-care vs research cost allo',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Research protocols target specific disease conditions coded via ICD-10 for inclusion/exclusion criteria, regulatory submissions, and therapeutic area classification. Essential for protocol design and ',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Studies involving procedural interventions reference CPT codes for coverage analysis, research billing determination (standard-of-care vs investigational), and regulatory documentation. Critical for b',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Principal investigators are institutional employees requiring credentialing, license verification, effort reporting, and IRB authorization. Essential for regulatory compliance (FDA 1572, ICH-GCP) and ',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Therapeutic specialty alignment enables research feasibility assessment, site selection based on clinical expertise, and principal investigator qualification verification. Healthcare operations use sp',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Research studies procure investigational products, devices, and specialized equipment from vendors. Protocol compliance requires tracking vendor relationships for IP sourcing, device trials, and regul',
    `actual_enrollment` STRING COMMENT 'The actual number of subjects enrolled in the study to date.',
    `amendment_count` STRING COMMENT 'The total number of protocol amendments that have been issued for this study.',
    `blinding_type` STRING COMMENT 'The level of blinding or masking applied in the study design.. Valid values are `open_label|single_blind|double_blind|triple_blind|quadruple_blind`',
    `cfr_part_11_compliant_flag` BOOLEAN COMMENT 'Indicates whether the study is conducted in compliance with FDA 21 CFR Part 11 electronic records and electronic signatures requirements.',
    `completion_date` DATE COMMENT 'The date on which the study was completed or is expected to be completed (last subject last visit).',
    `control_type` STRING COMMENT 'The type of control used in the study design.. Valid values are `placebo|active_comparator|no_intervention|sham|dose_comparison|historical`',
    `coordinating_center` STRING COMMENT 'The name of the coordinating center or data coordinating center managing the multi-site study.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the research study record was first created in the system.',
    `data_monitoring_committee_flag` BOOLEAN COMMENT 'Indicates whether an independent Data Monitoring Committee or Data Safety Monitoring Board oversees the study.',
    `enrollment_end_date` DATE COMMENT 'The date on which subject enrollment was closed or is planned to close.',
    `enrollment_start_date` DATE COMMENT 'The date on which subject enrollment began for this study.',
    `exclusion_criteria` STRING COMMENT 'Summary of the key exclusion criteria that would disqualify subjects from enrollment.',
    `fda_regulated_device_flag` BOOLEAN COMMENT 'Indicates whether the study involves an FDA-regulated device product.',
    `fda_regulated_drug_flag` BOOLEAN COMMENT 'Indicates whether the study involves an FDA-regulated drug product.',
    `funding_source` STRING COMMENT 'The primary source of funding for the research study (e.g., NIH grant number, industry sponsor).',
    `ide_number` STRING COMMENT 'The FDA-assigned Investigational Device Exemption number for device studies.',
    `inclusion_criteria` STRING COMMENT 'Summary of the key inclusion criteria that subjects must meet to be eligible for enrollment.',
    `ind_number` STRING COMMENT 'The FDA-assigned Investigational New Drug application number for drug studies.',
    `irb_approval_date` DATE COMMENT 'The date on which the IRB granted initial approval for the study to commence.',
    `irb_expiration_date` DATE COMMENT 'The date on which the current IRB approval expires and requires renewal.',
    `irb_protocol_number` STRING COMMENT 'The protocol number assigned by the Institutional Review Board that approved the study.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the research study record was last updated or modified.',
    `nct_identifier` STRING COMMENT 'ClinicalTrials.gov registry identifier (NCT number) for the study. Required for applicable clinical trials under FDAAA 801.. Valid values are `^NCT[0-9]{8}$`',
    `phase` STRING COMMENT 'The clinical trial phase (I, II, III, IV) indicating the stage of drug or device development. Not applicable for non-interventional studies. [ENUM-REF-CANDIDATE: phase_i|phase_ii|phase_iii|phase_iv|phase_i_ii|phase_ii_iii|not_applicable — 7 candidates stripped; promote to reference product]',
    `primary_completion_date` DATE COMMENT 'The date on which the last subject was examined or received an intervention for the purposes of final collection of data for the primary outcome.',
    `primary_outcome_measure` STRING COMMENT 'Description of the primary outcome measure or endpoint that the study is designed to assess.',
    `protocol_number` STRING COMMENT 'The official protocol number assigned to the research study by the sponsor or institution. Serves as the primary business identifier for the study.',
    `protocol_version` STRING COMMENT 'The current version number or identifier of the study protocol.',
    `protocol_version_date` DATE COMMENT 'The effective date of the current protocol version.',
    `randomization_flag` BOOLEAN COMMENT 'Indicates whether the study employs randomization of subjects to treatment arms.',
    `secondary_outcome_measures` STRING COMMENT 'Description of secondary outcome measures or endpoints assessed in the study.',
    `short_title` STRING COMMENT 'Abbreviated or short title of the study for operational use and reporting.',
    `sponsor_name` STRING COMMENT 'The name of the organization or entity sponsoring the research study (pharmaceutical company, academic institution, government agency).',
    `sponsor_type` STRING COMMENT 'Classification of the sponsor organization type.. Valid values are `industry|academic|government|non_profit|investigator_initiated`',
    `start_date` DATE COMMENT 'The date on which the study officially began enrollment or first subject first visit.',
    `study_description` STRING COMMENT 'A detailed narrative description of the study purpose, design, and methodology.',
    `study_status` STRING COMMENT 'Current lifecycle status of the research study indicating its operational state. [ENUM-REF-CANDIDATE: draft|pending_irb|approved|active|enrolling|closed_to_enrollment|completed|suspended|terminated|withdrawn — 10 candidates stripped; promote to reference product]',
    `study_type` STRING COMMENT 'Classification of the research study type indicating the nature of the investigation.. Valid values are `interventional|observational|expanded_access|registry|diagnostic|prevention`',
    `target_enrollment` STRING COMMENT 'The planned total number of subjects to be enrolled in the study across all sites.',
    `title` STRING COMMENT 'The full official title of the research study as documented in the protocol.',
    CONSTRAINT pk_research_study PRIMARY KEY(`research_study_id`)
) COMMENT 'Master record for every clinical or medical research study conducted at the institution. Captures study title, sponsor, phase (I–IV), study type (interventional, observational, expanded access), therapeutic area, IND/IDE number, NCT identifier, FDA 21 CFR Part 11 compliance flag, study status, IRB protocol number, PI, coordinating center, target enrollment, start/end dates, and regulatory submission references. Protocol amendments: tracked with amendment number, date, description of changes, reason, impact assessment (safety, efficacy, enrollment), IRB/FDA submission references, sponsor approval date, and implementation date per site — maintains full protocol version history for regulatory inspections. Treatment arms: arm name, type (experimental, active comparator, placebo, sham, observational), planned enrollment per arm, randomization ratio, dose/intervention description, arm status (open, closed, suspended), supporting randomization management and stratified enrollment. SSOT for research study identity, protocol version history, protocol amendments, and study design structure (including treatment arms) across the research domain.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`irb_submission` (
    `irb_submission_id` BIGINT COMMENT 'Unique identifier for the IRB or federal agency regulatory submission record. Primary key.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: IRB submissions are audited during FDA/OHRP inspections and institutional compliance reviews. Audit findings reference specific submissions for regulatory compliance verification and corrective action',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: IRB submissions are facility-specific for site-level protocol approvals. Regulatory compliance tracking, audit preparation, and IRB correspondence management require linking submissions to the submitt',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to consent.consent_policy. Business justification: IRB submissions must reference institutional consent policies to verify study consent procedures comply with organizational consent governance requirements. IRB reviewers validate consent form element',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: IRB submissions for clinical trials often reference payer coverage policies (NCDs, LCDs, commercial policies) to demonstrate that standard-of-care services are covered, supporting the protocols feasi',
    `interface_channel_id` BIGINT COMMENT 'Foreign key linking to interoperability.interface_channel. Business justification: IRB submissions to federal agencies (FDA, OHRP) are transmitted via specific interface channels for regulatory reporting. Tracks which channel was used for submission audit trail and troubleshooting f',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: IRB submissions document the disease/condition under study using standardized ICD codes for regulatory review, risk assessment, and vulnerable population determination. Required for IRB protocol revie',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the principal investigator responsible for this study and submission.',
    `protocol_amendment_id` BIGINT COMMENT 'Foreign key linking to research.protocol_amendment. Business justification: IRB submissions can be for protocol amendments (not all submissions are for amendments - initial submissions are for the base protocol). Adding protocol_amendment_id as nullable FK enables tracking of',
    `research_study_id` BIGINT COMMENT 'Foreign key reference to the parent research study or clinical trial protocol for which this submission is made.',
    `tertiary_irb_reviewed_by_user_employee_id` BIGINT COMMENT 'Foreign key reference to the IRB member, reviewer, or federal agency officer who conducted the primary review of this submission.',
    `acknowledgment_date` DATE COMMENT 'The date on which the federal agency (FDA, OHRP) formally acknowledged receipt of the submission. Applicable for federal agency submissions.',
    `action_due_date` DATE COMMENT 'The deadline by which the sponsor must complete required actions and respond to the IRB or federal agency.',
    `action_required_description` STRING COMMENT 'Detailed description of the actions required by the sponsor in response to the IRB or agency determination (e.g., Revise informed consent to clarify risks, Provide additional safety data).',
    `action_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether sponsor action is required in response to this submission (e.g., address IRB stipulations, respond to FDA information request, submit additional data).',
    `agency_response_letter` STRING COMMENT 'Reference or summary of the official response letter or communication received from the IRB or federal agency regarding this submission.',
    `approval_date` DATE COMMENT 'The date on which the IRB or federal agency granted approval or acknowledgment for this submission.',
    `approval_expiration_date` DATE COMMENT 'The date on which the IRB approval expires, requiring continuing review or renewal. Typically one year from approval date for greater than minimal risk studies.',
    `conditions_of_approval` STRING COMMENT 'Any stipulations, modifications, or conditions imposed by the IRB or federal agency as part of the approval. May include required protocol changes, additional monitoring, or reporting requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this submission record was first created in the research management system.',
    `determination_outcome` STRING COMMENT 'The IRB or agencys determination outcome: approved (full approval with no conditions), conditionally approved (approved pending minor modifications or clarifications), deferred (requires substantive revisions and re-review), disapproved (not approved), exempt determination (research qualifies for exemption), or not human subjects research (activity does not meet definition of human subjects research).. Valid values are `approved|conditionally_approved|deferred|disapproved|exempt_determination|not_human_subjects_research`',
    `ectd_sequence_number` STRING COMMENT 'The eCTD sequence number for FDA electronic submissions, used to track versions and amendments in the eCTD lifecycle.',
    `federal_agency_name` STRING COMMENT 'The name of the federal agency reviewing this submission (e.g., FDA Center for Drug Evaluation and Research, FDA Center for Devices and Radiological Health, OHRP). Applicable when reviewing_body_type is FDA, OHRP, or other federal agency.',
    `fwa_number` STRING COMMENT 'The institutions Federalwide Assurance number issued by OHRP, which is the assurance of compliance with federal regulations for the protection of human subjects. Format: FWA followed by 8 digits.. Valid values are `^FWA[0-9]{8}$`',
    `ide_number` STRING COMMENT 'The FDA-assigned Investigational Device Exemption number for device studies. Format: G followed by 6 digits. Applicable for IDE-related submissions.. Valid values are `^G[0-9]{6}$`',
    `ind_number` STRING COMMENT 'The FDA-assigned Investigational New Drug application number for drug studies. Format: IND followed by 6 digits. Applicable for IND-related submissions.. Valid values are `^IND[0-9]{6}$`',
    `informed_consent_version` STRING COMMENT 'The version identifier of the informed consent document(s) submitted and reviewed as part of this submission.',
    `irb_board_name` STRING COMMENT 'The name of the specific IRB board or panel reviewing this submission (e.g., Main IRB, Cancer Research IRB, Pediatric IRB). Applicable when reviewing_body_type is IRB.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this submission record was last updated or modified in the research management system.',
    `nct_number` STRING COMMENT 'The ClinicalTrials.gov registry identifier for this study. Format: NCT followed by 8 digits. Required for applicable clinical trials under FDAAA 801.. Valid values are `^NCT[0-9]{8}$`',
    `protocol_version` STRING COMMENT 'The version identifier of the research protocol submitted and reviewed as part of this submission.',
    `review_meeting_date` DATE COMMENT 'The date of the IRB convened meeting at which this submission was reviewed. Applicable for full board reviews.',
    `review_type` STRING COMMENT 'The level of review applied to this submission: full board (convened meeting review), expedited (review by IRB chair or designated reviewers), exempt (meets exemption criteria under 45 CFR 46.104), or administrative (non-substantive review).. Valid values are `full_board|expedited|exempt|administrative`',
    `reviewing_body_type` STRING COMMENT 'The type of regulatory body reviewing this submission: IRB (Institutional Review Board), FDA (Food and Drug Administration), OHRP (Office for Human Research Protections), or other federal agency.. Valid values are `irb|fda|ohrp|other_federal_agency`',
    `risk_level` STRING COMMENT 'The IRBs determination of the level of risk to human subjects: minimal risk (probability and magnitude of harm not greater than ordinary life) or greater than minimal risk.. Valid values are `minimal_risk|greater_than_minimal_risk`',
    `sponsor_organization` STRING COMMENT 'The name of the organization or entity sponsoring the research study (e.g., pharmaceutical company, academic institution, government agency).',
    `submission_date` DATE COMMENT 'The date on which the submission was formally submitted to the IRB or federal agency for review.',
    `submission_method` STRING COMMENT 'The method by which the submission was delivered: electronic eCTD (Electronic Common Technical Document for FDA submissions), electronic portal (IRB or agency online system), paper (physical documents), or email.. Valid values are `electronic_ectd|electronic_portal|paper|email`',
    `submission_notes` STRING COMMENT 'Additional notes, comments, or context regarding this submission, including internal tracking information or special circumstances.',
    `submission_number` STRING COMMENT 'The externally-known unique identifier or control number assigned by the IRB or federal agency to this submission (e.g., IRB protocol number, IND number, IDE number).',
    `submission_status` STRING COMMENT 'Current lifecycle status of the submission: draft (being prepared), submitted (sent to reviewing body), under review (active review in progress), approved (full approval granted), conditionally approved (approved with stipulations), deferred (additional information required), disapproved (rejected), withdrawn (voluntarily pulled by sponsor), acknowledged (federal agency receipt confirmed), or closed (submission lifecycle complete). [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|conditionally_approved|deferred|disapproved|withdrawn|acknowledged|closed — 10 candidates stripped; promote to reference product]',
    `submission_type` STRING COMMENT 'The category of regulatory submission: initial IRB review, protocol amendment, continuing review, reportable event (adverse event, protocol deviation, unanticipated problem), study closure, FDA IND (Investigational New Drug) application, IND amendment, IND annual report, IND safety report, IDE (Investigational Device Exemption) application, IDE supplement, NDA (New Drug Application), BLA (Biologics License Application), or OHRP (Office for Human Research Protections) assurance filing. [ENUM-REF-CANDIDATE: initial_review|amendment|continuing_review|reportable_event|closure|ind_application|ind_amendment|ind_annual_report|ind_safety_report|ide_application|ide_supplement|nda_submission|bla_submission|ohrp_assurance — 14 candidates stripped; promote to reference product]',
    `vulnerable_population_flag` BOOLEAN COMMENT 'Boolean indicator of whether the study involves vulnerable populations requiring additional protections (e.g., children, prisoners, pregnant women, cognitively impaired individuals).',
    `vulnerable_population_type` STRING COMMENT 'The specific type of vulnerable population involved in the study, requiring additional regulatory protections and IRB review considerations.. Valid values are `children|prisoners|pregnant_women|cognitively_impaired|economically_disadvantaged|other`',
    CONSTRAINT pk_irb_submission PRIMARY KEY(`irb_submission_id`)
) COMMENT 'Tracks all regulatory submissions associated with a research study, including IRB submissions (initial review, amendments, continuing reviews, reportable events, closures) and federal agency submissions (FDA IND/IDE applications, IND amendments, annual reports, safety reports, NDA/BLA submissions, OHRP assurance filings). Captures submission type, submission date, reviewing body (IRB board name/FWA number or federal agency), review type, determination outcome, approval/acknowledgment dates, conditions, submission number, submission method (eCTD, paper), agency response, and action required. Supports FDA 21 CFR Parts 56/312/812, 45 CFR Part 46 (Common Rule), and OHRP regulatory lifecycle management. SSOT for all research regulatory submissions (both IRB and federal agency) within the research domain.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`study_site` (
    `study_site_id` BIGINT COMMENT 'Unique identifier for the study site participating in a clinical trial. Primary key.',
    `accreditation_status_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_status. Business justification: Research sites require accreditation (AAHRPP for human subjects research, CAP for labs, AAALAC for animal research). Accreditation status is tracked per site for regulatory compliance.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Study sites undergo compliance audits (monitoring visits, regulatory inspections, GCP audits). Sites are audited entities requiring linkage for findings tracking, corrective actions, and accreditation',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility or research center where the study site is located.',
    `clinician_id` BIGINT COMMENT 'Reference to the principal investigator responsible for the conduct of the clinical trial at this site.',
    `cms_condition_status_id` BIGINT COMMENT 'Foreign key linking to compliance.cms_condition_status. Business justification: Research sites within CMS-certified facilities must maintain Conditions of Participation compliance. CMS surveys assess research activities as part of hospital operations.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Study sites operate as departmental cost centers for financial tracking, budget management, and institutional accounting. Required for site-level financial performance analysis, overhead allocation, a',
    `inventory_location_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_location. Business justification: Research sites maintain dedicated inventory locations for investigational products requiring temperature monitoring, secure storage, and regulatory compliance. Real business process: IP storage manage',
    `research_study_id` BIGINT COMMENT 'Reference to the parent clinical trial protocol that this site is participating in.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Site coordinators are institutional employees managing local study operations, subject scheduling, regulatory binder maintenance, and monitoring visit coordination. Required for workload tracking, GCP',
    `activation_date` DATE COMMENT 'Date when the site was officially activated and authorized to begin enrolling subjects in the clinical trial.',
    `actual_enrollment_count` STRING COMMENT 'Actual number of subjects enrolled at this site to date.',
    `adverse_event_count` STRING COMMENT 'Total number of adverse events reported from subjects enrolled at this site.',
    `closure_date` DATE COMMENT 'Date when the site was officially closed and ceased all study-related activities.',
    `corrective_action_plan_due_date` DATE COMMENT 'Date by which the site must submit or complete the corrective action plan to address identified deficiencies.',
    `corrective_action_plan_required_flag` BOOLEAN COMMENT 'Indicates whether a corrective action plan is currently required to address findings from monitoring visits or audits.',
    `corrective_action_plan_status` STRING COMMENT 'Current status of the corrective action plan addressing monitoring findings or audit observations.. Valid values are `not_required|pending|submitted|under_review|accepted|implemented`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this study site record was first created in the system.',
    `cro_organization_name` STRING COMMENT 'Name of the CRO contracted to manage site monitoring and oversight activities, if applicable.',
    `data_query_count` STRING COMMENT 'Total number of data clarification queries issued to this site for case report form discrepancies or missing data.',
    `enrollment_rate_per_month` DECIMAL(18,2) COMMENT 'Average number of subjects enrolled per month at this site, used for performance tracking and forecasting.',
    `informed_consent_compliance_status` STRING COMMENT 'Assessment of the sites compliance with informed consent procedures and documentation requirements.. Valid values are `compliant|minor_issue|major_issue|under_review`',
    `investigational_product_accountability_status` STRING COMMENT 'Current status of investigational drug or device accountability and inventory reconciliation at this site.. Valid values are `compliant|minor_discrepancy|major_discrepancy|under_review`',
    `irb_approval_date` DATE COMMENT 'Date when the IRB granted initial approval for the study to be conducted at this site.',
    `irb_approval_number` STRING COMMENT 'IRB-assigned approval number or reference for the study protocol at this site.',
    `irb_expiration_date` DATE COMMENT 'Date when the current IRB approval expires and requires renewal for continued study conduct.',
    `irb_of_record_name` STRING COMMENT 'Name of the IRB or ethics committee responsible for reviewing and approving the study at this site.',
    `last_monitoring_visit_date` DATE COMMENT 'Date of the most recent monitoring visit conducted at this site.',
    `last_monitoring_visit_type` STRING COMMENT 'Type of the most recent monitoring visit conducted at this site.. Valid values are `initiation|routine|interim|close_out|for_cause`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this study site record was most recently modified.',
    `next_monitoring_visit_scheduled_date` DATE COMMENT 'Planned date for the next scheduled monitoring visit at this site.',
    `open_data_query_count` STRING COMMENT 'Number of data queries currently outstanding and awaiting site response or resolution.',
    `planned_enrollment_capacity` STRING COMMENT 'Target number of subjects the site is expected to enroll in the clinical trial based on site capabilities and protocol requirements.',
    `protocol_deviation_count` STRING COMMENT 'Total number of protocol deviations identified at this site across all monitoring visits and audits.',
    `regulatory_binder_status` STRING COMMENT 'Current completeness status of the site regulatory binder containing all required regulatory documents and approvals.. Valid values are `incomplete|complete|under_review|approved`',
    `screen_failure_count` STRING COMMENT 'Number of subjects who were screened but failed to meet eligibility criteria and were not enrolled at this site.',
    `serious_adverse_event_count` STRING COMMENT 'Number of serious adverse events reported from subjects enrolled at this site, requiring expedited reporting.',
    `serious_protocol_deviation_count` STRING COMMENT 'Number of serious or major protocol deviations that may impact subject safety or data integrity at this site.',
    `site_name` STRING COMMENT 'Official name of the clinical research site or facility participating in the trial.',
    `site_notes` STRING COMMENT 'Free-text notes capturing important site-specific information, special considerations, or historical context.',
    `site_number` STRING COMMENT 'Sponsor-assigned unique site number within the clinical trial. Used for regulatory reporting and site identification across study documentation.',
    `site_performance_score` DECIMAL(18,2) COMMENT 'Composite performance score for the site based on enrollment rate, data quality, protocol compliance, and query resolution metrics.',
    `site_risk_rating` STRING COMMENT 'Overall risk assessment of the site based on performance metrics, compliance history, and monitoring findings.. Valid values are `low|medium|high|critical`',
    `site_status` STRING COMMENT 'Current operational status of the study site within the clinical trial lifecycle.. Valid values are `pending_activation|active|suspended|closed|terminated`',
    `source_document_verification_status` STRING COMMENT 'Current status of source document verification activities comparing case report forms to original medical records.. Valid values are `not_started|in_progress|complete|issues_identified`',
    `sponsor_organization_name` STRING COMMENT 'Name of the organization sponsoring the clinical trial (pharmaceutical company, academic institution, or government agency).',
    CONSTRAINT pk_study_site PRIMARY KEY(`study_site_id`)
) COMMENT 'Represents a physical or virtual site participating in a multi-site clinical trial, including site management and monitoring visit tracking. Site level: site name, number, facility identifier, PI at site, activation/closure dates, enrollment capacity, IRB of record, regulatory binder status, and performance metrics (screen failures, enrollment rate). Monitoring visits: visit type (initiation, routine, close-out, for-cause), visit date, monitor name/organization (sponsor, CRO, internal), findings summary, protocol deviations identified, data discrepancies noted, corrective action plan (CAP) required flag, CAP due date, CAP resolution, and visit report completion date. Supports multi-site trial management, site performance oversight, sponsor monitoring obligations, and ICH E6(R2) GCP monitoring requirements. SSOT for study site management and monitoring visit tracking within the research domain.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` (
    `subject_enrollment_id` BIGINT COMMENT 'Unique identifier for the research subject enrollment record. Primary key for this entity.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Subjects enroll at specific facilities. Enrollment metrics, site performance dashboards, patient safety monitoring, and resource allocation all require facility-level enrollment tracking. Fundamental ',
    `employee_id` BIGINT COMMENT 'Reference to the principal investigator responsible for this subject enrollment at the research site.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Device trials and implantable studies require tracking specific products (devices, implants) assigned to enrolled subjects. Essential for UDI capture, device accountability, adverse event reporting, a',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient master record. Links enrollment to the patient domain via Medical Record Number (MRN) without duplicating patient master data.',
    `notice_of_privacy_practices_id` BIGINT COMMENT 'Foreign key linking to compliance.notice_of_privacy_practices. Business justification: Research subjects must receive NPP at enrollment per HIPAA. NPP distribution is documented per enrollment for compliance with Privacy Rule requirements.',
    `patient_account_id` BIGINT COMMENT 'Foreign key linking to billing.patient_account. Business justification: Research subjects often have dedicated billing accounts to segregate research charges from clinical charges, track sponsor-covered services, and manage research-specific billing rules. Essential for r',
    `phi_access_log_id` BIGINT COMMENT 'Foreign key linking to compliance.phi_access_log. Business justification: Subject enrollment creates PHI access events that must be logged for HIPAA compliance auditing. Standard access monitoring for research subject records.',
    `research_study_id` BIGINT COMMENT 'Unique study-specific identifier assigned to the research subject, distinct from Medical Record Number (MRN). Used for de-identification and research data governance.',
    `study_arm_id` BIGINT COMMENT 'Foreign key linking to research.study_arm. Business justification: Enrolled subjects are randomized to study arms. Currently has randomization_arm (STRING) but no FK to study_arm master. Adding study_arm_id FK allows removal of redundant randomization_arm column whic',
    `study_site_id` BIGINT COMMENT 'Reference to the clinical research site or facility where the subject is enrolled and followed.',
    `adverse_event_flag` BOOLEAN COMMENT 'Indicates whether any adverse events were reported for this subject during the enrollment period. True if adverse events exist, False otherwise.',
    `completion_date` DATE COMMENT 'Date when the subject completed all protocol-required study activities and assessments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was first created in the system. Audit trail for data governance and compliance.',
    `data_lock_flag` BOOLEAN COMMENT 'Indicates whether this enrollment record has been locked for final analysis and regulatory submission. True if locked, False if still editable.',
    `data_lock_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was locked for final analysis. Null if not yet locked.',
    `data_monitoring_committee_review_flag` BOOLEAN COMMENT 'Indicates whether this subject enrollment was reviewed by the Data Monitoring Committee. True if reviewed, False otherwise.',
    `eligibility_confirmed_flag` BOOLEAN COMMENT 'Indicates whether the subject met all inclusion criteria and no exclusion criteria at the time of enrollment. True if eligibility was confirmed, False otherwise.',
    `enrollment_date` DATE COMMENT 'Date when the subject was formally enrolled into the research study after meeting eligibility criteria and providing informed consent.',
    `enrollment_notes` STRING COMMENT 'Free-text notes or comments related to the subject enrollment, including special circumstances, protocol-specific observations, or administrative remarks.',
    `enrollment_source` STRING COMMENT 'Source or channel through which the subject was recruited into the study (e.g., direct recruitment, physician referral, patient registry, community outreach).. Valid values are `direct_recruitment|referral|registry|existing_patient|community_outreach|other`',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the subject enrollment. Tracks progression from screening through study completion or early termination. [ENUM-REF-CANDIDATE: screened|enrolled|active|completed|withdrawn|lost_to_follow_up|screen_failed — 7 candidates stripped; promote to reference product]',
    `informed_consent_date` DATE COMMENT 'Date when the subject provided informed consent to participate in the research study.',
    `informed_consent_version` STRING COMMENT 'Version number or identifier of the informed consent form signed by the subject. Tracks consent document revisions.',
    `investigational_product_dispensed_flag` BOOLEAN COMMENT 'Indicates whether investigational drug or device was dispensed to this subject. True if product was dispensed, False otherwise.',
    `irb_approval_number` STRING COMMENT 'IRB approval number under which this subject enrollment was authorized. Links to the IRB approval record for the study protocol.',
    `protocol_deviation_flag` BOOLEAN COMMENT 'Indicates whether any protocol deviations occurred during this subject enrollment. True if deviations were recorded, False otherwise.',
    `randomization_date` DATE COMMENT 'Date when the subject was randomized to a treatment arm or cohort. Applicable for randomized controlled trials.',
    `screening_date` DATE COMMENT 'Date when the subject was screened for eligibility to participate in the research study. First contact date in the enrollment lifecycle.',
    `serious_adverse_event_flag` BOOLEAN COMMENT 'Indicates whether any serious adverse events were reported for this subject. True if serious adverse events exist, False otherwise.',
    `stratification_factors` STRING COMMENT 'Demographic or clinical characteristics used to stratify the subject during randomization (e.g., age group, disease stage, biomarker status). Stored as structured text or delimited values.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was last modified. Audit trail for data governance and compliance.',
    `withdrawal_date` DATE COMMENT 'Date when the subject withdrew from the study or was withdrawn by the investigator prior to completion.',
    `withdrawal_reason` STRING COMMENT 'Reason for subject withdrawal from the study (e.g., adverse event, subject request, protocol violation, lost to follow-up, investigator decision).',
    CONSTRAINT pk_subject_enrollment PRIMARY KEY(`subject_enrollment_id`)
) COMMENT 'Operational record of a research subjects enrollment into a specific study, capturing the full enrollment lifecycle. Includes subject study ID (distinct from MRN), screening date, enrollment date, randomization date, randomization arm/cohort assignment, stratification factors, enrollment status (screened, enrolled, active, completed, withdrawn, lost to follow-up), withdrawal reason, and completion date. Links to the patient domain via MRN without duplicating patient master data. Core transactional entity for study enrollment tracking.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`informed_consent` (
    `informed_consent_id` BIGINT COMMENT 'Unique identifier for the informed consent record. Primary key for the informed consent data product.',
    `attestation_id` BIGINT COMMENT 'Foreign key linking to compliance.attestation. Business justification: Informed consent processes require staff attestation of training and competency. Regulatory requirement for consent administrators to attest to proper training and understanding.',
    `capacity_assessment_id` BIGINT COMMENT 'Foreign key linking to consent.consent_capacity_assessment. Business justification: Research informed consent requires documented capacity assessment when subjects ability to consent is questioned. Regulatory requirement (21 CFR 50.20, ICH-GCP 4.8.9) mandates capacity determination ',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Informed consent processes must comply with institutional policies (IRB SOPs, HIPAA authorization, vulnerable population protections). Policy references are standard in consent documentation and regul',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Consenting clinician is required for regulatory compliance (21 CFR 50, ICH-GCP) and informed consent documentation. Healthcare operations track which credentialed clinician obtained consent for audit ',
    `demographics_id` BIGINT COMMENT 'Foreign key linking to patient.demographics. Business justification: Research informed consent requires direct link to patient demographics for identity verification during consent process, regulatory compliance (21 CFR Part 11 electronic signatures), consent capacity ',
    `visit_id` BIGINT COMMENT 'add column encounter_visit_id (BIGINT) with FK to encounter.visit.visit_id - informed consent is obtained during specific encounters but lacks a visit FK',
    `form_template_id` BIGINT COMMENT 'Identifier of the IRB-approved consent form template version used for this consent. Links to the consent form template master record.',
    `employee_id` BIGINT COMMENT 'User ID of the system user who last modified this informed consent record. Part of audit trail for regulatory compliance.',
    `informed_obtained_by_user_employee_id` BIGINT COMMENT 'User ID of the system user who created this informed consent record. Part of audit trail for regulatory compliance.',
    `note_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_note. Business justification: Informed consent discussions are documented as clinical notes in EHR per ICH-GCP requirements; linking supports regulatory audit trails, integrated documentation, and consent verification workflows. R',
    `notice_of_privacy_practices_id` BIGINT COMMENT 'Foreign key linking to compliance.notice_of_privacy_practices. Business justification: Informed consent processes include HIPAA authorization, which references the NPP. Often combined documents for research subjects receiving clinical care.',
    `primary_informed_employee_id` BIGINT COMMENT 'Identifier of the research staff member who obtained the informed consent. Must be a qualified and trained individual per protocol.',
    `research_study_id` BIGINT COMMENT 'Identifier of the clinical trial protocol under which this consent was obtained. Links to the protocol master record.',
    `subject_enrollment_id` BIGINT COMMENT 'Identifier of the research subject who provided informed consent. Links to the research subject master record.',
    `capacity_assessment_performed` BOOLEAN COMMENT 'Indicates whether a formal assessment of the subjects capacity to consent was performed. Required for vulnerable populations or when capacity is in question.',
    `capacity_assessment_result` STRING COMMENT 'Result of the capacity assessment. Capable indicates subject can provide informed consent; incapable indicates LAR consent required; not assessed indicates no formal assessment performed.. Valid values are `capable|incapable|not_assessed`',
    `consent_comprehension_assessed` BOOLEAN COMMENT 'Indicates whether the subjects comprehension of the informed consent was formally assessed (e.g., via teach-back method or comprehension quiz). Recommended for complex protocols.',
    `consent_copy_provided_date` DATE COMMENT 'Date on which a copy of the signed informed consent form was provided to the subject. Should match or closely follow consent date.',
    `consent_copy_provided_flag` BOOLEAN COMMENT 'Indicates whether a copy of the signed informed consent form was provided to the subject or legally authorized representative. Required by FDA and ICH guidelines.',
    `consent_date` DATE COMMENT 'Date on which the informed consent was obtained from the subject or legally authorized representative. Must be prior to any study procedures.',
    `consent_discussion_duration_minutes` STRING COMMENT 'Duration in minutes of the informed consent discussion with the subject. Captured to demonstrate adequate time for subject comprehension and questions.',
    `consent_document_location` STRING COMMENT 'Physical or electronic location where the original signed informed consent document is stored (e.g., regulatory binder, document management system path). Required for regulatory inspection readiness.',
    `consent_method` STRING COMMENT 'Method by which the informed consent was obtained. In-person is traditional face-to-face; electronic is via eConsent platform; telephonic is via phone with verbal consent; video conference is via remote video with electronic signature.. Valid values are `in_person|electronic|telephonic|video_conference`',
    `consent_status` STRING COMMENT 'Current status of the informed consent. Active indicates valid consent; withdrawn indicates subject revoked consent; expired indicates consent past validity period; superseded indicates replaced by newer version; pending indicates consent process initiated but not completed.. Valid values are `active|withdrawn|expired|superseded|pending`',
    `consent_time` TIMESTAMP COMMENT 'Precise timestamp when the informed consent was obtained, including time zone. Required for electronic consent systems and audit trails.',
    `consent_type` STRING COMMENT 'Type of informed consent obtained. Initial consent is the first consent; re-consent is obtained when protocol amendments require new consent; assent is for minors; LAR (Legally Authorized Representative) consent is for subjects unable to consent; HIPAA authorization is for PHI use; short form is for non-English speakers with witness; broad consent is for future unspecified research. [ENUM-REF-CANDIDATE: initial|re-consent|assent|lar_consent|hipaa_authorization|short_form|broad_consent — 7 candidates stripped; promote to reference product]',
    `consent_version_number` STRING COMMENT 'Version number of the consent form template used at the time of consent. Ensures traceability to the specific IRB-approved version.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this informed consent record was first created in the system. Part of audit trail for regulatory compliance.',
    `electronic_signature_reference` STRING COMMENT 'Unique identifier of the electronic signature captured via eConsent platform. Null for paper-based consents. Must comply with 21 CFR Part 11 requirements.',
    `hipaa_authorization_date` DATE COMMENT 'Date on which HIPAA authorization was obtained. Null if HIPAA authorization was not required or not included.',
    `hipaa_authorization_included` BOOLEAN COMMENT 'Indicates whether HIPAA authorization for use and disclosure of Protected Health Information (PHI) was included in this consent. Required for research involving PHI in the United States.',
    `interpreter_name` STRING COMMENT 'Full name of the interpreter who assisted with the informed consent process. Null if no interpreter was used.',
    `interpreter_used_flag` BOOLEAN COMMENT 'Indicates whether an interpreter was used during the informed consent process. True when subjects primary language differs from consent form language.',
    `irb_approval_date` DATE COMMENT 'Date on which the IRB approved the consent form template version used. Consent date must be on or after this date.',
    `irb_approval_number` STRING COMMENT 'IRB approval number for the consent form template version used. Ensures consent was obtained using an IRB-approved document.',
    `irb_expiration_date` DATE COMMENT 'Date on which the IRB approval for the consent form template expires. Consent date must be before this date to be valid.',
    `language_code` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the language in which the informed consent was presented and obtained (e.g., ENG for English, SPA for Spanish).. Valid values are `^[A-Z]{3}$`',
    `lar_consent_indicator` BOOLEAN COMMENT 'Indicates whether consent was obtained from a legally authorized representative rather than the subject. True when subject lacks capacity to consent.',
    `lar_name` STRING COMMENT 'Full name of the legally authorized representative who provided consent on behalf of the subject. Null if consent was obtained directly from subject.',
    `lar_relationship` STRING COMMENT 'Relationship of the legally authorized representative to the subject (e.g., parent, guardian, healthcare proxy, power of attorney). Null if consent was obtained directly from subject.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this informed consent record was last modified in the system. Part of audit trail for regulatory compliance.',
    `re_consent_date` DATE COMMENT 'Date on which re-consent was obtained due to protocol amendments or new information. Null if no re-consent has occurred.',
    `subject_questions_addressed_flag` BOOLEAN COMMENT 'Indicates whether all subject questions were addressed during the informed consent process. True confirms subject had opportunity to ask questions and received answers.',
    `subject_signature_date` DATE COMMENT 'Date on which the subject signed the informed consent form. Must match or precede consent date.',
    `subject_signature_indicator` BOOLEAN COMMENT 'Indicates whether the subject provided a signature on the informed consent form. True for signed consents; false for verbal consent with witness or LAR consent.',
    `withdrawal_date` DATE COMMENT 'Date on which the subject withdrew their informed consent. Null if consent has not been withdrawn.',
    `withdrawal_reason` STRING COMMENT 'Free-text reason provided by the subject for withdrawing informed consent. Null if consent has not been withdrawn.',
    `witness_name` STRING COMMENT 'Full name of the individual who witnessed the informed consent process. Null if no witness was required or present.',
    `witness_required_flag` BOOLEAN COMMENT 'Indicates whether a witness signature was required for this consent. True for short form consents, subjects unable to read, or per IRB requirements.',
    CONSTRAINT pk_informed_consent PRIMARY KEY(`informed_consent_id`)
) COMMENT 'Records the informed consent process for each research subject and manages IRB-approved consent form templates/versions. Subject-level consent: captures consent form version, consent date, re-consent date, consent type (initial, re-consent, assent, LAR consent), consenting staff, witness, signature indicator, capacity assessment, and language. Template/version management: captures template version number, IRB approval date, expiration date, language versions, form type (full ICF, short form, assent, HIPAA authorization), required elements checklist, and template status (draft, approved, superseded). Supports FDA 21 CFR Part 50, ICH E6(R2), and ensures subjects are consented on the current IRB-approved version. SSOT for consent documentation, template version control, and consent compliance within the research domain.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` (
    `protocol_amendment_id` BIGINT COMMENT 'Unique identifier for the protocol amendment record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Protocol amendments are authored by institutional research staff (PIs, research coordinators, regulatory specialists). Tracking authorship supports accountability, workload assessment, and quality met',
    `regulatory_change_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_change. Business justification: Protocol amendments are often triggered by regulatory changes (new FDA guidance, ICH-GCP updates, safety alerts). Tracking this linkage is essential for compliance documentation and regulatory justifi',
    `research_study_id` BIGINT COMMENT 'Reference to the parent research protocol that this amendment modifies.',
    `superseded_by_protocol_amendment_id` BIGINT COMMENT 'Reference to a subsequent amendment that supersedes this one, supporting version history tracking.',
    `amendment_date` DATE COMMENT 'Date when the amendment was formally created or drafted. Represents the principal business event timestamp for this amendment.',
    `amendment_description` STRING COMMENT 'Detailed narrative description of the changes introduced by this amendment, including specific sections of the protocol modified.',
    `amendment_document_url` STRING COMMENT 'URL or file path to the official amendment document stored in the document management system.',
    `amendment_number` STRING COMMENT 'Sequential or hierarchical identifier for this amendment (e.g., Amendment 1, Amendment 2.1). Serves as the business-facing amendment identifier.',
    `amendment_status` STRING COMMENT 'Current lifecycle status of the amendment (draft, submitted to IRB, IRB approved, submitted to FDA, FDA approved, sponsor approved, implemented, withdrawn, superseded). [ENUM-REF-CANDIDATE: draft|submitted_to_irb|irb_approved|submitted_to_fda|fda_approved|sponsor_approved|implemented|withdrawn|superseded — 9 candidates stripped; promote to reference product]',
    `amendment_title` STRING COMMENT 'Brief descriptive title summarizing the purpose or focus of this amendment.',
    `amendment_type` STRING COMMENT 'Classification of the amendment based on the nature and impact of the change (substantial, administrative, minor, safety-related, protocol deviation correction, eligibility criteria change).. Valid values are `substantial|administrative|minor|safety|protocol_deviation_correction|eligibility_criteria_change`',
    `amendment_version` STRING COMMENT 'Version identifier for this amendment document, supporting full version history tracking for regulatory audit readiness.',
    `comments` STRING COMMENT 'Free-text field for additional notes, reviewer comments, or internal documentation related to this amendment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this amendment record was first created in the system. Supports audit trail and regulatory compliance under FDA 21 CFR Part 11.',
    `fda_acknowledgment_date` DATE COMMENT 'Date when the FDA acknowledged receipt of the IND amendment submission.',
    `fda_submission_date` DATE COMMENT 'Date when the amendment was submitted to the FDA as part of an Investigational New Drug (IND) amendment.',
    `fda_submission_reference` STRING COMMENT 'Reference number for the FDA submission (e.g., IND amendment number) associated with this protocol amendment.',
    `impact_assessment_efficacy` STRING COMMENT 'Assessment of the amendments impact on study efficacy endpoints, statistical power, and scientific validity.',
    `impact_assessment_enrollment` STRING COMMENT 'Assessment of the amendments impact on study enrollment, including changes to eligibility criteria, recruitment strategies, or target enrollment numbers.',
    `impact_assessment_operational` STRING COMMENT 'Assessment of the amendments impact on study operations, site procedures, data collection, and resource requirements.',
    `impact_assessment_safety` STRING COMMENT 'Assessment of the amendments impact on participant safety, including any new risks introduced or mitigated.',
    `implementation_date` DATE COMMENT 'Date when this amendment was implemented and became effective across study sites.',
    `informed_consent_update_required_flag` BOOLEAN COMMENT 'Indicates whether this amendment requires updates to the informed consent form and re-consenting of enrolled participants.',
    `irb_approval_date` DATE COMMENT 'Date when the IRB granted approval for this amendment.',
    `irb_approval_number` STRING COMMENT 'Official approval number or reference issued by the IRB for this amendment.',
    `irb_submission_date` DATE COMMENT 'Date when the amendment was submitted to the IRB for review and approval.',
    `irb_submission_reference` STRING COMMENT 'Reference number or identifier for the IRB submission package associated with this amendment.',
    `last_modified_by` STRING COMMENT 'User identifier or name of the individual who last modified this amendment record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this amendment record was last modified. Supports audit trail and regulatory compliance under FDA 21 CFR Part 11.',
    `protocol_sections_modified` STRING COMMENT 'List or description of specific protocol sections modified by this amendment (e.g., Section 5.2 Inclusion Criteria, Section 8.1 Dosing Schedule).',
    `reason_for_amendment` STRING COMMENT 'Business and scientific rationale explaining why this amendment was necessary (e.g., safety concerns, enrollment challenges, new scientific data, regulatory feedback).',
    `reconsent_required_flag` BOOLEAN COMMENT 'Indicates whether currently enrolled participants must be re-consented under the amended protocol.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this amendment must be reported to regulatory authorities beyond the FDA (e.g., international regulatory bodies).',
    `site_implementation_required_flag` BOOLEAN COMMENT 'Indicates whether this amendment requires implementation actions at individual study sites (True) or is administrative only (False).',
    `sponsor_approval_authority` STRING COMMENT 'Name or role of the sponsor representative who authorized approval of this amendment.',
    `sponsor_approval_date` DATE COMMENT 'Date when the study sponsor formally approved this amendment for implementation.',
    `created_by` STRING COMMENT 'User identifier or name of the individual who created this amendment record in the system.',
    CONSTRAINT pk_protocol_amendment PRIMARY KEY(`protocol_amendment_id`)
) COMMENT 'Tracks all amendments to an approved research protocol, including the amendment number, amendment date, description of changes, reason for amendment, impact assessment (safety, efficacy, enrollment), IRB submission reference, FDA submission reference (IND amendment), sponsor approval date, and implementation date at each site. Maintains the full version history of the study protocol to support regulatory inspections and audit readiness under FDA 21 CFR Part 11.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`study_visit` (
    `study_visit_id` BIGINT COMMENT 'Unique identifier for the study visit record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Research visits occur at specific facilities. Visit scheduling, facility resource allocation, staff coordination, and operational logistics require facility-level visit tracking. Essential for researc',
    `clinician_id` BIGINT COMMENT 'Reference to the principal investigator responsible for the study at the site where this visit occurred.',
    `demographics_id` BIGINT COMMENT 'Reference to the enrolled research subject (patient) participating in the study.',
    `lab_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_order. Business justification: Protocol visits include scheduled lab collections per visit schedule. Linking visit to lab orders enables visit completion tracking, protocol deviation detection (missed/late labs), and source data ve',
    `observation_id` BIGINT COMMENT 'Foreign key linking to clinical.observation. Business justification: Study visits capture protocol-required observations (labs, assessments); linking supports protocol adherence monitoring, data completeness validation, and regulatory inspection readiness. Real process',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Study visits generate billable procedures that must be coded as CPT for research billing and coverage analysis. Essential for revenue cycle management and billing compliance in clinical trials.',
    `employee_id` BIGINT COMMENT 'Reference to the research coordinator or clinical research associate assigned to manage and document this visit.',
    `research_study_id` BIGINT COMMENT 'Reference to the clinical trial or research study to which this visit belongs.',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Some protocols require specific room types (procedure rooms, imaging suites). Room-level scheduling, equipment availability verification, and space utilization tracking require room assignment for res',
    `study_arm_id` BIGINT COMMENT 'Foreign key linking to research.study_arm. Business justification: Study visits are conducted for subjects enrolled in specific study arms. Adding study_arm_id FK enables arm-specific visit scheduling and protocol compliance tracking. Nullable as screening visits occ',
    `study_site_id` BIGINT COMMENT 'Reference to the research site or facility where the visit was conducted. Critical for multi-site clinical trials.',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key linking to research.subject_enrollment. Business justification: Study visits are conducted for enrolled subjects. Currently has demographics_id but no FK to subject_enrollment. Adding subject_enrollment_id establishes the relationship between visits and the enroll',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Research visits often occur in specialized units (infusion centers, clinical research units). Unit-level scheduling, nurse staffing, and resource planning require tracking which unit hosts each visit.',
    `vital_sign_id` BIGINT COMMENT 'Foreign key linking to clinical.vital_sign. Business justification: Study protocols require vital sign collection per visit schedule; linking enables protocol compliance monitoring, data quality validation, and source data verification during monitoring visits. Real p',
    `actual_date` DATE COMMENT 'The date on which the visit actually occurred. May differ from scheduled_date if the visit was rescheduled or occurred outside the protocol window.',
    `adverse_event_reported_flag` BOOLEAN COMMENT 'Boolean indicator of whether any adverse events were reported or documented during this visit. True indicates at least one adverse event was captured.',
    `assessments_completed_count` STRING COMMENT 'The number of protocol-required assessments (procedures, questionnaires, lab tests, imaging studies) that were successfully completed during this visit.',
    `assessments_missed_count` STRING COMMENT 'The number of protocol-required assessments that were not completed during this visit. Indicates potential protocol deviations.',
    `cancellation_reason` STRING COMMENT 'Reason why the visit was cancelled if visit_status is cancelled (e.g., subject withdrawal, investigator decision, adverse event, scheduling conflict, study termination).',
    `compliance_percentage` DECIMAL(18,2) COMMENT 'Calculated percentage of protocol-required assessments and procedures that were successfully completed during this visit. Used to track subject adherence and protocol compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this study visit record was first created in the system. Audit trail field for data governance and compliance.',
    `data_entry_complete_flag` BOOLEAN COMMENT 'Boolean indicator of whether all data from this visit has been entered into the electronic data capture (EDC) system. True indicates data entry is complete and the visit record is ready for monitoring or query resolution.',
    `informed_consent_reaffirmed_flag` BOOLEAN COMMENT 'Boolean indicator of whether informed consent was reaffirmed or re-consented during this visit (e.g., due to protocol amendments or new risks). True indicates consent was reaffirmed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this study visit record was last updated or modified. Audit trail field for data governance and compliance.',
    `missed_visit_reason` STRING COMMENT 'Reason why the subject missed the scheduled visit if visit_status is missed (e.g., subject no-show, illness, transportation issues, lost to follow-up).',
    `protocol_deviation_description` STRING COMMENT 'Detailed narrative description of any protocol deviations that occurred during this visit, including the nature of the deviation and any corrective actions taken.',
    `protocol_deviation_flag` BOOLEAN COMMENT 'Boolean indicator of whether any protocol deviations occurred during this visit (e.g., visit outside window, missed assessments, incorrect procedures). True indicates a deviation was documented.',
    `query_open_count` STRING COMMENT 'The number of open data queries associated with this visit that require resolution by the site. Used to track data quality and cleaning progress.',
    `scheduled_date` DATE COMMENT 'The date on which the visit was originally scheduled to occur according to the protocol timeline and visit windows.',
    `serious_adverse_event_flag` BOOLEAN COMMENT 'Boolean indicator of whether any serious adverse events (SAEs) were reported during this visit. SAEs require expedited reporting to regulatory authorities and IRB. True indicates at least one SAE was documented.',
    `source_data_verified_flag` BOOLEAN COMMENT 'Boolean indicator of whether the visit data has been verified against source documents by a clinical research associate or monitor. True indicates source data verification (SDV) is complete.',
    `study_drug_dispensed_flag` BOOLEAN COMMENT 'Boolean indicator of whether investigational drug or device was dispensed to the subject during this visit. True indicates study product was provided.',
    `study_drug_returned_flag` BOOLEAN COMMENT 'Boolean indicator of whether the subject returned unused investigational drug or device during this visit for accountability tracking. True indicates product was returned.',
    `visit_duration_minutes` STRING COMMENT 'The total duration of the visit in minutes, from check-in to check-out. Used for operational planning and subject burden assessment.',
    `visit_location` STRING COMMENT 'The physical or virtual location where the visit was conducted (e.g., research clinic, hospital site, subject home, telehealth platform). Important for multi-site studies and decentralized trials.',
    `visit_locked_flag` BOOLEAN COMMENT 'Boolean indicator of whether the visit data has been locked in the EDC system, preventing further edits. True indicates the visit is locked and considered final for analysis.',
    `visit_locked_timestamp` TIMESTAMP COMMENT 'The date and time when the visit data was locked in the EDC system. Null if the visit is not yet locked.',
    `visit_name` STRING COMMENT 'Human-readable name or label for the visit as defined in the protocol (e.g., Screening Visit, Baseline Assessment, Week 12 Follow-up, End of Study).',
    `visit_notes` STRING COMMENT 'Free-text clinical notes or observations documented by the study coordinator or investigator during the visit. May include subject comments, logistical issues, or contextual information.',
    `visit_number` STRING COMMENT 'Protocol-defined visit number or identifier (e.g., V1, V2, V3, Screening, Baseline, Week 4, Month 6). Corresponds to the schedule of assessments in the study protocol.',
    `visit_status` STRING COMMENT 'Current lifecycle status of the visit. Scheduled indicates the visit is planned, completed indicates all assessments were performed, missed indicates the subject did not attend, cancelled indicates the visit was removed from the schedule, in_progress indicates the visit is currently underway, and rescheduled indicates the visit was moved to a different date.. Valid values are `scheduled|completed|missed|cancelled|in_progress|rescheduled`',
    `visit_type` STRING COMMENT 'Classification of the visit according to its purpose in the study protocol. Screening visits assess eligibility, baseline establishes pre-treatment status, treatment visits occur during intervention, follow-up monitors post-treatment outcomes, end of study concludes participation, unscheduled visits address ad-hoc needs, safety visits monitor adverse events, and early termination visits document premature withdrawal. [ENUM-REF-CANDIDATE: screening|baseline|treatment|follow_up|end_of_study|unscheduled|safety|early_termination — 8 candidates stripped; promote to reference product]',
    `visit_window_end_date` DATE COMMENT 'The latest date within the protocol-defined visit window during which the visit may be conducted while remaining compliant with the study protocol.',
    `visit_window_start_date` DATE COMMENT 'The earliest date within the protocol-defined visit window during which the visit may be conducted while remaining compliant with the study protocol.',
    `visit_window_status` STRING COMMENT 'Indicates whether the actual visit date fell within the protocol-defined visit window. Within_window indicates compliance, early indicates the visit occurred before the window opened, late indicates the visit occurred after the window closed, and out_of_window indicates significant protocol deviation.. Valid values are `within_window|early|late|out_of_window`',
    CONSTRAINT pk_study_visit PRIMARY KEY(`study_visit_id`)
) COMMENT 'Represents a scheduled or unscheduled study visit for an enrolled research subject, as defined by the protocol schedule of assessments. Captures visit name, visit number, visit window (planned, early, late), actual visit date, visit type (screening, baseline, treatment, follow-up, end of study, unscheduled), visit status (scheduled, completed, missed, cancelled), visit location, and coordinator assigned. Drives protocol compliance tracking and subject retention management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`adverse_event` (
    `adverse_event_id` BIGINT COMMENT 'Unique identifier for the adverse event or protocol deviation record. Primary key for the adverse event data product.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Adverse events are reported by site. Site safety profiles, regulatory reporting (FDA, IRB), site performance evaluation, and risk-based monitoring all require facility attribution of adverse events. M',
    `compliance_regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Serious adverse events trigger mandatory regulatory submissions (IND safety reports, MedWatch forms, IRB reports). Core FDA/regulatory requirement for expedited reporting and safety monitoring.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_diagnosis. Business justification: Adverse events often result in clinical diagnoses documented in patient medical records; linking supports SAE causality assessment, regulatory safety reporting (FDA MedWatch), and longitudinal patient',
    `hotline_report_id` BIGINT COMMENT 'Foreign key linking to compliance.hotline_report. Business justification: Adverse events may be reported via compliance hotlines (safety concerns, protocol violations, misconduct allegations). Hotline reports trigger AE investigations and regulatory reporting.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Adverse events are coded using ICD-10-CM for integration with clinical documentation, regulatory reporting (FDA MedWatch), and safety signal detection. Essential for pharmacovigilance and serious adve',
    `investigation_id` BIGINT COMMENT 'Foreign key linking to compliance.investigation. Business justification: Serious adverse events trigger compliance investigations (root cause analysis, regulatory reporting determination, protocol violation assessment). Standard safety and quality management process.',
    `mpi_record_id` BIGINT COMMENT 'Identifier of the research subject (patient) who experienced the adverse event or was affected by the protocol deviation.',
    `public_health_report_id` BIGINT COMMENT 'Foreign key linking to interoperability.public_health_report. Business justification: Serious adverse events in clinical trials trigger mandatory expedited reporting to FDA via MedWatch (21 CFR 312.32). Links AE to the actual public health report transmission for regulatory compliance ',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Reporting clinician is tracked for adverse event causality assessment, safety monitoring, and regulatory reporting (FDA MedWatch, IRB reporting). Healthcare operations require credentialed clinician a',
    `research_study_id` BIGINT COMMENT 'Identifier of the clinical trial or research study in which this adverse event or protocol deviation occurred.',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Clinical research uses SNOMED CT for precise adverse event terminology mapping to MedDRA codes in safety databases and regulatory submissions. Critical for pharmacovigilance systems and FDA/EMA report',
    `study_site_id` BIGINT COMMENT 'Identifier of the clinical research site where the adverse event or protocol deviation was reported.',
    `study_visit_id` BIGINT COMMENT 'Foreign key linking to research.study_visit. Business justification: Adverse events are often detected or reported during study visits. Adding study_visit_id as nullable FK enables linking AEs to the visit context where they were identified, supporting temporal analysi',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key linking to research.subject_enrollment. Business justification: Adverse events are reported for enrolled research subjects. Currently has mpi_record_id but no FK to subject_enrollment. Adding subject_enrollment_id links the AE to the specific study enrollment, ena',
    `action_taken` STRING COMMENT 'Action taken with the investigational product in response to the adverse event: none, dose reduced, dose interrupted, drug withdrawn, concomitant medication given, or other.. Valid values are `none|dose_reduced|dose_interrupted|drug_withdrawn|concomitant_medication|other`',
    `ae_term` STRING COMMENT 'Medical term describing the adverse event using standardized medical terminology (typically MedDRA preferred term).',
    `capa_completion_date` DATE COMMENT 'Date when the corrective and preventive action plan was completed and verified.',
    `capa_description` STRING COMMENT 'Description of corrective and preventive actions (CAPA) taken to address the protocol deviation or quality event and prevent recurrence.',
    `causality_assessment` STRING COMMENT 'Investigator assessment of the relationship between the adverse event and the investigational product or study procedure: not related, unlikely, possible, probable, or definite.. Valid values are `not_related|unlikely|possible|probable|definite`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this adverse event record was first created in the research data system.',
    `deviation_category` STRING COMMENT 'Category of protocol deviation: eligibility criteria violation, informed consent issue, dosing error, visit window violation, data collection error, procedure deviation, or other. [ENUM-REF-CANDIDATE: eligibility|informed_consent|dosing|visit_window|data_collection|procedure|other — 7 candidates stripped; promote to reference product]',
    `deviation_description` STRING COMMENT 'Detailed description of the protocol deviation or violation, including what occurred and how it deviated from the approved protocol.',
    `deviation_severity` STRING COMMENT 'Severity classification of the protocol deviation: minor (no impact on subject safety or data integrity), major (potential impact), or critical (significant impact requiring immediate action).. Valid values are `minor|major|critical`',
    `discovery_date` DATE COMMENT 'Date when the protocol deviation or quality event was discovered or identified.',
    `event_status` STRING COMMENT 'Current workflow status of the adverse event or protocol deviation record: open (newly reported), under review (being investigated), resolved (action taken), or closed (final disposition complete).. Valid values are `open|under_review|resolved|closed`',
    `event_type` STRING COMMENT 'Classification of the safety or quality event: adverse event (AE), serious adverse event (SAE), protocol deviation, protocol violation, quality event, or near miss.. Valid values are `adverse_event|serious_adverse_event|protocol_deviation|protocol_violation|quality_event|near_miss`',
    `expectedness` STRING COMMENT 'Indicates whether the adverse event was expected (consistent with the investigator brochure or product labeling) or unexpected.. Valid values are `expected|unexpected`',
    `expedited_report_date` DATE COMMENT 'Date when the expedited safety report was submitted to regulatory authorities or IRB.',
    `expedited_reporting_flag` BOOLEAN COMMENT 'Indicates whether this adverse event requires expedited reporting to regulatory authorities (FDA, IRB) within specified timelines (typically 7 or 15 days for serious, unexpected, and related events).',
    `follow_up_date` DATE COMMENT 'Date when follow-up information was obtained or is scheduled to be obtained for this adverse event.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether additional follow-up information is required for this adverse event or protocol deviation.',
    `impact_on_data_integrity` STRING COMMENT 'Assessment of the protocol deviation or quality event impact on data integrity and study results: none, minimal, moderate, or significant.. Valid values are `none|minimal|moderate|significant`',
    `impact_on_subject_safety` STRING COMMENT 'Assessment of the protocol deviation or quality event impact on subject safety: none, minimal, moderate, or significant.. Valid values are `none|minimal|moderate|significant`',
    `irb_report_date` DATE COMMENT 'Date when the adverse event or protocol deviation report was submitted to the IRB.',
    `irb_reportable_flag` BOOLEAN COMMENT 'Indicates whether this adverse event or protocol deviation requires reporting to the Institutional Review Board (IRB) per institutional policy and federal regulations.',
    `meddra_code` STRING COMMENT 'MedDRA code for the adverse event term, enabling standardized reporting and analysis of safety data.',
    `meddra_version` STRING COMMENT 'Version of the MedDRA dictionary used for coding the adverse event term.',
    `medwatch_report_number` STRING COMMENT 'FDA MedWatch (Form 3500A) report number if an expedited safety report was submitted to the FDA.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this adverse event record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this adverse event record was last modified or updated.',
    `narrative` STRING COMMENT 'Detailed narrative description of the adverse event or protocol deviation, including clinical course, treatment, and outcome. Used for regulatory submissions and safety reviews.',
    `onset_date` DATE COMMENT 'Date when the adverse event or protocol deviation first occurred or was first observed.',
    `outcome` STRING COMMENT 'Final outcome of the adverse event: recovered/resolved, recovering/resolving, not recovered/not resolved, recovered with sequelae, fatal, or unknown.. Valid values are `recovered|recovering|not_recovered|recovered_with_sequelae|fatal|unknown`',
    `report_date` DATE COMMENT 'Date when the adverse event or protocol deviation was initially reported to the research team or entered into the safety database.',
    `reporter_role` STRING COMMENT 'Role or title of the individual who reported the adverse event or protocol deviation (e.g., principal investigator, study coordinator, research nurse).',
    `resolution_date` DATE COMMENT 'Date when the adverse event resolved or ended. Null if ongoing or fatal outcome.',
    `root_cause` STRING COMMENT 'Root cause analysis of the protocol deviation or quality event, identifying underlying factors that contributed to the occurrence.',
    `seriousness_criteria` STRING COMMENT 'Specific seriousness criteria met by the adverse event: death, life-threatening, hospitalization (initial or prolonged), disability/incapacity, congenital anomaly, or other medically important condition. Multiple criteria may apply.',
    `seriousness_flag` BOOLEAN COMMENT 'Indicates whether the adverse event meets regulatory criteria for seriousness (death, life-threatening, hospitalization, disability, congenital anomaly, or other medically important condition).',
    `severity_grade` STRING COMMENT 'Severity grade of the adverse event using CTCAE scale: Grade 1 (mild), Grade 2 (moderate), Grade 3 (severe), Grade 4 (life-threatening), Grade 5 (death).. Valid values are `grade_1|grade_2|grade_3|grade_4|grade_5`',
    `sponsor_report_date` DATE COMMENT 'Date when the adverse event or protocol deviation report was submitted to the study sponsor.',
    `sponsor_reportable_flag` BOOLEAN COMMENT 'Indicates whether this adverse event or protocol deviation requires reporting to the study sponsor per the clinical trial agreement.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this adverse event record in the system.',
    CONSTRAINT pk_adverse_event PRIMARY KEY(`adverse_event_id`)
) COMMENT 'Captures all safety events and quality events reported during a clinical trial or research study. Safety events: adverse events (AEs) and serious adverse events (SAEs) with AE term (MedDRA coded), onset/resolution dates, severity grade (CTCAE 1–5), seriousness criteria, causality assessment, action taken, outcome, and expedited reporting flag. Quality events: protocol deviations and violations with deviation description, category (eligibility, dosing, visit window, consent, data collection), severity (minor, major, important protocol deviation), discovery date, root cause, impact on subject safety and data integrity, corrective and preventive action (CAPA), and IRB/sponsor reportability determination. Supports FDA MedWatch, IND safety reporting (21 CFR 312.32), GCP compliance, quality management under ICH E6(R2), and regulatory inspection readiness. SSOT for all study safety events and quality events (including protocol deviations) within the research domain.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`investigational_product` (
    `investigational_product_id` BIGINT COMMENT 'Unique identifier for the investigational product record. Primary key.',
    `exclusion_screening_id` BIGINT COMMENT 'Foreign key linking to compliance.exclusion_screening. Business justification: Investigational product manufacturers/suppliers must be screened against exclusion lists (OIG, SAM, FDA debarment). Standard procurement compliance for federally funded research.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Investigational products (especially devices and biologics) are cataloged in material master for inventory management, expiration tracking, and lot control. Real business process: IP inventory account',
    `osha_safety_program_id` BIGINT COMMENT 'Foreign key linking to compliance.osha_safety_program. Business justification: Investigational products (hazardous drugs, devices, biologics) require OSHA safety programs (exposure control, hazard communication, PPE). Standard pharmaceutical safety compliance.',
    `research_study_id` BIGINT COMMENT 'add column research_research_study_id (BIGINT) with FK to research.research_study.research_study_id - investigational products are study-specific but lack a direct study FK',
    `accountability_required_flag` BOOLEAN COMMENT 'Indicates whether detailed product accountability records (receipt, dispensing, return, destruction) are required for regulatory compliance.',
    `adverse_event_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether adverse events related to this investigational product must be reported to regulatory authorities and IRB per safety monitoring requirements.',
    `approval_date` DATE COMMENT 'Date when the investigational product received regulatory approval (IND/IDE approval) to be used in clinical trials.',
    `blinding_status` STRING COMMENT 'Blinding or masking status of the investigational product in the clinical trial (open-label, single-blind, double-blind, triple-blind, or unblinded).. Valid values are `open_label|single_blind|double_blind|triple_blind|unblinded`',
    `brand_name` STRING COMMENT 'Proprietary or brand name of the investigational product, if assigned by the sponsor or manufacturer.',
    `comparator_indicator` BOOLEAN COMMENT 'Indicates whether this investigational product serves as an active comparator or control arm product in the clinical trial.',
    `controlled_substance_schedule` STRING COMMENT 'DEA controlled substance schedule classification if the investigational product contains controlled substances (Schedule I through V, or not controlled).. Valid values are `schedule_I|schedule_II|schedule_III|schedule_IV|schedule_V|not_controlled`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the investigational product record was first created in the system.',
    `data_governance_classification` STRING COMMENT 'Data governance classification level for investigational product data (e.g., identifiable, de-identified, limited dataset) per research data governance policies.',
    `discontinuation_date` DATE COMMENT 'Date when the investigational product was discontinued or withdrawn from clinical trial use, if applicable.',
    `dosage_form` STRING COMMENT 'Physical form of the investigational product (e.g., tablet, capsule, injection, solution, implant, topical cream).',
    `expiration_management_required_flag` BOOLEAN COMMENT 'Indicates whether expiration date tracking and management is required for this investigational product to ensure product integrity and subject safety.',
    `formulation` STRING COMMENT 'Detailed formulation description including active ingredients, excipients, and composition for drugs/biologics, or material composition for devices.',
    `generic_name` STRING COMMENT 'Generic or chemical name of the investigational product (e.g., active pharmaceutical ingredient name or device generic descriptor).',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the investigational product is classified as hazardous material requiring special handling, storage, and disposal procedures.',
    `ind_ide_number` STRING COMMENT 'FDA-assigned IND number for investigational drugs/biologics or IDE number for investigational devices. Required for clinical trial regulatory compliance.. Valid values are `^(IND|IDE)[0-9]{6,10}$`',
    `indication` STRING COMMENT 'Specific disease, condition, or indication for which the investigational product is being studied in the clinical trial.',
    `informed_consent_required_flag` BOOLEAN COMMENT 'Indicates whether informed consent is required from subjects before administration of this investigational product.',
    `irb_approval_required_flag` BOOLEAN COMMENT 'Indicates whether IRB approval is required for the use of this investigational product in the clinical trial.',
    `labeling_requirements` STRING COMMENT 'Specific labeling requirements for the investigational product including required statements, warnings, and identification information per regulatory standards.',
    `lot_tracking_required_flag` BOOLEAN COMMENT 'Indicates whether lot-level tracking and accountability is required for this investigational product per protocol and regulatory requirements.',
    `manufacturer_address` STRING COMMENT 'Physical address of the manufacturing facility where the investigational product is produced.',
    `manufacturer_name` STRING COMMENT 'Name of the manufacturer or supplier responsible for producing the investigational product.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the investigational product that do not fit in other structured fields.',
    `packaging_description` STRING COMMENT 'Description of the investigational product packaging including container type, closure system, and labeling specifications.',
    `phase` STRING COMMENT 'Phase of clinical development for the investigational product (Phase I, II, III, IV, or combined phases).. Valid values are `phase_I|phase_II|phase_III|phase_IV|phase_I_II|phase_II_III`',
    `placebo_indicator` BOOLEAN COMMENT 'Indicates whether this investigational product is a placebo (inactive control) used in the clinical trial.',
    `product_type` STRING COMMENT 'Classification of the investigational product: drug, biologic, medical device, combination product, placebo, or active comparator.. Valid values are `drug|biologic|device|combination_product|placebo|comparator`',
    `protocol_number` STRING COMMENT 'Unique protocol number or identifier for the clinical trial in which this investigational product is being studied.',
    `regulatory_status` STRING COMMENT 'Current regulatory status of the investigational product in the clinical trial program (active, inactive, withdrawn, suspended, or approved for marketing).. Valid values are `active|inactive|withdrawn|suspended|approved`',
    `research_billing_code` STRING COMMENT 'Billing code or charge code used for research billing compliance to distinguish investigational product costs from standard care costs.',
    `return_destruction_procedure` STRING COMMENT 'Documented procedure for returning unused investigational product to sponsor and/or destroying expired or unused product in compliance with regulations.',
    `route_of_administration` STRING COMMENT 'Method by which the investigational product is administered to subjects (e.g., oral, intravenous, subcutaneous, topical, implantable).',
    `shelf_life_months` STRING COMMENT 'Approved shelf life of the investigational product in months from date of manufacture, based on stability testing data.',
    `special_handling_instructions` STRING COMMENT 'Detailed instructions for special handling, preparation, administration, or disposal of the investigational product to ensure safety and efficacy.',
    `sponsor_name` STRING COMMENT 'Name of the organization or individual sponsoring the clinical trial and responsible for the investigational product.',
    `storage_requirements` STRING COMMENT 'Detailed storage conditions required for the investigational product (e.g., refrigerated 2-8°C, room temperature, protect from light, frozen).',
    `strength` STRING COMMENT 'Strength or concentration of the active ingredient(s) in the investigational product, including unit of measure (e.g., 50 mg, 10 mg/mL).',
    `temperature_monitoring_required_flag` BOOLEAN COMMENT 'Indicates whether continuous or periodic temperature monitoring is required during storage and transport of the investigational product.',
    `therapeutic_area` STRING COMMENT 'Primary therapeutic area or disease category that the investigational product is intended to treat (e.g., oncology, cardiology, neurology, infectious disease).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the investigational product record was last updated or modified.',
    CONSTRAINT pk_investigational_product PRIMARY KEY(`investigational_product_id`)
) COMMENT 'Master record for investigational drugs, biologics, or devices used in clinical trials. Captures IND/IDE number, NDC or device identifier, product name (generic and brand), formulation, dosage form, strength, manufacturer, lot number tracking flag, storage requirements, temperature monitoring requirements, expiration date management flag, blinding status (open-label, single-blind, double-blind), and comparator/placebo indicator. Supports FDA 21 CFR Part 312 (drugs) and 21 CFR Part 812 (devices) accountability requirements.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` (
    `ip_dispensation_id` BIGINT COMMENT 'Unique identifier for the investigational product dispensation record. Primary key.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Investigational products are dispensed at specific facility pharmacies. IP inventory management, accountability audits, temperature excursion tracking, and regulatory compliance all require facility-l',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Dispensing clinician is required for investigational product accountability (21 CFR 312.62), DEA compliance for controlled substances, and protocol adherence verification. Healthcare operations track ',
    `employee_id` BIGINT COMMENT 'Identifier of the pharmacist, research coordinator, or authorized personnel who dispensed the investigational product.',
    `inventory_location_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_location. Business justification: IP dispensation occurs from specific controlled inventory locations (research pharmacy, secure storage) requiring chain of custody, temperature monitoring, and regulatory accountability. Real business',
    `investigational_product_id` BIGINT COMMENT 'Foreign key linking to research.investigational_product. Business justification: IP dispensation records must reference the investigational_product master table. Currently has ip_name, ip_code (STRING) but no FK. Adding investigational_product_id FK allows removal of redundant nam',
    `research_study_id` BIGINT COMMENT 'Identifier of the clinical study under which this investigational product was dispensed.',
    `study_arm_id` BIGINT COMMENT 'Foreign key linking to research.study_arm. Business justification: IP dispensation is arm-specific (different arms receive different treatments). Currently has treatment_arm (STRING) but no FK to study_arm master. Adding study_arm_id FK allows removal of redundant tr',
    `study_site_id` BIGINT COMMENT 'Identifier of the research site where the dispensation occurred.',
    `subject_enrollment_id` BIGINT COMMENT 'Identifier of the enrolled research subject who received the investigational product. Protected health information under HIPAA.',
    `visit_id` BIGINT COMMENT 'Identifier of the study visit during which the investigational product was dispensed.',
    `accountability_status` STRING COMMENT 'The current status of investigational product accountability for this dispensation record (pending, reconciled, discrepancy, closed).. Valid values are `pending|reconciled|discrepancy|closed`',
    `administration_instructions` STRING COMMENT 'Instructions provided to the subject regarding how to administer or take the investigational product.',
    `blinding_status` STRING COMMENT 'Indicates whether the dispensation is blinded and to what degree (open, single-blind, double-blind, triple-blind).. Valid values are `open|single_blind|double_blind|triple_blind`',
    `chain_of_custody_signature` STRING COMMENT 'Electronic or physical signature capturing the chain of custody transfer from dispenser to subject.',
    `compliance_status` STRING COMMENT 'Indicates whether the subject was compliant with the investigational product administration instructions based on returned units and reported usage.. Valid values are `compliant|non_compliant|partial|not_assessed`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this investigational product dispensation record was first created in the system.',
    `discrepancy_notes` STRING COMMENT 'Notes documenting any discrepancies found during investigational product accountability reconciliation.',
    `dispensation_date` DATE COMMENT 'The date on which the investigational product was dispensed to the research subject.',
    `dispensation_notes` STRING COMMENT 'Additional notes or comments recorded by the dispenser regarding this investigational product dispensation event.',
    `dispensation_timestamp` TIMESTAMP COMMENT 'The precise date and time when the investigational product was dispensed to the research subject.',
    `dispensed_by_role` STRING COMMENT 'The role of the personnel who dispensed the investigational product (e.g., pharmacist, research coordinator).. Valid values are `pharmacist|research_coordinator|investigator|nurse|other`',
    `dose_level` STRING COMMENT 'The dose level or strength of the investigational product dispensed (e.g., 10mg, 50mg, placebo).',
    `expected_return_date` DATE COMMENT 'The date by which the subject is expected to return unused investigational product for accountability reconciliation.',
    `expiration_date` DATE COMMENT 'The expiration date of the investigational product lot dispensed. Critical for safety and accountability.',
    `informed_consent_date` DATE COMMENT 'The date on which the subject provided informed consent for the clinical trial, confirming eligibility for investigational product dispensation.',
    `irb_approval_number` STRING COMMENT 'The IRB approval number under which this investigational product dispensation is authorized.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this investigational product dispensation record is currently active or has been superseded or voided.',
    `kit_number` STRING COMMENT 'The unique kit number assigned to the investigational product package dispensed to the subject.',
    `lot_number` STRING COMMENT 'The manufacturing lot number of the investigational product dispensed. Critical for traceability and accountability.',
    `missed_doses` STRING COMMENT 'The number of doses the subject reported missing or not taking as instructed.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this investigational product dispensation record was last modified.',
    `protocol_number` STRING COMMENT 'The protocol number of the clinical trial under which this dispensation occurred. Business identifier for the study.',
    `quantity_dispensed` DECIMAL(18,2) COMMENT 'The quantity of investigational product dispensed to the subject (e.g., number of tablets, vials, or units).',
    `quantity_returned` DECIMAL(18,2) COMMENT 'The quantity of investigational product returned by the subject at the next visit or study close-out.',
    `quantity_unit` STRING COMMENT 'The unit of measure for the quantity dispensed (e.g., tablets, vials, ml). [ENUM-REF-CANDIDATE: tablets|capsules|vials|syringes|patches|units|ml|mg|grams — 9 candidates stripped; promote to reference product]',
    `randomization_number` STRING COMMENT 'The randomization number assigned to the subject that determines treatment assignment. Protected to maintain blinding.',
    `return_date` DATE COMMENT 'The actual date on which the subject returned unused investigational product.',
    `sponsor_name` STRING COMMENT 'The name of the organization sponsoring the clinical trial under which this investigational product was dispensed.',
    `storage_instructions` STRING COMMENT 'Instructions provided to the subject regarding proper storage conditions for the investigational product (e.g., refrigeration, room temperature).',
    `subject_number` STRING COMMENT 'The unique subject enrollment number assigned within the clinical trial. Protected health information under HIPAA.',
    `subject_signature_timestamp` TIMESTAMP COMMENT 'The timestamp when the subject signed to acknowledge receipt of the investigational product.',
    `temperature_at_dispensation` DECIMAL(18,2) COMMENT 'The temperature recorded at the time of dispensation if temperature-sensitive investigational product. Measured in Celsius.',
    CONSTRAINT pk_ip_dispensation PRIMARY KEY(`ip_dispensation_id`)
) COMMENT 'Transactional record of investigational product (IP) dispensation to an enrolled research subject at a study visit. Captures dispensation date, lot number, quantity dispensed, dose level, kit number, subject compliance (returned units, missed doses), pharmacist or coordinator dispensing, and chain-of-custody signature. Supports IP accountability logs required under FDA 21 CFR Part 312.62 and ICH E6(R2) Section 8.3. Enables drug accountability reconciliation at study close-out.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`biospecimen` (
    `biospecimen_id` BIGINT COMMENT 'Unique identifier for the biospecimen record. Primary key for the biospecimen data product.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Biospecimens are collected at specific facilities. Chain of custody documentation, specimen quality tracking, logistics coordination, and regulatory compliance require facility attribution. Critical f',
    `cda_document_id` BIGINT COMMENT 'Foreign key linking to interoperability.cda_document. Business justification: Biospecimen collection and processing documented in CDA documents for regulatory compliance and data sharing with biobanks/central labs. Required for chain of custody documentation and interoperabilit',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Collecting clinician is required for biospecimen chain of custody, protocol compliance verification, and specimen quality assurance. Healthcare operations track credentialed clinician for invasive col',
    `genetic_testing_consent_id` BIGINT COMMENT 'Foreign key linking to consent.genetic_testing_consent. Business justification: Biospecimen collection for genetic analysis requires specific genetic testing consent documenting GINA disclosures, family implications, and incidental findings preferences. Real business process: bio',
    `inventory_location_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_location. Business justification: Biospecimens are stored in specific inventory locations (freezers, biorepositories) tracked in supply chain systems for temperature monitoring, retrieval, and regulatory compliance. Real business proc',
    `lab_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_order. Business justification: Research biospecimen collection is often ordered through lab order system for operational workflow, scheduling, phlebotomy coordination, and billing. Links research protocol schedule to lab operationa',
    `mpi_record_id` BIGINT COMMENT 'Reference to the research subject from whom this biospecimen was collected. May be de-identified per protocol.',
    `parent_biospecimen_id` BIGINT COMMENT 'Reference to the parent biospecimen if this specimen is an aliquot or derivative of another specimen.',
    `procedure_event_id` BIGINT COMMENT 'Foreign key linking to clinical.procedure_event. Business justification: Biospecimen collection (biopsy, blood draw) is performed as clinical procedures; linking supports research vs clinical billing determination, procedure order reconciliation, and regulatory documentati',
    `research_study_id` BIGINT COMMENT 'Reference to the clinical research study protocol under which this biospecimen was collected.',
    `specimen_id` BIGINT COMMENT 'Foreign key linking to laboratory.specimen. Business justification: Research biospecimens are laboratory specimens with additional research metadata (consent, protocol, storage). Linking to lab specimen enables chain of custody, accession tracking, and integration wit',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Biospecimen types and anatomical sites are standardized using SNOMED CT for interoperability with biobanks, research data sharing, and regulatory submissions. Critical for NIH data sharing compliance ',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key linking to research.subject_enrollment. Business justification: Biospecimens are collected from enrolled research subjects. Currently has mpi_record_id but no FK to subject_enrollment. Adding subject_enrollment_id links the specimen to the specific study enrollmen',
    `visit_id` BIGINT COMMENT 'Reference to the specific study visit or encounter during which the biospecimen was collected.',
    `aliquot_number` STRING COMMENT 'Sequential number identifying this aliquot if the original specimen was divided into multiple aliquots.',
    `anatomical_site` STRING COMMENT 'Anatomical location or body site from which the specimen was collected (e.g., left arm, liver, lung, colon).',
    `barcode` STRING COMMENT 'Unique barcode or label identifier affixed to the physical specimen container for tracking and chain-of-custody purposes.',
    `box_position` STRING COMMENT 'Position of the specimen within the storage box (e.g., box identifier, grid position A1, B2).',
    `chain_of_custody_log` STRING COMMENT 'Detailed log or audit trail documenting all handling, transfers, and custody changes of the specimen to ensure integrity and traceability.',
    `collection_date` DATE COMMENT 'Date on which the biospecimen was collected from the research subject.',
    `collection_method` STRING COMMENT 'Method or procedure used to collect the specimen (e.g., venipuncture, biopsy, swab, catheterization, surgical excision).',
    `collection_time` TIMESTAMP COMMENT 'Precise date and time when the biospecimen was collected, critical for time-sensitive assays and stability tracking.',
    `collection_volume` DECIMAL(18,2) COMMENT 'Volume of the specimen collected, typically measured in milliliters (mL) for liquid specimens.',
    `collection_volume_unit` STRING COMMENT 'Unit of measure for the collection volume or quantity (e.g., mL, L, uL for liquids; g, mg for solids).. Valid values are `mL|L|uL|g|mg`',
    `comments` STRING COMMENT 'Additional free-text comments or notes regarding the biospecimen, its collection, processing, or any special handling requirements.',
    `consent_date` DATE COMMENT 'Date on which the research subject provided informed consent for specimen collection and use.',
    `consent_for_future_use` BOOLEAN COMMENT 'Indicates whether the research subject provided informed consent for future use of this specimen in additional research studies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this biospecimen record was first created in the system.',
    `deidentification_status` STRING COMMENT 'Indicates whether the specimen is identified, de-identified, anonymized, or coded per HIPAA and research protocol requirements.. Valid values are `identified|de_identified|anonymized|coded`',
    `disposition` STRING COMMENT 'Final disposition or outcome of the specimen (e.g., stored for future use, analyzed and depleted, destroyed per protocol, shipped to external lab, transferred to another study).. Valid values are `stored|analyzed|shipped|destroyed|depleted|transferred`',
    `disposition_date` DATE COMMENT 'Date on which the specimen reached its final disposition (e.g., date destroyed, date fully depleted, date transferred).',
    `processing_date` DATE COMMENT 'Date on which the specimen was processed or prepared for storage.',
    `processing_method` STRING COMMENT 'Method used to process the specimen after collection (e.g., centrifugation, aliquoting, fixation, freezing, RNA extraction).',
    `processing_time` TIMESTAMP COMMENT 'Precise date and time when specimen processing was completed.',
    `protocol_deviation_description` STRING COMMENT 'Detailed description of any protocol deviations that occurred, including corrective actions taken.',
    `protocol_deviation_flag` BOOLEAN COMMENT 'Indicates whether any protocol deviations occurred during specimen collection, processing, or storage.',
    `quality_notes` STRING COMMENT 'Free-text notes regarding specimen quality, integrity issues, or deviations from protocol during collection or processing.',
    `rack_position` STRING COMMENT 'Position of the specimen within the storage rack or shelf (e.g., rack number, shelf level).',
    `received_date` DATE COMMENT 'Date on which the specimen was received at the destination facility or laboratory after shipment.',
    `shipment_date` DATE COMMENT 'Date on which the specimen was shipped or transferred to another location or facility.',
    `shipment_tracking_number` STRING COMMENT 'Tracking number or waybill identifier for the shipment, used to trace the specimen during transport.',
    `shipped_to_facility` STRING COMMENT 'Name or identifier of the external facility, laboratory, or institution to which the specimen was shipped.',
    `specimen_quality` STRING COMMENT 'Assessment of the specimen quality based on visual inspection, integrity, and suitability for analysis (e.g., acceptable, marginal, unacceptable, compromised).. Valid values are `acceptable|marginal|unacceptable|compromised`',
    `specimen_status` STRING COMMENT 'Current lifecycle status of the specimen (e.g., collected, processed, stored, in analysis, analyzed, shipped, destroyed, depleted). [ENUM-REF-CANDIDATE: collected|processed|stored|in_analysis|analyzed|shipped|destroyed|depleted — 8 candidates stripped; promote to reference product]',
    `specimen_subtype` STRING COMMENT 'Further classification or subtype of the specimen (e.g., whole blood vs. EDTA plasma, fresh tissue vs. frozen tissue).',
    `specimen_type` STRING COMMENT 'Type of biological specimen collected. Common types include blood, serum, plasma, urine, saliva, tissue, biopsy, bone marrow, cerebrospinal fluid (CSF), and other biosamples. [ENUM-REF-CANDIDATE: blood|serum|plasma|urine|saliva|tissue|biopsy|bone_marrow|csf — 9 candidates stripped; promote to reference product]',
    `storage_container_type` STRING COMMENT 'Type of storage container or environment (e.g., freezer, refrigerator, liquid nitrogen tank, ambient storage, cryogenic storage).. Valid values are `freezer|refrigerator|liquid_nitrogen|ambient|cryogenic`',
    `storage_temperature` DECIMAL(18,2) COMMENT 'Temperature at which the specimen is stored, measured in degrees Celsius (e.g., -80, -20, 4, 25).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this biospecimen record was last updated or modified.',
    CONSTRAINT pk_biospecimen PRIMARY KEY(`biospecimen_id`)
) COMMENT 'Tracks biological specimens collected from research subjects as part of study protocols, including blood, tissue, urine, saliva, and other biosamples. Captures specimen type, collection date and time, collection site (anatomical), collection method, volume/quantity, processing method, storage location (biobank, freezer, rack, box, position), chain-of-custody, de-identification status, consent for future use, specimen disposition (analyzed, stored, destroyed, shipped), and shipping/transfer records. Supports biobanking operations, translational research specimen management, and specimen lifecycle tracking from collection through final disposition.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` (
    `data_safety_monitoring_id` BIGINT COMMENT 'Unique identifier for the data safety monitoring record. Primary key for this entity.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: DSMB activities are audited for independence, charter compliance, documentation quality, and unblinding procedures. Standard in FDA-regulated trials and institutional compliance reviews.',
    `compliance_regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: DSMB recommendations (study modifications, safety reports, stopping rules) trigger regulatory submissions to FDA/IRB. Standard safety reporting for monitored trials.',
    `dsmb_committee_id` BIGINT COMMENT 'Identifier of the Data Safety Monitoring Board or Data Monitoring Committee assigned to oversee this trial.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that created this data safety monitoring record.',
    `research_document_id` BIGINT COMMENT 'Identifier or reference to the formal DSMB meeting minutes document stored in the document management system.',
    `research_study_id` BIGINT COMMENT 'Identifier of the clinical trial or study protocol being monitored by the DSMB/DMC.',
    `adverse_events_reviewed` STRING COMMENT 'Total count of adverse events reviewed by the DSMB during this meeting.',
    `charter_version` STRING COMMENT 'Version identifier of the DSMB charter document in effect at the time of this meeting.',
    `confidentiality_level` STRING COMMENT 'Confidentiality classification of the DSMB meeting: open (sponsor present), closed (DSMB only), or partially closed (sponsor present for portions).. Valid values are `open|closed|partially_closed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this data safety monitoring record was first created in the system.',
    `data_lock_date` DATE COMMENT 'Date on which the clinical trial data was locked for this interim analysis and DSMB review.',
    `dsmb_recommendation` STRING COMMENT 'Formal recommendation issued by the DSMB: continue trial as planned, modify protocol, suspend enrollment, terminate trial, or increase monitoring frequency.. Valid values are `continue_as_planned|modify_protocol|suspend_enrollment|terminate_trial|increase_monitoring`',
    `fda_notification_date` DATE COMMENT 'Date on which the FDA was formally notified of the DSMB recommendation and any safety actions taken.',
    `fda_notification_required` BOOLEAN COMMENT 'Indicates whether the DSMB recommendation requires formal notification to the FDA under IND safety reporting requirements.',
    `implementation_action_taken` STRING COMMENT 'Description of the concrete actions taken by the sponsor to implement the DSMB recommendation (e.g., protocol amendment submitted, enrollment suspended, monitoring increased).',
    `implementation_date` DATE COMMENT 'Date on which the sponsors implementation actions were completed or became effective.',
    `interim_analysis_trigger` STRING COMMENT 'Description of the event or milestone that triggered the interim analysis (e.g., enrollment milestone, calendar-based, safety signal threshold).',
    `irb_notification_date` DATE COMMENT 'Date on which the IRB was formally notified of the DSMB recommendation and sponsor response.',
    `irb_notification_required` BOOLEAN COMMENT 'Indicates whether the DSMB recommendation and sponsor response require notification to the Institutional Review Board.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this data safety monitoring record was last modified.',
    `meeting_date` DATE COMMENT 'Date on which the Data Safety Monitoring Board meeting occurred to review trial safety data.',
    `meeting_number` STRING COMMENT 'Sequential or coded identifier for the DSMB meeting (e.g., DSMB-001, Meeting 3).',
    `meeting_type` STRING COMMENT 'Classification of the DSMB meeting: scheduled routine review, ad hoc safety review, interim analysis, final review, or emergency convening.. Valid values are `scheduled|ad_hoc|interim_analysis|final_review|emergency`',
    `monitoring_status` STRING COMMENT 'Current status of DSMB monitoring for this trial: active (ongoing), suspended (temporarily paused), completed (trial ended), or terminated (trial stopped early).. Valid values are `active|suspended|completed|terminated`',
    `next_review_scheduled_date` DATE COMMENT 'Scheduled date for the next DSMB review meeting as determined during this meeting.',
    `notes` STRING COMMENT 'Additional notes, observations, or context related to this DSMB meeting and safety monitoring activity.',
    `protocol_modification_required` BOOLEAN COMMENT 'Indicates whether the DSMB recommendation requires a formal protocol amendment.',
    `recommendation_rationale` STRING COMMENT 'Detailed rationale and clinical/statistical justification for the DSMB recommendation.',
    `record_status` STRING COMMENT 'Lifecycle status of this data safety monitoring record: draft (in preparation), final (approved), amended (revised after finalization), or archived (historical).. Valid values are `draft|final|amended|archived`',
    `safety_stopping_rule_evaluated` BOOLEAN COMMENT 'Indicates whether pre-defined safety stopping rules were formally evaluated during this DSMB meeting.',
    `serious_adverse_events_reviewed` STRING COMMENT 'Count of serious adverse events (SAEs) reviewed by the DSMB during this meeting.',
    `sponsor_response` STRING COMMENT 'Sponsors formal response to the DSMB recommendation: accepted, accepted with modifications, rejected, or under review.. Valid values are `accepted|accepted_with_modifications|rejected|under_review`',
    `sponsor_response_date` DATE COMMENT 'Date on which the sponsor formally responded to the DSMB recommendation.',
    `sponsor_response_rationale` STRING COMMENT 'Detailed explanation of the sponsors response, including justification for acceptance, modification, or rejection of the DSMB recommendation.',
    `statistical_report_document_code` STRING COMMENT 'Identifier or reference to the interim statistical analysis report reviewed by the DSMB.',
    `stopping_rule_threshold_met` BOOLEAN COMMENT 'Indicates whether any safety stopping rule threshold was met or exceeded during this review.',
    `subjects_completed_at_review` STRING COMMENT 'Number of subjects who had completed the study protocol at the time of this DSMB review.',
    `subjects_enrolled_at_review` STRING COMMENT 'Total number of subjects enrolled in the trial at the time of this DSMB review.',
    `unblinding_event_occurred` BOOLEAN COMMENT 'Indicates whether treatment assignment unblinding occurred during this DSMB meeting for interim analysis purposes.',
    `unblinding_justification` STRING COMMENT 'Business and regulatory justification for unblinding, including the safety or efficacy rationale.',
    `unblinding_scope` STRING COMMENT 'Scope of unblinding performed: none, partial (selected subjects), full (all subjects), or treatment arm only (aggregate level).. Valid values are `none|partial|full|treatment_arm_only`',
    CONSTRAINT pk_data_safety_monitoring PRIMARY KEY(`data_safety_monitoring_id`)
) COMMENT 'Records Data Safety Monitoring Board (DSMB) or Data Monitoring Committee (DMC) activities for a clinical trial, including meeting dates, interim analysis triggers, safety stopping rules, unblinding events, committee recommendations (continue, modify, suspend, terminate), sponsor responses, and implementation actions. Captures the formal oversight record required for Phase II–IV trials and FDA-regulated studies. Supports trial integrity and subject safety oversight.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`billing_event` (
    `billing_event_id` BIGINT COMMENT 'Unique identifier for the research billing event record. Primary key.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Research billing compliance (Medicare coverage analysis, protocol vs. standard-of-care determination) is heavily audited. CMS requires documentation of billing determinations for clinical trial servic',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Research billing is facility-specific. Coverage analysis implementation, revenue cycle management, payer contract compliance, and financial reconciliation all require facility-level billing event trac',
    `charge_id` BIGINT COMMENT 'Reference to the underlying charge record in the billing system for this service.',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Research billing events must link to submitted claims for revenue cycle reconciliation, sponsor invoicing verification, and payer adjudication tracking. Clinical trial billing requires tracking from c',
    `coverage_analysis_id` BIGINT COMMENT 'Reference to the formal coverage analysis document that determined billing responsibility for this service.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Research billing requires diagnosis codes to support medical necessity and coverage determination for study-related services. Essential for claims processing and billing compliance under clinical tria',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Research billing events must link to actual invoices to track billing outcomes, reconcile research vs standard-of-care charges, and validate coverage determinations. Critical for CMS clinical trial bi',
    `invoice_line_id` BIGINT COMMENT 'Foreign key linking to billing.invoice_line. Business justification: Research billing events require line-level detail to determine which specific service line items are research vs standard-of-care. Essential for CMS NCD 310.1 compliance and accurate coverage analysis',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Research billing events generate accounting journal entries for revenue recognition, compliance tracking, and financial reporting. Essential for clinical trial billing compliance, Medicare coverage an',
    `lab_charge_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_charge. Business justification: Coverage analysis requires linking research billing events to actual lab charges for standard-of-care vs research-only determination per Medicare NCD 310.1 and payer policies. Essential for compliant ',
    `claim_line_id` BIGINT COMMENT 'Foreign key linking to claim.claim_line. Business justification: Line-level linkage required for coverage analysis validation—verifying standard-of-care vs research-only service determinations match actual claim line adjudication. CMS clinical trial policy complian',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Research billing distinguishes standard-of-care items (billed to insurance) from investigational items (billed to sponsor). Material master provides item-level cost, NDC/HCPCS codes, and coverage dete',
    `member_enrollment_id` BIGINT COMMENT 'Foreign key linking to insurance.member_enrollment. Business justification: Research billing events must verify active member enrollment to determine coverage responsibility. The coverage_determination field requires real-time enrollment status, benefit verification, and coor',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient who received the research service.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Performing clinician resolves research billing coverage analysis (Medicare NCD 310.1) and charge reconciliation. Healthcare operations require credentialed clinician link to determine standard-of-care',
    `procedure_event_id` BIGINT COMMENT 'Foreign key linking to clinical.procedure_event. Business justification: Research billing events reference underlying clinical procedures to determine coverage per Medicare NCD 310.1 (routine costs vs research costs); linking enables clinical trial billing reconciliation a',
    `research_study_id` BIGINT COMMENT 'Reference to the clinical trial protocol under which this billing event occurred.',
    `stark_arrangement_id` BIGINT COMMENT 'Foreign key linking to compliance.stark_arrangement. Business justification: Research billing involving physician referrals must be evaluated for Stark Law compliance (DHS referrals, compensation arrangements, FMV). Required for Medicare billing compliance.',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key linking to research.subject_enrollment. Business justification: Research billing events are for services provided to enrolled subjects. Currently has mpi_record_id but no FK to subject_enrollment. Adding subject_enrollment_id links billing to the enrollment contex',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which the research service was provided.',
    `analysis_date` DATE COMMENT 'The date on which the coverage analysis was performed to determine billing responsibility for this service.',
    `analyst_name` STRING COMMENT 'The name of the research billing compliance analyst who performed the coverage determination for this service.',
    `approval_date` DATE COMMENT 'The date on which the coverage determination was formally approved, allowing the charge to proceed to billing.',
    `approval_status` STRING COMMENT 'The current approval status of the coverage determination: pending initial review, approved for billing, rejected, under secondary review, or escalated to compliance.. Valid values are `pending|approved|rejected|under_review|escalated`',
    `approver_name` STRING COMMENT 'The name of the compliance officer or authorized personnel who approved the coverage determination.',
    `audit_trail` STRING COMMENT 'Comprehensive audit trail capturing all changes to the coverage determination and billing status, including timestamps and user identifiers.',
    `billing_date` DATE COMMENT 'The date on which the charge was submitted for billing to the determined responsible party.',
    `billing_status` STRING COMMENT 'The current billing status of this research service: not yet billed, billed to sponsor, billed to insurance payer, billed to patient, absorbed by institution, on hold, or billing error. [ENUM-REF-CANDIDATE: not_billed|billed_to_sponsor|billed_to_payer|billed_to_patient|institutional_absorbed|billing_hold|billing_error — 7 candidates stripped; promote to reference product]',
    `charge_amount` DECIMAL(18,2) COMMENT 'The gross charge amount for the service as recorded in the charge description master, before coverage determination.',
    `clinical_trial_policy_number` STRING COMMENT 'The institutional policy or procedure number governing research billing compliance for this trial, ensuring adherence to CMS and OIG guidance.',
    `cms_ncd_reference` STRING COMMENT 'Reference to the specific CMS NCD (e.g., NCD 310.1) that governs Medicare coverage for this clinical trial service.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether this billing event has been flagged for compliance review due to potential false claims risk or policy violation.',
    `compliance_notes` STRING COMMENT 'Free-text notes documenting compliance review findings, escalations, or special handling instructions for this billing event.',
    `coverage_determination` STRING COMMENT 'The formal determination of billing responsibility for this service: sponsor-billable (research-specific), payer-billable (standard of care), institutional cost (absorbed), or patient responsibility. [ENUM-REF-CANDIDATE: sponsor_billable|medicare_billable|medicaid_billable|commercial_insurance_billable|institutional_cost|patient_responsibility|grant_funded — 7 candidates stripped; promote to reference product]',
    `cpt_code` STRING COMMENT 'The CPT code representing the procedure or service performed, used to determine billing responsibility.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this research billing event record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the charge amount. Typically USD for U.S. healthcare organizations.. Valid values are `USD`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'A calculated score (0-100) representing the completeness and accuracy of this billing event record, used for data governance and quality monitoring.',
    `department_code` STRING COMMENT 'The internal department or cost center code where the service was performed, used for financial reporting and cost allocation.',
    `determination_rationale` STRING COMMENT 'Detailed explanation of why this service was classified under the assigned coverage determination, referencing protocol requirements and payer policies.',
    `event_number` STRING COMMENT 'Human-readable business identifier for this research billing event, used for tracking and audit purposes.',
    `grant_number` STRING COMMENT 'The grant or contract number under which this research service is funded, used for financial reconciliation with sponsors.',
    `hcpcs_code` STRING COMMENT 'The HCPCS code for the service, used when CPT does not apply or for supplies and equipment.',
    `irb_approval_number` STRING COMMENT 'The IRB approval number under which this research service was conducted, ensuring ethical compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this research billing event record was last modified, used for audit and data lineage tracking.',
    `payer_specific_determination` STRING COMMENT 'Additional payer-specific coverage determination details, capturing nuances in Medicare, Medicaid, or commercial payer policies for research services.',
    `payer_type` STRING COMMENT 'The category of payer responsible for this service: Medicare, Medicaid, commercial insurance, sponsor, grant, institutional cost, or patient self-pay. [ENUM-REF-CANDIDATE: medicare|medicaid|commercial|self_pay|sponsor|grant|institutional — 7 candidates stripped; promote to reference product]',
    `principal_investigator_npi` STRING COMMENT 'The NPI of the principal investigator responsible for the clinical trial, used for research oversight and billing compliance.',
    `procedure_description` STRING COMMENT 'Textual description of the procedure or service performed, providing clinical context for the billing event.',
    `protocol_phase` STRING COMMENT 'The clinical trial phase designation at the time of service (e.g., Phase I, Phase II, Phase III, Phase IV).',
    `protocol_version` STRING COMMENT 'The version of the clinical trial protocol that was in effect at the time of service, used to ensure coverage analysis alignment.',
    `revenue_code` STRING COMMENT 'The UB-04 revenue code associated with this service, used for institutional billing and cost center allocation.',
    `service_date` DATE COMMENT 'The date on which the research-related clinical service was provided to the patient.',
    `service_timestamp` TIMESTAMP COMMENT 'The precise date and time when the research service was performed, used for detailed audit and reconciliation.',
    `sponsor_name` STRING COMMENT 'The name of the clinical trial sponsor (pharmaceutical company, academic institution, or government agency) responsible for funding research-specific costs.',
    `standard_of_care_flag` BOOLEAN COMMENT 'Indicates whether this service is considered standard of care (true) or research-specific (false) per the coverage analysis.',
    CONSTRAINT pk_billing_event PRIMARY KEY(`billing_event_id`)
) COMMENT 'Captures research billing compliance determinations, coverage analysis documents, and individual charge-level events for clinical trial services. Coverage analysis layer: records the formal determination of which protocol services are standard of care (insurance-billable) versus research-specific (sponsor/grant-billable), including protocol version analyzed, analysis date, analyst, payer-specific determinations (Medicare, Medicaid, commercial), CPT/HCPCS codes reviewed, determination rationale, and approval status. Charge event layer: captures service date, CPT/HCPCS code, charge amount, coverage determination (sponsor-billable, Medicare-billable, institutional cost), clinical trial policy number, and CMS NCD reference. Supports research billing compliance under CMS NCD 310.1 and OIG guidance to prevent false claims. SSOT for research billing compliance and coverage analysis within the research domain.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` (
    `grant_expenditure_id` BIGINT COMMENT 'Unique identifier for the grant expenditure transaction record.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Grant expenditures are audited for allowability, allocability, reasonableness, and compliance with federal cost principles (Uniform Guidance 2 CFR 200). Standard research administration compliance.',
    `capital_project_id` BIGINT COMMENT 'Reference to the research project or study protocol associated with this expenditure.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Grant expenditures often allocate to specific facilities for multi-site grants. Indirect cost allocation, facility-level financial reporting, grant compliance auditing, and cost center reconciliation ',
    `charge_id` BIGINT COMMENT 'Foreign key linking to billing.charge. Business justification: Grant expenditures for patient-oriented research must trace to specific patient charges to allocate costs correctly for NIH effort reporting, cost accounting, and grant compliance. Required for federa',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Grant expenditures must post to specific GL accounts for financial reporting and grant compliance. Currently has general_ledger_account as text. FK to chart_of_accounts enables proper financial integr',
    `research_grant_id` BIGINT COMMENT 'Reference to the research grant or contract against which this expenditure is charged.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or personnel member for whom salary or fringe benefit costs are charged, applicable only to personnel and fringe benefit expense categories.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Grant-funded research purchases require PO-level tracking for allowability, allocability, and audit compliance. Real business process: grant accounting, effort reporting, sponsor audit trails, and fed',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier from whom goods or services were purchased, applicable to supplies, equipment, subcontract, and other direct cost categories.',
    `accounting_period` STRING COMMENT 'The accounting period or month within the fiscal year when the expenditure was recorded.',
    `allocable_flag` BOOLEAN COMMENT 'Indicates whether the expenditure is allocable to the grant according to the benefit received by the project (True if allocable, False if not allocable).',
    `allowable_flag` BOOLEAN COMMENT 'Indicates whether the expenditure is allowable under the grant terms and federal cost principles (True if allowable, False if unallowable or questioned).',
    `amount` DECIMAL(18,2) COMMENT 'The monetary value of the expenditure transaction in the grants base currency.',
    `approval_date` DATE COMMENT 'The date on which the expenditure transaction was approved for posting to the grant.',
    `approval_status` STRING COMMENT 'The current approval status of the expenditure transaction in the financial workflow (pending, approved, rejected, or under review by grants management).. Valid values are `pending|approved|rejected|under_review`',
    `approved_by` STRING COMMENT 'The name or identifier of the individual who approved the expenditure transaction, typically a grants administrator or financial manager.',
    `audit_flag` BOOLEAN COMMENT 'Indicates whether this expenditure has been flagged for audit review or questioned cost analysis (True if flagged, False otherwise).',
    `audit_notes` STRING COMMENT 'Free-text notes or comments from auditors or compliance reviewers regarding the expenditure, including any questioned cost justifications.',
    `award_number` STRING COMMENT 'The sponsor-assigned award or grant number under which the expenditure is charged.',
    `budget_period` STRING COMMENT 'The grant budget period or project year during which the expenditure is charged (e.g., Year 1, Year 2, or specific date range for the budget period).',
    `cost_center` STRING COMMENT 'The organizational cost center or department code to which the expenditure is allocated, typically representing the principal investigators department or research unit.',
    `cost_share_amount` DECIMAL(18,2) COMMENT 'The portion of the expenditure amount that represents institutional cost sharing or matching funds, if applicable.',
    `cost_share_flag` BOOLEAN COMMENT 'Indicates whether this expenditure represents institutional cost sharing or matching funds committed to the grant (True if cost share, False if sponsor-funded).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the expenditure record was first created in the source system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the expenditure amount (e.g., USD for United States Dollar).. Valid values are `^[A-Z]{3}$`',
    `grant_expenditure_description` STRING COMMENT 'Detailed narrative description of the expenditure, including the purpose, justification, and business context for the charge.',
    `direct_cost_flag` BOOLEAN COMMENT 'Indicates whether the expenditure is a direct cost that can be specifically identified with the grant project (True) or an indirect cost allocated through the facilities and administrative rate (False).',
    `effort_percentage` DECIMAL(18,2) COMMENT 'For personnel costs, the percentage of an individuals total compensated effort devoted to this grant during the reporting period, used for effort certification and compliance.',
    `expense_category` STRING COMMENT 'Classification of the expenditure according to sponsor-required cost categories: personnel costs (salary and wages), fringe benefits, supplies, equipment, travel, subcontract costs, other direct costs, or indirect costs (facilities and administrative). [ENUM-REF-CANDIDATE: personnel|fringe_benefits|supplies|equipment|travel|subcontract|other_direct|indirect — 8 candidates stripped; promote to reference product]',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the expenditure was posted, used for annual financial reporting and budget reconciliation.',
    `fund_code` STRING COMMENT 'The fund or account code representing the source of funds for the expenditure, used in fund accounting for sponsored research.',
    `general_ledger_account` STRING COMMENT 'The general ledger account code to which the expenditure is posted in the financial system.',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'The facilities and administrative (F&A) indirect cost rate applied to the expenditure, expressed as a percentage, used to calculate indirect cost recovery.',
    `invoice_number` STRING COMMENT 'The vendor invoice number or billing document number associated with the expenditure transaction.',
    `modified_by` STRING COMMENT 'The name or identifier of the user who last modified the expenditure record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the expenditure record was last modified or updated in the source system.',
    `program_code` STRING COMMENT 'The program or functional area code associated with the expenditure, used for organizational reporting and cost allocation.',
    `reasonable_flag` BOOLEAN COMMENT 'Indicates whether the expenditure is reasonable in nature and amount for the performance of the grant (True if reasonable, False if questioned).',
    `source_system_code` STRING COMMENT 'The unique identifier or primary key of the expenditure transaction in the source financial system.',
    `sponsor_code` STRING COMMENT 'The code or identifier for the funding sponsor or agency (e.g., NIH, NSF, DOD, private foundation) that provided the grant.',
    `transaction_date` DATE COMMENT 'The date on which the expenditure transaction was posted or incurred in the financial system.',
    `transaction_number` STRING COMMENT 'Business identifier for the expenditure transaction, typically sourced from the financial system (SAP FI document number or Workday journal entry number).',
    CONSTRAINT pk_grant_expenditure PRIMARY KEY(`grant_expenditure_id`)
) COMMENT 'Transactional record of expenditures charged against a research grant or contract, including personnel costs (salary, fringe), supplies, equipment, subcontract costs, travel, and indirect costs. Captures transaction date, expense category, amount, budget period, cost center, effort percentage, and sponsor-required cost classification. Supports grant financial management, budget-to-actual reporting, and compliance with 2 CFR Part 200 (Uniform Guidance) cost principles. Enables NIH Just-In-Time and progress report financial sections.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` (
    `study_sponsor_id` BIGINT COMMENT 'Unique identifier for the study sponsor record. Primary key for the study sponsor entity.',
    `business_associate_agreement_id` BIGINT COMMENT 'Foreign key linking to compliance.business_associate_agreement. Business justification: External sponsors are business associates requiring BAAs when they receive PHI (subject identifiers, medical records). HIPAA compliance requirement for covered entities conducting research.',
    `conflict_of_interest_id` BIGINT COMMENT 'Foreign key linking to compliance.conflict_of_interest. Business justification: Sponsor relationships require COI disclosure and management (financial interests, consulting arrangements, equity). Standard research integrity and FDA financial disclosure requirements.',
    `research_study_id` BIGINT COMMENT 'add column research_research_study_id (BIGINT) with FK to research.research_study.research_study_id - study sponsors fund specific studies but study_sponsor lacks a direct study FK; it only has compliance FKs',
    `agreement_effective_date` DATE COMMENT 'Date on which the master agreement or clinical trial agreement with the sponsor became effective and binding.',
    `agreement_expiration_date` DATE COMMENT 'Date on which the master agreement with the sponsor expires or is scheduled for renewal. Nullable for evergreen agreements.',
    `budget_approval_date` DATE COMMENT 'Date on which the study budget was formally approved by both the sponsor and the institutions research finance office.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in the study budget (e.g., USD, EUR, GBP, CAD).. Valid values are `^[A-Z]{3}$`',
    `budget_version` STRING COMMENT 'Version identifier for the study budget terms negotiated with the sponsor. Increments with each budget amendment or renegotiation (e.g., v1.0, v2.0, v2.1).',
    `created_by_user` STRING COMMENT 'Username or identifier of the research administrator or system user who created the study sponsor record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the study sponsor record was first created in the research management system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `cro_relationship_type` STRING COMMENT 'Describes the sponsors relationship with Contract Research Organizations. Direct Sponsor: sponsor manages study directly without CRO; CRO Delegated: CRO manages study on behalf of sponsor; Hybrid: shared responsibilities between sponsor and CRO; Not Applicable: no CRO involvement.. Valid values are `direct_sponsor|cro_delegated|hybrid|not_applicable`',
    `duns_number` STRING COMMENT 'Nine-digit DUNS number assigned by Dun & Bradstreet to uniquely identify the sponsor organization. Required for federal grants and contracts.. Valid values are `^[0-9]{9}$`',
    `financial_disclosure_required_flag` BOOLEAN COMMENT 'Indicates whether the sponsor requires investigators to complete financial disclosure forms per FDA regulations (21 CFR Part 54) to identify potential financial conflicts of interest. True if required; False if not required.',
    `invoicing_contact_email` STRING COMMENT 'Email address for submitting invoices and payment inquiries to the sponsors finance department.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `invoicing_contact_name` STRING COMMENT 'Full name of the sponsors accounts payable or invoicing contact responsible for processing study-related invoices.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the research administrator or system user who last modified the study sponsor record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the study sponsor record was last updated or modified. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `master_agreement_reference` STRING COMMENT 'Reference number or identifier for the master clinical trial agreement (CTA) or master service agreement (MSA) governing the relationship between the sponsor and the institution. Links to institutional contract management system.',
    `nda_bla_holder_flag` BOOLEAN COMMENT 'Indicates whether the sponsor holds an NDA or BLA with the FDA for the investigational product. True if sponsor is the regulatory holder; False if sponsor is not the holder (e.g., academic sponsor using an IND from another entity).',
    `negotiated_cost_flag` BOOLEAN COMMENT 'Indicates whether the budget terms represent negotiated rates specific to this sponsor (True) or standard institutional rates (False). Used to distinguish custom sponsor agreements from standard fee schedules.',
    `overhead_indirect_cost_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied to direct study costs to cover institutional overhead and indirect costs (e.g., facilities, administration, compliance). Expressed as a percentage (e.g., 25.00 for 25%).',
    `payment_milestone_terms` STRING COMMENT 'Narrative description of payment milestones and triggers defined in the sponsor agreement (e.g., payment upon enrollment, payment upon visit completion, payment upon database lock). Free-text field capturing negotiated payment schedule terms.',
    `payment_schedule_frequency` STRING COMMENT 'Frequency at which the sponsor remits payments to the institution. Per Visit: payment after each completed visit; Monthly: consolidated monthly invoicing; Quarterly: quarterly invoicing cycle; Milestone Based: payments tied to specific study milestones; Study Completion: lump sum upon study closure.. Valid values are `per_visit|monthly|quarterly|milestone_based|study_completion`',
    `per_procedure_reimbursement_rate` DECIMAL(18,2) COMMENT 'Standard reimbursement amount paid by the sponsor for each protocol-specified procedure (e.g., lab test, imaging study, biopsy). Expressed in the currency specified in budget_currency_code.',
    `per_visit_reimbursement_rate` DECIMAL(18,2) COMMENT 'Standard reimbursement amount paid by the sponsor for each completed study visit per protocol. Expressed in the currency specified in budget_currency_code.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary sponsor contact for official study communications, protocol amendments, and regulatory correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person at the sponsor organization responsible for study coordination and communication with the institution.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the sponsor contact, including country code and extension if applicable.',
    `screen_failure_allowance_amount` DECIMAL(18,2) COMMENT 'Reimbursement amount paid by the sponsor for each patient who is screened but fails to meet eligibility criteria and is not enrolled. Expressed in the currency specified in budget_currency_code.',
    `sponsor_address_line1` STRING COMMENT 'First line of the sponsor organizations primary business address, typically including street number and name.',
    `sponsor_address_line2` STRING COMMENT 'Second line of the sponsor organizations address for suite, floor, building, or other secondary address details. Nullable.',
    `sponsor_city` STRING COMMENT 'City where the sponsor organization is headquartered or maintains its primary business address.',
    `sponsor_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the sponsors primary business location (e.g., USA, GBR, CAN, DEU).. Valid values are `^[A-Z]{3}$`',
    `sponsor_name` STRING COMMENT 'Full legal name of the entity sponsoring the clinical research study. May be a pharmaceutical company, biotechnology firm, medical device manufacturer, government agency, academic institution, or private foundation.',
    `sponsor_notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or institutional knowledge about the sponsor relationship, budget terms, or payment history. Used for operational context and institutional memory.',
    `sponsor_postal_code` STRING COMMENT 'Postal or ZIP code for the sponsors primary business address.',
    `sponsor_state_province` STRING COMMENT 'State, province, or region of the sponsors primary address. Use standard postal abbreviations (e.g., CA, NY, ON).',
    `sponsor_status` STRING COMMENT 'Current status of the sponsor relationship with the institution. Active: currently sponsoring studies; Inactive: no active studies but relationship maintained; Suspended: temporarily halted due to compliance or contractual issues; Terminated: relationship ended.. Valid values are `active|inactive|suspended|terminated`',
    `sponsor_type` STRING COMMENT 'Classification of the sponsor organization type. Pharmaceutical: drug manufacturer; Biotechnology: biotech firm; Medical Device: device manufacturer; Government: federal or state agency (e.g., NIH, CDC); Academic: university or research institution; Foundation: private or public foundation; CRO: Contract Research Organization acting as sponsor. [ENUM-REF-CANDIDATE: pharmaceutical|biotechnology|medical_device|government|academic|foundation|cro — 7 candidates stripped; promote to reference product]',
    `startup_cost_amount` DECIMAL(18,2) COMMENT 'One-time startup cost paid by the sponsor to cover site initiation activities, including IRB submission, staff training, regulatory document preparation, and site activation. Expressed in the currency specified in budget_currency_code.',
    `tax_identification_number` STRING COMMENT 'Tax identification number (TIN), Employer Identification Number (EIN), or equivalent tax identifier for the sponsor organization. Used for institutional tax reporting and compliance (e.g., 1099 reporting).',
    CONSTRAINT pk_study_sponsor PRIMARY KEY(`study_sponsor_id`)
) COMMENT 'Master record for entities sponsoring clinical research studies, including negotiated study budgets and financial terms. Sponsor level: captures sponsor name, type (pharma, biotech, device, government, foundation), NDA/BLA holder status, CRO relationship, contact information, agreement reference, and financial disclosure requirements. Budget level: captures per-visit and per-procedure reimbursement rates, startup costs, overhead/indirect costs, screen failure allowances, payment milestones, budget version, negotiated vs institutional costs, budget approval date, and payment schedule terms. Distinct from grant — sponsors may fund studies without formal grant mechanisms (e.g., industry-sponsored CTAs). Supports research finance, sponsor invoicing, and study budget management. SSOT for sponsor identity and study budget terms within the research domain.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` (
    `coverage_analysis_id` BIGINT COMMENT 'Unique identifier for the coverage analysis document. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Coverage analysts are institutional employees in research billing/compliance departments performing Medicare coverage determinations and routine-vs-research cost segregation. Required for workload tra',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry. Business justification: Coverage analysis must reference specific CDM entries to determine which charge master items are standard-of-care vs research-only. Required for protocol budget development, sponsor negotiations, and ',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Coverage analysis documents must align with institutional billing compliance policies and payer policies (Medicare NCDs, LCDs). Policy references are mandatory for billing compliance audits.',
    `compliance_regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Coverage analyses are submitted to payers and CMS for clinical trial policy determinations. Medicare NCD/LCD process requires formal submission and review.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Coverage determinations are plan-specific (not just payer-level). Different health plans from the same payer have different coverage policies for clinical trial services. Plan-level analysis is requir',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Coverage analyses determine which trial services are billable to specific payers versus sponsor-covered. Medicare/Medicaid/commercial payer-specific determinations are documented in coverage analysis ',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Coverage analysis documents map study procedures to CPT codes to distinguish standard-of-care from investigational services for billing and sponsor negotiations. Critical for research billing complian',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Coverage analysis references diagnosis codes to establish medical necessity and apply payer coverage policies for clinical trial services. Required for billing compliance and payer negotiations. Remov',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Coverage analysis includes HCPCS codes for investigational devices, drugs, and supplies to determine payer coverage and billing strategy. Essential for research billing compliance. Removes denormalize',
    `protocol_amendment_id` BIGINT COMMENT 'Foreign key linking to research.protocol_amendment. Business justification: Coverage analysis documents are versioned with protocol amendments. Currently has protocol_version (STRING) but no FK to protocol_amendment. Adding protocol_amendment_id as nullable FK enables trackin',
    `research_study_id` BIGINT COMMENT 'Foreign key reference to the clinical trial or research study for which this coverage analysis was performed.',
    `superseded_by_coverage_analysis_id` BIGINT COMMENT 'Foreign key reference to the coverage analysis document that supersedes this one, if applicable.',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_catalog. Business justification: Coverage analysis evaluates which lab tests in protocol are standard-of-care (billable to insurance) vs research-only (sponsor-covered). Must link to test catalog for CPT/HCPCS code mapping and payer ',
    `analysis_date` DATE COMMENT 'The date on which the coverage analysis was performed or completed.',
    `analysis_document_number` STRING COMMENT 'Formal document control number assigned to this coverage analysis for tracking and audit purposes.',
    `analysis_status` STRING COMMENT 'Current lifecycle status of the coverage analysis document.. Valid values are `draft|under_review|approved|rejected|superseded|archived`',
    `analyst_title` STRING COMMENT 'Job title or role of the analyst who performed the coverage analysis (e.g., Research Billing Analyst, Clinical Research Coordinator).',
    `approval_date` DATE COMMENT 'Date on which the coverage analysis was formally approved for use in research billing operations.',
    `approver_name` STRING COMMENT 'Full name of the individual who approved the coverage analysis (typically a compliance officer or research billing manager).',
    `clinical_trial_agreement_flag` BOOLEAN COMMENT 'Indicates whether a formal clinical trial agreement exists that specifies sponsor responsibility for certain costs.',
    `comments` STRING COMMENT 'Additional comments, notes, or special considerations related to the coverage analysis.',
    `commercial_coverage_determination` STRING COMMENT 'Overall commercial insurance coverage determination for services in the protocol.. Valid values are `standard_of_care|research_only|mixed|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this coverage analysis record was first created in the system.',
    `determination_rationale` STRING COMMENT 'Detailed rationale and justification for the coverage determinations made in this analysis, including references to payer policies, clinical guidelines, and regulatory requirements.',
    `effective_date` DATE COMMENT 'Date from which the coverage analysis determinations become effective for billing purposes.',
    `expiration_date` DATE COMMENT 'Date on which the coverage analysis expires or is superseded, requiring a new analysis.',
    `investigational_device_flag` BOOLEAN COMMENT 'Indicates whether the protocol involves an investigational device subject to FDA Investigational Device Exemption (IDE) regulations.',
    `investigational_drug_flag` BOOLEAN COMMENT 'Indicates whether the protocol involves an investigational drug subject to FDA Investigational New Drug (IND) regulations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this coverage analysis record was last modified.',
    `lcd_reference` STRING COMMENT 'Reference to applicable CMS Local Coverage Determination policies used in the analysis.',
    `medicaid_coverage_determination` STRING COMMENT 'Overall Medicaid coverage determination for services in the protocol.. Valid values are `standard_of_care|research_only|mixed|not_applicable`',
    `medicare_coverage_determination` STRING COMMENT 'Overall Medicare coverage determination for services in the protocol: standard of care (billable to Medicare), research only (billable to sponsor), or mixed.. Valid values are `standard_of_care|research_only|mixed|not_applicable`',
    `ncd_reference` STRING COMMENT 'Reference to applicable CMS National Coverage Determination policies used in the analysis (e.g., NCD 310.1 for routine costs in clinical trials).',
    `ndc_codes_reviewed` STRING COMMENT 'Comma-separated list of NDC codes for investigational or standard drugs reviewed in the coverage analysis.',
    `off_label_use_flag` BOOLEAN COMMENT 'Indicates whether the protocol involves off-label use of approved drugs or devices, which may affect coverage determinations.',
    `payer_policy_reference` STRING COMMENT 'Reference to specific commercial payer policies or medical policies used in the coverage determination.',
    `payer_type` STRING COMMENT 'Primary payer type for which this coverage analysis was performed. Multiple indicates analysis covers determinations for multiple payer types. [ENUM-REF-CANDIDATE: medicare|medicaid|commercial|self_pay|sponsor|grant|multiple — 7 candidates stripped; promote to reference product]',
    `protocol_number` STRING COMMENT 'The unique protocol identifier for the clinical trial being analyzed. May be institution-specific or sponsor-assigned.',
    `protocol_version` STRING COMMENT 'Version number or identifier of the protocol document that was analyzed for coverage determination.',
    `protocol_version_date` DATE COMMENT 'The effective date of the protocol version analyzed.',
    `research_only_services_count` STRING COMMENT 'Number of services or procedures in the protocol determined to be research-specific and billable to sponsor or grant.',
    `reviewer_name` STRING COMMENT 'Full name of the individual who reviewed and validated the coverage analysis.',
    `reviewer_title` STRING COMMENT 'Job title or role of the reviewer who validated the coverage analysis.',
    `routine_cost_coverage_flag` BOOLEAN COMMENT 'Indicates whether routine costs of care in the clinical trial are covered by Medicare per NCD 310.1.',
    `sponsor_coverage_commitment` STRING COMMENT 'Description of services or costs that the study sponsor has committed to cover per the clinical trial agreement.',
    `standard_of_care_services_count` STRING COMMENT 'Number of services or procedures in the protocol determined to be standard of care and billable to insurance.',
    CONSTRAINT pk_coverage_analysis PRIMARY KEY(`coverage_analysis_id`)
) COMMENT 'Formal coverage analysis (CA) document record that determines which services in a clinical trial protocol are standard of care (billable to insurance) versus research-specific (billable to sponsor/grant). Captures protocol version analyzed, analysis date, analyst, payer-specific determinations (Medicare, Medicaid, commercial), CPT/HCPCS codes reviewed, determination rationale, approval status, and effective date. Required for research billing compliance programs under CMS NCD 310.1. Distinct from research_billing_event which captures individual charge-level determinations.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` (
    `research_regulatory_submission_id` BIGINT COMMENT 'Unique identifier for the regulatory submission record. Primary key for the research regulatory submission entity.',
    `clinician_id` BIGINT COMMENT 'Foreign key reference to the principal investigator responsible for the research study associated with this regulatory submission.',
    `compliance_regulatory_submission_id` BIGINT COMMENT 'FK to SSOT owner compliance.compliance_regulatory_submission for the regulatory_submission entity.',
    `corrective_action_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action_plan. Business justification: Regulatory submission deficiencies (FDA 483s, IRB stipulations, warning letters) require CAPAs. Standard regulatory response and quality management.',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Regulatory submissions (IND/IDE/NDA) to FDA often include reimbursement strategy sections citing existing coverage policies for comparator treatments or standard-of-care components. This supports mark',
    `interface_channel_id` BIGINT COMMENT 'Foreign key linking to interoperability.interface_channel. Business justification: Regulatory submissions (IND, IDE, NDA, BLA) to FDA are transmitted via specific interface channels using eCTD format. Essential for tracking submission delivery status, acknowledgments, and troublesho',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the system user who prepared and submitted this regulatory submission on behalf of the organization.',
    `protocol_amendment_id` BIGINT COMMENT 'Foreign key linking to research.protocol_amendment. Business justification: Regulatory submissions to FDA/NIH can be for protocol amendments. Adding protocol_amendment_id as nullable FK enables tracking of amendment-specific regulatory submissions and agency responses.',
    `regulatory_change_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_change. Business justification: Regulatory submissions respond to or are triggered by regulatory changes (new guidance, rule updates, safety alerts). Essential tracking for compliance officers and regulatory affairs.',
    `research_study_id` BIGINT COMMENT 'Foreign key reference to the research study for which this regulatory submission is made.',
    `acknowledgment_date` DATE COMMENT 'The date on which the regulatory agency officially acknowledged receipt of the submission.',
    `action_due_date` DATE COMMENT 'The deadline date by which the required action or response must be submitted to the regulatory agency.',
    `action_required_description` STRING COMMENT 'Detailed description of the specific actions, responses, or additional information required by the regulatory agency following their review of the submission.',
    `action_required_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether additional action or response is required from the submitting organization following the agency review.',
    `agency_division` STRING COMMENT 'The specific division or office within the regulatory agency responsible for reviewing this submission (e.g., Center for Drug Evaluation and Research (CDER), Center for Biologics Evaluation and Research (CBER), Center for Devices and Radiological Health (CDRH)).',
    `agency_response_date` DATE COMMENT 'The date on which the regulatory agency provided an official response or determination regarding the submission.',
    `agency_response_letter` STRING COMMENT 'Reference identifier or document location for the official response letter or communication received from the regulatory agency regarding this submission.',
    `bla_number` STRING COMMENT 'The Biologics License Application (BLA) number assigned by the Food and Drug Administration (FDA) when seeking approval to market a biological product. Applicable for BLA submissions.',
    `cfr_part_11_compliant_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this submission was prepared and submitted in compliance with Food and Drug Administration (FDA) 21 Code of Federal Regulations (CFR) Part 11 electronic records and electronic signatures requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this regulatory submission record was first created in the system. Supports audit trail and compliance tracking.',
    `determination_outcome` STRING COMMENT 'The final determination or decision outcome provided by the regulatory agency in response to the submission (e.g., Approved, Approved with Conditions, Not Approved, Clinical Hold).. Valid values are `Approved|Approved with Conditions|Not Approved|Clinical Hold|Withdrawn|Pending`',
    `ectd_sequence_number` STRING COMMENT 'The sequence number assigned to this submission within the electronic Common Technical Document (eCTD) lifecycle. Used to track versions and amendments in electronic submissions.',
    `fda_regulated_device_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this submission involves a Food and Drug Administration (FDA) regulated medical device.',
    `fda_regulated_drug_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether this submission involves a Food and Drug Administration (FDA) regulated drug product.',
    `ide_number` STRING COMMENT 'The Investigational Device Exemption (IDE) number assigned by the Food and Drug Administration (FDA) for device studies. Applicable when submission type is related to device investigations.',
    `ind_number` STRING COMMENT 'The Investigational New Drug (IND) application number assigned by the Food and Drug Administration (FDA) for drug studies. Applicable when submission type is related to drug investigations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this regulatory submission record was most recently updated or modified in the system. Supports audit trail and compliance tracking.',
    `nct_number` STRING COMMENT 'The ClinicalTrials.gov identifier (NCT number) for the clinical trial associated with this regulatory submission. Provides public registry linkage.',
    `nda_number` STRING COMMENT 'The New Drug Application (NDA) number assigned by the Food and Drug Administration (FDA) when seeking approval to market a new drug. Applicable for NDA submissions.',
    `principal_investigator_name` STRING COMMENT 'The full name of the principal investigator responsible for the research study associated with this regulatory submission.',
    `principal_investigator_npi` STRING COMMENT 'The National Provider Identifier (NPI) of the principal investigator, a unique 10-digit identification number issued by the Centers for Medicare and Medicaid Services (CMS).',
    `protocol_number` STRING COMMENT 'The internal protocol number or identifier for the research study protocol associated with this regulatory submission.',
    `protocol_version` STRING COMMENT 'The version number or identifier of the research protocol that is the subject of this regulatory submission.',
    `regulatory_agency` STRING COMMENT 'The federal regulatory agency to which this submission was made (e.g., Food and Drug Administration (FDA), National Institutes of Health (NIH), Office for Human Research Protections (OHRP), Centers for Medicare and Medicaid Services (CMS), Drug Enforcement Administration (DEA)).. Valid values are `FDA|NIH|OHRP|CMS|DEA|Other`',
    `sponsor_organization` STRING COMMENT 'The name of the organization or entity serving as the sponsor for the research study and responsible for the regulatory submission.',
    `submission_contact_email` STRING COMMENT 'The email address of the primary contact person for this regulatory submission. Business-confidential organizational contact information.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `submission_contact_name` STRING COMMENT 'The name of the individual serving as the primary contact person for this regulatory submission.',
    `submission_contact_phone` STRING COMMENT 'The phone number of the primary contact person for this regulatory submission. Business-confidential organizational contact information.',
    `submission_date` DATE COMMENT 'The date on which the regulatory submission was officially submitted to the federal agency. Represents the principal business event timestamp for this transaction.',
    `submission_method` STRING COMMENT 'The method or format used to submit the regulatory documentation to the agency (e.g., electronic Common Technical Document (eCTD), paper submission, electronic gateway, agency portal).. Valid values are `eCTD|Paper|Electronic Gateway|Portal|Other`',
    `submission_notes` STRING COMMENT 'Free-text notes or comments regarding the regulatory submission, including internal tracking information, special circumstances, or additional context.',
    `submission_number` STRING COMMENT 'The official submission tracking number assigned by the submitting organization or regulatory agency. Serves as the business identifier for this submission.',
    `submission_status` STRING COMMENT 'Current lifecycle status of the regulatory submission indicating its position in the review and approval workflow. [ENUM-REF-CANDIDATE: Draft|Submitted|Under Review|Acknowledged|Approved|Rejected|Withdrawn|Action Required — 8 candidates stripped; promote to reference product]',
    `submission_type` STRING COMMENT 'The category of regulatory submission being made to the federal agency. Indicates the purpose and nature of the submission (e.g., Investigational New Drug (IND) Application, Investigational Device Exemption (IDE) Application, New Drug Application (NDA), Biologics License Application (BLA), Office for Human Research Protections (OHRP) Assurance Filing). [ENUM-REF-CANDIDATE: IND Application|IDE Application|IND Amendment|IDE Amendment|Annual Report|Safety Report|NDA Submission|BLA Submission|OHRP Assurance Filing — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_research_regulatory_submission PRIMARY KEY(`research_regulatory_submission_id`)
) COMMENT 'Tracks all regulatory submissions made to federal agencies (FDA, NIH, OHRP) in connection with a research study, including IND applications, IDE applications, IND amendments, annual reports, safety reports, NDA/BLA submissions, and OHRP assurance filings. Captures submission type, submission date, agency, submission number, submission method (eCTD, paper), acknowledgment date, agency response, and action required. Supports FDA 21 CFR Part 312 and Part 812 regulatory lifecycle management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` (
    `monitoring_visit_id` BIGINT COMMENT 'Unique identifier for the clinical trial monitoring visit record. Primary key.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Monitoring visits are audit activities (source data verification, GCP compliance checks, regulatory document review). Often referenced in FDA inspections and institutional compliance reviews.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Monitoring visits occur at specific facilities. Site audit trails, CAPA tracking, regulatory inspection preparation, and site performance evaluation require facility identification for each monitoring',
    `corrective_action_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action_plan. Business justification: Monitoring visit findings (protocol deviations, GCP violations, data discrepancies) require CAPAs when deficiencies are identified. Quality management and regulatory compliance linkage.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: When monitors are institutional employees (vs. external CRO staff), tracking their credentials, GCP training currency, time allocation, and visit workload is required for quality assurance and resourc',
    `research_study_id` BIGINT COMMENT 'Reference to the clinical trial or research study being monitored.',
    `study_site_id` BIGINT COMMENT 'Foreign key linking to research.study_site. Business justification: Monitoring visits are conducted at study sites. Currently has site_name, site_number (STRING) but no FK to study_site master. Adding study_site_id FK allows removal of redundant site identification co',
    `adverse_event_review_flag` BOOLEAN COMMENT 'Indicates whether Adverse Event (AE) and Serious Adverse Event (SAE) reporting and documentation were reviewed for timeliness and completeness.',
    `comments` STRING COMMENT 'Additional comments, observations, or contextual notes regarding the monitoring visit not captured in structured fields.',
    `corrective_action_plan_due_date` DATE COMMENT 'Date by which the site must submit a Corrective Action Plan (CAP) or Corrective and Preventive Action (CAPA) response to the sponsor or Contract Research Organization (CRO).',
    `corrective_action_plan_received_date` DATE COMMENT 'Date on which the site submitted the Corrective Action Plan (CAP) or Corrective and Preventive Action (CAPA) response.',
    `corrective_action_plan_required_flag` BOOLEAN COMMENT 'Indicates whether a formal Corrective Action Plan (CAP) or Corrective and Preventive Action (CAPA) is required from the site in response to findings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this monitoring visit record was first created in the system.',
    `data_discrepancies_noted_count` STRING COMMENT 'Number of data discrepancies or queries identified between case report forms and source documents during Source Data Verification (SDV).',
    `findings_summary` STRING COMMENT 'Narrative summary of key findings, observations, protocol deviations, and data discrepancies identified during the monitoring visit.',
    `follow_up_visit_required_flag` BOOLEAN COMMENT 'Indicates whether a follow-up monitoring visit is required to verify implementation of corrective actions or address outstanding issues.',
    `follow_up_visit_scheduled_date` DATE COMMENT 'Scheduled date for the follow-up monitoring visit to verify corrective action implementation.',
    `informed_consent_review_flag` BOOLEAN COMMENT 'Indicates whether informed consent documents were reviewed for completeness, signatures, and regulatory compliance during this visit.',
    `investigational_product_accountability_flag` BOOLEAN COMMENT 'Indicates whether investigational drug or device accountability records (receipt, dispensing, return, destruction logs) were reviewed and reconciled.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this monitoring visit record was last updated or modified.',
    `major_findings_count` STRING COMMENT 'Number of major findings or critical issues identified during the visit that pose significant risk to subject safety, data integrity, or regulatory compliance.',
    `minor_findings_count` STRING COMMENT 'Number of minor findings or observations identified during the visit that require attention but do not pose immediate risk.',
    `monitor_organization` STRING COMMENT 'Organization employing the monitor: sponsor, Contract Research Organization (CRO), or internal monitoring team.',
    `monitor_type` STRING COMMENT 'Classification of the monitor: sponsor representative, CRO monitor, internal institutional monitor, or independent auditor.. Valid values are `sponsor|cro|internal|independent`',
    `principal_investigator_name` STRING COMMENT 'Name of the Principal Investigator (PI) at the study site who was present or consulted during the monitoring visit.',
    `protocol_deviations_identified_count` STRING COMMENT 'Number of protocol deviations identified during the monitoring visit that require documentation and corrective action.',
    `regulatory_document_review_flag` BOOLEAN COMMENT 'Indicates whether regulatory documents (Institutional Review Board (IRB) approvals, Food and Drug Administration (FDA) Form 1572, curriculum vitae, licenses) were reviewed for currency and completeness.',
    `remote_monitoring_flag` BOOLEAN COMMENT 'Indicates whether this monitoring visit was conducted remotely (virtual) rather than on-site, using electronic systems and teleconference.',
    `risk_based_monitoring_flag` BOOLEAN COMMENT 'Indicates whether this visit was conducted under a Risk-Based Monitoring (RBM) approach with targeted review based on risk assessment.',
    `sdv_percentage` DECIMAL(18,2) COMMENT 'Percentage of data points or subjects for which Source Data Verification (SDV) was performed during this visit.',
    `site_coordinator_name` STRING COMMENT 'Name of the site research coordinator or study coordinator who assisted during the monitoring visit.',
    `source_data_verification_performed_flag` BOOLEAN COMMENT 'Indicates whether Source Data Verification (SDV) was performed during this monitoring visit to compare case report forms against source documents.',
    `subjects_enrolled_count` STRING COMMENT 'Number of subjects enrolled at the site at the time of the monitoring visit.',
    `subjects_reviewed_count` STRING COMMENT 'Number of subject records reviewed by the monitor during this visit for source data verification and compliance.',
    `visit_date` DATE COMMENT 'The date on which the monitoring visit was conducted at the study site.',
    `visit_end_time` TIMESTAMP COMMENT 'Timestamp when the monitoring visit concluded at the site.',
    `visit_number` STRING COMMENT 'Sequential or coded identifier for this monitoring visit within the study (e.g., MV-001, MV-002).',
    `visit_objectives` STRING COMMENT 'Documented objectives and scope of the monitoring visit, including specific areas of focus (e.g., informed consent review, source data verification, regulatory document review).',
    `visit_report_completion_date` DATE COMMENT 'Date on which the monitoring visit report was finalized and approved for distribution.',
    `visit_report_document_code` STRING COMMENT 'Unique document identifier or reference number for the monitoring visit report in the document management system.',
    `visit_report_status` STRING COMMENT 'Current status of the monitoring visit report document: draft, in review, finalized, approved, or distributed to stakeholders.. Valid values are `draft|in_review|finalized|approved|distributed`',
    `visit_start_time` TIMESTAMP COMMENT 'Timestamp when the monitoring visit commenced at the site.',
    `visit_status` STRING COMMENT 'Current lifecycle status of the monitoring visit: scheduled, in progress, completed, cancelled, or pending report finalization.. Valid values are `scheduled|in_progress|completed|cancelled|pending_report`',
    `visit_type` STRING COMMENT 'Classification of the monitoring visit: initiation (site activation), routine (scheduled periodic), interim (mid-study), close-out (study termination), for-cause (triggered by issue), or triggered (unscheduled).. Valid values are `initiation|routine|interim|close_out|for_cause|triggered`',
    CONSTRAINT pk_monitoring_visit PRIMARY KEY(`monitoring_visit_id`)
) COMMENT 'Records clinical trial monitoring visits conducted by sponsor representatives, CROs, or internal monitors at study sites. Captures visit type (initiation, routine, close-out, for-cause), visit date, monitor name, site visited, findings summary, protocol deviations identified, data discrepancies noted, corrective action plan (CAP) required flag, CAP due date, and visit report completion date. Supports ICH E6(R2) GCP monitoring requirements and sponsor oversight obligations.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` (
    `protocol_deviation_id` BIGINT COMMENT 'Unique identifier for the protocol deviation record. Primary key.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Protocol deviations discovered during audits become audit findings requiring corrective action. Direct operational link for quality management and regulatory compliance tracking.',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Protocol deviations are site-specific quality events. Site quality metrics, trend analysis, corrective action tracking, and regulatory reporting (IRB, sponsor) require facility attribution. Essential ',
    `corrective_action_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action_plan. Business justification: Protocol deviations require CAPAs when they impact subject safety or data integrity. Standard quality management and regulatory compliance for GCP adherence.',
    `deficiency_id` BIGINT COMMENT 'Foreign key linking to consent.consent_deficiency. Business justification: Protocol deviations frequently involve consent violations (enrollment without valid consent, reconsent not obtained after protocol amendment, capacity assessment missing). Root cause analysis links pr',
    `research_study_id` BIGINT COMMENT 'Foreign key reference to the research study in which this protocol deviation occurred.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Responsible clinician is tracked for protocol deviation root cause analysis, corrective action plans, and credentialing impact assessment. Healthcare operations require attribution to credentialed cli',
    `study_site_id` BIGINT COMMENT 'Foreign key reference to the clinical trial site where the deviation occurred.',
    `subject_enrollment_id` BIGINT COMMENT 'Foreign key reference to the subject enrollment record associated with this deviation, if applicable.',
    `audit_finding_flag` BOOLEAN COMMENT 'Indicates whether this protocol deviation was identified as a finding during an internal or external audit or regulatory inspection.',
    `capa_completion_date` DATE COMMENT 'The date on which the corrective and preventive actions were completed and verified.',
    `closure_date` DATE COMMENT 'The date on which the protocol deviation record was formally closed after all corrective and preventive actions were completed and verified.',
    `corrective_action` STRING COMMENT 'Description of the immediate corrective action taken to address the specific protocol deviation.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this protocol deviation record was first created in the system.',
    `data_lock_flag` BOOLEAN COMMENT 'Indicates whether this protocol deviation record has been locked for editing to preserve data integrity for regulatory submission or audit purposes.',
    `data_lock_timestamp` TIMESTAMP COMMENT 'The timestamp when this protocol deviation record was locked for editing, if applicable.',
    `detected_by_role` STRING COMMENT 'The role or title of the study personnel who detected or identified the protocol deviation (e.g., Clinical Research Coordinator, Principal Investigator, Monitor).',
    `deviation_category` STRING COMMENT 'Classification of the type of protocol deviation that occurred (e.g., eligibility, dosing, visit window, consent, data collection, inclusion/exclusion criteria).. Valid values are `eligibility|dosing|visit_window|consent|data_collection|inclusion_exclusion`',
    `deviation_date` DATE COMMENT 'The date on which the protocol deviation actually occurred.',
    `deviation_description` STRING COMMENT 'Detailed narrative description of the protocol deviation, including what occurred and the circumstances surrounding the event.',
    `deviation_notes` STRING COMMENT 'Additional free-text notes, comments, or observations related to the protocol deviation, its investigation, or resolution.',
    `deviation_number` STRING COMMENT 'Unique business identifier assigned to this protocol deviation for tracking and reporting purposes.',
    `deviation_severity` STRING COMMENT 'Severity classification of the protocol deviation: minor (no impact on subject safety or data integrity), major (potential impact), or critical (significant impact requiring immediate action).. Valid values are `minor|major|critical`',
    `deviation_status` STRING COMMENT 'Current lifecycle status of the protocol deviation record (e.g., open, under review, closed, pending corrective and preventive action).. Valid values are `open|under_review|closed|pending_capa`',
    `discovery_date` DATE COMMENT 'The date on which the protocol deviation was identified or discovered by study personnel.',
    `fda_report_date` DATE COMMENT 'The date on which the protocol deviation was reported to the Food and Drug Administration (FDA), if applicable.',
    `fda_reportable_flag` BOOLEAN COMMENT 'Indicates whether this protocol deviation meets the criteria for reporting to the Food and Drug Administration (FDA) under 21 CFR Part 312 or 21 CFR Part 812.',
    `gcp_compliance_impact` STRING COMMENT 'Assessment of the impact of this protocol deviation on overall Good Clinical Practice (GCP) compliance and regulatory inspection readiness.',
    `impact_on_data_integrity` STRING COMMENT 'Assessment of the actual or potential impact of the deviation on the reliability, validity, and integrity of the study data.',
    `impact_on_subject_safety` STRING COMMENT 'Assessment of the actual or potential impact of the deviation on the safety and well-being of the study subject.',
    `irb_report_date` DATE COMMENT 'The date on which the protocol deviation was reported to the Institutional Review Board (IRB), if applicable.',
    `irb_reportable_flag` BOOLEAN COMMENT 'Indicates whether this protocol deviation meets the criteria for reporting to the Institutional Review Board (IRB) per institutional policy and regulatory requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this protocol deviation record was last modified or updated in the system.',
    `monitoring_visit_number` STRING COMMENT 'The monitoring visit number during which the protocol deviation was identified, if detected during a monitoring visit.',
    `preventive_action` STRING COMMENT 'Description of the preventive action implemented to prevent recurrence of similar protocol deviations in the future.',
    `protocol_section_reference` STRING COMMENT 'Specific section, subsection, or clause of the protocol that was deviated from (e.g., Section 5.2.1).',
    `protocol_version` STRING COMMENT 'The version of the study protocol that was in effect at the time of the deviation.',
    `reported_date` DATE COMMENT 'The date on which the protocol deviation was formally reported to the appropriate parties (e.g., sponsor, IRB).',
    `review_date` DATE COMMENT 'The date on which the protocol deviation was formally reviewed and assessed by qualified study personnel.',
    `reviewed_by_name` STRING COMMENT 'The name of the individual who reviewed and assessed the protocol deviation (typically the Principal Investigator or Quality Assurance personnel).',
    `root_cause` STRING COMMENT 'Analysis of the underlying root cause that led to the protocol deviation (e.g., staff training gap, system error, patient non-compliance).',
    `sponsor_report_date` DATE COMMENT 'The date on which the protocol deviation was reported to the study sponsor, if applicable.',
    `sponsor_reportable_flag` BOOLEAN COMMENT 'Indicates whether this protocol deviation meets the criteria for reporting to the study sponsor per the clinical trial agreement and sponsor requirements.',
    CONSTRAINT pk_protocol_deviation PRIMARY KEY(`protocol_deviation_id`)
) COMMENT 'Documents protocol deviations and violations identified during a clinical trial, including the deviation description, deviation date, discovery date, deviation category (eligibility, dosing, visit window, consent, data collection), severity (minor, major, important protocol deviation), root cause, impact on subject safety and data integrity, corrective and preventive action (CAPA), and IRB/sponsor reportability determination. Supports GCP compliance, regulatory inspection readiness, and quality management under ICH E6(R2).';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` (
    `deidentified_dataset_id` BIGINT COMMENT 'Unique identifier for the de-identified research dataset record. Primary key for the dataset registry.',
    `business_associate_agreement_id` BIGINT COMMENT 'Foreign key linking to compliance.business_associate_agreement. Business justification: Deidentified dataset sharing with external parties may require BAAs if re-identification risk exists (limited datasets per HIPAA). Safe Harbor assessment determines BAA necessity.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Deidentified datasets must comply with institutional data governance policies, HIPAA Safe Harbor/Expert Determination policies, and data sharing policies. Policy compliance is mandatory for data stewa',
    `fhir_endpoint_id` BIGINT COMMENT 'Foreign key linking to interoperability.fhir_endpoint. Business justification: Deidentified research datasets published via FHIR endpoints for data sharing per NIH Data Sharing Policy and 21st Century Cures Act. Tracks which FHIR endpoint serves the dataset for access control an',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that created this dataset record.',
    `access_tier` STRING COMMENT 'The access classification tier indicating the level of de-identification and corresponding access restrictions (internal, limited dataset per HIPAA, fully de-identified, public, controlled access).. Valid values are `internal|limited_dataset|fully_deidentified|public|controlled_access`',
    `approved_use_cases` STRING COMMENT 'Description of the approved research use cases, purposes, or research questions for which this dataset may be accessed.',
    `cfr_part_11_compliant_flag` BOOLEAN COMMENT 'Indicates whether the dataset and its access controls meet FDA 21 CFR Part 11 requirements for electronic records and signatures, applicable to clinical trial data.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this de-identified dataset record was first created in the system.',
    `data_dictionary_url` STRING COMMENT 'URL or reference to the data dictionary or codebook documenting the structure, variables, and codes in the dataset.',
    `data_elements_included` STRING COMMENT 'Description or list of the data elements, fields, or variables included in the de-identified dataset.',
    `data_sharing_agreement_reference` STRING COMMENT 'Reference number or identifier for the master data sharing agreement or data use agreement template governing access to this dataset.',
    `data_steward_department` STRING COMMENT 'The department or organizational unit to which the data steward belongs.',
    `data_steward_email` STRING COMMENT 'Email address of the data steward for dataset inquiries and access requests.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `data_steward_name` STRING COMMENT 'Name of the individual or role responsible for the governance and oversight of this de-identified dataset.',
    `data_use_agreement_required_flag` BOOLEAN COMMENT 'Indicates whether a signed Data Use Agreement is required before granting access to this dataset.',
    `dataset_code` STRING COMMENT 'Unique business identifier or code assigned to the dataset for external reference and tracking.',
    `dataset_creation_date` DATE COMMENT 'The date when this version of the de-identified dataset was created or extracted from source systems.',
    `dataset_description` STRING COMMENT 'Detailed narrative description of the dataset content, purpose, population, and key characteristics for researchers and data governance.',
    `dataset_expiration_date` DATE COMMENT 'The date when this dataset version expires and should no longer be used for new access requests, requiring refresh or retirement.',
    `dataset_format` STRING COMMENT 'The file format or data structure format of the dataset (e.g., CSV, Parquet, SAS, FHIR, OMOP CDM).',
    `dataset_location_path` STRING COMMENT 'The file system path, cloud storage location, or repository URL where the de-identified dataset files are stored.',
    `dataset_name` STRING COMMENT 'Human-readable name or title of the de-identified dataset for identification and cataloging purposes.',
    `dataset_size_mb` DECIMAL(18,2) COMMENT 'The total size of the dataset in megabytes, useful for storage planning and access provisioning.',
    `dataset_status` STRING COMMENT 'Current lifecycle status of the de-identified dataset indicating its availability and governance state. [ENUM-REF-CANDIDATE: draft|under_review|approved|active|archived|retired|suspended — 7 candidates stripped; promote to reference product]',
    `dataset_type` STRING COMMENT 'Classification of the dataset based on its source and nature (e.g., clinical trial data, observational study, EHR-derived, claims-derived). [ENUM-REF-CANDIDATE: clinical_trial|observational_study|registry|biobank|genomic|imaging|ehr_derived|claims_derived — 8 candidates stripped; promote to reference product]',
    `dataset_version` STRING COMMENT 'Version number or identifier for this iteration of the dataset, supporting version control and lineage tracking.',
    `date_range_end` DATE COMMENT 'The latest date of data included in the dataset, defining the temporal coverage end boundary.',
    `date_range_start` DATE COMMENT 'The earliest date of data included in the dataset, defining the temporal coverage start boundary.',
    `deidentification_date` DATE COMMENT 'The date when the de-identification process was completed and certified for this dataset.',
    `deidentification_method` STRING COMMENT 'The method used to de-identify the dataset per HIPAA standards: Safe Harbor (removal of 18 identifiers), Expert Determination, or Limited Dataset approach.. Valid values are `safe_harbor|expert_determination|limited_dataset|statistical_deidentification|anonymization`',
    `deidentification_performed_by` STRING COMMENT 'Name or identifier of the individual or team who performed the de-identification process.',
    `expert_determination_certification_flag` BOOLEAN COMMENT 'Indicates whether the dataset received expert determination certification per HIPAA 45 CFR 164.514(b)(1).',
    `expert_name` STRING COMMENT 'Name of the qualified statistical expert who provided the expert determination certification, if applicable.',
    `hipaa_limited_dataset_flag` BOOLEAN COMMENT 'Indicates whether this dataset qualifies as a HIPAA Limited Dataset per 45 CFR 164.514(e), which retains certain date and geographic information.',
    `irb_waiver_date` DATE COMMENT 'The date the IRB waiver or exemption was granted for this dataset.',
    `irb_waiver_reference` STRING COMMENT 'Reference number or identifier for the IRB waiver or exemption determination that permits use of this de-identified dataset without individual consent.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords or tags for dataset discovery and cataloging (e.g., oncology, diabetes, cardiovascular, genomics).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this de-identified dataset record was last updated or modified.',
    `nih_data_sharing_compliant_flag` BOOLEAN COMMENT 'Indicates whether the dataset meets NIH data sharing policy requirements for federally funded research.',
    `patient_population_count` STRING COMMENT 'The number of unique de-identified patients or subjects included in the dataset.',
    `phi_elements_removed` STRING COMMENT 'Documentation of the 18 HIPAA identifiers or other PHI elements that were removed or transformed during de-identification.',
    `publication_embargo_date` DATE COMMENT 'The date until which the dataset or findings derived from it are under publication embargo, if applicable.',
    `record_count` STRING COMMENT 'The total number of records or observations included in the de-identified dataset.',
    `reidentification_risk_assessment_date` DATE COMMENT 'The date when the re-identification risk assessment was last performed for this dataset.',
    `reidentification_risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score (0-100) representing the assessed risk of re-identification for this dataset, as determined by statistical analysis or expert determination.',
    `restricted_use_cases` STRING COMMENT 'Description of use cases or purposes that are explicitly prohibited or restricted for this dataset.',
    `source_database` STRING COMMENT 'The specific database or data repository from which the dataset was extracted.',
    `therapeutic_area` STRING COMMENT 'The primary therapeutic area or clinical domain covered by the dataset (e.g., oncology, cardiology, neurology, infectious disease).',
    CONSTRAINT pk_deidentified_dataset PRIMARY KEY(`deidentified_dataset_id`)
) COMMENT 'Master record for de-identified research datasets, access request management, and data governance. Dataset level: captures dataset name, source systems, de-identification method (Safe Harbor, Expert Determination per HIPAA 45 CFR 164.514(b)), de-identification date, data steward, approved use cases, data sharing agreement reference, IRB waiver reference, data elements, date range, and access tier (internal, limited dataset, fully de-identified). Access request level: tracks requestor name/institution, intended use, IRB approval reference, DUA status, request submission date, review date, approval/denial decision, access dates, expiration, and data destruction certification. Supports research data governance, HIPAA compliance, de-identified data access management, and NIH data sharing policy enforcement. SSOT for research data governance and de-identified data access within the research domain.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`data_access_request` (
    `data_access_request_id` BIGINT COMMENT 'Unique identifier for the data access request. Primary key for the data access request entity.',
    `business_associate_agreement_id` BIGINT COMMENT 'Foreign key linking to compliance.business_associate_agreement. Business justification: Data access requestors from external institutions require BAAs before PHI release (even limited datasets). HIPAA requirement for covered entities sharing protected health information.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Data access requests are governed by institutional policies (data use agreements, IRB review requirements, data classification policies, HIPAA minimum necessary). Policy references are mandatory.',
    `data_governance_committee_id` BIGINT COMMENT 'Identifier of the data governance committee or review board that evaluated the data access request.',
    `deidentified_dataset_id` BIGINT COMMENT 'Foreign key linking to research.deidentified_dataset. Business justification: Data access requests reference specific de-identified datasets. Currently has dataset_requested, dataset_description (STRING) but no FK to deidentified_dataset master. Adding deidentified_dataset_id F',
    `dua_document_id` BIGINT COMMENT 'Identifier or reference number of the executed Data Use Agreement document stored in the document management system.',
    `fhir_endpoint_id` BIGINT COMMENT 'Foreign key linking to interoperability.fhir_endpoint. Business justification: Data access requests specify which FHIR endpoint will be used for approved data retrieval. Essential for provisioning access, monitoring usage, and enforcing data use agreement terms in research data ',
    `research_study_id` BIGINT COMMENT 'Identifier of the research study for which data access is requested. Links to the research study entity.',
    `access_expiration_date` DATE COMMENT 'Date on which the granted data access expires and the requestor must cease using the dataset and destroy or return all copies.',
    `access_granted_date` DATE COMMENT 'Date on which the requestor was provided with actual access to the requested dataset following approval.',
    `access_method` STRING COMMENT 'Technical method or mechanism through which the requestor is granted access to the dataset.. Valid values are `secure_portal|data_enclave|direct_download|physical_media|api_access`',
    `approver_name` STRING COMMENT 'Name of the individual with authority who provided final approval or denial of the data access request.',
    `conditions_of_approval` STRING COMMENT 'Specific conditions, restrictions, or requirements that must be met as part of the approval for data access.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the data access request record was first created in the system.',
    `data_classification_level` STRING COMMENT 'Classification of the requested data based on the level of identifiability and sensitivity, determining applicable privacy protections.. Valid values are `de_identified|limited_dataset|identified|phi`',
    `data_destruction_certification_date` DATE COMMENT 'Date on which the requestor certified that all copies of the dataset have been destroyed or returned in compliance with the Data Use Agreement.',
    `data_destruction_required_flag` BOOLEAN COMMENT 'Indicator of whether the requestor is required to destroy or return all copies of the dataset upon expiration of access or completion of research.',
    `denial_reason` STRING COMMENT 'Detailed explanation of the rationale for denying the data access request, including specific policy or regulatory concerns.',
    `determination_decision` STRING COMMENT 'Final decision outcome of the data access request review process, indicating whether access was granted or denied.. Valid values are `approved|denied|conditional_approval|withdrawn`',
    `dua_execution_date` DATE COMMENT 'Date on which the Data Use Agreement was fully executed by all parties, establishing the legal framework for data access.',
    `dua_expiration_date` DATE COMMENT 'Date on which the Data Use Agreement expires, after which data access must cease unless renewed.',
    `dua_status` STRING COMMENT 'Current status of the Data Use Agreement that governs the terms and conditions of data access and use.. Valid values are `not_required|pending|executed|expired|terminated`',
    `hipaa_compliance_verified_flag` BOOLEAN COMMENT 'Indicator of whether HIPAA compliance requirements have been verified and documented for this data access request.',
    `intended_use` STRING COMMENT 'Detailed description of the research purpose, analytical methods, and intended use of the requested dataset as stated by the requestor.',
    `irb_approval_date` DATE COMMENT 'Date on which the IRB approved or exempted the research protocol associated with this data access request.',
    `irb_approval_number` STRING COMMENT 'Reference number of the IRB approval or exemption determination that authorizes the proposed research use of the requested data.',
    `irb_expiration_date` DATE COMMENT 'Date on which the IRB approval expires, requiring renewal if data access extends beyond this date.',
    `irb_institution_name` STRING COMMENT 'Name of the institution whose IRB reviewed and approved the research protocol for this data access request.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the data access request record was last updated or modified in the system.',
    `nih_data_sharing_policy_compliant_flag` BOOLEAN COMMENT 'Indicator of whether the data access request and associated data sharing arrangements comply with NIH data sharing policy requirements.',
    `publication_acknowledgment_required_flag` BOOLEAN COMMENT 'Indicator of whether the requestor is required to acknowledge the data source in any publications or presentations resulting from use of the dataset.',
    `request_notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the data access request, review process, or approval conditions.',
    `request_number` STRING COMMENT 'Business identifier for the data access request, used for tracking and reference in communications and documentation.',
    `request_status` STRING COMMENT 'Current lifecycle status of the data access request in the review and approval workflow. [ENUM-REF-CANDIDATE: submitted|under_review|pending_irb|pending_dua|approved|denied|withdrawn|expired — 8 candidates stripped; promote to reference product]',
    `request_type` STRING COMMENT 'Classification of the data access request based on the requestor relationship to the organization.. Valid values are `internal|external|collaborative|commercial`',
    `requestor_department` STRING COMMENT 'Department or division within the requestor institution where the requestor is employed or affiliated.',
    `requestor_email` STRING COMMENT 'Primary email address of the requestor for communication regarding the data access request.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requestor_institution` STRING COMMENT 'Name of the academic institution, research organization, or company with which the requestor is affiliated.',
    `requestor_name` STRING COMMENT 'Full name of the individual researcher or analyst requesting access to the research dataset.',
    `requestor_title` STRING COMMENT 'Professional title or role of the requestor within their institution, such as Principal Investigator, Research Fellow, or Data Analyst.',
    `research_purpose_category` STRING COMMENT 'Categorical classification of the primary research purpose for which the data access is requested.. Valid values are `clinical_research|population_health|quality_improvement|health_services_research|educational|commercial`',
    `review_completion_date` DATE COMMENT 'Date on which the review process was completed and a determination decision was made regarding the data access request.',
    `review_start_date` DATE COMMENT 'Date on which the formal review process of the data access request began by the data governance committee or designated reviewers.',
    `reviewer_name` STRING COMMENT 'Name of the individual or committee member who conducted the primary review of the data access request.',
    `submission_date` DATE COMMENT 'Date on which the data access request was initially submitted by the requestor for review.',
    CONSTRAINT pk_data_access_request PRIMARY KEY(`data_access_request_id`)
) COMMENT 'Tracks requests by researchers, analysts, or external collaborators to access de-identified or limited research datasets. Captures requestor name and institution, requested dataset, intended use, IRB approval reference, data use agreement (DUA) status, request submission date, review date, approval/denial decision, access granted date, access expiration date, and data destruction certification requirement. Supports research data governance, HIPAA compliance, and NIH data sharing policy enforcement.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`study_budget` (
    `study_budget_id` BIGINT COMMENT 'Unique identifier for the study budget record. Primary key.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Study budgets are audited for allowable costs, effort reporting compliance, sponsor agreement adherence, and Uniform Guidance compliance. Standard in sponsored research administration.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Budget coordinators are institutional employees managing study finances, sponsor invoicing, and budget-to-actual reconciliation. Essential for effort reporting, grant compliance, and financial workloa',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: Study budgets are negotiated per site in multi-site trials. Site feasibility assessment, contract negotiation, financial planning, and budget-to-actual variance tracking require facility-level budget ',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry. Business justification: Study budgets reference specific CDM entries for per-procedure reimbursement rates negotiated with sponsors. Essential for clinical trial budget negotiation, feasibility analysis, and automated resear',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Study budgets are allocated to departmental cost centers for financial management, expense tracking, and budget control. Essential for departmental financial reporting, cost center budget variance ana',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Research study budgets are formal institutional budgets requiring approval, tracking, and variance analysis in the finance system. Required for institutional budget management, financial planning, spo',
    `research_study_id` BIGINT COMMENT 'Foreign key reference to the research study for which this budget was negotiated and approved.',
    `stark_arrangement_id` BIGINT COMMENT 'Foreign key linking to compliance.stark_arrangement. Business justification: Research budgets involving physician compensation must be evaluated for Stark compliance (FMV, commercial reasonableness, no volume/value referrals). Required for Medicare billing.',
    `study_sponsor_id` BIGINT COMMENT 'Foreign key linking to research.study_sponsor. Business justification: Study budgets reference the sponsor master table. Currently has sponsor_name, sponsor_type (STRING) but no FK to study_sponsor. Adding study_sponsor_id FK allows removal of redundant sponsor identific',
    `superseded_by_study_budget_id` BIGINT COMMENT 'Foreign key reference to the newer budget version that supersedes this record. Supports budget version history and audit trail.',
    `amendment_reason` STRING COMMENT 'Business justification for budget amendment or revision. Documents why budget was renegotiated or updated after initial approval.',
    `budget_approval_date` DATE COMMENT 'Date on which the study budget was formally approved by institutional finance and research administration. Marks transition to active status.',
    `budget_approved_by_name` STRING COMMENT 'Name of the institutional authority who approved this budget for execution. Typically research finance director or authorized signatory.',
    `budget_effective_date` DATE COMMENT 'Date from which the budget rates and terms become effective for billing and cost allocation purposes.',
    `budget_expiration_date` DATE COMMENT 'Date on which the budget terms expire or are superseded. May align with study completion or contract end date.',
    `budget_negotiated_by_name` STRING COMMENT 'Name of the institutional representative who negotiated this budget with the sponsor. Typically research administrator or grants manager.',
    `budget_status` STRING COMMENT 'Current lifecycle status of the study budget. Tracks progression from draft through approval to active use and eventual closure. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|amended|superseded|closed — 7 candidates stripped; promote to reference product]',
    `budget_type` STRING COMMENT 'Classification of the budget based on funding source and negotiation model. Distinguishes sponsor-negotiated rates from institutional cost recovery models.. Valid values are `sponsor_negotiated|institutional_cost|hybrid|investigator_initiated`',
    `budget_version_number` STRING COMMENT 'Version identifier for this budget iteration. Supports tracking of budget amendments and renegotiations over the study lifecycle.',
    `closeout_cost_amount` DECIMAL(18,2) COMMENT 'One-time costs for study closure activities including final data reconciliation, site closeout visits, archival, and final regulatory submissions.',
    `comments` STRING COMMENT 'Free-text field for additional notes, special terms, or clarifications regarding budget negotiation, approval conditions, or payment terms.',
    `contract_number` STRING COMMENT 'Unique identifier for the clinical trial agreement or contract under which this budget was negotiated. Links budget to legal agreement.',
    `coverage_analysis_required_flag` BOOLEAN COMMENT 'Indicates whether a Medicare/Medicaid coverage analysis is required to distinguish standard-of-care costs from research costs. Required for federally-funded or Medicare-eligible patient populations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was first created in the system. Supports audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this budget (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `enrollment_bonus_amount` DECIMAL(18,2) COMMENT 'Bonus payment amount per enrolled patient if enrollment targets are met. Incentivizes timely recruitment.',
    `holdback_percentage` DECIMAL(18,2) COMMENT 'Percentage of each payment withheld by sponsor until study completion or milestone achievement. Expressed as percentage (e.g., 10.00 for 10%).',
    `holdback_release_condition` STRING COMMENT 'Conditions under which withheld funds will be released to the institution. May include study completion, data lock, or final report submission.',
    `investigational_drug_cost_covered_flag` BOOLEAN COMMENT 'Indicates whether the sponsor covers the cost of investigational drug or device. If false, institution may be responsible for procurement costs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was last updated. Supports audit trail and change tracking.',
    `overhead_amount` DECIMAL(18,2) COMMENT 'Total overhead or indirect cost amount negotiated for the study. May be calculated as percentage of direct costs or negotiated as flat amount.',
    `overhead_rate_percentage` DECIMAL(18,2) COMMENT 'Institutional indirect cost rate applied to direct study costs. Covers facilities, administration, and institutional support. Expressed as percentage (e.g., 25.00 for 25%).',
    `payment_schedule_type` STRING COMMENT 'Defines the billing and payment frequency model. Determines when invoices are submitted and payments are expected from sponsor.. Valid values are `per_visit|per_procedure|milestone|monthly|quarterly`',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice submission to expected payment receipt. Standard terms are 30, 45, or 60 days net.',
    `per_patient_budget_amount` DECIMAL(18,2) COMMENT 'Total budget amount allocated per enrolled patient, including all visits and procedures. Used for enrollment-based budget projections.',
    `pharmacy_preparation_fee_amount` DECIMAL(18,2) COMMENT 'Per-dose or per-patient fee for institutional pharmacy preparation, compounding, and dispensing of investigational product. Covers pharmacy labor and overhead.',
    `principal_investigator_name` STRING COMMENT 'Name of the principal investigator responsible for the study. Budget is allocated to PIs department or cost center.',
    `research_only_cost_amount` DECIMAL(18,2) COMMENT 'Estimated total cost of research-only services required by the protocol but not part of standard care. Billable to sponsor, not to patient insurance.',
    `retention_bonus_amount` DECIMAL(18,2) COMMENT 'Bonus payment amount per patient who completes the study without early withdrawal. Incentivizes patient retention and protocol adherence.',
    `screen_failure_allowance_count` STRING COMMENT 'Number of screen failure patients for which the sponsor will reimburse screening costs. Accounts for patients who do not meet eligibility criteria.',
    `screen_failure_reimbursement_amount` DECIMAL(18,2) COMMENT 'Per-patient reimbursement amount for screen failures. Covers costs of screening procedures for patients who do not qualify for enrollment.',
    `standard_of_care_cost_amount` DECIMAL(18,2) COMMENT 'Estimated total cost of standard-of-care services that would be provided regardless of study participation. Not billable to sponsor; may be billed to insurance.',
    `startup_cost_amount` DECIMAL(18,2) COMMENT 'One-time costs for study initiation activities including site activation, training, regulatory submissions, and initial supplies. Billed prior to first patient enrollment.',
    `target_enrollment_count` STRING COMMENT 'Target number of patients to be enrolled at this site under this budget. Used for budget projections and milestone tracking.',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'Total negotiated budget amount for the entire study, including all per-visit costs, procedures, startup costs, and overhead. Represents maximum sponsor commitment.',
    CONSTRAINT pk_study_budget PRIMARY KEY(`study_budget_id`)
) COMMENT 'Captures the negotiated and approved budget for a sponsored clinical trial or research study, including per-visit reimbursement rates, per-procedure rates, startup costs, overhead/indirect costs, screen failure allowances, and payment milestones. Tracks budget version, sponsor-negotiated amounts versus institutional costs, budget approval date, and payment schedule terms. Distinct from grant_expenditure (actuals) — this is the prospective budget and rate card for the study. Supports research finance and sponsor invoicing.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`consent_template` (
    `consent_template_id` BIGINT COMMENT 'Unique identifier for the informed consent form template record. Primary key.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Consent templates must comply with institutional policies (IRB SOPs, HIPAA authorization requirements, vulnerable population protections, reading level standards). Policy compliance is audited.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created this consent template record. Supports audit trail and accountability.',
    `protocol_amendment_id` BIGINT COMMENT 'Foreign key linking to research.protocol_amendment. Business justification: Consent templates are updated with protocol amendments. Adding protocol_amendment_id as nullable FK enables tracking of amendment-specific consent form versions and reconsent requirements. Nullable as',
    `research_study_id` BIGINT COMMENT 'Reference to the clinical research study for which this consent template is approved. Links to the research_study product.',
    `superseded_by_consent_template_id` BIGINT COMMENT 'Reference to the newer consent template that replaced this version. Null if this is the current active version.',
    `training_id` BIGINT COMMENT 'Foreign key linking to compliance.training. Business justification: Consent template updates require staff retraining on new versions. Training completion is tracked per template version for regulatory compliance and IRB requirements.',
    `comments` STRING COMMENT 'Free-text comments or notes regarding this consent template version, such as rationale for changes, special instructions, or IRB feedback. Supports operational documentation.',
    `compensation_disclosure` STRING COMMENT 'Description of compensation or reimbursement provided to subjects for participation, as disclosed in the consent template. Required element per 21 CFR 50.25.',
    `contact_information` STRING COMMENT 'Contact information for the principal investigator, study coordinator, and IRB, as provided in the consent template. Required element per 21 CFR 50.25.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this consent template record was first created in the system. Audit trail field.',
    `data_sharing_consent_flag` BOOLEAN COMMENT 'Indicates whether this consent template includes permission for sharing de-identified data with external researchers or public repositories (e.g., ClinicalTrials.gov, dbGaP).',
    `effective_date` DATE COMMENT 'Date from which this consent template version becomes active and can be used for subject enrollment. May differ from IRB approval date if implementation is delayed.',
    `future_use_consent_flag` BOOLEAN COMMENT 'Indicates whether this consent template includes permission for future use of biospecimens or data in unspecified research. Important for biobanking and secondary research.',
    `genetic_testing_consent_flag` BOOLEAN COMMENT 'Indicates whether this consent template includes specific permission for genetic or genomic testing. Required when study involves genetic analysis.',
    `hipaa_authorization_included_flag` BOOLEAN COMMENT 'Indicates whether HIPAA authorization for use and disclosure of PHI is included in this consent template. Required for research involving PHI in the United States.',
    `injury_compensation_disclosure` STRING COMMENT 'Statement regarding availability of compensation or medical treatment for research-related injuries, as disclosed in the consent template. Required for studies with more than minimal risk.',
    `irb_approval_date` DATE COMMENT 'Date on which the IRB approved this consent template version. Marks the start of the templates validity period.',
    `irb_approval_number` STRING COMMENT 'Unique approval number assigned by the IRB for this consent template version. Required for regulatory compliance and audit trail.',
    `irb_expiration_date` DATE COMMENT 'Date on which the IRB approval for this consent template expires. After this date, the template cannot be used for new enrollments unless re-approved.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code for the consent template (e.g., EN for English, ES for Spanish, ZH for Chinese). Supports multilingual study sites.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this consent template record was last modified. Audit trail field.',
    `reading_level` STRING COMMENT 'Target reading level of the consent document, typically expressed as a grade level (e.g., 8th grade). FDA recommends 6th-8th grade reading level for informed consent documents.',
    `reconsent_required_flag` BOOLEAN COMMENT 'Indicates whether subjects who consented under a previous template version must be re-consented using this new version. True if protocol changes materially affect risk/benefit or subject rights.',
    `required_elements_checklist` STRING COMMENT 'Comma-separated list or structured checklist of required consent elements per 21 CFR 50.25 (e.g., purpose, procedures, risks, benefits, alternatives, confidentiality, voluntary participation, contact information). Used for compliance verification.',
    `superseded_date` DATE COMMENT 'Date on which this consent template version was replaced by a newer version. Null if the template is still active or has not been superseded.',
    `template_document_hash` STRING COMMENT 'Cryptographic hash (e.g., SHA-256) of the consent template document file. Ensures document integrity and supports 21 CFR Part 11 compliance for electronic records.',
    `template_document_url` STRING COMMENT 'URL or file path to the stored consent template document (PDF, Word, etc.). Used for document retrieval and audit trail.',
    `template_number` STRING COMMENT 'Business identifier for the consent template, typically assigned by the IRB or study sponsor. Externally-known unique code for this template version.',
    `template_status` STRING COMMENT 'Current lifecycle status of the consent template: draft (under development), irb_submitted (pending IRB review), irb_approved (approved but not yet active), active (currently in use for enrollment), superseded (replaced by newer version), expired (IRB approval lapsed), withdrawn (removed from use). [ENUM-REF-CANDIDATE: draft|irb_submitted|irb_approved|active|superseded|expired|withdrawn — 7 candidates stripped; promote to reference product]',
    `template_type` STRING COMMENT 'Type of informed consent document: full ICF (comprehensive consent), short form (abbreviated consent for emergency or limited literacy), assent form (for minors), HIPAA authorization (for PHI use), parental permission (for pediatric studies), or LAD form (legally authorized representative).. Valid values are `full_icf|short_form|assent_form|hipaa_authorization|parental_permission|lad_form`',
    `template_version` STRING COMMENT 'Version number of the consent template (e.g., 1.0, 2.1, 3.0). Incremented with each IRB-approved revision.',
    `vulnerable_population_flag` BOOLEAN COMMENT 'Indicates whether this consent template is designed for vulnerable populations (e.g., children, prisoners, pregnant women, cognitively impaired individuals). Requires additional IRB scrutiny and protections.',
    `vulnerable_population_type` STRING COMMENT 'Specific type of vulnerable population for which this consent template is designed. Null or none if not applicable.. Valid values are `children|prisoners|pregnant_women|cognitively_impaired|economically_disadvantaged|none`',
    CONSTRAINT pk_consent_template PRIMARY KEY(`consent_template_id`)
) COMMENT 'Reference master for IRB-approved informed consent form (ICF) templates associated with a study, capturing template version number, IRB approval date, expiration date, language version, consent form type (full ICF, short form, assent form, HIPAA authorization), required elements checklist, and template status (draft, IRB-approved, superseded). Distinct from informed_consent (the subject-level transactional record) — this is the document template/version master. Supports consent version control and ensures subjects are consented on the current IRB-approved version.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`study_arm` (
    `study_arm_id` BIGINT COMMENT 'Unique identifier for the study arm within the clinical trial protocol. Primary key.',
    `employee_id` BIGINT COMMENT 'The identifier of the user or system account that created this study arm record.',
    `research_study_id` BIGINT COMMENT 'Reference to the parent clinical trial or research study to which this arm belongs.',
    `actual_enrollment` STRING COMMENT 'The actual number of subjects enrolled in this arm to date.',
    `arm_close_date` DATE COMMENT 'The date this arm was closed to enrollment, either as planned or due to early termination.',
    `arm_name` STRING COMMENT 'The descriptive name of the study arm (e.g., High Dose Experimental, Placebo Control, Standard of Care).',
    `arm_notes` STRING COMMENT 'Additional free-text notes or comments about this arm, including operational considerations, protocol deviations, or special instructions.',
    `arm_number` STRING COMMENT 'The protocol-defined arm number or code (e.g., Arm 1, Arm A, Control) used to identify this arm within the study documentation.',
    `arm_open_date` DATE COMMENT 'The date this arm was opened for enrollment.',
    `arm_status` STRING COMMENT 'The current operational status of the arm: open (actively enrolling), closed (enrollment complete), suspended (temporarily paused), terminated (stopped early), or completed (all subjects finished treatment).. Valid values are `open|closed|suspended|terminated|completed`',
    `arm_suspension_date` DATE COMMENT 'The date this arm was suspended, if applicable.',
    `arm_suspension_reason` STRING COMMENT 'The reason for suspension of this arm (e.g., safety concern, enrollment challenges, sponsor decision).',
    `arm_termination_date` DATE COMMENT 'The date this arm was terminated early, if applicable.',
    `arm_termination_reason` STRING COMMENT 'The reason for early termination of this arm (e.g., futility, safety, efficacy demonstrated, sponsor decision).',
    `arm_type` STRING COMMENT 'The classification of the arm according to its role in the study: experimental (investigational intervention), active comparator (approved treatment), placebo comparator, sham comparator, no intervention, or observational.. Valid values are `experimental|active_comparator|placebo_comparator|sham_comparator|no_intervention|observational`',
    `blinding_status` STRING COMMENT 'The blinding or masking status for this arm: open label (no blinding), single blind (subject blinded), double blind (subject and investigator blinded), triple blind (subject, investigator, and outcomes assessor blinded), or quadruple blind (subject, investigator, outcomes assessor, and data analyst blinded).. Valid values are `open_label|single_blind|double_blind|triple_blind|quadruple_blind`',
    `concomitant_medication_restrictions` STRING COMMENT 'Any restrictions on concomitant medications or therapies for subjects in this arm, as specified in the protocol.',
    `control_arm_flag` BOOLEAN COMMENT 'Indicates whether this arm is the control or comparator arm in the study (True) or an experimental arm (False).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this study arm record was first created in the system.',
    `crossover_allowed_flag` BOOLEAN COMMENT 'Indicates whether subjects in this arm are permitted to cross over to another arm during the study (True) or not (False).',
    `crossover_trigger` STRING COMMENT 'The condition or event that triggers crossover from this arm to another (e.g., disease progression, lack of response, completion of initial treatment phase).',
    `data_lock_flag` BOOLEAN COMMENT 'Indicates whether this study arm record has been locked for regulatory or data integrity purposes (True) or remains editable (False).',
    `data_lock_timestamp` TIMESTAMP COMMENT 'The date and time when this study arm record was locked, if applicable.',
    `dose_level` STRING COMMENT 'The dose or dose range assigned to this arm (e.g., 10 mg daily, 50 mg twice daily, dose escalation cohort). Applicable for drug and biological interventions.',
    `dose_unit` STRING COMMENT 'The unit of measure for the dose (e.g., mg, mL, IU, mcg). Applicable for drug and biological interventions.',
    `dosing_frequency` STRING COMMENT 'The frequency of administration for this arm (e.g., once daily, twice daily, weekly, as needed).',
    `eligibility_criteria_notes` STRING COMMENT 'Any arm-specific inclusion or exclusion criteria that differ from the overall study eligibility criteria.',
    `intervention_description` STRING COMMENT 'Detailed description of the intervention, including formulation, route of administration, frequency, and duration as specified in the protocol.',
    `intervention_name` STRING COMMENT 'The name of the investigational product, device, procedure, or intervention being administered in this arm.',
    `intervention_type` STRING COMMENT 'The category of intervention being studied in this arm (e.g., drug, biological, device, procedure, behavioral, dietary supplement, radiation, genetic, diagnostic test). [ENUM-REF-CANDIDATE: drug|biological|device|procedure|behavioral|dietary_supplement|radiation|genetic|diagnostic_test|other — 10 candidates stripped; promote to reference product]',
    `irb_approval_number` STRING COMMENT 'The IRB approval number associated with this arm, if arm-specific IRB review was required.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this study arm record was last modified.',
    `planned_enrollment` STRING COMMENT 'The target number of subjects planned to be enrolled in this arm according to the protocol.',
    `primary_endpoint_measure` STRING COMMENT 'The primary outcome measure or endpoint being evaluated for this arm, as defined in the protocol.',
    `protocol_version` STRING COMMENT 'The version of the protocol under which this arm definition is current. Updated when protocol amendments affect arm specifications.',
    `protocol_version_date` DATE COMMENT 'The effective date of the protocol version referenced for this arm.',
    `randomization_ratio` STRING COMMENT 'The ratio of subjects to be randomized to this arm relative to other arms (e.g., 1:1, 2:1, 1:1:1). Applicable for randomized studies.',
    `record_status` STRING COMMENT 'The current status of this record in the system: active (current and in use), inactive (superseded but retained), archived (historical), or deleted (soft delete).. Valid values are `active|inactive|archived|deleted`',
    `route_of_administration` STRING COMMENT 'The route by which the intervention is administered (e.g., oral, intravenous, subcutaneous, intramuscular, topical, inhalation). [ENUM-REF-CANDIDATE: oral|intravenous|subcutaneous|intramuscular|topical|inhalation|transdermal|rectal|ophthalmic|otic|nasal|other — 12 candidates stripped; promote to reference product]',
    `safety_monitoring_plan` STRING COMMENT 'Description of any arm-specific safety monitoring requirements, including frequency of assessments, laboratory tests, or Data Safety Monitoring Board (DSMB) reviews.',
    `secondary_endpoint_measures` STRING COMMENT 'The secondary outcome measures or endpoints being evaluated for this arm. Comma-separated list.',
    `stratification_factors` STRING COMMENT 'The factors used to stratify randomization for this arm (e.g., age group, disease stage, prior therapy). Comma-separated list.',
    `treatment_duration` STRING COMMENT 'The planned duration of treatment for subjects in this arm (e.g., 12 weeks, 6 months, until disease progression).',
    CONSTRAINT pk_study_arm PRIMARY KEY(`study_arm_id`)
) COMMENT 'Defines the treatment arms, cohorts, or groups within a clinical trial protocol, including arm name, arm type (experimental, active comparator, placebo, sham, observational), planned enrollment per arm, randomization ratio, dose level or intervention description, and arm status (open, closed, suspended). Supports randomization management, stratified enrollment tracking, and protocol-defined subgroup analyses. A study may have 2–10+ arms; this entity provides the reference structure for subject_enrollment arm assignments.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` (
    `study_partner_agreement_id` BIGINT COMMENT 'Unique identifier for this study-partner agreement record. Primary key.',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to the research study that has engaged this trading partner for data exchange or services.',
    `trading_partner_id` BIGINT COMMENT 'Foreign key linking to the external trading partner organization participating in this research study.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this study-partner relationship is currently active. A study may have multiple partners over time, with some becoming inactive as the study progresses or completes certain phases.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this study-partner agreement record was created in the system.',
    `data_flow_direction` STRING COMMENT 'Indicates the direction of data flow for this study-partner relationship: inbound (partner sends data to institution), outbound (institution sends data to partner), or bidirectional.',
    `data_sharing_agreement_reference` STRING COMMENT 'Reference identifier or document number for the executed data sharing agreement specific to this study-partner relationship. Governs what data can be exchanged, for what purposes, and under what terms.',
    `effective_end_date` DATE COMMENT 'The date on which this study-partner agreement ended or is scheduled to end. May be null for ongoing relationships.',
    `effective_start_date` DATE COMMENT 'The date on which this study-partner agreement became effective and data exchange was authorized to begin.',
    `last_modified_by` STRING COMMENT 'User or system identifier that last modified this study-partner agreement record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this study-partner agreement record.',
    `message_volume_monthly` STRING COMMENT 'The average or expected monthly volume of messages (HL7, FHIR, CDA) exchanged between the institution and this trading partner for this specific study. Used for capacity planning and SLA monitoring.',
    `onboarding_date` DATE COMMENT 'The date on which this trading partner was onboarded and activated for data exchange with this specific research study.',
    `partner_role` STRING COMMENT 'The specific role this trading partner plays in this research study (e.g., sponsor CRO, central lab, imaging core, data coordinating center). A partner may have different roles in different studies.',
    `sla_response_time_hours` DECIMAL(18,2) COMMENT 'The service level agreement response time in hours for this study-partner relationship. Defines the maximum time allowed for the trading partner to acknowledge or respond to data requests or messages for this study.',
    `created_by` STRING COMMENT 'User or system identifier that created this study-partner agreement record.',
    CONSTRAINT pk_study_partner_agreement PRIMARY KEY(`study_partner_agreement_id`)
) COMMENT 'This association product represents the data sharing and interoperability agreement between a research study and an external trading partner. It captures the operational relationship when a trading partner (sponsor CRO, central lab, imaging core, data coordinating center) participates in a multi-site clinical trial. Each record links one research study to one trading partner with attributes that govern the data exchange, service level agreements, and operational status specific to that study-partner collaboration.. Existence Justification: Multi-site clinical trials operationally engage multiple external trading partners (sponsor CROs, central labs, imaging cores, data coordinating centers) for data exchange, lab services, and study coordination. Each research study has multiple trading partners serving different roles, and each trading partner supports multiple concurrent studies. The business actively manages these study-partner relationships with specific data sharing agreements, SLAs, message volume tracking, and role assignments per study-partner pair.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` (
    `grant_personnel_id` BIGINT COMMENT 'Primary key for the grant_personnel association',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the workforce member assigned to the grant',
    `research_grant_id` BIGINT COMMENT 'Foreign key linking to the research grant funding the personnel',
    `appointment_end_date` DATE COMMENT 'The date on which the employees appointment to this grant ends. May be earlier than the grant project end date if personnel leave the project or transition off.',
    `appointment_start_date` DATE COMMENT 'The date on which the employees appointment to this grant begins. May differ from the grant project start date if personnel are added mid-project.',
    `appointment_status` STRING COMMENT 'Current status of the personnel appointment on this grant. Active: currently working on grant. Pending: approved but not yet started. Completed: appointment period ended normally. Terminated: appointment ended early.',
    `budget_period` STRING COMMENT 'The specific budget period (typically Year 1, Year 2, etc.) within the grant project period to which this personnel assignment applies. Allows tracking of personnel changes across multi-year grants.',
    `cost_share_percentage` DECIMAL(18,2) COMMENT 'The percentage of the employees effort on this grant that is funded by institutional cost-share rather than direct grant funds. Required when the grant award includes mandatory or voluntary committed cost-share.',
    `effort_percentage` DECIMAL(18,2) COMMENT 'The percentage of the employees total professional effort (time and intellectual energy) devoted to this grant. Required for federal effort reporting and SF-424 compliance. Must sum to 100% across all grants and institutional commitments for each employee.',
    `fte_on_grant` DECIMAL(18,2) COMMENT 'The Full-Time Equivalent value representing the proportion of a full-time position devoted to this grant. Calculated from effort_percentage and the employees base FTE. Used for personnel cost calculations.',
    `key_personnel_flag` BOOLEAN COMMENT 'Indicates whether this employee is designated as key personnel on the grant, requiring sponsor approval for changes. Typically includes PI, Co-PIs, and other senior/key persons identified in the grant application.',
    `role` STRING COMMENT 'The specific role or position the employee holds on this grant (e.g., Principal Investigator, Co-Investigator, Research Coordinator). Required for NIH progress reports and sponsor reporting.',
    `salary_charged` DECIMAL(18,2) COMMENT 'The dollar amount of the employees salary and fringe benefits charged to this grant during the current budget period. Used for grant expenditure tracking and budget-to-actual reporting.',
    CONSTRAINT pk_grant_personnel PRIMARY KEY(`grant_personnel_id`)
) COMMENT 'This association product represents the personnel assignment relationship between employees and research grants. It captures effort allocation, salary distribution, and cost-share commitments required for federal effort reporting (SF-424, PHS 398), NIH/NSF grant administration, and OMB Uniform Guidance compliance. Each record links one employee to one grant with attributes that exist only in the context of this funding relationship, including role on the grant, effort percentage, appointment dates, and financial allocations.. Existence Justification: In healthcare research operations, employees (clinical staff, researchers, analysts) are routinely assigned to multiple concurrent grants with different effort allocations, roles, and salary distributions. Simultaneously, each grant funds multiple personnel including the PI, co-investigators, research coordinators, and support staff. Grant personnel assignments are actively managed operational records that research administrators create, update, and track for federal effort reporting, cost accounting, and compliance purposes.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` (
    `investigational_product_training_id` BIGINT COMMENT 'Primary key uniquely identifying this product-training certification record',
    `investigational_product_id` BIGINT COMMENT 'Foreign key linking to the investigational product requiring training certification',
    `training_id` BIGINT COMMENT 'Foreign key linking to the compliance training program required for this investigational product',
    `administration_competency_verified` BOOLEAN COMMENT 'Indicates whether competency to administer this specific investigational product has been verified through practical assessment or simulation. Required for products with complex administration procedures.',
    `certification_authority` STRING COMMENT 'Name or role of the individual who verified and certified competency for handling this investigational product (e.g., Principal Investigator, Clinical Research Coordinator, Pharmacy Director).',
    `effective_date` DATE COMMENT 'Date when this product-training requirement became effective. Used when new investigational products are added to trials or when training requirements change.',
    `expiration_date` DATE COMMENT 'Date when this product-training certification expires. May differ from recertification_due_date if product is discontinued or training requirements change.',
    `handling_certification_date` DATE COMMENT 'Date when staff member was certified to handle this specific investigational product after completing required training. Used for accountability and regulatory compliance per FDA 21 CFR Part 312/812.',
    `product_specific_training_status` STRING COMMENT 'Current status of training certification for this specific investigational product. Tracks whether staff member has completed required training for handling this particular product.',
    `recertification_due_date` DATE COMMENT 'Date by which staff member must complete recertification training for this investigational product. Calculated based on training frequency requirements and product-specific regulatory mandates.',
    `training_version` STRING COMMENT 'Version of the training program completed for this investigational product. Tracks which version of product-specific training materials the staff member was certified under, important when product formulation or handling procedures change.',
    CONSTRAINT pk_investigational_product_training PRIMARY KEY(`investigational_product_training_id`)
) COMMENT 'This association product represents the training certification relationship between investigational products and compliance training programs. It captures product-specific training requirements, competency verification, and certification status for staff handling investigational products in clinical trials. Each record links one investigational product to one training program with attributes tracking certification dates, competency verification, training version compliance, and recertification schedules specific to that product-training combination.. Existence Justification: In clinical trial operations, investigational products require multiple types of training (handling hazardous materials, administering complex dosage forms, storage/temperature monitoring, controlled substance protocols), and each training program applies to multiple investigational products with similar characteristics. The business actively manages product-specific training certifications as operational records, tracking which staff are certified to handle which products, with certification dates, competency verification, and recertification schedules that exist only in the context of each product-training combination.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`dua_document` (
    `dua_document_id` BIGINT COMMENT 'Primary key for dua_document',
    `employee_id` BIGINT COMMENT 'Identifier of the principal investigator responsible for the research study associated with this data use agreement.',
    `hie_organization_id` BIGINT COMMENT 'Identifier of the external organization or institution requesting access to healthcare data under this agreement.',
    `parent_dua_document_id` BIGINT COMMENT 'Identifier of the parent DUA document if this is an amendment, renewal, or addendum to an existing agreement.',
    `primary_superseded_dua_document_id` BIGINT COMMENT 'Self-referencing FK on dua_document (superseded_dua_document_id)',
    `audit_rights_description` STRING COMMENT 'Description of Healthcares audit rights to verify recipient compliance with the terms of the data use agreement.',
    `breach_notification_required_flag` BOOLEAN COMMENT 'Indicates whether the recipient is required to notify Healthcare of any data breach or unauthorized disclosure.',
    `compliance_review_date` DATE COMMENT 'Date of the most recent compliance review or audit of the recipients adherence to the data use agreement terms.',
    `compliance_status` STRING COMMENT 'Current compliance status of the recipient organization based on audits and monitoring activities.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the data use agreement record was first created in the system.',
    `data_classification_level` STRING COMMENT 'Classification level of the data being shared under this agreement, indicating sensitivity and required protection controls.',
    `data_destruction_deadline_date` DATE COMMENT 'Date by which the recipient must destroy or return the data if data destruction is required.',
    `data_destruction_required_flag` BOOLEAN COMMENT 'Indicates whether the recipient is required to destroy or return the data upon completion of the research or expiration of the agreement.',
    `data_security_requirements` STRING COMMENT 'Specific data security and protection requirements that the recipient must implement, including encryption, access controls, and audit logging.',
    `data_type` STRING COMMENT 'Type of data being shared indicating the level of identifiability: identified PHI, limited dataset, de-identified, aggregated, or fully anonymized.',
    `document_storage_location` STRING COMMENT 'File path or storage location reference for the signed physical or electronic copy of the data use agreement document.',
    `document_type` STRING COMMENT 'Classification of the DUA document type indicating whether it is a standard template, custom agreement, amendment, renewal, addendum, or master agreement.',
    `document_version_number` STRING COMMENT 'Version number of the data use agreement document, tracking revisions and amendments.',
    `dua_number` STRING COMMENT 'Business identifier for the data use agreement, externally referenced in research protocols and IRB submissions.',
    `effective_date` DATE COMMENT 'Date when the data use agreement becomes legally binding and data sharing may commence.',
    `expiration_date` DATE COMMENT 'Date when the data use agreement terminates and data sharing authorization ends. Nullable for agreements without fixed end dates.',
    `healthcare_signatory_name` STRING COMMENT 'Full name of the Healthcare authorized representative who signed the agreement on behalf of the organization.',
    `healthcare_signatory_title` STRING COMMENT 'Job title or role of the Healthcare authorized representative who signed the agreement.',
    `irb_approval_date` DATE COMMENT 'Date when the IRB approved the research protocol associated with this data use agreement.',
    `irb_protocol_number` STRING COMMENT 'IRB protocol number associated with the research study for which data access is being granted.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the data use agreement record was last updated or modified in the system.',
    `notes` STRING COMMENT 'Additional notes, comments, or special conditions related to the data use agreement not captured in other structured fields.',
    `permitted_use_description` STRING COMMENT 'Detailed description of the permitted uses of the data as specified in the agreement, including research objectives and scope.',
    `principal_investigator_email` STRING COMMENT 'Primary email address of the principal investigator for correspondence regarding the data use agreement.',
    `principal_investigator_name` STRING COMMENT 'Full name of the principal investigator leading the research study.',
    `prohibited_use_description` STRING COMMENT 'Description of prohibited uses of the data, including restrictions on re-identification, commercial use, or sharing with third parties.',
    `publication_rights_description` STRING COMMENT 'Description of publication rights and requirements, including manuscript review, co-authorship, and acknowledgment obligations.',
    `recipient_signatory_name` STRING COMMENT 'Full name of the authorized representative from the requesting organization who signed the agreement.',
    `recipient_signatory_title` STRING COMMENT 'Job title or role of the authorized representative from the requesting organization who signed the agreement.',
    `renewal_count` STRING COMMENT 'Number of times this data use agreement has been renewed, tracking the history of the relationship.',
    `signed_date` DATE COMMENT 'Date when all parties signed the data use agreement, making it legally binding.',
    `dua_document_status` STRING COMMENT 'Current lifecycle status of the data use agreement indicating its operational state.',
    `termination_date` DATE COMMENT 'Actual date when the data use agreement was terminated, if terminated before the scheduled expiration date.',
    `termination_reason` STRING COMMENT 'Reason for early termination of the data use agreement if terminated before the expiration date.',
    `title` STRING COMMENT 'Full title of the data use agreement document describing the scope and purpose of data sharing.',
    CONSTRAINT pk_dua_document PRIMARY KEY(`dua_document_id`)
) COMMENT 'Master reference table for dua_document. Referenced by dua_document_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` (
    `data_governance_committee_id` BIGINT COMMENT 'Primary key for data_governance_committee',
    `employee_id` BIGINT COMMENT 'Reference to the individual serving as the committee chairperson.',
    `data_escalation_committee_id` BIGINT COMMENT 'Reference to the committee to which unresolved issues or decisions are escalated.',
    `data_reporting_to_committee_id` BIGINT COMMENT 'Reference to the higher-level committee to which this committee reports in the governance hierarchy.',
    `data_secretary_person_employee_id` BIGINT COMMENT 'Reference to the individual serving as the committee secretary responsible for meeting documentation and administrative support.',
    `data_vice_chair_person_employee_id` BIGINT COMMENT 'Reference to the individual serving as the committee vice chairperson.',
    `care_site_id` BIGINT COMMENT 'add column facility_care_site_id (BIGINT) with FK to facility.care_site.care_site_id - data governance committees operate within specific institutions but lack a facility FK',
    `parent_committee_id` BIGINT COMMENT 'Reference to the parent committee in a hierarchical governance structure, if applicable.',
    `parent_data_governance_committee_id` BIGINT COMMENT 'Self-referencing FK on data_governance_committee (parent_data_governance_committee_id)',
    `authority_level` STRING COMMENT 'Level of decision-making authority granted to the committee within the governance hierarchy.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Annual budget allocated to the committee for operations, initiatives, and resources.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget amount.',
    `charter_description` STRING COMMENT 'Detailed description of the committees charter, mission, scope, and responsibilities within the data governance framework.',
    `charter_effective_date` DATE COMMENT 'Date when the current committee charter became effective.',
    `charter_expiration_date` DATE COMMENT 'Date when the current committee charter expires and requires renewal or revision.',
    `committee_code` STRING COMMENT 'Short alphanumeric code used to identify the committee in operational systems and reporting.',
    `committee_name` STRING COMMENT 'Official name of the data governance committee.',
    `committee_type` STRING COMMENT 'Classification of the committee based on its function and authority level within the governance structure.',
    `contact_email` STRING COMMENT 'Primary email address for contacting the committee or its administrative support.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this committee record was first created in the system.',
    `data_domain_coverage` STRING COMMENT 'Description of the data domains and subject areas under the committees governance purview, such as clinical research data, patient data, or operational data.',
    `data_steward_appointment_flag` BOOLEAN COMMENT 'Indicates whether the committee has authority to appoint or approve data stewards for specific data domains.',
    `decision_making_model` STRING COMMENT 'Method by which the committee reaches decisions on matters within its authority.',
    `dissolution_date` DATE COMMENT 'Date when the committee was officially dissolved or terminated, if applicable.',
    `dissolution_reason` STRING COMMENT 'Explanation for why the committee was dissolved, including business justification and context.',
    `established_date` DATE COMMENT 'Date when the committee was officially established and began operations.',
    `irb_alignment_flag` BOOLEAN COMMENT 'Indicates whether the committee coordinates with or reports to the Institutional Review Board for research data governance matters.',
    `issue_resolution_authority_flag` BOOLEAN COMMENT 'Indicates whether the committee has authority to resolve data governance issues and disputes.',
    `last_review_date` DATE COMMENT 'Date when the committee charter, membership, or effectiveness was last formally reviewed.',
    `meeting_frequency` STRING COMMENT 'Scheduled frequency at which the committee convenes for regular meetings.',
    `meeting_location` STRING COMMENT 'Primary physical or virtual location where committee meetings are held.',
    `member_count` STRING COMMENT 'Current total number of active members serving on the committee.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of the committee charter, membership, or effectiveness.',
    `notes` STRING COMMENT 'Additional notes, comments, or context about the committee not captured in other structured fields.',
    `policy_approval_authority_flag` BOOLEAN COMMENT 'Indicates whether the committee has authority to approve data governance policies and standards.',
    `quorum_requirement` STRING COMMENT 'Minimum number of members required to be present for the committee to conduct official business and make binding decisions.',
    `regulatory_oversight_flag` BOOLEAN COMMENT 'Indicates whether the committee has regulatory oversight responsibilities requiring compliance with external regulations such as FDA 21 CFR Part 11, HIPAA, or other healthcare regulations.',
    `scope` STRING COMMENT 'Organizational scope of the committees jurisdiction and responsibilities.',
    `data_governance_committee_status` STRING COMMENT 'Current operational status of the data governance committee.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this committee record was last updated in the system.',
    `voting_member_count` STRING COMMENT 'Number of committee members with voting rights on committee decisions.',
    CONSTRAINT pk_data_governance_committee PRIMARY KEY(`data_governance_committee_id`)
) COMMENT 'Master reference table for data_governance_committee. Referenced by data_governance_committee_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` (
    `dsmb_committee_id` BIGINT COMMENT 'Primary key for dsmb_committee',
    `parent_dsmb_committee_id` BIGINT COMMENT 'Self-referencing FK on dsmb_committee (parent_dsmb_committee_id)',
    `research_study_id` BIGINT COMMENT 'add column research_research_study_id (BIGINT) with FK to research.research_study.research_study_id - DSMBs oversee specific studies but dsmb_committee lacks a direct study FK',
    `adverse_event_review_threshold` STRING COMMENT 'Criteria or threshold that triggers mandatory DSMB committee review of adverse events reported in studies under their oversight.',
    `chair_affiliation` STRING COMMENT 'Institutional or organizational affiliation of the committee chairperson.',
    `chair_email` STRING COMMENT 'Primary email address for contacting the committee chairperson.',
    `chair_name` STRING COMMENT 'Full name of the individual serving as the chairperson of the DSMB committee.',
    `chair_phone` STRING COMMENT 'Primary phone number for contacting the committee chairperson.',
    `charter_document_reference` STRING COMMENT 'Reference identifier or location of the committee charter document that defines the scope, responsibilities, and operating procedures.',
    `committee_code` STRING COMMENT 'Unique alphanumeric code assigned to the DSMB committee for reference and tracking purposes.',
    `committee_name` STRING COMMENT 'Official name of the DSMB committee.',
    `committee_type` STRING COMMENT 'Classification of the DSMB committee based on its formation and governance structure.',
    `communication_protocol` STRING COMMENT 'Established protocol for communication between the DSMB committee, study investigators, sponsors, and regulatory authorities.',
    `confidentiality_agreement_reference` STRING COMMENT 'Reference identifier for the confidentiality or non-disclosure agreement signed by committee members.',
    `conflict_of_interest_policy` STRING COMMENT 'Reference to or description of the conflict of interest policy governing committee members and their relationships with study sponsors.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this DSMB committee record was first created in the system.',
    `data_access_level` STRING COMMENT 'Level of access to study data granted to the DSMB committee, indicating whether they review blinded, unblinded, or partially blinded data.',
    `data_quality_monitoring_flag` BOOLEAN COMMENT 'Indicates whether the DSMB committee reviews data quality and integrity as part of their oversight responsibilities. True if data quality monitoring is included, False otherwise.',
    `dissolution_date` DATE COMMENT 'Date when the DSMB committee was officially dissolved or terminated. Null if committee is still active.',
    `efficacy_monitoring_flag` BOOLEAN COMMENT 'Indicates whether the DSMB committee is responsible for monitoring treatment efficacy in addition to safety. True if efficacy monitoring is included, False otherwise.',
    `formation_date` DATE COMMENT 'Date when the DSMB committee was officially formed and constituted.',
    `independent_flag` BOOLEAN COMMENT 'Indicates whether the DSMB committee operates independently from the study sponsor and investigators. True if independent, False otherwise.',
    `interim_analysis_schedule` STRING COMMENT 'Planned schedule for interim data analyses to be reviewed by the DSMB committee during the course of a study.',
    `last_meeting_date` DATE COMMENT 'Date of the most recent DSMB committee meeting.',
    `meeting_frequency` STRING COMMENT 'Scheduled frequency at which the DSMB committee convenes for regular meetings.',
    `meeting_minutes_location` STRING COMMENT 'Storage location or reference path for official meeting minutes and records of DSMB committee proceedings.',
    `member_count` STRING COMMENT 'Total number of active members currently serving on the DSMB committee.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this DSMB committee record was last modified or updated in the system.',
    `next_scheduled_meeting_date` DATE COMMENT 'Date of the next scheduled DSMB committee meeting.',
    `notes` STRING COMMENT 'Additional notes, comments, or contextual information about the DSMB committee.',
    `oversight_scope` STRING COMMENT 'Description of the scope of studies, trials, or research activities that fall under the oversight of this DSMB committee.',
    `quorum_requirement` STRING COMMENT 'Minimum number of members required to be present for the committee to conduct official business and make binding decisions.',
    `regulatory_authority` STRING COMMENT 'Primary regulatory authority or agency overseeing the research activities monitored by this committee (e.g., FDA, EMA, Health Canada).',
    `reporting_frequency` STRING COMMENT 'Frequency at which the DSMB committee provides formal reports and recommendations to study sponsors and regulatory authorities.',
    `safety_monitoring_flag` BOOLEAN COMMENT 'Indicates whether the DSMB committee is responsible for monitoring participant safety. True if safety monitoring is included, False otherwise.',
    `statistical_support_provider` STRING COMMENT 'Name of the organization or individual providing statistical analysis support to the DSMB committee.',
    `dsmb_committee_status` STRING COMMENT 'Current operational status of the DSMB committee in its lifecycle.',
    `stopping_rule_criteria` STRING COMMENT 'Predefined statistical or clinical criteria that would trigger the DSMB committee to recommend early termination or modification of a study.',
    `therapeutic_area` STRING COMMENT 'Primary therapeutic area or medical specialty focus of the research overseen by this committee (e.g., oncology, cardiology, neurology).',
    CONSTRAINT pk_dsmb_committee PRIMARY KEY(`dsmb_committee_id`)
) COMMENT 'Master reference table for dsmb_committee. Referenced by dsmb_committee_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`research_document` (
    `research_document_id` BIGINT COMMENT 'Primary key for research_document',
    `irb_submission_id` BIGINT COMMENT 'Reference to the IRB that reviewed and approved this document, ensuring ethical compliance.',
    `primary_research_study_id` BIGINT COMMENT 'Reference to the clinical trial protocol that this document supports or is associated with.',
    `primary_superseded_by_research_document_id` BIGINT COMMENT 'Reference to the newer version of the document that replaces this version, establishing version lineage.',
    `research_study_id` BIGINT COMMENT 'Reference to the clinical study or research project that this document belongs to.',
    `access_restriction_notes` STRING COMMENT 'Special instructions or notes regarding who may access this document and under what conditions, supporting data governance and privacy compliance.',
    `amendment_number` STRING COMMENT 'Sequential number indicating which amendment this document represents for the associated protocol or study.',
    `amendment_reason` STRING COMMENT 'Explanation of why the document was amended, including scientific, safety, or regulatory justifications.',
    `approval_date` DATE COMMENT 'The date when the document received official approval from the designated authority or IRB.',
    `approver_name` STRING COMMENT 'Full name of the authorized individual who provided final approval for the document.',
    `author_name` STRING COMMENT 'Full name of the principal author or creator of the research document.',
    `author_organization` STRING COMMENT 'The organization or institution that the document author represents or is affiliated with.',
    `checksum_value` DECIMAL(18,2) COMMENT 'Cryptographic hash value of the document file to ensure integrity and detect unauthorized modifications, required for FDA 21 CFR Part 11 compliance.',
    `confidentiality_level` STRING COMMENT 'Data classification level indicating the sensitivity and access restrictions for the document.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this document record was first created in the research document management system.',
    `destruction_eligible_date` DATE COMMENT 'The earliest date when the document becomes eligible for destruction based on retention policies and regulatory requirements.',
    `document_description` STRING COMMENT 'Detailed narrative description of the document content, purpose, and scope within the research context.',
    `document_number` STRING COMMENT 'Business identifier for the research document, externally visible and used for reference in communications and regulatory submissions.',
    `document_status` STRING COMMENT 'Current lifecycle status of the research document indicating its approval state and usability.',
    `document_type` STRING COMMENT 'Classification of the research document indicating its purpose and regulatory category.',
    `effective_date` DATE COMMENT 'The date when this version of the document becomes officially active and enforceable for research operations.',
    `electronic_signature_applied` BOOLEAN COMMENT 'Indicates whether the document has been electronically signed in compliance with FDA 21 CFR Part 11 requirements.',
    `expiration_date` DATE COMMENT 'The date when this document version is no longer valid or must be renewed, particularly relevant for IRB approvals and regulatory submissions.',
    `file_format` STRING COMMENT 'The digital file format of the stored document.',
    `file_path` STRING COMMENT 'Storage location or URI where the physical document file is stored in the document management system.',
    `file_size_bytes` BIGINT COMMENT 'The size of the document file measured in bytes for storage management and validation purposes.',
    `keywords` STRING COMMENT 'Comma-separated list of keywords or tags for document categorization, search, and retrieval.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the primary language of the document content.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this document record was last updated or modified.',
    `regulatory_submission_flag` BOOLEAN COMMENT 'Indicates whether this document is part of a regulatory submission to FDA, EMA, or other governing bodies.',
    `retention_period_years` STRING COMMENT 'The number of years this document must be retained per regulatory requirements before eligible for destruction.',
    `reviewer_name` STRING COMMENT 'Full name of the individual who reviewed the document for accuracy, compliance, and scientific validity.',
    `signature_timestamp` TIMESTAMP COMMENT 'The date and time when the electronic signature was applied to the document.',
    `submission_reference_number` STRING COMMENT 'The reference or tracking number assigned by the regulatory authority for submissions that include this document.',
    `title` STRING COMMENT 'The official title or name of the research document.',
    `version_number` STRING COMMENT 'Version identifier for the document following major.minor versioning convention to track revisions and amendments.',
    CONSTRAINT pk_research_document PRIMARY KEY(`research_document_id`)
) COMMENT 'Master reference table for research_document. Referenced by meeting_minutes_document_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`research`.`research_grant` (
    `research_grant_id` BIGINT COMMENT 'Unique identifier for the research grant or funding award record. Primary key.',
    `compliance_regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Grants trigger regulatory submissions (NIH progress reports, financial disclosures, human subjects certifications, animal welfare assurances). Standard academic research compliance for federally funde',
    `conflict_of_interest_id` BIGINT COMMENT 'Foreign key linking to compliance.conflict_of_interest. Business justification: Grant-funded research requires COI disclosures from investigators per PHS/NSF regulations (42 CFR 50 Subpart F). Federally mandated for financial conflict management.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Grants are executed within specific departmental cost centers for expense tracking, budget management, and financial reporting. Required for departmental financial statements, indirect cost allocation',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Grants are tracked in restricted funds for sponsor compliance, donor restrictions, and fund accounting. Core relationship for healthcare fund accounting, financial reporting, audit trails, and regulat',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `audit_flag` BOOLEAN COMMENT 'Indicates whether this grant has been selected for audit by the sponsor, Office of Inspector General (OIG), or internal audit (True) or not (False).',
    `award_amount` DECIMAL(18,2) COMMENT 'The total funding amount awarded by the sponsor for the entire project period, including all budget periods. Expressed in the currency of the award (typically USD for U.S. federal grants).',
    `budget_period_end_date` DATE COMMENT 'The end date of the current budget period within the overall project period.',
    `budget_period_start_date` DATE COMMENT 'The start date of the current budget period (typically 12 months) within the overall project period. Multi-year grants have multiple budget periods.',
    `cfda_number` STRING COMMENT 'The CFDA number (now known as Assistance Listings number) that identifies the federal program under which the grant is awarded. Required for federal grants and used in Single Audit reporting.',
    `clinical_trial_flag` BOOLEAN COMMENT 'Indicates whether this grant supports a clinical trial as defined by NIH or FDA (True) or not (False). Clinical trials require additional regulatory oversight and reporting.',
    `closeout_date` DATE COMMENT 'The date on which all administrative and financial closeout activities were completed and the grant was officially closed in the institutions financial system. Typically occurs 90 days after the project end date.',
    `compliance_notes` STRING COMMENT 'Free-text field for documenting compliance issues, audit findings, corrective actions, or other regulatory notes related to the grant.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this grant record was first created in the system.',
    `direct_costs` DECIMAL(18,2) COMMENT 'The portion of the award amount allocated to direct project costs (personnel, supplies, equipment, travel, subcontracts, etc.), excluding indirect costs (Facilities and Administrative costs).',
    `fa_rate` DECIMAL(18,2) COMMENT 'The negotiated indirect cost rate applied to the grant, expressed as a percentage. This rate is used to calculate the indirect costs portion of the award.',
    `final_report_submitted_date` DATE COMMENT 'The date on which the final technical and financial reports were submitted to the funding agency, as required by the grant terms.',
    `funding_agency` STRING COMMENT 'The name of the organization providing the grant funding (e.g., National Institutes of Health, National Science Foundation, Patient-Centered Outcomes Research Institute, Department of Defense, private foundation name).',
    `grant_number` STRING COMMENT 'The externally-known grant or award number assigned by the funding agency (e.g., NIH grant number, NSF award number, foundation reference number). This is the business identifier used in all sponsor communications and reporting.',
    `grant_status` STRING COMMENT 'Current lifecycle status of the grant award. Pending: award notice received but not yet activated. Active: grant is in execution and funds are being expended. Suspended: temporarily halted by sponsor or institution. Closed: project period completed and final reporting submitted. Terminated: ended early by sponsor or institution.. Valid values are `pending|active|suspended|closed|terminated`',
    `grant_type` STRING COMMENT 'The classification of the grant award mechanism (e.g., R01 Research Project Grant, R21 Exploratory/Developmental Research Grant, T32 Institutional Training Grant, K-award Career Development, industry-sponsored clinical trial, foundation grant, contract). Aligns with NIH activity codes and sponsor-specific classifications.',
    `iacuc_protocol_number` STRING COMMENT 'The protocol number assigned by the Institutional Animal Care and Use Committee for animal research conducted under this grant. Required when the grant involves animal subjects.',
    `indirect_costs` DECIMAL(18,2) COMMENT 'The portion of the award amount allocated to Facilities and Administrative (F&A) costs, calculated using the institutions negotiated indirect cost rate. Also known as overhead.',
    `institutional_approval_date` DATE COMMENT 'The date on which the institutions Office of Sponsored Programs or equivalent authority approved acceptance of the grant award.',
    `irb_protocol_number` STRING COMMENT 'The protocol number assigned by the Institutional Review Board for human subjects research conducted under this grant. Required when the grant involves human subjects research.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this grant record was last updated in the system.',
    `prime_sponsor_flag` BOOLEAN COMMENT 'Indicates whether this institution is the prime recipient of the award (True) or a subrecipient under another institutions prime award (False).',
    `project_end_date` DATE COMMENT 'The date on which the grant project period ends, as specified in the award notice. This is the last date on which costs may be incurred against the grant, unless a no-cost extension is granted.',
    `project_start_date` DATE COMMENT 'The date on which the grant project period begins, as specified in the award notice. This is the earliest date on which costs may be incurred against the grant.',
    `remaining_balance` DECIMAL(18,2) COMMENT 'The unspent portion of the award amount, calculated as award_amount minus total_expenditures_to_date. Represents funds still available for project expenditures.',
    `sponsor_award_date` DATE COMMENT 'The date on which the funding agency officially issued the award notice or executed the grant agreement.',
    `subcontract_flag` BOOLEAN COMMENT 'Indicates whether this grant includes subcontracts to other institutions or organizations (True) or not (False).',
    `title` STRING COMMENT 'The official title of the research project or program as stated in the award notice.',
    `total_expenditures_to_date` DECIMAL(18,2) COMMENT 'The cumulative amount of grant funds expended from the project start date through the current date. Used for budget-to-actual variance analysis and sponsor financial reporting.',
    CONSTRAINT pk_research_grant PRIMARY KEY(`research_grant_id`)
) COMMENT 'Master record for research grants and funding awards, including award management and expenditure tracking. Award level: captures grant number, funding agency (NIH, NSF, PCORI, DOD, private foundation), grant type (R01, R21, T32, K-award, industry-sponsored), award amount, direct/indirect costs (F&A rate), project period, PI, co-investigators, grant status, and associated study identifiers. Expenditure level: tracks personnel costs (salary, fringe), supplies, equipment, subcontracts, travel, indirect costs, transaction dates, budget periods, cost centers, effort percentages, and sponsor-required cost classifications. Supports grant financial management, budget-to-actual reporting, 2 CFR Part 200 (Uniform Guidance) compliance, and NIH progress report financial sections. SSOT for research funding and grant expenditure tracking within the research domain.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_protocol_amendment_id` FOREIGN KEY (`protocol_amendment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`protocol_amendment`(`protocol_amendment_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ADD CONSTRAINT `fk_research_irb_submission_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ADD CONSTRAINT `fk_research_study_site_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_study_arm_id` FOREIGN KEY (`study_arm_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_arm`(`study_arm_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ADD CONSTRAINT `fk_research_subject_enrollment_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_site`(`study_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ADD CONSTRAINT `fk_research_informed_consent_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ADD CONSTRAINT `fk_research_protocol_amendment_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ADD CONSTRAINT `fk_research_protocol_amendment_superseded_by_protocol_amendment_id` FOREIGN KEY (`superseded_by_protocol_amendment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`protocol_amendment`(`protocol_amendment_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_study_arm_id` FOREIGN KEY (`study_arm_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_arm`(`study_arm_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_site`(`study_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ADD CONSTRAINT `fk_research_study_visit_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_site`(`study_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_study_visit_id` FOREIGN KEY (`study_visit_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_visit`(`study_visit_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ADD CONSTRAINT `fk_research_adverse_event_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ADD CONSTRAINT `fk_research_investigational_product_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `vibe_healthcare_v1`.`research`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_study_arm_id` FOREIGN KEY (`study_arm_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_arm`(`study_arm_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_site`(`study_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ADD CONSTRAINT `fk_research_ip_dispensation_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_parent_biospecimen_id` FOREIGN KEY (`parent_biospecimen_id`) REFERENCES `vibe_healthcare_v1`.`research`.`biospecimen`(`biospecimen_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ADD CONSTRAINT `fk_research_biospecimen_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ADD CONSTRAINT `fk_research_data_safety_monitoring_dsmb_committee_id` FOREIGN KEY (`dsmb_committee_id`) REFERENCES `vibe_healthcare_v1`.`research`.`dsmb_committee`(`dsmb_committee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ADD CONSTRAINT `fk_research_data_safety_monitoring_research_document_id` FOREIGN KEY (`research_document_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_document`(`research_document_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ADD CONSTRAINT `fk_research_data_safety_monitoring_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_coverage_analysis_id` FOREIGN KEY (`coverage_analysis_id`) REFERENCES `vibe_healthcare_v1`.`research`.`coverage_analysis`(`coverage_analysis_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ADD CONSTRAINT `fk_research_billing_event_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ADD CONSTRAINT `fk_research_grant_expenditure_research_grant_id` FOREIGN KEY (`research_grant_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_grant`(`research_grant_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ADD CONSTRAINT `fk_research_study_sponsor_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ADD CONSTRAINT `fk_research_coverage_analysis_protocol_amendment_id` FOREIGN KEY (`protocol_amendment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`protocol_amendment`(`protocol_amendment_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ADD CONSTRAINT `fk_research_coverage_analysis_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ADD CONSTRAINT `fk_research_coverage_analysis_superseded_by_coverage_analysis_id` FOREIGN KEY (`superseded_by_coverage_analysis_id`) REFERENCES `vibe_healthcare_v1`.`research`.`coverage_analysis`(`coverage_analysis_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ADD CONSTRAINT `fk_research_research_regulatory_submission_protocol_amendment_id` FOREIGN KEY (`protocol_amendment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`protocol_amendment`(`protocol_amendment_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ADD CONSTRAINT `fk_research_research_regulatory_submission_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ADD CONSTRAINT `fk_research_monitoring_visit_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ADD CONSTRAINT `fk_research_monitoring_visit_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_site`(`study_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ADD CONSTRAINT `fk_research_protocol_deviation_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ADD CONSTRAINT `fk_research_protocol_deviation_study_site_id` FOREIGN KEY (`study_site_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_site`(`study_site_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ADD CONSTRAINT `fk_research_protocol_deviation_subject_enrollment_id` FOREIGN KEY (`subject_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`subject_enrollment`(`subject_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ADD CONSTRAINT `fk_research_data_access_request_data_governance_committee_id` FOREIGN KEY (`data_governance_committee_id`) REFERENCES `vibe_healthcare_v1`.`research`.`data_governance_committee`(`data_governance_committee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ADD CONSTRAINT `fk_research_data_access_request_deidentified_dataset_id` FOREIGN KEY (`deidentified_dataset_id`) REFERENCES `vibe_healthcare_v1`.`research`.`deidentified_dataset`(`deidentified_dataset_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ADD CONSTRAINT `fk_research_data_access_request_dua_document_id` FOREIGN KEY (`dua_document_id`) REFERENCES `vibe_healthcare_v1`.`research`.`dua_document`(`dua_document_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ADD CONSTRAINT `fk_research_data_access_request_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ADD CONSTRAINT `fk_research_study_budget_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ADD CONSTRAINT `fk_research_study_budget_study_sponsor_id` FOREIGN KEY (`study_sponsor_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_sponsor`(`study_sponsor_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ADD CONSTRAINT `fk_research_study_budget_superseded_by_study_budget_id` FOREIGN KEY (`superseded_by_study_budget_id`) REFERENCES `vibe_healthcare_v1`.`research`.`study_budget`(`study_budget_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ADD CONSTRAINT `fk_research_consent_template_protocol_amendment_id` FOREIGN KEY (`protocol_amendment_id`) REFERENCES `vibe_healthcare_v1`.`research`.`protocol_amendment`(`protocol_amendment_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ADD CONSTRAINT `fk_research_consent_template_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ADD CONSTRAINT `fk_research_consent_template_superseded_by_consent_template_id` FOREIGN KEY (`superseded_by_consent_template_id`) REFERENCES `vibe_healthcare_v1`.`research`.`consent_template`(`consent_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ADD CONSTRAINT `fk_research_study_arm_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ADD CONSTRAINT `fk_research_study_partner_agreement_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ADD CONSTRAINT `fk_research_grant_personnel_research_grant_id` FOREIGN KEY (`research_grant_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_grant`(`research_grant_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ADD CONSTRAINT `fk_research_investigational_product_training_investigational_product_id` FOREIGN KEY (`investigational_product_id`) REFERENCES `vibe_healthcare_v1`.`research`.`investigational_product`(`investigational_product_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ADD CONSTRAINT `fk_research_dua_document_parent_dua_document_id` FOREIGN KEY (`parent_dua_document_id`) REFERENCES `vibe_healthcare_v1`.`research`.`dua_document`(`dua_document_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ADD CONSTRAINT `fk_research_dua_document_primary_superseded_dua_document_id` FOREIGN KEY (`primary_superseded_dua_document_id`) REFERENCES `vibe_healthcare_v1`.`research`.`dua_document`(`dua_document_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ADD CONSTRAINT `fk_research_data_governance_committee_data_escalation_committee_id` FOREIGN KEY (`data_escalation_committee_id`) REFERENCES `vibe_healthcare_v1`.`research`.`data_governance_committee`(`data_governance_committee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ADD CONSTRAINT `fk_research_data_governance_committee_data_reporting_to_committee_id` FOREIGN KEY (`data_reporting_to_committee_id`) REFERENCES `vibe_healthcare_v1`.`research`.`data_governance_committee`(`data_governance_committee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ADD CONSTRAINT `fk_research_data_governance_committee_parent_committee_id` FOREIGN KEY (`parent_committee_id`) REFERENCES `vibe_healthcare_v1`.`research`.`data_governance_committee`(`data_governance_committee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ADD CONSTRAINT `fk_research_data_governance_committee_parent_data_governance_committee_id` FOREIGN KEY (`parent_data_governance_committee_id`) REFERENCES `vibe_healthcare_v1`.`research`.`data_governance_committee`(`data_governance_committee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ADD CONSTRAINT `fk_research_dsmb_committee_parent_dsmb_committee_id` FOREIGN KEY (`parent_dsmb_committee_id`) REFERENCES `vibe_healthcare_v1`.`research`.`dsmb_committee`(`dsmb_committee_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ADD CONSTRAINT `fk_research_dsmb_committee_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ADD CONSTRAINT `fk_research_research_document_irb_submission_id` FOREIGN KEY (`irb_submission_id`) REFERENCES `vibe_healthcare_v1`.`research`.`irb_submission`(`irb_submission_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ADD CONSTRAINT `fk_research_research_document_primary_research_study_id` FOREIGN KEY (`primary_research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ADD CONSTRAINT `fk_research_research_document_primary_superseded_by_research_document_id` FOREIGN KEY (`primary_superseded_by_research_document_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_document`(`research_document_id`);
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ADD CONSTRAINT `fk_research_research_document_research_study_id` FOREIGN KEY (`research_study_id`) REFERENCES `vibe_healthcare_v1`.`research`.`research_study`(`research_study_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`research` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_healthcare_v1`.`research` SET TAGS ('dbx_domain' = 'research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` SET TAGS ('dbx_subdomain' = 'study_management');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `compliance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `exchange_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Standard Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `osha_safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Osha Safety Program Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `actual_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Actual Enrollment');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `blinding_type` SET TAGS ('dbx_business_glossary_term' = 'Blinding Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `blinding_type` SET TAGS ('dbx_value_regex' = 'open_label|single_blind|double_blind|triple_blind|quadruple_blind');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `cfr_part_11_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Code of Federal Regulations (CFR) Part 11 Compliant Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Study Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'placebo|active_comparator|no_intervention|sham|dose_comparison|historical');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `coordinating_center` SET TAGS ('dbx_business_glossary_term' = 'Coordinating Center');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `data_monitoring_committee_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Monitoring Committee (DMC) Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment End Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Start Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `exclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `fda_regulated_device_flag` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Regulated Device Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `fda_regulated_drug_flag` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Regulated Drug Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `ide_number` SET TAGS ('dbx_business_glossary_term' = 'Investigational Device Exemption (IDE) Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `inclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Criteria');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `ind_number` SET TAGS ('dbx_business_glossary_term' = 'Investigational New Drug (IND) Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `irb_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `irb_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `irb_protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Protocol Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `nct_identifier` SET TAGS ('dbx_business_glossary_term' = 'National Clinical Trial (NCT) Identifier');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `nct_identifier` SET TAGS ('dbx_value_regex' = '^NCT[0-9]{8}$');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `phase` SET TAGS ('dbx_business_glossary_term' = 'Study Phase');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `primary_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Primary Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `primary_outcome_measure` SET TAGS ('dbx_business_glossary_term' = 'Primary Outcome Measure');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Protocol Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `protocol_version_date` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `randomization_flag` SET TAGS ('dbx_business_glossary_term' = 'Randomization Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `secondary_outcome_measures` SET TAGS ('dbx_business_glossary_term' = 'Secondary Outcome Measures');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `short_title` SET TAGS ('dbx_business_glossary_term' = 'Study Short Title');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `sponsor_type` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `sponsor_type` SET TAGS ('dbx_value_regex' = 'industry|academic|government|non_profit|investigator_initiated');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Study Start Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `study_description` SET TAGS ('dbx_business_glossary_term' = 'Study Description');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'Study Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Study Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'interventional|observational|expanded_access|registry|diagnostic|prevention');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `target_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Target Enrollment');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_study` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Study Title');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `irb_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Submission Identifier');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `interface_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Channel Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Condition Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Identifier');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `protocol_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol Amendment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Identifier');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `tertiary_irb_reviewed_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By User Identifier');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `tertiary_irb_reviewed_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `tertiary_irb_reviewed_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Federal Agency Acknowledgment Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Action Due Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `action_required_description` SET TAGS ('dbx_business_glossary_term' = 'Action Required Description');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Action Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `agency_response_letter` SET TAGS ('dbx_business_glossary_term' = 'Agency Response Letter');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `agency_response_letter` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `approval_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `conditions_of_approval` SET TAGS ('dbx_business_glossary_term' = 'Conditions of Approval');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `determination_outcome` SET TAGS ('dbx_business_glossary_term' = 'Determination Outcome');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `determination_outcome` SET TAGS ('dbx_value_regex' = 'approved|conditionally_approved|deferred|disapproved|exempt_determination|not_human_subjects_research');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `ectd_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Common Technical Document (eCTD) Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `federal_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Federal Agency Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `federal_agency_name` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `fwa_number` SET TAGS ('dbx_business_glossary_term' = 'Federalwide Assurance (FWA) Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `fwa_number` SET TAGS ('dbx_value_regex' = '^FWA[0-9]{8}$');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `ide_number` SET TAGS ('dbx_business_glossary_term' = 'Investigational Device Exemption (IDE) Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `ide_number` SET TAGS ('dbx_value_regex' = '^G[0-9]{6}$');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `ind_number` SET TAGS ('dbx_business_glossary_term' = 'Investigational New Drug (IND) Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `ind_number` SET TAGS ('dbx_value_regex' = '^IND[0-9]{6}$');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `informed_consent_version` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Version');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `irb_board_name` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Board Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `nct_number` SET TAGS ('dbx_business_glossary_term' = 'ClinicalTrials.gov (NCT) Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `nct_number` SET TAGS ('dbx_value_regex' = '^NCT[0-9]{8}$');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `review_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Review Meeting Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'full_board|expedited|exempt|administrative');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `reviewing_body_type` SET TAGS ('dbx_business_glossary_term' = 'Reviewing Body Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `reviewing_body_type` SET TAGS ('dbx_value_regex' = 'irb|fda|ohrp|other_federal_agency');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Research Risk Level');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'minimal_risk|greater_than_minimal_risk');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `sponsor_organization` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Organization');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic_ectd|electronic_portal|paper|email');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `submission_notes` SET TAGS ('dbx_business_glossary_term' = 'Submission Notes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Control Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `vulnerable_population_flag` SET TAGS ('dbx_business_glossary_term' = 'Vulnerable Population Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `vulnerable_population_type` SET TAGS ('dbx_business_glossary_term' = 'Vulnerable Population Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`irb_submission` ALTER COLUMN `vulnerable_population_type` SET TAGS ('dbx_value_regex' = 'children|prisoners|pregnant_women|cognitively_impaired|economically_disadvantaged|other');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` SET TAGS ('dbx_subdomain' = 'study_management');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `study_site_id` SET TAGS ('dbx_business_glossary_term' = 'Study Site Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `accreditation_status_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `cms_condition_status_id` SET TAGS ('dbx_business_glossary_term' = 'Cms Condition Status Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `inventory_location_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Location Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Site Coordinator Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Site Activation Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `actual_enrollment_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Enrollment Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `adverse_event_count` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event (AE) Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Site Closure Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `corrective_action_plan_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Due Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `corrective_action_plan_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `corrective_action_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `corrective_action_plan_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|submitted|under_review|accepted|implemented');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `cro_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Research Organization (CRO) Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `data_query_count` SET TAGS ('dbx_business_glossary_term' = 'Data Query Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `enrollment_rate_per_month` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Rate Per Month');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `informed_consent_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Compliance Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `informed_consent_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|minor_issue|major_issue|under_review');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `investigational_product_accountability_status` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product Accountability Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `investigational_product_accountability_status` SET TAGS ('dbx_value_regex' = 'compliant|minor_discrepancy|major_discrepancy|under_review');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `irb_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `irb_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `irb_of_record_name` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) of Record Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `last_monitoring_visit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Monitoring Visit Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `last_monitoring_visit_type` SET TAGS ('dbx_business_glossary_term' = 'Last Monitoring Visit Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `last_monitoring_visit_type` SET TAGS ('dbx_value_regex' = 'initiation|routine|interim|close_out|for_cause');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `next_monitoring_visit_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Next Monitoring Visit Scheduled Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `open_data_query_count` SET TAGS ('dbx_business_glossary_term' = 'Open Data Query Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `planned_enrollment_capacity` SET TAGS ('dbx_business_glossary_term' = 'Planned Enrollment Capacity');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `planned_enrollment_capacity` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `protocol_deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Protocol Deviation Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `regulatory_binder_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Binder Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `regulatory_binder_status` SET TAGS ('dbx_value_regex' = 'incomplete|complete|under_review|approved');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `screen_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Screen Failure Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `serious_adverse_event_count` SET TAGS ('dbx_business_glossary_term' = 'Serious Adverse Event (SAE) Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `serious_protocol_deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Serious Protocol Deviation Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_notes` SET TAGS ('dbx_business_glossary_term' = 'Site Notes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_number` SET TAGS ('dbx_business_glossary_term' = 'Site Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Site Performance Score');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Site Risk Rating');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_status` SET TAGS ('dbx_business_glossary_term' = 'Site Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `site_status` SET TAGS ('dbx_value_regex' = 'pending_activation|active|suspended|closed|terminated');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `source_document_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Source Document Verification (SDV) Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `source_document_verification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|complete|issues_identified');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_site` ALTER COLUMN `sponsor_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Organization Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` SET TAGS ('dbx_subdomain' = 'subject_conduct');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Enrollment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `notice_of_privacy_practices_id` SET TAGS ('dbx_business_glossary_term' = 'Notice Of Privacy Practices Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `phi_access_log_id` SET TAGS ('dbx_business_glossary_term' = 'Phi Access Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Study Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `research_study_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `research_study_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `study_arm_id` SET TAGS ('dbx_business_glossary_term' = 'Study Arm Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `study_site_id` SET TAGS ('dbx_business_glossary_term' = 'Research Site Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `adverse_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event (AE) Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Study Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `data_lock_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Lock Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `data_lock_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Lock Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `data_monitoring_committee_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Monitoring Committee (DMC) Review Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `eligibility_confirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Confirmed Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `enrollment_notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'direct_recruitment|referral|registry|existing_patient|community_outreach|other');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `informed_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `informed_consent_version` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Version');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `investigational_product_dispensed_flag` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product Dispensed Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `protocol_deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Protocol Deviation Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `randomization_date` SET TAGS ('dbx_business_glossary_term' = 'Randomization Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `screening_date` SET TAGS ('dbx_business_glossary_term' = 'Screening Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `serious_adverse_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Serious Adverse Event (SAE) Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `stratification_factors` SET TAGS ('dbx_business_glossary_term' = 'Stratification Factors');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`subject_enrollment` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `informed_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `attestation_id` SET TAGS ('dbx_business_glossary_term' = 'Attestation Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `capacity_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Capacity Assessment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `capacity_assessment_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Consenting Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Demographics Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Template ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `informed_obtained_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `informed_obtained_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `informed_obtained_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `note_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Note Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `notice_of_privacy_practices_id` SET TAGS ('dbx_business_glossary_term' = 'Notice Of Privacy Practices Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `primary_informed_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Consenting Staff ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `primary_informed_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `primary_informed_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Research Subject ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `capacity_assessment_performed` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Performed Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `capacity_assessment_performed` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `capacity_assessment_result` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Result');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `capacity_assessment_result` SET TAGS ('dbx_value_regex' = 'capable|incapable|not_assessed');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `capacity_assessment_result` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `consent_comprehension_assessed` SET TAGS ('dbx_business_glossary_term' = 'Consent Comprehension Assessed Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `consent_copy_provided_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Copy Provided Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `consent_copy_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Copy Provided to Subject Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `consent_discussion_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Consent Discussion Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `consent_document_location` SET TAGS ('dbx_business_glossary_term' = 'Consent Document Storage Location');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'in_person|electronic|telephonic|video_conference');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'active|withdrawn|expired|superseded|pending');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `consent_time` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `consent_version_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Version Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `electronic_signature_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `hipaa_authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Authorization Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `hipaa_authorization_included` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Authorization Included Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `interpreter_name` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `interpreter_used_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Used Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `irb_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `irb_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Consent Language Code');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `lar_consent_indicator` SET TAGS ('dbx_business_glossary_term' = 'Legally Authorized Representative (LAR) Consent Indicator');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `lar_name` SET TAGS ('dbx_business_glossary_term' = 'Legally Authorized Representative (LAR) Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `lar_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `lar_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `lar_relationship` SET TAGS ('dbx_business_glossary_term' = 'Legally Authorized Representative (LAR) Relationship');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `re_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Re-Consent Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `subject_questions_addressed_flag` SET TAGS ('dbx_business_glossary_term' = 'Subject Questions Addressed Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `subject_questions_addressed_flag` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `subject_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Subject Signature Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `subject_signature_indicator` SET TAGS ('dbx_business_glossary_term' = 'Subject Signature Indicator');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Reason');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`informed_consent` ALTER COLUMN `witness_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Witness Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `protocol_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol Amendment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Author Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `superseded_by_protocol_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Amendment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Description');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_document_url` SET TAGS ('dbx_business_glossary_term' = 'Amendment Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_title` SET TAGS ('dbx_business_glossary_term' = 'Amendment Title');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'substantial|administrative|minor|safety|protocol_deviation_correction|eligibility_criteria_change');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `amendment_version` SET TAGS ('dbx_business_glossary_term' = 'Amendment Version');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `fda_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Acknowledgment Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `fda_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `fda_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Submission Reference');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `impact_assessment_efficacy` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment - Efficacy');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `impact_assessment_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment - Enrollment');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `impact_assessment_operational` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment - Operational');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `impact_assessment_safety` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment - Safety');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `informed_consent_update_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Update Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `irb_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `irb_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `irb_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Submission Reference');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `protocol_sections_modified` SET TAGS ('dbx_business_glossary_term' = 'Protocol Sections Modified');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `reason_for_amendment` SET TAGS ('dbx_business_glossary_term' = 'Reason for Amendment');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `reconsent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Re-consent Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `site_implementation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Site Implementation Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `sponsor_approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Approval Authority');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `sponsor_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_amendment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` SET TAGS ('dbx_subdomain' = 'subject_conduct');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `study_visit_id` SET TAGS ('dbx_business_glossary_term' = 'Study Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Research Subject Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `demographics_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `observation_id` SET TAGS ('dbx_business_glossary_term' = 'Observation Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Study Coordinator Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `study_arm_id` SET TAGS ('dbx_business_glossary_term' = 'Study Arm Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `study_site_id` SET TAGS ('dbx_business_glossary_term' = 'Research Site Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `vital_sign_id` SET TAGS ('dbx_business_glossary_term' = 'Vital Sign Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Visit Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `adverse_event_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event (AE) Reported Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `assessments_completed_count` SET TAGS ('dbx_business_glossary_term' = 'Assessments Completed Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `assessments_missed_count` SET TAGS ('dbx_business_glossary_term' = 'Assessments Missed Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Visit Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `compliance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Subject Compliance Percentage');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `compliance_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `data_entry_complete_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Entry Complete Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `informed_consent_reaffirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Reaffirmed Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `missed_visit_reason` SET TAGS ('dbx_business_glossary_term' = 'Missed Visit Reason');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `protocol_deviation_description` SET TAGS ('dbx_business_glossary_term' = 'Protocol Deviation Description');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `protocol_deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Protocol Deviation Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `query_open_count` SET TAGS ('dbx_business_glossary_term' = 'Open Query Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Visit Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `serious_adverse_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Serious Adverse Event (SAE) Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `source_data_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Source Data Verified Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `study_drug_dispensed_flag` SET TAGS ('dbx_business_glossary_term' = 'Study Drug Dispensed Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `study_drug_returned_flag` SET TAGS ('dbx_business_glossary_term' = 'Study Drug Returned Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `visit_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Visit Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `visit_location` SET TAGS ('dbx_business_glossary_term' = 'Visit Location');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `visit_locked_flag` SET TAGS ('dbx_business_glossary_term' = 'Visit Locked Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `visit_locked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Visit Locked Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `visit_name` SET TAGS ('dbx_business_glossary_term' = 'Visit Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `visit_notes` SET TAGS ('dbx_business_glossary_term' = 'Visit Notes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `visit_number` SET TAGS ('dbx_business_glossary_term' = 'Visit Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `visit_status` SET TAGS ('dbx_business_glossary_term' = 'Visit Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `visit_status` SET TAGS ('dbx_value_regex' = 'scheduled|completed|missed|cancelled|in_progress|rescheduled');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `visit_type` SET TAGS ('dbx_business_glossary_term' = 'Visit Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `visit_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Visit Window End Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `visit_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Visit Window Start Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `visit_window_status` SET TAGS ('dbx_business_glossary_term' = 'Visit Window Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_visit` ALTER COLUMN `visit_window_status` SET TAGS ('dbx_value_regex' = 'within_window|early|late|out_of_window');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` SET TAGS ('dbx_subdomain' = 'subject_conduct');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `adverse_event_id` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event (AE) ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `compliance_regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `hotline_report_id` SET TAGS ('dbx_business_glossary_term' = 'Hotline Report Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Research Subject ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `public_health_report_id` SET TAGS ('dbx_business_glossary_term' = 'Public Health Report Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `public_health_report_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `public_health_report_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Study ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `study_site_id` SET TAGS ('dbx_business_glossary_term' = 'Research Site ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `study_visit_id` SET TAGS ('dbx_business_glossary_term' = 'Study Visit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `action_taken` SET TAGS ('dbx_business_glossary_term' = 'Action Taken with Study Treatment');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `action_taken` SET TAGS ('dbx_value_regex' = 'none|dose_reduced|dose_interrupted|drug_withdrawn|concomitant_medication|other');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `ae_term` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event (AE) Term');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `capa_completion_date` SET TAGS ('dbx_business_glossary_term' = 'CAPA Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `capa_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Description');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `causality_assessment` SET TAGS ('dbx_business_glossary_term' = 'Causality Assessment');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `causality_assessment` SET TAGS ('dbx_value_regex' = 'not_related|unlikely|possible|probable|definite');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `deviation_category` SET TAGS ('dbx_business_glossary_term' = 'Protocol Deviation Category');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `deviation_description` SET TAGS ('dbx_business_glossary_term' = 'Protocol Deviation Description');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `deviation_severity` SET TAGS ('dbx_business_glossary_term' = 'Protocol Deviation Severity');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `deviation_severity` SET TAGS ('dbx_value_regex' = 'minor|major|critical');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Deviation Discovery Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'open|under_review|resolved|closed');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'adverse_event|serious_adverse_event|protocol_deviation|protocol_violation|quality_event|near_miss');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `expectedness` SET TAGS ('dbx_business_glossary_term' = 'Expectedness');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `expectedness` SET TAGS ('dbx_value_regex' = 'expected|unexpected');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `expedited_report_date` SET TAGS ('dbx_business_glossary_term' = 'Expedited Report Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `expedited_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Expedited Reporting Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `impact_on_data_integrity` SET TAGS ('dbx_business_glossary_term' = 'Impact on Data Integrity');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `impact_on_data_integrity` SET TAGS ('dbx_value_regex' = 'none|minimal|moderate|significant');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `impact_on_subject_safety` SET TAGS ('dbx_business_glossary_term' = 'Impact on Subject Safety');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `impact_on_subject_safety` SET TAGS ('dbx_value_regex' = 'none|minimal|moderate|significant');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `irb_report_date` SET TAGS ('dbx_business_glossary_term' = 'IRB Report Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `irb_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Reportable Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `meddra_code` SET TAGS ('dbx_business_glossary_term' = 'Medical Dictionary for Regulatory Activities (MedDRA) Code');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `meddra_version` SET TAGS ('dbx_business_glossary_term' = 'MedDRA Version');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `medwatch_report_number` SET TAGS ('dbx_business_glossary_term' = 'FDA MedWatch Report Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `narrative` SET TAGS ('dbx_business_glossary_term' = 'Event Narrative');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `onset_date` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event (AE) Onset Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event (AE) Outcome');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'recovered|recovering|not_recovered|recovered_with_sequelae|fatal|unknown');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `report_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Report Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `reporter_role` SET TAGS ('dbx_business_glossary_term' = 'Reporter Role');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event (AE) Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `seriousness_criteria` SET TAGS ('dbx_business_glossary_term' = 'Seriousness Criteria');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `seriousness_flag` SET TAGS ('dbx_business_glossary_term' = 'Serious Adverse Event (SAE) Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `severity_grade` SET TAGS ('dbx_business_glossary_term' = 'Common Terminology Criteria for Adverse Events (CTCAE) Severity Grade');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `severity_grade` SET TAGS ('dbx_value_regex' = 'grade_1|grade_2|grade_3|grade_4|grade_5');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `sponsor_report_date` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Report Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `sponsor_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Reportable Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`adverse_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` SET TAGS ('dbx_subdomain' = 'subject_conduct');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `investigational_product_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `exclusion_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Screening Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `osha_safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Osha Safety Program Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `accountability_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Product Accountability Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `adverse_event_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Reporting Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `blinding_status` SET TAGS ('dbx_business_glossary_term' = 'Blinding Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `blinding_status` SET TAGS ('dbx_value_regex' = 'open_label|single_blind|double_blind|triple_blind|unblinded');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand or Trade Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `comparator_indicator` SET TAGS ('dbx_business_glossary_term' = 'Comparator Product Indicator');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Schedule');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_value_regex' = 'schedule_I|schedule_II|schedule_III|schedule_IV|schedule_V|not_controlled');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `data_governance_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Classification');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Product Discontinuation Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `dosage_form` SET TAGS ('dbx_business_glossary_term' = 'Dosage Form');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `dosage_form` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `expiration_management_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date Management Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `expiration_management_required_flag` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `formulation` SET TAGS ('dbx_business_glossary_term' = 'Product Formulation');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `generic_name` SET TAGS ('dbx_business_glossary_term' = 'Generic Product Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `ind_ide_number` SET TAGS ('dbx_business_glossary_term' = 'Investigational New Drug (IND) or Investigational Device Exemption (IDE) Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `ind_ide_number` SET TAGS ('dbx_value_regex' = '^(IND|IDE)[0-9]{6,10}$');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `indication` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `informed_consent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `irb_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `labeling_requirements` SET TAGS ('dbx_business_glossary_term' = 'Labeling Requirements');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `lot_tracking_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Lot Tracking Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Address');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Product Notes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `packaging_description` SET TAGS ('dbx_business_glossary_term' = 'Packaging Description');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `phase` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Phase');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `phase` SET TAGS ('dbx_value_regex' = 'phase_I|phase_II|phase_III|phase_IV|phase_I_II|phase_II_III');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `placebo_indicator` SET TAGS ('dbx_business_glossary_term' = 'Placebo Indicator');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'drug|biologic|device|combination_product|placebo|comparator');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Protocol Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|withdrawn|suspended|approved');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `research_billing_code` SET TAGS ('dbx_business_glossary_term' = 'Research Billing Code');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `return_destruction_procedure` SET TAGS ('dbx_business_glossary_term' = 'Return and Destruction Procedure');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `shelf_life_months` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life in Months');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Sponsor Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `storage_requirements` SET TAGS ('dbx_business_glossary_term' = 'Storage Requirements');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `storage_requirements` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `strength` SET TAGS ('dbx_business_glossary_term' = 'Product Strength');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `temperature_monitoring_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Monitoring Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` SET TAGS ('dbx_subdomain' = 'subject_conduct');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `ip_dispensation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product (IP) Dispensation ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Dispensed By Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `inventory_location_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Location Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `investigational_product_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Study ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `study_arm_id` SET TAGS ('dbx_business_glossary_term' = 'Study Arm Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `study_site_id` SET TAGS ('dbx_business_glossary_term' = 'Research Site ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Research Subject ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Study Visit ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `accountability_status` SET TAGS ('dbx_business_glossary_term' = 'Accountability Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `accountability_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|discrepancy|closed');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `administration_instructions` SET TAGS ('dbx_business_glossary_term' = 'Administration Instructions');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `blinding_status` SET TAGS ('dbx_business_glossary_term' = 'Blinding Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `blinding_status` SET TAGS ('dbx_value_regex' = 'open|single_blind|double_blind|triple_blind');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `chain_of_custody_signature` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Signature');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Subject Compliance Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial|not_assessed');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `discrepancy_notes` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `dispensation_date` SET TAGS ('dbx_business_glossary_term' = 'Dispensation Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `dispensation_notes` SET TAGS ('dbx_business_glossary_term' = 'Dispensation Notes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `dispensation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispensation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `dispensed_by_role` SET TAGS ('dbx_business_glossary_term' = 'Dispensed By Role');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `dispensed_by_role` SET TAGS ('dbx_value_regex' = 'pharmacist|research_coordinator|investigator|nurse|other');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `dose_level` SET TAGS ('dbx_business_glossary_term' = 'Dose Level');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `expected_return_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Return Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `informed_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Record');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `kit_number` SET TAGS ('dbx_business_glossary_term' = 'Kit Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `missed_doses` SET TAGS ('dbx_business_glossary_term' = 'Missed Doses Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Protocol Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `quantity_dispensed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Dispensed');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `quantity_returned` SET TAGS ('dbx_business_glossary_term' = 'Quantity Returned');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `randomization_number` SET TAGS ('dbx_business_glossary_term' = 'Randomization Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `randomization_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `randomization_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'Return Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_business_glossary_term' = 'Study Sponsor Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `storage_instructions` SET TAGS ('dbx_business_glossary_term' = 'Storage Instructions');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `storage_instructions` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `subject_number` SET TAGS ('dbx_business_glossary_term' = 'Subject Enrollment Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `subject_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `subject_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `subject_signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Subject Signature Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`ip_dispensation` ALTER COLUMN `temperature_at_dispensation` SET TAGS ('dbx_business_glossary_term' = 'Temperature at Dispensation (Celsius)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` SET TAGS ('dbx_subdomain' = 'subject_conduct');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `biospecimen_id` SET TAGS ('dbx_business_glossary_term' = 'Biospecimen Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `cda_document_id` SET TAGS ('dbx_business_glossary_term' = 'Cda Document Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Collector Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `genetic_testing_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Genetic Testing Consent Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `inventory_location_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Location Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Research Subject Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `parent_biospecimen_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Biospecimen Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Study Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `aliquot_number` SET TAGS ('dbx_business_glossary_term' = 'Aliquot Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `anatomical_site` SET TAGS ('dbx_business_glossary_term' = 'Anatomical Collection Site');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Biospecimen Barcode');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `box_position` SET TAGS ('dbx_business_glossary_term' = 'Box Position');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `chain_of_custody_log` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Log');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `chain_of_custody_log` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `collection_time` SET TAGS ('dbx_business_glossary_term' = 'Collection Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `collection_volume` SET TAGS ('dbx_business_glossary_term' = 'Collection Volume');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `collection_volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Collection Volume Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `collection_volume_unit` SET TAGS ('dbx_value_regex' = 'mL|L|uL|g|mg');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `consent_for_future_use` SET TAGS ('dbx_business_glossary_term' = 'Consent for Future Use');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `deidentification_status` SET TAGS ('dbx_business_glossary_term' = 'De-identification Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `deidentification_status` SET TAGS ('dbx_value_regex' = 'identified|de_identified|anonymized|coded');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Specimen Disposition');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'stored|analyzed|shipped|destroyed|depleted|transferred');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `processing_date` SET TAGS ('dbx_business_glossary_term' = 'Processing Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `processing_method` SET TAGS ('dbx_business_glossary_term' = 'Processing Method');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `processing_time` SET TAGS ('dbx_business_glossary_term' = 'Processing Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `protocol_deviation_description` SET TAGS ('dbx_business_glossary_term' = 'Protocol Deviation Description');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `protocol_deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Protocol Deviation Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `quality_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Notes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `rack_position` SET TAGS ('dbx_business_glossary_term' = 'Rack Position');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Shipment Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `shipment_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `shipped_to_facility` SET TAGS ('dbx_business_glossary_term' = 'Shipped to Facility');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `shipped_to_facility` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_quality` SET TAGS ('dbx_business_glossary_term' = 'Specimen Quality');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_quality` SET TAGS ('dbx_value_regex' = 'acceptable|marginal|unacceptable|compromised');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_status` SET TAGS ('dbx_business_glossary_term' = 'Specimen Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_subtype` SET TAGS ('dbx_business_glossary_term' = 'Specimen Subtype');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `specimen_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `storage_container_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Container Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `storage_container_type` SET TAGS ('dbx_value_regex' = 'freezer|refrigerator|liquid_nitrogen|ambient|cryogenic');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `storage_container_type` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `storage_temperature` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature (Celsius)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `storage_temperature` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`biospecimen` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `data_safety_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Data Safety Monitoring ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `compliance_regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `dsmb_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Data Safety Monitoring Board (DSMB) Committee ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `research_document_id` SET TAGS ('dbx_business_glossary_term' = 'Meeting Minutes Document ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `adverse_events_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Adverse Events Reviewed');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `charter_version` SET TAGS ('dbx_business_glossary_term' = 'DSMB Charter Version');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'DSMB Meeting Confidentiality Level');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'open|closed|partially_closed');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `data_lock_date` SET TAGS ('dbx_business_glossary_term' = 'Data Lock Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `dsmb_recommendation` SET TAGS ('dbx_business_glossary_term' = 'DSMB Recommendation');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `dsmb_recommendation` SET TAGS ('dbx_value_regex' = 'continue_as_planned|modify_protocol|suspend_enrollment|terminate_trial|increase_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `fda_notification_date` SET TAGS ('dbx_business_glossary_term' = 'FDA Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `fda_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Notification Required');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `implementation_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Implementation Action Taken');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `interim_analysis_trigger` SET TAGS ('dbx_business_glossary_term' = 'Interim Analysis Trigger');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `irb_notification_date` SET TAGS ('dbx_business_glossary_term' = 'IRB Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `irb_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Notification Required');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_date` SET TAGS ('dbx_business_glossary_term' = 'DSMB Meeting Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_number` SET TAGS ('dbx_business_glossary_term' = 'DSMB Meeting Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_type` SET TAGS ('dbx_business_glossary_term' = 'DSMB Meeting Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `meeting_type` SET TAGS ('dbx_value_regex' = 'scheduled|ad_hoc|interim_analysis|final_review|emergency');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `monitoring_status` SET TAGS ('dbx_business_glossary_term' = 'DSMB Monitoring Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `monitoring_status` SET TAGS ('dbx_value_regex' = 'active|suspended|completed|terminated');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `next_review_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Next DSMB Review Scheduled Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'DSMB Meeting Notes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `protocol_modification_required` SET TAGS ('dbx_business_glossary_term' = 'Protocol Modification Required');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `recommendation_rationale` SET TAGS ('dbx_business_glossary_term' = 'DSMB Recommendation Rationale');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'draft|final|amended|archived');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `safety_stopping_rule_evaluated` SET TAGS ('dbx_business_glossary_term' = 'Safety Stopping Rule Evaluated');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `serious_adverse_events_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Serious Adverse Events (SAE) Reviewed');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `sponsor_response` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Response to DSMB Recommendation');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `sponsor_response` SET TAGS ('dbx_value_regex' = 'accepted|accepted_with_modifications|rejected|under_review');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `sponsor_response_date` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Response Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `sponsor_response_rationale` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Response Rationale');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `statistical_report_document_code` SET TAGS ('dbx_business_glossary_term' = 'Statistical Report Document ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `stopping_rule_threshold_met` SET TAGS ('dbx_business_glossary_term' = 'Stopping Rule Threshold Met');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `subjects_completed_at_review` SET TAGS ('dbx_business_glossary_term' = 'Subjects Completed at Review');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `subjects_enrolled_at_review` SET TAGS ('dbx_business_glossary_term' = 'Subjects Enrolled at Review');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `unblinding_event_occurred` SET TAGS ('dbx_business_glossary_term' = 'Unblinding Event Occurred');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `unblinding_justification` SET TAGS ('dbx_business_glossary_term' = 'Unblinding Justification');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `unblinding_scope` SET TAGS ('dbx_business_glossary_term' = 'Unblinding Scope');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_safety_monitoring` ALTER COLUMN `unblinding_scope` SET TAGS ('dbx_value_regex' = 'none|partial|full|treatment_arm_only');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` SET TAGS ('dbx_subdomain' = 'financial_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `billing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Research Billing Event ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `charge_id` SET TAGS ('dbx_business_glossary_term' = 'Charge ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `coverage_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Analysis ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `coverage_analysis_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `lab_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Charge Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `claim_line_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Line Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `procedure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `stark_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Stark Arrangement Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Analysis Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `analyst_name` SET TAGS ('dbx_business_glossary_term' = 'Coverage Analyst Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review|escalated');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `billing_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `clinical_trial_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Policy Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `cms_ncd_reference` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) National Coverage Determination (NCD) Reference');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `coverage_determination` SET TAGS ('dbx_business_glossary_term' = 'Coverage Determination');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `coverage_determination` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `cpt_code` SET TAGS ('dbx_business_glossary_term' = 'Current Procedural Terminology (CPT) Code');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `determination_rationale` SET TAGS ('dbx_business_glossary_term' = 'Determination Rationale');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Research Billing Event Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `grant_number` SET TAGS ('dbx_business_glossary_term' = 'Grant Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `hcpcs_code` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Common Procedure Coding System (HCPCS) Code');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `payer_specific_determination` SET TAGS ('dbx_business_glossary_term' = 'Payer-Specific Determination');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `payer_type` SET TAGS ('dbx_business_glossary_term' = 'Payer Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `principal_investigator_npi` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `procedure_description` SET TAGS ('dbx_business_glossary_term' = 'Procedure Description');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `protocol_phase` SET TAGS ('dbx_business_glossary_term' = 'Protocol Phase');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `service_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`billing_event` ALTER COLUMN `standard_of_care_flag` SET TAGS ('dbx_business_glossary_term' = 'Standard of Care Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` SET TAGS ('dbx_subdomain' = 'financial_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `grant_expenditure_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Expenditure ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `charge_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `research_grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `allocable_flag` SET TAGS ('dbx_business_glossary_term' = 'Allocable Cost Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `allowable_flag` SET TAGS ('dbx_business_glossary_term' = 'Allowable Cost Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Amount');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `audit_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `award_number` SET TAGS ('dbx_business_glossary_term' = 'Award Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `budget_period` SET TAGS ('dbx_business_glossary_term' = 'Budget Period');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Amount');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `cost_share_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `grant_expenditure_description` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Description');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `direct_cost_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Cost Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `effort_percentage` SET TAGS ('dbx_business_glossary_term' = 'Effort Percentage');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `effort_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `expense_category` SET TAGS ('dbx_business_glossary_term' = 'Expense Category');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `fund_code` SET TAGS ('dbx_business_glossary_term' = 'Fund Code');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `reasonable_flag` SET TAGS ('dbx_business_glossary_term' = 'Reasonable Cost Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `sponsor_code` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Code');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_expenditure` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` SET TAGS ('dbx_subdomain' = 'study_management');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `study_sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Study Sponsor Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `business_associate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Business Associate Agreement Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `conflict_of_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Of Interest Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `agreement_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `agreement_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `budget_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `budget_version` SET TAGS ('dbx_business_glossary_term' = 'Study Budget Version');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `cro_relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Research Organization (CRO) Relationship Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `cro_relationship_type` SET TAGS ('dbx_value_regex' = 'direct_sponsor|cro_delegated|hybrid|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `financial_disclosure_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Disclosure Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `invoicing_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Invoicing Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `invoicing_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `invoicing_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `invoicing_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `invoicing_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Invoicing Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `invoicing_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `invoicing_contact_name` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `master_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Agreement Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `master_agreement_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `nda_bla_holder_flag` SET TAGS ('dbx_business_glossary_term' = 'New Drug Application (NDA) or Biologics License Application (BLA) Holder Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `negotiated_cost_flag` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Cost Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `overhead_indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Overhead or Indirect Cost Rate Percentage');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `overhead_indirect_cost_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `payment_milestone_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Milestone Terms');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `payment_milestone_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `payment_schedule_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule Frequency');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `payment_schedule_frequency` SET TAGS ('dbx_value_regex' = 'per_visit|monthly|quarterly|milestone_based|study_completion');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `per_procedure_reimbursement_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Procedure Reimbursement Rate');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `per_procedure_reimbursement_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `per_visit_reimbursement_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Visit Reimbursement Rate');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `per_visit_reimbursement_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Sponsor Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Sponsor Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Sponsor Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `screen_failure_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Screen Failure Allowance Amount');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `screen_failure_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_city` SET TAGS ('dbx_business_glossary_term' = 'Sponsor City');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_country_code` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Country Code');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_country_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Legal Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_notes` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Notes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_state_province` SET TAGS ('dbx_business_glossary_term' = 'Sponsor State or Province');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_status` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Relationship Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `sponsor_type` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Type Classification');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `startup_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Study Startup Cost Amount');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `startup_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Tax Identification Number (TIN)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_sponsor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` SET TAGS ('dbx_subdomain' = 'financial_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `coverage_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Analysis ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `coverage_analysis_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `compliance_regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `protocol_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol Amendment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `superseded_by_coverage_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Coverage Analysis ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `superseded_by_coverage_analysis_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Test Catalog Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Analysis Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `analysis_document_number` SET TAGS ('dbx_business_glossary_term' = 'Coverage Analysis Document Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `analysis_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Analysis Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `analysis_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|rejected|superseded|archived');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `analyst_title` SET TAGS ('dbx_business_glossary_term' = 'Analyst Title');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `clinical_trial_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Agreement Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Coverage Analysis Comments');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `commercial_coverage_determination` SET TAGS ('dbx_business_glossary_term' = 'Commercial Payer Coverage Determination');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `commercial_coverage_determination` SET TAGS ('dbx_value_regex' = 'standard_of_care|research_only|mixed|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `commercial_coverage_determination` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `determination_rationale` SET TAGS ('dbx_business_glossary_term' = 'Determination Rationale');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `investigational_device_flag` SET TAGS ('dbx_business_glossary_term' = 'Investigational Device Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `investigational_drug_flag` SET TAGS ('dbx_business_glossary_term' = 'Investigational Drug Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `lcd_reference` SET TAGS ('dbx_business_glossary_term' = 'Local Coverage Determination (LCD) Reference');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `medicaid_coverage_determination` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Coverage Determination');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `medicaid_coverage_determination` SET TAGS ('dbx_value_regex' = 'standard_of_care|research_only|mixed|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `medicaid_coverage_determination` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `medicare_coverage_determination` SET TAGS ('dbx_business_glossary_term' = 'Medicare Coverage Determination');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `medicare_coverage_determination` SET TAGS ('dbx_value_regex' = 'standard_of_care|research_only|mixed|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `medicare_coverage_determination` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `ncd_reference` SET TAGS ('dbx_business_glossary_term' = 'National Coverage Determination (NCD) Reference');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `ndc_codes_reviewed` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC) Codes Reviewed');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `off_label_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Off-Label Use Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `payer_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Payer Policy Reference');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `payer_type` SET TAGS ('dbx_business_glossary_term' = 'Payer Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Protocol Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `protocol_version_date` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `research_only_services_count` SET TAGS ('dbx_business_glossary_term' = 'Research Only Services Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `reviewer_title` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Title');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `routine_cost_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Routine Cost Coverage Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `routine_cost_coverage_flag` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `sponsor_coverage_commitment` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Coverage Commitment');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `sponsor_coverage_commitment` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`coverage_analysis` ALTER COLUMN `standard_of_care_services_count` SET TAGS ('dbx_business_glossary_term' = 'Standard of Care Services Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `research_regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Research Regulatory Submission Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `interface_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Interface Channel Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `protocol_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol Amendment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Acknowledgment Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Action Due Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `action_required_description` SET TAGS ('dbx_business_glossary_term' = 'Action Required Description');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Action Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `agency_division` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Division');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `agency_division` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `agency_response_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Response Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `agency_response_date` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `agency_response_letter` SET TAGS ('dbx_business_glossary_term' = 'Agency Response Letter Reference');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `agency_response_letter` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `bla_number` SET TAGS ('dbx_business_glossary_term' = 'Biologics License Application (BLA) Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `cfr_part_11_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Code of Federal Regulations (CFR) Part 11 Compliant Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `determination_outcome` SET TAGS ('dbx_business_glossary_term' = 'Agency Determination Outcome');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `determination_outcome` SET TAGS ('dbx_value_regex' = 'Approved|Approved with Conditions|Not Approved|Clinical Hold|Withdrawn|Pending');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `ectd_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Common Technical Document (eCTD) Sequence Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `fda_regulated_device_flag` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Regulated Device Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `fda_regulated_drug_flag` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Regulated Drug Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `ide_number` SET TAGS ('dbx_business_glossary_term' = 'Investigational Device Exemption (IDE) Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `ind_number` SET TAGS ('dbx_business_glossary_term' = 'Investigational New Drug (IND) Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `nct_number` SET TAGS ('dbx_business_glossary_term' = 'National Clinical Trial (NCT) Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `nda_number` SET TAGS ('dbx_business_glossary_term' = 'New Drug Application (NDA) Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `principal_investigator_npi` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Research Protocol Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Research Protocol Version');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_value_regex' = 'FDA|NIH|OHRP|CMS|DEA|Other');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `sponsor_organization` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Organization Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Submission Contact Email Address');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_contact_email` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Submission Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Submission Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_contact_phone` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'eCTD|Paper|Electronic Gateway|Portal|Other');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Notes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `monitoring_visit_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Visit Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Monitor Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `study_site_id` SET TAGS ('dbx_business_glossary_term' = 'Study Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `adverse_event_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event (AE) Review Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `corrective_action_plan_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Due Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `corrective_action_plan_received_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Received Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `corrective_action_plan_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `data_discrepancies_noted_count` SET TAGS ('dbx_business_glossary_term' = 'Data Discrepancies Noted Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `follow_up_visit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Visit Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `follow_up_visit_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Visit Scheduled Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `informed_consent_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Review Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `investigational_product_accountability_flag` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product Accountability Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `monitor_organization` SET TAGS ('dbx_business_glossary_term' = 'Monitor Organization');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `monitor_type` SET TAGS ('dbx_business_glossary_term' = 'Monitor Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `monitor_type` SET TAGS ('dbx_value_regex' = 'sponsor|cro|internal|independent');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `protocol_deviations_identified_count` SET TAGS ('dbx_business_glossary_term' = 'Protocol Deviations Identified Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `regulatory_document_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Document Review Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `remote_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Monitoring Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `risk_based_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Monitoring (RBM) Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `sdv_percentage` SET TAGS ('dbx_business_glossary_term' = 'Source Data Verification (SDV) Percentage');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `sdv_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `site_coordinator_name` SET TAGS ('dbx_business_glossary_term' = 'Site Coordinator Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `site_coordinator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `source_data_verification_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Source Data Verification (SDV) Performed Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `subjects_enrolled_count` SET TAGS ('dbx_business_glossary_term' = 'Subjects Enrolled Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `subjects_reviewed_count` SET TAGS ('dbx_business_glossary_term' = 'Subjects Reviewed Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `visit_date` SET TAGS ('dbx_business_glossary_term' = 'Visit Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `visit_end_time` SET TAGS ('dbx_business_glossary_term' = 'Visit End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `visit_number` SET TAGS ('dbx_business_glossary_term' = 'Visit Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `visit_objectives` SET TAGS ('dbx_business_glossary_term' = 'Visit Objectives');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `visit_report_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Visit Report Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `visit_report_document_code` SET TAGS ('dbx_business_glossary_term' = 'Visit Report Document Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `visit_report_status` SET TAGS ('dbx_business_glossary_term' = 'Visit Report Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `visit_report_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|finalized|approved|distributed');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `visit_start_time` SET TAGS ('dbx_business_glossary_term' = 'Visit Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `visit_status` SET TAGS ('dbx_business_glossary_term' = 'Visit Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `visit_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|pending_report');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `visit_type` SET TAGS ('dbx_business_glossary_term' = 'Visit Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`monitoring_visit` ALTER COLUMN `visit_type` SET TAGS ('dbx_value_regex' = 'initiation|routine|interim|close_out|for_cause|triggered');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `protocol_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol Deviation Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `deficiency_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Deficiency Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `study_site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `subject_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Enrollment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `audit_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `capa_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action (CAPA)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `data_lock_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Lock Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `data_lock_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Lock Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `detected_by_role` SET TAGS ('dbx_business_glossary_term' = 'Detected By Role');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `deviation_category` SET TAGS ('dbx_business_glossary_term' = 'Deviation Category');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `deviation_category` SET TAGS ('dbx_value_regex' = 'eligibility|dosing|visit_window|consent|data_collection|inclusion_exclusion');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `deviation_date` SET TAGS ('dbx_business_glossary_term' = 'Deviation Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `deviation_description` SET TAGS ('dbx_business_glossary_term' = 'Deviation Description');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `deviation_notes` SET TAGS ('dbx_business_glossary_term' = 'Deviation Notes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `deviation_number` SET TAGS ('dbx_business_glossary_term' = 'Protocol Deviation Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `deviation_severity` SET TAGS ('dbx_business_glossary_term' = 'Deviation Severity');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `deviation_severity` SET TAGS ('dbx_value_regex' = 'minor|major|critical');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `deviation_status` SET TAGS ('dbx_business_glossary_term' = 'Deviation Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `deviation_status` SET TAGS ('dbx_value_regex' = 'open|under_review|closed|pending_capa');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `fda_report_date` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Report Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `fda_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Reportable Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `gcp_compliance_impact` SET TAGS ('dbx_business_glossary_term' = 'Good Clinical Practice (GCP) Compliance Impact');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `impact_on_data_integrity` SET TAGS ('dbx_business_glossary_term' = 'Impact on Data Integrity');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `impact_on_subject_safety` SET TAGS ('dbx_business_glossary_term' = 'Impact on Subject Safety');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `irb_report_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Report Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `irb_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Reportable Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `monitoring_visit_number` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Visit Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `preventive_action` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action (CAPA)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `protocol_section_reference` SET TAGS ('dbx_business_glossary_term' = 'Protocol Section Reference');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `reviewed_by_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `reviewed_by_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `sponsor_report_date` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Report Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`protocol_deviation` ALTER COLUMN `sponsor_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Reportable Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` SET TAGS ('dbx_subdomain' = 'financial_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `deidentified_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'De-identified Dataset Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `business_associate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Business Associate Agreement Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `fhir_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Fhir Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `access_tier` SET TAGS ('dbx_business_glossary_term' = 'Access Tier');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `access_tier` SET TAGS ('dbx_value_regex' = 'internal|limited_dataset|fully_deidentified|public|controlled_access');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `approved_use_cases` SET TAGS ('dbx_business_glossary_term' = 'Approved Use Cases');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `cfr_part_11_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Code of Federal Regulations (CFR) Part 11 Compliant Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_dictionary_url` SET TAGS ('dbx_business_glossary_term' = 'Data Dictionary Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_elements_included` SET TAGS ('dbx_business_glossary_term' = 'Data Elements Included');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_sharing_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Agreement Reference');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_steward_department` SET TAGS ('dbx_business_glossary_term' = 'Data Steward Department');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_steward_email` SET TAGS ('dbx_business_glossary_term' = 'Data Steward Email');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_steward_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_steward_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_steward_email` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_steward_name` SET TAGS ('dbx_business_glossary_term' = 'Data Steward Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `data_use_agreement_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Use Agreement (DUA) Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `dataset_code` SET TAGS ('dbx_business_glossary_term' = 'Dataset Code');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `dataset_creation_date` SET TAGS ('dbx_business_glossary_term' = 'Dataset Creation Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `dataset_description` SET TAGS ('dbx_business_glossary_term' = 'Dataset Description');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `dataset_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Dataset Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `dataset_format` SET TAGS ('dbx_business_glossary_term' = 'Dataset Format');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `dataset_location_path` SET TAGS ('dbx_business_glossary_term' = 'Dataset Location Path');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `dataset_location_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `dataset_name` SET TAGS ('dbx_business_glossary_term' = 'Dataset Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `dataset_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Dataset Size in Megabytes (MB)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `dataset_status` SET TAGS ('dbx_business_glossary_term' = 'Dataset Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `dataset_type` SET TAGS ('dbx_business_glossary_term' = 'Dataset Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `dataset_version` SET TAGS ('dbx_business_glossary_term' = 'Dataset Version');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `date_range_end` SET TAGS ('dbx_business_glossary_term' = 'Date Range End');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `date_range_start` SET TAGS ('dbx_business_glossary_term' = 'Date Range Start');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `deidentification_date` SET TAGS ('dbx_business_glossary_term' = 'De-identification Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `deidentification_method` SET TAGS ('dbx_business_glossary_term' = 'De-identification Method');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `deidentification_method` SET TAGS ('dbx_value_regex' = 'safe_harbor|expert_determination|limited_dataset|statistical_deidentification|anonymization');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `deidentification_performed_by` SET TAGS ('dbx_business_glossary_term' = 'De-identification Performed By');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `expert_determination_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Expert Determination Certification Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `expert_name` SET TAGS ('dbx_business_glossary_term' = 'Expert Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `hipaa_limited_dataset_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Limited Dataset Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `irb_waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Waiver Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `irb_waiver_reference` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Waiver Reference');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `nih_data_sharing_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'National Institutes of Health (NIH) Data Sharing Compliant Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `patient_population_count` SET TAGS ('dbx_business_glossary_term' = 'Patient Population Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `phi_elements_removed` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Elements Removed');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `publication_embargo_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Embargo Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `record_count` SET TAGS ('dbx_business_glossary_term' = 'Record Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `reidentification_risk_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Re-identification Risk Assessment Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `reidentification_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Re-identification Risk Score');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `restricted_use_cases` SET TAGS ('dbx_business_glossary_term' = 'Restricted Use Cases');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `source_database` SET TAGS ('dbx_business_glossary_term' = 'Source Database');
ALTER TABLE `vibe_healthcare_v1`.`research`.`deidentified_dataset` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` SET TAGS ('dbx_subdomain' = 'financial_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `data_access_request_id` SET TAGS ('dbx_business_glossary_term' = 'Data Access Request ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `business_associate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Business Associate Agreement Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `data_governance_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Committee ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `deidentified_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Deidentified Dataset Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `dua_document_id` SET TAGS ('dbx_business_glossary_term' = 'Data Use Agreement (DUA) Document ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `fhir_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Fhir Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `access_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Access Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `access_granted_date` SET TAGS ('dbx_business_glossary_term' = 'Access Granted Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `access_method` SET TAGS ('dbx_business_glossary_term' = 'Access Method');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `access_method` SET TAGS ('dbx_value_regex' = 'secure_portal|data_enclave|direct_download|physical_media|api_access');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `conditions_of_approval` SET TAGS ('dbx_business_glossary_term' = 'Conditions of Approval');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_value_regex' = 'de_identified|limited_dataset|identified|phi');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `data_destruction_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Data Destruction Certification Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `data_destruction_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Destruction Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `determination_decision` SET TAGS ('dbx_business_glossary_term' = 'Determination Decision');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `determination_decision` SET TAGS ('dbx_value_regex' = 'approved|denied|conditional_approval|withdrawn');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `dua_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Data Use Agreement (DUA) Execution Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `dua_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Data Use Agreement (DUA) Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `dua_status` SET TAGS ('dbx_business_glossary_term' = 'Data Use Agreement (DUA) Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `dua_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|executed|expired|terminated');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `hipaa_compliance_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Compliance Verified Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `intended_use` SET TAGS ('dbx_business_glossary_term' = 'Intended Use');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `irb_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `irb_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `irb_institution_name` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Institution Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `nih_data_sharing_policy_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'National Institutes of Health (NIH) Data Sharing Policy Compliant Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `publication_acknowledgment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Publication Acknowledgment Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `request_notes` SET TAGS ('dbx_business_glossary_term' = 'Request Notes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Request Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Request Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'internal|external|collaborative|commercial');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_department` SET TAGS ('dbx_business_glossary_term' = 'Requestor Department');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_business_glossary_term' = 'Requestor Email Address');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_institution` SET TAGS ('dbx_business_glossary_term' = 'Requestor Institution');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `requestor_title` SET TAGS ('dbx_business_glossary_term' = 'Requestor Title');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `research_purpose_category` SET TAGS ('dbx_business_glossary_term' = 'Research Purpose Category');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `research_purpose_category` SET TAGS ('dbx_value_regex' = 'clinical_research|population_health|quality_improvement|health_services_research|educational|commercial');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Start Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_access_request` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` SET TAGS ('dbx_subdomain' = 'financial_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `study_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Study Budget Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Coordinator Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Institutional Budget Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `stark_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Stark Arrangement Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `study_sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Study Sponsor Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `superseded_by_study_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Budget Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `budget_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `budget_approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Approved By Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `budget_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `budget_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `budget_negotiated_by_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Negotiated By Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'sponsor_negotiated|institutional_cost|hybrid|investigator_initiated');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `budget_version_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `closeout_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Closeout Cost Amount');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `coverage_analysis_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Coverage Analysis Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `coverage_analysis_required_flag` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `enrollment_bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Bonus Amount');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `holdback_percentage` SET TAGS ('dbx_business_glossary_term' = 'Holdback Percentage');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `holdback_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `holdback_release_condition` SET TAGS ('dbx_business_glossary_term' = 'Holdback Release Condition');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `investigational_drug_cost_covered_flag` SET TAGS ('dbx_business_glossary_term' = 'Investigational Drug Cost Covered Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `overhead_amount` SET TAGS ('dbx_business_glossary_term' = 'Overhead Amount');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `overhead_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overhead Rate Percentage');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `overhead_rate_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `payment_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `payment_schedule_type` SET TAGS ('dbx_value_regex' = 'per_visit|per_procedure|milestone|monthly|quarterly');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `per_patient_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Per Patient Budget Amount');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `pharmacy_preparation_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Preparation Fee Amount');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `research_only_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Research Only Cost Amount');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `retention_bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Bonus Amount');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `screen_failure_allowance_count` SET TAGS ('dbx_business_glossary_term' = 'Screen Failure Allowance Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `screen_failure_reimbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Screen Failure Reimbursement Amount');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `standard_of_care_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Standard of Care Cost Amount');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `startup_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Startup Cost Amount');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `target_enrollment_count` SET TAGS ('dbx_business_glossary_term' = 'Target Enrollment Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_budget` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Amount');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `consent_template_id` SET TAGS ('dbx_business_glossary_term' = 'Research Consent Template ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `protocol_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol Amendment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `superseded_by_consent_template_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Template ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Training Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Template Comments');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `compensation_disclosure` SET TAGS ('dbx_business_glossary_term' = 'Compensation Disclosure');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `compensation_disclosure` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `compensation_disclosure` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `contact_information` SET TAGS ('dbx_business_glossary_term' = 'Study Contact Information');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `contact_information` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `data_sharing_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Consent Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Template Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `future_use_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Future Use Consent Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `genetic_testing_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Genetic Testing Consent Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `hipaa_authorization_included_flag` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Authorization Included Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `injury_compensation_disclosure` SET TAGS ('dbx_business_glossary_term' = 'Injury Compensation Disclosure');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `injury_compensation_disclosure` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `injury_compensation_disclosure` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `irb_approval_date` SET TAGS ('dbx_business_glossary_term' = 'IRB Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `irb_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'IRB Approval Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `reading_level` SET TAGS ('dbx_business_glossary_term' = 'Reading Level Grade');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `reconsent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reconsent Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `required_elements_checklist` SET TAGS ('dbx_business_glossary_term' = 'Required Elements Checklist');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `superseded_date` SET TAGS ('dbx_business_glossary_term' = 'Template Superseded Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `template_document_hash` SET TAGS ('dbx_business_glossary_term' = 'Template Document Hash');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `template_document_url` SET TAGS ('dbx_business_glossary_term' = 'Template Document URL');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `template_number` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Form (ICF) Template Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `template_status` SET TAGS ('dbx_business_glossary_term' = 'Template Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `template_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `template_type` SET TAGS ('dbx_value_regex' = 'full_icf|short_form|assent_form|hipaa_authorization|parental_permission|lad_form');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `template_version` SET TAGS ('dbx_business_glossary_term' = 'Template Version Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `vulnerable_population_flag` SET TAGS ('dbx_business_glossary_term' = 'Vulnerable Population Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `vulnerable_population_type` SET TAGS ('dbx_business_glossary_term' = 'Vulnerable Population Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`consent_template` ALTER COLUMN `vulnerable_population_type` SET TAGS ('dbx_value_regex' = 'children|prisoners|pregnant_women|cognitively_impaired|economically_disadvantaged|none');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` SET TAGS ('dbx_subdomain' = 'study_management');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `study_arm_id` SET TAGS ('dbx_business_glossary_term' = 'Study Arm Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `actual_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Actual Enrollment Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `arm_close_date` SET TAGS ('dbx_business_glossary_term' = 'Arm Close Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `arm_name` SET TAGS ('dbx_business_glossary_term' = 'Arm Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `arm_notes` SET TAGS ('dbx_business_glossary_term' = 'Arm Notes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `arm_number` SET TAGS ('dbx_business_glossary_term' = 'Arm Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `arm_open_date` SET TAGS ('dbx_business_glossary_term' = 'Arm Open Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `arm_status` SET TAGS ('dbx_business_glossary_term' = 'Arm Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `arm_status` SET TAGS ('dbx_value_regex' = 'open|closed|suspended|terminated|completed');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `arm_suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Arm Suspension Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `arm_suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Arm Suspension Reason');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `arm_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Arm Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `arm_termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Arm Termination Reason');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `arm_type` SET TAGS ('dbx_business_glossary_term' = 'Arm Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `arm_type` SET TAGS ('dbx_value_regex' = 'experimental|active_comparator|placebo_comparator|sham_comparator|no_intervention|observational');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `blinding_status` SET TAGS ('dbx_business_glossary_term' = 'Blinding Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `blinding_status` SET TAGS ('dbx_value_regex' = 'open_label|single_blind|double_blind|triple_blind|quadruple_blind');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `concomitant_medication_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Concomitant Medication Restrictions');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `control_arm_flag` SET TAGS ('dbx_business_glossary_term' = 'Control Arm Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `crossover_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Crossover Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `crossover_trigger` SET TAGS ('dbx_business_glossary_term' = 'Crossover Trigger');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `data_lock_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Lock Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `data_lock_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Lock Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `dose_level` SET TAGS ('dbx_business_glossary_term' = 'Dose Level');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `dose_unit` SET TAGS ('dbx_business_glossary_term' = 'Dose Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `dosing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Dosing Frequency');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `eligibility_criteria_notes` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria Notes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `intervention_description` SET TAGS ('dbx_business_glossary_term' = 'Intervention Description');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `intervention_name` SET TAGS ('dbx_business_glossary_term' = 'Intervention Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `intervention_type` SET TAGS ('dbx_business_glossary_term' = 'Intervention Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `planned_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Planned Enrollment Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `primary_endpoint_measure` SET TAGS ('dbx_business_glossary_term' = 'Primary Endpoint Measure');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `protocol_version_date` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `randomization_ratio` SET TAGS ('dbx_business_glossary_term' = 'Randomization Ratio');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|deleted');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `safety_monitoring_plan` SET TAGS ('dbx_business_glossary_term' = 'Safety Monitoring Plan');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `secondary_endpoint_measures` SET TAGS ('dbx_business_glossary_term' = 'Secondary Endpoint Measures');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `stratification_factors` SET TAGS ('dbx_business_glossary_term' = 'Stratification Factors');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `treatment_duration` SET TAGS ('dbx_business_glossary_term' = 'Treatment Duration');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `treatment_duration` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_arm` ALTER COLUMN `treatment_duration` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` SET TAGS ('dbx_subdomain' = 'study_management');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` SET TAGS ('dbx_association_edges' = 'research.research_study,interoperability.trading_partner');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `study_partner_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Study Partner Agreement ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Partner Agreement - Research Study Id');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `trading_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Study Partner Agreement - Trading Partner Id');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `data_flow_direction` SET TAGS ('dbx_business_glossary_term' = 'Data Flow Direction');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `data_sharing_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Agreement Reference');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `message_volume_monthly` SET TAGS ('dbx_business_glossary_term' = 'Monthly Message Volume');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `message_volume_monthly` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `partner_role` SET TAGS ('dbx_business_glossary_term' = 'Partner Role');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'SLA Response Time Hours');
ALTER TABLE `vibe_healthcare_v1`.`research`.`study_partner_agreement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` SET TAGS ('dbx_subdomain' = 'financial_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` SET TAGS ('dbx_association_edges' = 'workforce.employee,research.grant');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ALTER COLUMN `grant_personnel_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Personnel - Grant Personnel Id');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Personnel - Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ALTER COLUMN `research_grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Personnel - Grant Id');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ALTER COLUMN `appointment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Grant Appointment End Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ALTER COLUMN `appointment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Grant Appointment Start Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ALTER COLUMN `appointment_status` SET TAGS ('dbx_business_glossary_term' = 'Grant Appointment Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ALTER COLUMN `budget_period` SET TAGS ('dbx_business_glossary_term' = 'Budget Period');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Percentage');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ALTER COLUMN `effort_percentage` SET TAGS ('dbx_business_glossary_term' = 'Effort Percentage');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ALTER COLUMN `effort_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ALTER COLUMN `fte_on_grant` SET TAGS ('dbx_business_glossary_term' = 'FTE on Grant');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ALTER COLUMN `key_personnel_flag` SET TAGS ('dbx_business_glossary_term' = 'Key Personnel Indicator');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ALTER COLUMN `role` SET TAGS ('dbx_business_glossary_term' = 'Grant Role');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ALTER COLUMN `salary_charged` SET TAGS ('dbx_business_glossary_term' = 'Salary Charged to Grant');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ALTER COLUMN `salary_charged` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`grant_personnel` ALTER COLUMN `salary_charged` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` SET TAGS ('dbx_subdomain' = 'subject_conduct');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` SET TAGS ('dbx_association_edges' = 'research.investigational_product,compliance.training');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ALTER COLUMN `investigational_product_training_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product Training Certification ID');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ALTER COLUMN `investigational_product_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product Training - Investigational Product Id');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product Training - Training Id');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ALTER COLUMN `administration_competency_verified` SET TAGS ('dbx_business_glossary_term' = 'Administration Competency Verified Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ALTER COLUMN `certification_authority` SET TAGS ('dbx_business_glossary_term' = 'Certification Authority');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ALTER COLUMN `handling_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Handling Certification Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ALTER COLUMN `product_specific_training_status` SET TAGS ('dbx_business_glossary_term' = 'Product-Specific Training Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ALTER COLUMN `recertification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recertification Due Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`investigational_product_training` ALTER COLUMN `training_version` SET TAGS ('dbx_business_glossary_term' = 'Training Version');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `dua_document_id` SET TAGS ('dbx_business_glossary_term' = 'Dua Document Identifier');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `hie_organization_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Organization Id');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `parent_dua_document_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Dua Document Id');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `primary_superseded_dua_document_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Dua Document Id');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `primary_superseded_dua_document_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `audit_rights_description` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Description');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `breach_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Breach Notification Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `data_classification_level` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `data_destruction_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Data Destruction Deadline Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `data_destruction_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Destruction Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `data_security_requirements` SET TAGS ('dbx_business_glossary_term' = 'Data Security Requirements');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `data_type` SET TAGS ('dbx_business_glossary_term' = 'Data Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `document_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Location');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `document_storage_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `document_storage_location` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `document_version_number` SET TAGS ('dbx_business_glossary_term' = 'Document Version Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `dua_number` SET TAGS ('dbx_business_glossary_term' = 'Dua Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `healthcare_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Signatory Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `healthcare_signatory_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `healthcare_signatory_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `healthcare_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Signatory Title');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `irb_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Irb Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `irb_protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Irb Protocol Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `permitted_use_description` SET TAGS ('dbx_business_glossary_term' = 'Permitted Use Description');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `principal_investigator_email` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Email');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `principal_investigator_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `principal_investigator_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `principal_investigator_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `prohibited_use_description` SET TAGS ('dbx_business_glossary_term' = 'Prohibited Use Description');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `publication_rights_description` SET TAGS ('dbx_business_glossary_term' = 'Publication Rights Description');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `recipient_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Signatory Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `recipient_signatory_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `recipient_signatory_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `recipient_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Recipient Signatory Title');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `renewal_count` SET TAGS ('dbx_business_glossary_term' = 'Renewal Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `dua_document_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dua_document` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` SET TAGS ('dbx_subdomain' = 'study_management');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `data_governance_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Committee Identifier');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `data_escalation_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Escalation Committee Id');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `data_escalation_committee_id` SET TAGS ('dbx_self_reference' = 'parent_committee');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `data_reporting_to_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting To Committee Id');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `data_secretary_person_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Secretary Person Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `data_secretary_person_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `data_secretary_person_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `data_vice_chair_person_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Vice Chair Person Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `data_vice_chair_person_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `data_vice_chair_person_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `parent_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Committee Id');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `parent_data_governance_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Data Governance Committee Id');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `parent_data_governance_committee_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `authority_level` SET TAGS ('dbx_business_glossary_term' = 'Authority Level');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `charter_description` SET TAGS ('dbx_business_glossary_term' = 'Charter Description');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `charter_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Charter Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `charter_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Charter Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `committee_code` SET TAGS ('dbx_business_glossary_term' = 'Committee Code');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `committee_name` SET TAGS ('dbx_business_glossary_term' = 'Committee Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `committee_type` SET TAGS ('dbx_business_glossary_term' = 'Committee Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `data_domain_coverage` SET TAGS ('dbx_business_glossary_term' = 'Data Domain Coverage');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `data_domain_coverage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `data_steward_appointment_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Steward Appointment Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `decision_making_model` SET TAGS ('dbx_business_glossary_term' = 'Decision Making Model');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dissolution Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `dissolution_reason` SET TAGS ('dbx_business_glossary_term' = 'Dissolution Reason');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `established_date` SET TAGS ('dbx_business_glossary_term' = 'Established Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `irb_alignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Irb Alignment Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `issue_resolution_authority_flag` SET TAGS ('dbx_business_glossary_term' = 'Issue Resolution Authority Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Meeting Frequency');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `meeting_location` SET TAGS ('dbx_business_glossary_term' = 'Meeting Location');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Member Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `policy_approval_authority_flag` SET TAGS ('dbx_business_glossary_term' = 'Policy Approval Authority Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `quorum_requirement` SET TAGS ('dbx_business_glossary_term' = 'Quorum Requirement');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `regulatory_oversight_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Oversight Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Scope');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `data_governance_committee_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`data_governance_committee` ALTER COLUMN `voting_member_count` SET TAGS ('dbx_business_glossary_term' = 'Voting Member Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` SET TAGS ('dbx_subdomain' = 'study_management');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `dsmb_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Dsmb Committee Identifier');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `parent_dsmb_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Dsmb Committee Id');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `parent_dsmb_committee_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `adverse_event_review_threshold` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Review Threshold');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `chair_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Chair Affiliation');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `chair_email` SET TAGS ('dbx_business_glossary_term' = 'Chair Email');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `chair_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `chair_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `chair_name` SET TAGS ('dbx_business_glossary_term' = 'Chair Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `chair_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `chair_phone` SET TAGS ('dbx_business_glossary_term' = 'Chair Phone');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `chair_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `chair_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `charter_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Charter Document Reference');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `charter_document_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `committee_code` SET TAGS ('dbx_business_glossary_term' = 'Committee Code');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `committee_name` SET TAGS ('dbx_business_glossary_term' = 'Committee Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `committee_type` SET TAGS ('dbx_business_glossary_term' = 'Committee Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `confidentiality_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Agreement Reference');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `confidentiality_agreement_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `conflict_of_interest_policy` SET TAGS ('dbx_business_glossary_term' = 'Conflict Of Interest Policy');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `conflict_of_interest_policy` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `data_access_level` SET TAGS ('dbx_business_glossary_term' = 'Data Access Level');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `data_quality_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Monitoring Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dissolution Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `efficacy_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Efficacy Monitoring Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `formation_date` SET TAGS ('dbx_business_glossary_term' = 'Formation Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `independent_flag` SET TAGS ('dbx_business_glossary_term' = 'Independent Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `independent_flag` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `interim_analysis_schedule` SET TAGS ('dbx_business_glossary_term' = 'Interim Analysis Schedule');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `last_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Last Meeting Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Meeting Frequency');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `meeting_minutes_location` SET TAGS ('dbx_business_glossary_term' = 'Meeting Minutes Location');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `meeting_minutes_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Member Count');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `next_scheduled_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Meeting Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `oversight_scope` SET TAGS ('dbx_business_glossary_term' = 'Oversight Scope');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `quorum_requirement` SET TAGS ('dbx_business_glossary_term' = 'Quorum Requirement');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `safety_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Monitoring Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `statistical_support_provider` SET TAGS ('dbx_business_glossary_term' = 'Statistical Support Provider');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `dsmb_committee_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `stopping_rule_criteria` SET TAGS ('dbx_business_glossary_term' = 'Stopping Rule Criteria');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `stopping_rule_criteria` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`dsmb_committee` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `research_document_id` SET TAGS ('dbx_business_glossary_term' = 'Research Document Identifier');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `irb_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Irb Submission Id');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `primary_research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `primary_superseded_by_research_document_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Document Id');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Id');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `research_study_id` SET TAGS ('dbx_source_attribute' = 'research_study_id');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `access_restriction_notes` SET TAGS ('dbx_business_glossary_term' = 'Access Restriction Notes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `access_restriction_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `approver_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `approver_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `author_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `author_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `author_organization` SET TAGS ('dbx_business_glossary_term' = 'Author Organization');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `checksum_value` SET TAGS ('dbx_business_glossary_term' = 'Checksum Value');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `destruction_eligible_date` SET TAGS ('dbx_business_glossary_term' = 'Destruction Eligible Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `electronic_signature_applied` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Applied');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'File Path');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size Bytes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signature Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `submission_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` SET TAGS ('dbx_subdomain' = 'financial_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `research_grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `compliance_regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `conflict_of_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Of Interest Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `audit_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `award_amount` SET TAGS ('dbx_business_glossary_term' = 'Award Amount');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `budget_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `budget_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `cfda_number` SET TAGS ('dbx_business_glossary_term' = 'Catalog of Federal Domestic Assistance (CFDA) Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `clinical_trial_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `closeout_date` SET TAGS ('dbx_business_glossary_term' = 'Closeout Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `direct_costs` SET TAGS ('dbx_business_glossary_term' = 'Direct Costs');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `fa_rate` SET TAGS ('dbx_business_glossary_term' = 'Facilities and Administrative (F&A) Rate');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `final_report_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Final Report Submitted Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `funding_agency` SET TAGS ('dbx_business_glossary_term' = 'Funding Agency');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `funding_agency` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `grant_number` SET TAGS ('dbx_business_glossary_term' = 'Grant Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_business_glossary_term' = 'Grant Status');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `grant_status` SET TAGS ('dbx_value_regex' = 'pending|active|suspended|closed|terminated');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `grant_type` SET TAGS ('dbx_business_glossary_term' = 'Grant Type');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `iacuc_protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Animal Care and Use Committee (IACUC) Protocol Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `indirect_costs` SET TAGS ('dbx_business_glossary_term' = 'Indirect Costs');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `institutional_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `irb_protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Protocol Number');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `prime_sponsor_flag` SET TAGS ('dbx_business_glossary_term' = 'Prime Sponsor Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `project_end_date` SET TAGS ('dbx_business_glossary_term' = 'Project End Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `sponsor_award_date` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Award Date');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `subcontract_flag` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Flag');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Grant Title');
ALTER TABLE `vibe_healthcare_v1`.`research`.`research_grant` ALTER COLUMN `total_expenditures_to_date` SET TAGS ('dbx_business_glossary_term' = 'Total Expenditures To Date');
