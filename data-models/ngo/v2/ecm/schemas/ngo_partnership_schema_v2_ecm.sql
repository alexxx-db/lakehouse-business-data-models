-- Schema for Domain: partnership | Business:  | Version: v2_ecm
-- Generated on: 2026-07-03 04:47:16

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`partnership` COMMENT 'Systems of record: eTools (UNICEF partner management & HACT), UN Partner Portal (UNPP), SAP vendor master. Covers partner assessments, agreements, HACT compliance, and capacity building.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`partner_org` (
    `partner_org_id` BIGINT COMMENT 'Unique system-generated surrogate key identifying a partner organization record. This is the primary key and Single Source of Truth (SSOT) identifier for all inter-organizational partner entities in the partnership domain.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Partnership management best practice assigns NGO staff as relationship owner for each partner organization. Critical for due diligence oversight, capacity assessment coordination, performance monitori',
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
    `partner_org_status` STRING COMMENT 'Current status indicator for the partner org workflow state.',
    `tax_identifier` STRING COMMENT 'Government-issued tax identification number (e.g., EIN in the US, VAT number in the EU) for the partner organization. Required for financial transactions, sub-award agreements, and compliance with NICRA (Negotiated Indirect Cost Rate Agreement) reporting.',
    `thematic_focus_areas` STRING COMMENT 'Comma-separated list of primary thematic areas in which the partner organization operates (e.g., WASH, GBV, PSS, Health, Education, Livelihoods, NFI Distribution). Used for partner matching in program design and cluster coordination with OCHA.',
    `volunteer_count` STRING COMMENT 'Total number of active volunteers engaged by the partner organization. Reflects community mobilization capacity and is used in operational capacity assessments for field program delivery.',
    CONSTRAINT pk_partner_org PRIMARY KEY(`partner_org_id`)
) COMMENT 'Implementing partner organization. Source systems: UN Partner Portal (UNPP), eTools (UNICEF), SAP vendor master. Systems-of-record: eTools (Partner Management), SAP vendor master, UN Partner Portal. Framework: HACT / IATI Organisation Standard.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` (
    `partnership_agreement_id` BIGINT COMMENT 'Unique system-generated surrogate identifier for the partnership agreement record. Primary key for the partnership_agreement data product.',
    `agreement_id` BIGINT COMMENT 'Primary key for agreement',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Partnership agreements in nonprofit operations typically implement specific grant awards. Tracking which donor award funds each partnership is essential for financial reporting, compliance monitoring,',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Partnership agreements create compliance obligations (donor reporting schedules, regulatory filings, IATI publication requirements). Each agreement generates specific obligations tracked in compliance',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Partnership agreements in nonprofits are funded through specific restricted or unrestricted funds. Financial reporting, fund accounting, and donor compliance require tracking which fund finances each ',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: Partnership agreements are established to implement specific interventions. Linking agreement to intervention enables program-level financial consolidation, results aggregation, donor reporting, and i',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: CRITICAL missing link. Every partnership agreement must reference its partner organization. Currently stores partner_organization_name as denormalized text. Adding partner_org_id FK allows JOIN to par',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Partnership agreements require designated NGO program manager for oversight, amendment approvals, performance review sign-off, and donor reporting accountability. Distinct from partner_org relationshi',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safeguarding.risk_assessment. Business justification: Partnership agreements require safeguarding risk assessments before execution per donor compliance standards (CHS, Grand Bargain). Risk assessment informs partnership approval decisions and monitoring',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Partnership agreements are managed in specific grants management systems (e.g., Salesforce, SAP Grants, custom portals). Tracking the source system is essential for data access control, audit trails, ',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the partnership agreement. draft = under preparation; pending_signature = awaiting execution; active = fully executed and in force; suspended = temporarily halted; expired = past end date without renewal; terminated = ended before expiry; amended = superseded by an amendment. [ENUM-REF-CANDIDATE: draft|pending_signature|active|suspended|expired|terminated|amended — promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the formal inter-organizational legal instrument. MoU = Memorandum of Understanding; LoA = Letter of Agreement; SoW = Scope of Work; sub_award = sub-grant or sub-award agreement; consortium = multi-party consortium agreement; other = any other instrument type. [ENUM-REF-CANDIDATE: MoU|LoA|SoW|sub_award|consortium|framework|other — promote to reference product if additional types are needed]. Valid values are `MoU|LoA|SoW|sub_award|consortium|other`',
    `amendment_date` DATE COMMENT 'Date on which the most recent amendment to the agreement was executed. Null for original agreements with no amendments.',
    `amendment_description` STRING COMMENT 'Narrative summary of the changes introduced by the most recent amendment (e.g., budget increase, no-cost extension, scope modification). Null for original agreements.',
    `amendment_number` STRING COMMENT 'Sequential integer indicating the amendment version of the agreement. Zero (0) indicates the original agreement; increments by 1 for each subsequent amendment. Supports amendment history tracking.',
    `capacity_assessment_date` DATE COMMENT 'Date on which the most recent partner capacity assessment or due diligence review was completed.',
    `capacity_assessment_status` STRING COMMENT 'Status of the partner due diligence and capacity assessment conducted prior to or during the agreement. not_required = exempt; pending = assessment initiated but not complete; completed = assessment passed; failed = partner did not meet threshold; waived = formally waived by authorized approver.. Valid values are `not_required|pending|completed|failed|waived`',
    `cluster_lead_agency` STRING COMMENT 'Name of the OCHA cluster lead agency (e.g., UNICEF for WASH, WFP for Food Security) under whose coordination framework the agreements activities are implemented. Relevant for humanitarian response agreements.',
    `partnership_agreement_code` STRING COMMENT 'Standardized code representing the partnership agreement classification or category.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the partnership agreement record was first created in the system. Supports audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the funding ceiling and financial obligations under the agreement (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `partnership_agreement_description` STRING COMMENT 'Detailed textual description providing context about the partnership agreement.',
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
    `partnership_agreement_name` STRING COMMENT 'Human-readable name or label for the partnership agreement.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the partnership agreement entity.',
    `operational_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the primary country where the agreements activities are implemented (e.g., SSD, YEM, HTI).. Valid values are `^[A-Z]{3}$`',
    `outstanding_dct_amount` DECIMAL(18,2) COMMENT 'Outstanding Direct Cash Transfer balance (disbursed minus liquidated). Present in MVM stub, carried forward for ECM completeness.',
    `parent_agreement_reference` STRING COMMENT 'Agreement reference number of the parent or prime agreement under which this sub-award or amendment was issued. Enables hierarchical agreement traceability. Null for top-level agreements.',
    `program_sector` STRING COMMENT 'Humanitarian or development sector under which the agreements activities fall. WASH = Water Sanitation and Hygiene; GBV = Gender-Based Violence; PSS = Psychosocial Support. [ENUM-REF-CANDIDATE: WASH|health|education|food_security|protection|shelter|livelihoods|GBV|PSS|nutrition|other — promote to reference product]',
    `reference_number` STRING COMMENT 'Externally-known alphanumeric reference number assigned to the agreement, used in correspondence, filing, and cross-system lookups (e.g., MOU-2024-0042, LOA-2023-WASH-007). Serves as the BUSINESS_IDENTIFIER for this agreement.',
    `renewal_option` BOOLEAN COMMENT 'Indicates whether the agreement contains a renewal or extension option clause (True) that allows the parties to extend the agreement beyond the effective end date without a full renegotiation.',
    `reporting_frequency` STRING COMMENT 'Agreed frequency at which the partner must submit programmatic and/or financial reports under the agreement (e.g., monthly SitRep, quarterly narrative, annual audit).. Valid values are `monthly|quarterly|semi_annual|annual|ad_hoc`',
    `scope_description` STRING COMMENT 'Narrative description of the agreed scope of work, activities, and deliverables covered by the agreement. Summarizes the SoW or program objectives as stated in the legal instrument.',
    `sdg_alignment_codes` STRING COMMENT 'Comma-separated list of UN Sustainable Development Goal (SDG) goal numbers to which the agreements activities contribute (e.g., 3,6,16). Used for donor reporting and IATI disclosure.',
    `signatory_name_lead` STRING COMMENT 'Full name of the authorized signatory representing the lead organization on the agreement. Captured for legal validity and audit purposes.',
    `signatory_name_partner` STRING COMMENT 'Full name of the authorized signatory representing the partner organization on the agreement. Captured for legal validity and audit purposes.',
    `start_date` DATE COMMENT 'Date and time when the start event occurred for this partnership agreement.',
    `partnership_agreement_status` STRING COMMENT 'Current status indicator for the partnership agreement workflow state.',
    `termination_date` DATE COMMENT 'Actual date on which the agreement was terminated, if terminated before the effective end date. Null for active or expired agreements.',
    `termination_notice_days` STRING COMMENT 'Number of calendar days written notice required by either party to terminate the agreement without cause, as specified in the termination clause.',
    `termination_reason` STRING COMMENT 'Reason for early termination of the agreement. Null for agreements that expire naturally or remain active.. Valid values are `mutual_consent|breach|force_majeure|funding_exhausted|program_closure|other`',
    `theory_of_change_reference` STRING COMMENT 'Reference identifier or title of the Theory of Change (ToC) or LogFrame (Logical Framework) document that underpins the program activities governed by this agreement. Links the agreement to the MEL framework.',
    `title` STRING COMMENT 'Full descriptive title of the partnership agreement as it appears on the signed legal instrument (e.g., Memorandum of Understanding for WASH Program Delivery in Borno State).',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'Total agreed budget ceiling for the partnership agreement. Present in MVM stub, carried forward for ECM completeness.',
    `transfer_modality` STRING COMMENT 'Cash transfer modality to implementing partner: Direct Cash Transfer / Reimbursement / Direct Payment per HACT framework. Present in MVM stub, carried forward for ECM completeness.',
    CONSTRAINT pk_partnership_agreement PRIMARY KEY(`partnership_agreement_id`)
) COMMENT 'ECM-canonical partnership agreement entity. Supersedes the MVM-tier stub agreement and is a strict superset of its attributes. Source systems: eTools (UNICEF), SAP, UN Partner Portal, UNPP, InSight. Captures the full lifecycle of implementing partner agreements including PCA, SSFA, and programme documents with HACT compliance tracking.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` (
    `capacity_assessment_id` BIGINT COMMENT 'Unique system-generated identifier for each partner capacity assessment record. Primary key for the capacity_assessment data product.',
    `award_id` BIGINT COMMENT 'Reference to the grant or funding agreement that triggered or is associated with this capacity assessment. Links due diligence records to specific funding instruments.',
    `chs_self_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.chs_self_assessment. Business justification: Capacity assessments routinely include CHS (Core Humanitarian Standard) self-assessment as a component for partner quality assurance. Direct operational link in partner vetting processes. CHS complian',
    `partner_org_id` BIGINT COMMENT 'Reference to the partner organization (CSO, CBO, INGO, government body, UN agency, or consortium) being assessed. Links to the partner master record.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or consultant who led the capacity assessment process. Used for accountability, quality assurance, and audit trail purposes.',
    `prior_assessment_capacity_assessment_id` BIGINT COMMENT 'Reference to the immediately preceding capacity assessment record for the same partner, enabling longitudinal tracking of capacity development progress over time.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Capacity assessments conducted via digital data collection platforms (KoBoToolbox, ODK, CommCare). Linking to system_platform enables data lineage tracking, API integration for automated scoring, comp',
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
    `capacity_assessment_status` STRING COMMENT 'Current status indicator for the capacity assessment workflow state.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when the capacity assessment record was most recently modified. Used for change tracking, data synchronization, and audit trail purposes.',
    `validation_date` DATE COMMENT 'Date on which the capacity assessment was formally reviewed and validated by the authorized staff member, marking the record as officially approved for use in partnership and sub-award decisions.',
    CONSTRAINT pk_capacity_assessment PRIMARY KEY(`capacity_assessment_id`)
) COMMENT 'Partner capacity assessment including HACT micro-assessment. Source systems: eTools, eZHACT, UN Partner Portal.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` (
    `due_diligence_record_id` BIGINT COMMENT 'Unique system-generated identifier for the due diligence and partner verification record. Primary key for this entity. Entity role: MASTER_AGREEMENT — this record represents a formal compliance verification container with its own lifecycle, effective dates, and binding outcome.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Due diligence assessments are often triggered by specific award risk thresholds, donor requirements, and subaward value ceilings. Award context determines diligence scope, required certifications, and',
    `capacity_assessment_id` BIGINT COMMENT 'Foreign key linking to partnership.capacity_assessment. Business justification: due_diligence_record stores capacity_assessment_score and capacity_assessment_date as denormalized attributes but has no FK to the actual capacity_assessment record. Due diligence incorporates capacit',
    `partner_org_id` BIGINT COMMENT 'Reference to the partner organization (CSO, CBO, INGO, government body, UN agency, or consortium) that is the subject of this due diligence record.',
    `sanctions_screening_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening. Business justification: Due diligence records must reference specific sanctions screening results for anti-terrorism compliance and donor requirements. Mandatory step in partner vetting. Links DD workflow to compliance evide',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member (typically a Partnership Officer or Compliance Officer) responsible for conducting and owning this due diligence record.',
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
    `ngo_registration_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction in which the partner is legally registered as an NGO or nonprofit entity.. Valid values are `^[A-Z]{3}$`',
    `ngo_registration_expiry_date` DATE COMMENT 'Date on which the partners national NGO registration expires and must be renewed. Null if registration is perpetual. Triggers compliance alerts when approaching expiry.',
    `ngo_registration_number` STRING COMMENT 'Official registration number issued by the national NGO regulatory authority or charity commission in the partners country of primary operation. Key identifier for legal compliance verification.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the due diligence record entity.',
    `overall_outcome` STRING COMMENT 'Final determination of the due diligence exercise indicating whether the partner is cleared for sub-award or partnership engagement. Approved with conditions requires a documented corrective action plan.. Valid values are `approved|approved_with_conditions|rejected|deferred|inconclusive`',
    `record_reference_number` STRING COMMENT 'Externally-known unique alphanumeric reference code assigned to this due diligence record, used in correspondence, audit trails, and donor reporting. Format: DDR-YYYY-NNNNNN.. Valid values are `^DDR-[0-9]{4}-[0-9]{6}$`',
    `reviewer_notes` STRING COMMENT 'Confidential narrative notes recorded by the responsible staff member summarizing key findings, concerns, and recommendations from the due diligence review. Restricted to compliance and partnership leadership.',
    `risk_level` STRING COMMENT 'Composite risk rating assigned to the partner following due diligence, reflecting financial, governance, compliance, and operational risk factors. Determines monitoring intensity and sub-award conditions.. Valid values are `low|medium|high|critical`',
    `risk_score` STRING COMMENT 'Numeric composite risk score (typically 0–100) calculated from weighted assessment criteria across financial, governance, legal, and operational dimensions. Supports quantitative risk ranking across the partner portfolio.',
    `safeguarding_policy_verified` BOOLEAN COMMENT 'Indicates whether the partner has a documented and operational safeguarding policy covering protection from sexual exploitation, abuse, and harassment (PSEAH), child protection, and GBV prevention, as required by IASC and donor standards.',
    `sphere_compliance_status` STRING COMMENT 'Assessment of the partners operational compliance with the Sphere Humanitarian Charter and Minimum Standards in Humanitarian Response, covering WASH, food security, shelter, and health sectors.. Valid values are `compliant|partial|non_compliant|not_assessed`',
    `start_date` DATE COMMENT 'Date and time when the start event occurred for this due diligence record.',
    `due_diligence_record_status` STRING COMMENT 'Current status indicator for the due diligence record workflow state.',
    `supporting_document_ref` STRING COMMENT 'Reference identifier or URL pointing to the document management system location where supporting due diligence evidence (audit reports, registration certificates, signed certifications) is stored.',
    CONSTRAINT pk_due_diligence_record PRIMARY KEY(`due_diligence_record_id`)
) COMMENT 'Formal due diligence and partner verification master record covering legal compliance checks, sanctions screening (OFAC, EU, UN), anti-terrorism certification, financial audit review, governance verification, and regulatory standing. Includes embedded accreditation/certification tracking for CHS (Core Humanitarian Standard), Sphere compliance, HAP membership, ISO certifications, and national NGO registration status with issuing body, certificate number, issue date, expiry date, and verification status. Tracks due diligence type, completion date, outcome, risk level, next review date, and responsible staff. Required for compliance with 2 CFR 200, USAID ADS 303, and donor partner vetting regulations. This is the SSOT for all partner verification, screening, and accreditation data in the partnership domain.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` (
    `partner_contact_id` BIGINT COMMENT 'Unique system-generated identifier for the partner contact record. Primary key for the partner_contact data product within the partnership domain.',
    `partner_org_id` BIGINT COMMENT 'Reference to the partner organization to which this contact belongs. Links the individual contact to their parent Civil Society Organization (CSO), Community-Based Organization (CBO), International Non-Governmental Organization (INGO), UN agency, government body, or consortium entity.',
    `user_account_id` BIGINT COMMENT 'Foreign key linking to technology.user_account. Business justification: Partner contacts who have system access require linkage for core IAM processes: access provisioning when partnership starts, periodic access reviews, deprovisioning when contact leaves, security audit',
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
    `preferred_contact_channel` STRING COMMENT 'The partner contacts preferred communication channel for receiving outreach and coordination messages. Supports effective stakeholder engagement and respects communication preferences in diverse field contexts.. Valid values are `email|phone|mobile|whatsapp|signal`',
    `preferred_language` STRING COMMENT 'ISO 639-1 or ISO 639-3 language code representing the partner contacts preferred language for communications and documentation (e.g., en for English, fr for French, ar for Arabic, es for Spanish). Supports multilingual coordination in international humanitarian operations.. Valid values are `^[a-z]{2,3}(-[A-Z]{2})?$`',
    `primary_email` STRING COMMENT 'Primary professional email address for the partner contact. Used as the main digital communication channel for coordination, reporting, and official correspondence including Memoranda of Understanding (MoU) and Scope of Work (SoW) exchanges.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone` STRING COMMENT 'Primary telephone number for the partner contact in E.164 international format. Used for urgent coordination, field communications, and stakeholder engagement across the partnership lifecycle.. Valid values are `^+?[1-9]d{1,14}$`',
    `role_type` STRING COMMENT 'Functional role classification of the contact within the partnership relationship. Determines the contacts authority and responsibilities in coordination workflows. [ENUM-REF-CANDIDATE: focal_point|authorized_representative|technical_lead|financial_officer|program_manager|legal_signatory|cluster_coordinator|field_officer — promote to reference product]. Valid values are `focal_point|authorized_representative|technical_lead|financial_officer|program_manager|legal_signatory`',
    `salutation` STRING COMMENT 'Honorific or title prefix used when addressing the partner contact in formal communications (e.g., Mr., Ms., Dr., Prof.).. Valid values are `Mr.|Ms.|Mrs.|Dr.|Prof.`',
    `secondary_email` STRING COMMENT 'Alternate or backup email address for the partner contact. Used when the primary email is unreachable or for personal/secondary organizational accounts.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `secondary_language` STRING COMMENT 'ISO 639-1 or ISO 639-3 language code for the partner contacts secondary working language. Supports assignment of contacts to multilingual coordination meetings, cluster working groups, and OCHA-led inter-agency processes.. Valid values are `^[a-z]{2,3}(-[A-Z]{2})?$`',
    `skype_handle` STRING COMMENT 'Skype username or identifier for the partner contact. Used for virtual coordination meetings, remote field communications, and inter-agency conference calls in areas with limited connectivity.',
    `source_system_contact_reference` STRING COMMENT 'The unique identifier assigned to this contact record in the originating operational system of record (e.g., Salesforce Contact ID, Dynamics 365 Contact GUID). Enables cross-system reconciliation and data lineage tracing in the lakehouse Silver layer.',
    `start_date` DATE COMMENT 'Date on which the partner contact was first formally engaged or registered in the partnership management system. Marks the beginning of the contacts active role in the partnership lifecycle.',
    `partner_contact_status` STRING COMMENT 'Current status indicator for the partner contact workflow state.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the partner contact record. Used for change tracking, data freshness monitoring, and incremental data pipeline processing in the Databricks Lakehouse Silver layer.',
    `verification_date` DATE COMMENT 'Date on which the partner contacts identity and credentials were last verified as part of the partner due diligence process. Used to schedule re-verification cycles and maintain compliance audit trails.',
    `verification_status` STRING COMMENT 'Status of the identity and credential verification process for the partner contact. Supports due diligence requirements for sub-award management and partner capacity assessments per USAID, DFID, and OMB Uniform Guidance 2 CFR 200 requirements.. Valid values are `verified|pending|failed|not_required`',
    CONSTRAINT pk_partner_contact PRIMARY KEY(`partner_contact_id`)
) COMMENT 'Master record for individual contacts within partner organizations including focal points, authorized representatives, technical leads, and financial officers. Captures name, title, role type, communication channels, language preference, and active status. Supports relationship management and coordination workflows across the partnership lifecycle.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` (
    `agreement_amendment_id` BIGINT COMMENT 'Unique system-generated identifier for each formal modification record to a partnership agreement. Serves as the primary key for the agreement_amendment entity.',
    `partnership_agreement_id` BIGINT COMMENT 'Reference to the parent partnership agreement (MoU, LoA, SoW, or sub-award) that this amendment modifies. Links the amendment to its originating agreement record.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member record of the individual who formally approved this amendment. Links to the workforce domain for accountability and audit trail purposes.',
    `amendment_number` STRING COMMENT 'Externally-known sequential identifier for this amendment within the context of the parent agreement (e.g., AMD-2024-001). Used in official correspondence, donor reporting, and compliance filings. Supports full amendment history tracking per agreement.. Valid values are `^AMD-[0-9]{4}-[0-9]{3}$`',
    `amendment_status` STRING COMMENT 'Current lifecycle state of the amendment record. Draft indicates preparation in progress; pending_approval indicates submission to approval authority; approved indicates fully executed; rejected indicates declined by approver; superseded indicates replaced by a subsequent amendment; withdrawn indicates retracted before approval.. Valid values are `draft|pending_approval|approved|rejected|superseded|withdrawn`',
    `amendment_title` STRING COMMENT 'Short descriptive title summarizing the purpose of the amendment (e.g., No-Cost Extension to December 2025, Budget Realignment Q3 2024). Used in correspondence, dashboards, and partner communications.',
    `amendment_type` STRING COMMENT 'Classification of the formal modification being made to the agreement. Scope change alters deliverables or geographic coverage; budget realignment redistributes funds across cost categories; no-cost extension extends the period without additional funding; period of performance adjusts start/end dates; signatory change updates authorized representatives. [ENUM-REF-CANDIDATE: scope_change|budget_realignment|no_cost_extension|period_of_performance|signatory_change|other — promote to reference product]. Valid values are `scope_change|budget_realignment|no_cost_extension|period_of_performance|signatory_change|other`',
    `approval_authority` STRING COMMENT 'Name or title of the individual, committee, or organizational body with delegated authority to approve this amendment (e.g., Country Director, Grants Manager, Donor Agreement Officer). Supports RACI accountability tracking.',
    `approved_date` DATE COMMENT 'The date on which the amendment was formally approved by the designated approval authority. Null if not yet approved or if rejected/withdrawn.',
    `beneficiary_target_change` BOOLEAN COMMENT 'Indicates whether this amendment modifies the target beneficiary numbers, population groups, or vulnerability criteria for the program. True = beneficiary targets modified; False = no change. Relevant for MEL/MEAL reporting and SDG indicator tracking.',
    `budget_change_amount` DECIMAL(18,2) COMMENT 'The net monetary change to the agreement budget introduced by this amendment (revised_budget_amount minus original_budget_amount). Positive values indicate budget increases; negative values indicate reductions. Null for non-financial amendments.',
    `clauses_modified` STRING COMMENT 'Enumeration or description of the specific agreement clauses, articles, or sections that are modified by this amendment (e.g., Article 3 — Scope of Work, Article 7 — Budget). Supports legal review and compliance tracking.',
    `agreement_amendment_code` STRING COMMENT 'Standardized code representing the agreement amendment classification or category.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this amendment record was first created in the data platform. Supports audit trail, data lineage, and compliance with record-keeping requirements under 2 CFR 200 and FASB ASC 958.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to all monetary amounts in this amendment record (e.g., USD, EUR, GBP). Ensures consistent financial reporting across multi-currency partnership portfolios.. Valid values are `^[A-Z]{3}$`',
    `agreement_amendment_description` STRING COMMENT 'Detailed textual description providing context about the agreement amendment.',
    `document_reference` STRING COMMENT 'File path, document management system reference, or URL pointing to the executed amendment document (signed PDF or equivalent). Supports audit trail and compliance evidence requirements.',
    `donor_approval_reference` STRING COMMENT 'Reference number, letter identifier, or correspondence tracking code for the donors written prior approval of this amendment. Required for audit evidence when donor_prior_approval_required is True.',
    `donor_prior_approval_required` BOOLEAN COMMENT 'Indicates whether this amendment requires prior written approval from the donor or prime recipient before implementation, as mandated under 2 CFR 200.308 or specific award terms. True = prior approval required; False = notification only or no approval needed.',
    `effective_date` DATE COMMENT 'The date on which the amendment becomes legally binding and operationally effective. This is the real-world event date, distinct from the signature date or record creation timestamp. Critical for period-of-performance tracking and financial reporting.',
    `end_date` DATE COMMENT 'Date and time when the end event occurred for this agreement amendment.',
    `execution_date` DATE COMMENT 'The date on which all required signatories formally signed and executed the amendment document. May differ from the effective date when retroactive amendments are issued.',
    `extension_duration_days` STRING COMMENT 'Number of calendar days by which the period of performance is extended by this amendment. Null for non-extension amendments. Used for program planning, resource allocation, and donor reporting on timeline changes.',
    `geographic_scope_change` BOOLEAN COMMENT 'Indicates whether this amendment modifies the geographic coverage or operational areas of the agreement (e.g., adding or removing districts, countries, or OCHA cluster areas). True = geographic scope modified; False = no geographic change.',
    `gms_reference` STRING COMMENT 'External reference identifier for this amendment as recorded in the Grant Management System (GMS) or donors award management platform (e.g., USAID ASIST, DFID ARIES). Enables cross-system reconciliation and donor audit support.',
    `iati_activity_identifier` STRING COMMENT 'IATI-standard activity identifier associated with the parent agreement, used to publish amendment data to the IATI Registry for transparency and open data compliance. Format follows IATI hierarchical identifier standard.',
    `is_no_cost_extension` BOOLEAN COMMENT 'Indicates whether this amendment constitutes a no-cost extension (NCE), extending the period of performance without additional funding. True = NCE; False = other amendment type. Critical for grant closeout planning and donor reporting.',
    `justification` STRING COMMENT 'Narrative explanation of the business rationale for the amendment, including the circumstances that necessitated the change (e.g., context changes, operational constraints, donor-directed modifications). Required for donor reporting and audit compliance under 2 CFR 200.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this agreement amendment.',
    `agreement_amendment_name` STRING COMMENT 'Human-readable name or label for the agreement amendment.',
    `ngo_signatory_name` STRING COMMENT 'Full name of the authorized representative of Ngo who signs this amendment on behalf of the organization. Required for legal enforceability and signatory change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional context, internal commentary, or operational notes related to this amendment that do not fit structured fields. Used by grants management and partnership teams for internal coordination.',
    `original_budget_amount` DECIMAL(18,2) COMMENT 'The total authorized budget of the agreement prior to this amendment, expressed in the agreement currency. Retained for Budget versus Actual (BvA) analysis and audit trail of financial modifications.',
    `original_end_date` DATE COMMENT 'The end date of the period of performance as defined in the agreement prior to this amendment. Used to calculate extension duration and track no-cost extension history.',
    `original_start_date` DATE COMMENT 'The start date of the period of performance as defined in the agreement prior to this amendment. Retained for audit trail and comparison purposes when a period-of-performance amendment is processed.',
    `partner_signatory_name` STRING COMMENT 'Full name of the authorized representative of the partner organization who signs this amendment on behalf of the CSO, CBO, INGO, government body, or UN agency. Required for signatory change amendments and legal enforceability.',
    `revised_beneficiary_target` STRING COMMENT 'Updated total number of direct beneficiaries targeted under the agreement following this amendment. Null if beneficiary_target_change is False. Used for MEL/MEAL indicator tracking and donor results reporting.',
    `revised_budget_amount` DECIMAL(18,2) COMMENT 'The total authorized budget of the agreement as updated by this amendment. Null if this amendment does not modify the budget. Used for BvA reporting and donor financial compliance.',
    `revised_end_date` DATE COMMENT 'The updated end date of the period of performance as established by this amendment. Null if this amendment does not modify the end date. Key field for no-cost extension tracking.',
    `revised_start_date` DATE COMMENT 'The updated start date of the period of performance as established by this amendment. Null if this amendment does not modify the start date.',
    `scope_change_description` STRING COMMENT 'Detailed narrative describing changes to the Scope of Work (SoW), program activities, geographic coverage, target beneficiary populations, or deliverables introduced by this amendment. Null if amendment type is not scope_change.',
    `start_date` DATE COMMENT 'Date and time when the start event occurred for this agreement amendment.',
    `agreement_amendment_status` STRING COMMENT 'Current status indicator for the agreement amendment workflow state.',
    `submitted_date` DATE COMMENT 'The date on which the amendment request was formally submitted to the approval authority or donor/prime for review. Used to track processing timelines and compliance with advance notification requirements under 2 CFR 200.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this amendment record was last modified. Used for change tracking, data synchronization, and audit trail maintenance in the Databricks Silver Layer.',
    CONSTRAINT pk_agreement_amendment PRIMARY KEY(`agreement_amendment_id`)
) COMMENT 'Transactional record capturing formal modifications to existing partnership agreements including scope changes, budget realignments, no-cost extensions, period of performance adjustments, and signatory changes. Tracks amendment number, amendment type, effective date, justification, approval authority, and the specific clauses modified. Maintains the full amendment history of each agreement.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` (
    `partner_performance_review_id` BIGINT COMMENT 'Unique system-generated identifier for each partner performance review record. Primary key for the partner_performance_review data product.',
    `implementation_plan_id` BIGINT COMMENT 'Reference to the program or project that the implementing partner is delivering under review.',
    `internal_review_id` BIGINT COMMENT 'Foreign key linking to compliance.internal_review. Business justification: Partner performance reviews may trigger or reference internal compliance reviews when issues are identified. Links performance monitoring to compliance oversight. Essential for integrated risk managem',
    `partner_org_id` BIGINT COMMENT 'Reference to the implementing partner organisation being reviewed. Links to the partner master record in the partnership domain.',
    `partnership_agreement_id` BIGINT COMMENT 'Reference to the governing agreement (MoU, LoA, SoW, or sub-award) under which this performance review is conducted.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or team lead who conducted and is accountable for this performance review.',
    `approval_date` DATE COMMENT 'Date on which the performance review was formally approved by the authorised reviewer or partnership manager.',
    `areas_for_improvement` STRING COMMENT 'Narrative description of performance gaps, weaknesses, or risks identified during the review that require corrective action or capacity strengthening.',
    `beneficiary_feedback_incorporated` BOOLEAN COMMENT 'Indicates whether beneficiary feedback (e.g., from Post-Distribution Monitoring (PDM), Focus Group Discussions (FGD), or KoboToolbox surveys) was incorporated into the review findings.',
    `budget_utilisation_rate` DECIMAL(18,2) COMMENT 'Percentage of the sub-award budget expended by the partner during the review period (0.00–100.00). Key Budget versus Actual (BvA) indicator for financial stewardship assessment.',
    `capacity_building_areas` STRING COMMENT 'Narrative description of specific capacity building areas recommended for the partner (e.g., financial management, MEL systems, safeguarding, ICT4D). Populated when capacity_building_recommended is True.',
    `capacity_building_recommended` BOOLEAN COMMENT 'Indicates whether the reviewer recommends a formal capacity building or organisational development intervention for the partner based on identified gaps.',
    `partner_performance_review_code` STRING COMMENT 'Standardized code representing the partner performance review classification or category.',
    `corrective_action_description` STRING COMMENT 'Detailed description of required corrective actions, including specific steps the partner must take to address identified deficiencies. Populated when corrective_action_required is True.',
    `corrective_action_due_date` DATE COMMENT 'Deadline by which the partner must demonstrate completion of required corrective actions. Null when corrective_action_required is False.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether a formal Corrective Action Plan (CAP) is required as an outcome of this review. True triggers a CAP workflow in the partnership management system.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action plan associated with this review. Tracks partner remediation progress for risk management and compliance reporting.. Valid values are `not_required|pending|in_progress|completed|overdue`',
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
    `partnership_renewal_recommendation` STRING COMMENT 'Reviewers recommendation on whether to renew, conditionally renew, or terminate the partnership agreement based on this reviews findings. Feeds into partnership pipeline decisions.. Valid values are `renew|renew_with_conditions|do_not_renew|under_review`',
    `programmatic_quality_rating` STRING COMMENT 'Rating of the partners delivery quality against agreed SoW milestones, Theory of Change (ToC) outputs, and LogFrame indicators. Distinct from financial accountability.. Valid values are `excellent|satisfactory|needs_improvement|unsatisfactory`',
    `reporting_compliance_rating` STRING COMMENT 'Rating of the partners adherence to agreed reporting schedules, SitRep submissions, and donor reporting requirements including IATI data publication obligations.. Valid values are `excellent|satisfactory|needs_improvement|unsatisfactory`',
    `reports_due_count` STRING COMMENT 'Total number of reports required from the partner during the review period per the agreement schedule.',
    `reports_submitted_count` STRING COMMENT 'Number of required narrative and financial reports submitted by the partner during the review period.',
    `review_date` DATE COMMENT 'The actual calendar date on which the performance review meeting or assessment was conducted with the partner.',
    `review_method` STRING COMMENT 'Methodology used to conduct the performance review. Field visits provide direct observation; desk reviews rely on submitted documentation; joint reviews involve donor or cluster lead participation.. Valid values are `desk_review|field_visit|joint_review|remote_assessment`',
    `review_period_end_date` DATE COMMENT 'Last day of the performance period being assessed in this review. Together with review_period_start_date defines the assessment window.',
    `review_period_start_date` DATE COMMENT 'First day of the performance period being assessed in this review. Aligns with the reporting cycle defined in the partner SoW.',
    `review_reference_number` STRING COMMENT 'Externally-known alphanumeric reference code assigned to this review for tracking in correspondence, donor reports, and audit trails. Format: PPR-YYYY-NNNNNN.. Valid values are `^PPR-[0-9]{4}-[0-9]{6}$`',
    `review_status` STRING COMMENT 'Current lifecycle state of the performance review record. Drives workflow routing for approval and archiving.. Valid values are `draft|in_progress|completed|approved|cancelled`',
    `review_type` STRING COMMENT 'Classification of the review occasion. Scheduled reviews occur at fixed intervals per the SoW; triggered reviews are initiated by risk events or compliance concerns; final reviews occur at agreement close-out.. Valid values are `scheduled|ad_hoc|triggered|final|mid_term`',
    `risk_level` STRING COMMENT 'Risk classification assigned to the partner as an outcome of this review. Informs sub-award monitoring intensity, financial controls, and escalation protocols.. Valid values are `low|medium|high|critical`',
    `safeguarding_compliance_rating` STRING COMMENT 'Rating of the partners compliance with safeguarding policies including GBV prevention, child protection, and HAP/CHS accountability commitments.. Valid values are `excellent|satisfactory|needs_improvement|unsatisfactory`',
    `start_date` DATE COMMENT 'Date and time when the start event occurred for this partner performance review.',
    `partner_performance_review_status` STRING COMMENT 'Current status indicator for the partner performance review workflow state.',
    `strengths_noted` STRING COMMENT 'Narrative description of the partners notable strengths and positive performance areas identified during the review. Used for learning and best-practice documentation.',
    CONSTRAINT pk_partner_performance_review PRIMARY KEY(`partner_performance_review_id`)
) COMMENT 'Periodic performance review records for implementing partners assessing delivery against agreed SoW milestones, reporting compliance, financial accountability, and programmatic quality. Captures review period, performance rating, key findings, corrective action requirements, and reviewer details. Feeds into partnership renewal and risk management decisions.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`consortium` (
    `consortium_id` BIGINT COMMENT 'Unique system-generated identifier for the consortium record. Primary key for the consortium master data product within the partnership domain.',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: Consortia are formed to deliver specific interventions through multi-partner collaboration. Linking consortium to intervention enables consolidated program reporting, multi-partner results tracking, a',
    `partner_org_id` BIGINT COMMENT 'FK to partnership.partner_org',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Consortium management requires designated NGO staff focal point for coordination, steering committee participation, and member communication. Standard practice in multi-agency humanitarian response co',
    `partnership_agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Consortium currently stores agreement_reference as STRING but has no FK to the actual partnership_agreement record. Consortia are formalized through partnership agreements (MoUs). Adding partnership_a',
    `constituent_id` BIGINT COMMENT 'FK to donor.constituent',
    `single_audit_id` BIGINT COMMENT 'Foreign key linking to compliance.single_audit. Business justification: Consortia receiving US federal funds above threshold require single audits per OMB Uniform Guidance. Links consortium structure to regulatory audit requirement. Essential for federal grant compliance ',
    `chs_compliance_status` STRING COMMENT 'Status of the consortiums adherence to the Core Humanitarian Standard (CHS) on Quality and Accountability, assessed through partner due diligence and capacity assessments.. Valid values are `compliant|partial|non_compliant|under_review|not_assessed`',
    `consortium_code` STRING COMMENT 'Standardized code representing the consortium classification or category.',
    `consortium_name` STRING COMMENT 'Official full name of the multi-partner consortium or joint programming arrangement as registered with the lead donor or coordinating body (e.g., OCHA cluster).',
    `consortium_type` STRING COMMENT 'Classification of the consortium arrangement indicating Ngos role and the structural form. Lead_agency means Ngo is the prime recipient; member means Ngo is a sub-partner; pooled_fund indicates a CERF or similar mechanism. [ENUM-REF-CANDIDATE: lead_agency|member|co_implementer|pooled_fund|consortium_of_consortia — promote to reference product]. Valid values are `lead_agency|member|co_implementer|pooled_fund|consortium_of_consortia`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the primary country of consortium operations. For multi-country consortia, this represents the lead country of registration or primary operational context.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consortium record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `decision_making_protocol` STRING COMMENT 'Formal protocol governing how decisions are made within the consortium. Consensus requires unanimous agreement; majority_vote uses simple majority; lead_agency_authority delegates decisions to the prime recipient; weighted_vote allocates votes by funding share.. Valid values are `consensus|majority_vote|lead_agency_authority|weighted_vote`',
    `consortium_description` STRING COMMENT 'Detailed textual description providing context about the consortium.',
    `due_diligence_date` DATE COMMENT 'Date on which the most recent due diligence assessment for the consortium was completed. Used to track expiry and schedule renewal per donor compliance requirements.',
    `due_diligence_status` STRING COMMENT 'Current status of the due diligence process for the consortium arrangement, covering financial management capacity, safeguarding policies, and anti-terrorism compliance checks.. Valid values are `pending|in_progress|completed|expired`',
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
    `consortium_status` STRING COMMENT 'Current status indicator for the consortium workflow state.',
    `steering_committee_composition` STRING COMMENT 'Description of the steering committee membership including designated representatives from each partner organization, their roles (chair, co-chair, member), and meeting frequency.',
    `thematic_focus` STRING COMMENT 'Primary humanitarian or development sector(s) addressed by the consortium (e.g., WASH, GBV, food security, health, education, PSS). Aligns with OCHA cluster system and IASC sector classifications.',
    `theory_of_change_ref` STRING COMMENT 'Reference identifier or document title of the consortiums Theory of Change (ToC) that articulates the causal pathway from inputs and activities to intended outcomes and impact. Used in MEL and MEAL frameworks.',
    `total_funding_amount` DECIMAL(18,2) COMMENT 'Total funding envelope committed to the consortium across all member organizations and donor sources, expressed in the reporting currency. Used for Grand Bargain localization tracking and joint donor reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the consortium record was most recently modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports change tracking and data governance.',
    CONSTRAINT pk_consortium PRIMARY KEY(`consortium_id`)
) COMMENT 'Master record for multi-partner consortia and joint programming arrangements where Ngo acts as lead agency or member. Captures consortium name, lead organization, governance structure (steering committee composition, decision-making protocols), consortium agreement reference, geographic scope, thematic focus, total funding envelope, and operational status. Supports coordination with OCHA cluster leads, IASC working groups, and pooled fund mechanisms. Essential for Grand Bargain localization commitments and joint donor reporting.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` (
    `consortium_member_id` BIGINT COMMENT 'Unique identifier for the consortium member association record.',
    `consortium_id` BIGINT COMMENT 'Reference to the consortium arrangement that this member belongs to.',
    `partner_org_id` BIGINT COMMENT 'Reference to the partner organization participating as a member of this consortium.',
    `capacity_assessment_date` DATE COMMENT 'The date when the most recent capacity assessment was conducted for this member organization.',
    `capacity_assessment_score` DECIMAL(18,2) COMMENT 'Overall capacity assessment score for this member organization at the time of consortium formation, typically on a scale of 0-100.',
    `consortium_member_code` STRING COMMENT 'Standardized code representing the consortium member classification or category.',
    `contribution_type` DECIMAL(18,2) COMMENT 'The primary type of contribution this member provides to the consortium (financial resources, in-kind goods/services, technical assistance, capacity building, advocacy, coordination).',
    `cost_share_percentage` DECIMAL(18,2) COMMENT 'The percentage of total project costs that this member organization must contribute as cost-sharing or matching funds.',
    `cost_share_required` BOOLEAN COMMENT 'Indicates whether this member organization is required to provide cost-sharing or matching funds as part of their consortium participation.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this consortium member record was first created in the system.',
    `consortium_member_description` STRING COMMENT 'Detailed textual description providing context about the consortium member.',
    `due_diligence_completion_date` DATE COMMENT 'The date when the due diligence review for this member organization was completed.',
    `due_diligence_status` STRING COMMENT 'Status of the due diligence review conducted on this member organization (passed, conditional approval, failed, pending review, expired).. Valid values are `passed|conditional|failed|pending|expired`',
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
    `consortium_member_status` STRING COMMENT 'Current status indicator for the consortium member workflow state.',
    `steering_committee_representative` STRING COMMENT 'Name of the individual representing this member organization on the consortium steering committee or governance body.',
    `sub_award_agreement_number` STRING COMMENT 'Unique identifier or reference number of the sub-award agreement or sub-grant issued to this member organization.',
    `sub_award_type` STRING COMMENT 'The type of legal instrument governing this members participation (sub-grant, sub-contract, MoU - Memorandum of Understanding, LoA - Letter of Agreement, SoW - Scope of Work).. Valid values are `sub_grant|sub_contract|mou|loa|sow`',
    `technical_working_group_participation` STRING COMMENT 'List or description of technical working groups, IASC clusters, or OCHA coordination mechanisms in which this member actively participates on behalf of the consortium.',
    `thematic_responsibility` STRING COMMENT 'The thematic area, sector, or technical domain where this member has primary responsibility (e.g., WASH, health, protection, education, nutrition).',
    `voting_rights` BOOLEAN COMMENT 'Indicates whether this member organization has voting rights in consortium governance decisions and steering committee meetings.',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created this consortium member record.',
    CONSTRAINT pk_consortium_member PRIMARY KEY(`consortium_member_id`)
) COMMENT 'Association record linking partner organizations to consortia, capturing each members role (lead, co-implementer, technical advisor), contribution type, funding allocation percentage, geographic responsibility, and membership status. Tracks the full composition and role distribution within each consortium arrangement.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` (
    `coordination_meeting_id` BIGINT COMMENT 'Unique system-generated identifier for each inter-agency or cluster coordination meeting record. Serves as the primary key for this entity.',
    `crisis_communication_id` BIGINT COMMENT 'Foreign key linking to communication.crisis_communication. Business justification: Coordination meetings during emergencies feed directly into crisis communication protocols, sitreps, and stakeholder updates. Ensures meeting decisions, action items, and inter-agency agreements are r',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Coordination meetings require tracking which NGO staff member represented the organization at inter-agency/cluster coordination forums. Essential for accountability, follow-up action assignment, and h',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Virtual coordination meetings hosted on specific platforms (Zoom, Teams, WebEx). Business need to track platform for license cost allocation, capacity planning, technical support, security compliance ',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Volunteers often represent the NGO in cluster/sector coordination meetings, especially volunteer coordinators or technical specialists. Essential for tracking volunteer participation in coordination m',
    `action_items_summary` STRING COMMENT 'Summary of agreed action items arising from the meeting, including responsible parties and target completion dates where recorded. Supports follow-up tracking and accountability.',
    `agenda_document_url` STRING COMMENT 'URL or file path reference to the pre-circulated meeting agenda document. Supports pre-meeting preparation and post-meeting institutional memory.',
    `agenda_summary` STRING COMMENT 'Structured summary of the meeting agenda items as circulated prior to or during the meeting. Captures the key topics discussed for institutional memory and follow-up tracking.',
    `associated_response_plan` STRING COMMENT 'Name or code of the Humanitarian Response Plan (HRP), Flash Appeal, or other inter-agency response framework that this meeting is associated with. Contextualizes the meeting within the broader humanitarian response architecture.',
    `city` STRING COMMENT 'City or locality where the coordination meeting took place. Supports geographic analysis of coordination activity and field presence.',
    `cluster_sector` STRING COMMENT 'The OCHA humanitarian cluster or sector to which this meeting belongs (e.g., WASH, Health, Nutrition, Shelter, Protection, Food Security, Education, Logistics, Emergency Telecommunications). Null for bilateral or non-cluster meetings. [ENUM-REF-CANDIDATE: wash|health|nutrition|shelter|protection|food_security|education|logistics|emergency_telecom|camp_coordination|early_recovery — promote to reference product]',
    `coordination_meeting_code` STRING COMMENT 'Standardized code representing the coordination meeting classification or category.',
    `confidentiality_level` STRING COMMENT 'Data classification level of the meeting record and its contents. Determines access controls and sharing permissions for meeting minutes, decisions, and attendee lists.. Valid values are `public|internal|confidential|restricted`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the country where the meeting was held. Enables geographic filtering and country-level coordination reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this coordination meeting record was first created in the system. Supports audit trail and data lineage requirements.',
    `coordination_meeting_description` STRING COMMENT 'Detailed textual description providing context about the coordination meeting.',
    `duration_minutes` STRING COMMENT 'Total duration of the coordination meeting in minutes. Supports analysis of coordination effort and time investment across clusters and working groups.',
    `end_date` DATE COMMENT 'Date and time when the end event occurred for this coordination meeting.',
    `end_time` TIMESTAMP COMMENT 'Precise timestamp marking the scheduled or actual end of the coordination meeting. Used to calculate meeting duration and assess time investment in coordination activities.',
    `follow_up_status` STRING COMMENT 'Current status of post-meeting follow-up actions. Tracks whether action items from the meeting have been addressed, are in progress, or are overdue.. Valid values are `pending|in_progress|completed|overdue|not_required`',
    `hosting_organization` STRING COMMENT 'Name of the organization that hosted or convened the coordination meeting. May be Ngo itself, a UN agency, government body, or another INGO acting as cluster lead.',
    `humanitarian_context` STRING COMMENT 'Operational context in which the coordination meeting takes place. Distinguishes acute emergency response from protracted crisis, recovery, development, or preparedness phases.. Valid values are `emergency|protracted_crisis|development|recovery|preparedness`',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether this coordination meeting is part of a recurring series (e.g., monthly cluster meetings, weekly working group calls). Supports scheduling and series-level analysis.',
    `key_decisions` STRING COMMENT 'Narrative record of the principal decisions made during the coordination meeting. Essential for institutional memory, accountability, and follow-up action tracking per CHS and HAP standards.',
    `language` STRING COMMENT 'ISO 639-1 or 639-2 language code for the primary language in which the meeting was conducted (e.g., en, fr, ar). Supports multilingual coordination environments.. Valid values are `^[a-z]{2,3}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this coordination meeting record was most recently modified. Supports change tracking, audit trail, and data freshness monitoring.',
    `location_type` STRING COMMENT 'Indicates whether the meeting was conducted in-person, virtually (e.g., via video conferencing), or in a hybrid format combining both modalities.. Valid values are `in_person|virtual|hybrid`',
    `meeting_date` DATE COMMENT 'The calendar date on which the coordination meeting took place or is scheduled to take place. Principal real-world event date for this transaction.',
    `meeting_reference_code` STRING COMMENT 'Externally-known alphanumeric reference code assigned to the meeting for cross-system tracking and institutional memory. Used in SitReps, donor reports, and OCHA coordination logs.. Valid values are `^[A-Z]{2,10}-MTG-[0-9]{4}-[0-9]{4,6}$`',
    `meeting_status` STRING COMMENT 'Current lifecycle state of the coordination meeting record. Tracks whether the meeting is planned, has occurred, was cancelled, or is in draft preparation.. Valid values are `scheduled|completed|cancelled|postponed|draft`',
    `meeting_title` STRING COMMENT 'Official title or name of the coordination meeting as recorded in the meeting notice or invitation. Provides human-readable identification for institutional memory and reporting.',
    `meeting_type` STRING COMMENT 'Classification of the coordination meeting by its inter-agency structure. Cluster meetings align with OCHA cluster system; working groups are thematic; bilateral meetings are between two organizations; consortium meetings involve prime and sub-award partners. [ENUM-REF-CANDIDATE: cluster|working_group|bilateral|consortium|task_force|inter_agency|steering_committee|donor_review — promote to reference product]. Valid values are `cluster|working_group|bilateral|consortium|task_force|inter_agency`',
    `minutes_document_url` STRING COMMENT 'URL or file path reference to the official meeting minutes document stored in the document management system. Enables direct access to the full minutes for institutional memory.',
    `minutes_recorded` BOOLEAN COMMENT 'Indicates whether formal meeting minutes were recorded and are available for this coordination meeting. Supports institutional memory and accountability requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this coordination meeting.',
    `coordination_meeting_name` STRING COMMENT 'Human-readable name or label for the coordination meeting.',
    `next_meeting_date` DATE COMMENT 'Scheduled date of the next meeting in the series or the follow-up meeting agreed upon at this meeting. Supports coordination planning and scheduling.',
    `ngo_attendees_count` STRING COMMENT 'Number of Ngo staff members who attended the coordination meeting. Supports workforce engagement analysis and coordination effort reporting.',
    `ngo_role` STRING COMMENT 'The role played by Ngo in this coordination meeting. Distinguishes whether Ngo hosted, co-hosted, presented, or attended as a participant or observer. Critical for accountability and stakeholder engagement reporting. [ENUM-REF-CANDIDATE: host|co_host|attendee|presenter|observer|cluster_lead|co_lead — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text field for additional contextual notes, observations, or supplementary information about the coordination meeting not captured in structured fields.',
    `organizations_represented` STRING COMMENT 'Number of distinct organizations represented at the coordination meeting. Indicates breadth of inter-agency engagement and cluster participation.',
    `recurrence_frequency` STRING COMMENT 'Frequency at which this recurring coordination meeting series convenes. Null for one-off or ad hoc meetings. Used for scheduling and coordination cadence analysis.. Valid values are `weekly|biweekly|monthly|quarterly|ad_hoc`',
    `related_sitrep_reference` STRING COMMENT 'Reference code or identifier of the OCHA Situation Report (SitRep) that this meeting contributed to or is referenced in. Links coordination activity to humanitarian situation reporting.',
    `sdg_alignment` STRING COMMENT 'Pipe-separated list of UN Sustainable Development Goal (SDG) numbers that the meeting agenda topics align with (e.g., 3|6|16). Supports SDG-aligned reporting to donors and governing bodies.',
    `series_reference_code` STRING COMMENT 'Reference code linking this meeting instance to its parent recurring series. Enables series-level aggregation and trend analysis across multiple meeting instances.',
    `start_date` DATE COMMENT 'Date and time when the start event occurred for this coordination meeting.',
    `start_time` TIMESTAMP COMMENT 'Precise timestamp marking the scheduled or actual start of the coordination meeting, including timezone offset. Used for scheduling, conflict detection, and attendance tracking.',
    `coordination_meeting_status` STRING COMMENT 'Current status indicator for the coordination meeting workflow state.',
    `total_attendees` STRING COMMENT 'Total number of individuals who attended the coordination meeting. Used for participation analytics, cluster engagement metrics, and donor reporting on coordination activities.',
    `venue_name` STRING COMMENT 'Name of the physical venue or facility where the in-person or hybrid meeting was held (e.g., OCHA compound, NGO coordination hub, government ministry). Null for fully virtual meetings.',
    `virtual_platform` STRING COMMENT 'The digital conferencing platform used for virtual or hybrid meetings (e.g., Zoom, Microsoft Teams, Webex). Null for fully in-person meetings.. Valid values are `zoom|teams|webex|google_meet|skype|other`',
    CONSTRAINT pk_coordination_meeting PRIMARY KEY(`coordination_meeting_id`)
) COMMENT 'Transactional record for inter-agency and cluster coordination meetings attended or hosted by Ngo. Captures meeting type (cluster, working group, bilateral, consortium), date, location, agenda items, attendees, key decisions, action items, and follow-up status. Supports accountability and institutional memory for stakeholder engagement.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` (
    `partner_report_submission_id` BIGINT COMMENT 'Unique system-generated identifier for each partner report submission record. Primary key for this entity.',
    `award_id` BIGINT COMMENT 'Reference to the grant or funding award associated with this report submission, enabling traceability to the donor funding source.',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to program.budget_plan. Business justification: Partner financial reports must reference the approved budget plan for budget-vs-actual variance analysis, expenditure verification against approved line items, burn rate tracking, and financial accoun',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project under which the partner is implementing activities and for which this report is submitted.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Partner financial reports trigger accounting entries when partner-reported expenses are recognized or accruals posted. Required for financial close process, expense recognition, and reconciling partne',
    `partner_org_id` BIGINT COMMENT 'Reference to the implementing partner (Civil Society Organization, Community-Based Organization, INGO, government body, or UN agency) that submitted this report.',
    `partnership_agreement_id` BIGINT COMMENT 'Reference to the sub-award, MoU, LoA, or SoW under which this report is submitted. Links the submission to its governing partnership agreement.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Partner report submissions may fulfill regulatory filing obligations (IATI publication, donor portal submissions, government reporting). Direct mapping between operational reporting and compliance fil',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or grants officer responsible for reviewing and assessing this partner report submission.',
    `subaward_id` BIGINT COMMENT 'Foreign key linking to grant.subaward. Business justification: Partners submit performance and financial reports specific to their subaward scope, not just prime award. Subaward-level reporting is standard practice in tiered grant management for tracking downstre',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Partner reports submitted through specific platforms (donor portals, grants management systems, SharePoint). Critical for tracking submission channels, providing technical support to partners, analyzi',
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
    `donor_report_reference` STRING COMMENT 'The reference number or identifier of the upstream donor report into which this partner submissions data has been incorporated, enabling traceability from sub-award reporting to prime award donor reporting.',
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
    `quality_score` DECIMAL(18,2) COMMENT 'Numeric quality assessment score assigned by the reviewer to the submitted report, typically on a standardized scale (e.g., 0–100). Reflects completeness, accuracy, and adherence to reporting standards. Used for partner performance monitoring.',
    `remarks` STRING COMMENT 'Additional notes, contextual observations, or internal comments recorded by the grants management team regarding this report submission, such as exceptional circumstances, force majeure events, or escalation notes.',
    `report_period_frequency` STRING COMMENT 'The scheduled reporting cadence for this submission as defined in the sub-award agreement, indicating whether the report covers a monthly, quarterly, semi-annual, annual, or ad hoc period.. Valid values are `monthly|quarterly|semi_annual|annual|ad_hoc`',
    `report_title` STRING COMMENT 'The formal title or name of the submitted report document as provided by the implementing partner, used for identification and document management purposes.',
    `report_type` STRING COMMENT 'Classification of the report submitted by the partner. Narrative reports cover programmatic progress; financial reports cover expenditure against budget (BvA); SitRep (Situation Report) covers operational context; PDM (Post-Distribution Monitoring) covers distribution outcomes; combined covers both narrative and financial. [ENUM-REF-CANDIDATE: narrative|financial|situation_report|post_distribution_monitoring|combined|other — promote to reference product]. Valid values are `narrative|financial|situation_report|post_distribution_monitoring|combined`',
    `report_version` STRING COMMENT 'Sequential version number of the report submission, incremented each time the partner resubmits a revised version following feedback or a revision request. Version 1 is the initial submission.',
    `reporting_period_end_date` DATE COMMENT 'The last day of the period covered by this report submission, as defined in the sub-award or agreement reporting schedule.',
    `reporting_period_start_date` DATE COMMENT 'The first day of the period covered by this report submission, as defined in the sub-award or agreement reporting schedule.',
    `review_completion_date` DATE COMMENT 'The date on which the review of the partner report was completed and a decision (accepted, feedback issued, or rejected) was communicated to the partner.',
    `review_start_date` DATE COMMENT 'The date on which the formal review of the submitted report was initiated by the grants management team.',
    `review_status` STRING COMMENT 'Current workflow state of the report submission in the review and acceptance lifecycle. Tracks progression from initial receipt through quality review, feedback, revision, and final acceptance or rejection.. Valid values are `pending_review|under_review|feedback_issued|revision_requested|accepted|rejected`',
    `revision_deadline` DATE COMMENT 'The deadline by which the implementing partner must resubmit a revised report following a revision request or feedback issuance. Null if no revision has been requested.',
    `start_date` DATE COMMENT 'Date and time when the start event occurred for this partner report submission.',
    `partner_report_submission_status` STRING COMMENT 'Current status indicator for the partner report submission workflow state.',
    `submission_date` DATE COMMENT 'The actual calendar date on which the partner submitted this report to the organization. Used to calculate timeliness and compliance with reporting obligations.',
    `submission_method` STRING COMMENT 'The channel or mechanism through which the partner submitted the report, such as email, online portal, GMS (Grant Management System) upload, hard copy, or KoboToolbox.. Valid values are `email|online_portal|gms_upload|hard_copy|kobo_toolbox`',
    `submission_reference_number` STRING COMMENT 'Externally-known alphanumeric reference code assigned to this report submission, used in correspondence with the partner and in donor reporting systems such as Unit4 ERP or GMS.',
    `submission_timestamp` TIMESTAMP COMMENT 'The precise date and time at which the partner report was received or uploaded into the grant management system, capturing the exact moment of submission for audit trail purposes.',
    `target_beneficiaries` STRING COMMENT 'The planned number of beneficiaries the partner was expected to reach during the reporting period as defined in the sub-award agreement or LogFrame targets.',
    `total_expenditure_reported` DECIMAL(18,2) COMMENT 'The total financial expenditure reported by the implementing partner for the reporting period, as stated in the financial report. Used for Budget versus Actual (BvA) analysis and donor financial reporting.',
    CONSTRAINT pk_partner_report_submission PRIMARY KEY(`partner_report_submission_id`)
) COMMENT 'Tracks all programmatic and financial reports submitted by implementing partners under their sub-award or agreement obligations. Captures report type (narrative, financial, SitRep, PDM), reporting period, submission date, review status, feedback provided, and acceptance date. Supports compliance monitoring and donor reporting obligations under 2 CFR 200. Systems-of-record: eTools (PD/SSFA reporting), InSight. Framework: HACT / IATI v2.03 result reporting.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` (
    `capacity_building_plan_id` BIGINT COMMENT 'Unique system-generated identifier for the capacity building plan record. Primary key for this entity. Role: MASTER_AGREEMENT — this product represents a structured, time-bound plan (agreement-like container) governing capacity-building interventions for a partner organization.',
    `award_id` BIGINT COMMENT 'Reference to the grant or sub-award under which this capacity building plan is funded and implemented. Links to the grant master record in the grant domain.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Capacity building plans require formal budget allocation for training, technical assistance, and organizational development activities. Links plan to approved budget for expenditure tracking, variance',
    `capacity_assessment_id` BIGINT COMMENT 'Reference to the formal capacity assessment record that identified the gaps and informed the design of this capacity building plan. Ensures traceability from assessment findings to planned interventions.',
    `partner_org_id` BIGINT COMMENT 'Reference to the partner organization (Civil Society Organization, Community-Based Organization, or local INGO) for whom this capacity building plan has been developed. Links to the partner organization master record in the partnership domain.',
    `staff_member_id` BIGINT COMMENT 'Reference to the Ngo staff member (e.g., Partnership Officer, Capacity Building Advisor) who is the primary owner and accountable lead for this plans implementation.',
    `training_program_id` BIGINT COMMENT 'Foreign key linking to safeguarding.training_program. Business justification: Capacity building plans specify safeguarding training programs to address partner capacity gaps identified in assessments. Links planned interventions to standardized training curriculum for implement',
    `approval_date` DATE COMMENT 'Date on which this capacity building plan was formally approved by the designated authority at Ngo, authorizing commencement of activities and budget expenditure.',
    `approved_by` STRING COMMENT 'Name or identifier of the Ngo staff member or management authority who formally approved this capacity building plan for implementation. Supports governance and accountability documentation.',
    `baseline_capacity_score` DECIMAL(18,2) COMMENT 'Numeric score representing the partner organizations overall organizational capacity at the time of the baseline assessment, prior to plan implementation. Typically scored on a standardized scale (e.g., 1–5 or 0–100) per the assessment tool used.',
    `capacity_score_scale` STRING COMMENT 'The scoring scale used for baseline, target, and current capacity scores in this plan (e.g., 1_to_5, 0_to_100). Ensures consistent interpretation of scores across different assessment tools and reporting periods.. Valid values are `1_to_5|0_to_100|1_to_4|0_to_10`',
    `chs_standard_aligned` BOOLEAN COMMENT 'Indicates whether this capacity building plan is designed in alignment with the Core Humanitarian Standard (CHS) on Quality and Accountability, ensuring the partner is supported to meet CHS commitments.',
    `capacity_building_plan_code` STRING COMMENT 'Standardized code representing the capacity building plan classification or category.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the partner organization operates and where this capacity building plan is being implemented (e.g., SOM, SDN, ETH).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this capacity building plan record was first created in the system. Corresponds to the MASTER_AGREEMENT RECORD_AUDIT_CREATED category. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the local currency in which the plan budget is also tracked (e.g., USD, EUR, KES). Supports multi-currency financial reporting for field operations.. Valid values are `^[A-Z]{3}$`',
    `current_capacity_score` DECIMAL(18,2) COMMENT 'Most recently recorded organizational capacity score for the partner, updated following periodic reassessments or milestone reviews during plan implementation. Enables tracking of progress toward the target capacity score.',
    `capacity_building_plan_description` STRING COMMENT 'Detailed textual description providing context about the capacity building plan.',
    `donor_reporting_required` BOOLEAN COMMENT 'Indicates whether progress on this capacity building plan must be reported to the donor as part of grant compliance obligations. True = donor reporting required; False = internal plan only.',
    `end_date` DATE COMMENT 'The planned or actual date on which the capacity building plan concludes and all activities are expected to be completed. Nullable for open-ended plans. Corresponds to the MASTER_AGREEMENT EFFECTIVE_UNTIL category.',
    `expenditure_to_date_usd` DECIMAL(18,2) COMMENT 'Cumulative actual expenditure incurred against this capacity building plan to date, expressed in US Dollars (USD). Used for Budget versus Actual (BvA) tracking and financial stewardship reporting.',
    `gender_mainstreaming_included` BOOLEAN COMMENT 'Indicates whether gender mainstreaming and Gender-Based Violence (GBV) prevention components are explicitly included in this capacity building plan, in line with donor gender policies and SDG (Sustainable Development Goal) 5 commitments.',
    `grand_bargain_commitment_ref` STRING COMMENT 'Reference code or description of the specific Grand Bargain commitment (e.g., Workstream 2 — Localization) that this capacity building plan contributes to. Supports donor accountability and IATI transparency reporting.',
    `implementation_region` STRING COMMENT 'Sub-national region, state, or province where the partner organization and this capacity building plan are primarily based. Supports geographic disaggregation in MEL dashboards and GIS (Geographic Information System) reporting.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review or progress assessment of this capacity building plan, during which activity completion, capacity scores, and budget utilization were evaluated.',
    `localization_strategy_aligned` BOOLEAN COMMENT 'Indicates whether this capacity building plan is formally aligned with Ngos localization strategy and Grand Bargain commitments to strengthen local and national actors. True = aligned and documented; False = not formally aligned.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this capacity building plan.',
    `capacity_building_plan_name` STRING COMMENT 'Human-readable name or label for the capacity building plan.',
    `next_review_date` DATE COMMENT 'Date on which the next formal review of this capacity building plan is scheduled. Drives workflow reminders and ensures timely monitoring of plan progress.',
    `notes` STRING COMMENT 'Free-text field for additional contextual notes, observations, or qualitative commentary on the capacity building plan, including lessons learned, contextual challenges, or coordination notes with OCHA cluster leads.',
    `overall_objective` STRING COMMENT 'High-level statement of the primary objective of this capacity building plan, describing the intended organizational capability improvement to be achieved by the plans end date.',
    `overall_progress_status` STRING COMMENT 'Qualitative assessment of the overall implementation progress of the capacity building plan relative to the planned timeline and milestones. Distinct from plan_status (lifecycle state); this reflects delivery performance.. Valid values are `on_track|delayed|at_risk|completed|not_started`',
    `partner_focal_point_name` STRING COMMENT 'Full name of the designated focal point or primary contact person at the partner organization who is responsible for coordinating and participating in capacity building activities under this plan.',
    `partner_focal_point_title` STRING COMMENT 'Job title or role of the partner organizations designated focal point for this capacity building plan (e.g., Executive Director, Finance Manager, MEL Officer).',
    `plan_reference_code` STRING COMMENT 'Externally-known alphanumeric reference code assigned to this capacity building plan, used in donor reports, partner correspondence, and IATI disclosures. Format: CBP-[PartnerCode]-[Year]-[Sequence].. Valid values are `^CBP-[A-Z0-9]{3,10}-[0-9]{4}-[0-9]{3,6}$`',
    `plan_status` STRING COMMENT 'Current lifecycle status of the capacity building plan. draft = under development; active = approved and in implementation; on_hold = temporarily suspended; completed = all activities delivered and closed; cancelled = plan discontinued.. Valid values are `draft|active|on_hold|completed|cancelled`',
    `plan_title` STRING COMMENT 'Human-readable title of the capacity building plan, typically referencing the partner organization name and the primary functional area targeted (e.g., Financial Management Strengthening Plan — Partner XYZ 2024).',
    `plan_type` STRING COMMENT 'Classification of the primary focus area of the capacity building plan. organizational = overall organizational development; technical = sector-specific technical skills; financial = financial management and accountability; governance = board and leadership strengthening; mel = Monitoring, Evaluation, and Learning (MEL) systems. [ENUM-REF-CANDIDATE: organizational|technical|financial|governance|mel|procurement|hr|communications|safeguarding — promote to reference product]. Valid values are `organizational|technical|financial|governance|mel`',
    `reporting_frequency` STRING COMMENT 'Frequency at which progress updates on this capacity building plan must be reported internally or to the donor. Drives scheduling of review meetings and SitRep (Situation Report) contributions.. Valid values are `monthly|quarterly|semi_annual|annual|ad_hoc`',
    `safeguarding_component_included` BOOLEAN COMMENT 'Indicates whether this capacity building plan includes a dedicated safeguarding (Protection from Sexual Exploitation and Abuse — PSEA) component. Required for compliance with donor safeguarding policies and CHS commitments.',
    `start_date` DATE COMMENT 'The date on which the capacity building plan officially commences and activities are scheduled to begin. Corresponds to the MASTER_AGREEMENT EFFECTIVE_FROM category.',
    `capacity_building_plan_status` STRING COMMENT 'Current status indicator for the capacity building plan workflow state.',
    `target_capacity_score` DECIMAL(18,2) COMMENT 'Numeric score representing the desired organizational capacity level to be achieved by the partner organization upon successful completion of this plan. Used to measure progress and plan effectiveness.',
    `targeted_functional_areas` STRING COMMENT 'Comma-separated list of organizational functional areas targeted by this plan for strengthening, as identified in the capacity assessment. Common values include: financial management, human resources, procurement, governance, MEL (Monitoring Evaluation and Learning), safeguarding, communications, ICT4D (Information and Communication Technology for Development).',
    `theory_of_change_summary` STRING COMMENT 'Narrative summary of the Theory of Change (ToC) underpinning this capacity building plan, describing the causal pathway from planned interventions to expected organizational capability improvements and ultimate program outcomes.',
    `total_activities_completed` STRING COMMENT 'Count of capacity building activity line-items that have been fully delivered and marked as completed under this plan. Used to calculate overall plan completion rate for MEL dashboards and donor reporting.',
    `total_activities_planned` STRING COMMENT 'Total number of capacity building activity line-items (trainings, mentoring sessions, technical assistance visits, peer learning events) planned under this plan. Used for progress tracking and workload planning.',
    `total_budget_usd` DECIMAL(18,2) COMMENT 'Total approved budget allocated for the implementation of this capacity building plan, expressed in US Dollars (USD). Covers all activity costs including training, technical assistance, materials, and facilitator fees.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this capacity building plan record was most recently modified. Supports audit trail requirements and data lineage tracking in the Databricks Silver Layer.',
    CONSTRAINT pk_capacity_building_plan PRIMARY KEY(`capacity_building_plan_id`)
) COMMENT 'Master record with embedded activity line-items for structured capacity-building interventions developed for partner organizations based on capacity assessment findings. Plan-level data captures objectives, targeted functional areas (financial management, HR, procurement, governance, MEL), timeline, responsible staff, budget allocation, and overall progress status. Activity-level line-items capture individual trainings, mentoring sessions, technical assistance visits, and peer learning events with delivery dates, facilitators, participant lists, topics covered, pre/post assessment scores, and completion status. Supports localization strategies, partner strengthening, and Grand Bargain commitments. This is the SSOT for all capacity-building planning and delivery tracking in the partnership domain.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` (
    `capacity_building_activity_id` BIGINT COMMENT 'Unique system-generated identifier for each capacity-building activity record delivered to a partner organization. Serves as the primary key for this entity. Entity role: TRANSACTION_HEADER — a discrete, trackable business event with its own lifecycle.',
    `award_id` BIGINT COMMENT 'Identifier of the grant funding this capacity-building activity. Required for donor compliance reporting and Budget versus Actual (BvA) tracking under OMB Uniform Guidance 2 CFR 200.',
    `capacity_building_plan_id` BIGINT COMMENT 'Identifier of the overarching capacity-building plan under which this individual activity is scheduled and tracked. Links the activity to its strategic plan and progress milestones.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Individual capacity building activities (workshops, training sessions) incur direct costs that must be charged to specific cost centers for activity-based costing and financial tracking. Required for ',
    `impact_story_id` BIGINT COMMENT 'Foreign key linking to communication.impact_story. Business justification: Capacity building outcomes (trained staff, improved systems, organizational transformation) are compelling impact narratives for donors and advocates. Links stories to specific capacity interventions ',
    `intervention_id` BIGINT COMMENT 'Identifier of the program or project under which this capacity-building activity is funded and implemented. Enables program-level aggregation of partner strengthening efforts.',
    `partner_org_id` BIGINT COMMENT 'Identifier of the partner organization (CSO, CBO, INGO, government body, UN agency, or consortium member) receiving this capacity-building activity. Satisfies TRANSACTION_HEADER PARTY_REFERENCE category.',
    `staff_member_id` BIGINT COMMENT 'Identifier of the internal staff member or consultant who facilitated or led this capacity-building activity. Used for workload tracking and quality assurance reviews.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Capacity building training delivered via LMS, webinar platforms, or e-learning systems. Tracking platform enables participant access management, completion tracking, certificate generation, technical ',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Experienced volunteers frequently serve as trainers, facilitators, or peer mentors in partner capacity building activities. This is a core localization pattern where volunteer expertise builds partner',
    `activity_cost_usd` DECIMAL(18,2) COMMENT 'Total direct cost incurred to deliver this capacity-building activity, expressed in US Dollars. Includes facilitator fees, venue, materials, and travel. Used for Budget versus Actual (BvA) tracking and cost-effectiveness analysis under OMB Uniform Guidance 2 CFR 200.',
    `activity_reference_code` STRING COMMENT 'Externally-known alphanumeric reference code assigned to this capacity-building activity, used in partner communications, donor reports, and IATI disclosures. Format: CBA-{COUNTRY}-{YEAR}-{SEQUENCE}. Satisfies TRANSACTION_HEADER BUSINESS_IDENTIFIER category.. Valid values are `^CBA-[A-Z]{2,6}-[0-9]{4}-[0-9]{4,6}$`',
    `activity_status` STRING COMMENT 'Current lifecycle state of the capacity-building activity. Drives workflow management, MEL dashboard filtering, and completion reporting to donors. Satisfies TRANSACTION_HEADER LIFECYCLE_STATUS category.. Valid values are `planned|in_progress|completed|cancelled|postponed`',
    `activity_title` STRING COMMENT 'Descriptive title of the capacity-building activity (e.g., Financial Management Training for Partner Finance Officers, MEAL System Technical Assistance Visit). Used in reports and partner communications.',
    `activity_type` STRING COMMENT 'Classification of the modality or format of the capacity-building activity. Drives reporting disaggregation and MEL indicator tracking. [ENUM-REF-CANDIDATE: training|mentoring|technical_assistance|peer_learning|coaching|workshop|on_the_job_support|e_learning — promote to reference product if additional types are needed]. Valid values are `training|mentoring|technical_assistance|peer_learning|coaching|workshop`',
    `actual_delivery_date` DATE COMMENT 'The real-world date on which the capacity-building activity was delivered or commenced. The principal business event date for this transaction. Satisfies TRANSACTION_HEADER BUSINESS_EVENT_TIMESTAMP category.',
    `actual_end_date` DATE COMMENT 'The real-world date on which the capacity-building activity concluded. Used to calculate actual duration and compare against planned schedule.',
    `assessment_method` STRING COMMENT 'Method used to evaluate participant knowledge or competency before and after the activity. Informs the validity and comparability of pre/post assessment scores across activities.. Valid values are `written_test|oral_assessment|practical_demonstration|observation|self_assessment|peer_review`',
    `capacity_domain` STRING COMMENT 'High-level domain of organizational capacity being strengthened through this activity, aligned with standard capacity assessment frameworks. Used for portfolio-level gap analysis and Theory of Change (ToC) alignment.. Valid values are `organizational|technical|leadership|financial|operational|advocacy`',
    `certification_body` STRING COMMENT 'Name of the accrediting or certifying body that issued the certificate for this activity (e.g., CHS Alliance, SPHERE Association, USAID, Internal). Populated only when is_certified is True.',
    `capacity_building_activity_code` STRING COMMENT 'Standardized code representing the capacity building activity classification or category.',
    `completion_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of registered participants who completed the full capacity-building activity (attended all sessions or met minimum attendance threshold). Key MEL indicator for activity quality and partner engagement.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the location where the capacity-building activity was delivered. Enables geographic disaggregation in MEL dashboards and OCHA cluster reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this capacity-building activity record was first created in the system. Satisfies TRANSACTION_HEADER RECORD_AUDIT_CREATED category. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `delivery_mode` STRING COMMENT 'Mode through which the capacity-building activity was delivered to participants. Distinguishes face-to-face field visits from remote or blended approaches, relevant for cost analysis and ICT4D reporting.. Valid values are `in_person|virtual|hybrid|self_paced`',
    `capacity_building_activity_description` STRING COMMENT 'Detailed textual description providing context about the capacity building activity.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total number of contact hours delivered during this capacity-building activity. Used for MEL indicator reporting (e.g., total training hours delivered to partners) and cost-per-hour analysis.',
    `end_date` DATE COMMENT 'Date and time when the end event occurred for this capacity building activity.',
    `facilitator_name` STRING COMMENT 'Full name of the lead facilitator or trainer who delivered this capacity-building activity. Captured for quality assurance, follow-up, and facilitator performance tracking. Classified confidential as it identifies a specific individual in a professional context.',
    `facilitator_type` STRING COMMENT 'Classification of the entity or individual who facilitated the capacity-building activity. Distinguishes internal staff-led sessions from externally contracted consultants or peer-learning facilitated by other NGOs or UN agencies.. Valid values are `internal_staff|external_consultant|peer_organization|un_agency|government`',
    `feedback_collected` BOOLEAN COMMENT 'Indicates whether participant feedback or a post-distribution monitoring (PDM) equivalent survey was collected for this capacity-building activity. Supports accountability and learning (MEAL) requirements.',
    `female_participants` STRING COMMENT 'Number of female participants in this capacity-building activity. Required for gender disaggregation reporting per USAID Gender Equality Policy, DFID guidelines, and SDG 5 indicators.',
    `follow_up_due_date` DATE COMMENT 'Target date by which the follow-up action identified after this capacity-building activity should be completed. Populated only when follow_up_required is True.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether a follow-up visit, mentoring session, or technical assistance is required after this activity to reinforce learning or address outstanding gaps. Drives scheduling of subsequent capacity-building activities.',
    `is_certified` BOOLEAN COMMENT 'Indicates whether a certificate of completion or competency was issued to participants upon successful completion of this capacity-building activity. Relevant for accredited training programs and professional development tracking.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this capacity-building activity record was most recently modified. Satisfies TRANSACTION_HEADER RECORD_AUDIT_UPDATED category. Used for data lineage, audit trails, and incremental ETL processing. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `linked_capacity_gap` STRING COMMENT 'Description or reference code of the specific capacity gap identified in the partners capacity assessment that this activity is designed to address. Enables traceability from gap identification to intervention delivery.',
    `location_name` STRING COMMENT 'Name of the specific city, district, or venue where the capacity-building activity took place (e.g., Nairobi Regional Office, Kampala Training Centre). Complements country code for field-level geographic reporting.',
    `male_participants` STRING COMMENT 'Number of male participants in this capacity-building activity. Required for gender disaggregation reporting per USAID Gender Equality Policy and SDG 5 indicators.',
    `materials_provided` BOOLEAN COMMENT 'Indicates whether training materials, toolkits, manuals, or job aids were distributed to participants as part of this capacity-building activity. Relevant for resource tracking and follow-up support planning.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this capacity building activity.',
    `capacity_building_activity_name` STRING COMMENT 'Human-readable name or label for the capacity building activity.',
    `notes` STRING COMMENT 'Free-text field for capturing qualitative observations, lessons learned, contextual factors, or any other relevant information about the capacity-building activity not captured in structured fields. Supports MEL narrative reporting.',
    `participant_satisfaction_score` DECIMAL(18,2) COMMENT 'Average satisfaction rating provided by participants in post-activity feedback forms, typically on a scale of 1–5 or 1–10. Used for activity quality improvement and facilitator performance assessment.',
    `post_assessment_score` DECIMAL(18,2) COMMENT 'Average knowledge or competency assessment score recorded for participants after the capacity-building activity concluded. Compared against pre-assessment score to measure learning gain and activity effectiveness.',
    `pre_assessment_score` DECIMAL(18,2) COMMENT 'Average knowledge or competency assessment score recorded for participants before the capacity-building activity commenced. Used to establish a baseline for measuring learning gain. Expressed as a percentage (0–100). Satisfies TRANSACTION_HEADER QUANTITATIVE_RESULT category (non-monetary).',
    `scheduled_end_date` DATE COMMENT 'Planned date on which the capacity-building activity was originally scheduled to conclude. Used for duration planning and workplan management.',
    `scheduled_start_date` DATE COMMENT 'Planned date on which the capacity-building activity was originally scheduled to begin. Used for planning, calendar management, and variance analysis against actual delivery.',
    `start_date` DATE COMMENT 'Date and time when the start event occurred for this capacity building activity.',
    `capacity_building_activity_status` STRING COMMENT 'Current status indicator for the capacity building activity workflow state.',
    `thematic_area` STRING COMMENT 'Primary thematic or sectoral focus of the capacity-building activity (e.g., Financial Management, MEAL, WASH, GBV Prevention, Procurement, Safeguarding, Proposal Writing). Used for portfolio analysis and gap identification. [ENUM-REF-CANDIDATE: financial_management|meal|wash|gbv_prevention|procurement|safeguarding|proposal_writing|hr_management|logistics|governance — promote to reference product]',
    `topics_covered` STRING COMMENT 'Free-text or structured description of the specific topics, modules, or competencies addressed during the activity (e.g., Budget vs Actual reporting, SAP navigation, donor compliance rules). Supports curriculum documentation and knowledge management.',
    `total_participants` STRING COMMENT 'Total number of individuals from the partner organization who participated in this capacity-building activity. Core MEL indicator for reach and coverage reporting to donors.',
    CONSTRAINT pk_capacity_building_activity PRIMARY KEY(`capacity_building_activity_id`)
) COMMENT 'Transactional record for individual capacity-building activities delivered to partner organizations including trainings, mentoring sessions, technical assistance visits, and peer learning events. Captures activity type, delivery date, facilitator, participants, topics covered, pre/post assessment scores, and completion status. Tracks progress against the capacity-building plan.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` (
    `partner_risk_register_id` BIGINT COMMENT 'Unique surrogate identifier for each risk entry in the partner risk register. Primary key for this data product.',
    `due_diligence_record_id` BIGINT COMMENT 'Foreign key linking to partnership.due_diligence_record. Business justification: partner_risk_register stores capacity_assessment_score and capacity_assessment_date but has no FK to due_diligence_record. Risks are identified through due diligence processes. Adding due_diligence_re',
    `partner_org_id` BIGINT COMMENT 'Reference to the partner organization for which this risk entry is recorded. Links to the partner master record.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member record of the designated risk owner responsible for monitoring and managing this risk. Enables automated escalation workflows and accountability tracking.',
    `subaward_id` BIGINT COMMENT 'Reference to the specific sub-award agreement under which this risk is being assessed, if applicable. Links to the sub-award management record.',
    `partner_risk_register_code` STRING COMMENT 'Standardized code representing the partner risk register classification or category.',
    `composite_risk_score` STRING COMMENT 'Calculated product of likelihood_rating multiplied by impact_rating (range 1–25), yielding the overall risk severity score used to prioritise mitigation actions and sub-award oversight decisions. Stored as a business-recorded value from the risk assessment process, not a real-time derived metric.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk register entry was first created in the system. Provides the audit trail creation marker required for data governance and compliance reporting.',
    `partner_risk_register_description` STRING COMMENT 'Detailed textual description providing context about the partner risk register.',
    `donor_notification_required` BOOLEAN COMMENT 'Indicates whether the risk event or materialisation requires formal notification to the donor per grant agreement terms (True). Relevant for USAID, DFID/FCDO, CERF, and other institutional donors with mandatory incident reporting clauses.',
    `donor_notified_date` DATE COMMENT 'Date on which the donor was formally notified of this risk or incident. Null if notification has not yet occurred or is not required. Used for compliance tracking against donor agreement notification timelines.',
    `due_diligence_level` STRING COMMENT 'Level of due diligence applied to this partner in relation to this risk: standard (routine checks), enhanced (additional scrutiny for high-risk partners), simplified (low-risk, minimal checks). Aligns with donor-mandated partner vetting requirements.. Valid values are `standard|enhanced|simplified`',
    `end_date` DATE COMMENT 'Date and time when the end event occurred for this partner risk register.',
    `escalated_to` STRING COMMENT 'Name or role of the individual, committee, or external body to whom this risk was escalated (e.g., Country Director, Board Risk Committee, USAID Agreement Officer). Supports accountability and audit trail requirements.',
    `escalation_date` DATE COMMENT 'Date on which this risk was formally escalated to senior management, the board, or the donor. Null if escalation has not occurred. Used for audit trail and compliance reporting.',
    `escalation_required` BOOLEAN COMMENT 'Indicates whether this risk has been flagged for escalation to senior management, the board, or the donor (True). Set automatically when risk_level is critical or when safeguarding_risk_flag is True.',
    `fiduciary_risk_flag` BOOLEAN COMMENT 'Indicates whether this risk entry has been classified as a fiduciary risk (True) involving financial management, fund accountability, or procurement integrity concerns. Triggers enhanced financial monitoring protocols.',
    `financial_exposure_usd` DECIMAL(18,2) COMMENT 'Estimated maximum financial exposure in US Dollars associated with this risk, representing the value of funds at risk if the risk materialises (e.g., sub-award value at risk of misappropriation). Used in fiduciary risk prioritisation and BvA oversight.',
    `impact_rating` STRING COMMENT 'Numeric score (1–5) representing the severity of consequences if the risk materialises: 1=Negligible, 2=Minor, 3=Moderate, 4=Major, 5=Catastrophic. Assessed across financial, programmatic, reputational, and safeguarding dimensions.',
    `inherent_impact_rating` STRING COMMENT 'Impact rating (1–5) assessed BEFORE any mitigation controls are applied. Together with inherent_likelihood_rating, establishes the gross risk score prior to control application.',
    `inherent_likelihood_rating` STRING COMMENT 'Likelihood rating (1–5) assessed BEFORE any mitigation controls are applied. Captures the gross/inherent risk level to benchmark the effectiveness of mitigation measures.',
    `last_review_date` DATE COMMENT 'The date on which this risk entry was most recently reviewed and updated by the risk owner or oversight team. Used to flag stale entries requiring re-assessment.',
    `likelihood_rating` STRING COMMENT 'Numeric score (1–5) representing the probability that the risk will materialise: 1=Rare, 2=Unlikely, 3=Possible, 4=Likely, 5=Almost Certain. Used in composite risk scoring per standard NGO risk matrices.',
    `mitigation_measures` STRING COMMENT 'Narrative description of the specific controls, actions, and safeguards implemented or planned to reduce the likelihood or impact of the risk. May include capacity-building, enhanced financial monitoring, spot-checks, or escalation protocols.',
    `mitigation_status` STRING COMMENT 'Current implementation status of the mitigation measures: planned (not yet started), in_progress (underway), completed (fully implemented), overdue (past target date without completion).. Valid values are `planned|in_progress|completed|overdue`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this partner risk register.',
    `monitoring_frequency` STRING COMMENT 'Frequency at which this risk entry is actively monitored and reviewed: weekly, monthly, quarterly, semi_annual, annual, or ad_hoc. Drives scheduling of oversight activities and MEL review cycles.. Valid values are `weekly|monthly|quarterly|semi_annual|annual|ad_hoc`',
    `partner_risk_register_name` STRING COMMENT 'Human-readable name or label for the partner risk register.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of this risk entry. Drives automated reminders and compliance with periodic risk review obligations under donor agreements.',
    `notes` STRING COMMENT 'Free-text field for additional context, observations, or supplementary information related to this risk entry that does not fit into structured fields. May include references to related incident reports, audit findings, or SitRep entries.',
    `oversight_mechanism` STRING COMMENT 'Description of the specific oversight mechanism applied to manage this risk (e.g., Monthly financial spot-checks, Quarterly field monitoring visits, Third-party audit, PDM surveys). Documents the control environment for donor compliance.',
    `risk_appetite_alignment` STRING COMMENT 'Assessment of whether this risk falls within the organisations defined risk appetite: within_appetite (acceptable), at_tolerance (borderline, requires monitoring), exceeds_appetite (unacceptable, requires immediate action or sub-award suspension).. Valid values are `within_appetite|at_tolerance|exceeds_appetite`',
    `risk_category` STRING COMMENT 'High-level classification of the risk type: fiduciary (financial mismanagement, fraud), programmatic (delivery failure, quality gaps), reputational (media, political exposure), safeguarding (protection of beneficiaries and staff), or compliance (regulatory, donor-condition breaches).. Valid values are `fiduciary|programmatic|reputational|safeguarding|compliance`',
    `risk_closure_date` DATE COMMENT 'The date on which this risk was formally closed, either because it was fully mitigated, the sub-award ended, or the risk was deemed no longer applicable. Null if the risk remains open.',
    `risk_description` STRING COMMENT 'Detailed narrative describing the nature of the risk, its potential causes, and the context in which it may materialise. Supports due diligence documentation and donor compliance reporting.',
    `risk_identification_date` DATE COMMENT 'The date on which this risk was first formally identified and entered into the risk register. Marks the start of the risk lifecycle and is used for ageing analysis.',
    `risk_level` STRING COMMENT 'Qualitative risk band derived from the composite risk score: low (1–4), medium (5–9), high (10–16), critical (17–25). Used for traffic-light reporting in MEL dashboards, donor SitReps, and sub-award oversight decisions.. Valid values are `low|medium|high|critical`',
    `risk_materialisation_date` DATE COMMENT 'Date on which the risk was confirmed to have materialised into an actual incident or adverse event. Null if the risk has not materialised. Used for incident timeline analysis and donor reporting.',
    `risk_materialised` BOOLEAN COMMENT 'Indicates whether the identified risk has actually materialised into an incident or adverse event (True). When True, triggers incident management workflows and may require sub-award suspension or termination review.',
    `risk_owner` STRING COMMENT 'Name or role title of the individual within the NGO responsible for monitoring and managing this risk entry. Typically a Program Manager, Grants Manager, or Country Director.',
    `risk_register_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to this risk entry for cross-system reference and reporting (e.g., RR-FISC-2024-0012). Used in donor reports, audit trails, and compliance filings.. Valid values are `^RR-[A-Z]{2,6}-[0-9]{4}-[0-9]{4}$`',
    `risk_status` STRING COMMENT 'Current lifecycle state of the risk entry: open (identified, not yet addressed), under_review (being assessed), mitigated (controls applied), escalated (elevated to senior management or donor), closed (resolved or no longer applicable).. Valid values are `open|under_review|mitigated|escalated|closed`',
    `risk_subcategory` STRING COMMENT 'Granular classification within the risk category (e.g., Procurement Fraud under fiduciary, GBV Incident under safeguarding, FCPA Violation under compliance). [ENUM-REF-CANDIDATE: procurement_fraud|financial_misreporting|conflict_of_interest|gbv_incident|child_protection|data_breach|political_interference|media_exposure|delivery_failure|quality_failure|regulatory_breach|donor_condition_breach — promote to reference product]',
    `risk_title` STRING COMMENT 'Short, human-readable title summarising the risk (e.g., Inadequate financial controls at field office level). Used as the primary label in risk dashboards and SitRep summaries.',
    `safeguarding_risk_flag` BOOLEAN COMMENT 'Indicates whether this risk entry involves safeguarding concerns (True), including GBV, child protection, or protection of beneficiaries and staff from exploitation and abuse. Triggers mandatory escalation per CHS safeguarding protocols.',
    `start_date` DATE COMMENT 'Date and time when the start event occurred for this partner risk register.',
    `partner_risk_register_status` STRING COMMENT 'Current status indicator for the partner risk register workflow state.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk register entry was most recently modified. Used for change tracking, audit trail, and data lineage in the Databricks Silver Layer.',
    CONSTRAINT pk_partner_risk_register PRIMARY KEY(`partner_risk_register_id`)
) COMMENT 'Master record maintaining the risk register for each partner organization covering fiduciary risk, programmatic risk, reputational risk, safeguarding risk, and compliance risk. Captures risk category, risk description, likelihood rating, impact rating, composite risk score, mitigation measures, risk owner, and review date. Feeds into sub-award management and oversight decisions.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` (
    `mou_obligation_id` BIGINT COMMENT 'Unique system-generated identifier for each obligation, deliverable, or commitment record defined within an MoU or partnership agreement. Primary key for this entity.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: MOU obligations frequently derive from specific award compliance requirements, donor special conditions, and regulatory flow-down clauses. Tracking which award drives each obligation is essential for ',
    `field_monitoring_visit_id` BIGINT COMMENT 'Foreign key linking to partnership.field_monitoring_visit. Business justification: mou_obligation has verified_date and verified_by_name but no link to the field_monitoring_visit where verification occurred. Obligations are often verified during field monitoring visits. Adding field',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: MOU obligations (deliverables, milestones, reporting requirements) are tied to specific program interventions for performance monitoring, results verification, and intervention-level obligation tracki',
    `partnership_agreement_id` BIGINT COMMENT 'Reference to the parent MoU, LoA, SoW, or sub-award agreement under which this obligation is defined. Links the obligation to its governing partnership instrument.',
    `achieved_value` DECIMAL(18,2) COMMENT 'Actual quantitative result achieved against the target value at the time of completion or latest reporting. Enables performance tracking and BvA (Budget versus Actual) style analysis for non-financial obligations.',
    `amendment_reference` STRING COMMENT 'Reference number or description of the partnership agreement amendment that introduced or modified this obligation. Null for obligations defined in the original agreement. Supports change management and audit trail.',
    `capacity_building_component` BOOLEAN COMMENT 'Boolean flag indicating whether this obligation includes a capacity building or institutional strengthening component for the partner organization (e.g., training, mentoring, systems development). Supports partner capacity assessment tracking.',
    `cluster_lead_agency` STRING COMMENT 'Name of the OCHA cluster lead agency (e.g., UNICEF for WASH, WFP for Food Security, UNHCR for Shelter) under whose coordination framework this obligation falls. Relevant for obligations arising from cluster coordination commitments.',
    `mou_obligation_code` STRING COMMENT 'Standardized code representing the mou obligation classification or category.',
    `completion_date` DATE COMMENT 'The actual date on which the obligation was fulfilled and accepted by the receiving party. Null if the obligation has not yet been completed. Used to calculate timeliness and compliance metrics.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this obligation record was first created in the data platform. Supports audit trail, data lineage, and compliance with record-keeping requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the financial_value_amount (e.g., USD, EUR, GBP). Required when financial_value_amount is populated.. Valid values are `^[A-Z]{3}$`',
    `days_overdue` STRING COMMENT 'Number of calendar days this obligation is past its due_date without completion, as of the last system refresh. Populated only when obligation_status is overdue. Used for escalation prioritization and partner performance scoring.',
    `mou_obligation_description` STRING COMMENT 'Detailed textual description providing context about the mou obligation.',
    `donor_reference_number` STRING COMMENT 'The donors own reference number or grant award number associated with this obligation, where the obligation is tied to a specific donor-funded grant. Enables traceability from obligation to donor grant for compliance reporting.',
    `due_date` DATE COMMENT 'The agreed deadline by which the obligation must be fulfilled, as specified in the partnership instrument. Drives automated reminders, escalation triggers, and compliance monitoring.',
    `end_date` DATE COMMENT 'Date and time when the end event occurred for this mou obligation.',
    `escalation_date` DATE COMMENT 'Date on which this obligation was formally escalated to senior management, the donor, or a dispute resolution mechanism due to non-fulfillment or contested completion.',
    `escalation_notes` STRING COMMENT 'Free-text narrative documenting the reason for escalation, actions taken, and resolution steps. Captures the escalation history for audit and learning purposes.',
    `escalation_status` STRING COMMENT 'Indicates whether this obligation has been escalated due to non-compliance or dispute: none (no escalation), flagged (internally noted as at-risk), escalated (formally raised to senior management or donor), or resolved (escalation closed after remediation).. Valid values are `none|flagged|escalated|resolved`',
    `evidence_description` STRING COMMENT 'Narrative description of the evidence submitted to demonstrate fulfillment of this obligation (e.g., Quarterly narrative report submitted via email on 2024-03-31, Training attendance register and photos uploaded to SharePoint). Supports audit and compliance review.',
    `evidence_document_reference` STRING COMMENT 'File path, document management system reference, URL, or unique document identifier pointing to the supporting evidence artifact (report, photo, attendance list, financial statement) that demonstrates fulfillment of this obligation.',
    `financial_value_amount` DECIMAL(18,2) COMMENT 'Monetary value associated with this obligation where it involves a financial commitment (e.g., sub-grant tranche disbursement, in-kind contribution valuation, or cost-sharing commitment). Null for non-financial obligations.',
    `geographic_location` STRING COMMENT 'Sub-national geographic scope of the obligation (e.g., region, district, camp, or settlement name) where the deliverable is to be executed. Supports GIS-based field operations monitoring.',
    `indicator_reference` STRING COMMENT 'Reference to the specific KPI or MEL indicator that this obligation contributes to, as defined in the partnerships MEAL framework or donor reporting requirements. Supports DHIS2 indicator tracking and MEL dashboard reporting.',
    `is_critical_obligation` BOOLEAN COMMENT 'Boolean flag indicating whether this obligation is classified as critical to the partnerships core deliverables or donor compliance requirements. Critical obligations trigger priority escalation workflows and are highlighted in SitRep and donor reporting.',
    `is_donor_reportable` BOOLEAN COMMENT 'Boolean flag indicating whether fulfillment of this obligation must be reported to the donor (e.g., USAID BHA, DFID, CERF). Drives inclusion in donor compliance reports and IATI activity updates.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this obligation record was most recently modified. Used for incremental data loading, change detection, and audit trail in the Databricks Silver Layer.',
    `logframe_output_reference` STRING COMMENT 'Reference code or label linking this obligation to a specific output, outcome, or activity in the partnerships Logical Framework (LogFrame) or Theory of Change (ToC). Enables Results-Based Management (RBM) tracking and MEL alignment.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this mou obligation.',
    `mou_obligation_name` STRING COMMENT 'Human-readable name or label for the mou obligation.',
    `notes` STRING COMMENT 'Free-text field for additional context, clarifications, or internal commentary related to this obligation that does not fit into structured fields. Used by partnership managers for operational notes and follow-up actions.',
    `obligation_description` STRING COMMENT 'Detailed narrative description of the obligation, deliverable, or commitment as defined in the partnership instrument. Captures the full scope, quality standards, and acceptance criteria agreed upon by both parties.',
    `obligation_reference_number` STRING COMMENT 'Externally-known alphanumeric code or clause reference identifying this obligation within the partnership instrument (e.g., MOU-2024-001-OBL-03, or clause reference Section 4.2.1). Used in partner communications and compliance reporting.',
    `obligation_status` STRING COMMENT 'Current lifecycle state of the obligation: pending (not yet started), in_progress (work underway), completed (fulfilled and verified), overdue (past due date without completion), waived (formally excused by mutual agreement), or disputed (fulfillment contested by either party).. Valid values are `pending|in_progress|completed|overdue|waived|disputed`',
    `obligation_title` STRING COMMENT 'Short, human-readable title summarizing the obligation or deliverable (e.g., Quarterly Program Progress Report, WASH Training for 50 Community Health Workers). Used in dashboards and partner communications.',
    `obligation_type` STRING COMMENT 'Classification of the obligation by its nature: deliverable (tangible output), reporting (narrative or data submission), financial (fund transfer or accounting), capacity_building (training or institutional strengthening), coordination (attendance at cluster/working group meetings), or compliance (regulatory or donor requirement). [ENUM-REF-CANDIDATE: deliverable|reporting|financial|capacity_building|coordination|compliance — promote to reference product if additional types emerge]. Valid values are `deliverable|reporting|financial|capacity_building|coordination|compliance`',
    `operational_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code identifying the country where this obligation is to be fulfilled. Enables geographic filtering and country-level compliance reporting.. Valid values are `^[A-Z]{3}$`',
    `program_sector` STRING COMMENT 'The humanitarian or development sector to which this obligation relates (e.g., WASH, GBV, Health, Education, Food Security, Shelter, PSS, Nutrition). Aligns with OCHA cluster system and IATI sector codes for cross-program reporting.',
    `recurrence_frequency` STRING COMMENT 'Indicates whether this obligation is a one-time commitment or a recurring one, and if recurring, the frequency: monthly, quarterly, semi_annual, annual, or ad_hoc. Drives automated scheduling of future obligation instances.. Valid values are `one_time|monthly|quarterly|semi_annual|annual|ad_hoc`',
    `reminder_days_before_due` STRING COMMENT 'Number of calendar days before the due_date that an automated reminder notification should be triggered to the responsible focal point and partnership manager. Configurable per obligation based on complexity and risk.',
    `reporting_period_end_date` DATE COMMENT 'End date of the reporting or performance period to which this obligation applies. Together with reporting_period_start_date, defines the window for periodic compliance obligations.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the reporting or performance period to which this obligation applies. Used for periodic obligations (e.g., quarterly reports, monthly financial submissions) to align with donor reporting cycles.',
    `responsible_focal_point_name` STRING COMMENT 'Full name of the individual designated as the primary focal point accountable for fulfilling this obligation on behalf of the responsible party. Used for escalation and follow-up communications.',
    `responsible_party` STRING COMMENT 'Indicates which party bears primary responsibility for fulfilling this obligation: lead_organization (the NGO itself), partner_organization (the CSO, CBO, INGO, or government counterpart), both_parties (joint obligation), or third_party (a designated sub-contractor or consortium member).. Valid values are `lead_organization|partner_organization|both_parties|third_party`',
    `start_date` DATE COMMENT 'Date and time when the start event occurred for this mou obligation.',
    `mou_obligation_status` STRING COMMENT 'Current status indicator for the mou obligation workflow state.',
    `target_unit_of_measure` STRING COMMENT 'Unit of measurement for the target value (e.g., beneficiaries, households, training sessions, metric tons, reports). Required when target_value is populated to give the quantity business meaning.',
    `target_value` DECIMAL(18,2) COMMENT 'Quantitative target associated with this obligation (e.g., number of beneficiaries to be reached, number of training sessions to be conducted, quantity of NFIs to be distributed). Null for qualitative obligations.',
    `verified_by_name` STRING COMMENT 'Full name of the staff member or authorized representative who verified and accepted the fulfillment evidence for this obligation on behalf of the receiving party.',
    `verified_date` DATE COMMENT 'Date on which the receiving party formally verified and accepted the evidence of fulfillment for this obligation. Distinct from completion_date, which is when the responsible party submitted the deliverable.',
    `waiver_justification` STRING COMMENT 'Narrative explanation of why this obligation was formally waived by mutual agreement of both parties. Required when obligation_status is waived. Documents the business rationale for audit and compliance purposes.',
    CONSTRAINT pk_mou_obligation PRIMARY KEY(`mou_obligation_id`)
) COMMENT 'Tracks specific obligations, deliverables, and commitments defined within MoUs and partnership agreements. Captures obligation description, responsible party, due date, completion status, evidence of fulfillment, and escalation status. Enables systematic monitoring of whether both parties are meeting their agreed commitments under each partnership instrument.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` (
    `partner_accreditation_id` BIGINT COMMENT 'Unique system-generated identifier for each partner accreditation record. Primary key for the partner_accreditation data product.',
    `partner_org_id` BIGINT COMMENT 'Reference to the partner organization that holds this accreditation. Links to the partner_org master record.',
    `accreditation_code` STRING COMMENT 'Standardized short code or identifier for the accreditation scheme (e.g., CHS, SPHERE, HAP, ISO9001, ISO27001, NGO-REG). Used for filtering, reporting, and cross-partner comparisons in MEL dashboards.',
    `accreditation_name` STRING COMMENT 'Full descriptive name of the accreditation, certification, or standard (e.g., Core Humanitarian Standard Certification, ISO 9001:2015 Quality Management, Sphere Humanitarian Standards Compliance, HAP Membership, National NGO Registration – Kenya). Human-readable label used in due diligence reports and partner dashboards.',
    `accreditation_score` DECIMAL(18,2) COMMENT 'Numeric score or rating assigned by the accrediting body upon assessment, where applicable (e.g., CHS self-assessment score out of 100, ISO audit score). Null if the accreditation is pass/fail with no numeric score. Used in partner capacity assessment scoring and due diligence risk rating calculations.',
    `accreditation_status` STRING COMMENT 'Current lifecycle status of the accreditation record. active indicates the accreditation is valid and in force; expired indicates the validity period has lapsed; suspended indicates temporary withdrawal by the accrediting body; pending_renewal indicates renewal application submitted; withdrawn indicates permanent revocation; under_review indicates the accrediting body is conducting a review.. Valid values are `active|expired|suspended|pending_renewal|withdrawn|under_review`',
    `accreditation_type` STRING COMMENT 'Broad category of the accreditation record. Distinguishes between formal certifications (e.g., CHS, ISO), membership bodies (e.g., HAP), national NGO registrations, compliance standards (e.g., Sphere), licenses, and awards. [ENUM-REF-CANDIDATE: certification|membership|registration|compliance_standard|license|award — promote to reference product if additional values emerge]. Valid values are `certification|membership|registration|compliance_standard|license|award`',
    `accrediting_body_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the accrediting body is domiciled or where the registration is issued (e.g., CHE for Switzerland-based CHS Alliance, GBR for UK Charity Commission). Supports geographic compliance analysis.. Valid values are `^[A-Z]{3}$`',
    `accrediting_body_name` STRING COMMENT 'Full name of the organization or authority that issued the accreditation or certification (e.g., CHS Alliance, Sphere Association, Bureau Veritas, Kenya NGO Coordination Board, ISO Certification Body). Critical for verification and audit trail purposes.',
    `applicable_standard_version` STRING COMMENT 'Version or edition of the standard or framework against which the accreditation was assessed (e.g., CHS 2018, Sphere 2018, ISO 9001:2015). Important for tracking compliance against evolving standards and identifying partners certified to outdated versions.',
    `assessment_level` STRING COMMENT 'Indicates the rigor and methodology of the accreditation assessment. full denotes a comprehensive third-party audit; partial denotes assessment of selected components; self_assessment denotes partner-reported compliance without external verification; third_party denotes independent external audit; peer_review denotes assessment by peer organizations. Informs the weight given to the accreditation in due diligence scoring.. Valid values are `full|partial|self_assessment|third_party|peer_review`',
    `certificate_number` STRING COMMENT 'Official certificate or registration number issued by the accrediting body. Serves as the externally-known unique identifier for the accreditation document. Used for verification with the issuing body and referenced in due diligence reports and donor compliance submissions.',
    `chs_commitment_level` STRING COMMENT 'For CHS-specific accreditations, records the highest CHS commitment level achieved by the partner organization (Commitments 1–9 per the CHS framework). Null for non-CHS accreditations. Supports CHS-aligned partner quality benchmarking. [ENUM-REF-CANDIDATE: commitment_1|commitment_2|commitment_3|commitment_4|commitment_5|commitment_6|commitment_7|commitment_8|commitment_9 — promote to reference product]. Valid values are `commitment_1|commitment_2|commitment_3|commitment_4|commitment_5|commitment_6`',
    `partner_accreditation_code` STRING COMMENT 'Standardized code representing the partner accreditation classification or category.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this accreditation record was first created in the system. Stored in yyyy-MM-ddTHH:mm:ss.SSSXXX format. Supports audit trail and data lineage requirements.',
    `partner_accreditation_description` STRING COMMENT 'Detailed textual description providing context about the partner accreditation.',
    `document_reference` STRING COMMENT 'File path, document management system reference, or URL pointing to the scanned certificate or official accreditation document stored in Ngos document repository. Enables auditors and compliance staff to retrieve the source document for verification.',
    `document_upload_date` DATE COMMENT 'The date on which the accreditation certificate document was uploaded to Ngos document management system. Used to assess document currency and flag records where the uploaded document may be outdated relative to the most recent renewal. Stored in yyyy-MM-dd format.',
    `donor_reference` STRING COMMENT 'Name or identifier of the donor that mandates this accreditation as a grant or sub-award condition (e.g., USAID/BHA, FCDO, CERF). Populated only when donor_required is True. Supports grant compliance reporting and sub-award management.',
    `donor_required` BOOLEAN COMMENT 'Indicates whether this specific accreditation is required by a donor as a condition of a grant or sub-award agreement. True if mandated by a donor (e.g., USAID, DFID/FCDO, CERF); False otherwise. Supports grant compliance tracking and sub-award due diligence.',
    `due_diligence_weight` DECIMAL(18,2) COMMENT 'Numeric weight assigned to this accreditation in Ngos partner due diligence scoring model (e.g., 0.25 for 25% weight). Reflects the relative importance of this accreditation type in the overall partner risk rating calculation. Configured by the Partnership team in alignment with donor requirements.',
    `end_date` DATE COMMENT 'Date and time when the end event occurred for this partner accreditation.',
    `expiry_date` DATE COMMENT 'The date on which the accreditation, certification, or registration expires and must be renewed. Null for accreditations with no fixed expiry. Used to trigger renewal workflows and flag partners with lapsed credentials in due diligence reviews. Stored in yyyy-MM-dd format.',
    `geographic_applicability` STRING COMMENT 'Country or region where this accreditation is valid and recognized. May be a specific ISO 3166-1 alpha-3 country code (e.g., KEN, ETH), a regional designation, or GLOBAL for internationally recognized accreditations. Supports geographic due diligence and partner deployment decisions.',
    `iati_activity_identifier` STRING COMMENT 'IATI activity identifier associated with the partnership or program context in which this accreditation was assessed or required. Supports IATI-compliant transparency reporting and donor traceability.',
    `is_mandatory_for_partnership` BOOLEAN COMMENT 'Indicates whether this accreditation is a mandatory prerequisite for Ngo to enter into or maintain a partnership agreement with this organization. True if required by Ngos partnership policy, donor conditions, or regulatory requirements; False if optional or informational. Drives partnership eligibility checks.',
    `issue_date` DATE COMMENT 'The date on which the accrediting body formally issued or granted the accreditation, certification, or registration. Marks the start of the accreditations validity period. Stored in yyyy-MM-dd format.',
    `max_possible_score` DECIMAL(18,2) COMMENT 'The maximum score achievable under the accreditation assessment framework, used to contextualize the accreditation_score (e.g., 100 for a percentage-based CHS assessment). Null if the accreditation is pass/fail. Enables normalized cross-partner comparisons.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this partner accreditation.',
    `partner_accreditation_name` STRING COMMENT 'Human-readable name or label for the partner accreditation.',
    `notes` STRING COMMENT 'Free-text field for additional context, conditions, limitations, or observations related to this accreditation record. May include details of any conditions attached to the accreditation, findings from the assessment, or follow-up actions required. Used by partnership officers during due diligence reviews.',
    `renewal_alert_days` STRING COMMENT 'Number of days before the accreditation expiry_date at which an automated renewal alert should be triggered for the partnership management team. Configurable per accreditation type (e.g., 90 days for CHS certification, 30 days for national NGO registration). Supports proactive compliance management.',
    `renewal_date` DATE COMMENT 'The date on which the partner organization submitted or is scheduled to submit a renewal application for this accreditation. Distinct from expiry_date (when it lapses) and issue_date (when originally granted). Supports proactive renewal tracking and partner capacity management workflows.',
    `scope_description` STRING COMMENT 'Narrative description of the scope, coverage, or applicability of the accreditation. Specifies which programs, sectors, geographic areas, or operational activities the accreditation covers (e.g., WASH and shelter programs in East Africa, Financial management systems only). Supports targeted due diligence assessments.',
    `start_date` DATE COMMENT 'Date and time when the start event occurred for this partner accreditation.',
    `partner_accreditation_status` STRING COMMENT 'Current status indicator for the partner accreditation workflow state.',
    `thematic_sector` STRING COMMENT 'The humanitarian or development sector to which this accreditation primarily applies (e.g., WASH, GBV, Health, Education, Shelter, Food Security, PSS). Supports sector-specific partner capability mapping and program design. Uses common humanitarian sector taxonomy aligned with OCHA cluster system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this accreditation record was most recently modified. Stored in yyyy-MM-ddTHH:mm:ss.SSSXXX format. Used for change tracking, data synchronization, and audit trail purposes.',
    `verification_date` DATE COMMENT 'The date on which Ngo staff last verified the accreditation with the issuing body. Used to assess how current the verification is and to schedule re-verification cycles. Stored in yyyy-MM-dd format.',
    `verification_status` STRING COMMENT 'Indicates whether Ngo staff have independently verified the accreditation with the issuing body. verified means the certificate has been confirmed as authentic and current; unverified means no verification has been performed; pending_verification means verification is in progress; verification_failed means the accrediting body could not confirm the certificate. Critical for due diligence quality assurance.. Valid values are `verified|unverified|pending_verification|verification_failed`',
    `verified_by` STRING COMMENT 'Name or staff identifier of the Ngo staff member who performed the most recent verification of this accreditation with the issuing body. Supports audit trail and accountability for due diligence processes.',
    CONSTRAINT pk_partner_accreditation PRIMARY KEY(`partner_accreditation_id`)
) COMMENT 'Tracks formal accreditations, certifications, and standards compliance held by partner organizations including CHS (Core Humanitarian Standard) certification, Sphere compliance, HAP membership, ISO certifications, and national NGO registration status. Captures accreditation body, certificate number, issue date, expiry date, and verification status. Supports due diligence and quality assurance.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` (
    `field_monitoring_visit_id` BIGINT COMMENT 'Unique system-generated identifier for each field monitoring and supportive supervision visit record. Primary key for the field_monitoring_visit data product.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Field monitoring visits verify partner compliance with specific award terms, donor conditions, and programmatic requirements. Award context determines visit scope, checklist items, and whether finding',
    `capacity_building_plan_id` BIGINT COMMENT 'Foreign key linking to partnership.capacity_building_plan. Business justification: field_monitoring_visit has corrective_action_plan_required (BOOLEAN) and corrective_action_plan_status (STRING) but no FK to an actual plan. When field visits identify issues, corrective action plans ',
    `compliance_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.incident. Business justification: Field monitoring visits may identify compliance incidents (fraud, safeguarding violations, financial irregularities). Direct discovery-to-incident link for audit trail. Critical for incident reporting',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Field monitoring visits incur costs (travel, accommodation, per diem, local transport) that must be charged to specific cost centers for expense tracking and budget management. Essential for monitorin',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: Field monitoring visits assess partner implementation quality of specific interventions. Linking visit to intervention enables program-level quality assurance, intervention-specific findings aggregati',
    `it_asset_id` BIGINT COMMENT 'Foreign key linking to technology.it_asset. Business justification: Field monitoring visits use specific equipment (tablets, GPS devices, cameras) for data collection. Linking to it_asset enables equipment accountability, maintenance scheduling, insurance claims for d',
    `partner_org_id` BIGINT COMMENT 'Reference to the implementing partner organization being monitored during this visit. Links to the partner_org master record in the partnership domain.',
    `partnership_agreement_id` BIGINT COMMENT 'Reference to the sub-award agreement, MoU, LoA, or SoW under which this monitoring visit is conducted, linking oversight activity to the specific binding instrument.',
    `prior_visit_field_monitoring_visit_id` BIGINT COMMENT 'Reference to the previous field monitoring visit record for the same partner and site, enabling longitudinal tracking of compliance trends and verification of prior corrective actions.',
    `staff_member_id` BIGINT COMMENT 'Reference to the Ngo staff member who led and is responsible for this field monitoring visit. Links to the workforce staff_member record.',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Volunteers with specialized expertise (technical advisors, monitoring specialists) routinely participate in partner monitoring visits. Standard practice in consortium arrangements and quality assuranc',
    `assets_verified` BOOLEAN COMMENT 'Indicates whether donor-funded assets (equipment, vehicles, NFI stocks, infrastructure) were physically verified against the partners asset register during this monitoring visit.',
    `beneficiaries_interviewed_count` STRING COMMENT 'Number of program beneficiaries or Persons of Concern (PoC) directly interviewed or consulted during the monitoring visit as part of accountability and feedback mechanisms.',
    `field_monitoring_visit_code` STRING COMMENT 'Standardized code representing the field monitoring visit classification or category.',
    `corrective_action_plan_deadline` DATE COMMENT 'Date by which the partner is required to submit or fully implement the Corrective Action Plan (CAP) addressing findings from this monitoring visit.',
    `corrective_action_plan_required` BOOLEAN COMMENT 'Indicates whether the monitoring visit findings require the partner to develop and submit a formal Corrective Action Plan (CAP) to address identified non-compliance issues.',
    `corrective_action_plan_status` STRING COMMENT 'Current status of the Corrective Action Plan (CAP) associated with this monitoring visit, tracking partner response from submission through acceptance.. Valid values are `not_required|pending_submission|submitted|under_review|accepted|overdue`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this field monitoring visit record was first created in the grant management system. Supports audit trail and data lineage requirements.',
    `critical_findings_count` STRING COMMENT 'Number of findings classified as critical severity (requiring immediate corrective action, potential sub-award suspension, or donor notification) identified during the visit.',
    `field_monitoring_visit_description` STRING COMMENT 'Detailed textual description providing context about the field monitoring visit.',
    `donor_notification_required` BOOLEAN COMMENT 'Indicates whether the severity of findings from this monitoring visit triggers a mandatory notification obligation to the prime donor (e.g., USAID, DFID/FCDO, CERF) under the terms of the prime award.',
    `end_date` DATE COMMENT 'Date and time when the end event occurred for this field monitoring visit.',
    `financial_findings_summary` STRING COMMENT 'Narrative description of financial management findings from the spot-check component of the visit, including observations on expenditure documentation, procurement compliance, BvA accuracy, and fund accounting practices.',
    `findings_summary` STRING COMMENT 'Narrative summary of key findings from the monitoring visit, capturing the most significant observations across programmatic, financial, safeguarding, and operational dimensions for inclusion in monitoring reports.',
    `follow_up_visit_due_date` DATE COMMENT 'Target date by which the follow-up verification visit must be completed to confirm corrective action implementation and close outstanding findings.',
    `follow_up_visit_required` BOOLEAN COMMENT 'Indicates whether a subsequent field monitoring visit is required to verify implementation of corrective actions or to conduct additional oversight based on findings from this visit.',
    `hact_assurance_category` STRING COMMENT 'HACT assurance category for this visit (Programmatic Visit, Spot Check, Scheduled Audit, Special Audit).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording the most recent modification to this field monitoring visit record, supporting change tracking and audit compliance.',
    `major_findings_count` STRING COMMENT 'Number of findings classified as major severity (significant non-compliance requiring corrective action within a defined timeframe) identified during the visit.',
    `minor_findings_count` STRING COMMENT 'Number of findings classified as minor severity (observations or recommendations for improvement that do not constitute material non-compliance) identified during the visit.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this field monitoring visit.',
    `monitoring_checklist_version` STRING COMMENT 'Version identifier of the standardized monitoring checklist or tool used during the visit (e.g., KoboToolbox form version, internal checklist version number), ensuring reproducibility and comparability across visits.',
    `field_monitoring_visit_name` STRING COMMENT 'Human-readable name or label for the field monitoring visit.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the field monitoring visit entity.',
    `overall_compliance_rating` STRING COMMENT 'Aggregate compliance rating assigned to the partner following the monitoring visit, summarizing the overall level of adherence to sub-award terms, donor requirements, and organizational standards.. Valid values are `satisfactory|partially_satisfactory|unsatisfactory|critical_non_compliance`',
    `partner_acknowledgement_date` DATE COMMENT 'Date on which the partner organization formally acknowledged receipt of the monitoring visit report and findings, initiating the corrective action response timeline.',
    `partner_rep_name` STRING COMMENT 'Full name of the senior partner organization representative who received the monitoring team and participated in the opening and closing meetings during the visit.',
    `program_sector` STRING COMMENT 'Humanitarian or development sector of the program being monitored (e.g., WASH, GBV, Nutrition, Education, Shelter, Health, Livelihoods, PSS). Aligns with OCHA cluster system and IATI sector codes. [ENUM-REF-CANDIDATE: wash|gbv|nutrition|education|shelter|health|livelihoods|pss|food_security|protection — promote to reference product]',
    `safeguarding_findings_summary` STRING COMMENT 'Narrative description of safeguarding and protection findings from the visit, including observations on GBV prevention measures, child protection protocols, complaint and feedback mechanisms, and CHS compliance.',
    `site_admin1_name` STRING COMMENT 'First-level administrative division (state, province, region, governorate) where the monitored project site is located, aligned with OCHA Common Operational Datasets (COD) administrative boundaries.',
    `site_admin2_name` STRING COMMENT 'Second-level administrative division (district, county, department, woreda) where the monitored project site is located, supporting geographic disaggregation in SitRep and donor reporting.',
    `site_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the country where the monitored project site is located.. Valid values are `^[A-Z]{3}$`',
    `site_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the monitored project site in decimal degrees (WGS84), enabling GIS mapping and spatial analysis of monitoring coverage.',
    `site_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the monitored project site in decimal degrees (WGS84), enabling GIS mapping and spatial analysis of monitoring coverage.',
    `site_name` STRING COMMENT 'Name of the specific partner project site, field office, distribution point, health facility, or community location visited during the monitoring exercise.',
    `staff_interviewed_count` STRING COMMENT 'Number of partner organization staff members interviewed or consulted during the monitoring visit, supporting assessment of organizational capacity and program implementation quality.',
    `start_date` DATE COMMENT 'Date and time when the start event occurred for this field monitoring visit.',
    `field_monitoring_visit_status` STRING COMMENT 'Current status indicator for the field monitoring visit workflow state.',
    `total_findings_count` STRING COMMENT 'Total number of distinct findings documented during the monitoring visit across all severity levels, providing a quantitative measure of monitoring intensity and partner compliance issues.',
    `visit_date` DATE COMMENT 'The actual calendar date on which the field monitoring visit was conducted at the partner project site. Principal real-world event date for this transaction.',
    `visit_end_time` TIMESTAMP COMMENT 'Precise date and time when the field monitoring visit concluded at the partner site, enabling duration tracking and staff time reporting.',
    `visit_purpose` STRING COMMENT 'Primary objective classification of the field monitoring visit. Determines the scope of review activities, checklists applied, and reporting obligations. [ENUM-REF-CANDIDATE: programmatic_monitoring|financial_spot_check|safeguarding_audit|asset_verification|capacity_building|closeout_review — promote to reference product if additional types emerge]. Valid values are `programmatic_monitoring|financial_spot_check|safeguarding_audit|asset_verification|capacity_building|closeout_review`',
    `visit_reference_number` STRING COMMENT 'Externally-known alphanumeric reference code assigned to the visit for tracking in grant management systems, donor reports, and partner correspondence. Format: FMV-YYYY-NNNNNN.. Valid values are `^FMV-[0-9]{4}-[0-9]{6}$`',
    `visit_report_submitted_date` DATE COMMENT 'Date on which the completed field monitoring visit report was formally submitted to the partnership management team and/or uploaded to the grant management system.',
    `visit_report_url` STRING COMMENT 'URL or document management system path to the full field monitoring visit report, including all findings, recommendations, and supporting evidence uploaded to the GMS or document repository.',
    `visit_start_time` TIMESTAMP COMMENT 'Precise date and time when the field monitoring visit commenced at the partner site, used for scheduling, duration calculation, and audit trail purposes.',
    `visit_status` STRING COMMENT 'Current lifecycle state of the field monitoring visit record, tracking progression from planning through completion and any required follow-up actions.. Valid values are `planned|in_progress|completed|cancelled|follow_up_required`',
    `visit_type` STRING COMMENT 'Modality of the monitoring visit indicating whether the partner was notified in advance (announced), visited without prior notice (unannounced), conducted remotely, or performed as a desk review of submitted documentation.. Valid values are `announced|unannounced|remote|desk_review`',
    CONSTRAINT pk_field_monitoring_visit PRIMARY KEY(`field_monitoring_visit_id`)
) COMMENT 'Transactional record for field monitoring and supportive supervision visits conducted by Ngo staff to implementing partner project sites as part of sub-award oversight obligations. Captures visit date, site location, visit purpose (programmatic monitoring, financial spot-check, safeguarding audit, asset verification), findings categorized by severity, recommendations, corrective action plans with deadlines, and follow-up verification status. Distinct from MEL domain programmatic monitoring: this product focuses on partner compliance and sub-award oversight rather than program outcome measurement. Supports donor compliance requirements for partner monitoring under USAID ADS 303 and 2 CFR 200.332.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`partner_compliance` (
    `partner_compliance_id` BIGINT COMMENT 'Unique system-generated surrogate key identifying a partner compliance assignment record. Primary key.',
    `obligation_id` BIGINT COMMENT 'Foreign key to compliance.obligation. Identifies which compliance obligation this partner must fulfill.',
    `partner_org_id` BIGINT COMMENT 'Foreign key to partnership.partner_org. Identifies which partner organization this compliance obligation applies to.',
    `assigned_date` DATE COMMENT 'The date when this obligation was assigned to this partner. Used to track when the compliance requirement became applicable to this partner relationship.',
    `partner_compliance_code` STRING COMMENT 'Standardized code representing the partner compliance classification or category.',
    `completion_date` DATE COMMENT 'The date when this partner successfully completed or submitted this obligation. Null if not yet completed. Used for compliance reporting and performance tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this partner compliance assignment record was first created in the system. Used for audit trail and data lineage.',
    `partner_compliance_description` STRING COMMENT 'Detailed textual description providing context about the partner compliance.',
    `due_date` DATE COMMENT 'The date by which this partner must fulfill this obligation. May differ from the obligations global next_due_date if partner-specific extensions or custom schedules apply. Used for monitoring and escalation.',
    `end_date` DATE COMMENT 'Date and time when the end event occurred for this partner compliance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this partner compliance assignment record was most recently modified. Used for audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this partner compliance.',
    `partner_compliance_name` STRING COMMENT 'Human-readable name or label for the partner compliance.',
    `notes` STRING COMMENT 'Free-text notes specific to this partners fulfillment of this obligation. May include partner-specific instructions, exceptions, submission details, or follow-up actions. Supplements the global obligation notes with partner-specific context.',
    `partner_compliance_status` STRING COMMENT 'Current status of this partners fulfillment of this specific obligation. Tracks lifecycle from assignment through completion. Values: assigned (obligation applies but work not started), in_progress (partner actively working on fulfillment), submitted (partner submitted but pending review), completed (successfully fulfilled), overdue (past due date without completion), waived (obligation waived for this partner), not_applicable (determined not to apply to this partner).',
    `responsible_focal_point` STRING COMMENT 'Name or identifier of the specific individual at the partner organization responsible for fulfilling this obligation. May reference a contact from partner_org embedded contact records or be a free-text name. Used for accountability and follow-up communications.',
    `start_date` DATE COMMENT 'Date and time when the start event occurred for this partner compliance.',
    `waiver_status` STRING COMMENT 'Indicates whether a waiver has been requested or granted for this partner for this obligation. Values: none (no waiver), requested (partner requested waiver, pending decision), approved (waiver granted, obligation does not apply), denied (waiver request rejected, obligation still applies). Used when partners seek exemptions from specific obligations.',
    CONSTRAINT pk_partner_compliance PRIMARY KEY(`partner_compliance_id`)
) COMMENT 'This association product represents the Assignment between partner_org and obligation. It captures the assignment of specific compliance obligations to partner organizations, tracking partner-specific compliance status, responsible focal points, and completion tracking. Each record links one partner organization to one compliance obligation with attributes that exist only in the context of this relationship: which partner must fulfill which obligation, who is responsible, when it is due, and whether it has been completed.. Existence Justification: In nonprofit operations, partner organizations are subject to multiple compliance obligations (IRS filings, donor reporting, audit requirements, registration renewals), and each compliance obligation applies to multiple partner organizations. The NGO actively manages partner compliance tracking as an operational process: assigning obligations to partners, monitoring due dates, tracking completion status, and escalating overdue items. This is not an analytical correlation but an operational business process where compliance officers create, update, and monitor partner-specific compliance assignments.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` (
    `campaign_participation_id` BIGINT COMMENT 'Unique system-generated surrogate key identifying a specific partner organizations participation in a specific advocacy campaign.',
    `advocacy_campaign_id` BIGINT COMMENT 'Foreign key to communication.advocacy_campaign identifying which campaign the partner is participating in.',
    `partner_org_id` BIGINT COMMENT 'Foreign key to partnership.partner_org identifying which partner organization is participating.',
    `partnership_agreement_id` BIGINT COMMENT 'Reference to the governing partnership agreement under which this campaign participation occurs.',
    `actual_reach_count` STRING COMMENT 'Actual number of people reached through this partners campaign participation.',
    `approval_status` STRING COMMENT 'The current approval status of the partner organizations participation in this campaign. Pending indicates invitation sent but not yet confirmed; approved indicates partner has confirmed participation; declined indicates partner declined the invitation; withdrawn indicates partner initially approved but later withdrew. This tracks the lifecycle of each participation relationship.',
    `beneficiary_reach_actual` STRING COMMENT 'Actual number of beneficiaries reached by the partner in this campaign.',
    `beneficiary_reach_target` STRING COMMENT 'Target number of beneficiaries the partner aims to reach through this campaign.',
    `budget_contribution` DECIMAL(18,2) COMMENT 'Financial contribution committed by the partner for this campaign.',
    `campaign_participation_code` STRING COMMENT 'Standardized code representing the campaign participation classification or category.',
    `compliance_verified_flag` BOOLEAN COMMENT 'Whether the partners campaign activities have been verified for compliance with campaign guidelines.',
    `content_approval_status` STRING COMMENT 'Status of content approval for partner-produced campaign materials.',
    `contribution_type` DECIMAL(18,2) COMMENT 'The type of contribution the partner organization provides to this specific campaign. Examples include advocacy (policy influence), content (materials and messaging), funding (financial support), field implementation (on-ground activities), technical expertise (specialized knowledge), media amplification (press and social reach), or coalition building (network mobilization). A partner may have different contribution types across different campaigns.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this participation record was created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO currency code for the budget contribution amount.',
    `deliverables_description` STRING COMMENT 'Description of deliverables the partner is responsible for in this campaign.',
    `campaign_participation_description` STRING COMMENT 'Detailed textual description providing context about the campaign participation.',
    `end_date` DATE COMMENT 'Date and time when the end event occurred for this campaign participation.',
    `events_hosted_count` STRING COMMENT 'Number of campaign events hosted by the partner.',
    `exit_reason` STRING COMMENT 'Reason the partner exited or withdrew from the campaign, if applicable.',
    `geographic_scope` STRING COMMENT 'Geographic scope of the partners participation (e.g., national, regional, local).',
    `inkind_contribution_currency` STRING COMMENT 'Currency code for the in-kind contribution value.',
    `inkind_contribution_value` DECIMAL(18,2) COMMENT 'Monetary value of in-kind contributions provided by the partner for the campaign.',
    `is_lead_partner` BOOLEAN COMMENT 'Whether this partner is the lead coordinating partner for the campaign.',
    `materials_distributed_count` STRING COMMENT 'Number of campaign materials distributed by the partner.',
    `media_channels_used` STRING COMMENT 'Comma-separated list of media channels the partner uses for the campaign (e.g., radio, social media, print).',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this campaign participation.',
    `campaign_participation_name` STRING COMMENT 'Human-readable name or label for the campaign participation.',
    `notes` STRING COMMENT 'Additional notes about the partners campaign participation.',
    `participation_end_date` DATE COMMENT 'The date when the partner organizations active participation in this campaign ended or is planned to end. May differ from the campaign end date if the partners involvement is time-limited. Null for ongoing participation. Used for tracking partner engagement duration and post-campaign evaluation.',
    `participation_start_date` DATE COMMENT 'The date when the partner organizations active participation in this campaign began. May differ from the campaign start date if the partner joined mid-campaign. Used for tracking partner engagement duration and coordination timelines.',
    `partner_role` STRING COMMENT 'The specific role the partner organization plays in this campaign. Distinguishes between lead partners (primary coordinators), supporting partners (secondary contributors), implementing partners (field execution), technical partners (subject matter expertise), financial partners (funding contributors), and media partners (amplification and outreach). This attribute exists only in the context of a specific partner-campaign relationship.',
    `performance_rating` DOUBLE COMMENT 'Performance rating of the partners participation in this campaign.',
    `reporting_frequency` STRING COMMENT 'Frequency at which the partner reports on campaign activities (e.g., weekly, monthly, quarterly).',
    `social_media_impressions` BIGINT COMMENT 'Total social media impressions generated by the partner for the campaign.',
    `staff_assigned_count` STRING COMMENT 'Number of staff assigned by the partner to support this campaign.',
    `start_date` DATE COMMENT 'Date and time when the start event occurred for this campaign participation.',
    `campaign_participation_status` STRING COMMENT 'Current status indicator for the campaign participation workflow state.',
    `target_audience_description` STRING COMMENT 'Description of the target audience the partner is responsible for reaching.',
    `target_reach_count` STRING COMMENT 'Target number of people to be reached through this partners campaign participation.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this participation record was last updated. Used for audit trail and change tracking.',
    `visibility_level` STRING COMMENT 'The level of public visibility and attribution the partner organization receives for their participation in this campaign. Public means prominently featured in campaign materials; acknowledged means listed as a partner but not prominently featured; confidential means partner involvement is tracked internally but not publicly disclosed; anonymous means partner requested no attribution. Visibility level varies by partner preference and campaign context.',
    CONSTRAINT pk_campaign_participation PRIMARY KEY(`campaign_participation_id`)
) COMMENT 'This association product represents the participation relationship between partner organizations and advocacy campaigns. It captures each partners role, contribution type, visibility level, and approval status for their involvement in specific campaigns. Each record links one partner organization to one advocacy campaign with attributes that exist only in the context of this participation relationship. This is the operational record of partner engagement in advocacy, awareness, and fundraising campaigns managed by the communications team.. Existence Justification: In nonprofit operations, partner organizations participate in multiple advocacy campaigns simultaneously (e.g., a CSO may be involved in a humanitarian access campaign, a localization advocacy initiative, and a policy reform campaign at the same time). Each advocacy campaign involves multiple partner organizations with distinct roles (lead, supporting, implementing). The communications team actively manages these participation relationships, tracking each partners role, contribution type, visibility level, and approval status per campaign for coordination, attribution, and reporting purposes.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`consortium_communication` (
    `consortium_communication_id` BIGINT COMMENT 'Primary key for the consortium_communication association',
    `consortium_id` BIGINT COMMENT 'Foreign key linking to the consortium record. Identifies which multi-partner consortium arrangement this communication plan assignment relates to.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to the communication plan record. Identifies which communication plan or deliverable (strategic plan, SitRep, briefing note) is associated with this consortium.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member from this consortium who conducted the review and approval. Captures accountability for consortium governance compliance in joint communications.',
    `approval_authority` STRING COMMENT 'The level of approval authority this consortium holds over the communication plan content. Required indicates consortium steering committee must approve before publication; advisory indicates consortium provides input but does not have veto power; none indicates no formal approval process for this consortium.',
    `assigned_date` DATE COMMENT 'Date when this consortium was formally assigned to or included in the communication plan scope. Used for tracking when consortium coordination requirements were established.',
    `branding_guidelines` STRING COMMENT 'Specific branding and logo usage guidelines for this consortium in the communication plan. Captures consortium logo placement requirements, member organization logo protocols, lead agency branding hierarchy, pooled fund mechanism branding requirements, and any donor-mandated branding restrictions for joint communications.',
    `consortium_communication_code` STRING COMMENT 'Standardized code representing the consortium communication classification or category.',
    `consortium_role` STRING COMMENT 'The specific role this consortium plays in the communication plan execution. Lead_communicator indicates the consortium is the primary author/distributor; contributing_partner indicates input/review responsibilities; review_only indicates approval rights without authorship; information_recipient indicates the consortium receives but does not contribute to the communication.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this consortium communication.',
    `consortium_communication_description` STRING COMMENT 'Detailed textual description providing context about the consortium communication.',
    `end_date` DATE COMMENT 'Date and time when the end event occurred for this consortium communication.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the modified event occurred for this consortium communication.',
    `consortium_communication_name` STRING COMMENT 'Human-readable name or label for the consortium communication.',
    `notes` STRING COMMENT 'Attribute capturing the notes information for the consortium communication entity.',
    `review_completed_date` DATE COMMENT 'Date when this consortium completed its review and approval process for the communication plan. Used for tracking consortium governance cycle times and coordination efficiency.',
    `review_deadline` DATE COMMENT 'Deadline by which this consortium must complete its review and approval process for the communication plan. Critical for time-sensitive humanitarian coordination reporting such as OCHA SitReps and cluster updates.',
    `review_notes` STRING COMMENT 'Free-text notes capturing consortium feedback, revision requests, or approval conditions for the communication plan. Documents consortium steering committee input and ensures transparency in multi-partner coordination.',
    `review_status` STRING COMMENT 'Current status of this consortiums review and approval process for the communication plan. Tracks the workflow state of consortium steering committee review, ensuring governance protocols are followed for multi-partner communications.',
    `start_date` DATE COMMENT 'Date and time when the start event occurred for this consortium communication.',
    `consortium_communication_status` STRING COMMENT 'Current status indicator for the consortium communication workflow state.',
    `visibility_requirements` STRING COMMENT 'Specific visibility and acknowledgment requirements for this consortium in the communication deliverables. Captures donor visibility clauses, OCHA cluster reporting requirements, IASC working group acknowledgment protocols, and Grand Bargain localization visibility commitments that must be reflected in the communication materials.',
    CONSTRAINT pk_consortium_communication PRIMARY KEY(`consortium_communication_id`)
) COMMENT 'This association product represents the assignment of communication plans to consortia in multi-partner humanitarian coordination contexts. It captures the specific role each consortium plays in a communication plan, approval authority for consortium-branded materials, visibility requirements for donor and cluster reporting, branding guidelines for joint communications, and review status for coordinated multi-stakeholder messaging. Each record links one consortium to one communication plan with attributes that exist only in the context of this relationship, supporting Grand Bargain transparency commitments and IASC coordination protocols.. Existence Justification: In humanitarian multi-partner coordination, a single consortium can be referenced in multiple communication plans (donor-specific reports, OCHA SitReps, advocacy campaigns, emergency response briefings), and a single communication plan (especially strategic plans or crisis SitReps) can cover multiple consortia or joint programming arrangements. The business actively manages consortium-specific communication requirements including approval authority, branding protocols, visibility commitments, and review workflows for each consortium-plan combination.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`macro_assessment` (
    `macro_assessment_id` BIGINT COMMENT 'Unique identifier for the macro assessment record.',
    `country_id` BIGINT COMMENT 'Country assessed',
    `assessing_agency` STRING COMMENT 'Attribute capturing the assessing agency information for the macro assessment entity.',
    `assessment_code` STRING COMMENT 'Standardized code representing the assessment classification or category.',
    `assessment_date` DATE COMMENT 'Date of assessment',
    `assessment_summary` STRING COMMENT 'Attribute capturing the assessment summary information for the macro assessment entity.',
    `assessment_title` STRING COMMENT 'Attribute capturing the assessment title information for the macro assessment entity.',
    `assessor_name` STRING COMMENT 'Name of assessor',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this macro assessment.',
    `fiduciary_risk_rating` STRING COMMENT 'Attribute capturing the fiduciary risk rating information for the macro assessment entity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the last modified event occurred for this macro assessment.',
    `overall_risk_rating` STRING COMMENT 'Overall risk rating (Low/Medium/High/Significant)',
    `pfm_risk_rating` STRING COMMENT 'Public Financial Management risk rating',
    `report_url` STRING COMMENT 'Attribute capturing the report url information for the macro assessment entity.',
    `macro_assessment_status` STRING COMMENT 'Current status indicator for the macro assessment workflow state.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the updated event occurred for this macro assessment.',
    `valid_until_date` DATE COMMENT 'Date and time when the valid until event occurred for this macro assessment.',
    `validity_end_date` DATE COMMENT 'Expiry date of assessment',
    CONSTRAINT pk_macro_assessment PRIMARY KEY(`macro_assessment_id`)
) COMMENT 'HACT macro assessment of country public financial management systems';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`micro_assessment` (
    `micro_assessment_id` BIGINT COMMENT 'Unique identifier for the micro assessment record.',
    `macro_assessment_id` BIGINT COMMENT 'Reference identifier linking to the associated macro assessment entity.',
    `partner_org_id` BIGINT COMMENT 'Partner assessed',
    `assessing_firm` STRING COMMENT 'Attribute capturing the assessing firm information for the micro assessment entity.',
    `assessment_code` STRING COMMENT 'Standardized code representing the assessment classification or category.',
    `assessment_date` DATE COMMENT 'Date of assessment',
    `assessor_firm` STRING COMMENT 'Audit firm conducting assessment',
    `assigned_ip_transfer_modality` STRING COMMENT 'IP transfer modality enum: Direct Cash Transfer/Reimbursement/Direct Payment',
    `assurance_activities_required` STRING COMMENT 'Attribute capturing the assurance activities required information for the micro assessment entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this micro assessment.',
    `internal_control_rating` STRING COMMENT 'Attribute capturing the internal control rating information for the micro assessment entity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the last modified event occurred for this micro assessment.',
    `overall_risk_rating` STRING COMMENT 'Low/Moderate/Significant/High risk rating driving transfer modality',
    `programmatic_visits_per_year` STRING COMMENT 'Attribute capturing the programmatic visits per year information for the micro assessment entity.',
    `risk_rating` STRING COMMENT 'Risk rating (Low/Medium/Significant/High) - determines transfer modality',
    `scheduled_audit_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the scheduled audit required condition applies.',
    `spot_checks_per_year` STRING COMMENT 'Attribute capturing the spot checks per year information for the micro assessment entity.',
    `micro_assessment_status` STRING COMMENT 'Current status indicator for the micro assessment workflow state.',
    `transfer_modality` STRING COMMENT 'IP transfer modality enum: Direct Cash Transfer / Reimbursement / Direct Payment',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the updated event occurred for this micro assessment.',
    `valid_until_date` DATE COMMENT 'Date and time when the valid until event occurred for this micro assessment.',
    `validity_end_date` DATE COMMENT 'Expiry date',
    CONSTRAINT pk_micro_assessment PRIMARY KEY(`micro_assessment_id`)
) COMMENT 'HACT micro assessment of implementing partner financial management capacity; determines IP transfer modality';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`programme_visit` (
    `programme_visit_id` BIGINT COMMENT 'Unique identifier for the programme visit record.',
    `intervention_id` BIGINT COMMENT 'Related intervention',
    `micro_assessment_id` BIGINT COMMENT 'Reference identifier linking to the associated micro assessment entity.',
    `partner_org_id` BIGINT COMMENT 'Partner visited',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated programme conducted by staff member entity.',
    `programme_staff_member_id` BIGINT COMMENT 'Staff conducting visit',
    `action_points` STRING COMMENT 'Attribute capturing the action points information for the programme visit entity.',
    `actual_date` DATE COMMENT 'Date and time when the actual event occurred for this programme visit.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this programme visit.',
    `findings` STRING COMMENT 'Key findings',
    `findings_summary` STRING COMMENT 'Attribute capturing the findings summary information for the programme visit entity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the last modified event occurred for this programme visit.',
    `planned_date` DATE COMMENT 'Date and time when the planned event occurred for this programme visit.',
    `programme_visit_status` STRING COMMENT 'Current status indicator for the programme visit workflow state.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the updated event occurred for this programme visit.',
    `visit_code` STRING COMMENT 'Standardized code representing the visit classification or category.',
    `visit_date` DATE COMMENT 'Date of visit',
    `visit_status` STRING COMMENT 'Current status indicator for the visit workflow state.',
    `visit_type` STRING COMMENT 'Type of visit',
    CONSTRAINT pk_programme_visit PRIMARY KEY(`programme_visit_id`)
) COMMENT 'HACT programme visit to implementing partner for assurance activities';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`spot_check` (
    `spot_check_id` BIGINT COMMENT 'Unique identifier for the spot check record.',
    `staff_member_id` BIGINT COMMENT 'Reference identifier linking to the associated conducted by staff member entity.',
    `finance_face_form_id` BIGINT COMMENT 'Reference identifier linking to the associated face form entity.',
    `micro_assessment_id` BIGINT COMMENT 'Reference identifier linking to the associated micro assessment entity.',
    `partner_org_id` BIGINT COMMENT 'Partner checked',
    `actual_date` DATE COMMENT 'Date and time when the actual event occurred for this spot check.',
    `amount_ineligible` STRING COMMENT 'Amount found ineligible',
    `amount_reviewed` DECIMAL(18,2) COMMENT 'Attribute capturing the amount reviewed information for the spot check entity.',
    `amount_tested` STRING COMMENT 'Attribute capturing the amount tested information for the spot check entity.',
    `check_date` DATE COMMENT 'Date of spot check',
    `spot_check_code` STRING COMMENT 'Standardized code representing the spot check classification or category.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this spot check.',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `financial_findings_rating` STRING COMMENT 'Attribute capturing the financial findings rating information for the spot check entity.',
    `findings_count` STRING COMMENT 'Number of findings',
    `findings_summary` STRING COMMENT 'Attribute capturing the findings summary information for the spot check entity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the last modified event occurred for this spot check.',
    `planned_date` DATE COMMENT 'Date and time when the planned event occurred for this spot check.',
    `spot_check_status` STRING COMMENT 'Current status indicator for the spot check workflow state.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the updated event occurred for this spot check.',
    CONSTRAINT pk_spot_check PRIMARY KEY(`spot_check_id`)
) COMMENT 'HACT spot check of implementing partner financial records';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`scheduled_audit` (
    `scheduled_audit_id` BIGINT COMMENT 'Unique identifier for the scheduled audit record.',
    `micro_assessment_id` BIGINT COMMENT 'Reference identifier linking to the associated micro assessment entity.',
    `partner_org_id` BIGINT COMMENT 'Partner audited',
    `actual_date` DATE COMMENT 'Date and time when the actual event occurred for this scheduled audit.',
    `amount_audited` STRING COMMENT 'Attribute capturing the amount audited information for the scheduled audit entity.',
    `amount_ineligible` STRING COMMENT 'Amount found ineligible',
    `audit_code` STRING COMMENT 'Standardized code representing the audit classification or category.',
    `audit_firm` STRING COMMENT 'Attribute capturing the audit firm information for the scheduled audit entity.',
    `audit_opinion` STRING COMMENT 'Attribute capturing the audit opinion information for the scheduled audit entity.',
    `audit_period_end` STRING COMMENT 'Attribute capturing the audit period end information for the scheduled audit entity.',
    `audit_period_end_date` DATE COMMENT 'Date and time when the audit period end event occurred for this scheduled audit.',
    `audit_period_start` STRING COMMENT 'Attribute capturing the audit period start information for the scheduled audit entity.',
    `audit_period_start_date` DATE COMMENT 'Date and time when the audit period start event occurred for this scheduled audit.',
    `audit_type` STRING COMMENT 'Classification type categorizing the audit for this record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this scheduled audit.',
    `currency_code` STRING COMMENT 'Standardized code representing the currency classification or category.',
    `findings_summary` STRING COMMENT 'Attribute capturing the findings summary information for the scheduled audit entity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the last modified event occurred for this scheduled audit.',
    `opinion_type` STRING COMMENT 'Audit opinion type',
    `planned_date` DATE COMMENT 'Date and time when the planned event occurred for this scheduled audit.',
    `questioned_cost_amount` DECIMAL(18,2) COMMENT 'Numeric value representing the questioned cost quantity or measurement.',
    `scheduled_audit_status` STRING COMMENT 'Current status indicator for the scheduled audit workflow state.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the updated event occurred for this scheduled audit.',
    CONSTRAINT pk_scheduled_audit PRIMARY KEY(`scheduled_audit_id`)
) COMMENT 'HACT scheduled audit of implementing partner';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`partnership_face_form` (
    `partnership_face_form_id` BIGINT COMMENT 'Unique identifier for the partnership face form record.',
    `intervention_id` BIGINT COMMENT 'Related intervention',
    `partner_org_id` BIGINT COMMENT 'Partner submitting FACE',
    `amount_authorized` STRING COMMENT 'Attribute capturing the amount authorized information for the partnership face form entity.',
    `amount_liquidated` STRING COMMENT 'Attribute capturing the amount liquidated information for the partnership face form entity.',
    `amount_requested` STRING COMMENT 'Attribute capturing the amount requested information for the partnership face form entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the created event occurred for this partnership face form.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Attribute capturing the outstanding balance information for the partnership face form entity.',
    `reporting_period_end` STRING COMMENT 'Period end',
    `reporting_period_start` STRING COMMENT 'Period start',
    `partnership_face_form_status` STRING COMMENT 'Current status indicator for the partnership face form workflow state.',
    `submission_date` DATE COMMENT 'Date and time when the submission event occurred for this partnership face form.',
    `transfer_modality` STRING COMMENT 'IP transfer modality: Direct Cash Transfer / Reimbursement / Direct Payment',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the updated event occurred for this partnership face form.',
    CONSTRAINT pk_partnership_face_form PRIMARY KEY(`partnership_face_form_id`)
) COMMENT 'HACT FACE (Funding Authorization and Certificate of Expenditures) form for quarterly liquidation';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`partnership`.`agreement` (
    `agreement_id` BIGINT COMMENT 'Primary key for agreement',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Partnership agreements in nonprofit operations typically implement specific grant awards. Tracking which donor award funds each partnership is essential for financial reporting, compliance monitoring,',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Partnership agreements create compliance obligations (donor reporting schedules, regulatory filings, IATI publication requirements). Each agreement generates specific obligations tracked in compliance',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Partnership agreements in nonprofits are funded through specific restricted or unrestricted funds. Financial reporting, fund accounting, and donor compliance require tracking which fund finances each ',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: Partnership agreements are established to implement specific interventions. Linking agreement to intervention enables program-level financial consolidation, results aggregation, donor reporting, and i',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: CRITICAL missing link. Every partnership agreement must reference its partner organization. Currently stores partner_organization_name as denormalized text. Adding partner_org_id FK allows JOIN to par',
    `plan_id` BIGINT COMMENT 'Foreign key linking to communication.communication_plan. Business justification: Major partnership agreements require structured communication plans for launch announcements, milestone updates, and donor visibility requirements. Essential for tracking communication deliverables ti',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Partnership agreements require designated NGO program manager for oversight, amendment approvals, performance review sign-off, and donor reporting accountability. Distinct from partner_org relationshi',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safeguarding.risk_assessment. Business justification: Partnership agreements require safeguarding risk assessments before execution per donor compliance standards (CHS, Grand Bargain). Risk assessment informs partnership approval decisions and monitoring',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Partnership agreements are managed in specific grants management systems (e.g., Salesforce, SAP Grants, custom portals). Tracking the source system is essential for data access control, audit trails, ',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the partnership agreement. draft = under preparation; pending_signature = awaiting execution; active = fully executed and in force; suspended = temporarily halted; expired = past end date without renewal; terminated = ended before expiry; amended = superseded by an amendment. [ENUM-REF-CANDIDATE: draft|pending_signature|active|suspended|expired|terminated|amended — promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the formal inter-organizational legal instrument. MoU = Memorandum of Understanding; LoA = Letter of Agreement; SoW = Scope of Work; sub_award = sub-grant or sub-award agreement; consortium = multi-party consortium agreement; other = any other instrument type. [ENUM-REF-CANDIDATE: MoU|LoA|SoW|sub_award|consortium|framework|other — promote to reference product if additional types are needed]. Valid values are `MoU|LoA|SoW|sub_award|consortium|other`',
    `amendment_date` DATE COMMENT 'Date on which the most recent amendment to the agreement was executed. Null for original agreements with no amendments.',
    `capacity_assessment_date` DATE COMMENT 'Date on which the most recent partner capacity assessment or due diligence review was completed.',
    `capacity_assessment_status` STRING COMMENT 'Status of the partner due diligence and capacity assessment conducted prior to or during the agreement. not_required = exempt; pending = assessment initiated but not complete; completed = assessment passed; failed = partner did not meet threshold; waived = formally waived by authorized approver.. Valid values are `not_required|pending|completed|failed|waived`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the partnership agreement record was first created in the system. Supports audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the funding ceiling and financial obligations under the agreement (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date on which the agreement expires or obligations cease. Nullable for open-ended agreements. Corresponds to the EFFECTIVE_UNTIL category for MASTER_AGREEMENT role.',
    `effective_start_date` DATE COMMENT 'The date on which the agreement becomes legally binding and operational obligations commence. Corresponds to the EFFECTIVE_FROM category for MASTER_AGREEMENT role.',
    `execution_date` DATE COMMENT 'The date on which the agreement was formally signed and executed by all required parties. May differ from the effective start date if the agreement is backdated or has a future commencement.',
    `governing_law_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction whose laws govern the interpretation and enforcement of the agreement (e.g., GBR, USA, CHE).. Valid values are `^[A-Z]{3}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the partnership agreement record was most recently modified. Supports change tracking, audit trail, and incremental data pipeline processing.',
    `operational_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the primary country where the agreements activities are implemented (e.g., SSD, YEM, HTI).. Valid values are `^[A-Z]{3}$`',
    `termination_date` DATE COMMENT 'Actual date on which the agreement was terminated, if terminated before the effective end date. Null for active or expired agreements.',
    CONSTRAINT pk_agreement PRIMARY KEY(`agreement_id`)
) COMMENT 'MVM-tier stub for agreement; the ECM-tier superset is partnership_agreement which contains all attributes from this product plus additional detail columns.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ADD CONSTRAINT `fk_partnership_partnership_agreement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ADD CONSTRAINT `fk_partnership_partnership_agreement_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ADD CONSTRAINT `fk_partnership_capacity_assessment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ADD CONSTRAINT `fk_partnership_capacity_assessment_prior_assessment_capacity_assessment_id` FOREIGN KEY (`prior_assessment_capacity_assessment_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`capacity_assessment`(`capacity_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ADD CONSTRAINT `fk_partnership_due_diligence_record_capacity_assessment_id` FOREIGN KEY (`capacity_assessment_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`capacity_assessment`(`capacity_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ADD CONSTRAINT `fk_partnership_due_diligence_record_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ADD CONSTRAINT `fk_partnership_partner_contact_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ADD CONSTRAINT `fk_partnership_agreement_amendment_partnership_agreement_id` FOREIGN KEY (`partnership_agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partnership_agreement`(`partnership_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ADD CONSTRAINT `fk_partnership_partner_performance_review_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ADD CONSTRAINT `fk_partnership_partner_performance_review_partnership_agreement_id` FOREIGN KEY (`partnership_agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partnership_agreement`(`partnership_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ADD CONSTRAINT `fk_partnership_consortium_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ADD CONSTRAINT `fk_partnership_consortium_partnership_agreement_id` FOREIGN KEY (`partnership_agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partnership_agreement`(`partnership_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ADD CONSTRAINT `fk_partnership_consortium_member_consortium_id` FOREIGN KEY (`consortium_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`consortium`(`consortium_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ADD CONSTRAINT `fk_partnership_consortium_member_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ADD CONSTRAINT `fk_partnership_partner_report_submission_partnership_agreement_id` FOREIGN KEY (`partnership_agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partnership_agreement`(`partnership_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ADD CONSTRAINT `fk_partnership_capacity_building_plan_capacity_assessment_id` FOREIGN KEY (`capacity_assessment_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`capacity_assessment`(`capacity_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ADD CONSTRAINT `fk_partnership_capacity_building_plan_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ADD CONSTRAINT `fk_partnership_capacity_building_activity_capacity_building_plan_id` FOREIGN KEY (`capacity_building_plan_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`capacity_building_plan`(`capacity_building_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ADD CONSTRAINT `fk_partnership_capacity_building_activity_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ADD CONSTRAINT `fk_partnership_partner_risk_register_due_diligence_record_id` FOREIGN KEY (`due_diligence_record_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`due_diligence_record`(`due_diligence_record_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ADD CONSTRAINT `fk_partnership_partner_risk_register_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ADD CONSTRAINT `fk_partnership_mou_obligation_field_monitoring_visit_id` FOREIGN KEY (`field_monitoring_visit_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`field_monitoring_visit`(`field_monitoring_visit_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ADD CONSTRAINT `fk_partnership_mou_obligation_partnership_agreement_id` FOREIGN KEY (`partnership_agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partnership_agreement`(`partnership_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ADD CONSTRAINT `fk_partnership_partner_accreditation_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ADD CONSTRAINT `fk_partnership_field_monitoring_visit_capacity_building_plan_id` FOREIGN KEY (`capacity_building_plan_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`capacity_building_plan`(`capacity_building_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ADD CONSTRAINT `fk_partnership_field_monitoring_visit_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ADD CONSTRAINT `fk_partnership_field_monitoring_visit_partnership_agreement_id` FOREIGN KEY (`partnership_agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partnership_agreement`(`partnership_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ADD CONSTRAINT `fk_partnership_field_monitoring_visit_prior_visit_field_monitoring_visit_id` FOREIGN KEY (`prior_visit_field_monitoring_visit_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`field_monitoring_visit`(`field_monitoring_visit_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_compliance` ADD CONSTRAINT `fk_partnership_partner_compliance_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ADD CONSTRAINT `fk_partnership_campaign_participation_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ADD CONSTRAINT `fk_partnership_campaign_participation_partnership_agreement_id` FOREIGN KEY (`partnership_agreement_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partnership_agreement`(`partnership_agreement_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_communication` ADD CONSTRAINT `fk_partnership_consortium_communication_consortium_id` FOREIGN KEY (`consortium_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`consortium`(`consortium_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`micro_assessment` ADD CONSTRAINT `fk_partnership_micro_assessment_macro_assessment_id` FOREIGN KEY (`macro_assessment_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`macro_assessment`(`macro_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`micro_assessment` ADD CONSTRAINT `fk_partnership_micro_assessment_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`programme_visit` ADD CONSTRAINT `fk_partnership_programme_visit_micro_assessment_id` FOREIGN KEY (`micro_assessment_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`micro_assessment`(`micro_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`programme_visit` ADD CONSTRAINT `fk_partnership_programme_visit_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`spot_check` ADD CONSTRAINT `fk_partnership_spot_check_micro_assessment_id` FOREIGN KEY (`micro_assessment_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`micro_assessment`(`micro_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`spot_check` ADD CONSTRAINT `fk_partnership_spot_check_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`scheduled_audit` ADD CONSTRAINT `fk_partnership_scheduled_audit_micro_assessment_id` FOREIGN KEY (`micro_assessment_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`micro_assessment`(`micro_assessment_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`scheduled_audit` ADD CONSTRAINT `fk_partnership_scheduled_audit_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_face_form` ADD CONSTRAINT `fk_partnership_partnership_face_form_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ADD CONSTRAINT `fk_partnership_agreement_partner_org_id` FOREIGN KEY (`partner_org_id`) REFERENCES `vibe_ngo_v1`.`partnership`.`partner_org`(`partner_org_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`partnership` SET TAGS ('pii_division' = 'business');
ALTER SCHEMA `vibe_ngo_v1`.`partnership` SET TAGS ('pii_domain' = 'partnership');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` SET TAGS ('pii_subdomain' = 'partner_registry');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` SET TAGS ('pii_column_comment_framework' = 'HACT + IATI');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Relationship Manager Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `statutory_registration_id` SET TAGS ('pii_business_glossary_term' = 'Statutory Registration Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `accreditation_status` SET TAGS ('pii_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `accreditation_status` SET TAGS ('pii_value_regex' = 'accredited|provisional|not_accredited|suspended|under_review');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `annual_budget_usd` SET TAGS ('pii_business_glossary_term' = 'Annual Organizational Budget (USD)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `annual_budget_usd` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `authorized_rep_name` SET TAGS ('pii_business_glossary_term' = 'Authorized Representative Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `authorized_rep_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `authorized_rep_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `authorized_rep_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `authorized_rep_title` SET TAGS ('pii_business_glossary_term' = 'Authorized Representative Title');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `bank_country` SET TAGS ('pii_business_glossary_term' = 'Partner Bank Country');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `bank_country` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `bank_country` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `bank_name` SET TAGS ('pii_business_glossary_term' = 'Partner Banking Institution Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `bank_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `bank_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `bank_name` SET TAGS ('pii_type' = 'financial');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `capacity_assessment_date` SET TAGS ('pii_business_glossary_term' = 'Partner Capacity Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `capacity_assessment_score` SET TAGS ('pii_business_glossary_term' = 'Partner Capacity Assessment Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `capacity_assessment_score` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `chs_certified` SET TAGS ('pii_business_glossary_term' = 'Core Humanitarian Standard (CHS) Certification Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `cluster_memberships` SET TAGS ('pii_business_glossary_term' = 'OCHA Cluster Memberships');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `countries_of_operation` SET TAGS ('pii_business_glossary_term' = 'Countries of Operation');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `due_diligence_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Due Diligence Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `due_diligence_status` SET TAGS ('pii_business_glossary_term' = 'Due Diligence Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `due_diligence_status` SET TAGS ('pii_value_regex' = 'completed|in_progress|not_started|expired|waived');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `finance_contact_email` SET TAGS ('pii_business_glossary_term' = 'Finance Officer Email Address');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `finance_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `finance_contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `finance_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `finance_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `founding_year` SET TAGS ('pii_business_glossary_term' = 'Organization Founding Year');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `hact_risk_rating` SET TAGS ('pii_business_glossary_term' = 'HACT Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `hq_address` SET TAGS ('pii_business_glossary_term' = 'Headquarters Mailing Address');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `hq_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `hq_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `hq_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `hq_city` SET TAGS ('pii_business_glossary_term' = 'Headquarters City');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `hq_city` SET TAGS ('pii_type' = 'address');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `hq_country` SET TAGS ('pii_business_glossary_term' = 'Headquarters Country');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `hq_country` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `iati_org_identifier` SET TAGS ('pii_business_glossary_term' = 'International Aid Transparency Initiative (IATI) Organization Identifier');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `ip_transfer_modality` SET TAGS ('pii_business_glossary_term' = 'IP Transfer Modality');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `mission_statement` SET TAGS ('pii_business_glossary_term' = 'Organization Mission Statement');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `partner_org_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `org_acronym` SET TAGS ('pii_business_glossary_term' = 'Organization Acronym');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `org_name` SET TAGS ('pii_business_glossary_term' = 'Organization Legal Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `org_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `org_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `org_type` SET TAGS ('pii_business_glossary_term' = 'Organization Type Classification');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `org_website` SET TAGS ('pii_business_glossary_term' = 'Organization Website URL');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `org_website` SET TAGS ('pii_value_regex' = '^https?://[^s/$.?#].[^s]*$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `partnership_status` SET TAGS ('pii_business_glossary_term' = 'Partnership Lifecycle Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `partnership_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|pending_vetting|blacklisted|archived');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `preferred_language` SET TAGS ('pii_business_glossary_term' = 'Preferred Communication Language');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `preferred_language` SET TAGS ('pii_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_business_glossary_term' = 'Primary Focal Point Email Address');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_business_glossary_term' = 'Primary Focal Point Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Primary Focal Point Phone Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `primary_contact_title` SET TAGS ('pii_business_glossary_term' = 'Primary Focal Point Title');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `sanctions_screen_date` SET TAGS ('pii_business_glossary_term' = 'Sanctions Screening Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `sanctions_screened` SET TAGS ('pii_business_glossary_term' = 'Sanctions Screening Completed Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `staff_count` SET TAGS ('pii_business_glossary_term' = 'Total Staff Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `tax_identifier` SET TAGS ('pii_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `tax_identifier` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `tax_identifier` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `thematic_focus_areas` SET TAGS ('pii_business_glossary_term' = 'Thematic Focus Areas');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_org` ALTER COLUMN `volunteer_count` SET TAGS ('pii_business_glossary_term' = 'Total Volunteer Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` SET TAGS ('pii_subdomain' = 'agreement_governance');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` SET TAGS ('pii_ssot_scope' = 'partner_agreement');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` SET TAGS ('pii_ssot_owner' = 'partnership');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` SET TAGS ('pii_ssot_boundary' = 'partner_agreement');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` SET TAGS ('pii_disambiguated_from' = 'supply.supply_agreement');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` SET TAGS ('pii_ecm_reconciled' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` SET TAGS ('pii_mvm_stub' = 'agreement');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `partnership_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Partnership Agreement ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `obligation_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `finance_fund_id` SET TAGS ('pii_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Program Manager Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `risk_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `agreement_status` SET TAGS ('pii_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `agreement_type` SET TAGS ('pii_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `agreement_type` SET TAGS ('pii_value_regex' = 'MoU|LoA|SoW|sub_award|consortium|other');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `amendment_date` SET TAGS ('pii_business_glossary_term' = 'Amendment Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `amendment_description` SET TAGS ('pii_business_glossary_term' = 'Amendment Description');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `amendment_number` SET TAGS ('pii_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `capacity_assessment_date` SET TAGS ('pii_business_glossary_term' = 'Partner Capacity Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `capacity_assessment_status` SET TAGS ('pii_business_glossary_term' = 'Partner Capacity Assessment Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `capacity_assessment_status` SET TAGS ('pii_value_regex' = 'not_required|pending|completed|failed|waived');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `cluster_lead_agency` SET TAGS ('pii_business_glossary_term' = 'OCHA Cluster Lead Agency');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `disbursed_amount` SET TAGS ('pii_business_glossary_term' = 'Disbursed Amount');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('pii_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('pii_value_regex' = 'negotiation|mediation|arbitration|litigation|other');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `due_diligence_risk_rating` SET TAGS ('pii_business_glossary_term' = 'Due Diligence Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `due_diligence_risk_rating` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `due_diligence_risk_rating` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Agreement Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Agreement Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `execution_date` SET TAGS ('pii_business_glossary_term' = 'Agreement Execution Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `funding_ceiling_amount` SET TAGS ('pii_business_glossary_term' = 'Funding Ceiling Amount');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `funding_ceiling_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `geographic_scope` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `governing_law_country_code` SET TAGS ('pii_business_glossary_term' = 'Governing Law Country Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `governing_law_country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `hact_risk_rating` SET TAGS ('pii_business_glossary_term' = 'HACT Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `iati_activity_identifier` SET TAGS ('pii_business_glossary_term' = 'International Aid Transparency Initiative (IATI) Activity Identifier');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `indirect_cost_rate` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Rate (ICR)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `indirect_cost_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `ip_transfer_modality` SET TAGS ('pii_business_glossary_term' = 'IP Transfer Modality');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `is_consortium_agreement` SET TAGS ('pii_business_glossary_term' = 'Is Consortium Agreement Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `is_sub_award` SET TAGS ('pii_business_glossary_term' = 'Is Sub-Award Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `lead_organization_name` SET TAGS ('pii_business_glossary_term' = 'Lead Organization Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `lead_organization_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `lead_organization_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `liquidated_amount` SET TAGS ('pii_business_glossary_term' = 'Liquidated Amount');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `mvm_migration_reference` SET TAGS ('pii_business_glossary_term' = 'MVM Migration Reference');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `mvm_migration_reference` SET TAGS ('pii_ecm_reconciliation' = 'mvm_stub_agreement');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `partnership_agreement_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `operational_country_code` SET TAGS ('pii_business_glossary_term' = 'Operational Country Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `operational_country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `outstanding_dct_amount` SET TAGS ('pii_business_glossary_term' = 'Outstanding DCT Amount');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `parent_agreement_reference` SET TAGS ('pii_business_glossary_term' = 'Parent Agreement Reference Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `program_sector` SET TAGS ('pii_business_glossary_term' = 'Program Sector');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `reference_number` SET TAGS ('pii_business_glossary_term' = 'Agreement Reference Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `renewal_option` SET TAGS ('pii_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|semi_annual|annual|ad_hoc');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `scope_description` SET TAGS ('pii_business_glossary_term' = 'Agreement Scope Description');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `sdg_alignment_codes` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment Codes');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `signatory_name_lead` SET TAGS ('pii_business_glossary_term' = 'Lead Organization Signatory Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `signatory_name_lead` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `signatory_name_lead` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `signatory_name_lead` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `signatory_name_partner` SET TAGS ('pii_business_glossary_term' = 'Partner Organization Signatory Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `signatory_name_partner` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `signatory_name_partner` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `signatory_name_partner` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Agreement Termination Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('pii_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `termination_reason` SET TAGS ('pii_value_regex' = 'mutual_consent|breach|force_majeure|funding_exhausted|program_closure|other');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `theory_of_change_reference` SET TAGS ('pii_business_glossary_term' = 'Theory of Change (ToC) Reference');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Agreement Title');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `total_budget_amount` SET TAGS ('pii_business_glossary_term' = 'Total Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_agreement` ALTER COLUMN `transfer_modality` SET TAGS ('pii_business_glossary_term' = 'IP Transfer Modality');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` SET TAGS ('pii_subdomain' = 'capacity_development');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `capacity_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Capacity Assessment ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `chs_self_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Chs Self Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Lead Assessor Staff ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `prior_assessment_capacity_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Prior Capacity Assessment ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_date` SET TAGS ('pii_business_glossary_term' = 'Capacity Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_end_date` SET TAGS ('pii_business_glossary_term' = 'Capacity Assessment End Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_location_country` SET TAGS ('pii_business_glossary_term' = 'Assessment Location Country Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_location_country` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_location_country` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_methodology` SET TAGS ('pii_business_glossary_term' = 'Capacity Assessment Methodology');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_methodology` SET TAGS ('pii_value_regex' = 'USAID_OCA|DFID_OCAT|ECHO_PACA|IRC_CCAT|UNDP_CAPACITY_SCORECARD|OTHER');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_reference_code` SET TAGS ('pii_business_glossary_term' = 'Capacity Assessment Reference Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_reference_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2,6}-CA-[0-9]{4}-[0-9]{4,6}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_report_url` SET TAGS ('pii_business_glossary_term' = 'Capacity Assessment Report Document URL');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_report_url` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_scope` SET TAGS ('pii_business_glossary_term' = 'Capacity Assessment Scope');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_scope` SET TAGS ('pii_value_regex' = 'FULL|ABBREVIATED|DESK_REVIEW|FIELD_VISIT');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_start_date` SET TAGS ('pii_business_glossary_term' = 'Capacity Assessment Start Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_status` SET TAGS ('pii_business_glossary_term' = 'Capacity Assessment Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_status` SET TAGS ('pii_value_regex' = 'DRAFT|IN_PROGRESS|COMPLETED|VALIDATED|ARCHIVED');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_tool_version` SET TAGS ('pii_business_glossary_term' = 'Assessment Tool Version');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_type` SET TAGS ('pii_business_glossary_term' = 'Capacity Assessment Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `assessment_type` SET TAGS ('pii_value_regex' = 'PRE_AWARD|PERIODIC|TRIGGERED|CLOSE_OUT');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `capacity_building_plan_required` SET TAGS ('pii_business_glossary_term' = 'Capacity Building Plan Required Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `enhanced_monitoring_required` SET TAGS ('pii_business_glossary_term' = 'Enhanced Monitoring Required Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `financial_mgmt_score` SET TAGS ('pii_business_glossary_term' = 'Financial Management Capacity Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `financial_risk_rating` SET TAGS ('pii_business_glossary_term' = 'Financial Management Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `financial_risk_rating` SET TAGS ('pii_value_regex' = 'LOW|MEDIUM|HIGH|CRITICAL');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `governance_score` SET TAGS ('pii_business_glossary_term' = 'Governance Capacity Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `hr_mgmt_score` SET TAGS ('pii_business_glossary_term' = 'Human Resources (HR) Management Capacity Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `it_systems_score` SET TAGS ('pii_business_glossary_term' = 'Information Technology (IT) Systems Capacity Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `key_findings_summary` SET TAGS ('pii_business_glossary_term' = 'Key Assessment Findings Summary');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `kobo_submission_reference` SET TAGS ('pii_business_glossary_term' = 'KoboToolbox Submission ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `lead_assessor_name` SET TAGS ('pii_business_glossary_term' = 'Lead Assessor Full Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `lead_assessor_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `lead_assessor_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `lead_assessor_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `lead_assessor_organization` SET TAGS ('pii_business_glossary_term' = 'Lead Assessor Organization');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `mel_score` SET TAGS ('pii_business_glossary_term' = 'Monitoring Evaluation and Learning (MEL) Capacity Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `capacity_assessment_name` SET TAGS ('pii_type' = 'address');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `next_assessment_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Capacity Assessment Due Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `overall_risk_rating` SET TAGS ('pii_business_glossary_term' = 'Overall Partner Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `overall_risk_rating` SET TAGS ('pii_value_regex' = 'LOW|MEDIUM|HIGH|CRITICAL');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `overall_score` SET TAGS ('pii_business_glossary_term' = 'Overall Capacity Assessment Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `partner_self_assessment_completed` SET TAGS ('pii_business_glossary_term' = 'Partner Self-Assessment Completed Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `partner_self_assessment_score` SET TAGS ('pii_business_glossary_term' = 'Partner Self-Assessment Overall Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `payment_modality_recommendation` SET TAGS ('pii_business_glossary_term' = 'Recommended Sub-Award Payment Modality');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `procurement_score` SET TAGS ('pii_business_glossary_term' = 'Procurement Capacity Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `program_mgmt_score` SET TAGS ('pii_business_glossary_term' = 'Program Management Capacity Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `recommended_interventions` SET TAGS ('pii_business_glossary_term' = 'Recommended Capacity-Building Interventions');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `score_scale_max` SET TAGS ('pii_business_glossary_term' = 'Assessment Score Scale Maximum');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_assessment` ALTER COLUMN `validation_date` SET TAGS ('pii_business_glossary_term' = 'Assessment Validation Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` SET TAGS ('pii_subdomain' = 'partner_registry');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `due_diligence_record_id` SET TAGS ('pii_business_glossary_term' = 'Due Diligence Record ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `capacity_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Capacity Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `sanctions_screening_id` SET TAGS ('pii_business_glossary_term' = 'Sanctions Screening Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Staff Member ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `aml_cft_check_status` SET TAGS ('pii_business_glossary_term' = 'Anti-Money Laundering and Counter-Financing of Terrorism (AML/CFT) Check Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `aml_cft_check_status` SET TAGS ('pii_value_regex' = 'clear|flagged|pending|not_required');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `anti_terrorism_cert_date` SET TAGS ('pii_business_glossary_term' = 'Anti-Terrorism Certification Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `anti_terrorism_certification` SET TAGS ('pii_business_glossary_term' = 'Anti-Terrorism Certification Obtained');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `chs_cert_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Core Humanitarian Standard (CHS) Certificate Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `chs_certificate_number` SET TAGS ('pii_business_glossary_term' = 'Core Humanitarian Standard (CHS) Certificate Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `chs_certification_status` SET TAGS ('pii_business_glossary_term' = 'Core Humanitarian Standard (CHS) Certification Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `chs_certification_status` SET TAGS ('pii_value_regex' = 'certified|self_assessed|not_assessed|expired');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `completion_date` SET TAGS ('pii_business_glossary_term' = 'Due Diligence Completion Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `conditions_of_approval` SET TAGS ('pii_business_glossary_term' = 'Conditions of Approval');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `debarment_check_date` SET TAGS ('pii_business_glossary_term' = 'Debarment Check Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `debarment_check_status` SET TAGS ('pii_business_glossary_term' = 'Debarment and Suspension Check Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `debarment_check_status` SET TAGS ('pii_value_regex' = 'clear|debarred|suspended|pending');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `diligence_status` SET TAGS ('pii_business_glossary_term' = 'Due Diligence Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `diligence_status` SET TAGS ('pii_value_regex' = 'initiated|in_progress|pending_review|completed|failed|waived');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `diligence_type` SET TAGS ('pii_business_glossary_term' = 'Due Diligence Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `diligence_type` SET TAGS ('pii_value_regex' = 'pre_award|periodic_review|triggered_review|close_out|enhanced_due_diligence');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `financial_audit_opinion` SET TAGS ('pii_business_glossary_term' = 'Financial Audit Opinion');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `financial_audit_opinion` SET TAGS ('pii_value_regex' = 'unqualified|qualified|adverse|disclaimer|not_available');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `financial_audit_reviewed` SET TAGS ('pii_business_glossary_term' = 'Financial Audit Reviewed');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `financial_audit_year` SET TAGS ('pii_business_glossary_term' = 'Financial Audit Year');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `governance_verified` SET TAGS ('pii_business_glossary_term' = 'Governance Structure Verified');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `hap_membership_status` SET TAGS ('pii_business_glossary_term' = 'Humanitarian Accountability Partnership (HAP) Membership Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `hap_membership_status` SET TAGS ('pii_value_regex' = 'member|former_member|not_applicable|pending');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `initiation_date` SET TAGS ('pii_business_glossary_term' = 'Due Diligence Initiation Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `iso_cert_expiry_date` SET TAGS ('pii_business_glossary_term' = 'ISO Certification Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `iso_certification_type` SET TAGS ('pii_business_glossary_term' = 'ISO Certification Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `legal_registration_verified` SET TAGS ('pii_business_glossary_term' = 'Legal Registration Verified');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `due_diligence_record_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Due Diligence Review Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `ngo_registration_country` SET TAGS ('pii_business_glossary_term' = 'NGO Registration Country');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `ngo_registration_country` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `ngo_registration_expiry_date` SET TAGS ('pii_business_glossary_term' = 'NGO Registration Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `ngo_registration_number` SET TAGS ('pii_business_glossary_term' = 'National NGO Registration Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `overall_outcome` SET TAGS ('pii_business_glossary_term' = 'Due Diligence Overall Outcome');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `overall_outcome` SET TAGS ('pii_value_regex' = 'approved|approved_with_conditions|rejected|deferred|inconclusive');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `record_reference_number` SET TAGS ('pii_business_glossary_term' = 'Due Diligence Record Reference Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `record_reference_number` SET TAGS ('pii_value_regex' = '^DDR-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `reviewer_notes` SET TAGS ('pii_business_glossary_term' = 'Due Diligence Reviewer Notes');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `reviewer_notes` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Partner Risk Level');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `risk_score` SET TAGS ('pii_business_glossary_term' = 'Partner Risk Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `safeguarding_policy_verified` SET TAGS ('pii_business_glossary_term' = 'Safeguarding Policy Verified');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `sphere_compliance_status` SET TAGS ('pii_business_glossary_term' = 'Sphere Humanitarian Standards Compliance Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `sphere_compliance_status` SET TAGS ('pii_value_regex' = 'compliant|partial|non_compliant|not_assessed');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`due_diligence_record` ALTER COLUMN `supporting_document_ref` SET TAGS ('pii_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` SET TAGS ('pii_subdomain' = 'partner_registry');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `partner_contact_id` SET TAGS ('pii_business_glossary_term' = 'Partner Contact ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `user_account_id` SET TAGS ('pii_business_glossary_term' = 'User Account Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `cluster_membership` SET TAGS ('pii_business_glossary_term' = 'Cluster Membership');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `consent_date` SET TAGS ('pii_business_glossary_term' = 'Data Consent Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `contact_status` SET TAGS ('pii_business_glossary_term' = 'Partner Contact Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `contact_status` SET TAGS ('pii_value_regex' = 'active|inactive|on_leave|departed|pending_verification');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country of Assignment');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `data_sharing_consent` SET TAGS ('pii_business_glossary_term' = 'Data Sharing Consent Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `department` SET TAGS ('pii_business_glossary_term' = 'Contact Department');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `do_not_contact` SET TAGS ('pii_business_glossary_term' = 'Do Not Contact Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `duty_station` SET TAGS ('pii_business_glossary_term' = 'Duty Station');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Contact Engagement End Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `first_name` SET TAGS ('pii_business_glossary_term' = 'Contact First Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `first_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `first_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `gender` SET TAGS ('pii_business_glossary_term' = 'Contact Gender');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `gender` SET TAGS ('pii_value_regex' = 'male|female|non_binary|prefer_not_to_say');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `gender` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `gender` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `gender` SET TAGS ('pii_type' = 'gender');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `is_authorized_signatory` SET TAGS ('pii_business_glossary_term' = 'Is Authorized Signatory Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `is_financial_authorized` SET TAGS ('pii_business_glossary_term' = 'Is Financially Authorized Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `is_primary_contact` SET TAGS ('pii_business_glossary_term' = 'Is Primary Contact Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `job_title` SET TAGS ('pii_business_glossary_term' = 'Contact Job Title');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `last_interaction_date` SET TAGS ('pii_business_glossary_term' = 'Last Interaction Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `last_name` SET TAGS ('pii_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `last_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `last_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `linkedin_profile` SET TAGS ('pii_business_glossary_term' = 'LinkedIn Profile URL');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `linkedin_profile` SET TAGS ('pii_value_regex' = '^https?://(www.)?linkedin.com/in/[a-zA-Z0-9-_%]+/?$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `linkedin_profile` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `middle_name` SET TAGS ('pii_business_glossary_term' = 'Contact Middle Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `middle_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `middle_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `middle_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `mobile_phone` SET TAGS ('pii_business_glossary_term' = 'Mobile Phone Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `mobile_phone` SET TAGS ('pii_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `mobile_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `mobile_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `mobile_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `partner_contact_name` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `partner_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `nationality` SET TAGS ('pii_business_glossary_term' = 'Contact Nationality');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `nationality` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `nationality` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `nationality` SET TAGS ('pii_type' = 'demographic');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Contact Notes');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `office_address` SET TAGS ('pii_business_glossary_term' = 'Office Address');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `office_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `office_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `office_address` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `office_phone` SET TAGS ('pii_business_glossary_term' = 'Office Phone Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `office_phone` SET TAGS ('pii_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `office_phone` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `office_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `office_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `preferred_contact_channel` SET TAGS ('pii_business_glossary_term' = 'Preferred Contact Channel');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `preferred_contact_channel` SET TAGS ('pii_value_regex' = 'email|phone|mobile|whatsapp|signal');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `preferred_language` SET TAGS ('pii_business_glossary_term' = 'Preferred Language');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `preferred_language` SET TAGS ('pii_value_regex' = '^[a-z]{2,3}(-[A-Z]{2})?$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `primary_email` SET TAGS ('pii_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `primary_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `primary_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `primary_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `primary_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `primary_phone` SET TAGS ('pii_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `primary_phone` SET TAGS ('pii_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `primary_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `primary_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `primary_phone` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `role_type` SET TAGS ('pii_business_glossary_term' = 'Partner Contact Role Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `role_type` SET TAGS ('pii_value_regex' = 'focal_point|authorized_representative|technical_lead|financial_officer|program_manager|legal_signatory');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `salutation` SET TAGS ('pii_business_glossary_term' = 'Contact Salutation');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `salutation` SET TAGS ('pii_value_regex' = 'Mr.|Ms.|Mrs.|Dr.|Prof.');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `secondary_email` SET TAGS ('pii_business_glossary_term' = 'Secondary Email Address');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `secondary_email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `secondary_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `secondary_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `secondary_email` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `secondary_language` SET TAGS ('pii_business_glossary_term' = 'Secondary Language');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `secondary_language` SET TAGS ('pii_value_regex' = '^[a-z]{2,3}(-[A-Z]{2})?$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `skype_handle` SET TAGS ('pii_business_glossary_term' = 'Skype Identifier');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `skype_handle` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `source_system_contact_reference` SET TAGS ('pii_business_glossary_term' = 'Source System Contact Identifier');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Contact Engagement Start Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Contact Verification Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Contact Verification Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_contact` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'verified|pending|failed|not_required');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` SET TAGS ('pii_subdomain' = 'agreement_governance');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `agreement_amendment_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Amendment ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `partnership_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Approver Staff Member ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `amendment_number` SET TAGS ('pii_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `amendment_number` SET TAGS ('pii_value_regex' = '^AMD-[0-9]{4}-[0-9]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `amendment_status` SET TAGS ('pii_business_glossary_term' = 'Amendment Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `amendment_status` SET TAGS ('pii_value_regex' = 'draft|pending_approval|approved|rejected|superseded|withdrawn');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `amendment_title` SET TAGS ('pii_business_glossary_term' = 'Amendment Title');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `amendment_type` SET TAGS ('pii_business_glossary_term' = 'Amendment Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `amendment_type` SET TAGS ('pii_value_regex' = 'scope_change|budget_realignment|no_cost_extension|period_of_performance|signatory_change|other');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `approval_authority` SET TAGS ('pii_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `approved_date` SET TAGS ('pii_business_glossary_term' = 'Amendment Approved Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `beneficiary_target_change` SET TAGS ('pii_business_glossary_term' = 'Beneficiary Target Change Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `budget_change_amount` SET TAGS ('pii_business_glossary_term' = 'Budget Change Amount');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `budget_change_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `clauses_modified` SET TAGS ('pii_business_glossary_term' = 'Clauses Modified');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `document_reference` SET TAGS ('pii_business_glossary_term' = 'Amendment Document Reference');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `donor_approval_reference` SET TAGS ('pii_business_glossary_term' = 'Donor Prior Approval Reference');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `donor_prior_approval_required` SET TAGS ('pii_business_glossary_term' = 'Donor Prior Approval Required Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `execution_date` SET TAGS ('pii_business_glossary_term' = 'Amendment Execution Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `extension_duration_days` SET TAGS ('pii_business_glossary_term' = 'Extension Duration Days');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `geographic_scope_change` SET TAGS ('pii_business_glossary_term' = 'Geographic Scope Change Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `gms_reference` SET TAGS ('pii_business_glossary_term' = 'Grant Management System (GMS) Reference');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `iati_activity_identifier` SET TAGS ('pii_business_glossary_term' = 'International Aid Transparency Initiative (IATI) Activity ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `is_no_cost_extension` SET TAGS ('pii_business_glossary_term' = 'No-Cost Extension Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `justification` SET TAGS ('pii_business_glossary_term' = 'Amendment Justification');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `agreement_amendment_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `ngo_signatory_name` SET TAGS ('pii_business_glossary_term' = 'NGO Signatory Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `ngo_signatory_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `ngo_signatory_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `ngo_signatory_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Amendment Notes');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `original_budget_amount` SET TAGS ('pii_business_glossary_term' = 'Original Agreement Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `original_budget_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `original_end_date` SET TAGS ('pii_business_glossary_term' = 'Original Period of Performance End Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `original_start_date` SET TAGS ('pii_business_glossary_term' = 'Original Period of Performance Start Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `partner_signatory_name` SET TAGS ('pii_business_glossary_term' = 'Partner Signatory Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `partner_signatory_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `partner_signatory_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `partner_signatory_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `revised_beneficiary_target` SET TAGS ('pii_business_glossary_term' = 'Revised Beneficiary Target Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `revised_budget_amount` SET TAGS ('pii_business_glossary_term' = 'Revised Agreement Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `revised_budget_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `revised_end_date` SET TAGS ('pii_business_glossary_term' = 'Revised Period of Performance End Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `revised_start_date` SET TAGS ('pii_business_glossary_term' = 'Revised Period of Performance Start Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `scope_change_description` SET TAGS ('pii_business_glossary_term' = 'Scope Change Description');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `submitted_date` SET TAGS ('pii_business_glossary_term' = 'Amendment Submitted Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement_amendment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` SET TAGS ('pii_subdomain' = 'capacity_development');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `partner_performance_review_id` SET TAGS ('pii_business_glossary_term' = 'Partner Performance Review ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `implementation_plan_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `internal_review_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Review Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `partnership_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `areas_for_improvement` SET TAGS ('pii_business_glossary_term' = 'Areas for Improvement');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `beneficiary_feedback_incorporated` SET TAGS ('pii_business_glossary_term' = 'Beneficiary Feedback Incorporated Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `budget_utilisation_rate` SET TAGS ('pii_business_glossary_term' = 'Budget Utilisation Rate');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `capacity_building_areas` SET TAGS ('pii_business_glossary_term' = 'Capacity Building Areas');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `capacity_building_recommended` SET TAGS ('pii_business_glossary_term' = 'Capacity Building Recommended Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `corrective_action_description` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `corrective_action_due_date` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `corrective_action_required` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `corrective_action_status` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `corrective_action_status` SET TAGS ('pii_value_regex' = 'not_required|pending|in_progress|completed|overdue');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `field_visit_conducted` SET TAGS ('pii_business_glossary_term' = 'Field Visit Conducted Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `financial_accountability_rating` SET TAGS ('pii_business_glossary_term' = 'Financial Accountability Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `financial_accountability_rating` SET TAGS ('pii_value_regex' = 'excellent|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `key_findings_summary` SET TAGS ('pii_business_glossary_term' = 'Key Findings Summary');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `milestone_achievement_rate` SET TAGS ('pii_business_glossary_term' = 'Milestone Achievement Rate');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `milestones_achieved_count` SET TAGS ('pii_business_glossary_term' = 'Achieved Milestones Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `milestones_planned_count` SET TAGS ('pii_business_glossary_term' = 'Planned Milestones Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `partner_performance_review_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `next_review_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `overall_performance_rating` SET TAGS ('pii_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `overall_performance_rating` SET TAGS ('pii_value_regex' = 'excellent|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `overall_performance_score` SET TAGS ('pii_business_glossary_term' = 'Overall Performance Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `partner_acknowledgement_date` SET TAGS ('pii_business_glossary_term' = 'Partner Acknowledgement Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `partner_acknowledgement_received` SET TAGS ('pii_business_glossary_term' = 'Partner Acknowledgement Received Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `partnership_renewal_recommendation` SET TAGS ('pii_business_glossary_term' = 'Partnership Renewal Recommendation');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `partnership_renewal_recommendation` SET TAGS ('pii_value_regex' = 'renew|renew_with_conditions|do_not_renew|under_review');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `programmatic_quality_rating` SET TAGS ('pii_business_glossary_term' = 'Programmatic Quality Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `programmatic_quality_rating` SET TAGS ('pii_value_regex' = 'excellent|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `reporting_compliance_rating` SET TAGS ('pii_business_glossary_term' = 'Reporting Compliance Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `reporting_compliance_rating` SET TAGS ('pii_value_regex' = 'excellent|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `reports_due_count` SET TAGS ('pii_business_glossary_term' = 'Reports Due Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `reports_submitted_count` SET TAGS ('pii_business_glossary_term' = 'Reports Submitted Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `review_date` SET TAGS ('pii_business_glossary_term' = 'Review Conducted Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `review_method` SET TAGS ('pii_business_glossary_term' = 'Review Method');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `review_method` SET TAGS ('pii_value_regex' = 'desk_review|field_visit|joint_review|remote_assessment');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `review_reference_number` SET TAGS ('pii_business_glossary_term' = 'Performance Review Reference Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `review_reference_number` SET TAGS ('pii_value_regex' = '^PPR-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `review_status` SET TAGS ('pii_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `review_status` SET TAGS ('pii_value_regex' = 'draft|in_progress|completed|approved|cancelled');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `review_type` SET TAGS ('pii_business_glossary_term' = 'Review Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `review_type` SET TAGS ('pii_value_regex' = 'scheduled|ad_hoc|triggered|final|mid_term');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Partner Risk Level');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `safeguarding_compliance_rating` SET TAGS ('pii_business_glossary_term' = 'Safeguarding Compliance Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `safeguarding_compliance_rating` SET TAGS ('pii_value_regex' = 'excellent|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_performance_review` ALTER COLUMN `strengths_noted` SET TAGS ('pii_business_glossary_term' = 'Strengths Noted');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` SET TAGS ('pii_subdomain' = 'consortium_coordination');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `consortium_id` SET TAGS ('pii_business_glossary_term' = 'Consortium ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Lead Partner Org Id');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `partner_org_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Ngo Focal Point Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `partnership_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `constituent_id` SET TAGS ('pii_business_glossary_term' = 'Primary Donor Constituent Id');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `constituent_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `constituent_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `single_audit_id` SET TAGS ('pii_business_glossary_term' = 'Single Audit Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `chs_compliance_status` SET TAGS ('pii_business_glossary_term' = 'Core Humanitarian Standard (CHS) Compliance Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `chs_compliance_status` SET TAGS ('pii_value_regex' = 'compliant|partial|non_compliant|under_review|not_assessed');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `consortium_name` SET TAGS ('pii_business_glossary_term' = 'Consortium Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `consortium_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `consortium_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `consortium_type` SET TAGS ('pii_business_glossary_term' = 'Consortium Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `consortium_type` SET TAGS ('pii_value_regex' = 'lead_agency|member|co_implementer|pooled_fund|consortium_of_consortia');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Primary Country Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `decision_making_protocol` SET TAGS ('pii_business_glossary_term' = 'Consortium Decision-Making Protocol');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `decision_making_protocol` SET TAGS ('pii_value_regex' = 'consensus|majority_vote|lead_agency_authority|weighted_vote');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `due_diligence_date` SET TAGS ('pii_business_glossary_term' = 'Due Diligence Completion Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `due_diligence_status` SET TAGS ('pii_business_glossary_term' = 'Partner Due Diligence Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `due_diligence_status` SET TAGS ('pii_value_regex' = 'pending|in_progress|completed|expired');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Consortium End Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `funding_currency` SET TAGS ('pii_business_glossary_term' = 'Consortium Funding Currency');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `funding_currency` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `geographic_scope` SET TAGS ('pii_business_glossary_term' = 'Consortium Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `governance_structure` SET TAGS ('pii_business_glossary_term' = 'Consortium Governance Structure Description');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `grand_bargain_localization` SET TAGS ('pii_business_glossary_term' = 'Grand Bargain Localization Commitment Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `iasc_working_group` SET TAGS ('pii_business_glossary_term' = 'Inter-Agency Standing Committee (IASC) Working Group');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `iati_identifier` SET TAGS ('pii_business_glossary_term' = 'International Aid Transparency Initiative (IATI) Identifier');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `localization_percentage` SET TAGS ('pii_business_glossary_term' = 'Localization Percentage');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `logframe_ref` SET TAGS ('pii_business_glossary_term' = 'Logical Framework (LogFrame) Reference');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `mel_framework_ref` SET TAGS ('pii_business_glossary_term' = 'Monitoring Evaluation and Learning (MEL) Framework Reference');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `member_count` SET TAGS ('pii_business_glossary_term' = 'Consortium Member Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `ngo_funding_share` SET TAGS ('pii_business_glossary_term' = 'Ngo Funding Share Amount');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `ngo_funding_share` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `ngo_role` SET TAGS ('pii_business_glossary_term' = 'Ngo Role in Consortium');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `ngo_role` SET TAGS ('pii_value_regex' = 'lead_agency|sub_partner|co_lead|observer');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Consortium Notes');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `ocha_cluster_alignment` SET TAGS ('pii_business_glossary_term' = 'OCHA Cluster Alignment');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `operational_status` SET TAGS ('pii_business_glossary_term' = 'Consortium Operational Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `operational_status` SET TAGS ('pii_value_regex' = 'pipeline|active|suspended|closed|dissolved');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `pooled_fund_mechanism` SET TAGS ('pii_business_glossary_term' = 'Pooled Fund Mechanism');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `reference_code` SET TAGS ('pii_business_glossary_term' = 'Consortium Reference Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `reference_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]{3,30}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Consortium Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|semi_annual|annual|ad_hoc');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `short_name` SET TAGS ('pii_business_glossary_term' = 'Consortium Short Name / Acronym');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `short_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `short_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Consortium Start Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `steering_committee_composition` SET TAGS ('pii_business_glossary_term' = 'Steering Committee Composition');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `thematic_focus` SET TAGS ('pii_business_glossary_term' = 'Consortium Thematic Focus');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `theory_of_change_ref` SET TAGS ('pii_business_glossary_term' = 'Theory of Change (ToC) Reference');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `total_funding_amount` SET TAGS ('pii_business_glossary_term' = 'Total Consortium Funding Envelope');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `total_funding_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` SET TAGS ('pii_subdomain' = 'consortium_coordination');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `consortium_member_id` SET TAGS ('pii_business_glossary_term' = 'Consortium Member ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `consortium_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `consortium_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `consortium_id` SET TAGS ('pii_business_glossary_term' = 'Consortium ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `capacity_assessment_date` SET TAGS ('pii_business_glossary_term' = 'Capacity Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `capacity_assessment_score` SET TAGS ('pii_business_glossary_term' = 'Capacity Assessment Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `contribution_type` SET TAGS ('pii_business_glossary_term' = 'Contribution Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `cost_share_percentage` SET TAGS ('pii_business_glossary_term' = 'Cost Share Percentage');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `cost_share_required` SET TAGS ('pii_business_glossary_term' = 'Cost Share Required');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `due_diligence_completion_date` SET TAGS ('pii_business_glossary_term' = 'Due Diligence Completion Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `due_diligence_status` SET TAGS ('pii_business_glossary_term' = 'Due Diligence Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `due_diligence_status` SET TAGS ('pii_value_regex' = 'passed|conditional|failed|pending|expired');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `funding_allocation_amount` SET TAGS ('pii_business_glossary_term' = 'Funding Allocation Amount');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `funding_allocation_percentage` SET TAGS ('pii_business_glossary_term' = 'Funding Allocation Percentage');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `funding_currency_code` SET TAGS ('pii_business_glossary_term' = 'Funding Currency Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `funding_currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `geographic_responsibility` SET TAGS ('pii_business_glossary_term' = 'Geographic Responsibility');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `indirect_cost_rate` SET TAGS ('pii_business_glossary_term' = 'Indirect Cost Rate (ICR)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `member_role` SET TAGS ('pii_business_glossary_term' = 'Member Role');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `member_role` SET TAGS ('pii_value_regex' = 'lead|co_implementer|technical_advisor|sub_recipient|associate_member|observer');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `membership_end_date` SET TAGS ('pii_business_glossary_term' = 'Membership End Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `membership_start_date` SET TAGS ('pii_business_glossary_term' = 'Membership Start Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `membership_status` SET TAGS ('pii_business_glossary_term' = 'Membership Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `membership_status` SET TAGS ('pii_value_regex' = 'active|pending|suspended|withdrawn|terminated|inactive');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `consortium_member_name` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `consortium_member_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `performance_rating` SET TAGS ('pii_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `performance_rating` SET TAGS ('pii_value_regex' = 'excellent|satisfactory|needs_improvement|unsatisfactory|not_rated');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `performance_review_date` SET TAGS ('pii_business_glossary_term' = 'Performance Review Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|semi_annual|annual|ad_hoc');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `reporting_template_reference` SET TAGS ('pii_business_glossary_term' = 'Reporting Template Reference');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `risk_mitigation_plan` SET TAGS ('pii_business_glossary_term' = 'Risk Mitigation Plan');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `risk_rating` SET TAGS ('pii_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `risk_rating` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `signing_authority_name` SET TAGS ('pii_business_glossary_term' = 'Signing Authority Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `signing_authority_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `signing_authority_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `signing_authority_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `signing_authority_title` SET TAGS ('pii_business_glossary_term' = 'Signing Authority Title');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `signing_date` SET TAGS ('pii_business_glossary_term' = 'Signing Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `steering_committee_representative` SET TAGS ('pii_business_glossary_term' = 'Steering Committee Representative');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `steering_committee_representative` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `sub_award_agreement_number` SET TAGS ('pii_business_glossary_term' = 'Sub-Award Agreement Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `sub_award_type` SET TAGS ('pii_business_glossary_term' = 'Sub-Award Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `sub_award_type` SET TAGS ('pii_value_regex' = 'sub_grant|sub_contract|mou|loa|sow');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `technical_working_group_participation` SET TAGS ('pii_business_glossary_term' = 'Technical Working Group Participation');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `thematic_responsibility` SET TAGS ('pii_business_glossary_term' = 'Thematic Responsibility');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `voting_rights` SET TAGS ('pii_business_glossary_term' = 'Voting Rights');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_member` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` SET TAGS ('pii_subdomain' = 'consortium_coordination');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `coordination_meeting_id` SET TAGS ('pii_business_glossary_term' = 'Coordination Meeting ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `crisis_communication_id` SET TAGS ('pii_business_glossary_term' = 'Crisis Communication Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Ngo Lead Representative Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `volunteer_id` SET TAGS ('pii_business_glossary_term' = 'Volunteer Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `action_items_summary` SET TAGS ('pii_business_glossary_term' = 'Action Items Summary');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `agenda_document_url` SET TAGS ('pii_business_glossary_term' = 'Agenda Document URL');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `agenda_summary` SET TAGS ('pii_business_glossary_term' = 'Agenda Summary');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `associated_response_plan` SET TAGS ('pii_business_glossary_term' = 'Associated Humanitarian Response Plan');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'Meeting City');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `city` SET TAGS ('pii_type' = 'address');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `cluster_sector` SET TAGS ('pii_business_glossary_term' = 'Cluster or Sector');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Meeting Duration (Minutes)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `end_time` SET TAGS ('pii_business_glossary_term' = 'Meeting End Time');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `follow_up_status` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `follow_up_status` SET TAGS ('pii_value_regex' = 'pending|in_progress|completed|overdue|not_required');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `hosting_organization` SET TAGS ('pii_business_glossary_term' = 'Hosting Organization');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `humanitarian_context` SET TAGS ('pii_business_glossary_term' = 'Humanitarian Context');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `humanitarian_context` SET TAGS ('pii_value_regex' = 'emergency|protracted_crisis|development|recovery|preparedness');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `is_recurring` SET TAGS ('pii_business_glossary_term' = 'Recurring Meeting Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `key_decisions` SET TAGS ('pii_business_glossary_term' = 'Key Decisions');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `language` SET TAGS ('pii_business_glossary_term' = 'Meeting Language');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `language` SET TAGS ('pii_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `location_type` SET TAGS ('pii_business_glossary_term' = 'Meeting Location Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `location_type` SET TAGS ('pii_value_regex' = 'in_person|virtual|hybrid');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `location_type` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `meeting_date` SET TAGS ('pii_business_glossary_term' = 'Meeting Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `meeting_reference_code` SET TAGS ('pii_business_glossary_term' = 'Meeting Reference Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `meeting_reference_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2,10}-MTG-[0-9]{4}-[0-9]{4,6}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `meeting_status` SET TAGS ('pii_business_glossary_term' = 'Meeting Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `meeting_status` SET TAGS ('pii_value_regex' = 'scheduled|completed|cancelled|postponed|draft');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `meeting_title` SET TAGS ('pii_business_glossary_term' = 'Meeting Title');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `meeting_type` SET TAGS ('pii_business_glossary_term' = 'Meeting Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `meeting_type` SET TAGS ('pii_value_regex' = 'cluster|working_group|bilateral|consortium|task_force|inter_agency');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `minutes_document_url` SET TAGS ('pii_business_glossary_term' = 'Meeting Minutes Document URL');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `minutes_recorded` SET TAGS ('pii_business_glossary_term' = 'Meeting Minutes Recorded Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `coordination_meeting_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `next_meeting_date` SET TAGS ('pii_business_glossary_term' = 'Next Meeting Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `ngo_attendees_count` SET TAGS ('pii_business_glossary_term' = 'Ngo Attendees Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `ngo_role` SET TAGS ('pii_business_glossary_term' = 'Ngo Role in Meeting');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Meeting Notes');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `organizations_represented` SET TAGS ('pii_business_glossary_term' = 'Organizations Represented Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `recurrence_frequency` SET TAGS ('pii_business_glossary_term' = 'Recurrence Frequency');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `recurrence_frequency` SET TAGS ('pii_value_regex' = 'weekly|biweekly|monthly|quarterly|ad_hoc');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `related_sitrep_reference` SET TAGS ('pii_business_glossary_term' = 'Related Situation Report (SitRep) Reference');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `sdg_alignment` SET TAGS ('pii_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `series_reference_code` SET TAGS ('pii_business_glossary_term' = 'Meeting Series Reference Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `start_time` SET TAGS ('pii_business_glossary_term' = 'Meeting Start Time');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `total_attendees` SET TAGS ('pii_business_glossary_term' = 'Total Attendees Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `venue_name` SET TAGS ('pii_business_glossary_term' = 'Venue Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `venue_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `venue_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `virtual_platform` SET TAGS ('pii_business_glossary_term' = 'Virtual Meeting Platform');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`coordination_meeting` ALTER COLUMN `virtual_platform` SET TAGS ('pii_value_regex' = 'zoom|teams|webex|google_meet|skype|other');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` SET TAGS ('pii_subdomain' = 'capacity_development');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` SET TAGS ('pii_column_comment_framework' = 'HACT + IATI');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `partner_report_submission_id` SET TAGS ('pii_business_glossary_term' = 'Partner Report Submission ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `budget_plan_id` SET TAGS ('pii_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `journal_entry_id` SET TAGS ('pii_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `partnership_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `regulatory_filing_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `subaward_id` SET TAGS ('pii_business_glossary_term' = 'Subaward Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `acceptance_date` SET TAGS ('pii_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `approved_budget_amount` SET TAGS ('pii_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `approved_budget_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `beneficiaries_reached` SET TAGS ('pii_business_glossary_term' = 'Beneficiaries Reached');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `cluster_sector` SET TAGS ('pii_business_glossary_term' = 'Cluster or Sector');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `days_late` SET TAGS ('pii_business_glossary_term' = 'Days Late');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `document_url` SET TAGS ('pii_business_glossary_term' = 'Report Document URL');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `donor_report_reference` SET TAGS ('pii_business_glossary_term' = 'Donor Report Reference');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `donor_reporting_obligation` SET TAGS ('pii_business_glossary_term' = 'Donor Reporting Obligation Indicator');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Report Due Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `feedback_provided` SET TAGS ('pii_business_glossary_term' = 'Feedback Provided');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `financial_documentation_attached` SET TAGS ('pii_business_glossary_term' = 'Financial Documentation Attached');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `geographic_coverage` SET TAGS ('pii_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `is_late_submission` SET TAGS ('pii_business_glossary_term' = 'Late Submission Indicator');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `mel_indicators_reported` SET TAGS ('pii_business_glossary_term' = 'Monitoring Evaluation and Learning (MEL) Indicators Reported');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `partner_report_submission_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `narrative_summary` SET TAGS ('pii_business_glossary_term' = 'Narrative Summary');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `quality_score` SET TAGS ('pii_business_glossary_term' = 'Report Quality Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `report_period_frequency` SET TAGS ('pii_business_glossary_term' = 'Report Period Frequency');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `report_period_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|semi_annual|annual|ad_hoc');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `report_title` SET TAGS ('pii_business_glossary_term' = 'Report Title');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `report_type` SET TAGS ('pii_business_glossary_term' = 'Report Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `report_type` SET TAGS ('pii_value_regex' = 'narrative|financial|situation_report|post_distribution_monitoring|combined');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `report_version` SET TAGS ('pii_business_glossary_term' = 'Report Version Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `review_completion_date` SET TAGS ('pii_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `review_start_date` SET TAGS ('pii_business_glossary_term' = 'Review Start Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `review_status` SET TAGS ('pii_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `review_status` SET TAGS ('pii_value_regex' = 'pending_review|under_review|feedback_issued|revision_requested|accepted|rejected');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `revision_deadline` SET TAGS ('pii_business_glossary_term' = 'Revision Deadline');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `submission_method` SET TAGS ('pii_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `submission_method` SET TAGS ('pii_value_regex' = 'email|online_portal|gms_upload|hard_copy|kobo_toolbox');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `submission_reference_number` SET TAGS ('pii_business_glossary_term' = 'Submission Reference Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `target_beneficiaries` SET TAGS ('pii_business_glossary_term' = 'Target Beneficiaries');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `total_expenditure_reported` SET TAGS ('pii_business_glossary_term' = 'Total Expenditure Reported');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_report_submission` ALTER COLUMN `total_expenditure_reported` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` SET TAGS ('pii_subdomain' = 'capacity_development');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `capacity_building_plan_id` SET TAGS ('pii_business_glossary_term' = 'Capacity Building Plan ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `budget_id` SET TAGS ('pii_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `capacity_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Capacity Assessment ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Responsible Staff ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `training_program_id` SET TAGS ('pii_business_glossary_term' = 'Training Program Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Plan Approval Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `baseline_capacity_score` SET TAGS ('pii_business_glossary_term' = 'Baseline Capacity Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `capacity_score_scale` SET TAGS ('pii_business_glossary_term' = 'Capacity Score Scale');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `capacity_score_scale` SET TAGS ('pii_value_regex' = '1_to_5|0_to_100|1_to_4|0_to_10');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `chs_standard_aligned` SET TAGS ('pii_business_glossary_term' = 'Core Humanitarian Standard (CHS) Aligned Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `current_capacity_score` SET TAGS ('pii_business_glossary_term' = 'Current Capacity Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `donor_reporting_required` SET TAGS ('pii_business_glossary_term' = 'Donor Reporting Required Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Plan End Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `expenditure_to_date_usd` SET TAGS ('pii_business_glossary_term' = 'Expenditure to Date (USD)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `expenditure_to_date_usd` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `gender_mainstreaming_included` SET TAGS ('pii_business_glossary_term' = 'Gender Mainstreaming Included Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `gender_mainstreaming_included` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `gender_mainstreaming_included` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `gender_mainstreaming_included` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `grand_bargain_commitment_ref` SET TAGS ('pii_business_glossary_term' = 'Grand Bargain Commitment Reference');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `implementation_region` SET TAGS ('pii_business_glossary_term' = 'Implementation Region');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `localization_strategy_aligned` SET TAGS ('pii_business_glossary_term' = 'Localization Strategy Aligned Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `capacity_building_plan_name` SET TAGS ('pii_type' = 'address');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Plan Notes');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `overall_objective` SET TAGS ('pii_business_glossary_term' = 'Overall Capacity Building Objective');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `overall_progress_status` SET TAGS ('pii_business_glossary_term' = 'Overall Progress Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `overall_progress_status` SET TAGS ('pii_value_regex' = 'on_track|delayed|at_risk|completed|not_started');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `partner_focal_point_name` SET TAGS ('pii_business_glossary_term' = 'Partner Focal Point Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `partner_focal_point_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `partner_focal_point_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `partner_focal_point_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `partner_focal_point_title` SET TAGS ('pii_business_glossary_term' = 'Partner Focal Point Job Title');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `plan_reference_code` SET TAGS ('pii_business_glossary_term' = 'Capacity Building Plan Reference Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `plan_reference_code` SET TAGS ('pii_value_regex' = '^CBP-[A-Z0-9]{3,10}-[0-9]{4}-[0-9]{3,6}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_business_glossary_term' = 'Capacity Building Plan Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_value_regex' = 'draft|active|on_hold|completed|cancelled');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `plan_title` SET TAGS ('pii_business_glossary_term' = 'Capacity Building Plan Title');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Capacity Building Plan Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `plan_type` SET TAGS ('pii_value_regex' = 'organizational|technical|financial|governance|mel');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|semi_annual|annual|ad_hoc');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `safeguarding_component_included` SET TAGS ('pii_business_glossary_term' = 'Safeguarding Component Included Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Plan Start Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `target_capacity_score` SET TAGS ('pii_business_glossary_term' = 'Target Capacity Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `targeted_functional_areas` SET TAGS ('pii_business_glossary_term' = 'Targeted Functional Areas');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `theory_of_change_summary` SET TAGS ('pii_business_glossary_term' = 'Theory of Change (ToC) Summary');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `total_activities_completed` SET TAGS ('pii_business_glossary_term' = 'Total Activities Completed');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `total_activities_planned` SET TAGS ('pii_business_glossary_term' = 'Total Activities Planned');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `total_budget_usd` SET TAGS ('pii_business_glossary_term' = 'Total Budget (USD)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `total_budget_usd` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` SET TAGS ('pii_subdomain' = 'capacity_development');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `capacity_building_activity_id` SET TAGS ('pii_business_glossary_term' = 'Capacity Building Activity ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `capacity_building_plan_id` SET TAGS ('pii_business_glossary_term' = 'Capacity Building Plan ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `impact_story_id` SET TAGS ('pii_business_glossary_term' = 'Impact Story Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Facilitator Staff Member ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `volunteer_id` SET TAGS ('pii_business_glossary_term' = 'Volunteer Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `activity_cost_usd` SET TAGS ('pii_business_glossary_term' = 'Activity Cost (USD)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `activity_cost_usd` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `activity_reference_code` SET TAGS ('pii_business_glossary_term' = 'Capacity Building Activity Reference Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `activity_reference_code` SET TAGS ('pii_value_regex' = '^CBA-[A-Z]{2,6}-[0-9]{4}-[0-9]{4,6}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `activity_status` SET TAGS ('pii_business_glossary_term' = 'Capacity Building Activity Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `activity_status` SET TAGS ('pii_value_regex' = 'planned|in_progress|completed|cancelled|postponed');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `activity_title` SET TAGS ('pii_business_glossary_term' = 'Capacity Building Activity Title');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `activity_type` SET TAGS ('pii_business_glossary_term' = 'Capacity Building Activity Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `activity_type` SET TAGS ('pii_value_regex' = 'training|mentoring|technical_assistance|peer_learning|coaching|workshop');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `actual_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `actual_end_date` SET TAGS ('pii_business_glossary_term' = 'Actual End Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `assessment_method` SET TAGS ('pii_business_glossary_term' = 'Assessment Method');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `assessment_method` SET TAGS ('pii_value_regex' = 'written_test|oral_assessment|practical_demonstration|observation|self_assessment|peer_review');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `capacity_domain` SET TAGS ('pii_business_glossary_term' = 'Capacity Domain');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `capacity_domain` SET TAGS ('pii_value_regex' = 'organizational|technical|leadership|financial|operational|advocacy');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `certification_body` SET TAGS ('pii_business_glossary_term' = 'Certification Body');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `completion_rate_pct` SET TAGS ('pii_business_glossary_term' = 'Completion Rate Percentage');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `delivery_mode` SET TAGS ('pii_business_glossary_term' = 'Delivery Mode');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `delivery_mode` SET TAGS ('pii_value_regex' = 'in_person|virtual|hybrid|self_paced');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `duration_hours` SET TAGS ('pii_business_glossary_term' = 'Activity Duration (Hours)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `facilitator_name` SET TAGS ('pii_business_glossary_term' = 'Facilitator Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `facilitator_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `facilitator_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `facilitator_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `facilitator_type` SET TAGS ('pii_business_glossary_term' = 'Facilitator Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `facilitator_type` SET TAGS ('pii_value_regex' = 'internal_staff|external_consultant|peer_organization|un_agency|government');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `feedback_collected` SET TAGS ('pii_business_glossary_term' = 'Feedback Collected Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `female_participants` SET TAGS ('pii_business_glossary_term' = 'Female Participants Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `follow_up_due_date` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `follow_up_required` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `is_certified` SET TAGS ('pii_business_glossary_term' = 'Certification Issued Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `linked_capacity_gap` SET TAGS ('pii_business_glossary_term' = 'Linked Capacity Gap');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `location_name` SET TAGS ('pii_business_glossary_term' = 'Activity Location Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `location_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `location_name` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `male_participants` SET TAGS ('pii_business_glossary_term' = 'Male Participants Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `materials_provided` SET TAGS ('pii_business_glossary_term' = 'Training Materials Provided Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `capacity_building_activity_name` SET TAGS ('pii_type' = 'address');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Activity Notes');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `participant_satisfaction_score` SET TAGS ('pii_business_glossary_term' = 'Participant Satisfaction Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `post_assessment_score` SET TAGS ('pii_business_glossary_term' = 'Post-Assessment Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `pre_assessment_score` SET TAGS ('pii_business_glossary_term' = 'Pre-Assessment Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `scheduled_end_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `scheduled_start_date` SET TAGS ('pii_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `thematic_area` SET TAGS ('pii_business_glossary_term' = 'Thematic Area');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `topics_covered` SET TAGS ('pii_business_glossary_term' = 'Topics Covered');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`capacity_building_activity` ALTER COLUMN `total_participants` SET TAGS ('pii_business_glossary_term' = 'Total Participants');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` SET TAGS ('pii_subdomain' = 'partner_registry');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `partner_risk_register_id` SET TAGS ('pii_business_glossary_term' = 'Partner Risk Register ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `due_diligence_record_id` SET TAGS ('pii_business_glossary_term' = 'Due Diligence Record Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Risk Owner Staff ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `subaward_id` SET TAGS ('pii_business_glossary_term' = 'Sub-Award ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `composite_risk_score` SET TAGS ('pii_business_glossary_term' = 'Composite Risk Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `donor_notification_required` SET TAGS ('pii_business_glossary_term' = 'Donor Notification Required Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `donor_notified_date` SET TAGS ('pii_business_glossary_term' = 'Donor Notified Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `due_diligence_level` SET TAGS ('pii_business_glossary_term' = 'Due Diligence Level');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `due_diligence_level` SET TAGS ('pii_value_regex' = 'standard|enhanced|simplified');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `escalated_to` SET TAGS ('pii_business_glossary_term' = 'Escalated To');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `escalation_date` SET TAGS ('pii_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `escalation_required` SET TAGS ('pii_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `fiduciary_risk_flag` SET TAGS ('pii_business_glossary_term' = 'Fiduciary Risk Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `financial_exposure_usd` SET TAGS ('pii_business_glossary_term' = 'Financial Exposure (USD)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `financial_exposure_usd` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `impact_rating` SET TAGS ('pii_business_glossary_term' = 'Impact Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `inherent_impact_rating` SET TAGS ('pii_business_glossary_term' = 'Inherent Impact Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `inherent_likelihood_rating` SET TAGS ('pii_business_glossary_term' = 'Inherent Likelihood Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `likelihood_rating` SET TAGS ('pii_business_glossary_term' = 'Likelihood Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `mitigation_measures` SET TAGS ('pii_business_glossary_term' = 'Mitigation Measures');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `mitigation_status` SET TAGS ('pii_business_glossary_term' = 'Mitigation Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `mitigation_status` SET TAGS ('pii_value_regex' = 'planned|in_progress|completed|overdue');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `monitoring_frequency` SET TAGS ('pii_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `monitoring_frequency` SET TAGS ('pii_value_regex' = 'weekly|monthly|quarterly|semi_annual|annual|ad_hoc');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `partner_risk_register_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Risk Register Notes');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `oversight_mechanism` SET TAGS ('pii_business_glossary_term' = 'Oversight Mechanism');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `risk_appetite_alignment` SET TAGS ('pii_business_glossary_term' = 'Risk Appetite Alignment');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `risk_appetite_alignment` SET TAGS ('pii_value_regex' = 'within_appetite|at_tolerance|exceeds_appetite');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `risk_category` SET TAGS ('pii_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `risk_category` SET TAGS ('pii_value_regex' = 'fiduciary|programmatic|reputational|safeguarding|compliance');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `risk_closure_date` SET TAGS ('pii_business_glossary_term' = 'Risk Closure Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `risk_description` SET TAGS ('pii_business_glossary_term' = 'Risk Description');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `risk_identification_date` SET TAGS ('pii_business_glossary_term' = 'Risk Identification Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `risk_materialisation_date` SET TAGS ('pii_business_glossary_term' = 'Risk Materialisation Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `risk_materialised` SET TAGS ('pii_business_glossary_term' = 'Risk Materialised Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `risk_owner` SET TAGS ('pii_business_glossary_term' = 'Risk Owner');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `risk_register_code` SET TAGS ('pii_business_glossary_term' = 'Risk Register Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `risk_register_code` SET TAGS ('pii_value_regex' = '^RR-[A-Z]{2,6}-[0-9]{4}-[0-9]{4}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `risk_status` SET TAGS ('pii_business_glossary_term' = 'Risk Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `risk_status` SET TAGS ('pii_value_regex' = 'open|under_review|mitigated|escalated|closed');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `risk_subcategory` SET TAGS ('pii_business_glossary_term' = 'Risk Sub-Category');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `risk_title` SET TAGS ('pii_business_glossary_term' = 'Risk Title');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `safeguarding_risk_flag` SET TAGS ('pii_business_glossary_term' = 'Safeguarding Risk Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_risk_register` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` SET TAGS ('pii_subdomain' = 'agreement_governance');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `mou_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Memorandum of Understanding (MoU) Obligation ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `field_monitoring_visit_id` SET TAGS ('pii_business_glossary_term' = 'Field Monitoring Visit Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `partnership_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Partnership Agreement ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `achieved_value` SET TAGS ('pii_business_glossary_term' = 'Obligation Achieved Value');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `amendment_reference` SET TAGS ('pii_business_glossary_term' = 'Amendment Reference');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `capacity_building_component` SET TAGS ('pii_business_glossary_term' = 'Capacity Building Component Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `cluster_lead_agency` SET TAGS ('pii_business_glossary_term' = 'Cluster Lead Agency');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `completion_date` SET TAGS ('pii_business_glossary_term' = 'Obligation Completion Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `days_overdue` SET TAGS ('pii_business_glossary_term' = 'Days Overdue');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `donor_reference_number` SET TAGS ('pii_business_glossary_term' = 'Donor Reference Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Obligation Due Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `escalation_date` SET TAGS ('pii_business_glossary_term' = 'Escalation Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `escalation_notes` SET TAGS ('pii_business_glossary_term' = 'Escalation Notes');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `escalation_status` SET TAGS ('pii_business_glossary_term' = 'Escalation Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `escalation_status` SET TAGS ('pii_value_regex' = 'none|flagged|escalated|resolved');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `evidence_description` SET TAGS ('pii_business_glossary_term' = 'Evidence of Fulfillment Description');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `evidence_document_reference` SET TAGS ('pii_business_glossary_term' = 'Evidence Document Reference');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `financial_value_amount` SET TAGS ('pii_business_glossary_term' = 'Financial Obligation Value Amount');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `financial_value_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `geographic_location` SET TAGS ('pii_business_glossary_term' = 'Geographic Location');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `geographic_location` SET TAGS ('pii_type' = 'location');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `indicator_reference` SET TAGS ('pii_business_glossary_term' = 'Key Performance Indicator (KPI) Reference');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `is_critical_obligation` SET TAGS ('pii_business_glossary_term' = 'Is Critical Obligation Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `is_donor_reportable` SET TAGS ('pii_business_glossary_term' = 'Is Donor Reportable Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `logframe_output_reference` SET TAGS ('pii_business_glossary_term' = 'Logical Framework (LogFrame) Output Reference');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `mou_obligation_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Obligation Notes');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `obligation_description` SET TAGS ('pii_business_glossary_term' = 'Obligation Description');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `obligation_reference_number` SET TAGS ('pii_business_glossary_term' = 'Obligation Reference Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `obligation_status` SET TAGS ('pii_business_glossary_term' = 'Obligation Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `obligation_status` SET TAGS ('pii_value_regex' = 'pending|in_progress|completed|overdue|waived|disputed');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `obligation_title` SET TAGS ('pii_business_glossary_term' = 'Obligation Title');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `obligation_type` SET TAGS ('pii_business_glossary_term' = 'Obligation Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `obligation_type` SET TAGS ('pii_value_regex' = 'deliverable|reporting|financial|capacity_building|coordination|compliance');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `operational_country_code` SET TAGS ('pii_business_glossary_term' = 'Operational Country Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `operational_country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `program_sector` SET TAGS ('pii_business_glossary_term' = 'Program Sector');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `recurrence_frequency` SET TAGS ('pii_business_glossary_term' = 'Obligation Recurrence Frequency');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `recurrence_frequency` SET TAGS ('pii_value_regex' = 'one_time|monthly|quarterly|semi_annual|annual|ad_hoc');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `reminder_days_before_due` SET TAGS ('pii_business_glossary_term' = 'Reminder Days Before Due Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `responsible_focal_point_name` SET TAGS ('pii_business_glossary_term' = 'Responsible Focal Point Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `responsible_focal_point_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `responsible_focal_point_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `responsible_focal_point_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `responsible_party` SET TAGS ('pii_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `responsible_party` SET TAGS ('pii_value_regex' = 'lead_organization|partner_organization|both_parties|third_party');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `target_unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Target Unit of Measure');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `target_value` SET TAGS ('pii_business_glossary_term' = 'Obligation Target Value');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `verified_by_name` SET TAGS ('pii_business_glossary_term' = 'Verified By Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `verified_by_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `verified_by_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `verified_by_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `verified_date` SET TAGS ('pii_business_glossary_term' = 'Obligation Verified Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`mou_obligation` ALTER COLUMN `waiver_justification` SET TAGS ('pii_business_glossary_term' = 'Waiver Justification');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` SET TAGS ('pii_subdomain' = 'partner_registry');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `partner_accreditation_id` SET TAGS ('pii_business_glossary_term' = 'Partner Accreditation ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `accreditation_code` SET TAGS ('pii_business_glossary_term' = 'Accreditation Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `accreditation_name` SET TAGS ('pii_business_glossary_term' = 'Accreditation Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `accreditation_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `accreditation_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `accreditation_score` SET TAGS ('pii_business_glossary_term' = 'Accreditation Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `accreditation_status` SET TAGS ('pii_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `accreditation_status` SET TAGS ('pii_value_regex' = 'active|expired|suspended|pending_renewal|withdrawn|under_review');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `accreditation_type` SET TAGS ('pii_business_glossary_term' = 'Accreditation Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `accreditation_type` SET TAGS ('pii_value_regex' = 'certification|membership|registration|compliance_standard|license|award');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `accrediting_body_country_code` SET TAGS ('pii_business_glossary_term' = 'Accrediting Body Country Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `accrediting_body_country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `accrediting_body_name` SET TAGS ('pii_business_glossary_term' = 'Accrediting Body Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `accrediting_body_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `accrediting_body_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `applicable_standard_version` SET TAGS ('pii_business_glossary_term' = 'Applicable Standard Version');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `assessment_level` SET TAGS ('pii_business_glossary_term' = 'Assessment Level');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `assessment_level` SET TAGS ('pii_value_regex' = 'full|partial|self_assessment|third_party|peer_review');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `certificate_number` SET TAGS ('pii_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `chs_commitment_level` SET TAGS ('pii_business_glossary_term' = 'Core Humanitarian Standard (CHS) Commitment Level');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `chs_commitment_level` SET TAGS ('pii_value_regex' = 'commitment_1|commitment_2|commitment_3|commitment_4|commitment_5|commitment_6');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `document_reference` SET TAGS ('pii_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `document_upload_date` SET TAGS ('pii_business_glossary_term' = 'Document Upload Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `donor_reference` SET TAGS ('pii_business_glossary_term' = 'Donor Reference');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `donor_required` SET TAGS ('pii_business_glossary_term' = 'Donor Required');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `due_diligence_weight` SET TAGS ('pii_business_glossary_term' = 'Due Diligence Weight');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Accreditation Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `geographic_applicability` SET TAGS ('pii_business_glossary_term' = 'Geographic Applicability');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `iati_activity_identifier` SET TAGS ('pii_business_glossary_term' = 'International Aid Transparency Initiative (IATI) Activity Identifier');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `is_mandatory_for_partnership` SET TAGS ('pii_business_glossary_term' = 'Is Mandatory for Partnership');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `issue_date` SET TAGS ('pii_business_glossary_term' = 'Accreditation Issue Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `max_possible_score` SET TAGS ('pii_business_glossary_term' = 'Maximum Possible Score');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `partner_accreditation_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Accreditation Notes');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `renewal_alert_days` SET TAGS ('pii_business_glossary_term' = 'Renewal Alert Days');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `renewal_date` SET TAGS ('pii_business_glossary_term' = 'Accreditation Renewal Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `scope_description` SET TAGS ('pii_business_glossary_term' = 'Accreditation Scope Description');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `thematic_sector` SET TAGS ('pii_business_glossary_term' = 'Thematic Sector');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'verified|unverified|pending_verification|verification_failed');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_accreditation` ALTER COLUMN `verified_by` SET TAGS ('pii_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` SET TAGS ('pii_subdomain' = 'capacity_development');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `field_monitoring_visit_id` SET TAGS ('pii_business_glossary_term' = 'Field Monitoring Visit ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `capacity_building_plan_id` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `compliance_incident_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `it_asset_id` SET TAGS ('pii_business_glossary_term' = 'It Asset Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `partnership_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Partnership Agreement ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `prior_visit_field_monitoring_visit_id` SET TAGS ('pii_business_glossary_term' = 'Prior Visit ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Lead Monitor Staff ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `volunteer_id` SET TAGS ('pii_business_glossary_term' = 'Volunteer Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `volunteer_id` SET TAGS ('pii_type' = 'personal');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `assets_verified` SET TAGS ('pii_business_glossary_term' = 'Assets Verified Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `beneficiaries_interviewed_count` SET TAGS ('pii_business_glossary_term' = 'Beneficiaries Interviewed Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `corrective_action_plan_deadline` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Deadline');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `corrective_action_plan_required` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan Required Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `corrective_action_plan_status` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan (CAP) Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `corrective_action_plan_status` SET TAGS ('pii_value_regex' = 'not_required|pending_submission|submitted|under_review|accepted|overdue');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `critical_findings_count` SET TAGS ('pii_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `donor_notification_required` SET TAGS ('pii_business_glossary_term' = 'Donor Notification Required Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `financial_findings_summary` SET TAGS ('pii_business_glossary_term' = 'Financial Findings Summary');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `financial_findings_summary` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `findings_summary` SET TAGS ('pii_business_glossary_term' = 'Findings Summary');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `follow_up_visit_due_date` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Visit Due Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `follow_up_visit_required` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Visit Required Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `hact_assurance_category` SET TAGS ('pii_business_glossary_term' = 'HACT Assurance Category');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `major_findings_count` SET TAGS ('pii_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `minor_findings_count` SET TAGS ('pii_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `monitoring_checklist_version` SET TAGS ('pii_business_glossary_term' = 'Monitoring Checklist Version');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `field_monitoring_visit_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `overall_compliance_rating` SET TAGS ('pii_business_glossary_term' = 'Overall Compliance Rating');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `overall_compliance_rating` SET TAGS ('pii_value_regex' = 'satisfactory|partially_satisfactory|unsatisfactory|critical_non_compliance');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `partner_acknowledgement_date` SET TAGS ('pii_business_glossary_term' = 'Partner Acknowledgement Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `partner_rep_name` SET TAGS ('pii_business_glossary_term' = 'Partner Representative Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `partner_rep_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `partner_rep_name` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `partner_rep_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `program_sector` SET TAGS ('pii_business_glossary_term' = 'Program Sector');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `safeguarding_findings_summary` SET TAGS ('pii_business_glossary_term' = 'Safeguarding Findings Summary');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `safeguarding_findings_summary` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `site_admin1_name` SET TAGS ('pii_business_glossary_term' = 'Site Administrative Level 1 Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `site_admin1_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `site_admin1_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `site_admin2_name` SET TAGS ('pii_business_glossary_term' = 'Site Administrative Level 2 Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `site_admin2_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `site_admin2_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `site_country_code` SET TAGS ('pii_business_glossary_term' = 'Site Country Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `site_country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `site_latitude` SET TAGS ('pii_business_glossary_term' = 'Site Latitude Coordinate');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `site_latitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `site_latitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `site_longitude` SET TAGS ('pii_business_glossary_term' = 'Site Longitude Coordinate');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `site_longitude` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `site_longitude` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `site_name` SET TAGS ('pii_business_glossary_term' = 'Project Site Name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `site_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `site_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `staff_interviewed_count` SET TAGS ('pii_business_glossary_term' = 'Partner Staff Interviewed Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `total_findings_count` SET TAGS ('pii_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `visit_date` SET TAGS ('pii_business_glossary_term' = 'Visit Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `visit_end_time` SET TAGS ('pii_business_glossary_term' = 'Visit End Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `visit_purpose` SET TAGS ('pii_business_glossary_term' = 'Visit Purpose');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `visit_purpose` SET TAGS ('pii_value_regex' = 'programmatic_monitoring|financial_spot_check|safeguarding_audit|asset_verification|capacity_building|closeout_review');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `visit_reference_number` SET TAGS ('pii_business_glossary_term' = 'Field Monitoring Visit Reference Number');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `visit_reference_number` SET TAGS ('pii_value_regex' = '^FMV-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `visit_report_submitted_date` SET TAGS ('pii_business_glossary_term' = 'Visit Report Submitted Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `visit_report_url` SET TAGS ('pii_business_glossary_term' = 'Visit Report Document URL');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `visit_report_url` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `visit_start_time` SET TAGS ('pii_business_glossary_term' = 'Visit Start Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `visit_status` SET TAGS ('pii_business_glossary_term' = 'Visit Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `visit_status` SET TAGS ('pii_value_regex' = 'planned|in_progress|completed|cancelled|follow_up_required');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `visit_type` SET TAGS ('pii_business_glossary_term' = 'Visit Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`field_monitoring_visit` ALTER COLUMN `visit_type` SET TAGS ('pii_value_regex' = 'announced|unannounced|remote|desk_review');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_compliance` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_compliance` SET TAGS ('pii_subdomain' = 'agreement_governance');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_compliance` SET TAGS ('pii_association_edges' = 'partnership.partner_org,compliance.obligation');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_compliance` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_compliance` SET TAGS ('pii_mvm' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_compliance` ALTER COLUMN `partner_compliance_id` SET TAGS ('pii_business_glossary_term' = 'Partner Compliance Assignment ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_compliance` ALTER COLUMN `obligation_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Obligation ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_compliance` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_compliance` ALTER COLUMN `assigned_date` SET TAGS ('pii_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_compliance` ALTER COLUMN `completion_date` SET TAGS ('pii_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_compliance` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_compliance` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Partner-Specific Due Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_compliance` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Update Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_compliance` ALTER COLUMN `partner_compliance_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_compliance` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Partner Compliance Notes');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_compliance` ALTER COLUMN `partner_compliance_status` SET TAGS ('pii_business_glossary_term' = 'Partner Compliance Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_compliance` ALTER COLUMN `responsible_focal_point` SET TAGS ('pii_business_glossary_term' = 'Responsible Focal Point');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partner_compliance` ALTER COLUMN `waiver_status` SET TAGS ('pii_business_glossary_term' = 'Waiver Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` SET TAGS ('pii_subdomain' = 'consortium_coordination');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` SET TAGS ('pii_association_edges' = 'partnership.partner_org,communication.advocacy_campaign');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ALTER COLUMN `campaign_participation_id` SET TAGS ('pii_business_glossary_term' = 'Campaign Participation ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ALTER COLUMN `advocacy_campaign_id` SET TAGS ('pii_business_glossary_term' = 'Advocacy Campaign ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ALTER COLUMN `partnership_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Partnership Agreement');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ALTER COLUMN `actual_reach_count` SET TAGS ('pii_business_glossary_term' = 'Actual reach count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Participation Approval Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ALTER COLUMN `compliance_verified_flag` SET TAGS ('pii_business_glossary_term' = 'Compliance Verified Flag');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ALTER COLUMN `content_approval_status` SET TAGS ('pii_business_glossary_term' = 'Content Approval Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ALTER COLUMN `contribution_type` SET TAGS ('pii_business_glossary_term' = 'Partner Contribution Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ALTER COLUMN `events_hosted_count` SET TAGS ('pii_business_glossary_term' = 'Events Hosted Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ALTER COLUMN `exit_reason` SET TAGS ('pii_business_glossary_term' = 'Exit Reason');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ALTER COLUMN `inkind_contribution_currency` SET TAGS ('pii_business_glossary_term' = 'In-Kind Contribution Currency');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ALTER COLUMN `inkind_contribution_value` SET TAGS ('pii_business_glossary_term' = 'In-Kind Contribution Value');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ALTER COLUMN `materials_distributed_count` SET TAGS ('pii_business_glossary_term' = 'Materials Distributed Count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ALTER COLUMN `media_channels_used` SET TAGS ('pii_business_glossary_term' = 'Media Channels Used');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ALTER COLUMN `campaign_participation_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ALTER COLUMN `participation_end_date` SET TAGS ('pii_business_glossary_term' = 'Participation End Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ALTER COLUMN `participation_start_date` SET TAGS ('pii_business_glossary_term' = 'Participation Start Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ALTER COLUMN `partner_role` SET TAGS ('pii_business_glossary_term' = 'Partner Role in Campaign');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ALTER COLUMN `reporting_frequency` SET TAGS ('pii_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ALTER COLUMN `social_media_impressions` SET TAGS ('pii_business_glossary_term' = 'Social Media Impressions');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ALTER COLUMN `target_audience_description` SET TAGS ('pii_business_glossary_term' = 'Target Audience Description');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ALTER COLUMN `target_reach_count` SET TAGS ('pii_business_glossary_term' = 'Target reach count');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`campaign_participation` ALTER COLUMN `visibility_level` SET TAGS ('pii_business_glossary_term' = 'Partner Visibility Level');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_communication` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_communication` SET TAGS ('pii_subdomain' = 'consortium_coordination');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_communication` SET TAGS ('pii_association_edges' = 'partnership.consortium,communication.communication_plan');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_communication` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_communication` ALTER COLUMN `consortium_communication_id` SET TAGS ('pii_business_glossary_term' = 'Consortium Communication - Consortium Communication Id');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_communication` ALTER COLUMN `consortium_id` SET TAGS ('pii_business_glossary_term' = 'Consortium Communication - Consortium Id');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_communication` ALTER COLUMN `plan_id` SET TAGS ('pii_business_glossary_term' = 'Consortium Communication - Communication Plan Id');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_communication` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Reviewer Staff Member');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_communication` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_communication` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_communication` ALTER COLUMN `approval_authority` SET TAGS ('pii_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_communication` ALTER COLUMN `assigned_date` SET TAGS ('pii_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_communication` ALTER COLUMN `branding_guidelines` SET TAGS ('pii_business_glossary_term' = 'Branding Guidelines');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_communication` ALTER COLUMN `consortium_role` SET TAGS ('pii_business_glossary_term' = 'Consortium Communication Role');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_communication` ALTER COLUMN `consortium_communication_name` SET TAGS ('pii_type' = 'name');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_communication` ALTER COLUMN `review_completed_date` SET TAGS ('pii_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_communication` ALTER COLUMN `review_deadline` SET TAGS ('pii_business_glossary_term' = 'Review Deadline');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_communication` ALTER COLUMN `review_notes` SET TAGS ('pii_business_glossary_term' = 'Review Notes');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_communication` ALTER COLUMN `review_status` SET TAGS ('pii_business_glossary_term' = 'Consortium Review Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`consortium_communication` ALTER COLUMN `visibility_requirements` SET TAGS ('pii_business_glossary_term' = 'Visibility Requirements');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`macro_assessment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`macro_assessment` SET TAGS ('pii_subdomain' = 'partner_registry');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`macro_assessment` SET TAGS ('pii_hact' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`macro_assessment` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`macro_assessment` ALTER COLUMN `assessor_name` SET TAGS ('pii_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`macro_assessment` ALTER COLUMN `assessor_name` SET TAGS ('pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`micro_assessment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`micro_assessment` SET TAGS ('pii_subdomain' = 'partner_registry');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`micro_assessment` SET TAGS ('pii_hact' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`micro_assessment` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`programme_visit` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`programme_visit` SET TAGS ('pii_subdomain' = 'capacity_development');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`programme_visit` SET TAGS ('pii_hact' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`programme_visit` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`programme_visit` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`programme_visit` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`programme_visit` ALTER COLUMN `programme_staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`programme_visit` ALTER COLUMN `programme_staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`spot_check` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`spot_check` SET TAGS ('pii_subdomain' = 'capacity_development');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`spot_check` SET TAGS ('pii_hact' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`spot_check` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`spot_check` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`spot_check` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`scheduled_audit` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`scheduled_audit` SET TAGS ('pii_subdomain' = 'capacity_development');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`scheduled_audit` SET TAGS ('pii_hact' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`scheduled_audit` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_face_form` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_face_form` SET TAGS ('pii_subdomain' = 'capacity_development');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_face_form` SET TAGS ('pii_hact' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`partnership_face_form` SET TAGS ('pii_tier' = 'mvm');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` SET TAGS ('pii_subdomain' = 'agreement_governance');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` SET TAGS ('pii_tier' = 'MVM');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` SET TAGS ('pii_ecm_superset' = 'partnership_agreement');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `award_id` SET TAGS ('pii_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `obligation_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `finance_fund_id` SET TAGS ('pii_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `intervention_id` SET TAGS ('pii_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `partner_org_id` SET TAGS ('pii_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `plan_id` SET TAGS ('pii_business_glossary_term' = 'Communication Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `staff_member_id` SET TAGS ('pii_business_glossary_term' = 'Program Manager Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `staff_member_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `staff_member_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `risk_assessment_id` SET TAGS ('pii_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `system_platform_id` SET TAGS ('pii_business_glossary_term' = 'System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('pii_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `agreement_type` SET TAGS ('pii_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `agreement_type` SET TAGS ('pii_value_regex' = 'MoU|LoA|SoW|sub_award|consortium|other');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `amendment_date` SET TAGS ('pii_business_glossary_term' = 'Amendment Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `capacity_assessment_date` SET TAGS ('pii_business_glossary_term' = 'Partner Capacity Assessment Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `capacity_assessment_status` SET TAGS ('pii_business_glossary_term' = 'Partner Capacity Assessment Status');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `capacity_assessment_status` SET TAGS ('pii_value_regex' = 'not_required|pending|completed|failed|waived');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Agreement Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Agreement Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `execution_date` SET TAGS ('pii_business_glossary_term' = 'Agreement Execution Date');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `governing_law_country_code` SET TAGS ('pii_business_glossary_term' = 'Governing Law Country Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `governing_law_country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `operational_country_code` SET TAGS ('pii_business_glossary_term' = 'Operational Country Code');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `operational_country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`partnership`.`agreement` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Agreement Termination Date');
