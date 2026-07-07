-- Schema for Domain: pharmacy | Business: Health_Insurance | Version: v2_mvm
-- Generated on: 2026-06-27 10:42:58

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`pharmacy` COMMENT 'Manages pharmacy benefit administration — formulary design, drug tier assignments, NDC-level drug master, MAC/AWP/WAC pricing, retail and mail-order dispensing, specialty pharmacy, and pharmacy claim adjudication. Owns PBM contract terms, step therapy and quantity limit rules, drug utilization review (DUR) outcomes, and prior authorization for specialty drugs. Interfaces with RxClaim or Argus PBM systems and supports CMS Part D reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` (
    `drug_master_id` BIGINT COMMENT 'Unique surrogate identifier for each drug master record in the lakehouse Silver layer. Serves as the primary key for all downstream joins across formulary, claims, DUR, rebate contracting, and PBM adjudication.',
    `ahfs_class_code` STRING COMMENT '',
    `atc_code` STRING COMMENT 'The WHO Anatomical Therapeutic Chemical (ATC) classification code at the 5th level, identifying the drugs anatomical main group, therapeutic subgroup, pharmacological subgroup, chemical subgroup, and chemical substance. Used for therapeutic class reporting, HEDIS pharmacy measures, population health analytics, and international drug classification alignment.. Valid values are `^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$`',
    `awp_effective_date` DATE COMMENT 'The date on which the current AWP unit price became effective. Used to apply the correct AWP for historical claims repricing, audit reconciliation, and retroactive rebate calculations.',
    `awp_unit_price` DECIMAL(18,2) COMMENT 'The Average Wholesale Price (AWP) per unit of the drug as published by First Databank or Medi-Span. AWP is the benchmark pricing reference used in pharmacy reimbursement calculations, MAC pricing comparisons, and rebate contract negotiations. Expressed in USD per unit (tablet, mL, gram, etc.).',
    `brand_name` STRING COMMENT 'The proprietary trade name under which the drug is marketed by the manufacturer (e.g., Lipitor, Humira). Used in formulary tier assignment, rebate contracting, member communications, and brand vs. generic substitution logic in PBM adjudication.',
    `brand_or_generic_indicator` STRING COMMENT '',
    `controlled_substance_schedule` STRING COMMENT 'The DEA controlled substance schedule classification (I through V) indicating the drugs potential for abuse and accepted medical use. Schedule II-V drugs require enhanced DUR edits, quantity limits, early refill restrictions, and special handling in PBM adjudication. Not_scheduled indicates no DEA restriction.. Valid values are `I|II|III|IV|V|not_scheduled`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this drug master record was first created in the lakehouse Silver layer. Used for data lineage, audit compliance, and change data capture tracking per HIPAA Security Rule requirements.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `dea_number_required` BOOLEAN COMMENT 'Indicates whether a valid DEA registration number is required on the prescription for this drug due to its controlled substance classification. Drives prescription validation edits in PBM adjudication and pharmacy dispensing workflows.',
    `dosage_form` STRING COMMENT 'The physical form in which the drug is dispensed (e.g., tablet, capsule, solution, injection, patch, inhaler). Critical for formulary configuration, quantity limit rules, step therapy protocols, and DUR screening in RxClaim/Argus. [ENUM-REF-CANDIDATE: tablet|capsule|solution|injection|patch|inhaler|cream|ointment|suspension|powder — promote to reference product]',
    `drug_class_code` STRING COMMENT 'The classification code for the drug class within the GPI or ETC hierarchy, representing a more granular grouping below therapeutic subclass (e.g., specific statin subtype). Used in formulary step therapy rules, DUR clinical edits, and rebate tier segmentation in PBM systems.',
    `drug_class_name` STRING COMMENT 'The human-readable name of the drug class corresponding to the drug_class_code. Provides the most granular named classification level in the therapeutic hierarchy for formulary configuration and clinical reporting.',
    `drug_name` STRING COMMENT 'The full proprietary or established name of the drug as it appears on the FDA-approved label and in the First Databank or Medi-Span drug database feed. Used as the primary human-readable identity label across formulary displays, EOB communications, and member-facing materials.',
    `drug_status` STRING COMMENT 'Current lifecycle status of the drug record in the master file. Active drugs are eligible for formulary placement and PBM adjudication. Discontinued or recalled drugs trigger claim edits and member/provider notifications. Drives formulary maintenance workflows in RxClaim/Argus.. Valid values are `active|inactive|discontinued|recalled|pending`',
    `drug_type` STRING COMMENT 'Classification of the drug as brand-name, generic, biosimilar, over-the-counter (OTC), compounded, or repackaged. Drives formulary tier assignment, cost-sharing rules, generic substitution logic, and rebate eligibility in PBM adjudication and formulary management.. Valid values are `brand|generic|biosimilar|otc|compound|repackaged`',
    `effective_date` DATE COMMENT 'The date on which this drug master record became effective and eligible for use in formulary configuration, PBM adjudication, and claims processing. Used for temporal validity enforcement in adjudication date-of-service lookups and formulary effective date management.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fda_approval_status` STRING COMMENT 'The current FDA regulatory approval status of the drug product. Approved drugs are eligible for formulary coverage. Tentatively approved generics may be covered under specific plan designs. Withdrawn or not-approved drugs are excluded from formulary and trigger claim denials. Required for CMS Part D formulary compliance.. Valid values are `approved|tentatively_approved|pending|withdrawn|not_approved`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Medication)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `generic_name` STRING COMMENT 'The International Nonproprietary Name (INN) or United States Adopted Name (USAN) for the active ingredient(s) of the drug (e.g., atorvastatin, adalimumab). Used for generic substitution logic, DUR screening, therapeutic equivalence grouping, and HEDIS pharmacy measure reporting.',
    `gpi_code` STRING COMMENT 'The 14-digit Medi-Span Generic Product Identifier (GPI) code providing a hierarchical drug classification from drug group (2 digits) through drug class, subclass, name, name extension, dosage form, and strength. Used as the primary therapeutic classification key in RxClaim/Argus PBM systems for formulary management, DUR screening, and rebate contracting.. Valid values are `^[0-9]{14}$`',
    `hcc_relevant` BOOLEAN COMMENT 'Indicates whether this drug is clinically associated with one or more CMS Hierarchical Condition Categories (HCCs) for risk adjustment purposes. HCC-relevant drugs are used in RAF score modeling, RAPS/EDPS encounter data submissions, and population health stratification for Medicare Advantage plans.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_biosimilar` BOOLEAN COMMENT 'Indicates whether this drug is an FDA-approved biosimilar to a reference biological product. Biosimilars have distinct formulary placement rules, interchangeability designations, and rebate contracting considerations under CMS Part D and commercial plan designs.',
    `is_generic_available` BOOLEAN COMMENT 'Indicates whether an FDA-approved generic equivalent is available in the market for this brand-name drug. Used in formulary tier assignment, member cost-sharing communications, and generic substitution prompts during PBM adjudication and pharmacy dispensing.',
    `is_maintenance_drug` BOOLEAN COMMENT 'Indicates whether this drug is classified as a maintenance medication intended for long-term chronic condition management (e.g., antihypertensives, statins, diabetes medications). Maintenance drugs are eligible for 90-day supply dispensing at mail-order pharmacies and are used in HEDIS medication adherence measures (PDC).',
    `is_preventive_drug` BOOLEAN COMMENT 'Indicates whether this drug qualifies as a preventive medication under ACA Section 2713 or HDHP/HSA preventive care rules, making it eligible for $0 cost-sharing before the deductible is met. Used in benefit configuration and claims adjudication cost-sharing logic.',
    `is_specialty_drug` BOOLEAN COMMENT 'Indicates whether this drug is classified as a specialty pharmaceutical requiring special handling, storage, administration, or monitoring (e.g., biologics, oncology agents, hepatitis C treatments). Specialty drugs are subject to mandatory specialty pharmacy channel requirements, prior authorization, and enhanced DUR in PBM adjudication. Critical for CMS Part D specialty tier placement.',
    `labeler_code` STRING COMMENT 'The 5-digit FDA-assigned labeler code (first segment of the NDC) identifying the firm that manufactures, repackages, relabels, or distributes the drug. Used for manufacturer-level rebate aggregation and PBM contract management.. Valid values are `^[0-9]{5}$`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `multi_source_code` STRING COMMENT 'The FDA Orange Book multi-source code indicating the competitive market status of the drug: O=originator brand with no generic, M=multi-source (generic available), N=no current market (discontinued), Y=single-source generic. Used in generic substitution logic, formulary tier assignment, and MAC pricing eligibility determination.. Valid values are `O|M|N|Y`',
    `ndc` STRING COMMENT 'The 11-digit National Drug Code assigned by the FDA uniquely identifying the labeler, product, and package size of a drug. This is the primary external business identifier for the drug and is used in pharmacy claims (NCPDP/837P), formulary management, PBM adjudication (RxClaim/Argus), and CMS Part D reporting. Stored in 5-4-2 format without hyphens.. Valid values are `^[0-9]{11}$`',
    `ndc_11` STRING COMMENT 'The NDC formatted in the standard 5-4-2 hyphenated display format (e.g., 12345-6789-01) as required for human-readable labeling, SBC documentation, and regulatory submissions to CMS and state DOIs.. Valid values are `^[0-9]{5}-[0-9]{4}-[0-9]{2}$`',
    `ndc_code` STRING COMMENT '',
    `package_size` DECIMAL(18,2) COMMENT 'The quantity of drug units contained in the dispensed package as defined by the NDC (e.g., 30 tablets, 100 mL, 1 vial). Used in unit-of-use pricing calculations, days supply verification, quantity limit enforcement, and MAC pricing per-unit derivation.',
    `package_size_unit` STRING COMMENT 'The unit of measure for the package size quantity (e.g., EA for each/tablet/capsule, ML for milliliter, GM for gram). Used in conjunction with package_size for accurate dispensing quantity calculations, days supply verification, and unit-cost pricing in PBM adjudication. [ENUM-REF-CANDIDATE: EA|ML|GM|MG|TAB|CAP|VIAL|PATCH|KIT — 9 candidates stripped; promote to reference product]',
    `pharmacological_category` STRING COMMENT 'The pharmacological mechanism-of-action category of the drug (e.g., ACE Inhibitor, Beta Blocker, SSRI, Statin, Monoclonal Antibody). Used for DUR drug-drug interaction screening, therapeutic duplication edits, clinical program targeting in care management, and HEDIS measure attribution.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `rems_program` STRING COMMENT 'The name of the FDA-mandated Risk Evaluation and Mitigation Strategy (REMS) program associated with this drug, if applicable (e.g., iPLEDGE for isotretinoin, TIRF REMS for fentanyl products). REMS drugs require special dispensing controls, patient enrollment, and prescriber certification that must be validated during PBM adjudication and prior authorization.',
    `route_of_administration` STRING COMMENT 'The path by which the drug is administered to the patient (e.g., oral, intravenous, subcutaneous, topical, inhalation). Drives formulary benefit category assignment (medical vs. pharmacy benefit), prior authorization requirements, and specialty pharmacy routing in PBM adjudication. [ENUM-REF-CANDIDATE: oral|intravenous|subcutaneous|intramuscular|topical|inhalation|transdermal|ophthalmic|otic|rectal — promote to reference product]',
    `rxnorm_code` STRING COMMENT '',
    `source_record_code` STRING COMMENT 'The native record identifier from the originating source system (First Databank, Medi-Span, RxClaim, or Argus) for this drug master record. Used for data lineage, cross-system reconciliation, and upstream change tracking in the lakehouse ingestion pipeline.',
    `source_system_code` STRING COMMENT 'Identifies the operational source system from which this drug master record was ingested (e.g., FDB=First Databank, MEDISPAN=Medi-Span, RXCLAIM=RxClaim PBM, ARGUS=Argus PBM, INTERNAL=internally maintained). Used for data lineage tracking, conflict resolution during ETL, and audit compliance in the Databricks Silver layer.. Valid values are `FDB|MEDISPAN|RXCLAIM|ARGUS|INTERNAL`',
    `strength` STRING COMMENT 'The concentration or potency of the active ingredient(s) expressed as a numeric value with unit of measure (e.g., 10 mg, 500 mg/5 mL, 0.25%). Used in DUR duplicate therapy screening, quantity limit enforcement, and clinical appropriateness review in UM/PA workflows.',
    `termination_date` DATE COMMENT 'The date on which this drug master record was terminated or superseded, indicating the drug is no longer active for formulary placement or new claim adjudication. Null indicates the record is currently active. Used for historical claims repricing and formulary audit trails.',
    `therapeutic_class_code` STRING COMMENT 'The standardized code identifying the broad therapeutic class of the drug (e.g., cardiovascular agents, anti-infectives, antineoplastics). Used for formulary tier grouping, rebate contract aggregation, utilization reporting, and disease management program enrollment triggers.',
    `therapeutic_class_name` STRING COMMENT 'The human-readable name of the therapeutic class corresponding to the therapeutic_class_code. Used in formulary displays, member-facing SBC documents, provider communications, and regulatory reporting to CMS and state DOIs.',
    `therapeutic_equivalence_code` STRING COMMENT 'The FDA Orange Book therapeutic equivalence evaluation code (e.g., AB, AA, BC) indicating whether a generic drug is therapeutically equivalent to the reference listed drug. AB-rated generics are substitutable at the pharmacy. Used in generic substitution logic, formulary step therapy, and DAW (Dispense As Written) override processing in PBM adjudication.. Valid values are `^[A-Z]{2}[0-9]*$`',
    `therapeutic_subclass_code` STRING COMMENT 'The standardized code identifying the therapeutic subclass within the broader therapeutic class (e.g., HMG-CoA Reductase Inhibitors within cardiovascular agents). Enables granular formulary tier differentiation, step therapy protocol design, and rebate contract segmentation.',
    `therapeutic_subclass_name` STRING COMMENT 'The human-readable name of the therapeutic subclass corresponding to the therapeutic_subclass_code. Used in formulary management workflows, clinical program configuration, and detailed utilization analytics.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this drug master record was last modified in the lakehouse Silver layer. Used for incremental data refresh, change detection, and audit trail maintenance in the Databricks lakehouse pipeline.',
    `wac_unit_price` DECIMAL(18,2) COMMENT 'The Wholesale Acquisition Cost (WAC) per unit as reported by the manufacturer, representing the list price to wholesalers before discounts and rebates. Used as a pricing benchmark for specialty drug reimbursement, rebate baseline calculations, and CMS Part D coverage gap discount program calculations.',
    CONSTRAINT pk_drug_master PRIMARY KEY(`drug_master_id`)
) COMMENT 'Authoritative NDC-level drug master record for all covered pharmaceutical products. Captures National Drug Code (NDC), drug name, generic name, brand name, manufacturer, dosage form, strength, route of administration, drug class, controlled substance schedule, FDA approval status, and therapeutic equivalence codes (AB-rated/biosimilar). Includes generic substitution relationships and the full therapeutic classification hierarchy: ATC (Anatomical Therapeutic Chemical) code, GPI (Generic Product Identifier) prefix, pharmacological category, therapeutic class, therapeutic subclass, class name, and subclass name. This is the SSOT for all drug identity, classification, equivalence, and therapeutic hierarchy data used across formulary, claims, DUR, rebate contracting, HEDIS pharmacy measures, and PBM adjudication. Sourced from First Databank/Medi-Span drug database feeds.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` (
    `formulary_id` BIGINT COMMENT 'Unique surrogate identifier for the formulary record. Primary key for the formulary data product in the pharmacy domain.',
    `prior_version_formulary_id` BIGINT COMMENT 'Reference to the immediately preceding version of this formulary. Enables formulary change tracking, member notification workflows, and historical adjudication lookups for appeals and grievances.',
    `formulary_category` STRING COMMENT 'Business classification of the formulary indicating its benefit richness level relative to other formularies offered by the plan. Used in benefit design analytics, member communications, and plan comparison tools.. Valid values are `standard|enhanced|basic|premium|custom`',
    `change_notification_date` DATE COMMENT 'Date on which member notification was sent for formulary changes. CMS Part D requires 60-day advance notice for non-preferred formulary changes and immediate notification for safety-related removals.',
    `cms_formulary_code` STRING COMMENT 'The CMS-assigned formulary identifier used in Part D formulary file submissions to CMS. Required for Medicare Part D plans to identify the formulary in RAPS and EDPS submissions.. Valid values are `^[0-9]{8}$`',
    `formulary_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the formulary across systems, used in EDI transactions, PBM interfaces, and CMS Part D submissions. Corresponds to the formulary ID field in RxClaim/Argus PBM system.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this formulary record was first created in the system. Used for audit trail, data lineage, and compliance documentation purposes.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `formulary_description` STRING COMMENT 'Free-text business description of the formulary, including its intended population, key design features, and any notable coverage inclusions or exclusions. Used in internal documentation and plan benefit configuration.',
    `drug_count` STRING COMMENT 'Total number of unique drug entries (NDC or drug-tier combinations) included in this formulary at the time of the last update. Used for formulary adequacy assessments and CMS Part D formulary file validation.',
    `drug_utilization_review_ind` BOOLEAN COMMENT 'Indicates whether Drug Utilization Review (DUR) edits are applied during adjudication under this formulary. DUR programs screen for drug interactions, duplicate therapy, and inappropriate dosing per OBRA 90 requirements.',
    `effective_date` DATE COMMENT 'The date on which this formulary becomes active and applicable to member benefit adjudication. Used by PBM systems (RxClaim/Argus) to determine which formulary version applies at point of dispensing.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: MedicationKnowledge)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `formulary_status` STRING COMMENT 'Current lifecycle status of the formulary record. Active formularies are used in live adjudication; pending formularies are approved but not yet effective; retired formularies are historical records no longer in use.. Valid values are `active|inactive|pending|retired|suspended`',
    `formulary_type` STRING COMMENT 'Classification of the formulary structure indicating coverage breadth and tier design. Open formularies cover most drugs; closed formularies restrict to listed drugs only; tiered formularies apply differential cost-sharing by tier.. Valid values are `open|closed|tiered|preferred|exclusive`',
    `generic_substitution_policy` STRING COMMENT 'Policy governing generic drug substitution at point of dispensing. Mandatory substitution requires dispensing of generic equivalents; permissive allows brand if requested; DAW (Dispense As Written) honored respects prescriber instructions.. Valid values are `mandatory|permissive|prohibited|daw_honored`',
    `is_aca_compliant` BOOLEAN COMMENT 'Indicates whether this formulary meets ACA Qualified Health Plan (QHP) essential health benefit (EHB) drug coverage requirements, including the required drug categories and classes under 45 CFR Part 156.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_cms_part_d` BOOLEAN COMMENT 'Indicates whether this formulary is subject to CMS Medicare Part D regulatory requirements, including annual bid submission, formulary file submission to CMS, and coverage determination obligations.',
    `last_review_date` DATE COMMENT 'Date on which the Pharmacy and Therapeutics (P&T) Committee last reviewed and approved this formulary. P&T Committee review is required for CMS Part D compliance and NCQA accreditation.',
    `lob_code` STRING COMMENT 'Line of Business (LOB) associated with this formulary, indicating the regulatory and market segment under which the formulary operates. Drives CMS Part D, Medicaid, or commercial compliance requirements.. Valid values are `commercial|medicare|medicaid|marketplace|fehb|tricare`',
    `low_income_subsidy_ind` BOOLEAN COMMENT 'Indicates whether this formulary is designated for use by Low Income Subsidy (LIS) eligible members under Medicare Part D. LIS formularies must meet CMS benchmark plan requirements for cost-sharing and drug coverage.',
    `mail_order_ind` BOOLEAN COMMENT 'Indicates whether this formulary supports mail-order pharmacy dispensing. Mail-order programs typically offer 90-day supplies at reduced cost-sharing and are a key component of pharmacy benefit design.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `formulary_name` STRING COMMENT 'Human-readable business name of the formulary (e.g., Standard Commercial Formulary 2025, Medicare Part D Enhanced Formulary). Used in member-facing materials, SBC documents, and plan benefit configurations.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next Pharmacy and Therapeutics (P&T) Committee review of this formulary. Supports compliance tracking for CMS Part D requirements mandating regular formulary review cycles.',
    `pbm_formulary_code` STRING COMMENT 'The formulary identifier as assigned by the PBM system (RxClaim or Argus). Used for cross-system reconciliation between the health plans internal formulary record and the PBMs formulary configuration.. Valid values are `^[A-Z0-9_-]{1,50}$`',
    `plan_year` STRING COMMENT 'The benefit plan year (e.g., 2025) for which this formulary is effective. Used for annual formulary change management, CMS Part D annual bid submissions, and benefit year reporting.',
    `prior_auth_ind` BOOLEAN COMMENT 'Indicates whether this formulary requires prior authorization (PA) for any covered drugs. PA requirements are subject to CMS Part D coverage determination timelines and member appeal rights.',
    `pt_committee_approval_date` DATE COMMENT 'Date on which the Pharmacy and Therapeutics (P&T) Committee formally approved this formulary or the most recent formulary update. Required documentation for CMS Part D compliance and NCQA accreditation audits.',
    `quantity_limit_ind` BOOLEAN COMMENT 'Indicates whether this formulary applies quantity limits (QL) on covered drugs, restricting the amount dispensed per fill or per defined time period. Quantity limits are a utilization management tool subject to CMS Part D exception requirements.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regulatory_approval_date` DATE COMMENT 'The date on which CMS or the applicable State Department of Insurance approved this formulary for use. Required for Part D compliance documentation and audit trails.',
    `regulatory_filing_date` DATE COMMENT 'The date on which the formulary was submitted to CMS or the applicable State Department of Insurance for regulatory review and approval.',
    `regulatory_filing_status` STRING COMMENT 'Status of the formularys regulatory filing with CMS or applicable State Department of Insurance (DOI). Tracks whether the formulary has been submitted, approved, or rejected for compliance with Part D or state market requirements.. Valid values are `not_filed|filed|approved|rejected|pending_review`',
    `source_system_code` STRING COMMENT 'Identifies the operational source system from which this formulary record originated (e.g., RxClaim, Argus PBM system, Facets). Used for data lineage tracking and cross-system reconciliation in the Databricks Silver layer.. Valid values are `rxclaim|argus|facets|qnxt|manual|other`',
    `specialty_pharmacy_ind` BOOLEAN COMMENT 'Indicates whether this formulary designates a specialty pharmacy network for dispensing high-cost specialty drugs. Specialty pharmacy programs may include limited distribution networks and enhanced clinical support services.',
    `specialty_tier_ind` BOOLEAN COMMENT 'Indicates whether this formulary includes a specialty drug tier for high-cost specialty medications. Specialty tiers typically apply to drugs with monthly costs exceeding CMS specialty tier threshold (currently $670/month for Part D).',
    `step_therapy_ind` BOOLEAN COMMENT 'Indicates whether this formulary employs step therapy (also known as fail-first) protocols requiring members to try lower-cost or preferred drugs before coverage of higher-cost alternatives is authorized.',
    `termination_date` DATE COMMENT 'The date on which this formulary is no longer active. Null indicates an open-ended formulary with no defined end date. Used for formulary version management and historical adjudication lookups.',
    `tier_count` STRING COMMENT 'The total number of cost-sharing tiers defined in this formulary (e.g., 3-tier, 4-tier, 5-tier, 6-tier). Determines the tier structure used in drug tier assignments and member cost-sharing calculations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this formulary record was last modified. Used for change tracking, incremental data loads in the Databricks Silver layer, and audit trail requirements.',
    `url` STRING COMMENT 'Public-facing URL where members can access the formulary drug list. CMS Part D and ACA QHP regulations require health plans to publish formularies online and provide the URL in plan materials and SBC documents.. Valid values are `^https?://.+$`',
    `version` STRING COMMENT 'Version number of the formulary, incremented with each approved update or mid-year formulary change. Used to track formulary change history and ensure members receive required 60-day advance notice of non-preferred changes.. Valid values are `^[0-9]{1,4}.[0-9]{1,4}$`',
    CONSTRAINT pk_formulary PRIMARY KEY(`formulary_id`)
) COMMENT 'Master record for each formulary (drug benefit list) offered by the health plan. Defines the formulary name, effective date range, line of business (LOB), plan year, formulary type (open/closed/tiered), PBM contract reference, and regulatory filing status. A formulary is the SSOT for which drugs are covered under a given benefit design and is required for CMS Part D compliance.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` (
    `formulary_drug_tier_id` BIGINT COMMENT 'Unique surrogate identifier for each formulary drug tier assignment record. Primary key for this association entity linking a drug (NDC) to a formulary with its tier, cost-sharing, and utilization management (UM) controls.',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: Formulary drug tier entries define drug coverage within a formulary; the plan benefit record defines the governing drug benefit parameters (EHB classification, authorization requirements, formulary_ti',
    `clinical_criteria_id` BIGINT COMMENT 'Foreign key linking to utilization.clinical_criteria. Business justification: Formulary drug tier step-therapy and prior-auth requirements are governed by specific clinical criteria versions. Linking enables UM/pharmacy integration reports validating that tier-level PA and step',
    `drug_master_id` BIGINT COMMENT 'Reference to the internal drug master record corresponding to this NDC, enabling joins to the drug master for drug name, therapeutic class, and other drug attributes.',
    `formulary_id` BIGINT COMMENT 'Reference to the formulary to which this drug tier assignment belongs. A formulary is the approved list of covered drugs for a given plan and benefit year.',
    `health_plan_id` BIGINT COMMENT 'Reference to the health plan or benefit plan under which this formulary drug tier assignment applies. Links the tier assignment to the specific plan for cost-sharing and benefit configuration.',
    `rx_benefit_config_id` BIGINT COMMENT 'add column rx_benefit_config_id (BIGINT) with FK to plan.rx_benefit_config.rx_benefit_config_id - tiers integrate with Rx benefit config',
    `benefit_year` STRING COMMENT 'The plan benefit year (e.g., 2024, 2025) to which this formulary drug tier assignment applies. CMS Part D formulary files are submitted annually by benefit year.',
    `coinsurance_rate` DECIMAL(18,2) COMMENT 'Member coinsurance percentage applied to the drug cost under this formulary tier assignment, expressed as a decimal (e.g., 0.20 = 20%). Used when cost-sharing is percentage-based rather than fixed copay. Applies to specialty and high-cost tiers.',
    `copay_mail_order` DECIMAL(18,2) COMMENT 'Fixed member copay amount for a 90-day supply dispensed through a mail-order pharmacy under this formulary tier assignment. Mail-order copays are typically lower than retail to incentivize mail-order utilization.',
    `copay_retail_30` DECIMAL(18,2) COMMENT 'Fixed member copay amount for a 30-day supply dispensed at a retail pharmacy under this formulary tier assignment. Drives member cost-sharing at point of sale. Used in SBC and EOB generation.',
    `copay_retail_90` DECIMAL(18,2) COMMENT 'Fixed member copay amount for a 90-day supply dispensed at a retail pharmacy under this formulary tier assignment. Applicable for maintenance medications at extended-supply retail pharmacies.',
    `coverage_status` STRING COMMENT 'Indicates whether the drug is covered under this formulary assignment. covered = fully covered per tier rules; covered_with_restrictions = covered subject to UM controls (PA, ST, QL); not_covered = not on formulary; excluded = explicitly excluded per CMS or plan rules.. Valid values are `covered|not_covered|covered_with_restrictions|excluded`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this formulary drug tier assignment record was first created in the system. Supports audit trail, data lineage, and regulatory compliance documentation.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `deductible_applies` BOOLEAN COMMENT 'Indicates whether the plan deductible must be met before cost-sharing for this drug tier applies. Relevant for High Deductible Health Plans (HDHP) and plans with drug-specific deductibles.',
    `dispensing_channel` STRING COMMENT 'Pharmacy dispensing channel(s) through which this drug may be dispensed under this formulary tier assignment. specialty indicates dispensing is restricted to a specialty pharmacy network. Drives pharmacy routing at point of sale.. Valid values are `retail|mail_order|specialty|retail_and_mail|all`',
    `drug_tier_change_reason` STRING COMMENT 'Business reason for a change to the drugs tier assignment (e.g., generic available, contract renegotiation, clinical review, CMS requirement, formulary refresh). Supports audit trail and CMS formulary change notification requirements.',
    `dur_alert_type` STRING COMMENT 'Type of Drug Utilization Review (DUR) alert associated with this formulary drug tier assignment (e.g., drug-drug interaction, drug-disease contraindication, duplicate therapy, dose range check). Drives DUR edits at point of sale in the PBM adjudication system. [ENUM-REF-CANDIDATE: drug_drug_interaction|drug_disease|duplicate_therapy|dose_range|drug_allergy|drug_age — promote to reference product]',
    `effective_date` DATE COMMENT 'Date on which this formulary drug tier assignment becomes effective. Used to determine the applicable tier and cost-sharing rules at the time of dispensing. Required for CMS formulary file submissions.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Medication)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `formulary_status_code` STRING COMMENT 'CMS-defined formulary status code used in the Part D formulary file submission. Values: 1=Covered, 2=Covered with Restrictions, 3=Not Covered, 4=Covered (Grandfathered), 5=Covered (Transition), 6=Covered (LIS). Required field in CMS formulary extract file.. Valid values are `1|2|3|4|5|6`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lob_code` STRING COMMENT 'Line of business to which this formulary drug tier assignment applies (e.g., commercial, medicare_part_d, medicaid, exchange, fehb). Determines applicable regulatory requirements and cost-sharing rules.. Valid values are `commercial|medicare_part_d|medicaid|exchange|fehb`',
    `mac_pricing_applicable` BOOLEAN COMMENT 'Indicates whether Maximum Allowable Cost (MAC) pricing applies to this drug under this formulary tier assignment. MAC pricing caps reimbursement for generic drugs and is a key PBM contract term.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `ndc_code` STRING COMMENT '11-digit National Drug Code uniquely identifying the specific drug product, dosage form, and package size assigned to this formulary tier. NDC is the primary drug identifier used in pharmacy claim adjudication and CMS formulary file submissions.. Valid values are `^[0-9]{11}$`',
    `pa_criteria_description` STRING COMMENT 'Narrative description of the clinical criteria that must be met for prior authorization approval of this drug. Supports PA adjudication, member appeals, and CMS/NCQA compliance documentation.',
    `pa_type` STRING COMMENT 'Type of prior authorization process required for this drug (e.g., standard = standard review timeline; expedited = urgent/expedited review; retrospective = post-service review). Null or not_applicable if prior_auth_required is false.. Valid values are `standard|expedited|retrospective|not_applicable`',
    `pbm_formulary_code` STRING COMMENT 'PBM system-specific formulary identifier used in RxClaim or Argus to reference this formulary configuration. Enables reconciliation between the health plans internal formulary records and the PBMs adjudication system.',
    `prior_auth_required` BOOLEAN COMMENT 'Indicates whether prior authorization (PA) is required before this drug will be covered under this formulary tier assignment. When true, a PA request must be approved before the claim will adjudicate. Reported in the CMS PA extract file.',
    `ql_clinical_basis` STRING COMMENT 'Clinical rationale or basis for the quantity limit rule (e.g., FDA-approved maximum dose, clinical guidelines, safety limit). Documents the evidence basis for the QL control as required for CMS and NCQA compliance.',
    `ql_days_supply` STRING COMMENT 'The number of days supply over which the maximum quantity limit applies (e.g., 30 days, 90 days). Defines the time window for the quantity limit rule. Null if quantity_limit_required is false.',
    `ql_dosage_form_restriction` STRING COMMENT 'Specifies any dosage form restrictions associated with the quantity limit rule (e.g., tablet only, extended-release excluded, oral solution only). Captures clinical basis for dosage form-specific QL controls.',
    `ql_max_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity of the drug allowed per fill or per defined time period under the quantity limit rule. Expressed in the drugs dispensing unit (e.g., tablets, mL, units). Null if quantity_limit_required is false.',
    `quantity_limit_required` BOOLEAN COMMENT 'Indicates whether a quantity limit (QL) applies to this drug under this formulary assignment. When true, the dispensed quantity per fill or per time period is restricted. Reported in the CMS QL extract file.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Lifecycle status of this formulary drug tier assignment record. active = currently in effect; inactive = terminated or expired; pending = approved but not yet effective; superseded = replaced by a newer version of the same assignment.. Valid values are `active|inactive|pending|superseded`',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `specialty_drug_flag` BOOLEAN COMMENT 'Indicates whether this drug is designated as a specialty drug under this formulary. Specialty drugs typically require dispensing through a specialty pharmacy, have higher cost-sharing, and may require PA. Used in specialty pharmacy channel routing and PBM contract management.',
    `st_clinical_rationale` STRING COMMENT 'Clinical rationale or evidence basis for the step therapy protocol (e.g., preferred generic available, clinical guidelines recommend first-line therapy, cost-effectiveness). Required for CMS and NCQA UM documentation.',
    `st_override_criteria` STRING COMMENT 'Criteria under which the step therapy requirement may be overridden without completing the required step sequence (e.g., contraindication to step drug, prior treatment failure documented, clinical exception). Supports PA override adjudication.',
    `st_required_step_ndc` STRING COMMENT 'National Drug Code (NDC) of the required step drug that must be tried and failed before coverage of this drug is approved under the step therapy protocol. Null if step_therapy_required is false.. Valid values are `^[0-9]{11}$`',
    `st_step_number` STRING COMMENT 'The sequence number of this drug in the step therapy protocol (e.g., 1 = first-line, 2 = second-line). Defines the order in which step drugs must be tried and failed before coverage of the target drug is approved. Null if step_therapy_required is false.',
    `step_therapy_required` BOOLEAN COMMENT 'Indicates whether step therapy (ST) applies to this drug under this formulary assignment. When true, the member must first try and fail one or more preferred (step) drugs before coverage of this drug is approved. Reported in the CMS ST extract file.',
    `termination_date` DATE COMMENT 'Date on which this formulary drug tier assignment expires or is terminated. Null indicates the assignment is currently active with no defined end date. Supports historical tracking and CMS formulary file change submissions.',
    `tier_name` STRING COMMENT 'Human-readable label for the drug tier (e.g., Generic, Preferred Brand, Non-Preferred Brand, Specialty, Specialty Preferred). Displayed on member-facing materials including the Summary of Benefits and Coverage (SBC) and Explanation of Benefits (EOB).',
    `tier_number` STRING COMMENT 'Numeric tier level assigned to the drug within the formulary (e.g., 1=Generic, 2=Preferred Brand, 3=Non-Preferred Brand, 4=Specialty, 5=Specialty Preferred, 6=Select Care). Drives member cost-sharing at point of sale. CMS requires tier number in formulary file submissions.',
    `transition_fill_allowed` BOOLEAN COMMENT 'Indicates whether a transition fill is permitted for this drug when a member is new to the plan or the drugs formulary status has changed. CMS Part D requires transition fills for certain drugs during the transition period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this formulary drug tier assignment record was last modified. Supports change tracking, audit trail, and CMS formulary change notification compliance.',
    CONSTRAINT pk_formulary_drug_tier PRIMARY KEY(`formulary_drug_tier_id`)
) COMMENT 'Association entity linking a specific drug (NDC) to a formulary with its assigned tier, cost-sharing rules, coverage status, and all utilization management (UM) controls. UM controls owned by this product include: quantity limits (max quantity per fill/time period, dosage form restrictions, clinical basis), step therapy protocols (fail-first drug sequences, required step drugs, step sequence, clinical rationale, override criteria), prior authorization flags, and specialty drug designation. Captures effective date range for each tier assignment and each UM control configuration. This is the single operational record that drives member cost-sharing and UM edits at point of sale, and is the SSOT for CMS formulary file submissions including formulary, QL, ST, and PA extract files.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` (
    `drug_pricing_id` BIGINT COMMENT 'Unique surrogate identifier for each NDC-level drug pricing record in the Silver Layer lakehouse. Primary key for the drug_pricing data product.',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: drug_pricing records are defined per NDC; linking to drug_master provides the authoritative drug attributes and eliminates duplicated columns.',
    `pbm_contract_id` BIGINT COMMENT 'add column pbm_contract_id (BIGINT) with FK to pharmacy.pbm_contract.pbm_contract_id - drug pricing flows from PBM contract terms',
    `awp_discount_pct` DECIMAL(18,2) COMMENT 'Percentage discount applied to AWP to derive the reimbursement rate under AWP-based contracts (e.g., AWP minus 15%). Expressed as a positive decimal percentage (e.g., 15.0000 = 15%). Used for PBM contract compliance validation and reimbursement audits.',
    `awp_price` DECIMAL(18,2) COMMENT 'Average Wholesale Price per unit as published by First Databank or Medi-Span. Commonly used as the benchmark for pharmacy reimbursement calculations and discount negotiations. Expressed in USD.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this drug pricing record was first created in the Silver Layer lakehouse. Used for data lineage, audit trails, and SLA monitoring of pricing file processing.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary price fields in this record (e.g., USD). Supports multi-currency operations for Puerto Rico and other US territories. Defaults to USD for domestic plans.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `days_supply` STRING COMMENT 'Number of days of drug supply for which this pricing record applies (e.g., 30-day retail, 90-day mail order). Used to differentiate pricing tiers by supply duration per PBM contract terms.',
    `dea_schedule` STRING COMMENT 'DEA controlled substance schedule classification (CI through CV) or NON-CONTROLLED. Used for DUR edits, quantity limit enforcement, prior authorization requirements, and regulatory compliance reporting.. Valid values are `CI|CII|CIII|CIV|CV|NON-CONTROLLED`',
    `dispensing_channel` STRING COMMENT 'Pharmacy dispensing channel for which this pricing record applies: retail (community pharmacy), mail_order (90-day supply mail service), specialty (specialty pharmacy), or long_term_care (LTC facility pharmacy). Pricing may differ by channel per PBM contract terms.. Valid values are `retail|mail_order|specialty|long_term_care`',
    `dispensing_fee` DECIMAL(18,2) COMMENT 'Fixed dispensing fee in USD paid to the pharmacy per prescription fill, separate from the ingredient cost. Defined in PBM network contracts and applied during claim adjudication to calculate total pharmacy reimbursement.',
    `effective_date` DATE COMMENT 'Date on which this pricing record becomes effective and applicable for claim adjudication. Used to select the correct price for a claim based on the date of service. Aligns with PBM pricing file effective dates.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date on which this pricing record expires and is no longer applicable for new claim adjudication. Null indicates an open-ended pricing record with no defined end date. Used with effective_date to determine the active pricing window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Medication)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `formulary_tier` STRING COMMENT 'Formulary tier assignment for this drug under the applicable plan benefit design (e.g., tier_1=preferred generic, tier_2=generic, tier_3=preferred brand, tier_4=non-preferred brand, tier_5=specialty). Drives member cost-sharing (copay/coinsurance) during claim adjudication.. Valid values are `tier_1|tier_2|tier_3|tier_4|tier_5|non_formulary`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `mac_list_version` STRING COMMENT 'Version identifier of the MAC list, used to track updates and revisions to the MAC pricing schedule. Supports audit trails for MAC list changes and pharmacy reimbursement disputes. Null when price_type is not MAC.',
    `mac_methodology` STRING COMMENT 'Describes the methodology used to derive the MAC price (e.g., MARKET_BASKET=based on market survey of acquisition costs, NADAC_BASED=derived from CMS NADAC data, AWP_DISCOUNT=percentage discount from AWP, WAC_DISCOUNT=percentage discount from WAC, CUSTOM=plan-specific methodology). Required for PBM contract compliance and regulatory transparency. Null when price_type is not MAC.. Valid values are `MARKET_BASKET|NADAC_BASED|AWP_DISCOUNT|WAC_DISCOUNT|CUSTOM`',
    `mac_price` DECIMAL(18,2) COMMENT 'Maximum Allowable Cost per unit set by the PBM or health plan for generic and multi-source drugs. Represents the upper reimbursement limit for a drug under the applicable MAC list. Expressed in USD. Null when price_type is not MAC.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `multi_source_code` STRING COMMENT 'FDA Orange Book multi-source code indicating the competitive market status of the drug: O=Originator brand (no generic), M=Multi-source (generic available), N=Non-multi-source, Y=Generic product. Used to determine MAC eligibility and generic substitution applicability.. Valid values are `O|M|N|Y`',
    `package_size` DECIMAL(18,2) COMMENT 'Quantity of units contained in the standard package as defined by the NDC. Used to convert between package-level and per-unit pricing and to validate dispensed quantity against package size during adjudication.',
    `package_size_uom` STRING COMMENT 'Unit of measure for the package size quantity (e.g., TAB for tablets, ML for milliliters). Distinct from unit_of_measure which applies to the pricing unit; this field describes the package-level quantity unit. [ENUM-REF-CANDIDATE: EA|ML|GM|MG|UN|TAB|CAP|VIAL|PATCH — promote to reference product]',
    `price_change_pct` DECIMAL(18,2) COMMENT 'Percentage change in unit price from the prior pricing record to the current record, calculated as ((unit_price - prior_unit_price) / prior_unit_price) * 100. Used for drug price inflation monitoring, CMS price increase reporting, and PBM contract compliance.',
    `price_type` STRING COMMENT 'Classifies the pricing methodology represented by this record: AWP (Average Wholesale Price), WAC (Wholesale Acquisition Cost), MAC (Maximum Allowable Cost), RBP (Reference Based Pricing), NADAC (National Average Drug Acquisition Cost), or Usual and Customary. Determines how the price is applied during claim adjudication and reimbursement calculation. [ENUM-REF-CANDIDATE: AWP|WAC|MAC|RBP|NADAC|USUAL_AND_CUSTOMARY — promote to reference product]. Valid values are `AWP|WAC|MAC|RBP|NADAC|USUAL_AND_CUSTOMARY`',
    `pricing_file_date` DATE COMMENT 'Publication or release date of the source pricing file from which this record was extracted. Used to track pricing file currency, identify stale pricing data, and support audit and reconciliation processes.',
    `pricing_file_name` STRING COMMENT 'Name of the source pricing file from which this record was loaded (e.g., FDB_PRICE_20240101.txt, RXCLAIM_MAC_Q1_2024.csv). Used for data lineage, audit trails, and troubleshooting pricing discrepancies.',
    `pricing_source` STRING COMMENT 'Identifies the originating source of the pricing data (e.g., First Databank, Medi-Span, RxClaim PBM feed, Argus PBM feed, CMS published rates, internal custom pricing). Critical for audit trails and PBM contract compliance. [ENUM-REF-CANDIDATE: FDB|MEDISPAN|RXCLAIM|ARGUS|CMS|INTERNAL|CUSTOM — promote to reference product]',
    `pricing_status` STRING COMMENT 'Current lifecycle status of the pricing record: active (currently in use for adjudication), inactive (no longer applicable), pending (approved but not yet effective), superseded (replaced by a newer pricing record for the same NDC and price type).. Valid values are `active|inactive|pending|superseded`',
    `prior_unit_price` DECIMAL(18,2) COMMENT 'Previous per-unit price for this NDC and price type before the most recent pricing update. Used for price change analysis, trend reporting, and PBM contract compliance audits.',
    `rbp_price` DECIMAL(18,2) COMMENT 'Reference Based Pricing per unit used as the benchmark reimbursement amount under RBP pharmacy contracts. Expressed in USD. Null when price_type is not RBP.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `unit_of_measure` STRING COMMENT 'Dispensing unit of measure for which the price applies (e.g., EA=Each, ML=Milliliter, GM=Gram, MG=Milligram, UN=Unit, TAB=Tablet, CAP=Capsule, VIAL=Vial, PATCH=Patch). Required for accurate per-unit cost calculation during adjudication. [ENUM-REF-CANDIDATE: EA|ML|GM|MG|UN|TAB|CAP|VIAL|PATCH — promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'Per-unit drug price expressed in USD for the applicable price type (AWP, WAC, MAC, or RBP). Used as the basis for claim adjudication, cost-sharing calculation, and pharmacy reimbursement. Precision to 6 decimal places to accommodate high-precision specialty drug pricing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this drug pricing record was last modified in the Silver Layer lakehouse. Used for change data capture (CDC), incremental processing, and audit trail maintenance.',
    `wac_price` DECIMAL(18,2) COMMENT 'Wholesale Acquisition Cost per unit as reported by the manufacturer to the pricing compendia. Represents the list price from manufacturer to wholesaler before discounts. Expressed in USD. Used in WAC-based reimbursement contracts.',
    CONSTRAINT pk_drug_pricing PRIMARY KEY(`drug_pricing_id`)
) COMMENT 'NDC-level drug pricing record capturing AWP (Average Wholesale Price), WAC (Wholesale Acquisition Cost), MAC (Maximum Allowable Cost), and RBP (Reference Based Pricing) values sourced from PBM pricing files. Includes effective date, pricing source, unit of measure, package size, price type, MAC list name, and MAC list methodology reference. Used for claim adjudication, cost-sharing calculation, and pharmacy reimbursement. MAC list grouping attributes are included directly on pricing records for governance and PBM contract compliance. Sourced from RxClaim or Argus PBM pricing feeds and First Databank/Medi-Span pricing updates.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` (
    `claim_line_id` BIGINT COMMENT 'Primary key for claim_line',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: Pharmacy claim adjudication must reference the governing benefit to apply coverage rules, authorization requirements, and cost-sharing parameters. Adjudication systems resolve each claim line to the s',
    `condition_registry_id` BIGINT COMMENT 'Foreign key linking to care.condition_registry. Business justification: Pharmacy claims are attributed to specific chronic conditions for HCC risk adjustment validation and condition-level drug utilization reporting. Linking claim_line to condition_registry formalizes the',
    `cost_share_rule_id` BIGINT COMMENT 'Foreign key linking to plan.cost_share_rule. Business justification: Claim adjudication calculates patient_pay_amount and plan_paid_amount by applying the governing cost_share_rule (copay, coinsurance, deductible logic). Linking claim lines to the applied cost_share_ru',
    `dispensing_pharmacy_id` BIGINT COMMENT 'Foreign key linking to pharmacy.dispensing_pharmacy. Business justification: Every pharmacy claim line is dispensed at a specific dispensing pharmacy. Adding dispensing_pharmacy_id to claim_line normalizes the pharmacy reference and enables adjudication analytics by pharmacy, ',
    `drug_master_id` BIGINT COMMENT 'Reference to the drug master record for the dispensed drug on this claim line, enabling linkage to formulary, tier, and pricing data.',
    `formulary_id` BIGINT COMMENT 'Reference to the formulary under which this drug was adjudicated, determining tier assignment, coverage rules, and cost-sharing obligations.',
    `header_id` BIGINT COMMENT 'Foreign key linking to claim.header. Business justification: Pharmacy claim lines must be associated with a claim transaction header for adjudication processing, EOB generation, MLR reporting, and payment reconciliation. Every pharmacy dispensing event submitte',
    `hedis_measure_id` BIGINT COMMENT 'Foreign key linking to care.hedis_measure. Business justification: Pharmacy claims are the primary data source for HEDIS medication adherence measures (PDC, MPR for diabetes, hypertension, cholesterol). Linking claim_line to hedis_measure enables automated measure po',
    `pbm_contract_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pbm_contract. Business justification: Pharmacy claims are adjudicated under a specific PBM contract that governs pricing methodology (AWP discount, MAC pricing, dispensing fees). Linking claim_line to pbm_contract enables contract perform',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to care.care_plan. Business justification: Medication adherence tracking within care plans requires linking pharmacy claims to the members active care plan. Care coordinators use this to monitor whether care plan drug therapies are being fill',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Pharmacy claim adjudication must reference the active policy to determine benefit coverage, deductible accumulation, out-of-pocket maximum tracking, and cost-sharing tier applicability. Claims adjudic',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: Pharmacy claim lines must be linked to the prescribing provider for fraud/waste/abuse (FWA) detection, prescriber profiling, PDE submission to CMS, and network adequacy reporting. This is a standard o',
    `prior_authorization_id` BIGINT COMMENT 'Reference to the prior authorization record approved for this drug line, required for specialty and non-formulary drugs. Null if no PA was required.',
    `program_id` BIGINT COMMENT 'Foreign key linking to care.program. Business justification: Pharmacy claims for members enrolled in disease management programs (oncology, transplant, diabetes) are attributed to those programs for program-level drug cost and utilization reporting. This suppor',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to member.subscriber. Business justification: Pharmacy claim adjudication requires linking each dispensed claim line to the covered member subscriber for eligibility verification, cost-sharing calculation, accumulator updates, and CMS Part D PDE ',
    `adjudication_timestamp` TIMESTAMP COMMENT 'Date and time when this pharmacy claim line was adjudicated by the PBM system (RxClaim or Argus). Represents the business event timestamp for the adjudication transaction. Used for audit trails and processing SLA measurement.',
    `basis_of_cost_determination` STRING COMMENT 'Code indicating the pricing benchmark used to determine the ingredient cost for this claim line. Values include Average Wholesale Price (AWP), Wholesale Acquisition Cost (WAC), Maximum Allowable Cost (MAC), Federal Upper Limit (FUL), NADAC, negotiated rate, usual and customary, or other. Critical for PBM audit and CMS Part D compliance. [ENUM-REF-CANDIDATE: AWP|WAC|MAC|FUL|NADAC|negotiated|usual_and_customary|other — promote to reference product]',
    `catastrophic_coverage_indicator` BOOLEAN COMMENT 'Indicates whether this claim line was adjudicated under the catastrophic coverage phase of the Part D benefit, where the plan pays a higher percentage of drug costs after the members True Out-of-Pocket (TrOOP) threshold is met.',
    `cob_sequence` STRING COMMENT 'Indicates the payer sequence in a Coordination of Benefits (COB) scenario. 1=primary payer, 2=secondary payer, 3=tertiary payer. Used to correctly apply COB rules and calculate each payers liability on this claim line.',
    `compound_indicator` BOOLEAN COMMENT 'Indicates whether this claim line is part of a compounded drug prescription. When true, multiple ingredient lines will exist under the same claim header, each with its own NDC and ingredient cost.',
    `coverage_gap_indicator` BOOLEAN COMMENT 'Indicates whether this claim line was adjudicated during the Part D coverage gap (donut hole) phase. Used for manufacturer discount program tracking and CMS Part D benefit phase reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `days_supply` STRING COMMENT 'Number of days of medication supply dispensed on this claim line as reported by the dispensing pharmacy. Used for refill-too-soon edits, adherence calculations, and HEDIS medication adherence measures.',
    `dispense_as_written_code` STRING COMMENT 'NCPDP Dispense As Written (DAW) code indicating whether the prescriber or member requested brand-name dispensing when a generic was available. DAW 0=no product selection indicated, DAW 1=substitution not allowed by prescriber, DAW 2=substitution allowed-patient requested brand. Impacts cost-sharing and GDR calculations.. Valid values are `0|1|2|3|4|5`',
    `dispensed_date` DATE COMMENT 'Date the drug was dispensed to the member at the pharmacy. Represents the real-world service event date used for benefit period calculations, days supply tracking, and CMS Part D reporting.',
    `dispensing_fee_amount` DECIMAL(18,2) COMMENT 'The fee charged by the dispensing pharmacy for the professional service of dispensing the medication. Negotiated as part of PBM network contracts and reported separately from ingredient cost per CMS Part D requirements.',
    `drug_coverage_status` STRING COMMENT 'Coverage determination status for this drug on the applicable formulary at time of adjudication. Indicates whether the drug is covered, non-covered, excluded, subject to step therapy, or requires prior authorization (PA).. Valid values are `covered|non_covered|excluded|step_therapy_required|pa_required`',
    `dur_conflict_code` STRING COMMENT 'NCPDP DUR conflict code identifying the type of drug utilization issue detected during adjudication (e.g., drug-drug interaction, drug-disease contraindication, duplicate therapy, high dose). Supports clinical safety monitoring and regulatory DUR reporting. [ENUM-REF-CANDIDATE: promote to reference product for full NCPDP DUR conflict code set]',
    `dur_outcome_code` STRING COMMENT 'NCPDP Drug Utilization Review (DUR) outcome code recorded during adjudication, indicating the pharmacists action taken in response to a DUR alert (e.g., filled as is, filled with prescriber approval, not filled). Supports clinical safety audit trails. [ENUM-REF-CANDIDATE: promote to reference product for full NCPDP DUR outcome code set]',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Claim.item)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `fill_number` STRING COMMENT 'Sequential fill number for this prescription across all fills, including original and all refills. Distinct from refill_number in that it counts total fills rather than refill sequence. Used for prescription lifecycle tracking.',
    `formulary_tier` STRING COMMENT 'Drug formulary tier assigned to this drug at the time of adjudication, determining the members cost-sharing level (e.g., Tier 1 generic, Tier 2 preferred brand, Tier 3 non-preferred brand, Tier 4 specialty). Drives copay/coinsurance calculation.. Valid values are `tier_1|tier_2|tier_3|tier_4|tier_5|non_formulary`',
    `generic_indicator` BOOLEAN COMMENT 'Indicates whether the dispensed drug is a generic equivalent. Used for generic dispensing rate (GDR) reporting, formulary compliance analytics, and PBM performance measurement.',
    `gross_drug_cost_amount` DECIMAL(18,2) COMMENT 'Total gross cost of the drug on this claim line, calculated as ingredient cost plus dispensing fee plus sales tax plus incentive amount. Used as the basis for CMS Part D gross drug cost reporting and risk corridor calculations.',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Incentive or bonus amount paid to the pharmacy for performance-based or preferred network participation on this claim line. Included in gross drug cost calculations for CMS Part D reporting.',
    `ingredient_cost_amount` DECIMAL(18,2) COMMENT 'The drug ingredient cost component of the claim line, representing the cost of the drug itself exclusive of dispensing fee, sales tax, and other charges. Key input for MAC/AWP/WAC-based reimbursement calculations and compound drug cost analysis.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `line_sequence_number` STRING COMMENT 'Sequential number identifying the position of this line within the parent pharmacy claim. Used to order compound ingredient lines and COB line splits. Starts at 1.',
    `line_status` STRING COMMENT 'Current adjudication status of this pharmacy claim line. Drives payment processing, COB resolution, and audit reporting. [ENUM-REF-CANDIDATE: paid|denied|reversed|adjusted|pending|void — promote to reference product if additional statuses are needed]. Valid values are `paid|denied|reversed|adjusted|pending|void`',
    `line_type` STRING COMMENT 'Classifies the nature of this claim line: standard single-drug fill, compound ingredient line, COB line split, reversal, or adjustment. Drives compound cost analysis and COB workflows.. Valid values are `standard|compound_ingredient|cob_split|reversal|adjustment`',
    `low_income_subsidy_indicator` BOOLEAN COMMENT 'Indicates whether the member received a Low Income Subsidy (LIS) benefit on this claim line, resulting in reduced cost-sharing. Required for CMS Part D PDE reporting and LIS reconciliation.',
    `manufacturer_discount_amount` DECIMAL(18,2) COMMENT 'Amount of manufacturer discount applied to this claim line under the CMS Part D Coverage Gap Discount Program. Counts toward the members TrOOP and is reported on the PDE record.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `ndc_code` STRING COMMENT '11-digit National Drug Code identifying the specific drug product, strength, and package size dispensed on this claim line. Sourced from FDA NDC Directory. PHI when linked to a member.. Valid values are `^[0-9]{11}$`',
    `patient_pay_amount` DECIMAL(18,2) COMMENT 'Total amount paid by the member/patient at point of sale, including copay, coinsurance, and deductible contributions. Used for Out-of-Pocket (OOP) accumulator tracking and Maximum Out-of-Pocket (MOOP) calculations.',
    `pde_submission_date` DATE COMMENT 'Date this claim line was submitted to CMS as a Prescription Drug Event (PDE) record for Part D reconciliation and risk adjustment. Null for non-Part D claims. Critical for CMS compliance and audit.',
    `pharmacy_channel` STRING COMMENT 'Distribution channel through which the drug was dispensed: retail pharmacy, mail-order pharmacy, specialty pharmacy, long-term care (LTC) pharmacy, or home infusion. Drives network contract application, reimbursement rates, and utilization analytics.. Valid values are `retail|mail_order|specialty|long_term_care|home_infusion`',
    `plan_paid_amount` DECIMAL(18,2) COMMENT 'Net amount paid by the health plan on this claim line after applying member cost-sharing, COB adjustments, and other payer amounts. Core financial metric for MLR and PMPM reporting.',
    `quantity_dispensed` DECIMAL(18,2) COMMENT 'Actual quantity of the drug dispensed (e.g., number of tablets, milliliters, grams) as reported by the pharmacy. Used for quantity limit edits, compound ingredient cost allocation, and drug utilization review (DUR).',
    `quantity_limit_indicator` BOOLEAN COMMENT 'Indicates whether a quantity limit restriction was applied to this drug claim line during adjudication. When true, the dispensed quantity was subject to plan-defined quantity limit rules.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `refill_number` STRING COMMENT 'Refill sequence number for this prescription fill. Zero indicates the original fill; subsequent values indicate refill number. Used for refill-too-soon edits, adherence monitoring, and quantity limit enforcement.',
    `reversal_timestamp` TIMESTAMP COMMENT 'Date and time when this pharmacy claim line was reversed, if applicable. Null for non-reversed lines. Used for financial reconciliation, audit trails, and identifying reversed claims in PMPM and MLR calculations.',
    `sales_tax_amount` DECIMAL(18,2) COMMENT 'State or local sales tax applied to this pharmacy claim line where applicable. Reported separately per CMS Part D PDE requirements. Zero or null in states with no drug sales tax.',
    `source_system_claim_line_key` STRING COMMENT 'Natural key or transaction identifier for this claim line as assigned by the originating PBM system (RxClaim or Argus). Used for lineage tracing, reconciliation with source system, and EDI transaction matching.',
    `specialty_drug_indicator` BOOLEAN COMMENT 'Indicates whether the drug dispensed on this line is classified as a specialty drug, typically requiring special handling, storage, or administration and subject to specialty pharmacy channel requirements and PA rules.',
    `step_therapy_indicator` BOOLEAN COMMENT 'Indicates whether this drug claim line was subject to a step therapy protocol requiring the member to try a preferred or lower-cost drug before coverage of this drug was approved.',
    `true_oop_amount` DECIMAL(18,2) COMMENT 'Members True Out-of-Pocket (TrOOP) cost contribution from this claim line, used to track progress toward the Part D catastrophic coverage threshold. Includes patient pay and applicable manufacturer discounts.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_claim_line PRIMARY KEY(`claim_line_id`)
) COMMENT 'Line-level detail for pharmacy claims supporting multi-ingredient compound claims and coordination of benefits (COB) line splits. Captures line sequence, NDC, ingredient cost, dispensing fee, sales tax, incentive amount, other payer amount, patient pay amount, and basis of cost determination. Enables granular adjudication audit trails and compound drug cost analysis.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` (
    `prior_authorization_id` BIGINT COMMENT 'Primary key for prior_authorization',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: PA requests are evaluated against the specific benefit governing the requested drug, which defines authorization_required, prior_auth_review_level, and clinical criteria. CMS Part D and ACA regulatory',
    `clinical_criteria_id` BIGINT COMMENT 'Foreign key linking to utilization.clinical_criteria. Business justification: Pharmacy PAs are approved or denied based on specific clinical criteria (InterQual, MCG, plan-specific). Linking replaces denormalized clinical_criteria_code and clinical_criteria_version with a prope',
    `condition_registry_id` BIGINT COMMENT 'Foreign key linking to care.condition_registry. Business justification: PA clinical criteria validation requires linking to the members documented condition. The existing icd_diagnosis_code on prior_authorization is a denormalized condition reference. Replacing it with a',
    `coordinator_id` BIGINT COMMENT 'Foreign key linking to care.coordinator. Business justification: Care coordinators frequently initiate, track, and follow up on PA requests for members in their caseload. Linking PA to coordinator enables coordinator-level PA workload reporting, outcome tracking, a',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: A prior authorization is requested for a specific drug (NDC). prior_authorization currently stores drug_ndc and ndc_code as denormalized STRING fields. Adding drug_master_id FK to the authoritative dr',
    `formulary_id` BIGINT COMMENT 'Identifier of the formulary associated with the members plan at the time of the prior authorization request. Determines drug tier, coverage rules, and applicable PA criteria.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan or benefit plan under which the prior authorization is being evaluated. Determines applicable formulary, tier rules, and PA criteria.',
    `medical_policy_id` BIGINT COMMENT 'Foreign key linking to utilization.medical_policy. Business justification: Specialty and biologic drug PAs are evaluated against the plans medical policy (e.g., oncology drug policies, biosimilar substitution policies). Linking enables compliance reporting on PA decisions r',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: Prior‑authorization workflow uses the members risk score to assess clinical necessity and cost containment, mandated by internal utilization management policies.',
    `subscriber_id` BIGINT COMMENT 'Identifier of the health plan member for whom the prior authorization is requested. Links to the member master record in the Core Administration Platform (Facets/QNXT).',
    `original_pa_prior_authorization_id` BIGINT COMMENT 'Reference to the original prior authorization record when this record represents a renewal, appeal, or modification. Enables tracking of the full PA lifecycle chain. Null for initial requests.',
    `pa_decision_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_decision. Business justification: Needed for compliance reporting that ties each prior authorization to the final decision, supporting regulatory PA decision audit.',
    `pa_request_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_request. Business justification: Required for PA audit report linking each prior authorization record to its originating request, enabling traceability of request‑to‑authorization lifecycle.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Prior authorization decisions are benefit-year and policy-specific. The PA must reference the policy to validate formulary applicability, coverage limits, and cost-sharing. A PA approved under one pol',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: PA management requires linking each PA request to the credentialed prescribing provider in the provider master. Enables prescriber-level PA approval rate reporting, network participation validation, a',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Specialty-based PA clinical criteria routing is a named operational process — oncology, rheumatology, and neurology PAs use specialty-specific criteria sets. Linking PA records to the prescribers spe',
    `program_id` BIGINT COMMENT 'Foreign key linking to care.program. Business justification: Specialty drug PA requests are processed within specific care management programs (oncology, transplant, rare disease). Linking PA to program enables program-level PA volume, approval rate, and turnar',
    `appeal_indicator` BOOLEAN COMMENT 'Indicates whether this prior authorization record is associated with a member or prescriber appeal of a prior denial. True = this PA is an appeal case.',
    `approved_days_supply` STRING COMMENT 'Number of days of drug therapy authorized under this prior authorization. Used by the PBM to enforce dispensing limits and by CMS Part D for compliance reporting.',
    `approved_quantity` DECIMAL(18,2) COMMENT 'Total quantity of the drug authorized for dispensing under this prior authorization (e.g., number of tablets, milliliters, units). Enforced at point-of-sale by the PBM adjudication system.',
    `approved_refills` STRING COMMENT 'Number of refills authorized under this prior authorization in addition to the initial fill. Enforced by the PBM adjudication system at point-of-sale.',
    `cms_part_d_reportable` BOOLEAN COMMENT 'Indicates whether this prior authorization record is subject to CMS Part D PA reporting requirements. True = must be included in CMS Part D PA reporting submissions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this prior authorization record was first created in the Silver Layer data platform. Used for data lineage, audit trail, and Silver Layer processing compliance.',
    `criteria_met` BOOLEAN COMMENT 'Indicates whether the submitted clinical information met the applicable clinical criteria (InterQual/MCG) for the requested drug. True = criteria met (supports approval); False = criteria not met (supports denial).',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `decision_timestamp` TIMESTAMP COMMENT 'Exact date and time the prior authorization decision (approval, denial, or pend) was rendered by the clinical reviewer or automated adjudication engine. Used to calculate turnaround time against CMS and URAC standards.',
    `denial_reason_code` STRING COMMENT 'Standardized code indicating the reason for denial of the prior authorization request (e.g., not medically necessary, step therapy not completed, quantity limit exceeded, non-covered drug). Populated only when pa_status = denied. Used for member appeals and CMS Part D reporting.',
    `denial_reason_description` STRING COMMENT 'Free-text description of the denial reason, providing clinical or administrative context beyond the denial reason code. Included in member and prescriber denial notices per CMS and state DOI requirements.',
    `dispensing_channel` STRING COMMENT 'Pharmacy dispensing channel authorized for this prior authorization (retail, mail-order, specialty pharmacy, long-term care, or home infusion). Determines which pharmacy network is eligible to dispense.. Valid values are `retail|mail_order|specialty|long_term_care|home_infusion`',
    `drug_tier` STRING COMMENT 'Formulary tier of the requested drug at the time of the prior authorization request. Determines cost-sharing obligations and PA criteria applied.. Valid values are `tier_1|tier_2|tier_3|tier_4|tier_5|specialty`',
    `dur_outcome_code` STRING COMMENT 'NCPDP-standardized Drug Utilization Review (DUR) outcome code resulting from prospective DUR screening performed during PA adjudication (e.g., drug-drug interaction, drug-disease contraindication, duplicate therapy). Sourced from PBM system (RxClaim/Argus).',
    `effective_end_date` DATE COMMENT 'Date on which the prior authorization expires and is no longer valid for dispensing. After this date, a new PA request is required. Nullable for open-ended authorizations.',
    `effective_start_date` DATE COMMENT 'Date from which the approved prior authorization is valid for dispensing. Pharmacies and PBM adjudication systems use this date to confirm dispensing eligibility.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: CoverageEligibilityRequest)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `j_code` STRING COMMENT '',
    `lob` STRING COMMENT 'Line of Business (LOB) under which the members coverage falls, determining applicable regulatory requirements, formulary rules, and PA criteria (e.g., Commercial, Medicare Part D, Medicaid, ACA Marketplace).. Valid values are `commercial|medicare_part_d|medicaid|marketplace|cobra|individual`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free-text clinical notes entered by the reviewing clinician during the prior authorization evaluation, capturing clinical rationale, additional context, or instructions for the prescriber or pharmacy. Contains Protected Health Information (PHI).',
    `pa_reference_number` STRING COMMENT 'Externally-known, human-readable prior authorization reference number assigned by the Pharmacy Benefit Management (PBM) system (RxClaim or Argus) or Utilization Management (UM) system (InterQual/MCG). Used on Explanation of Benefits (EOB) and communicated to prescribers and pharmacies.. Valid values are `^PA-[0-9]{10}$`',
    `pa_status` STRING COMMENT 'Current lifecycle status of the prior authorization request. Drives dispensing eligibility at the pharmacy and CMS Part D PA reporting. [ENUM-REF-CANDIDATE: approved|denied|pending|cancelled|expired|appealed — promote to reference product if additional statuses are needed]. Valid values are `approved|denied|pending|cancelled|expired|appealed`',
    `pa_type` STRING COMMENT 'Category of prior authorization criteria applied, indicating the clinical or formulary reason the drug requires PA review (e.g., specialty drug, non-preferred tier, step therapy requirement, quantity limit, age restriction, off-label use). [ENUM-REF-CANDIDATE: specialty|non_preferred|step_therapy|quantity_limit|age_restriction|off_label — promote to reference product]. Valid values are `specialty|non_preferred|step_therapy|quantity_limit|age_restriction|off_label`',
    `prescriber_npi` STRING COMMENT '10-digit National Provider Identifier (NPI) of the prescribing physician or authorized prescriber requesting the prior authorization. Sourced from the Provider Management System (Cactus/ProviderSource) and validated against NPPES.. Valid values are `^[0-9]{10}$`',
    `quantity_limit_applied` BOOLEAN COMMENT 'Indicates whether a quantity limit restriction was a factor in the prior authorization evaluation. True = quantity limit rules were applied during adjudication.',
    `received_timestamp` TIMESTAMP COMMENT 'Exact date and time the prior authorization request was received by the Utilization Management (UM) system (InterQual/MCG) or PBM system (RxClaim/Argus). Used for precise turnaround time calculation and regulatory compliance.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `request_date` DATE COMMENT 'Calendar date on which the prior authorization request was submitted by the prescriber or pharmacy. Used for turnaround time measurement and CMS Part D compliance reporting.',
    `request_type` STRING COMMENT 'Classification of the prior authorization request indicating whether it is a new request, renewal of an existing authorization, appeal of a denial, expedited urgent request, or retrospective review.. Valid values are `new|renewal|appeal|expedited|retrospective`',
    `requested_days_supply` STRING COMMENT '',
    `requested_quantity` DECIMAL(18,2) COMMENT '',
    `review_level` STRING COMMENT 'Level of clinical review applied to the prior authorization request, indicating whether it was reviewed by a pharmacist, physician, peer-to-peer consultation, or medical director. Escalation level affects turnaround time standards.. Valid values are `pharmacist|physician|peer_to_peer|medical_director`',
    `source_system_pa_code` STRING COMMENT 'Native prior authorization identifier from the originating operational system (RxClaim, Argus, InterQual, or MCG). Preserved for reconciliation, audit, and cross-system traceability in the Silver Layer.',
    `specialty_drug_flag` BOOLEAN COMMENT 'Indicates whether the requested drug is classified as a specialty drug requiring specialty pharmacy dispensing and enhanced clinical review. Specialty drugs typically have higher cost-sharing and stricter PA criteria.',
    `step_therapy_completed` BOOLEAN COMMENT 'Indicates whether the member has documented evidence of completing the required step therapy (tried and failed prerequisite drugs) as required by the formulary PA criteria. Populated when step_therapy_required = True.',
    `step_therapy_completed_flag` BOOLEAN COMMENT '',
    `step_therapy_required` BOOLEAN COMMENT 'Indicates whether the prior authorization requires the member to have tried and failed one or more preferred or lower-tier drugs (step therapy) before the requested drug is authorized. True = step therapy applies.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this prior authorization record was last modified in the Silver Layer data platform, reflecting status changes, decision updates, or data corrections. Used for change data capture and audit.',
    CONSTRAINT pk_prior_authorization PRIMARY KEY(`prior_authorization_id`)
) COMMENT 'Prior authorization (PA) record for specialty and non-preferred drugs requiring clinical review before dispensing. Captures PA request date, requesting prescriber NPI, member ID, drug NDC, diagnosis codes (ICD), clinical criteria applied (InterQual/MCG), authorization status (approved/denied/pending), approved quantity, approved days supply, effective date range, and denial reason codes. Interfaces with the Utilization Management system and supports CMS Part D PA reporting.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` (
    `dispensing_pharmacy_id` BIGINT COMMENT 'Unique surrogate identifier for the dispensing pharmacy record within the PBM network master. Primary key for this entity.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Hospital outpatient pharmacies and health-system-owned dispensing pharmacies are credentialed as part of a facility. Linking dispensing_pharmacy to facility.facility_id supports facility-based pharmac',
    `provider_id` BIGINT COMMENT 'The 7-digit NCPDP pharmacy identifier (formerly NABP number) used as the primary pharmacy identifier in PBM claim transactions, formulary lookups, and pharmacy network directories. Sourced from RxClaim or Argus PBM system.',
    `par_agreement_id` BIGINT COMMENT 'Foreign key linking to network.par_agreement. Business justification: A dispensing pharmacys participation in a network is governed by a participation agreement (par_agreement). Health plans need this link to retrieve credentialing status, reimbursement methodology, an',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Required for network participation reporting and CMS network adequacy; each pharmacy must be linked to the provider network it belongs to.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.tier. Business justification: Dispensing pharmacies participate in a network at a specific tier (preferred, standard, specialty), which drives member cost-share differentials. network_tier is a denormalized plain attribute; replac',
    `accepts_electronic_prescriptions` BOOLEAN COMMENT 'Indicates whether the pharmacy is enabled to receive electronic prescriptions (e-prescribing) via NCPDP SCRIPT standard. Required for controlled substance e-prescribing (EPCS) compliance in many states.',
    `address_line1` STRING COMMENT 'Primary street address of the pharmacy dispensing location. Used for member pharmacy locator, network directory, and regulatory reporting.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, unit, floor) for the pharmacy dispensing location.',
    `awp_discount_percent` DECIMAL(18,2) COMMENT 'The contracted discount percentage applied to the AWP for brand drug ingredient cost reimbursement. For example, AWP minus 15% means awp_discount_percent = 15.00. Applies when ingredient_cost_basis is awp_discount. Commercially sensitive contract term.',
    `chain_independent_flag` STRING COMMENT 'Indicates whether the pharmacy is part of a chain organization (e.g., CVS, Walgreens, Rite Aid) or operates as an independent pharmacy. Affects contract terms, reimbursement rates, and network tier assignment.. Valid values are `chain|independent`',
    `chain_organization_name` STRING COMMENT 'Name of the parent chain organization if the pharmacy is a chain location (e.g., CVS Health, Walgreens Boots Alliance). Null for independent pharmacies. Used for chain-level contract management and performance reporting.',
    `city` STRING COMMENT 'City of the pharmacy dispensing location. Used for geographic network analysis, member access reporting, and CMS Part D network adequacy compliance.',
    `cold_chain_certified` BOOLEAN COMMENT 'Indicates whether the pharmacy holds cold chain certification for temperature-sensitive drug storage and shipping (e.g., biologics, insulin, vaccines). Required for specialty and mail-order pharmacies dispensing refrigerated or frozen medications.',
    `contract_effective_date` DATE COMMENT 'Date on which the pharmacys network participation contract becomes effective. Used to validate claim eligibility by service date and for contract lifecycle management.',
    `contract_termination_date` DATE COMMENT 'Date on which the pharmacys network participation contract ends or was terminated. Null for active open-ended contracts. Used for claim eligibility validation and network adequacy gap analysis.',
    `contract_type` STRING COMMENT 'Indicates whether the pharmacy reimbursement contract is negotiated directly with the health plan (direct) or administered through the PBM intermediary (PBM-administered). Affects financial settlement, audit rights, and MAC list applicability.. Valid values are `direct|pbm_administered`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dispensing pharmacy record was first created in the PBM network master. Supports audit trail, data lineage, and regulatory record retention requirements.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `dispensing_fee_amount` DECIMAL(18,2) COMMENT 'The contracted per-prescription dispensing fee paid to the pharmacy in addition to ingredient cost reimbursement. Expressed in USD. May vary by pharmacy type, drug type, or days supply. Commercially sensitive contract term.',
    `dispensing_state_code` STRING COMMENT 'Two-letter USPS state code of the state in which the pharmacy is licensed to dispense. May differ from the physical address state for mail-order pharmacies licensed in multiple states. Used for state-level regulatory compliance and claim adjudication.. Valid values are `^[A-Z]{2}$`',
    `doing_business_as_name` STRING COMMENT 'Trade name or DBA name under which the pharmacy operates if different from the legal business name. Used in member-facing directories and communications.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fax_number` STRING COMMENT 'Fax number for the pharmacy dispensing location. Used for prior authorization transmissions, prescription transfers, and clinical communications.. Valid values are `^[0-9]{10}$`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Organization)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `ingredient_cost_basis` STRING COMMENT 'The pricing benchmark used to calculate ingredient cost reimbursement for drug claims. AWP (Average Wholesale Price) discount is most common for brand drugs; MAC (Maximum Allowable Cost) applies to generics; WAC (Wholesale Acquisition Cost) and NADAC (National Average Drug Acquisition Cost) are alternative benchmarks. Sourced from PBM contract terms in RxClaim/Argus.. Valid values are `awp_discount|mac|wac|nadac`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `line_of_business` STRING COMMENT 'The health insurance line of business for which this pharmacy network participation record applies. A pharmacy may have separate network records per LOB with different contract terms. Drives claim adjudication routing and formulary selection.. Valid values are `commercial|medicare_part_d|medicaid|exchange|cobra`',
    `mail_order_capable` BOOLEAN COMMENT 'Indicates whether the pharmacy is certified and operationally capable of fulfilling mail-order prescriptions (90-day supply, home delivery). Drives claim routing and member benefit design enforcement.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `ncpdp_chain_code` STRING COMMENT 'NCPDP-assigned 4-digit chain code identifying the pharmacy chain organization. Used for chain-level contract application and bulk reimbursement rate assignment in the PBM system.. Valid values are `^[0-9]{4}$`',
    `network_effective_date` DATE COMMENT 'Date on which the pharmacys current network participation status became effective. Distinct from contract_effective_date; captures the most recent network status change date (e.g., reactivation after suspension).',
    `network_participation_status` STRING COMMENT 'Current status of the pharmacys participation in the PBM network. Drives real-time claim adjudication eligibility checks in RxClaim/Argus. Active pharmacies are eligible to dispense covered drugs; inactive/terminated pharmacies are rejected at point-of-sale.. Valid values are `active|inactive|suspended|terminated|pending`',
    `network_termination_date` DATE COMMENT 'Date on which the pharmacys network participation was or is scheduled to be terminated. Null for currently active network participants. Used for claim eligibility validation and network adequacy gap analysis.',
    `performance_audit_provision` BOOLEAN COMMENT 'Indicates whether the pharmacy contract includes audit provisions allowing the PBM or health plan to conduct on-site or desk audits of dispensing records, pricing, and compliance. Required for CMS Part D sponsor oversight obligations.',
    `pharmacy_name` STRING COMMENT 'Legal business name of the dispensing pharmacy as registered with the state board of pharmacy and NCPDP. Used in member-facing communications, EOB documents, and provider directory.',
    `pharmacy_type` STRING COMMENT 'Classification of the pharmacy by dispensing channel and operational model. Drives claim routing, reimbursement logic, and formulary applicability within the PBM system (RxClaim/Argus). [ENUM-REF-CANDIDATE: retail|mail_order|specialty|long_term_care|compounding — promote to reference product if additional types emerge]. Valid values are `retail|mail_order|specialty|long_term_care|compounding`',
    `phone_number` STRING COMMENT 'Primary telephone number for the pharmacy dispensing location. Used for member contact, prior authorization coordination, and provider directory.. Valid values are `^[0-9]{10}$`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `signature_required_flag` BOOLEAN COMMENT 'Indicates whether the pharmacy requires patient or authorized representative signature upon delivery for mail-order or specialty drug shipments. Relevant for controlled substances and high-value specialty medications.',
    `source_system_code` STRING COMMENT 'Identifies the operational source system from which this pharmacy record was ingested (e.g., RxClaim, Argus PBM, Cactus credentialing system). Supports data lineage tracking and reconciliation in the Databricks lakehouse Silver layer.. Valid values are `rxclaim|argus|cactus|provider_source|manual`',
    `specialty_accreditation_code` STRING COMMENT 'Accreditation body certification held by the pharmacy for specialty drug dispensing. URAC, ACHC, and NABP PCAB are the primary specialty pharmacy accreditation bodies recognized by health plans and PBMs. Required for specialty network participation. [ENUM-REF-CANDIDATE: urac|achc|jcaho|nabp_pcab|none — promote to reference product if multi-accreditation tracking is needed]. Valid values are `urac|achc|jcaho|nabp_pcab|none`',
    `state_code` STRING COMMENT 'Two-letter USPS state abbreviation for the pharmacy dispensing location. Used for state-level licensure validation, network adequacy reporting, and regulatory compliance.. Valid values are `^[A-Z]{2}$`',
    `twenty_four_hour_flag` BOOLEAN COMMENT 'Indicates whether the pharmacy operates 24 hours per day, 7 days per week. Used for network adequacy reporting and member access analysis, particularly for CMS Part D access requirements.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the dispensing pharmacy record was most recently updated. Used for change data capture, data quality monitoring, and audit trail in the Databricks Silver layer.',
    `zip_code` STRING COMMENT 'US ZIP or ZIP+4 postal code for the pharmacy dispensing location. Used for geographic network adequacy analysis, member proximity calculations, and CMS Part D access reporting.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    CONSTRAINT pk_dispensing_pharmacy PRIMARY KEY(`dispensing_pharmacy_id`)
) COMMENT 'Master record for retail, mail-order, and specialty pharmacies participating in the PBM network. Captures pharmacy identity: NPI, NCPDP provider ID, pharmacy name, chain/independent flag, pharmacy type (retail/mail/specialty/long-term care/compounding), address, phone, DEA number, state license. Captures network participation and contractual reimbursement terms: network tier (preferred/standard/specialty), network participation status, dispensing fee schedule, ingredient cost reimbursement basis (AWP discount/MAC/WAC), contract type (direct/PBM-administered), contract effective date range, performance requirements, audit provisions, mail-order fulfillment capabilities (cold chain certification, signature requirements), and per-pharmacy or per-chain contract variations. This is the SSOT for pharmacy provider identity, network participation, and all pharmacy-level reimbursement contract terms within the pharmacy domain; detailed credentialing lives in the provider/credential domains.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` (
    `pbm_contract_id` BIGINT COMMENT 'Unique surrogate identifier for the PBM contract record in the pharmacy domain silver layer. Primary key for this entity. Role: MASTER_AGREEMENT.',
    `formulary_id` BIGINT COMMENT 'Reference to the drug formulary associated with this PBM contract. The formulary defines covered drugs, tier assignments, and utilization management rules governed by this contract.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: PBM contracts are executed on behalf of specific health plans. Financial reconciliation (rebate pass-through, PMPM guarantees), CMS contract number reporting, and PBM performance guarantee tracking al',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: PBM contracts are scoped to specific pharmacy networks; health plans must know which provider_network a PBM contract covers for network adequacy reporting, benefit administration, and CMS Part D compl',
    `amendment_date` DATE COMMENT 'Date of the most recent amendment or addendum executed against this PBM contract. Null if no amendments have been made since original execution. Used to track contract evolution and ensure current terms are applied in adjudication.',
    `audit_frequency` STRING COMMENT 'Contractually specified frequency at which the health plan may exercise audit rights over the PBM. Relevant only when audit_rights_flag is True. Drives compliance calendar and vendor oversight scheduling.. Valid values are `annual|biennial|on_demand|quarterly|not_applicable`',
    `audit_rights_flag` BOOLEAN COMMENT 'Indicates whether the health plan has contractual audit rights to inspect PBM financial records, rebate calculations, MAC list pricing, and claims adjudication data. True = audit rights granted; False = not included. Critical for compliance and financial oversight.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the PBM contract automatically renews at the end of the contract term unless notice of termination is provided. True = auto-renews; False = requires affirmative renewal action.',
    `awp_discount_mail_pct` DECIMAL(18,2) COMMENT 'Contracted discount percentage off AWP (Average Wholesale Price) applied to drug ingredient cost reimbursement at mail-order pharmacies. Typically deeper than retail AWP discounts due to mail-order volume.',
    `awp_discount_retail_pct` DECIMAL(18,2) COMMENT 'Contracted discount percentage off AWP (Average Wholesale Price) applied to brand and generic drug ingredient cost reimbursement at retail pharmacies. A core financial term in PBM contracts (e.g., AWP minus 18% for generics).',
    `cms_contract_number` STRING COMMENT 'CMS (Centers for Medicare and Medicaid Services) contract number associated with the Medicare Part D plan under which this PBM contract operates (e.g., H1234 for MA-PD, S1234 for PDP). Required for CMS Part D reporting and RAPS/EDPS submissions. Null for non-Medicare LOBs.. Valid values are `^H[0-9]{4}$|^S[0-9]{4}$|^R[0-9]{4}$|^E[0-9]{4}$`',
    `contract_name` STRING COMMENT 'Descriptive name of the PBM contract (e.g., Express Scripts ASO Agreement FY2024). Used for display in reporting dashboards and contract management workflows.',
    `contract_number` STRING COMMENT 'Externally-known, human-readable contract reference number assigned by the health plan or PBM vendor at execution. Used for correspondence, audits, and regulatory filings. Maps to the contract identifier in RxClaim or Argus PBM system.',
    `contract_owner_name` STRING COMMENT 'Name of the health plan employee or department responsible for managing this PBM contract relationship. Used for escalation routing, audit coordination, and vendor governance.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the PBM contract. Draft indicates the contract is under negotiation; active indicates it is in force; suspended indicates temporarily halted; terminated indicates early cancellation; expired indicates natural end-of-term; pending_renewal indicates renewal is in progress.. Valid values are `draft|active|suspended|terminated|expired|pending_renewal`',
    `contract_type` STRING COMMENT 'Classification of the PBM contract arrangement. ASO (Administrative Services Only) means the health plan retains financial risk; full_risk means the PBM assumes drug spend risk; carve_out means pharmacy benefits are separated from medical; pass_through means drug costs are passed at actual cost; hybrid combines elements. [ENUM-REF-CANDIDATE: ASO|full_risk|carve_out|pass_through|hybrid — promote to reference product if additional types emerge]. Valid values are `ASO|full_risk|carve_out|pass_through|hybrid`',
    `contract_version` STRING COMMENT 'Version identifier for the PBM contract document, incremented with each amendment or renewal (e.g., 1.0, 2.1, Amendment_3). Supports contract lifecycle management and audit trail for regulatory examinations.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `dispensing_fee_mail_order` DECIMAL(18,2) COMMENT 'Contracted dispensing fee in USD paid per prescription claim fulfilled through mail-order pharmacy channels under this PBM contract. Typically lower than retail due to volume efficiencies.',
    `dispensing_fee_retail` DECIMAL(18,2) COMMENT 'Contracted dispensing fee in USD paid to retail network pharmacies per prescription claim under this PBM contract. Part of the pharmacy reimbursement formula alongside ingredient cost (AWP/WAC/MAC).',
    `dispensing_fee_specialty` DECIMAL(18,2) COMMENT 'Contracted dispensing fee in USD paid per specialty drug prescription claim under this PBM contract. Specialty pharmacy dispensing fees are negotiated separately due to the high-cost, high-touch nature of specialty drugs.',
    `dur_program_flag` BOOLEAN COMMENT 'Indicates whether Drug Utilization Review (DUR) — including prospective, concurrent, and retrospective DUR — is included as a service under this PBM contract. True = DUR services included; False = not included.',
    `effective_date` DATE COMMENT 'Date on which the PBM contract becomes legally binding and operationally active. Governs when PBM services, pricing schedules, and rebate guarantees take effect. Format: yyyy-MM-dd.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `generic_dispensing_rate_guarantee` DECIMAL(18,2) COMMENT 'Contractually guaranteed minimum generic dispensing rate (GDR) as a percentage of total prescription claims. If the PBM fails to achieve this rate, financial penalties or credits apply. Key cost-management metric in PBM contracts.',
    `governing_state_code` STRING COMMENT 'Two-letter US state code of the state whose laws govern this PBM contract for dispute resolution and regulatory compliance purposes. Relevant for state DOI oversight, MAC transparency laws, and PBM regulation.. Valid values are `^[A-Z]{2}$`',
    `ingredient_cost_basis` STRING COMMENT 'The drug pricing benchmark used as the basis for ingredient cost reimbursement under this contract. AWP (Average Wholesale Price), WAC (Wholesale Acquisition Cost), MAC (Maximum Allowable Cost), NADAC (National Average Drug Acquisition Cost), or AAC (Actual Acquisition Cost). Determines the reimbursement formula for drug ingredient costs.. Valid values are `AWP|WAC|MAC|NADAC|AAC`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lob_scope` STRING COMMENT 'Line of Business (LOB) covered under this PBM contract. Determines which member populations and benefit programs are governed by this agreement. A single contract may cover one or multiple LOBs. [ENUM-REF-CANDIDATE: commercial|medicare_part_d|medicaid|exchange|all — promote to reference product for multi-LOB support]. Valid values are `commercial|medicare_part_d|medicaid|exchange|all`',
    `mac_list_reference` STRING COMMENT 'Identifier or name of the MAC (Maximum Allowable Cost) list applied under this PBM contract for generic and multi-source drug reimbursement. MAC lists cap reimbursement for generics below AWP. References the specific MAC list version maintained by the PBM.',
    `mail_order_flag` BOOLEAN COMMENT 'Indicates whether mail-order pharmacy dispensing services are included in the scope of this PBM contract. True = mail order included; False = retail-only or carved out.',
    `mail_order_penetration_guarantee` DECIMAL(18,2) COMMENT 'Contractually guaranteed minimum mail-order pharmacy utilization rate as a percentage of eligible maintenance drug claims. Drives cost savings through mail-order channel incentives.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `performance_guarantee_flag` BOOLEAN COMMENT 'Indicates whether the PBM contract includes financial performance guarantees (e.g., generic dispensing rate, mail-order penetration, member satisfaction scores). True = performance guarantees included; False = not included.',
    `prior_auth_flag` BOOLEAN COMMENT 'Indicates whether prior authorization (PA) requirements for specialty and non-formulary drugs are administered by the PBM under this contract. True = PBM manages PA; False = health plan manages PA internally.',
    `quantity_limit_flag` BOOLEAN COMMENT 'Indicates whether quantity limit (QL) utilization management rules are in scope under this PBM contract. Quantity limits restrict the amount of a drug dispensed per fill or per time period. True = quantity limits apply; False = not applicable.',
    `rebate_guarantee_pmpm` DECIMAL(18,2) COMMENT 'Contractually guaranteed minimum rebate amount expressed as Per Member Per Month (PMPM) in USD that the PBM must remit to the health plan. A key financial performance guarantee in PBM contracts. Used for actuarial reserving and financial reconciliation.',
    `rebate_pass_through_pct` DECIMAL(18,2) COMMENT 'Percentage of manufacturer drug rebates that the PBM is contractually obligated to pass through to the health plan (e.g., 100% pass-through vs. spread-based retention). Critical for MLR (Medical Loss Ratio) calculations and CMS Part D compliance.',
    `rebate_reconciliation_lag_days` STRING COMMENT 'Number of calendar days after the close of a settlement period within which the PBM must provide rebate invoices and supporting data to the health plan. Used for financial close scheduling and IBNR reserve calculations.',
    `rebate_settlement_frequency` STRING COMMENT 'Contractually specified frequency at which the PBM remits drug manufacturer rebates to the health plan. Drives cash flow forecasting, accounts receivable management, and actuarial IBNR (Incurred But Not Reported) rebate estimates.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this PBM contract record was first created in the data platform. Used for audit trail, data lineage, and compliance with HIPAA record retention requirements. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this PBM contract record was most recently modified in the data platform. Supports change detection, SCD (Slowly Changing Dimension) processing, and audit trail requirements. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `renewal_notice_days` STRING COMMENT 'Number of calendar days prior to contract termination_date by which either party must provide written notice of intent not to renew. Operationally critical for contract management and vendor transitions.',
    `source_system_code` STRING COMMENT 'Identifies the operational source system from which this PBM contract record was ingested into the lakehouse silver layer (e.g., RxClaim, Argus, manual entry). Supports data lineage and reconciliation.. Valid values are `RxClaim|Argus|manual|other`',
    `specialty_pharmacy_flag` BOOLEAN COMMENT 'Indicates whether specialty pharmacy benefit management (high-cost biologics, specialty injectables) is within the scope of this PBM contract. True = specialty pharmacy included; False = carved out or not applicable.',
    `step_therapy_flag` BOOLEAN COMMENT 'Indicates whether step therapy protocols are included in the scope of this PBM contract. Step therapy requires members to try lower-cost drugs before coverage of higher-cost alternatives is authorized. True = step therapy applies; False = not applicable.',
    `termination_date` DATE COMMENT 'Date on which the PBM contract ends or was terminated. Null for open-ended contracts. Distinguishes between scheduled expiration and early termination when combined with contract_status. Format: yyyy-MM-dd.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_pbm_contract PRIMARY KEY(`pbm_contract_id`)
) COMMENT 'Master record for PBM (Pharmacy Benefit Manager) contracts governing the relationship between the health plan and the PBM (e.g., RxClaim, Argus). Captures contract name, PBM vendor, contract type (ASO/full-risk/carve-out), effective date range, rebate guarantee terms, dispensing fee schedules, MAC list reference, performance guarantees, audit rights, and LOB scope. This is the SSOT for PBM contractual terms within the pharmacy domain.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` (
    `formulary_exception_id` BIGINT COMMENT 'Primary key for formulary_exception',
    `adverse_determination_id` BIGINT COMMENT 'Foreign key linking to appeal.adverse_determination. Business justification: CMS Part D requires that denied formulary exceptions generate an adverse determination (coverage determination notice). Direct link from formulary_exception to adverse_determination supports CMS cover',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: Formulary exceptions (CMS coverage determinations) must reference the specific drug benefit to determine applicable exception criteria, EHB coverage mandates, and regulatory timelines. CMS requires ex',
    `case_id` BIGINT COMMENT 'Identifier of the associated appeal record if the member or prescriber has filed an appeal against a denied formulary exception. Links to the appeals management entity. Null if no appeal has been filed.',
    `clinical_criteria_id` BIGINT COMMENT 'Foreign key linking to utilization.clinical_criteria. Business justification: Formulary exception decisions (step-therapy exceptions, medical necessity exceptions) are evaluated against specific clinical criteria. Linking supports CMS coverage determination compliance documenta',
    `condition_registry_id` BIGINT COMMENT 'Foreign key linking to care.condition_registry. Business justification: CMS Part D formulary exception requirements mandate clinical justification tied to a documented diagnosis. The existing diagnosis_code on formulary_exception is denormalized. Linking to condition_regi',
    `coordinator_id` BIGINT COMMENT 'Foreign key linking to care.coordinator. Business justification: Care coordinators initiate and manage formulary exception requests on behalf of members in their caseload. Linking formulary_exception to coordinator enables coordinator workload tracking, exception o',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: A formulary exception is requested for a specific drug. formulary_exception currently stores drug_ndc (STRING) and drug_name (STRING) as denormalized fields. Adding drug_master_id FK to drug_master no',
    `formulary_id` BIGINT COMMENT 'Identifier of the specific formulary against which the exception is being evaluated. A plan may maintain multiple formularies (e.g., commercial, Medicare Part D, Medicaid). Links to the formulary master in the PBM system (RxClaim/Argus).',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health benefit plan under which the formulary exception is being requested. Determines the applicable formulary, tier structure, and exception adjudication rules.',
    `medical_policy_id` BIGINT COMMENT 'Foreign key linking to utilization.medical_policy. Business justification: Formulary exceptions for non-formulary or experimental drugs are evaluated against the plans medical policy governing coverage. Linking enables compliance reporting on whether exception decisions ali',
    `identity_id` BIGINT COMMENT 'Identifier of the health plan member on whose behalf the formulary exception request is submitted. Links to the member master record in the core administration platform (Facets/QNXT).',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Formulary exception requests are filed under a specific policy and benefit year. The policy determines which formulary applies, the drugs current tier, and applicable cost-sharing. CMS coverage deter',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider. Business justification: Formulary exception requests are filed by prescribing providers on behalf of members. Linking to the provider master enables prescriber-level exception rate reporting, network compliance checks, and C',
    `prior_authorization_id` BIGINT COMMENT 'Identifier of an associated Prior Authorization (PA) request in the UM system (InterQual/MCG) when the formulary exception is linked to or triggered by a PA requirement. Null if no PA is associated.',
    `appeal_rights_notification_date` DATE COMMENT 'Date on which the appeal rights notification was sent to the member and prescriber following a denial. Required for CMS Part D compliance tracking and audit purposes.',
    `appeal_rights_notified` BOOLEAN COMMENT 'Indicates whether the required appeal rights notification was sent to the member and prescriber following a denial decision, as mandated by CMS Part D regulations. True = notification sent; False = notification not yet sent.',
    `clinical_justification` STRING COMMENT 'Free-text clinical rationale provided by the prescriber or member supporting the formulary exception request. May include diagnosis, treatment history, contraindications to formulary alternatives, or medical necessity documentation. Treated as confidential clinical information.',
    `cms_coverage_determination_type` STRING COMMENT 'CMS-defined classification of the coverage determination process type for Part D reporting. Standard: routine 72-hour review; Expedited: 24-hour urgent review; Reopen: plan-initiated reconsideration; Revised: updated determination on a prior decision.. Valid values are `standard|expedited|reopen|revised`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the formulary exception record was first created in the data platform. Used for audit trail, data lineage, and Silver layer ingestion tracking.',
    `current_drug_tier` STRING COMMENT 'The formulary tier at which the requested drug is currently placed (or non_formulary if not on the formulary) at the time the exception request is submitted. Used to assess the tier differential and cost-sharing impact of the exception. [ENUM-REF-CANDIDATE: tier_1|tier_2|tier_3|tier_4|tier_5|specialty|non_formulary — 7 candidates stripped; promote to reference product]',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `days_supply_requested` STRING COMMENT 'Number of days of drug supply requested in the formulary exception, applicable for quantity limit or day supply override exceptions. Standard values are 30, 60, or 90 days.',
    `decision_date` DATE COMMENT 'Calendar date on which the final determination (approval or denial) was made on the formulary exception request. Used to calculate turnaround time and assess CMS timeliness compliance.',
    `decision_timestamp` TIMESTAMP COMMENT 'Precise date and time the exception determination was rendered. Enables exact measurement of response time against CMS 72-hour standard and 24-hour expedited decision deadlines.',
    `denial_reason_code` STRING COMMENT 'Standardized code indicating the reason for denial of the formulary exception request (e.g., formulary alternative available, insufficient clinical documentation, drug not medically necessary). Null for approved or pending requests. Used in EOB and appeal rights notifications.',
    `denial_reason_description` STRING COMMENT 'Human-readable explanation of the reason for denial of the formulary exception request. Included in the written notice of denial sent to the member and prescriber as required by CMS Part D regulations.',
    `effective_end_date` DATE COMMENT 'Date through which an approved formulary exception remains valid. After this date, the member must reapply or the standard formulary restriction resumes. Null for open-ended approvals or non-approved requests.',
    `effective_start_date` DATE COMMENT 'Date from which an approved formulary exception is valid and the member may obtain the drug at the excepted tier or without the formulary restriction. Null for denied or pending requests.',
    `exception_request_number` STRING COMMENT 'Externally-visible, human-readable unique reference number assigned to the formulary exception request at intake. Used by members, prescribers, and pharmacies to track the status of the request. Generated by the PBM system (RxClaim/Argus) or UM system.',
    `exception_status` STRING COMMENT 'Current lifecycle status of the formulary exception request. Pending: under review; Approved: exception granted; Denied: exception not granted; Withdrawn: requestor cancelled; Expired: approved exception past effective period; Appealed: denial under appeal review.. Valid values are `pending|approved|denied|withdrawn|expired|appealed`',
    `exception_type` STRING COMMENT 'Classification of the formulary exception request indicating the specific restriction being challenged. Values: non_formulary (drug not on formulary), tier_exception (request lower cost-sharing tier), pa_exception (override Prior Authorization requirement), step_therapy_exception (bypass step therapy protocol), quantity_limit_exception (override quantity/day supply limit), coverage_determination (standard CMS Part D coverage determination). [ENUM-REF-CANDIDATE: non_formulary|tier_exception|pa_exception|step_therapy_exception|quantity_limit_exception|coverage_determination — promote to reference product]. Valid values are `non_formulary|tier_exception|pa_exception|step_therapy_exception|quantity_limit_exception|coverage_determination`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: MedicationKnowledge)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `formulary_alternative_ndc` STRING COMMENT '11-digit NDC of the formulary-covered alternative drug suggested by the plan when denying a non-formulary or tier exception request. Required by CMS to be communicated to the member and prescriber in the denial notice.. Valid values are `^[0-9]{11}$`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_expedited` BOOLEAN COMMENT 'Indicates whether the formulary exception request was submitted and processed under the expedited (24-hour) review pathway, as opposed to the standard (72-hour) pathway. Expedited requests require prescriber attestation that the standard timeframe would seriously jeopardize the members life, health, or ability to regain maximum function.',
    `line_of_business` STRING COMMENT 'Line of Business (LOB) under which the formulary exception is processed. Determines applicable regulatory framework, formulary rules, and exception adjudication standards (e.g., CMS Part D rules apply only to Medicare Part D LOB).. Valid values are `commercial|medicare_part_d|medicaid|exchange|cobra|fehb`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `prescriber_npi` STRING COMMENT '10-digit National Provider Identifier (NPI) of the prescribing physician or authorized prescriber who submitted or supports the formulary exception request. Required for CMS Part D coverage determination documentation.. Valid values are `^[0-9]{10}$`',
    `quantity_requested` DECIMAL(18,2) COMMENT 'The quantity of the drug (in dispensing units) for which the exception is requested, applicable for quantity limit exception requests. Expressed in the drugs standard dispensing unit (e.g., tablets, milliliters).',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `request_channel` STRING COMMENT 'Channel through which the formulary exception request was submitted. Values: phone (member/prescriber call), fax (fax submission), portal (member or prescriber web portal), edi (electronic data interchange transaction), mail (paper/postal), prescriber_portal (dedicated prescriber e-prescribing or PBM portal).. Valid values are `phone|fax|portal|edi|mail|prescriber_portal`',
    `request_date` DATE COMMENT 'Calendar date on which the formulary exception request was formally submitted by the member, prescriber, or authorized representative. This is the principal business event date used for CMS timeliness compliance tracking (72-hour standard, 24-hour expedited).',
    `request_received_timestamp` TIMESTAMP COMMENT 'Precise date and time the formulary exception request was received and logged in the PBM or UM system. Used for exact timeliness measurement against CMS regulatory response deadlines.',
    `requested_drug_tier` STRING COMMENT 'The formulary cost-sharing tier to which the requestor is asking the drug to be assigned for this member (e.g., requesting Tier 2 generic pricing for a Tier 3 preferred brand). Applicable for tier exception requests.. Valid values are `tier_1|tier_2|tier_3|tier_4|tier_5|specialty`',
    `requestor_type` STRING COMMENT 'Identifies who initiated the formulary exception request. Member: the enrollee themselves; Prescriber: the treating physician or authorized prescriber; Authorized Representative: a legally designated representative acting on behalf of the member; Pharmacy: the dispensing pharmacy acting on behalf of the member.. Valid values are `member|prescriber|authorized_representative|pharmacy`',
    `review_level` STRING COMMENT 'Level of clinical review applied to the formulary exception request. Pharmacist: initial review by clinical pharmacist; Medical Director: escalated review by physician medical director; Peer to Peer: prescriber-to-medical-director discussion; Committee: pharmacy and therapeutics committee review.. Valid values are `pharmacist|medical_director|peer_to_peer|committee`',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this formulary exception record originated. Supports data lineage and reconciliation in the Databricks Silver layer. Values: rxclaim, argus (PBM systems), interqual, mcg (UM systems), facets, qnxt (core admin), manual (manually entered). [ENUM-REF-CANDIDATE: rxclaim|argus|interqual|mcg|facets|qnxt|manual — 7 candidates stripped; promote to reference product]',
    `step_therapy_drugs_tried` STRING COMMENT 'Comma-separated list of NDCs or drug names of step therapy prerequisite drugs that the member has already tried and failed, as documented in the step therapy exception request. Supports clinical review and CMS step therapy override requirements.',
    `supporting_doc_received` BOOLEAN COMMENT 'Indicates whether the required clinical supporting documentation (e.g., prescriber letter of medical necessity, lab results, treatment history) has been received from the prescriber or member. True = documentation received; False = documentation pending or not received.',
    `supporting_doc_received_date` DATE COMMENT 'Date on which the required clinical supporting documentation was received from the prescriber or member. Used to calculate the effective review start date and CMS timeliness compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the formulary exception record was last modified in the data platform. Tracks status changes, decision updates, and documentation additions throughout the exception lifecycle.',
    CONSTRAINT pk_formulary_exception PRIMARY KEY(`formulary_exception_id`)
) COMMENT 'Transactional record for member or prescriber requests to cover a non-formulary drug or override a formulary restriction (tier exception, PA exception, step therapy exception). Captures request date, member ID, prescriber NPI, requested drug NDC, exception type, clinical justification, decision status (approved/denied), effective date range, and appeal rights notification. Supports CMS Part D coverage determination and exception request requirements.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_prior_version_formulary_id` FOREIGN KEY (`prior_version_formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ADD CONSTRAINT `fk_pharmacy_formulary_drug_tier_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ADD CONSTRAINT `fk_pharmacy_formulary_drug_tier_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ADD CONSTRAINT `fk_pharmacy_drug_pricing_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ADD CONSTRAINT `fk_pharmacy_drug_pricing_pbm_contract_id` FOREIGN KEY (`pbm_contract_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract`(`pbm_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ADD CONSTRAINT `fk_pharmacy_claim_line_dispensing_pharmacy_id` FOREIGN KEY (`dispensing_pharmacy_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy`(`dispensing_pharmacy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ADD CONSTRAINT `fk_pharmacy_claim_line_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ADD CONSTRAINT `fk_pharmacy_claim_line_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ADD CONSTRAINT `fk_pharmacy_claim_line_pbm_contract_id` FOREIGN KEY (`pbm_contract_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract`(`pbm_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ADD CONSTRAINT `fk_pharmacy_claim_line_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_original_pa_prior_authorization_id` FOREIGN KEY (`original_pa_prior_authorization_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ADD CONSTRAINT `fk_pharmacy_pbm_contract_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization`(`prior_authorization_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`pharmacy` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_health_insurance_v1`.`pharmacy` SET TAGS ('dbx_domain' = 'pharmacy');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` SET TAGS ('dbx_subdomain' = 'formulary_management');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_vibe_coding_demo' = 'scoped');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `atc_code` SET TAGS ('dbx_business_glossary_term' = 'Anatomical Therapeutic Chemical (ATC) Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `atc_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `atc_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `awp_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Average Wholesale Price (AWP) Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `awp_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Average Wholesale Price (AWP) Unit Price');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `awp_unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Schedule (DEA)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_value_regex' = 'I|II|III|IV|V|not_scheduled');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `dea_number_required` SET TAGS ('dbx_business_glossary_term' = 'DEA Number Required Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `dosage_form` SET TAGS ('dbx_business_glossary_term' = 'Dosage Form');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `drug_class_code` SET TAGS ('dbx_business_glossary_term' = 'Drug Class Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `drug_class_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `drug_class_name` SET TAGS ('dbx_business_glossary_term' = 'Drug Class Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `drug_name` SET TAGS ('dbx_business_glossary_term' = 'Drug Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `drug_status` SET TAGS ('dbx_business_glossary_term' = 'Drug Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `drug_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|recalled|pending');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `drug_type` SET TAGS ('dbx_business_glossary_term' = 'Drug Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `drug_type` SET TAGS ('dbx_value_regex' = 'brand|generic|biosimilar|otc|compound|repackaged');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `fda_approval_status` SET TAGS ('dbx_business_glossary_term' = 'FDA Approval Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `fda_approval_status` SET TAGS ('dbx_value_regex' = 'approved|tentatively_approved|pending|withdrawn|not_approved');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `generic_name` SET TAGS ('dbx_business_glossary_term' = 'Generic Name (INN)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `gpi_code` SET TAGS ('dbx_business_glossary_term' = 'Generic Product Identifier (GPI) Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `gpi_code` SET TAGS ('dbx_value_regex' = '^[0-9]{14}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `gpi_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `hcc_relevant` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category (HCC) Relevant Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `is_biosimilar` SET TAGS ('dbx_business_glossary_term' = 'Biosimilar Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `is_generic_available` SET TAGS ('dbx_business_glossary_term' = 'Generic Available Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `is_maintenance_drug` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Drug Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `is_preventive_drug` SET TAGS ('dbx_business_glossary_term' = 'Preventive Drug Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `is_specialty_drug` SET TAGS ('dbx_business_glossary_term' = 'Specialty Drug Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `labeler_code` SET TAGS ('dbx_business_glossary_term' = 'NDC Labeler Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `labeler_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `labeler_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `master_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `multi_source_code` SET TAGS ('dbx_business_glossary_term' = 'Multi-Source Code (MSC)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `multi_source_code` SET TAGS ('dbx_value_regex' = 'O|M|N|Y');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `multi_source_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `ndc` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `ndc` SET TAGS ('dbx_value_regex' = '^[0-9]{11}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `ndc_11` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC) 11-Digit Formatted');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `ndc_11` SET TAGS ('dbx_value_regex' = '^[0-9]{5}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `package_size` SET TAGS ('dbx_business_glossary_term' = 'Package Size');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `package_size_unit` SET TAGS ('dbx_business_glossary_term' = 'Package Size Unit of Measure');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `pharmacological_category` SET TAGS ('dbx_business_glossary_term' = 'Pharmacological Category');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `rems_program` SET TAGS ('dbx_business_glossary_term' = 'Risk Evaluation and Mitigation Strategy (REMS) Program');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `source_record_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'FDB|MEDISPAN|RXCLAIM|ARGUS|INTERNAL');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `source_system_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `strength` SET TAGS ('dbx_business_glossary_term' = 'Drug Strength');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `therapeutic_class_code` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Class Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `therapeutic_class_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `therapeutic_class_name` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Class Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `therapeutic_equivalence_code` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Equivalence Code (TE Code)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `therapeutic_equivalence_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]*$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `therapeutic_equivalence_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `therapeutic_subclass_code` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Subclass Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `therapeutic_subclass_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `therapeutic_subclass_name` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Subclass Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `wac_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Acquisition Cost (WAC) Unit Price');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `wac_unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` SET TAGS ('dbx_subdomain' = 'formulary_management');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `prior_version_formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Formulary Version ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_category` SET TAGS ('dbx_business_glossary_term' = 'Formulary Category');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_category` SET TAGS ('dbx_value_regex' = 'standard|enhanced|basic|premium|custom');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `change_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Formulary Change Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `cms_formulary_code` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Formulary Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `cms_formulary_code` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `cms_formulary_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_code` SET TAGS ('dbx_business_glossary_term' = 'Formulary Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_description` SET TAGS ('dbx_business_glossary_term' = 'Formulary Description');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `drug_count` SET TAGS ('dbx_business_glossary_term' = 'Formulary Drug Count');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `drug_utilization_review_ind` SET TAGS ('dbx_business_glossary_term' = 'Drug Utilization Review (DUR) Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Formulary Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_status` SET TAGS ('dbx_business_glossary_term' = 'Formulary Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired|suspended');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_type` SET TAGS ('dbx_business_glossary_term' = 'Formulary Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_type` SET TAGS ('dbx_value_regex' = 'open|closed|tiered|preferred|exclusive');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `generic_substitution_policy` SET TAGS ('dbx_business_glossary_term' = 'Generic Substitution Policy');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `generic_substitution_policy` SET TAGS ('dbx_value_regex' = 'mandatory|permissive|prohibited|daw_honored');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `is_aca_compliant` SET TAGS ('dbx_business_glossary_term' = 'Affordable Care Act (ACA) Compliance Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `is_cms_part_d` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Part D Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Formulary Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `lob_code` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `lob_code` SET TAGS ('dbx_value_regex' = 'commercial|medicare|medicaid|marketplace|fehb|tricare');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `lob_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `low_income_subsidy_ind` SET TAGS ('dbx_business_glossary_term' = 'Low Income Subsidy (LIS) Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `mail_order_ind` SET TAGS ('dbx_business_glossary_term' = 'Mail Order Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `master_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_name` SET TAGS ('dbx_business_glossary_term' = 'Formulary Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Formulary Next Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `pbm_formulary_code` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Benefit Manager (PBM) Formulary Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `pbm_formulary_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,50}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `pbm_formulary_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Plan Year');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `prior_auth_ind` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `pt_committee_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy and Therapeutics (P&T) Committee Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `quantity_limit_ind` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `regulatory_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `regulatory_filing_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `regulatory_filing_status` SET TAGS ('dbx_value_regex' = 'not_filed|filed|approved|rejected|pending_review');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'rxclaim|argus|facets|qnxt|manual|other');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `source_system_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `specialty_pharmacy_ind` SET TAGS ('dbx_business_glossary_term' = 'Specialty Pharmacy Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `specialty_tier_ind` SET TAGS ('dbx_business_glossary_term' = 'Specialty Tier Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `step_therapy_ind` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Formulary Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `tier_count` SET TAGS ('dbx_business_glossary_term' = 'Formulary Tier Count');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Formulary URL');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `url` SET TAGS ('dbx_value_regex' = '^https?://.+$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Formulary Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,4}.[0-9]{1,4}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` SET TAGS ('dbx_subdomain' = 'formulary_management');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `formulary_drug_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Drug Tier ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `clinical_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `benefit_year` SET TAGS ('dbx_business_glossary_term' = 'Benefit Year');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `coinsurance_rate` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Rate');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `coinsurance_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `copay_mail_order` SET TAGS ('dbx_business_glossary_term' = 'Mail Order Copay Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `copay_mail_order` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `copay_retail_30` SET TAGS ('dbx_business_glossary_term' = 'Retail 30-Day Copay Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `copay_retail_30` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `copay_retail_90` SET TAGS ('dbx_business_glossary_term' = 'Retail 90-Day Copay Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `copay_retail_90` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Drug Coverage Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `coverage_status` SET TAGS ('dbx_value_regex' = 'covered|not_covered|covered_with_restrictions|excluded');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `deductible_applies` SET TAGS ('dbx_business_glossary_term' = 'Deductible Applies Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `dispensing_channel` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Channel');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `dispensing_channel` SET TAGS ('dbx_value_regex' = 'retail|mail_order|specialty|retail_and_mail|all');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `drug_tier_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Drug Tier Change Reason');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `dur_alert_type` SET TAGS ('dbx_business_glossary_term' = 'Drug Utilization Review (DUR) Alert Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `formulary_status_code` SET TAGS ('dbx_business_glossary_term' = 'CMS Formulary Status Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `formulary_status_code` SET TAGS ('dbx_value_regex' = '1|2|3|4|5|6');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `formulary_status_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `lob_code` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `lob_code` SET TAGS ('dbx_value_regex' = 'commercial|medicare_part_d|medicaid|exchange|fehb');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `lob_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `mac_pricing_applicable` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allowable Cost (MAC) Pricing Applicable Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `master_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{11}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `ndc_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `pa_criteria_description` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Criteria Description');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `pa_type` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `pa_type` SET TAGS ('dbx_value_regex' = 'standard|expedited|retrospective|not_applicable');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `pbm_formulary_code` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Benefit Manager (PBM) Formulary Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `pbm_formulary_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `prior_auth_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `ql_clinical_basis` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit (QL) Clinical Basis');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `ql_days_supply` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit (QL) Days Supply');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `ql_dosage_form_restriction` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit (QL) Dosage Form Restriction');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `ql_max_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit (QL) Maximum Quantity');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `quantity_limit_required` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit (QL) Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `specialty_drug_flag` SET TAGS ('dbx_business_glossary_term' = 'Specialty Drug Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `st_clinical_rationale` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy (ST) Clinical Rationale');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `st_override_criteria` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy (ST) Override Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `st_required_step_ndc` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy (ST) Required Step Drug NDC');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `st_required_step_ndc` SET TAGS ('dbx_value_regex' = '^[0-9]{11}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `st_step_number` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy (ST) Step Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `st_step_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy (ST) Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_business_glossary_term' = 'Drug Tier Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `tier_number` SET TAGS ('dbx_business_glossary_term' = 'Drug Tier Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `tier_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `transition_fill_allowed` SET TAGS ('dbx_business_glossary_term' = 'Transition Fill Allowed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` SET TAGS ('dbx_subdomain' = 'formulary_management');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `drug_pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Pricing ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `awp_discount_pct` SET TAGS ('dbx_business_glossary_term' = 'Average Wholesale Price (AWP) Discount Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `awp_discount_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `awp_price` SET TAGS ('dbx_business_glossary_term' = 'Average Wholesale Price (AWP)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `awp_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `currency_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `days_supply` SET TAGS ('dbx_business_glossary_term' = 'Days Supply');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_value_regex' = 'CI|CII|CIII|CIV|CV|NON-CONTROLLED');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `dispensing_channel` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Channel');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `dispensing_channel` SET TAGS ('dbx_value_regex' = 'retail|mail_order|specialty|long_term_care');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `dispensing_fee` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Fee');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `dispensing_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `formulary_tier` SET TAGS ('dbx_business_glossary_term' = 'Formulary Tier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `formulary_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|tier_5|non_formulary');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `mac_list_version` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allowable Cost (MAC) List Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `mac_methodology` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allowable Cost (MAC) List Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `mac_methodology` SET TAGS ('dbx_value_regex' = 'MARKET_BASKET|NADAC_BASED|AWP_DISCOUNT|WAC_DISCOUNT|CUSTOM');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `mac_price` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allowable Cost (MAC) Price');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `mac_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `master_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `multi_source_code` SET TAGS ('dbx_business_glossary_term' = 'Multi-Source Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `multi_source_code` SET TAGS ('dbx_value_regex' = 'O|M|N|Y');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `multi_source_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `package_size` SET TAGS ('dbx_business_glossary_term' = 'Package Size');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `package_size_uom` SET TAGS ('dbx_business_glossary_term' = 'Package Size Unit of Measure');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `price_change_pct` SET TAGS ('dbx_business_glossary_term' = 'Price Change Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `price_change_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'AWP|WAC|MAC|RBP|NADAC|USUAL_AND_CUSTOMARY');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `pricing_file_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing File Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `pricing_file_name` SET TAGS ('dbx_business_glossary_term' = 'Pricing File Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `pricing_source` SET TAGS ('dbx_business_glossary_term' = 'Pricing Source');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `pricing_status` SET TAGS ('dbx_business_glossary_term' = 'Pricing Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `pricing_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `prior_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Prior Unit Price');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `prior_unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `rbp_price` SET TAGS ('dbx_business_glossary_term' = 'Reference Based Pricing (RBP) Price');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `rbp_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `wac_price` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Acquisition Cost (WAC)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `wac_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` SET TAGS ('dbx_subdomain' = 'dispensing_operations');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `claim_line_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Line Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `condition_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Registry Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `cost_share_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Rule Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `dispensing_pharmacy_id` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Pharmacy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Header Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `hedis_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Hedis Measure Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `pbm_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Pbm Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `adjudication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `basis_of_cost_determination` SET TAGS ('dbx_business_glossary_term' = 'Basis of Cost Determination');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `catastrophic_coverage_indicator` SET TAGS ('dbx_business_glossary_term' = 'Catastrophic Coverage Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `cob_sequence` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Sequence');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `compound_indicator` SET TAGS ('dbx_business_glossary_term' = 'Compound Drug Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `coverage_gap_indicator` SET TAGS ('dbx_business_glossary_term' = 'Coverage Gap Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `days_supply` SET TAGS ('dbx_business_glossary_term' = 'Days Supply');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `dispense_as_written_code` SET TAGS ('dbx_business_glossary_term' = 'Dispense As Written (DAW) Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `dispense_as_written_code` SET TAGS ('dbx_value_regex' = '0|1|2|3|4|5');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `dispense_as_written_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `dispensed_date` SET TAGS ('dbx_business_glossary_term' = 'Dispensed Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `dispensed_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `dispensed_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `dispensing_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Fee Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `dispensing_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `drug_coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Drug Coverage Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `drug_coverage_status` SET TAGS ('dbx_value_regex' = 'covered|non_covered|excluded|step_therapy_required|pa_required');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `dur_conflict_code` SET TAGS ('dbx_business_glossary_term' = 'Drug Utilization Review (DUR) Conflict Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `dur_conflict_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `dur_outcome_code` SET TAGS ('dbx_business_glossary_term' = 'Drug Utilization Review (DUR) Outcome Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `dur_outcome_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `fill_number` SET TAGS ('dbx_business_glossary_term' = 'Fill Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `fill_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `formulary_tier` SET TAGS ('dbx_business_glossary_term' = 'Formulary Tier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `formulary_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|tier_5|non_formulary');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `generic_indicator` SET TAGS ('dbx_business_glossary_term' = 'Generic Drug Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `gross_drug_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Drug Cost Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `gross_drug_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `ingredient_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Cost Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `ingredient_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `line_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `line_sequence_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Line Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'paid|denied|reversed|adjusted|pending|void');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Line Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = 'standard|compound_ingredient|cob_split|reversal|adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `low_income_subsidy_indicator` SET TAGS ('dbx_business_glossary_term' = 'Low Income Subsidy (LIS) Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `manufacturer_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Discount Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `manufacturer_discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `master_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{11}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `ndc_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `ndc_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `ndc_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `patient_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Patient Pay Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `patient_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `patient_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `pde_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Prescription Drug Event (PDE) Submission Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `pharmacy_channel` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Channel');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `pharmacy_channel` SET TAGS ('dbx_value_regex' = 'retail|mail_order|specialty|long_term_care|home_infusion');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `plan_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Plan Paid Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `plan_paid_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `quantity_dispensed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Dispensed');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `quantity_limit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `refill_number` SET TAGS ('dbx_business_glossary_term' = 'Refill Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `refill_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `reversal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reversal Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `sales_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Sales Tax Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `sales_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `source_system_claim_line_key` SET TAGS ('dbx_business_glossary_term' = 'Source System Claim Line Key');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `specialty_drug_indicator` SET TAGS ('dbx_business_glossary_term' = 'Specialty Drug Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `step_therapy_indicator` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `true_oop_amount` SET TAGS ('dbx_business_glossary_term' = 'True Out-of-Pocket (TrOOP) Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `true_oop_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `true_oop_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` SET TAGS ('dbx_subdomain' = 'dispensing_operations');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `clinical_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `condition_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Registry Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Coordinator Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `original_pa_prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Original Prior Authorization (PA) ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `pa_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Decision Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Request Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Specialty Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `appeal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Appeal Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `approved_days_supply` SET TAGS ('dbx_business_glossary_term' = 'Approved Days Supply');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `approved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Approved Quantity');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `approved_refills` SET TAGS ('dbx_business_glossary_term' = 'Approved Number of Refills');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `cms_part_d_reportable` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Part D Reportable Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `criteria_met` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Met Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Decision Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Denial Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Denial Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `dispensing_channel` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Channel');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `dispensing_channel` SET TAGS ('dbx_value_regex' = 'retail|mail_order|specialty|long_term_care|home_infusion');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `drug_tier` SET TAGS ('dbx_business_glossary_term' = 'Drug Formulary Tier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `drug_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|tier_5|specialty');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `dur_outcome_code` SET TAGS ('dbx_business_glossary_term' = 'Drug Utilization Review (DUR) Outcome Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `dur_outcome_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `lob` SET TAGS ('dbx_value_regex' = 'commercial|medicare_part_d|medicaid|marketplace|cobra|individual');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `master_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Clinical Notes');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `pa_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `pa_reference_number` SET TAGS ('dbx_value_regex' = '^PA-[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `pa_reference_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `pa_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `pa_status` SET TAGS ('dbx_value_regex' = 'approved|denied|pending|cancelled|expired|appealed');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `pa_type` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `pa_type` SET TAGS ('dbx_value_regex' = 'specialty|non_preferred|step_therapy|quantity_limit|age_restriction|off_label');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `prescriber_npi` SET TAGS ('dbx_business_glossary_term' = 'Prescriber National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `prescriber_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `prescriber_npi` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `quantity_limit_applied` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit Applied Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Received Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Request Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Request Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'new|renewal|appeal|expedited|retrospective');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `review_level` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Review Level');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `review_level` SET TAGS ('dbx_value_regex' = 'pharmacist|physician|peer_to_peer|medical_director');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `source_system_pa_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Prior Authorization (PA) ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `source_system_pa_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `specialty_drug_flag` SET TAGS ('dbx_business_glossary_term' = 'Specialty Drug Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `step_therapy_completed` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Completed Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Required Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` SET TAGS ('dbx_subdomain' = 'dispensing_operations');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `dispensing_pharmacy_id` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Pharmacy ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliated Facility Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'National Council for Prescription Drug Programs (NCPDP) Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `par_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Par Agreement Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `accepts_electronic_prescriptions` SET TAGS ('dbx_business_glossary_term' = 'Accepts Electronic Prescriptions Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Address Line 1');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `address_line1` SET TAGS ('dbx_fhir_element' = 'address.line');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Address Line 2');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `address_line2` SET TAGS ('dbx_fhir_element' = 'address.line');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `awp_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Average Wholesale Price (AWP) Discount Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `awp_discount_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `chain_independent_flag` SET TAGS ('dbx_business_glossary_term' = 'Chain or Independent Pharmacy Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `chain_independent_flag` SET TAGS ('dbx_value_regex' = 'chain|independent');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `chain_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Chain Organization Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy City');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `city` SET TAGS ('dbx_fhir_element' = 'address.city');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `cold_chain_certified` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Certification Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `contract_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `contract_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'direct|pbm_administered');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `dispensing_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Fee Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `dispensing_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `dispensing_state_code` SET TAGS ('dbx_business_glossary_term' = 'Dispensing State Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `dispensing_state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `dispensing_state_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Fax Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fax_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fax_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `ingredient_cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Cost Reimbursement Basis');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `ingredient_cost_basis` SET TAGS ('dbx_value_regex' = 'awp_discount|mac|wac|nadac');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'commercial|medicare_part_d|medicaid|exchange|cobra');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `mail_order_capable` SET TAGS ('dbx_business_glossary_term' = 'Mail Order Capable Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `master_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `ncpdp_chain_code` SET TAGS ('dbx_business_glossary_term' = 'National Council for Prescription Drug Programs (NCPDP) Chain Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `ncpdp_chain_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `ncpdp_chain_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `network_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Network Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `network_participation_status` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `network_participation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|pending');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `network_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Network Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `performance_audit_provision` SET TAGS ('dbx_business_glossary_term' = 'Performance Audit Provision Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `pharmacy_name` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `pharmacy_type` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `pharmacy_type` SET TAGS ('dbx_value_regex' = 'retail|mail_order|specialty|long_term_care|compounding');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `phone_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `phone_number` SET TAGS ('dbx_fhir_element' = 'telecom.phone');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `signature_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'rxclaim|argus|cactus|provider_source|manual');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `source_system_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `specialty_accreditation_code` SET TAGS ('dbx_business_glossary_term' = 'Specialty Pharmacy Accreditation Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `specialty_accreditation_code` SET TAGS ('dbx_value_regex' = 'urac|achc|jcaho|nabp_pcab|none');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `specialty_accreditation_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy State Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `state_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `state_code` SET TAGS ('dbx_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `twenty_four_hour_flag` SET TAGS ('dbx_business_glossary_term' = '24-Hour Operation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy ZIP Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `zip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `zip_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `zip_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` SET TAGS ('dbx_subdomain' = 'dispensing_operations');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `pbm_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Benefit Manager (PBM) Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Most Recent Amendment Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `amendment_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_value_regex' = 'annual|biennial|on_demand|quarterly|not_applicable');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `awp_discount_mail_pct` SET TAGS ('dbx_business_glossary_term' = 'Average Wholesale Price (AWP) Discount Mail Order Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `awp_discount_mail_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `awp_discount_retail_pct` SET TAGS ('dbx_business_glossary_term' = 'Average Wholesale Price (AWP) Discount Retail Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `awp_discount_retail_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `cms_contract_number` SET TAGS ('dbx_business_glossary_term' = 'CMS Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `cms_contract_number` SET TAGS ('dbx_value_regex' = '^H[0-9]{4}$|^S[0-9]{4}$|^R[0-9]{4}$|^E[0-9]{4}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `cms_contract_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'PBM Contract Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'PBM Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `contract_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'PBM Contract Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired|pending_renewal');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'PBM Contract Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'ASO|full_risk|carve_out|pass_through|hybrid');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `contract_version` SET TAGS ('dbx_business_glossary_term' = 'Contract Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `dispensing_fee_mail_order` SET TAGS ('dbx_business_glossary_term' = 'Mail Order Dispensing Fee (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `dispensing_fee_mail_order` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `dispensing_fee_retail` SET TAGS ('dbx_business_glossary_term' = 'Retail Dispensing Fee (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `dispensing_fee_retail` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `dispensing_fee_specialty` SET TAGS ('dbx_business_glossary_term' = 'Specialty Dispensing Fee (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `dispensing_fee_specialty` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `dur_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Drug Utilization Review (DUR) Program Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `generic_dispensing_rate_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Generic Dispensing Rate (GDR) Guarantee Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `generic_dispensing_rate_guarantee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `governing_state_code` SET TAGS ('dbx_business_glossary_term' = 'Governing State Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `governing_state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `governing_state_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `ingredient_cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Cost Basis');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `ingredient_cost_basis` SET TAGS ('dbx_value_regex' = 'AWP|WAC|MAC|NADAC|AAC');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `ingredient_cost_basis` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `lob_scope` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB) Scope');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `lob_scope` SET TAGS ('dbx_value_regex' = 'commercial|medicare_part_d|medicaid|exchange|all');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `mac_list_reference` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allowable Cost (MAC) List Reference');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `mac_list_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `mail_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Mail Order Pharmacy Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `mail_order_penetration_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Mail Order Penetration Rate Guarantee Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `mail_order_penetration_guarantee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `master_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `performance_guarantee_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Guarantee Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `prior_auth_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `quantity_limit_flag` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `rebate_guarantee_pmpm` SET TAGS ('dbx_business_glossary_term' = 'Rebate Guarantee Per Member Per Month (PMPM)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `rebate_guarantee_pmpm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `rebate_pass_through_pct` SET TAGS ('dbx_business_glossary_term' = 'Rebate Pass-Through Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `rebate_pass_through_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `rebate_reconciliation_lag_days` SET TAGS ('dbx_business_glossary_term' = 'Rebate Reconciliation Lag (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `rebate_settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rebate Settlement Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `rebate_settlement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'RxClaim|Argus|manual|other');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `source_system_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `specialty_pharmacy_flag` SET TAGS ('dbx_business_glossary_term' = 'Specialty Pharmacy Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `step_therapy_flag` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` SET TAGS ('dbx_subdomain' = 'dispensing_operations');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `formulary_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Exception Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `adverse_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Adverse Determination Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `clinical_criteria_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `condition_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Registry Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Coordinator Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Provider Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `appeal_rights_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Rights Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `appeal_rights_notified` SET TAGS ('dbx_business_glossary_term' = 'Appeal Rights Notification Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `clinical_justification` SET TAGS ('dbx_business_glossary_term' = 'Clinical Justification');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `clinical_justification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `cms_coverage_determination_type` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Coverage Determination Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `cms_coverage_determination_type` SET TAGS ('dbx_value_regex' = 'standard|expedited|reopen|revised');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `current_drug_tier` SET TAGS ('dbx_business_glossary_term' = 'Current Drug Formulary Tier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `days_supply_requested` SET TAGS ('dbx_business_glossary_term' = 'Days Supply Requested');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Decision Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `exception_request_number` SET TAGS ('dbx_business_glossary_term' = 'Exception Request Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `exception_request_number` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|withdrawn|expired|appealed');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_value_regex' = 'non_formulary|tier_exception|pa_exception|step_therapy_exception|quantity_limit_exception|coverage_determination');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `fhir_last_updated` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `fhir_profile_url` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `fhir_resource_reference` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `fhir_resource_type` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `fhir_version_code` SET TAGS ('dbx_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `formulary_alternative_ndc` SET TAGS ('dbx_business_glossary_term' = 'Formulary Alternative Drug National Drug Code (NDC)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `formulary_alternative_ndc` SET TAGS ('dbx_value_regex' = '^[0-9]{11}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `is_expedited` SET TAGS ('dbx_business_glossary_term' = 'Expedited Exception Request Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'commercial|medicare_part_d|medicaid|exchange|cobra|fehb');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `master_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `prescriber_npi` SET TAGS ('dbx_business_glossary_term' = 'Prescriber National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `prescriber_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `prescriber_npi` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `record_status` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `request_channel` SET TAGS ('dbx_business_glossary_term' = 'Exception Request Channel');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `request_channel` SET TAGS ('dbx_value_regex' = 'phone|fax|portal|edi|mail|prescriber_portal');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Request Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `request_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Request Received Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `requested_drug_tier` SET TAGS ('dbx_business_glossary_term' = 'Requested Drug Tier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `requested_drug_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|tier_5|specialty');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `requestor_type` SET TAGS ('dbx_business_glossary_term' = 'Requestor Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `requestor_type` SET TAGS ('dbx_value_regex' = 'member|prescriber|authorized_representative|pharmacy');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `review_level` SET TAGS ('dbx_business_glossary_term' = 'Review Level');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `review_level` SET TAGS ('dbx_value_regex' = 'pharmacist|medical_director|peer_to_peer|committee');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `source_system_code` SET TAGS ('dbx_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `step_therapy_drugs_tried` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Drugs Tried');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `supporting_doc_received` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Received Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `supporting_doc_received_date` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Received Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_fhir_element' = 'meta.lastUpdated');
