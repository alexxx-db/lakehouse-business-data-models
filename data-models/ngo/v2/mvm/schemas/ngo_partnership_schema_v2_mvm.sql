-- Schema for Domain: partnership | Business: Ngo | Version: v2_mvm
-- Generated on: 2026-07-03 06:20:34

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`partnership` COMMENT 'Systems of record: eTools (UNICEF partner management & HACT), UN Partner Portal (UNPP), SAP vendor master. Covers partner assessments, agreements, HACT compliance, and capacity building.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`partner_org` (
    `partner_org_id` BIGINT COMMENT 'Unique system-generated surrogate key identifying a partner organization record. This is the primary key and Single Source of Truth (SSOT) identifier for all inter-organizational partner entities in the partnership domain.',
    `psea_policy_id` BIGINT COMMENT 'Foreign key linking to safeguarding.psea_policy. Business justification: NGO partner onboarding and due diligence requires verifying that partner orgs have adopted an adequate PSEA policy. Linking partner_org to psea_policy enables compliance tracking, donor reporting on p',
    `statutory_registration_id` BIGINT COMMENT 'Foreign key linking to compliance.statutory_registration. Business justification: Partner organizations must maintain valid statutory registrations (NGO registration, tax-exempt status) for due diligence and partnership eligibility. Links partner vetting to legal compliance status.',
    `accreditation_status` STRING COMMENT 'Current accreditation status of the partner organization against recognized humanitarian or development standards such as the Core Humanitarian Standard (CHS), HAP (Humanitarian Accountability Partnership), or equivalent national accreditation bodies.. Valid values are `accredited|provisional|not_accredited|suspended|under_review`',
    `annual_budget_usd` DECIMAL(18,2) COMMENT 'Most recently reported annual organizational budget of the partner in US Dollars. Used for financial capacity assessment, sub-award sizing decisions, and due diligence under OMB Uniform Guidance. Sourced from partner financial disclosures or audited accounts.',
    `authorized_rep_name` STRING COMMENT 'Full name of the individual legally authorized to sign agreements (MoUs, LoAs, SoWs, sub-award agreements) on behalf of the partner organization. Required for agreement execution and legal compliance.',
    `authorized_rep_title` STRING COMMENT 'Official title of the authorized signatory at the partner organization (e.g., Executive Director, CEO, Country Representative). Validates signing authority for sub-award and partnership agreements.',
    `bank_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the partner organizations primary bank account is held. Used for international wire transfer compliance and OFAC/sanctions screening.. Valid values are `^[A-Z]{3}$`',
    `bank_name` STRING COMMENT 'Name of the primary banking institution used by the partner organization for receiving sub-grant disbursements. Required for financial due diligence and sub-award payment processing in SAP S/4HANA and Unit4 ERP.',
    `capacity_assessment_date` DATE COMMENT 'Date on which the most recent formal partner capacity assessment was conducted. Used to determine whether a reassessment is due and to track the currency of due diligence records.',
    `capacity_assessment_score` DECIMAL(18,2) COMMENT 'Numeric score (typically 0–100) resulting from the most recent formal partner capacity assessment covering governance, financial management, HR, and program delivery. Used to determine sub-award eligibility, required oversight level, and capacity-strengthening needs under OMB Uniform Guidance.',
    `chs_certified` BOOLEAN COMMENT 'Indicates whether the partner organization holds a valid Core Humanitarian Standard (CHS) certification. CHS certification demonstrates commitment to accountability, quality, and improvement in humanitarian response.',
    `cluster_memberships` STRING COMMENT 'Comma-separated list of OCHA humanitarian cluster(s) in which the partner organization holds active membership or co-lead roles (e.g., WASH, Health, Shelter, Food Security, Protection). Used for coordination mapping and IASC working group engagement tracking.',
    `partner_org_code` STRING COMMENT 'Standardized code representing the partner org classification or category.',
    `countries_of_operation` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where the partner organization has active field operations. Distinct from country of registration. Used for geographic coverage analysis and OCHA 3W (Who does What Where) reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this partner org.',
    `partner_org_description` STRING COMMENT 'Detailed textual description providing context about the partner org.',
    `due_diligence_expiry_date` DATE COMMENT 'Date on which the current due diligence clearance expires and a new assessment must be completed before the partner can enter into new sub-award or partnership agreements.',
    `due_diligence_status` STRING COMMENT 'Current status of the partner organizations due diligence vetting process. Expired indicates that a previously completed assessment has passed its validity period and renewal is required before new agreements can be executed.. Valid values are `completed|in_progress|not_started|expired|waived`',
    `end_date` DATE COMMENT 'Date and time when the end event occurred for this partner org.',
    `finance_contact_email` STRING COMMENT 'Email address of the partner organizations designated financial officer or finance focal point. Used for Budget versus Actual (BvA) reporting, financial documentation requests, and sub-grant financial management communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `founding_year` STRING COMMENT 'Calendar year in which the partner organization was founded or established. Used to assess organizational maturity, track record, and eligibility for capacity-strengthening programs.',
    `hact_risk_rating` STRING COMMENT 'Current HACT risk rating from most recent micro assessment (Low, Medium, Significant, High).',
    `hq_address` STRING COMMENT 'Full mailing address of the partner organizations global headquarters including street, city, postal code, and country. Used for official correspondence, legal notices, and sub-award agreement documentation.',
    `hq_city` STRING COMMENT 'City where the partner organizations global headquarters is located. Used for correspondence, coordination meetings, and geographic reporting.',
    `hq_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country where the partner organizations global headquarters is located. Used for geographic analysis, donor reporting, and OCHA cluster coordination mapping.. Valid values are `^[A-Z]{3}$`',
    `iati_org_identifier` STRING COMMENT 'Globally unique organization identifier assigned under the International Aid Transparency Initiative (IATI) standard (e.g., GB-CHC-1234567). Enables cross-organization data linkage and transparency reporting to IATI registry. Required for DFID and many EU donor compliance reports.',
    `ip_transfer_modality` STRING COMMENT 'Current IP transfer modality determined by most recent HACT micro assessment: Direct Cash Transfer | Reimbursement | Direct Payment.',
    `mission_statement` STRING COMMENT 'Official mission statement of the partner organization describing its core purpose and mandate. Used for alignment assessment with Ngos Theory of Change (ToC) and program design.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this partner org.',
    `partner_org_name` STRING COMMENT 'Human-readable name or label for the partner org.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the partner org entity.',
    `org_acronym` STRING COMMENT 'Commonly used acronym or short name for the partner organization (e.g., CARE, IRC, MSF). Widely used in SitReps, cluster coordination, and OCHA reporting to identify partners concisely.',
    `org_name` STRING COMMENT 'Full legal registered name of the partner organization as it appears on official registration documents. Used as the primary human-readable identity label for the partner across all systems including Microsoft Dynamics 365 and Salesforce Nonprofit Cloud.',
    `org_type` STRING COMMENT 'Categorical classification of the partner organization type. Distinguishes between International Non-Governmental Organizations (INGOs), Civil Society Organizations (CSOs), Community-Based Organizations (CBOs), UN agencies, government bodies, consortia, private sector entities, and academic institutions. Drives eligibility rules for sub-award agreements and due diligence requirements. [ENUM-REF-CANDIDATE: INGO|NGO|CSO|CBO|UN_AGENCY|GOVERNMENT|CONSORTIUM|PRIVATE_SECTOR|ACADEMIC — promote to reference product]',
    `org_website` STRING COMMENT 'Official public website URL of the partner organization. Used for due diligence verification, public profile validation, and IATI transparency reporting.. Valid values are `^https?://[^s/$.?#].[^s]*$`',
    `partner_org_status` STRING COMMENT 'Current status indicator for the partner org workflow state.',
    `partnership_status` STRING COMMENT 'Current lifecycle status of the partner organization relationship. Controls whether the partner is eligible for new agreements, sub-awards, or field collaboration. pending_vetting indicates due diligence is in progress; blacklisted indicates the partner is barred from engagement per donor or regulatory requirements.. Valid values are `active|inactive|suspended|pending_vetting|blacklisted|archived`',
    `preferred_language` STRING COMMENT 'ISO 639-1 or ISO 639-2 language code representing the partner organizations preferred language for official communications, reporting, and agreement documentation (e.g., en, fr, ar, es).. Valid values are `^[a-z]{2,3}$`',
    `primary_contact_email` STRING COMMENT 'Official email address of the primary focal point at the partner organization. Used for formal communications, agreement notifications, and reporting requests.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary focal point or authorized representative at the partner organization. This is the principal contact for partnership coordination, agreement negotiations, and official communications.',
    `primary_contact_phone` STRING COMMENT 'Direct phone number (including country code) for the primary focal point at the partner organization. Used for urgent field coordination and emergency communications.',
    `primary_contact_title` STRING COMMENT 'Job title or designation of the primary focal point at the partner organization (e.g., Country Director, Partnership Manager, Executive Director). Used to assess seniority and authority level for agreement signing.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp indicating when the partner organization record was first created in the system. Serves as the audit trail creation marker and supports data lineage tracking in the Databricks Silver Layer.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp indicating when the partner organization record was most recently modified. Used for change tracking, data freshness monitoring, and incremental load processing in the Databricks Lakehouse Silver Layer.',
    `sanctions_screen_date` DATE COMMENT 'Date on which the most recent sanctions screening was completed for the partner organization. Used to determine whether re-screening is required before new agreements or disbursements.',
    `sanctions_screened` BOOLEAN COMMENT 'Indicates whether the partner organization has been screened against applicable sanctions lists (e.g., OFAC SDN List, UN Consolidated Sanctions List, EU Sanctions List) as part of the due diligence process. Required for USAID and US Government-funded programs.',
    `sdg_alignment` STRING COMMENT 'Comma-separated list of UN Sustainable Development Goal (SDG) numbers that the partner organizations mandate aligns with (e.g., 1,2,3,6). Used for strategic alignment reporting and donor narrative reporting.',
    `staff_count` STRING COMMENT 'Total number of paid staff (national and international) employed by the partner organization at the time of last capacity assessment. Used as an indicator of organizational capacity for program delivery and sub-award management.',
    `start_date` DATE COMMENT 'Date and time when the start event occurred for this partner org.',
    `tax_identifier` STRING COMMENT 'Government-issued tax identification number (e.g., EIN in the US, VAT number in the EU) for the partner organization. Required for financial transactions, sub-award agreements, and compliance with NICRA (Negotiated Indirect Cost Rate Agreement) reporting.',
    `thematic_focus_areas` STRING COMMENT 'Comma-separated list of primary thematic areas in which the partner organization operates (e.g., WASH, GBV, PSS, Health, Education, Livelihoods, NFI Distribution). Used for partner matching in program design and cluster coordination with OCHA.',
    `volunteer_count` STRING COMMENT 'Total number of active volunteers engaged by the partner organization. Reflects community mobilization capacity and is used in operational capacity assessments for field program delivery.',
    CONSTRAINT pk_partner_org PRIMARY KEY(`partner_org_id`)
) COMMENT 'Implementing partner organization. Source systems: UN Partner Portal (UNPP), eTools (UNICEF), SAP vendor master. Systems-of-record: eTools (Partner Management), SAP vendor master, UN Partner Portal. Framework: HACT / IATI Organisation Standard.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`agreement` (
    `agreement_id` BIGINT COMMENT 'Unique system-generated surrogate identifier for the partnership agreement record. Primary key for the partnership_agreement data product.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Partnership agreements create compliance obligations (donor reporting schedules, regulatory filings, IATI publication requirements). Each agreement generates specific obligations tracked in compliance',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: CRITICAL missing link. Every partnership agreement must reference its partner organization. Currently stores partner_organization_name as denormalized text. Adding partner_org_id FK allows JOIN to par',
    `psea_policy_id` BIGINT COMMENT 'Foreign key linking to safeguarding.psea_policy. Business justification: Partnership agreements contractually bind partners to specific PSEA policy versions. Donors require agreements to reference the governing PSEA policy. This link enables compliance audits to verify whi',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the partnership agreement. draft = under preparation; pending_signature = awaiting execution; active = fully executed and in force; suspended = temporarily halted; expired = past end date without renewal; terminated = ended before expiry; amended = superseded by an amendment. [ENUM-REF-CANDIDATE: draft|pending_signature|active|suspended|expired|terminated|amended — promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the formal inter-organizational legal instrument. MoU = Memorandum of Understanding; LoA = Letter of Agreement; SoW = Scope of Work; sub_award = sub-grant or sub-award agreement; consortium = multi-party consortium agreement; other = any other instrument type. [ENUM-REF-CANDIDATE: MoU|LoA|SoW|sub_award|consortium|framework|other — promote to reference product if additional types are needed]. Valid values are `MoU|LoA|SoW|sub_award|consortium|other`',
    `amendment_date` DATE COMMENT 'Date on which the most recent amendment to the agreement was executed. Null for original agreements with no amendments.',
    `amendment_description` STRING COMMENT 'Narrative summary of the changes introduced by the most recent amendment (e.g., budget increase, no-cost extension, scope modification). Null for original agreements.',
    `amendment_number` STRING COMMENT 'Sequential integer indicating the amendment version of the agreement. Zero (0) indicates the original agreement; increments by 1 for each subsequent amendment. Supports amendment history tracking.',
    `capacity_assessment_date` DATE COMMENT 'Date on which the most recent partner capacity assessment or due diligence review was completed.',
    `capacity_assessment_status` STRING COMMENT 'Status of the partner due diligence and capacity assessment conducted prior to or during the agreement. not_required = exempt; pending = assessment initiated but not complete; completed = assessment passed; failed = partner did not meet threshold; waived = formally waived by authorized approver.. Valid values are `not_required|pending|completed|failed|waived`',
    `cluster_lead_agency` STRING COMMENT 'Name of the OCHA cluster lead agency (e.g., UNICEF for WASH, WFP for Food Security) under whose coordination framework the agreements activities are implemented. Relevant for humanitarian response agreements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the partnership agreement record was first created in the system. Supports audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the funding ceiling and financial obligations under the agreement (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `disbursed_amount` DECIMAL(18,2) COMMENT 'Cumulative amount disbursed to partner under this agreement. Present in MVM stub, carried forward for ECM completeness.',
    `dispute_resolution_mechanism` STRING COMMENT 'Agreed mechanism for resolving disputes arising under the agreement. Captured from the legal instruments dispute resolution clause.. Valid values are `negotiation|mediation|arbitration|litigation|other`',
    `due_diligence_risk_rating` STRING COMMENT 'Risk rating assigned to the partner following due diligence review. Informs monitoring intensity, financial controls, and reporting requirements under the agreement.. Valid values are `low|medium|high|critical`',
    `effective_end_date` DATE COMMENT 'The date on which the agreement expires or obligations cease. Nullable for open-ended agreements. Corresponds to the EFFECTIVE_UNTIL category for MASTER_AGREEMENT role.',
    `effective_start_date` DATE COMMENT 'The date on which the agreement becomes legally binding and operational obligations commence. Corresponds to the EFFECTIVE_FROM category for MASTER_AGREEMENT role.',
    `end_date` DATE COMMENT 'Date and time when the end event occurred for this partnership agreement.',
    `execution_date` DATE COMMENT 'The date on which the agreement was formally signed and executed by all required parties. May differ from the effective start date if the agreement is backdated or has a future commencement.',
    `funding_ceiling_amount` DECIMAL(18,2) COMMENT 'Maximum total financial value authorized under the agreement in the agreements stated currency. For sub-awards, this is the maximum sub-grant amount. Null for non-financial MoUs.',
    `geographic_scope` STRING COMMENT 'Free-text description of the geographic area covered by the agreement (e.g., Borno and Yobe States, Nigeria or Kabul Province, Afghanistan). Used for operational planning and GIS-based reporting.',
    `governing_law_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction whose laws govern the interpretation and enforcement of the agreement (e.g., GBR, USA, CHE).. Valid values are `^[A-Z]{3}$`',
    `hact_risk_rating` STRING COMMENT 'HACT risk rating from micro assessment: Low / Moderate / Significant / High. Determines transfer modality and assurance activities.',
    `iati_activity_identifier` STRING COMMENT 'IATI-standard activity identifier for the agreement, enabling public disclosure and cross-organization traceability on the IATI Registry (e.g., GB-CHC-123456-WASH-NGA-2024).',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'Negotiated Indirect Cost Rate (NICRA) or agreed Facilities and Administration (F&A) rate applied to direct costs under this agreement, expressed as a decimal (e.g., 0.1500 = 15%). Relevant for US federal sub-awards under OMB Uniform Guidance.',
    `ip_transfer_modality` STRING COMMENT 'Implementing Partner transfer modality enum determined by HACT micro assessment risk rating: Direct Cash Transfer | Reimbursement | Direct Payment.',
    `is_consortium_agreement` BOOLEAN COMMENT 'Indicates whether this agreement governs a multi-party consortium arrangement (True) rather than a bilateral agreement (False). Consortium agreements may have additional members tracked separately.',
    `is_sub_award` BOOLEAN COMMENT 'Indicates whether this agreement is a sub-award (True) or a prime/direct agreement (False). Drives compliance requirements under OMB Uniform Guidance 2 CFR 200 for pass-through entities.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the partnership agreement record was most recently modified. Supports change tracking, audit trail, and incremental data pipeline processing.',
    `lead_organization_name` STRING COMMENT 'Legal name of the primary organization (typically the prime recipient or lead INGO) that is the principal party initiating or managing the agreement. Serves as the PARTY_REFERENCE anchor for the agreement.',
    `liquidated_amount` DECIMAL(18,2) COMMENT 'Cumulative amount liquidated/reported by partner. Present in MVM stub, carried forward for ECM completeness.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this partnership agreement.',
    `mvm_migration_reference` STRING COMMENT 'Reference code linking this record to the legacy MVM agreement stub for migration traceability.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the partnership agreement entity.',
    `operational_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the primary country where the agreements activities are implemented (e.g., SSD, YEM, HTI).. Valid values are `^[A-Z]{3}$`',
    `outstanding_dct_amount` DECIMAL(18,2) COMMENT 'Outstanding Direct Cash Transfer balance (disbursed minus liquidated). Present in MVM stub, carried forward for ECM completeness.',
    `parent_agreement_reference` STRING COMMENT 'Agreement reference number of the parent or prime agreement under which this sub-award or amendment was issued. Enables hierarchical agreement traceability. Null for top-level agreements.',
    `partnership_agreement_code` STRING COMMENT 'Standardized code representing the partnership agreement classification or category.',
    `partnership_agreement_description` STRING COMMENT 'Detailed textual description providing context about the partnership agreement.',
    `partnership_agreement_name` STRING COMMENT 'Human-readable name or label for the partnership agreement.',
    `partnership_agreement_status` STRING COMMENT 'Current status indicator for the partnership agreement workflow state.',
    `program_sector` STRING COMMENT 'Humanitarian or development sector under which the agreements activities fall. WASH = Water Sanitation and Hygiene; GBV = Gender-Based Violence; PSS = Psychosocial Support. [ENUM-REF-CANDIDATE: WASH|health|education|food_security|protection|shelter|livelihoods|GBV|PSS|nutrition|other — promote to reference product]',
    `reference_number` STRING COMMENT 'Externally-known alphanumeric reference number assigned to the agreement, used in correspondence, filing, and cross-system lookups (e.g., MOU-2024-0042, LOA-2023-WASH-007). Serves as the BUSINESS_IDENTIFIER for this agreement.',
    `renewal_option` BOOLEAN COMMENT 'Indicates whether the agreement contains a renewal or extension option clause (True) that allows the parties to extend the agreement beyond the effective end date without a full renegotiation.',
    `reporting_frequency` STRING COMMENT 'Agreed frequency at which the partner must submit programmatic and/or financial reports under the agreement (e.g., monthly SitRep, quarterly narrative, annual audit).. Valid values are `monthly|quarterly|semi_annual|annual|ad_hoc`',
    `scope_description` STRING COMMENT 'Narrative description of the agreed scope of work, activities, and deliverables covered by the agreement. Summarizes the SoW or program objectives as stated in the legal instrument.',
    `sdg_alignment_codes` STRING COMMENT 'Comma-separated list of UN Sustainable Development Goal (SDG) goal numbers to which the agreements activities contribute (e.g., 3,6,16). Used for donor reporting and IATI disclosure.',
    `signatory_name_lead` STRING COMMENT 'Full name of the authorized signatory representing the lead organization on the agreement. Captured for legal validity and audit purposes.',
    `signatory_name_partner` STRING COMMENT 'Full name of the authorized signatory representing the partner organization on the agreement. Captured for legal validity and audit purposes.',
    `start_date` DATE COMMENT 'Date and time when the start event occurred for this partnership agreement.',
    `termination_date` DATE COMMENT 'Actual date on which the agreement was terminated, if terminated before the effective end date. Null for active or expired agreements.',
    `termination_notice_days` STRING COMMENT 'Number of calendar days written notice required by either party to terminate the agreement without cause, as specified in the termination clause.',
    `termination_reason` STRING COMMENT 'Reason for early termination of the agreement. Null for agreements that expire naturally or remain active.. Valid values are `mutual_consent|breach|force_majeure|funding_exhausted|program_closure|other`',
    `theory_of_change_reference` STRING COMMENT 'Reference identifier or title of the Theory of Change (ToC) or LogFrame (Logical Framework) document that underpins the program activities governed by this agreement. Links the agreement to the MEL framework.',
    `title` STRING COMMENT 'Full descriptive title of the partnership agreement as it appears on the signed legal instrument (e.g., Memorandum of Understanding for WASH Program Delivery in Borno State).',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'Total agreed budget ceiling for the partnership agreement. Present in MVM stub, carried forward for ECM completeness.',
    `transfer_modality` STRING COMMENT 'Cash transfer modality to implementing partner: Direct Cash Transfer / Reimbursement / Direct Payment per HACT framework. Present in MVM stub, carried forward for ECM completeness.',
    CONSTRAINT pk_agreement PRIMARY KEY(`agreement_id`)
) COMMENT 'ECM-canonical partnership agreement entity. Supersedes the MVM-tier stub agreement and is a strict superset of its attributes. Source systems: eTools (UNICEF), SAP, UN Partner Portal, UNPP, InSight. Captures the full lifecycle of implementing partner agreements including PCA, SSFA, and programme documents with HACT compliance tracking.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` (
    `capacity_assessment_id` BIGINT COMMENT 'Unique system-generated identifier for each partner capacity assessment record. Primary key for the capacity_assessment data product.',
    `award_id` BIGINT COMMENT 'Reference to the grant or funding agreement that triggered or is associated with this capacity assessment. Links due diligence records to specific funding instruments.',
    `partner_org_id` BIGINT COMMENT 'Reference to the partner organization (CSO, CBO, INGO, government body, UN agency, or consortium) being assessed. Links to the partner master record.',
    `prior_assessment_capacity_assessment_id` BIGINT COMMENT 'Reference to the immediately preceding capacity assessment record for the same partner, enabling longitudinal tracking of capacity development progress over time.',
    `assessment_date` DATE COMMENT 'The principal date on which the capacity assessment was conducted or the field data collection was completed. Used as the primary business event date for reporting and due diligence timelines.',
    `assessment_end_date` DATE COMMENT 'Date on which the capacity assessment process was formally concluded and the final report was issued.',
    `assessment_location_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the country where the capacity assessment was physically conducted. Relevant for field-based assessments of local partners.. Valid values are `^[A-Z]{3}$`',
    `assessment_methodology` STRING COMMENT 'Standardized framework or tool used to conduct the capacity assessment. Common methodologies include USAID Organizational Capacity Assessment (OCA), DFID Organizational Capacity Assessment Tool (OCAT), ECHO Partner Assessment for Capacity Assessment (PACA), IRC Collaborative Capacity Assessment Tool (CCAT), and UNDP Capacity Scorecard. [ENUM-REF-CANDIDATE: USAID_OCA|DFID_OCAT|ECHO_PACA|IRC_CCAT|UNDP_CAPACITY_SCORECARD|OTHER — promote to reference product]. Valid values are `USAID_OCA|DFID_OCAT|ECHO_PACA|IRC_CCAT|UNDP_CAPACITY_SCORECARD|OTHER`',
    `assessment_reference_code` STRING COMMENT 'Externally-known alphanumeric reference code assigned to this capacity assessment, used in correspondence, donor reporting, and audit trails (e.g., NGO-CA-2024-000123).. Valid values are `^[A-Z]{2,6}-CA-[0-9]{4}-[0-9]{4,6}$`',
    `assessment_report_url` STRING COMMENT 'URL or document management system path to the full capacity assessment report. Classified as confidential due to sensitive organizational information about the partner.',
    `assessment_scope` STRING COMMENT 'Indicates the depth and modality of the assessment: FULL (comprehensive on-site assessment covering all functional areas), ABBREVIATED (targeted review of selected areas), DESK_REVIEW (document-based review without site visit), FIELD_VISIT (on-site verification component).. Valid values are `FULL|ABBREVIATED|DESK_REVIEW|FIELD_VISIT`',
    `assessment_start_date` DATE COMMENT 'Date on which the capacity assessment process formally commenced, including document review and stakeholder engagement initiation.',
    `assessment_status` STRING COMMENT 'Current lifecycle state of the capacity assessment record: DRAFT (initiated but not submitted), IN_PROGRESS (assessment underway), COMPLETED (assessment finalized), VALIDATED (reviewed and approved by authorized staff), ARCHIVED (superseded or closed).. Valid values are `DRAFT|IN_PROGRESS|COMPLETED|VALIDATED|ARCHIVED`',
    `assessment_tool_version` STRING COMMENT 'Version number or edition of the assessment methodology tool used (e.g., USAID OCA v3.0, DFID OCAT 2019). Ensures comparability of scores across assessments conducted using different tool versions.',
    `assessment_type` STRING COMMENT 'Classification of when and why the assessment was conducted: PRE_AWARD (due diligence before partnership), PERIODIC (scheduled review during partnership), TRIGGERED (event-driven reassessment due to risk flag), or CLOSE_OUT (end-of-partnership evaluation).. Valid values are `PRE_AWARD|PERIODIC|TRIGGERED|CLOSE_OUT`',
    `capacity_assessment_status` STRING COMMENT 'Current status indicator for the capacity assessment workflow state.',
    `capacity_building_plan_required` BOOLEAN COMMENT 'Indicates whether the assessment results mandate the development of a formal capacity-building plan (True) or whether the partners capacity is sufficient without a structured intervention plan (False).',
    `capacity_assessment_code` STRING COMMENT 'Standardized code representing the capacity assessment classification or category.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when the capacity assessment record was first created in the system. Used for audit trail, data lineage, and compliance reporting purposes.',
    `capacity_assessment_description` STRING COMMENT 'Detailed textual description providing context about the capacity assessment.',
    `end_date` DATE COMMENT 'Date and time when the end event occurred for this capacity assessment.',
    `enhanced_monitoring_required` BOOLEAN COMMENT 'Indicates whether the assessment outcome requires enhanced programmatic or financial monitoring of the partner (True), such as more frequent reporting, additional site visits, or pre-approval of expenditures, as mandated by donor regulations.',
    `financial_mgmt_score` DECIMAL(18,2) COMMENT 'Numeric score assigned to the partners financial management functional area, covering accounting systems, internal controls, audit compliance, and fund stewardship. Typically scored on a 0–100 or 1–5 scale per the assessment methodology.',
    `financial_risk_rating` STRING COMMENT 'Specific risk rating for the partners financial management functional area, used to determine sub-award monitoring intensity, payment modality, and required financial controls.. Valid values are `LOW|MEDIUM|HIGH|CRITICAL`',
    `governance_score` DECIMAL(18,2) COMMENT 'Numeric score for the partners organizational governance functional area, including board oversight, legal registration, organizational policies, and leadership accountability.',
    `hr_mgmt_score` DECIMAL(18,2) COMMENT 'Numeric score for the partners human resources management functional area, including HR policies, recruitment practices, staff development, and safeguarding compliance.',
    `it_systems_score` DECIMAL(18,2) COMMENT 'Numeric score for the partners ICT4D and information systems functional area, covering data management infrastructure, cybersecurity practices, and digital reporting capabilities.',
    `key_findings_summary` STRING COMMENT 'Concise narrative summary of the principal findings from the capacity assessment, highlighting major strengths, critical gaps, and priority areas for improvement across all assessed functional areas.',
    `kobo_submission_reference` STRING COMMENT 'Unique submission identifier from KoboToolbox or similar field data collection platform used to capture assessment data in the field. Enables traceability back to the source data collection record.',
    `lead_assessor_name` STRING COMMENT 'Full name of the individual who led the capacity assessment. Retained for reporting and audit purposes even when the staff record may change.',
    `lead_assessor_organization` STRING COMMENT 'Name of the organization to which the lead assessor belongs (e.g., the NGOs headquarters, an independent consulting firm, or a donor agency). Relevant when external assessors are engaged.',
    `mel_score` DECIMAL(18,2) COMMENT 'Numeric score for the partners Monitoring, Evaluation, and Learning (MEL) functional area, covering data collection systems, indicator tracking, reporting quality, and learning practices.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this capacity assessment.',
    `capacity_assessment_name` STRING COMMENT 'Human-readable name or label for the capacity assessment.',
    `next_assessment_due_date` DATE COMMENT 'Scheduled date by which the next capacity assessment must be completed, based on risk rating, donor requirements, or organizational policy. Drives compliance monitoring and workflow triggers.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the capacity assessment entity.',
    `overall_risk_rating` STRING COMMENT 'Categorical risk classification assigned to the partner based on the capacity assessment results: LOW (strong capacity, minimal oversight needed), MEDIUM (adequate capacity with some gaps), HIGH (significant capacity gaps requiring intensive support), CRITICAL (fundamental weaknesses posing fiduciary or programmatic risk).. Valid values are `LOW|MEDIUM|HIGH|CRITICAL`',
    `overall_score` DECIMAL(18,2) COMMENT 'Composite numeric score representing the partners overall organizational capacity across all assessed functional areas. Calculated per the assessment methodologys weighting scheme and recorded as the official assessment result.',
    `partner_self_assessment_completed` BOOLEAN COMMENT 'Indicates whether the partner organization completed a self-assessment component prior to or alongside the external assessment (True). Many OCA methodologies include a parallel self-assessment to identify perception gaps.',
    `partner_self_assessment_score` DECIMAL(18,2) COMMENT 'Overall score submitted by the partner organization in their self-assessment component. Compared against the external assessors score to identify perception gaps and inform capacity-building dialogue.',
    `payment_modality_recommendation` DECIMAL(18,2) COMMENT 'Payment modality recommended for sub-award disbursements based on the partners financial risk rating: ADVANCE (funds transferred before expenditure), REIMBURSEMENT (funds transferred after expenditure documentation), DIRECT_PAYMENT (NGO pays vendors directly on partners behalf), MIXED (combination of modalities).',
    `procurement_score` DECIMAL(18,2) COMMENT 'Numeric score for the partners procurement and supply chain management functional area, covering procurement policies, competitive bidding, vendor management, and asset control.',
    `program_mgmt_score` DECIMAL(18,2) COMMENT 'Numeric score for the partners program design and management functional area, including project planning, implementation capacity, beneficiary targeting, and service delivery quality.',
    `recommended_interventions` STRING COMMENT 'Narrative description of the specific capacity-building interventions recommended based on assessment findings, such as financial management training, procurement system upgrades, MEL system strengthening, or governance policy development.',
    `score_scale_max` DECIMAL(18,2) COMMENT 'The maximum possible score on the scoring scale used by the assessment methodology (e.g., 100 for percentage-based scales, 5 for Likert-based scales). Required to normalize scores across different methodologies for comparative analytics.',
    `start_date` DATE COMMENT 'Date and time when the start event occurred for this capacity assessment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when the capacity assessment record was most recently modified. Used for change tracking, data synchronization, and audit trail purposes.',
    `validation_date` DATE COMMENT 'Date on which the capacity assessment was formally reviewed and validated by the authorized staff member, marking the record as officially approved for use in partnership and sub-award decisions.',
    CONSTRAINT pk_capacity_assessment PRIMARY KEY(`capacity_assessment_id`)
) COMMENT 'Partner capacity assessment including HACT micro-assessment. Source systems: eTools, eZHACT, UN Partner Portal.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` (
    `due_diligence_record_id` BIGINT COMMENT 'Unique system-generated identifier for the due diligence and partner verification record. Primary key for this entity. Entity role: MASTER_AGREEMENT — this record represents a formal compliance verification container with its own lifecycle, effective dates, and binding outcome.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Due diligence assessments are often triggered by specific award risk thresholds, donor requirements, and subaward value ceilings. Award context determines diligence scope, required certifications, and',
    `capacity_assessment_id` BIGINT COMMENT 'Foreign key linking to partnership.capacity_assessment. Business justification: due_diligence_record stores capacity_assessment_score and capacity_assessment_date as denormalized attributes but has no FK to the actual capacity_assessment record. Due diligence incorporates capacit',
    `governance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.governance_policy. Business justification: NGO partner due diligence explicitly verifies the partners adherence to governance policies (anti-corruption, conflict-of-interest, whistleblower). Linking due_diligence_record to the specific govern',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: NGO due diligence is triggered and scoped to specific interventions before partner onboarding. Compliance officers and program managers need to verify that valid due diligence exists for every partner',
    `partner_org_id` BIGINT COMMENT 'Reference to the partner organization (CSO, CBO, INGO, government body, UN agency, or consortium) that is the subject of this due diligence record.',
    `psea_policy_id` BIGINT COMMENT 'Foreign key linking to safeguarding.psea_policy. Business justification: due_diligence_record has safeguarding_policy_verified attribute, meaning the due diligence process explicitly reviews the partners PSEA policy. Linking to the specific psea_policy record reviewed ena',
    `statutory_registration_id` BIGINT COMMENT 'Foreign key linking to compliance.statutory_registration. Business justification: Due diligence explicitly verifies a partners statutory registration (legal_registration_verified flag exists on the record). Linking directly to statutory_registration normalizes the denormalized reg',
    `aml_cft_check_status` STRING COMMENT 'Result of Anti-Money Laundering (AML) and Counter-Financing of Terrorism (CFT) due diligence checks conducted on the partner organization and its key principals, per FATF Recommendations and donor requirements.. Valid values are `clear|flagged|pending|not_required`',
    `anti_terrorism_cert_date` DATE COMMENT 'Date on which the partners anti-terrorism certification was signed and received. Required for USAID and BHA-funded sub-awards.',
    `anti_terrorism_certification` BOOLEAN COMMENT 'Indicates whether the partner has signed and submitted a valid anti-terrorism certification (e.g., USAID Standard Provision — Certification Regarding Terrorist Financing) as required for US Government-funded awards.',
    `chs_cert_expiry_date` DATE COMMENT 'Date on which the partners CHS certification expires. Triggers renewal alerts and may affect partner eligibility for humanitarian sub-awards.',
    `chs_certificate_number` STRING COMMENT 'Official certificate number issued by the CHS Alliance upon successful third-party verification of the partners compliance with the Core Humanitarian Standard.',
    `chs_certification_status` STRING COMMENT 'Accreditation status of the partner against the Core Humanitarian Standard on Quality and Accountability (CHS). Certified status requires third-party verification by the CHS Alliance.. Valid values are `certified|self_assessed|not_assessed|expired`',
    `due_diligence_record_code` STRING COMMENT 'Standardized code representing the due diligence record classification or category.',
    `completion_date` DATE COMMENT 'Calendar date on which all due diligence checks were completed and a final outcome was recorded. Null if the process is still in progress.',
    `conditions_of_approval` STRING COMMENT 'Free-text description of any conditions, restrictions, or corrective actions attached to an approved-with-conditions outcome. Documents required remediation steps and timelines before full approval is granted.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this due diligence record was first created in the system. Provides the audit trail creation marker required for compliance and data lineage tracking.',
    `debarment_check_date` DATE COMMENT 'Date on which the most recent debarment and suspension check was performed against SAM.gov and equivalent exclusion registries.',
    `debarment_check_status` STRING COMMENT 'Result of verification against the US System for Award Management (SAM.gov) exclusions list and equivalent debarment/suspension registries to confirm the partner is not excluded from receiving federal awards.. Valid values are `clear|debarred|suspended|pending`',
    `due_diligence_record_description` STRING COMMENT 'Detailed textual description providing context about the due diligence record.',
    `diligence_status` STRING COMMENT 'Current lifecycle state of the due diligence record, tracking progress from initiation through completion or failure. Drives workflow routing and compliance dashboards.. Valid values are `initiated|in_progress|pending_review|completed|failed|waived`',
    `diligence_type` STRING COMMENT 'Classification of the due diligence exercise by its trigger and scope. Pre-award is conducted before sub-award execution; periodic review is scheduled; triggered review is initiated by a risk event; close-out is conducted at agreement end; enhanced due diligence applies to high-risk partners.. Valid values are `pre_award|periodic_review|triggered_review|close_out|enhanced_due_diligence`',
    `due_diligence_record_status` STRING COMMENT 'Current status indicator for the due diligence record workflow state.',
    `end_date` DATE COMMENT 'Date and time when the end event occurred for this due diligence record.',
    `financial_audit_opinion` STRING COMMENT 'Type of auditors opinion issued in the partners most recent external financial audit. An unqualified (clean) opinion is required for most donor sub-award eligibility. Adverse or disclaimer opinions trigger enhanced due diligence.. Valid values are `unqualified|qualified|adverse|disclaimer|not_available`',
    `financial_audit_reviewed` BOOLEAN COMMENT 'Indicates whether the partners most recent external financial audit report has been reviewed and assessed as part of this due diligence exercise.',
    `financial_audit_year` STRING COMMENT 'Fiscal year covered by the most recent external financial audit report reviewed during due diligence. Used to assess currency of financial information.',
    `governance_verified` BOOLEAN COMMENT 'Indicates whether the partners governance structure (board composition, conflict of interest policies, organizational chart, and decision-making authority) has been reviewed and verified.',
    `hap_membership_status` STRING COMMENT 'Indicates the partners membership status with the Humanitarian Accountability Partnership (HAP), a predecessor accountability framework now integrated into the CHS Alliance.. Valid values are `member|former_member|not_applicable|pending`',
    `initiation_date` DATE COMMENT 'Calendar date on which the due diligence process was formally initiated for this partner. Marks the start of the MASTER_AGREEMENT effective period for compliance tracking purposes.',
    `iso_cert_expiry_date` DATE COMMENT 'Date on which the partners ISO certification expires. Null if no ISO certification is held or if certification is not time-limited.',
    `iso_certification_type` STRING COMMENT 'Type of ISO certification held by the partner organization (e.g., ISO 9001 Quality Management, ISO 27001 Information Security). Null if no ISO certification is held. [ENUM-REF-CANDIDATE: ISO_9001|ISO_27001|ISO_14001|ISO_45001|ISO_31000|none — promote to reference product]',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this due diligence record. Supports audit trail requirements and change tracking for compliance reporting.',
    `legal_registration_verified` BOOLEAN COMMENT 'Indicates whether the partners legal registration and incorporation status in its country of operation has been verified against official national NGO registration records or company registry.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this due diligence record.',
    `due_diligence_record_name` STRING COMMENT 'Human-readable name or label for the due diligence record.',
    `next_review_date` DATE COMMENT 'Scheduled calendar date for the next periodic due diligence review of this partner. Drives automated reminders and compliance calendar management. Effective-until equivalent for the current verification cycle.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the due diligence record entity.',
    `overall_outcome` STRING COMMENT 'Final determination of the due diligence exercise indicating whether the partner is cleared for sub-award or partnership engagement. Approved with conditions requires a documented corrective action plan.. Valid values are `approved|approved_with_conditions|rejected|deferred|inconclusive`',
    `record_reference_number` STRING COMMENT 'Externally-known unique alphanumeric reference code assigned to this due diligence record, used in correspondence, audit trails, and donor reporting. Format: DDR-YYYY-NNNNNN.. Valid values are `^DDR-[0-9]{4}-[0-9]{6}$`',
    `reviewer_notes` STRING COMMENT 'Confidential narrative notes recorded by the responsible staff member summarizing key findings, concerns, and recommendations from the due diligence review. Restricted to compliance and partnership leadership.',
    `risk_level` STRING COMMENT 'Composite risk rating assigned to the partner following due diligence, reflecting financial, governance, compliance, and operational risk factors. Determines monitoring intensity and sub-award conditions.. Valid values are `low|medium|high|critical`',
    `risk_score` STRING COMMENT 'Numeric composite risk score (typically 0–100) calculated from weighted assessment criteria across financial, governance, legal, and operational dimensions. Supports quantitative risk ranking across the partner portfolio.',
    `safeguarding_policy_verified` BOOLEAN COMMENT 'Indicates whether the partner has a documented and operational safeguarding policy covering protection from sexual exploitation, abuse, and harassment (PSEAH), child protection, and GBV prevention, as required by IASC and donor standards.',
    `sphere_compliance_status` STRING COMMENT 'Assessment of the partners operational compliance with the Sphere Humanitarian Charter and Minimum Standards in Humanitarian Response, covering WASH, food security, shelter, and health sectors.. Valid values are `compliant|partial|non_compliant|not_assessed`',
    `start_date` DATE COMMENT 'Date and time when the start event occurred for this due diligence record.',
    `supporting_document_ref` STRING COMMENT 'Reference identifier or URL pointing to the document management system location where supporting due diligence evidence (audit reports, registration certificates, signed certifications) is stored.',
    CONSTRAINT pk_due_diligence_record PRIMARY KEY(`due_diligence_record_id`)
) COMMENT 'Formal due diligence and partner verification master record covering legal compliance checks, sanctions screening (OFAC, EU, UN), anti-terrorism certification, financial audit review, governance verification, and regulatory standing. Includes embedded accreditation/certification tracking for CHS (Core Humanitarian Standard), Sphere compliance, HAP membership, ISO certifications, and national NGO registration status with issuing body, certificate number, issue date, expiry date, and verification status. Tracks due diligence type, completion date, outcome, risk level, next review date, and responsible staff. Required for compliance with 2 CFR 200, USAID ADS 303, and donor partner vetting regulations. This is the SSOT for all partner verification, screening, and accreditation data in the partnership domain.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` (
    `partner_contact_id` BIGINT COMMENT 'Unique system-generated identifier for the partner contact record. Primary key for the partner_contact data product within the partnership domain.',
    `partner_org_id` BIGINT COMMENT 'Reference to the partner organization to which this contact belongs. Links the individual contact to their parent Civil Society Organization (CSO), Community-Based Organization (CBO), International Non-Governmental Organization (INGO), UN agency, government body, or consortium entity.',
    `cluster_membership` STRING COMMENT 'Name of the OCHA humanitarian cluster(s) or IASC working group(s) in which this contact participates as a representative or lead (e.g., WASH Cluster, Health Cluster, Protection Cluster, Food Security Cluster). Supports inter-agency coordination tracking.',
    `partner_contact_code` STRING COMMENT 'Standardized code representing the partner contact classification or category.',
    `consent_date` DATE COMMENT 'Date on which the partner contact provided or last renewed their data sharing consent. Used to track consent validity periods and trigger re-consent workflows in compliance with GDPR and organizational data protection policies.',
    `contact_status` STRING COMMENT 'Current lifecycle status of the partner contact record. Indicates whether the contact is actively engaged in partnership coordination, temporarily unavailable, or no longer with the organization.. Valid values are `active|inactive|on_leave|departed|pending_verification`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the country where the partner contact is currently based or assigned. Used for geographic segmentation of partner networks and country-level coordination reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when the partner contact record was first created in the system. Provides the audit trail entry point for the records lifecycle in compliance with OMB Uniform Guidance 2 CFR 200 record retention requirements.',
    `data_sharing_consent` BOOLEAN COMMENT 'Indicates whether the partner contact has provided explicit consent for their personal data to be shared with third parties, donor agencies, or inter-agency coordination bodies. Required for compliance with GDPR, data protection regulations, and the Core Humanitarian Standard (CHS) accountability principles.',
    `department` STRING COMMENT 'Organizational department or unit within the partner organization where the contact is based (e.g., Finance, Programs, Monitoring Evaluation and Learning (MEL), Operations). Supports routing of communications to the correct functional area.',
    `partner_contact_description` STRING COMMENT 'Detailed textual description providing context about the partner contact.',
    `do_not_contact` BOOLEAN COMMENT 'Indicates that the partner contact has requested to not be contacted, or has been flagged by the organization as ineligible for outreach. Overrides all communication workflows and must be respected in all outreach campaigns.',
    `duty_station` STRING COMMENT 'Specific city, town, or field location where the partner contact is stationed. Used in humanitarian operations to identify field presence, coordinate cluster meetings, and assign contacts to geographic response zones.',
    `end_date` DATE COMMENT 'Date on which the partner contacts engagement formally ended, such as upon departure from the organization or role change. Null for currently active contacts. Used to maintain historical records and audit trails.',
    `first_name` STRING COMMENT 'Given name of the partner contact individual. Used for personalized communication and formal correspondence across the partnership lifecycle.',
    `gender` STRING COMMENT 'Self-identified gender of the partner contact. Used for gender disaggregation in partnership reporting, Sustainable Development Goal (SDG) 5 compliance tracking, and gender-balanced stakeholder engagement analysis.. Valid values are `male|female|non_binary|prefer_not_to_say`',
    `is_authorized_signatory` BOOLEAN COMMENT 'Indicates whether the partner contact is an authorized legal signatory for agreements such as Memoranda of Understanding (MoU), Letters of Agreement (LoA), sub-award agreements, and Scope of Work (SoW) documents. Critical for compliance with OMB Uniform Guidance 2 CFR 200 and donor requirements.',
    `is_financial_authorized` BOOLEAN COMMENT 'Indicates whether the partner contact holds financial authorization authority, such as approving sub-grant disbursements, signing financial reports, or authorizing Budget versus Actual (BvA) submissions. Supports financial stewardship and fund accounting controls.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this individual is the designated primary focal point for the partner organization. Only one contact per organization should be flagged as primary. Drives automated routing of official communications and partnership notifications.',
    `job_title` STRING COMMENT 'Official job title or designation of the partner contact within their organization (e.g., Country Director, Finance Manager, Program Coordinator). Used in formal correspondence and stakeholder mapping.',
    `last_interaction_date` DATE COMMENT 'Date of the most recent recorded interaction or communication with the partner contact. Used to identify dormant relationships, prioritize re-engagement, and support relationship management workflows in the Constituent Relationship Management (CRM) system.',
    `last_name` STRING COMMENT 'Family name or surname of the partner contact individual. Combined with first_name to form the full display name for reporting and relationship management.',
    `linkedin_profile` STRING COMMENT 'LinkedIn professional profile URL for the partner contact. Used for prospect research, due diligence verification, and professional background validation during partner capacity assessments.. Valid values are `^https?://(www.)?linkedin.com/in/[a-zA-Z0-9-_%]+/?$`',
    `middle_name` STRING COMMENT 'Middle name or second given name of the partner contact, used in formal legal correspondence and official documentation such as Memoranda of Understanding (MoU) and Letters of Agreement (LoA).',
    `mobile_phone` STRING COMMENT 'Mobile or cellular phone number for the partner contact in E.164 international format. Critical for field operations communication, WhatsApp coordination, and emergency contact in humanitarian contexts.. Valid values are `^+?[1-9]d{1,14}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this partner contact.',
    `partner_contact_name` STRING COMMENT 'Human-readable name or label for the partner contact.',
    `nationality` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the nationality of the partner contact. Used for visa and travel coordination, national staff vs. international staff classification, and compliance with local labor regulations.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, relationship history, or coordination notes about the partner contact. May include background on the contacts expertise, past collaboration history, or special communication instructions.',
    `office_address` STRING COMMENT 'Physical office address of the partner contacts workplace. Used for formal correspondence, field visit coordination, and partner mapping in Geographic Information System (GIS) tools.',
    `office_phone` STRING COMMENT 'Direct office or landline telephone number for the partner contact, including extension where applicable. Used for formal business communications and official coordination calls.. Valid values are `^+?[1-9]d{1,14}$`',
    `partner_contact_status` STRING COMMENT 'Current status indicator for the partner contact workflow state.',
    `preferred_contact_channel` STRING COMMENT 'The partner contacts preferred communication channel for receiving outreach and coordination messages. Supports effective stakeholder engagement and respects communication preferences in diverse field contexts.. Valid values are `email|phone|mobile|whatsapp|signal`',
    `preferred_language` STRING COMMENT 'ISO 639-1 or ISO 639-3 language code representing the partner contacts preferred language for communications and documentation (e.g., en for English, fr for French, ar for Arabic, es for Spanish). Supports multilingual coordination in international humanitarian operations.. Valid values are `^[a-z]{2,3}(-[A-Z]{2})?$`',
    `primary_email` STRING COMMENT 'Primary professional email address for the partner contact. Used as the main digital communication channel for coordination, reporting, and official correspondence including Memoranda of Understanding (MoU) and Scope of Work (SoW) exchanges.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone` STRING COMMENT 'Primary telephone number for the partner contact in E.164 international format. Used for urgent coordination, field communications, and stakeholder engagement across the partnership lifecycle.. Valid values are `^+?[1-9]d{1,14}$`',
    `role_type` STRING COMMENT 'Functional role classification of the contact within the partnership relationship. Determines the contacts authority and responsibilities in coordination workflows. [ENUM-REF-CANDIDATE: focal_point|authorized_representative|technical_lead|financial_officer|program_manager|legal_signatory|cluster_coordinator|field_officer — promote to reference product]. Valid values are `focal_point|authorized_representative|technical_lead|financial_officer|program_manager|legal_signatory`',
    `salutation` STRING COMMENT 'Honorific or title prefix used when addressing the partner contact in formal communications (e.g., Mr., Ms., Dr., Prof.).. Valid values are `Mr.|Ms.|Mrs.|Dr.|Prof.`',
    `skype_handle` STRING COMMENT 'Skype username or identifier for the partner contact. Used for virtual coordination meetings, remote field communications, and inter-agency conference calls in areas with limited connectivity.',
    `source_system_contact_reference` STRING COMMENT 'The unique identifier assigned to this contact record in the originating operational system of record (e.g., Salesforce Contact ID, Dynamics 365 Contact GUID). Enables cross-system reconciliation and data lineage tracing in the lakehouse Silver layer.',
    `start_date` DATE COMMENT 'Date on which the partner contact was first formally engaged or registered in the partnership management system. Marks the beginning of the contacts active role in the partnership lifecycle.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the partner contact record. Used for change tracking, data freshness monitoring, and incremental data pipeline processing in the Databricks Lakehouse Silver layer.',
    `verification_date` DATE COMMENT 'Date on which the partner contacts identity and credentials were last verified as part of the partner due diligence process. Used to schedule re-verification cycles and maintain compliance audit trails.',
    `verification_status` STRING COMMENT 'Status of the identity and credential verification process for the partner contact. Supports due diligence requirements for sub-award management and partner capacity assessments per USAID, DFID, and OMB Uniform Guidance 2 CFR 200 requirements.. Valid values are `verified|pending|failed|not_required`',
    CONSTRAINT pk_partner_contact PRIMARY KEY(`partner_contact_id`)
) COMMENT 'Master record for individual contacts within partner organizations including focal points, authorized representatives, technical leads, and financial officers. Captures name, title, role type, communication channels, language preference, and active status. Supports relationship management and coordination workflows across the partnership lifecycle.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` (
    `partner_performance_review_id` BIGINT COMMENT 'Unique system-generated identifier for each partner performance review record. Primary key for the partner_performance_review data product.',
    `agreement_id` BIGINT COMMENT 'Reference to the governing agreement (MoU, LoA, SoW, or sub-award) under which this performance review is conducted.',
    `capacity_assessment_id` BIGINT COMMENT 'Foreign key linking to partnership.capacity_assessment. Business justification: A partner performance review is directly informed by the most recent capacity assessment for that partner. The review already tracks capacity_building_recommended and capacity_building_areas, which ar',
    `implementation_plan_id` BIGINT COMMENT 'Reference to the program or project that the implementing partner is delivering under review.',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: NGO program managers run intervention-level partner performance dashboards and donor reports aggregating all partner reviews for a given intervention. The current path via implementation_plan is indir',
    `partner_org_id` BIGINT COMMENT 'Reference to the implementing partner organisation being reviewed. Links to the partner master record in the partnership domain.',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: Partner performance reviews are conducted within defined MEL reporting periods. MEL teams must correlate review ratings with reporting periods for consolidated period performance dashboards and donor ',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safeguarding.risk_assessment. Business justification: partner_performance_review has a safeguarding_compliance_rating attribute that should be grounded in a formal risk assessment. Linking to risk_assessment enables reviewers to reference the specific sa',
    `subaward_id` BIGINT COMMENT 'Foreign key linking to grant.subaward. Business justification: Subaward-level performance assessment: Partner performance reviews assess delivery under specific subawards. NGO grants management requires linking reviews to subawards for subaward closeout decisions',
    `approval_date` DATE COMMENT 'Date on which the performance review was formally approved by the authorised reviewer or partnership manager.',
    `areas_for_improvement` STRING COMMENT 'Narrative description of performance gaps, weaknesses, or risks identified during the review that require corrective action or capacity strengthening.',
    `beneficiary_feedback_incorporated` BOOLEAN COMMENT 'Indicates whether beneficiary feedback (e.g., from Post-Distribution Monitoring (PDM), Focus Group Discussions (FGD), or KoboToolbox surveys) was incorporated into the review findings.',
    `budget_utilisation_rate` DECIMAL(18,2) COMMENT 'Percentage of the sub-award budget expended by the partner during the review period (0.00–100.00). Key Budget versus Actual (BvA) indicator for financial stewardship assessment.',
    `capacity_building_areas` STRING COMMENT 'Narrative description of specific capacity building areas recommended for the partner (e.g., financial management, MEL systems, safeguarding, ICT4D). Populated when capacity_building_recommended is True.',
    `capacity_building_recommended` BOOLEAN COMMENT 'Indicates whether the reviewer recommends a formal capacity building or organisational development intervention for the partner based on identified gaps.',
    `partner_performance_review_code` STRING COMMENT 'Standardized code representing the partner performance review classification or category.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether a formal Corrective Action Plan (CAP) is required as an outcome of this review. True triggers a CAP workflow in the partnership management system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this performance review record was first created in the system. Supports audit trail and data lineage requirements.',
    `partner_performance_review_description` STRING COMMENT 'Detailed textual description providing context about the partner performance review.',
    `end_date` DATE COMMENT 'Date and time when the end event occurred for this partner performance review.',
    `field_visit_conducted` BOOLEAN COMMENT 'Indicates whether a physical field visit to the partners implementation site was conducted as part of this review. Required for high-risk partners per OMB Uniform Guidance subrecipient monitoring standards.',
    `financial_accountability_rating` STRING COMMENT 'Rating of the partners financial management practices including Budget versus Actual (BvA) variance, expenditure documentation, and compliance with Indirect Cost Rate (ICR) / NICRA requirements.. Valid values are `excellent|satisfactory|needs_improvement|unsatisfactory`',
    `key_findings_summary` STRING COMMENT 'Narrative summary of the principal findings from the performance review covering programmatic, financial, and compliance dimensions. Informs partnership renewal and risk management decisions.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this performance review record was most recently modified. Supports change tracking and Silver layer incremental processing in the Databricks Lakehouse.',
    `milestone_achievement_rate` DECIMAL(18,2) COMMENT 'Percentage of agreed SoW milestones achieved within the review period (0.00–100.00). Key Results-Based Management (RBM) indicator for partner performance tracking.',
    `milestones_achieved_count` STRING COMMENT 'Number of SoW milestones fully achieved within the review period. Numerator for milestone achievement rate calculation.',
    `milestones_planned_count` STRING COMMENT 'Total number of SoW milestones scheduled for delivery within the review period. Denominator for milestone achievement rate calculation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this partner performance review.',
    `partner_performance_review_name` STRING COMMENT 'Human-readable name or label for the partner performance review.',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the next performance review of this partner under the current agreement. Determined by risk level and agreement terms.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the partner performance review entity.',
    `overall_performance_rating` STRING COMMENT 'Composite performance rating assigned to the partner for the review period. Drives partnership renewal, risk classification, and sub-award decisions. Aligned with DAC evaluation criteria.. Valid values are `excellent|satisfactory|needs_improvement|unsatisfactory`',
    `overall_performance_score` DECIMAL(18,2) COMMENT 'Numeric composite score (e.g., 0.00–100.00) aggregating all scored dimensions of the review. Enables quantitative ranking and trend analysis across partners.',
    `partner_acknowledgement_date` DATE COMMENT 'Date on which the implementing partner formally acknowledged the review findings. Null until acknowledgement is received.',
    `partner_acknowledgement_received` BOOLEAN COMMENT 'Indicates whether the implementing partner has formally acknowledged receipt of the review findings and agreed corrective actions. Required for CHS accountability compliance.',
    `partner_performance_review_status` STRING COMMENT 'Current status indicator for the partner performance review workflow state.',
    `partnership_renewal_recommendation` STRING COMMENT 'Reviewers recommendation on whether to renew, conditionally renew, or terminate the partnership agreement based on this reviews findings. Feeds into partnership pipeline decisions.. Valid values are `renew|renew_with_conditions|do_not_renew|under_review`',
    `programmatic_quality_rating` STRING COMMENT 'Rating of the partners delivery quality against agreed SoW milestones, Theory of Change (ToC) outputs, and LogFrame indicators. Distinct from financial accountability.. Valid values are `excellent|satisfactory|needs_improvement|unsatisfactory`',
    `reporting_compliance_rating` STRING COMMENT 'Rating of the partners adherence to agreed reporting schedules, SitRep submissions, and donor reporting requirements including IATI data publication obligations.. Valid values are `excellent|satisfactory|needs_improvement|unsatisfactory`',
    `reports_due_count` STRING COMMENT 'Total number of reports required from the partner during the review period per the agreement schedule.',
    `reports_submitted_count` STRING COMMENT 'Number of required narrative and financial reports submitted by the partner during the review period.',
    `review_date` DATE COMMENT 'The actual calendar date on which the performance review meeting or assessment was conducted with the partner.',
    `review_method` STRING COMMENT 'Methodology used to conduct the performance review. Field visits provide direct observation; desk reviews rely on submitted documentation; joint reviews involve donor or cluster lead participation.. Valid values are `desk_review|field_visit|joint_review|remote_assessment`',
    `review_reference_number` STRING COMMENT 'Externally-known alphanumeric reference code assigned to this review for tracking in correspondence, donor reports, and audit trails. Format: PPR-YYYY-NNNNNN.. Valid values are `^PPR-[0-9]{4}-[0-9]{6}$`',
    `review_status` STRING COMMENT 'Current lifecycle state of the performance review record. Drives workflow routing for approval and archiving.. Valid values are `draft|in_progress|completed|approved|cancelled`',
    `review_type` STRING COMMENT 'Classification of the review occasion. Scheduled reviews occur at fixed intervals per the SoW; triggered reviews are initiated by risk events or compliance concerns; final reviews occur at agreement close-out.. Valid values are `scheduled|ad_hoc|triggered|final|mid_term`',
    `risk_level` STRING COMMENT 'Risk classification assigned to the partner as an outcome of this review. Informs sub-award monitoring intensity, financial controls, and escalation protocols.. Valid values are `low|medium|high|critical`',
    `safeguarding_compliance_rating` STRING COMMENT 'Rating of the partners compliance with safeguarding policies including GBV prevention, child protection, and HAP/CHS accountability commitments.. Valid values are `excellent|satisfactory|needs_improvement|unsatisfactory`',
    `start_date` DATE COMMENT 'Date and time when the start event occurred for this partner performance review.',
    `strengths_noted` STRING COMMENT 'Narrative description of the partners notable strengths and positive performance areas identified during the review. Used for learning and best-practice documentation.',
    CONSTRAINT pk_partner_performance_review PRIMARY KEY(`partner_performance_review_id`)
) COMMENT 'Periodic performance review records for implementing partners assessing delivery against agreed SoW milestones, reporting compliance, financial accountability, and programmatic quality. Captures review period, performance rating, key findings, corrective action requirements, and reviewer details. Feeds into partnership renewal and risk management decisions.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`consortium` (
    `consortium_id` BIGINT COMMENT 'Unique system-generated identifier for the consortium record. Primary key for the consortium master data product within the partnership domain.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Consortium currently stores agreement_reference as STRING but has no FK to the actual partnership_agreement record. Consortia are formalized through partnership agreements (MoUs). Adding partnership_a',
    `due_diligence_record_id` BIGINT COMMENT 'Foreign key linking to partnership.due_diligence_record. Business justification: Consortia undergo formal due diligence as an entity (separate from individual member due diligence). The consortium table currently stores due_diligence_date and due_diligence_status as denormalized s',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: Consortia are formed to deliver specific interventions through multi-partner collaboration. Linking consortium to intervention enables consolidated program reporting, multi-partner results tracking, a',
    `partner_org_id` BIGINT COMMENT 'FK to partnership.partner_org',
    `constituent_id` BIGINT COMMENT 'FK to donor.constituent',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safeguarding.risk_assessment. Business justification: Consortiums operating across multiple partners and geographies require a consortium-level safeguarding risk assessment distinct from individual agreement-level assessments. Cluster coordination bodies',
    `chs_compliance_status` STRING COMMENT 'Status of the consortiums adherence to the Core Humanitarian Standard (CHS) on Quality and Accountability, assessed through partner due diligence and capacity assessments.. Valid values are `compliant|partial|non_compliant|under_review|not_assessed`',
    `consortium_code` STRING COMMENT 'Standardized code representing the consortium classification or category.',
    `consortium_status` STRING COMMENT 'Current status indicator for the consortium workflow state.',
    `consortium_type` STRING COMMENT 'Classification of the consortium arrangement indicating Ngos role and the structural form. Lead_agency means Ngo is the prime recipient; member means Ngo is a sub-partner; pooled_fund indicates a CERF or similar mechanism. [ENUM-REF-CANDIDATE: lead_agency|member|co_implementer|pooled_fund|consortium_of_consortia — promote to reference product]. Valid values are `lead_agency|member|co_implementer|pooled_fund|consortium_of_consortia`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the primary country of consortium operations. For multi-country consortia, this represents the lead country of registration or primary operational context.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consortium record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `decision_making_protocol` STRING COMMENT 'Formal protocol governing how decisions are made within the consortium. Consensus requires unanimous agreement; majority_vote uses simple majority; lead_agency_authority delegates decisions to the prime recipient; weighted_vote allocates votes by funding share.. Valid values are `consensus|majority_vote|lead_agency_authority|weighted_vote`',
    `consortium_description` STRING COMMENT 'Detailed textual description providing context about the consortium.',
    `end_date` DATE COMMENT 'Date on which the consortium agreement expires or joint programming is scheduled to conclude. Nullable for open-ended arrangements. Critical for compliance reporting and closeout planning.',
    `funding_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the total funding envelope (e.g., USD, EUR, GBP). Aligns with IATI currency reporting standards and SAP S/4HANA fund accounting.. Valid values are `^[A-Z]{3}$`',
    `geographic_scope` STRING COMMENT 'Description of the geographic coverage of consortium operations, including countries, regions, or administrative zones. May reference GIS-coded areas or OCHA P-codes for field operations.',
    `governance_structure` STRING COMMENT 'Narrative description of the consortiums governance model including steering committee composition, decision-making protocols, voting rights, and escalation procedures as defined in the consortium agreement.',
    `grand_bargain_localization` BOOLEAN COMMENT 'Indicates whether this consortium is formally counted toward Ngos Grand Bargain localization commitments, specifically the 25% funding to local and national actors target.',
    `iasc_working_group` STRING COMMENT 'Name of the IASC working group or task force with which this consortium coordinates, relevant for inter-agency humanitarian response planning and joint needs assessments.',
    `iati_identifier` STRING COMMENT 'Globally unique IATI activity identifier for the consortium, enabling public transparency reporting on aid flows, partner contributions, and results per IATI Standard requirements.',
    `localization_percentage` DECIMAL(18,2) COMMENT 'Percentage of the total consortium funding envelope directed to local and national CSOs or CBOs as sub-partners, tracked against Grand Bargain 25% localization commitment.',
    `logframe_ref` STRING COMMENT 'Reference identifier or document title of the consortiums Logical Framework (LogFrame) used for results-based management (RBM), KPI tracking, and donor reporting.',
    `mel_framework_ref` STRING COMMENT 'Reference identifier or document title of the consortiums joint MEL (Monitoring Evaluation and Learning) or MEAL (Monitoring Evaluation Accountability and Learning) framework used for collective results measurement.',
    `member_count` STRING COMMENT 'Total number of partner organizations formally participating in the consortium, including lead agency and all sub-partners (INGOs, CSOs, CBOs, UN agencies, government bodies).',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this consortium.',
    `consortium_name` STRING COMMENT 'Official full name of the multi-partner consortium or joint programming arrangement as registered with the lead donor or coordinating body (e.g., OCHA cluster).',
    `ngo_funding_share` DECIMAL(18,2) COMMENT 'Portion of the total consortium funding envelope allocated to Ngo, whether as lead agency managing sub-awards or as a sub-partner receiving a sub-grant. Used for BvA (Budget versus Actual) reporting and ICR/NICRA calculations.',
    `ngo_role` STRING COMMENT 'Specific role that Ngo plays within this consortium arrangement. Lead_agency means Ngo holds the prime award and manages sub-awards; co_lead means shared leadership; sub_partner means Ngo receives a sub-award from the lead.. Valid values are `lead_agency|sub_partner|co_lead|observer`',
    `notes` STRING COMMENT 'Free-text field for additional contextual information about the consortium not captured in structured fields, including coordination challenges, strategic rationale, or historical context.',
    `ocha_cluster_alignment` STRING COMMENT 'Name of the OCHA humanitarian cluster(s) or sector working group(s) to which this consortium is formally aligned or co-leads (e.g., WASH Cluster, Food Security Cluster, Health Cluster, Protection Cluster).',
    `operational_status` STRING COMMENT 'Current lifecycle state of the consortium. Pipeline indicates pre-formation; active indicates ongoing joint programming; suspended indicates temporary halt; closed indicates completed; dissolved indicates formally terminated with no further obligations.. Valid values are `pipeline|active|suspended|closed|dissolved`',
    `pooled_fund_mechanism` STRING COMMENT 'Name of the pooled funding mechanism associated with the consortium if applicable (e.g., CERF, Country-Based Pooled Fund (CBPF), ECHO, BHA). Supports ODA tracking and joint donor reporting.',
    `reference_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the consortium by the lead donor, OCHA, or internal grant management system (GMS) for cross-system identification and reporting.. Valid values are `^[A-Z0-9-]{3,30}$`',
    `reporting_frequency` STRING COMMENT 'Agreed frequency of joint donor reporting and SitRep (Situation Report) submissions for the consortium, as stipulated in the consortium agreement or donor grant conditions.. Valid values are `monthly|quarterly|semi_annual|annual|ad_hoc`',
    `sdg_alignment` STRING COMMENT 'Comma-separated list of UN Sustainable Development Goal (SDG) numbers to which the consortiums programming contributes (e.g., 2,3,6 for Zero Hunger, Good Health, Clean Water). Supports IATI and donor reporting.',
    `short_name` STRING COMMENT 'Abbreviated or commonly used name or acronym for the consortium used in SitReps, donor reports, and inter-agency communications.',
    `start_date` DATE COMMENT 'Date on which the consortium agreement becomes effective and joint programming operations commence. Used for grant financial management period-of-performance tracking.',
    `steering_committee_composition` STRING COMMENT 'Description of the steering committee membership including designated representatives from each partner organization, their roles (chair, co-chair, member), and meeting frequency.',
    `thematic_focus` STRING COMMENT 'Primary humanitarian or development sector(s) addressed by the consortium (e.g., WASH, GBV, food security, health, education, PSS). Aligns with OCHA cluster system and IASC sector classifications.',
    `theory_of_change_ref` STRING COMMENT 'Reference identifier or document title of the consortiums Theory of Change (ToC) that articulates the causal pathway from inputs and activities to intended outcomes and impact. Used in MEL and MEAL frameworks.',
    `total_funding_amount` DECIMAL(18,2) COMMENT 'Total funding envelope committed to the consortium across all member organizations and donor sources, expressed in the reporting currency. Used for Grand Bargain localization tracking and joint donor reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the consortium record was most recently modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports change tracking and data governance.',
    CONSTRAINT pk_consortium PRIMARY KEY(`consortium_id`)
) COMMENT 'Master record for multi-partner consortia and joint programming arrangements where Ngo acts as lead agency or member. Captures consortium name, lead organization, governance structure (steering committee composition, decision-making protocols), consortium agreement reference, geographic scope, thematic focus, total funding envelope, and operational status. Supports coordination with OCHA cluster leads, IASC working groups, and pooled fund mechanisms. Essential for Grand Bargain localization commitments and joint donor reporting.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` (
    `consortium_member_id` BIGINT COMMENT 'Unique identifier for the consortium member association record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Each consortium member typically operates under their own sub-award agreement with the NGO. The consortium_member table currently stores sub_award_agreement_number as a denormalized string reference. ',
    `capacity_assessment_id` BIGINT COMMENT 'Foreign key linking to partnership.capacity_assessment. Business justification: Each consortium members capacity is assessed individually as part of consortium formation and ongoing governance. The consortium_member table currently stores capacity_assessment_date and capacity_as',
    `consortium_id` BIGINT COMMENT 'Reference to the consortium arrangement that this member belongs to.',
    `due_diligence_record_id` BIGINT COMMENT 'Foreign key linking to partnership.due_diligence_record. Business justification: Each consortium member undergoes individual due diligence as part of consortium onboarding. The consortium_member table currently stores due_diligence_completion_date and due_diligence_status as denor',
    `partner_org_id` BIGINT COMMENT 'Reference to the partner organization participating as a member of this consortium.',
    `subaward_id` BIGINT COMMENT 'Foreign key linking to grant.subaward. Business justification: Consortium member funding instrument: Each consortium member receives a subaward as their funding instrument. Linking consortium_member to subaward supports FFATA/FSRS reporting, sub-recipient monitor',
    `consortium_member_code` STRING COMMENT 'Standardized code representing the consortium member classification or category.',
    `consortium_member_status` STRING COMMENT 'Current status indicator for the consortium member workflow state.',
    `contribution_type` DECIMAL(18,2) COMMENT 'The primary type of contribution this member provides to the consortium (financial resources, in-kind goods/services, technical assistance, capacity building, advocacy, coordination).',
    `cost_share_percentage` DECIMAL(18,2) COMMENT 'The percentage of total project costs that this member organization must contribute as cost-sharing or matching funds.',
    `cost_share_required` BOOLEAN COMMENT 'Indicates whether this member organization is required to provide cost-sharing or matching funds as part of their consortium participation.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this consortium member record was first created in the system.',
    `consortium_member_description` STRING COMMENT 'Detailed textual description providing context about the consortium member.',
    `end_date` DATE COMMENT 'Date and time when the end event occurred for this consortium member.',
    `funding_allocation_amount` DECIMAL(18,2) COMMENT 'The absolute monetary amount allocated to this member organization from the consortium budget.',
    `funding_allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of total consortium funding allocated to this member organization for their scope of work.',
    `funding_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the funding allocation amount.. Valid values are `^[A-Z]{3}$`',
    `geographic_responsibility` STRING COMMENT 'The geographic area, region, or administrative unit where this member has primary implementation responsibility within the consortium arrangement.',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'The negotiated indirect cost rate (ICR) or facilities and administration (F&A) rate applicable to this member organizations sub-award, expressed as a percentage.',
    `member_role` STRING COMMENT 'The functional role that this partner organization plays within the consortium (e.g., lead agency, co-implementer, technical advisor, sub-recipient, associate member, observer).. Valid values are `lead|co_implementer|technical_advisor|sub_recipient|associate_member|observer`',
    `membership_end_date` DATE COMMENT 'The date when this partner organizations membership in the consortium ended or is scheduled to end. Null for ongoing memberships.',
    `membership_start_date` DATE COMMENT 'The date when this partner organization officially joined the consortium and their membership became effective.',
    `membership_status` STRING COMMENT 'Current lifecycle status of this consortium membership (active, pending approval, suspended, withdrawn by member, terminated by consortium, inactive).. Valid values are `active|pending|suspended|withdrawn|terminated|inactive`',
    `modified_by` STRING COMMENT 'Username or identifier of the system user who last modified this consortium member record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this consortium member record was last modified or updated in the system.',
    `consortium_member_name` STRING COMMENT 'Human-readable name or label for the consortium member.',
    `notes` STRING COMMENT 'Additional notes, comments, or contextual information about this consortium membership that does not fit into other structured fields.',
    `performance_rating` STRING COMMENT 'Most recent performance rating assigned to this member organization based on their consortium deliverables, reporting quality, and compliance (excellent, satisfactory, needs improvement, unsatisfactory, not yet rated).. Valid values are `excellent|satisfactory|needs_improvement|unsatisfactory|not_rated`',
    `performance_review_date` DATE COMMENT 'The date when the most recent performance review was conducted for this member organization.',
    `reporting_frequency` STRING COMMENT 'The frequency at which this member is required to submit progress and financial reports to the consortium lead (monthly, quarterly, semi-annual, annual, ad-hoc).. Valid values are `monthly|quarterly|semi_annual|annual|ad_hoc`',
    `reporting_template_reference` STRING COMMENT 'Reference identifier or name of the standardized reporting template that this member must use for consortium reporting.',
    `risk_mitigation_plan` STRING COMMENT 'Description of the risk mitigation measures and monitoring activities put in place for this member organization.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to this member organization based on capacity assessment, due diligence, and operational context (low, medium, high, critical).. Valid values are `low|medium|high|critical`',
    `signing_authority_name` STRING COMMENT 'Full name of the authorized representative from the member organization who signed the consortium agreement or MoU.',
    `signing_authority_title` STRING COMMENT 'Official title or position of the signing authority within the member organization (e.g., Executive Director, Country Director, Chief Executive Officer).',
    `signing_date` DATE COMMENT 'The date when the member organizations authorized representative signed the consortium agreement or MoU.',
    `start_date` DATE COMMENT 'Date and time when the start event occurred for this consortium member.',
    `steering_committee_representative` STRING COMMENT 'Name of the individual representing this member organization on the consortium steering committee or governance body.',
    `sub_award_type` STRING COMMENT 'The type of legal instrument governing this members participation (sub-grant, sub-contract, MoU - Memorandum of Understanding, LoA - Letter of Agreement, SoW - Scope of Work).. Valid values are `sub_grant|sub_contract|mou|loa|sow`',
    `technical_working_group_participation` STRING COMMENT 'List or description of technical working groups, IASC clusters, or OCHA coordination mechanisms in which this member actively participates on behalf of the consortium.',
    `thematic_responsibility` STRING COMMENT 'The thematic area, sector, or technical domain where this member has primary responsibility (e.g., WASH, health, protection, education, nutrition).',
    `voting_rights` BOOLEAN COMMENT 'Indicates whether this member organization has voting rights in consortium governance decisions and steering committee meetings.',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created this consortium member record.',
    CONSTRAINT pk_consortium_member PRIMARY KEY(`consortium_member_id`)
) COMMENT 'Association record linking partner organizations to consortia, capturing each members role (lead, co-implementer, technical advisor), contribution type, funding allocation percentage, geographic responsibility, and membership status. Tracks the full composition and role distribution within each consortium arrangement.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` (
    `partner_report_submission_id` BIGINT COMMENT 'Unique system-generated identifier for each partner report submission record. Primary key for this entity.',
    `agreement_id` BIGINT COMMENT 'Reference to the sub-award, MoU, LoA, or SoW under which this report is submitted. Links the submission to its governing partnership agreement.',
    `award_id` BIGINT COMMENT 'Reference to the grant or funding award associated with this report submission, enabling traceability to the donor funding source.',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to program.budget_plan. Business justification: Partner financial reports must reference the approved budget plan for budget-vs-actual variance analysis, expenditure verification against approved line items, burn rate tracking, and financial accoun',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Partner financial and narrative reports in NGO operations are submitted against specific components (sub-award tranches). Component-level expenditure reconciliation and donor reporting require knowing',
    `donor_report_id` BIGINT COMMENT 'Foreign key linking to grant.donor_report. Business justification: Partner-to-donor report compilation: Partner report submissions are aggregated into NGO donor reports. This link supports the reporting consolidation process — tracking which partner submissions feed ',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Each partner report submission fulfills a specific donor requirement (deliverable format, due date, submission method). NGO compliance teams track which donor requirement each submission satisfies for',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project under which the partner is implementing activities and for which this report is submitted.',
    `partner_org_id` BIGINT COMMENT 'Reference to the implementing partner (Civil Society Organization, Community-Based Organization, INGO, government body, or UN agency) that submitted this report.',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: Partner report submissions must be reconciled against MEL reporting periods for consolidated period-based performance reporting. NGO program staff and donors require period-aligned aggregation of part',
    `subaward_id` BIGINT COMMENT 'Foreign key linking to grant.subaward. Business justification: Partners submit performance and financial reports specific to their subaward scope, not just prime award. Subaward-level reporting is standard practice in tiered grant management for tracking downstre',
    `acceptance_date` DATE COMMENT 'The date on which the report was formally accepted by the organization, signifying that all reporting obligations for the period have been satisfactorily met by the implementing partner.',
    `approved_budget_amount` DECIMAL(18,2) COMMENT 'The approved sub-award budget amount for the reporting period against which the partners reported expenditure is compared in Budget versus Actual (BvA) analysis.',
    `beneficiaries_reached` STRING COMMENT 'Total number of direct beneficiaries (Persons of Concern, IDPs, or target population) reached by the partners program activities during the reporting period, as reported by the partner.',
    `cluster_sector` STRING COMMENT 'The humanitarian cluster or sector (e.g., WASH, Health, Shelter, Food Security, Protection, GBV) under which the partners reported activities fall, aligned with OCHA cluster coordination structures.',
    `partner_report_submission_code` STRING COMMENT 'Standardized code representing the partner report submission classification or category.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary country of implementation covered by this report submission.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this partner report submission record was first created in the system, providing an audit trail for data governance and compliance purposes.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the currency in which the partner reported expenditures (e.g., USD, EUR, GBP). Required for multi-currency grant environments.. Valid values are `^[A-Z]{3}$`',
    `days_late` STRING COMMENT 'Number of calendar days by which the submission exceeded the due date. Zero or negative values indicate on-time or early submission. Used for partner performance scoring and compliance reporting.',
    `partner_report_submission_description` STRING COMMENT 'Detailed textual description providing context about the partner report submission.',
    `document_url` STRING COMMENT 'URL or file path to the primary report document stored in the document management system or GMS (Grant Management System), enabling direct access to the submitted report file.',
    `donor_reporting_obligation` BOOLEAN COMMENT 'Indicates whether this partner report submission is required to satisfy a specific donor reporting obligation (e.g., USAID BHA, DFID, CERF), meaning the data must be incorporated into the prime recipients donor report.',
    `due_date` DATE COMMENT 'The contractually obligated deadline by which the partner was required to submit this report, as specified in the sub-award agreement or LoA.',
    `end_date` DATE COMMENT 'Date and time when the end event occurred for this partner report submission.',
    `feedback_provided` DECIMAL(18,2) COMMENT 'Detailed written feedback, comments, or queries provided by the reviewer to the implementing partner following the review of the submitted report. Captures specific issues, clarifications required, or commendations.',
    `financial_documentation_attached` BOOLEAN COMMENT 'Indicates whether the partner attached supporting financial documentation (receipts, invoices, bank statements) to this report submission as required under 2 CFR 200 and the sub-award agreement.',
    `geographic_coverage` STRING COMMENT 'Description of the geographic areas (districts, regions, or country) where the partner implemented activities during the reporting period, as reported. May reference GIS coordinates or administrative boundaries.',
    `is_late_submission` BOOLEAN COMMENT 'Indicates whether the report was submitted after the contractually obligated due date. True if submission_date is after due_date. Used for partner performance monitoring and compliance tracking.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this partner report submission record was most recently modified in the system, supporting audit trail requirements and data lineage tracking in the Databricks Silver Layer.',
    `mel_indicators_reported` BOOLEAN COMMENT 'Indicates whether the partner included MEL (Monitoring Evaluation and Learning) indicator data and results in this report submission, as required by the sub-award agreement.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this partner report submission.',
    `partner_report_submission_name` STRING COMMENT 'Human-readable name or label for the partner report submission.',
    `narrative_summary` STRING COMMENT 'A concise summary of the programmatic progress, key achievements, challenges, and lessons learned as reported by the implementing partner for the reporting period.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the partner report submission entity.',
    `partner_report_submission_status` STRING COMMENT 'Current status indicator for the partner report submission workflow state.',
    `quality_score` DECIMAL(18,2) COMMENT 'Numeric quality assessment score assigned by the reviewer to the submitted report, typically on a standardized scale (e.g., 0–100). Reflects completeness, accuracy, and adherence to reporting standards. Used for partner performance monitoring.',
    `remarks` STRING COMMENT 'Additional notes, contextual observations, or internal comments recorded by the grants management team regarding this report submission, such as exceptional circumstances, force majeure events, or escalation notes.',
    `report_period_frequency` STRING COMMENT 'The scheduled reporting cadence for this submission as defined in the sub-award agreement, indicating whether the report covers a monthly, quarterly, semi-annual, annual, or ad hoc period.. Valid values are `monthly|quarterly|semi_annual|annual|ad_hoc`',
    `report_title` STRING COMMENT 'The formal title or name of the submitted report document as provided by the implementing partner, used for identification and document management purposes.',
    `report_type` STRING COMMENT 'Classification of the report submitted by the partner. Narrative reports cover programmatic progress; financial reports cover expenditure against budget (BvA); SitRep (Situation Report) covers operational context; PDM (Post-Distribution Monitoring) covers distribution outcomes; combined covers both narrative and financial. [ENUM-REF-CANDIDATE: narrative|financial|situation_report|post_distribution_monitoring|combined|other — promote to reference product]. Valid values are `narrative|financial|situation_report|post_distribution_monitoring|combined`',
    `report_version` STRING COMMENT 'Sequential version number of the report submission, incremented each time the partner resubmits a revised version following feedback or a revision request. Version 1 is the initial submission.',
    `review_completion_date` DATE COMMENT 'The date on which the review of the partner report was completed and a decision (accepted, feedback issued, or rejected) was communicated to the partner.',
    `review_start_date` DATE COMMENT 'The date on which the formal review of the submitted report was initiated by the grants management team.',
    `review_status` STRING COMMENT 'Current workflow state of the report submission in the review and acceptance lifecycle. Tracks progression from initial receipt through quality review, feedback, revision, and final acceptance or rejection.. Valid values are `pending_review|under_review|feedback_issued|revision_requested|accepted|rejected`',
    `revision_deadline` DATE COMMENT 'The deadline by which the implementing partner must resubmit a revised report following a revision request or feedback issuance. Null if no revision has been requested.',
    `start_date` DATE COMMENT 'Date and time when the start event occurred for this partner report submission.',
    `submission_date` DATE COMMENT 'The actual calendar date on which the partner submitted this report to the organization. Used to calculate timeliness and compliance with reporting obligations.',
    `submission_method` STRING COMMENT 'The channel or mechanism through which the partner submitted the report, such as email, online portal, GMS (Grant Management System) upload, hard copy, or KoboToolbox.. Valid values are `email|online_portal|gms_upload|hard_copy|kobo_toolbox`',
    `submission_reference_number` STRING COMMENT 'Externally-known alphanumeric reference code assigned to this report submission, used in correspondence with the partner and in donor reporting systems such as Unit4 ERP or GMS.',
    `submission_timestamp` TIMESTAMP COMMENT 'The precise date and time at which the partner report was received or uploaded into the grant management system, capturing the exact moment of submission for audit trail purposes.',
    `target_beneficiaries` STRING COMMENT 'The planned number of beneficiaries the partner was expected to reach during the reporting period as defined in the sub-award agreement or LogFrame targets.',
    `total_expenditure_reported` DECIMAL(18,2) COMMENT 'The total financial expenditure reported by the implementing partner for the reporting period, as stated in the financial report. Used for Budget versus Actual (BvA) analysis and donor financial reporting.',
    CONSTRAINT pk_partner_report_submission PRIMARY KEY(`partner_report_submission_id`)
) COMMENT 'Tracks all programmatic and financial reports submitted by implementing partners under their sub-award or agreement obligations. Captures report type (narrative, financial, SitRep, PDM), reporting period, submission date, review status, feedback provided, and acceptance date. Supports compliance monitoring and donor reporting obligations under 2 CFR 200. Systems-of-record: eTools (PD/SSFA reporting), InSight. Framework: HACT / IATI v2.03 result reporting.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ADD CONSTRAINT `fk_partnership_agreement_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ADD CONSTRAINT `fk_partnership_capacity_assessment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ADD CONSTRAINT `fk_partnership_capacity_assessment_prior_assessment_capacity_assessment_id` FOREIGN KEY (`prior_assessment_capacity_assessment_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`capacity_assessment`(`capacity_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ADD CONSTRAINT `fk_partnership_due_diligence_record_capacity_assessment_id` FOREIGN KEY (`capacity_assessment_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`capacity_assessment`(`capacity_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ADD CONSTRAINT `fk_partnership_due_diligence_record_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ADD CONSTRAINT `fk_partnership_partner_contact_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ADD CONSTRAINT `fk_partnership_partner_performance_review_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ADD CONSTRAINT `fk_partnership_partner_performance_review_capacity_assessment_id` FOREIGN KEY (`capacity_assessment_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`capacity_assessment`(`capacity_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ADD CONSTRAINT `fk_partnership_partner_performance_review_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ADD CONSTRAINT `fk_partnership_consortium_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ADD CONSTRAINT `fk_partnership_consortium_due_diligence_record_id` FOREIGN KEY (`due_diligence_record_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`due_diligence_record`(`due_diligence_record_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ADD CONSTRAINT `fk_partnership_consortium_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ADD CONSTRAINT `fk_partnership_consortium_member_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ADD CONSTRAINT `fk_partnership_consortium_member_capacity_assessment_id` FOREIGN KEY (`capacity_assessment_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`capacity_assessment`(`capacity_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ADD CONSTRAINT `fk_partnership_consortium_member_consortium_id` FOREIGN KEY (`consortium_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`consortium`(`consortium_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ADD CONSTRAINT `fk_partnership_consortium_member_due_diligence_record_id` FOREIGN KEY (`due_diligence_record_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`due_diligence_record`(`due_diligence_record_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ADD CONSTRAINT `fk_partnership_consortium_member_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`partnership` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_ngo_v1`.`partnership` SET TAGS ('dbx_domain' = 'partnership');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` SET TAGS ('dbx_subdomain' = 'partner_registry');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `psea_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Psea Policy Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `statutory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Statutory Registration Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|provisional|not_accredited|suspended|under_review');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `annual_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Organizational Budget (USD)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `annual_budget_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `authorized_rep_name` SET TAGS ('dbx_business_glossary_term' = 'Authorized Representative Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `authorized_rep_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `authorized_rep_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `authorized_rep_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `authorized_rep_title` SET TAGS ('dbx_business_glossary_term' = 'Authorized Representative Title');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `bank_country` SET TAGS ('dbx_business_glossary_term' = 'Partner Bank Country');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `bank_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `bank_country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Banking Institution Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `bank_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `bank_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `bank_name` SET TAGS ('dbx_pii_type' = 'financial');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `capacity_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Partner Capacity Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `capacity_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Partner Capacity Assessment Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `capacity_assessment_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `chs_certified` SET TAGS ('dbx_business_glossary_term' = 'Core Humanitarian Standard (CHS) Certification Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `cluster_memberships` SET TAGS ('dbx_business_glossary_term' = 'OCHA Cluster Memberships');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `countries_of_operation` SET TAGS ('dbx_business_glossary_term' = 'Countries of Operation');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `due_diligence_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `due_diligence_status` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `due_diligence_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|not_started|expired|waived');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `finance_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Finance Officer Email Address');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `finance_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `finance_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `finance_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `finance_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `founding_year` SET TAGS ('dbx_business_glossary_term' = 'Organization Founding Year');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `hact_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'HACT Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `hq_address` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Mailing Address');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `hq_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `hq_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `hq_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `hq_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `hq_city` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `hq_country` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `hq_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `iati_org_identifier` SET TAGS ('dbx_business_glossary_term' = 'International Aid Transparency Initiative (IATI) Organization Identifier');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `ip_transfer_modality` SET TAGS ('dbx_business_glossary_term' = 'IP Transfer Modality');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `mission_statement` SET TAGS ('dbx_business_glossary_term' = 'Organization Mission Statement');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `partner_org_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `org_acronym` SET TAGS ('dbx_business_glossary_term' = 'Organization Acronym');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `org_name` SET TAGS ('dbx_business_glossary_term' = 'Organization Legal Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `org_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `org_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `org_type` SET TAGS ('dbx_business_glossary_term' = 'Organization Type Classification');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `org_website` SET TAGS ('dbx_business_glossary_term' = 'Organization Website URL');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `org_website` SET TAGS ('dbx_value_regex' = '^https?://[^s/$.?#].[^s]*$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `partnership_status` SET TAGS ('dbx_business_glossary_term' = 'Partnership Lifecycle Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `partnership_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_vetting|blacklisted|archived');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Language');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Focal Point Email Address');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Focal Point Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Focal Point Phone Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Focal Point Title');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `sanctions_screen_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `sanctions_screened` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Completed Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `staff_count` SET TAGS ('dbx_business_glossary_term' = 'Total Staff Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `thematic_focus_areas` SET TAGS ('dbx_business_glossary_term' = 'Thematic Focus Areas');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `volunteer_count` SET TAGS ('dbx_business_glossary_term' = 'Total Volunteer Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` SET TAGS ('dbx_subdomain' = 'agreement_compliance');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `psea_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Psea Policy Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'MoU|LoA|SoW|sub_award|consortium|other');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Description');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `capacity_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Partner Capacity Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `capacity_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Partner Capacity Assessment Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `capacity_assessment_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|completed|failed|waived');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `cluster_lead_agency` SET TAGS ('dbx_business_glossary_term' = 'OCHA Cluster Lead Agency');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `disbursed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disbursed Amount');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_value_regex' = 'negotiation|mediation|arbitration|litigation|other');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `due_diligence_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `due_diligence_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `due_diligence_risk_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Execution Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `funding_ceiling_amount` SET TAGS ('dbx_business_glossary_term' = 'Funding Ceiling Amount');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `funding_ceiling_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `governing_law_country_code` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Country Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `governing_law_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `hact_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'HACT Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `iati_activity_identifier` SET TAGS ('dbx_business_glossary_term' = 'International Aid Transparency Initiative (IATI) Activity Identifier');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `ip_transfer_modality` SET TAGS ('dbx_business_glossary_term' = 'IP Transfer Modality');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `is_consortium_agreement` SET TAGS ('dbx_business_glossary_term' = 'Is Consortium Agreement Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `is_sub_award` SET TAGS ('dbx_business_glossary_term' = 'Is Sub-Award Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `lead_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Organization Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `lead_organization_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `lead_organization_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `liquidated_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Amount');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `mvm_migration_reference` SET TAGS ('dbx_business_glossary_term' = 'MVM Migration Reference');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `mvm_migration_reference` SET TAGS ('dbx_ecm_reconciliation' = 'mvm_stub_agreement');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `operational_country_code` SET TAGS ('dbx_business_glossary_term' = 'Operational Country Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `operational_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `outstanding_dct_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding DCT Amount');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `parent_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Parent Agreement Reference Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `partnership_agreement_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `program_sector` SET TAGS ('dbx_business_glossary_term' = 'Program Sector');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Reference Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|ad_hoc');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Agreement Scope Description');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `sdg_alignment_codes` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment Codes');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `signatory_name_lead` SET TAGS ('dbx_business_glossary_term' = 'Lead Organization Signatory Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `signatory_name_lead` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `signatory_name_lead` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `signatory_name_lead` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `signatory_name_partner` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization Signatory Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `signatory_name_partner` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `signatory_name_partner` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `signatory_name_partner` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Termination Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'mutual_consent|breach|force_majeure|funding_exhausted|program_closure|other');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `theory_of_change_reference` SET TAGS ('dbx_business_glossary_term' = 'Theory of Change (ToC) Reference');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Agreement Title');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `transfer_modality` SET TAGS ('dbx_business_glossary_term' = 'IP Transfer Modality');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` SET TAGS ('dbx_subdomain' = 'agreement_compliance');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `capacity_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `prior_assessment_capacity_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Capacity Assessment ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment End Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_location_country` SET TAGS ('dbx_business_glossary_term' = 'Assessment Location Country Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_location_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_location_country` SET TAGS ('dbx_pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_methodology` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Methodology');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_methodology` SET TAGS ('dbx_value_regex' = 'USAID_OCA|DFID_OCAT|ECHO_PACA|IRC_CCAT|UNDP_CAPACITY_SCORECARD|OTHER');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Reference Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_reference_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}-CA-[0-9]{4}-[0-9]{4,6}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_report_url` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Report Document URL');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_report_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_scope` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Scope');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_scope` SET TAGS ('dbx_value_regex' = 'FULL|ABBREVIATED|DESK_REVIEW|FIELD_VISIT');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Start Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'DRAFT|IN_PROGRESS|COMPLETED|VALIDATED|ARCHIVED');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_tool_version` SET TAGS ('dbx_business_glossary_term' = 'Assessment Tool Version');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'PRE_AWARD|PERIODIC|TRIGGERED|CLOSE_OUT');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `capacity_building_plan_required` SET TAGS ('dbx_business_glossary_term' = 'Capacity Building Plan Required Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `enhanced_monitoring_required` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Monitoring Required Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `financial_mgmt_score` SET TAGS ('dbx_business_glossary_term' = 'Financial Management Capacity Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `financial_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Financial Management Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `financial_risk_rating` SET TAGS ('dbx_value_regex' = 'LOW|MEDIUM|HIGH|CRITICAL');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `governance_score` SET TAGS ('dbx_business_glossary_term' = 'Governance Capacity Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `hr_mgmt_score` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Management Capacity Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `it_systems_score` SET TAGS ('dbx_business_glossary_term' = 'Information Technology (IT) Systems Capacity Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `key_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Key Assessment Findings Summary');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `kobo_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'KoboToolbox Submission ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `lead_assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Assessor Full Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `lead_assessor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `lead_assessor_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `lead_assessor_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `lead_assessor_organization` SET TAGS ('dbx_business_glossary_term' = 'Lead Assessor Organization');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `mel_score` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Evaluation and Learning (MEL) Capacity Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `capacity_assessment_name` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Capacity Assessment Due Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `overall_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Partner Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `overall_risk_rating` SET TAGS ('dbx_value_regex' = 'LOW|MEDIUM|HIGH|CRITICAL');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Capacity Assessment Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `partner_self_assessment_completed` SET TAGS ('dbx_business_glossary_term' = 'Partner Self-Assessment Completed Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `partner_self_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Partner Self-Assessment Overall Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `payment_modality_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Recommended Sub-Award Payment Modality');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `procurement_score` SET TAGS ('dbx_business_glossary_term' = 'Procurement Capacity Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `program_mgmt_score` SET TAGS ('dbx_business_glossary_term' = 'Program Management Capacity Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `recommended_interventions` SET TAGS ('dbx_business_glossary_term' = 'Recommended Capacity-Building Interventions');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `score_scale_max` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score Scale Maximum');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Validation Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` SET TAGS ('dbx_subdomain' = 'agreement_compliance');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `due_diligence_record_id` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Record ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `capacity_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `governance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Governance Policy Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `psea_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Psea Policy Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `statutory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Statutory Registration Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `aml_cft_check_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering and Counter-Financing of Terrorism (AML/CFT) Check Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `aml_cft_check_status` SET TAGS ('dbx_value_regex' = 'clear|flagged|pending|not_required');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `anti_terrorism_cert_date` SET TAGS ('dbx_business_glossary_term' = 'Anti-Terrorism Certification Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `anti_terrorism_certification` SET TAGS ('dbx_business_glossary_term' = 'Anti-Terrorism Certification Obtained');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `chs_cert_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Core Humanitarian Standard (CHS) Certificate Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `chs_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Core Humanitarian Standard (CHS) Certificate Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `chs_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Core Humanitarian Standard (CHS) Certification Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `chs_certification_status` SET TAGS ('dbx_value_regex' = 'certified|self_assessed|not_assessed|expired');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Completion Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `conditions_of_approval` SET TAGS ('dbx_business_glossary_term' = 'Conditions of Approval');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `debarment_check_date` SET TAGS ('dbx_business_glossary_term' = 'Debarment Check Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `debarment_check_status` SET TAGS ('dbx_business_glossary_term' = 'Debarment and Suspension Check Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `debarment_check_status` SET TAGS ('dbx_value_regex' = 'clear|debarred|suspended|pending');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `diligence_status` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `diligence_status` SET TAGS ('dbx_value_regex' = 'initiated|in_progress|pending_review|completed|failed|waived');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `diligence_type` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `diligence_type` SET TAGS ('dbx_value_regex' = 'pre_award|periodic_review|triggered_review|close_out|enhanced_due_diligence');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `financial_audit_opinion` SET TAGS ('dbx_business_glossary_term' = 'Financial Audit Opinion');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `financial_audit_opinion` SET TAGS ('dbx_value_regex' = 'unqualified|qualified|adverse|disclaimer|not_available');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `financial_audit_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Financial Audit Reviewed');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `financial_audit_year` SET TAGS ('dbx_business_glossary_term' = 'Financial Audit Year');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `governance_verified` SET TAGS ('dbx_business_glossary_term' = 'Governance Structure Verified');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `hap_membership_status` SET TAGS ('dbx_business_glossary_term' = 'Humanitarian Accountability Partnership (HAP) Membership Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `hap_membership_status` SET TAGS ('dbx_value_regex' = 'member|former_member|not_applicable|pending');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Initiation Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `iso_cert_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'ISO Certification Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `iso_certification_type` SET TAGS ('dbx_business_glossary_term' = 'ISO Certification Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `legal_registration_verified` SET TAGS ('dbx_business_glossary_term' = 'Legal Registration Verified');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `due_diligence_record_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Diligence Review Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `overall_outcome` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Overall Outcome');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `overall_outcome` SET TAGS ('dbx_value_regex' = 'approved|approved_with_conditions|rejected|deferred|inconclusive');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `record_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Record Reference Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `record_reference_number` SET TAGS ('dbx_value_regex' = '^DDR-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `reviewer_notes` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Reviewer Notes');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `reviewer_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Partner Risk Level');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Partner Risk Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `safeguarding_policy_verified` SET TAGS ('dbx_business_glossary_term' = 'Safeguarding Policy Verified');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `sphere_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Sphere Humanitarian Standards Compliance Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `sphere_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|partial|non_compliant|not_assessed');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `supporting_document_ref` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` SET TAGS ('dbx_subdomain' = 'partner_registry');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `partner_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `cluster_membership` SET TAGS ('dbx_business_glossary_term' = 'Cluster Membership');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Data Consent Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|departed|pending_verification');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Assignment');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `data_sharing_consent` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Consent Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Contact Department');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `do_not_contact` SET TAGS ('dbx_business_glossary_term' = 'Do Not Contact Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `duty_station` SET TAGS ('dbx_business_glossary_term' = 'Duty Station');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Engagement End Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Contact Gender');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_say');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `gender` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `gender` SET TAGS ('dbx_pii_type' = 'gender');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `is_authorized_signatory` SET TAGS ('dbx_business_glossary_term' = 'Is Authorized Signatory Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `is_financial_authorized` SET TAGS ('dbx_business_glossary_term' = 'Is Financially Authorized Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Contact Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Contact Job Title');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `last_interaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Interaction Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `linkedin_profile` SET TAGS ('dbx_business_glossary_term' = 'LinkedIn Profile URL');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `linkedin_profile` SET TAGS ('dbx_value_regex' = '^https?://(www.)?linkedin.com/in/[a-zA-Z0-9-_%]+/?$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `linkedin_profile` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Middle Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `partner_contact_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `partner_contact_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Contact Nationality');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `nationality` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `nationality` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `nationality` SET TAGS ('dbx_pii_type' = 'demographic');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `office_address` SET TAGS ('dbx_business_glossary_term' = 'Office Address');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `office_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `office_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `office_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `office_phone` SET TAGS ('dbx_business_glossary_term' = 'Office Phone Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `office_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `office_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `office_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `office_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `preferred_contact_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Channel');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `preferred_contact_channel` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|whatsapp|signal');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}(-[A-Z]{2})?$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `primary_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `primary_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `primary_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact Role Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `role_type` SET TAGS ('dbx_value_regex' = 'focal_point|authorized_representative|technical_lead|financial_officer|program_manager|legal_signatory');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `salutation` SET TAGS ('dbx_business_glossary_term' = 'Contact Salutation');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `salutation` SET TAGS ('dbx_value_regex' = 'Mr.|Ms.|Mrs.|Dr.|Prof.');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `skype_handle` SET TAGS ('dbx_business_glossary_term' = 'Skype Identifier');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `skype_handle` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `source_system_contact_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Contact Identifier');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Engagement Start Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Verification Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Verification Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|not_required');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` SET TAGS ('dbx_subdomain' = 'agreement_compliance');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `partner_performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Performance Review ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `capacity_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `implementation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `areas_for_improvement` SET TAGS ('dbx_business_glossary_term' = 'Areas for Improvement');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `beneficiary_feedback_incorporated` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Feedback Incorporated Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `budget_utilisation_rate` SET TAGS ('dbx_business_glossary_term' = 'Budget Utilisation Rate');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `capacity_building_areas` SET TAGS ('dbx_business_glossary_term' = 'Capacity Building Areas');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `capacity_building_recommended` SET TAGS ('dbx_business_glossary_term' = 'Capacity Building Recommended Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `field_visit_conducted` SET TAGS ('dbx_business_glossary_term' = 'Field Visit Conducted Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `financial_accountability_rating` SET TAGS ('dbx_business_glossary_term' = 'Financial Accountability Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `financial_accountability_rating` SET TAGS ('dbx_value_regex' = 'excellent|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `key_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Key Findings Summary');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `milestone_achievement_rate` SET TAGS ('dbx_business_glossary_term' = 'Milestone Achievement Rate');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `milestones_achieved_count` SET TAGS ('dbx_business_glossary_term' = 'Achieved Milestones Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `milestones_planned_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Milestones Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `partner_performance_review_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `overall_performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `overall_performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `overall_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `partner_acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Partner Acknowledgement Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `partner_acknowledgement_received` SET TAGS ('dbx_business_glossary_term' = 'Partner Acknowledgement Received Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `partnership_renewal_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Partnership Renewal Recommendation');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `partnership_renewal_recommendation` SET TAGS ('dbx_value_regex' = 'renew|renew_with_conditions|do_not_renew|under_review');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `programmatic_quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Quality Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `programmatic_quality_rating` SET TAGS ('dbx_value_regex' = 'excellent|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `reporting_compliance_rating` SET TAGS ('dbx_business_glossary_term' = 'Reporting Compliance Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `reporting_compliance_rating` SET TAGS ('dbx_value_regex' = 'excellent|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `reports_due_count` SET TAGS ('dbx_business_glossary_term' = 'Reports Due Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `reports_submitted_count` SET TAGS ('dbx_business_glossary_term' = 'Reports Submitted Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Conducted Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `review_method` SET TAGS ('dbx_business_glossary_term' = 'Review Method');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `review_method` SET TAGS ('dbx_value_regex' = 'desk_review|field_visit|joint_review|remote_assessment');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `review_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Reference Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `review_reference_number` SET TAGS ('dbx_value_regex' = '^PPR-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|completed|approved|cancelled');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'scheduled|ad_hoc|triggered|final|mid_term');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Partner Risk Level');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `safeguarding_compliance_rating` SET TAGS ('dbx_business_glossary_term' = 'Safeguarding Compliance Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `safeguarding_compliance_rating` SET TAGS ('dbx_value_regex' = 'excellent|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `strengths_noted` SET TAGS ('dbx_business_glossary_term' = 'Strengths Noted');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` SET TAGS ('dbx_subdomain' = 'partner_registry');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `consortium_id` SET TAGS ('dbx_business_glossary_term' = 'Consortium ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `due_diligence_record_id` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Record Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Partner Org Id');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Donor Constituent Id');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `constituent_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `constituent_id` SET TAGS ('dbx_pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `chs_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Core Humanitarian Standard (CHS) Compliance Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `chs_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|partial|non_compliant|under_review|not_assessed');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `consortium_type` SET TAGS ('dbx_business_glossary_term' = 'Consortium Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `consortium_type` SET TAGS ('dbx_value_regex' = 'lead_agency|member|co_implementer|pooled_fund|consortium_of_consortia');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Country Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `decision_making_protocol` SET TAGS ('dbx_business_glossary_term' = 'Consortium Decision-Making Protocol');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `decision_making_protocol` SET TAGS ('dbx_value_regex' = 'consensus|majority_vote|lead_agency_authority|weighted_vote');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Consortium End Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `funding_currency` SET TAGS ('dbx_business_glossary_term' = 'Consortium Funding Currency');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `funding_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Consortium Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `governance_structure` SET TAGS ('dbx_business_glossary_term' = 'Consortium Governance Structure Description');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `grand_bargain_localization` SET TAGS ('dbx_business_glossary_term' = 'Grand Bargain Localization Commitment Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `iasc_working_group` SET TAGS ('dbx_business_glossary_term' = 'Inter-Agency Standing Committee (IASC) Working Group');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `iati_identifier` SET TAGS ('dbx_business_glossary_term' = 'International Aid Transparency Initiative (IATI) Identifier');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `localization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Localization Percentage');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `logframe_ref` SET TAGS ('dbx_business_glossary_term' = 'Logical Framework (LogFrame) Reference');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `mel_framework_ref` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Evaluation and Learning (MEL) Framework Reference');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Consortium Member Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `consortium_name` SET TAGS ('dbx_business_glossary_term' = 'Consortium Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `consortium_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `consortium_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `ngo_funding_share` SET TAGS ('dbx_business_glossary_term' = 'Ngo Funding Share Amount');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `ngo_funding_share` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `ngo_role` SET TAGS ('dbx_business_glossary_term' = 'Ngo Role in Consortium');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `ngo_role` SET TAGS ('dbx_value_regex' = 'lead_agency|sub_partner|co_lead|observer');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Consortium Notes');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `ocha_cluster_alignment` SET TAGS ('dbx_business_glossary_term' = 'OCHA Cluster Alignment');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Consortium Operational Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'pipeline|active|suspended|closed|dissolved');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `pooled_fund_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Pooled Fund Mechanism');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `reference_code` SET TAGS ('dbx_business_glossary_term' = 'Consortium Reference Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `reference_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,30}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Consortium Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|ad_hoc');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Consortium Short Name / Acronym');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `short_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `short_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Consortium Start Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `steering_committee_composition` SET TAGS ('dbx_business_glossary_term' = 'Steering Committee Composition');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `thematic_focus` SET TAGS ('dbx_business_glossary_term' = 'Consortium Thematic Focus');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `theory_of_change_ref` SET TAGS ('dbx_business_glossary_term' = 'Theory of Change (ToC) Reference');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `total_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Consortium Funding Envelope');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `total_funding_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` SET TAGS ('dbx_subdomain' = 'partner_registry');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `consortium_member_id` SET TAGS ('dbx_business_glossary_term' = 'Consortium Member ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `consortium_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `consortium_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `capacity_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `consortium_id` SET TAGS ('dbx_business_glossary_term' = 'Consortium ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `due_diligence_record_id` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Record Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `contribution_type` SET TAGS ('dbx_business_glossary_term' = 'Contribution Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Percentage');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `cost_share_required` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Required');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `funding_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Funding Allocation Amount');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `funding_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Funding Allocation Percentage');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `funding_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Funding Currency Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `funding_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `geographic_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Geographic Responsibility');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `member_role` SET TAGS ('dbx_business_glossary_term' = 'Member Role');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `member_role` SET TAGS ('dbx_value_regex' = 'lead|co_implementer|technical_advisor|sub_recipient|associate_member|observer');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `membership_end_date` SET TAGS ('dbx_business_glossary_term' = 'Membership End Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `membership_start_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Start Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|withdrawn|terminated|inactive');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `consortium_member_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `consortium_member_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|satisfactory|needs_improvement|unsatisfactory|not_rated');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|ad_hoc');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `reporting_template_reference` SET TAGS ('dbx_business_glossary_term' = 'Reporting Template Reference');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `risk_mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Risk Mitigation Plan');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `signing_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Signing Authority Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `signing_authority_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `signing_authority_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `signing_authority_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `signing_authority_title` SET TAGS ('dbx_business_glossary_term' = 'Signing Authority Title');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `signing_date` SET TAGS ('dbx_business_glossary_term' = 'Signing Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `steering_committee_representative` SET TAGS ('dbx_business_glossary_term' = 'Steering Committee Representative');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `steering_committee_representative` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `sub_award_type` SET TAGS ('dbx_business_glossary_term' = 'Sub-Award Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `sub_award_type` SET TAGS ('dbx_value_regex' = 'sub_grant|sub_contract|mou|loa|sow');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `technical_working_group_participation` SET TAGS ('dbx_business_glossary_term' = 'Technical Working Group Participation');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `thematic_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Thematic Responsibility');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `voting_rights` SET TAGS ('dbx_business_glossary_term' = 'Voting Rights');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` SET TAGS ('dbx_subdomain' = 'agreement_compliance');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `partner_report_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Report Submission ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `donor_report_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Report Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Requirement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `beneficiaries_reached` SET TAGS ('dbx_business_glossary_term' = 'Beneficiaries Reached');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `cluster_sector` SET TAGS ('dbx_business_glossary_term' = 'Cluster or Sector');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `days_late` SET TAGS ('dbx_business_glossary_term' = 'Days Late');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Report Document URL');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `donor_reporting_obligation` SET TAGS ('dbx_business_glossary_term' = 'Donor Reporting Obligation Indicator');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Report Due Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `feedback_provided` SET TAGS ('dbx_business_glossary_term' = 'Feedback Provided');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `financial_documentation_attached` SET TAGS ('dbx_business_glossary_term' = 'Financial Documentation Attached');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `is_late_submission` SET TAGS ('dbx_business_glossary_term' = 'Late Submission Indicator');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `mel_indicators_reported` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Evaluation and Learning (MEL) Indicators Reported');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `partner_report_submission_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `narrative_summary` SET TAGS ('dbx_business_glossary_term' = 'Narrative Summary');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Report Quality Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `report_period_frequency` SET TAGS ('dbx_business_glossary_term' = 'Report Period Frequency');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `report_period_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|ad_hoc');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `report_title` SET TAGS ('dbx_business_glossary_term' = 'Report Title');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'narrative|financial|situation_report|post_distribution_monitoring|combined');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `report_version` SET TAGS ('dbx_business_glossary_term' = 'Report Version Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Start Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending_review|under_review|feedback_issued|revision_requested|accepted|rejected');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `revision_deadline` SET TAGS ('dbx_business_glossary_term' = 'Revision Deadline');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'email|online_portal|gms_upload|hard_copy|kobo_toolbox');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `submission_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Reference Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `target_beneficiaries` SET TAGS ('dbx_business_glossary_term' = 'Target Beneficiaries');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `total_expenditure_reported` SET TAGS ('dbx_business_glossary_term' = 'Total Expenditure Reported');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `total_expenditure_reported` SET TAGS ('dbx_confidential' = 'true');
