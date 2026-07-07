-- Schema for Domain: pharmacy | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 08:47:31

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`pharmacy` COMMENT 'Manages pharmacy benefit administration — formulary design, drug tier assignments, NDC-level drug master, MAC/AWP/WAC pricing, retail and mail-order dispensing, specialty pharmacy, and pharmacy claim adjudication. Owns PBM contract terms, step therapy and quantity limit rules, drug utilization review (DUR) outcomes, and prior authorization for specialty drugs. Interfaces with RxClaim or Argus PBM systems and supports CMS Part D reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` (
    `drug_master_id` BIGINT COMMENT 'Unique surrogate identifier for each drug master record in the lakehouse Silver layer. Serves as the primary key for all downstream joins across formulary, claims, DUR, rebate contracting, and PBM adjudication.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Data governance requires tracking which employee entered or updated drug master records.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Required for drug rebate and pricing management: linking each drug to its manufacturer/vendor enables accurate rebate calculations, pricing negotiations, and CMS reporting.',
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
    `reference_drug_ndc` STRING COMMENT 'The NDC of the FDA Reference Listed Drug (RLD) or reference biological product to which this generic or biosimilar is therapeutically equivalent. Enables generic substitution relationship mapping, step therapy configuration, and biosimilar interchangeability tracking in the PBM system.. Valid values are `^[0-9]{11}$`',
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
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Formulary design must adhere to specific regulatory obligations (ACA, CMS); linking enables reporting of compliance status per formulary.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Formulary management assigns a responsible pharmacist/employee; needed for formulary change approval and governance reporting.',
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
    `mac_list_id` BIGINT COMMENT 'FK to pharmacy.mac_list',
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
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Line‑level pricing and cost allocation depend on the specific PBM contract; the FK supports detailed cost breakdowns for audits and CMS reporting.',
    `drug_master_id` BIGINT COMMENT 'Reference to the drug master record for the dispensed drug on this claim line, enabling linkage to formulary, tier, and pricing data.',
    `formulary_id` BIGINT COMMENT 'Reference to the formulary under which this drug was adjudicated, determining tier assignment, coverage rules, and cost-sharing obligations.',
    `journal_entry_line_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry_line. Business justification: Journal Entry Line Creation: each claim line generates a GL journal entry line for detailed expense tracking and audit trails.',
    `pharmacy_claim2_id` BIGINT COMMENT 'Reference to the parent pharmacy claim header to which this line belongs. Establishes the header/detail relationship for multi-line and compound drug claims.',
    `prior_authorization_id` BIGINT COMMENT 'Reference to the prior authorization record approved for this drug line, required for specialty and non-formulary drugs. Null if no PA was required.',
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
    `other_payer_amount` DECIMAL(18,2) COMMENT 'Amount paid by another payer (e.g., secondary insurer, manufacturer coupon, government program) on this claim line as part of Coordination of Benefits (COB). Used to calculate the plans net liability.',
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
    `case_id` BIGINT COMMENT 'Foreign key linking to appeal.appeal_case. Business justification: Needed for the Prior Authorization Appeal workflow; links a PA request to its appeal case for audit, compliance, and outcome reporting.',
    `employee_id` BIGINT COMMENT 'Identifier of the clinical reviewer (pharmacist, physician, or nurse) who made the prior authorization decision in the Utilization Management system (InterQual/MCG). Required for audit trail and URAC UM accreditation.',
    `formulary_id` BIGINT COMMENT 'Identifier of the formulary associated with the members plan at the time of the prior authorization request. Determines drug tier, coverage rules, and applicable PA criteria.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan or benefit plan under which the prior authorization is being evaluated. Determines applicable formulary, tier rules, and PA criteria.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: Prior‑authorization workflow uses the members risk score to assess clinical necessity and cost containment, mandated by internal utilization management policies.',
    `subscriber_id` BIGINT COMMENT 'Identifier of the health plan member for whom the prior authorization is requested. Links to the member master record in the Core Administration Platform (Facets/QNXT).',
    `original_pa_prior_authorization_id` BIGINT COMMENT 'Reference to the original prior authorization record when this record represents a renewal, appeal, or modification. Enables tracking of the full PA lifecycle chain. Null for initial requests.',
    `pa_decision_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_decision. Business justification: Needed for compliance reporting that ties each prior authorization to the final decision, supporting regulatory PA decision audit.',
    `pa_request_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_request. Business justification: Required for PA audit report linking each prior authorization record to its originating request, enabling traceability of request‑to‑authorization lifecycle.',
    `appeal_indicator` BOOLEAN COMMENT 'Indicates whether this prior authorization record is associated with a member or prescriber appeal of a prior denial. True = this PA is an appeal case.',
    `approved_days_supply` STRING COMMENT 'Number of days of drug therapy authorized under this prior authorization. Used by the PBM to enforce dispensing limits and by CMS Part D for compliance reporting.',
    `approved_quantity` DECIMAL(18,2) COMMENT 'Total quantity of the drug authorized for dispensing under this prior authorization (e.g., number of tablets, milliliters, units). Enforced at point-of-sale by the PBM adjudication system.',
    `approved_refills` STRING COMMENT 'Number of refills authorized under this prior authorization in addition to the initial fill. Enforced by the PBM adjudication system at point-of-sale.',
    `clinical_criteria_code` STRING COMMENT 'Code identifying the specific clinical criteria set applied during the prior authorization review, sourced from the Utilization Management system (InterQual or MCG). Used for audit, appeals, and regulatory reporting.',
    `clinical_criteria_version` STRING COMMENT 'Version of the clinical criteria set (InterQual or MCG) applied at the time of the prior authorization decision. Required for audit trails and appeals to ensure the correct criteria version is referenced.',
    `cms_part_d_reportable` BOOLEAN COMMENT 'Indicates whether this prior authorization record is subject to CMS Part D PA reporting requirements. True = must be included in CMS Part D PA reporting submissions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this prior authorization record was first created in the Silver Layer data platform. Used for data lineage, audit trail, and Silver Layer processing compliance.',
    `criteria_met` BOOLEAN COMMENT 'Indicates whether the submitted clinical information met the applicable clinical criteria (InterQual/MCG) for the requested drug. True = criteria met (supports approval); False = criteria not met (supports denial).',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `decision_timestamp` TIMESTAMP COMMENT 'Exact date and time the prior authorization decision (approval, denial, or pend) was rendered by the clinical reviewer or automated adjudication engine. Used to calculate turnaround time against CMS and URAC standards.',
    `denial_reason_code` STRING COMMENT 'Standardized code indicating the reason for denial of the prior authorization request (e.g., not medically necessary, step therapy not completed, quantity limit exceeded, non-covered drug). Populated only when pa_status = denied. Used for member appeals and CMS Part D reporting.',
    `denial_reason_description` STRING COMMENT 'Free-text description of the denial reason, providing clinical or administrative context beyond the denial reason code. Included in member and prescriber denial notices per CMS and state DOI requirements.',
    `dispensing_channel` STRING COMMENT 'Pharmacy dispensing channel authorized for this prior authorization (retail, mail-order, specialty pharmacy, long-term care, or home infusion). Determines which pharmacy network is eligible to dispense.. Valid values are `retail|mail_order|specialty|long_term_care|home_infusion`',
    `drug_ndc` STRING COMMENT '11-digit National Drug Code (NDC) identifying the specific drug product, strength, and package size for which prior authorization is requested. Sourced from the PBM drug master (RxClaim/Argus).. Valid values are `^[0-9]{11}$`',
    `drug_tier` STRING COMMENT 'Formulary tier of the requested drug at the time of the prior authorization request. Determines cost-sharing obligations and PA criteria applied.. Valid values are `tier_1|tier_2|tier_3|tier_4|tier_5|specialty`',
    `dur_outcome_code` STRING COMMENT 'NCPDP-standardized Drug Utilization Review (DUR) outcome code resulting from prospective DUR screening performed during PA adjudication (e.g., drug-drug interaction, drug-disease contraindication, duplicate therapy). Sourced from PBM system (RxClaim/Argus).',
    `effective_end_date` DATE COMMENT 'Date on which the prior authorization expires and is no longer valid for dispensing. After this date, a new PA request is required. Nullable for open-ended authorizations.',
    `effective_start_date` DATE COMMENT 'Date from which the approved prior authorization is valid for dispensing. Pharmacies and PBM adjudication systems use this date to confirm dispensing eligibility.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: CoverageEligibilityRequest)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `icd_diagnosis_code` STRING COMMENT 'Primary ICD-10-CM diagnosis code submitted by the prescriber to support the clinical necessity of the requested drug. Required for clinical criteria evaluation and CMS Part D PA reporting. Contains Protected Health Information (PHI).. Valid values are `^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `j_code` STRING COMMENT '',
    `lob` STRING COMMENT 'Line of Business (LOB) under which the members coverage falls, determining applicable regulatory requirements, formulary rules, and PA criteria (e.g., Commercial, Medicare Part D, Medicaid, ACA Marketplace).. Valid values are `commercial|medicare_part_d|medicaid|marketplace|cobra|individual`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `ndc_code` STRING COMMENT '',
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
    `secondary_diagnosis_codes` STRING COMMENT 'Pipe-delimited list of secondary ICD-10-CM diagnosis codes submitted to support clinical necessity. Stored as a delimited string per Silver Layer conventions (no ARRAY type). Contains Protected Health Information (PHI).',
    `source_system_pa_code` STRING COMMENT 'Native prior authorization identifier from the originating operational system (RxClaim, Argus, InterQual, or MCG). Preserved for reconciliation, audit, and cross-system traceability in the Silver Layer.',
    `specialty_drug_flag` BOOLEAN COMMENT 'Indicates whether the requested drug is classified as a specialty drug requiring specialty pharmacy dispensing and enhanced clinical review. Specialty drugs typically have higher cost-sharing and stricter PA criteria.',
    `step_therapy_completed` BOOLEAN COMMENT 'Indicates whether the member has documented evidence of completing the required step therapy (tried and failed prerequisite drugs) as required by the formulary PA criteria. Populated when step_therapy_required = True.',
    `step_therapy_completed_flag` BOOLEAN COMMENT '',
    `step_therapy_required` BOOLEAN COMMENT 'Indicates whether the prior authorization requires the member to have tried and failed one or more preferred or lower-tier drugs (step therapy) before the requested drug is authorized. True = step therapy applies.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this prior authorization record was last modified in the Silver Layer data platform, reflecting status changes, decision updates, or data corrections. Used for change data capture and audit.',
    CONSTRAINT pk_prior_authorization PRIMARY KEY(`prior_authorization_id`)
) COMMENT 'Prior authorization (PA) record for specialty and non-preferred drugs requiring clinical review before dispensing. Captures PA request date, requesting prescriber NPI, member ID, drug NDC, diagnosis codes (ICD), clinical criteria applied (InterQual/MCG), authorization status (approved/denied/pending), approved quantity, approved days supply, effective date range, and denial reason codes. Interfaces with the Utilization Management system and supports CMS Part D PA reporting.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` (
    `dur_alert_id` BIGINT COMMENT 'Unique surrogate identifier for each Drug Utilization Review (DUR) alert record generated during pharmacy claim adjudication in the Pharmacy Benefit Management (PBM) system (RxClaim or Argus).',
    `drug_master_id` BIGINT COMMENT 'add column drug_master_id (BIGINT) with FK to pharmacy.drug_master.drug_master_id - DUR alerts reference the drug',
    `health_plan_id` BIGINT COMMENT 'Reference to the health plan or benefit plan under which the member is enrolled at the time of the DUR alert. Used to apply plan-specific DUR rules, formulary restrictions, and CMS Part D contract reporting.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the health plan member for whom the DUR alert was triggered. Used to associate the alert with the members medication history and clinical profile.',
    `pharmacy_claim_id` BIGINT COMMENT 'FK to pharmacy.pharmacy_claim.pharmacy_claim_id',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: DUR alerts are reviewed by a clinical reviewer employee; audit of DUR decisions needs this link.',
    `adjudication_outcome` STRING COMMENT 'Final adjudication outcome of the pharmacy claim after the DUR alert was processed. Indicates whether the claim was paid, rejected due to the alert, overridden by the pharmacist or plan, pending review, or reversed.. Valid values are `paid|rejected|overridden|pending|reversed`',
    `alert_generated_timestamp` TIMESTAMP COMMENT 'Date and time when the DUR alert was generated by the PBM adjudication engine (RxClaim or Argus) during real-time claim processing. Represents the principal business event timestamp for this record.',
    `alert_status` STRING COMMENT 'Current lifecycle status of the DUR alert record. active=alert is open and requires action, resolved=alert addressed and closed, overridden=pharmacist or plan overrode the alert, suppressed=alert suppressed per plan rules, escalated=referred for clinical review.. Valid values are `active|resolved|overridden|suppressed|escalated`',
    `alert_type_code` STRING COMMENT 'NCPDP standardized code identifying the category of Drug Utilization Review (DUR) alert. Common values: DD=Drug-Drug Interaction, DC=Drug-Disease Contraindication, TD=Therapeutic Duplication, PA=Drug-Allergy, LD=Low Dose, HD=High Dose, MN=Drug-Age, CS=Drug-Gender, AD=Additive Toxicity, RF=Early Refill. [ENUM-REF-CANDIDATE: DD|DC|TD|PA|LD|HD|MN|CS|AD|RF|LR|DS|PG|MC|ID — promote to reference product]',
    `alert_type_description` STRING COMMENT 'Human-readable description of the DUR alert type (e.g., Drug-Drug Interaction, Therapeutic Duplication, High Dose Alert, Early Refill). Complements the alert_type_code for reporting and member communications.',
    `clinical_significance_code` STRING COMMENT 'Numeric code from the clinical drug database (First DataBank or Medi-Span) indicating the clinical significance of the drug interaction or contraindication. Ranges from 1 (most severe) to 5 (least severe). Supplements the NCPDP severity_level_code with database-specific grading.. Valid values are `^[0-9]{1}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the DUR alert record was first created and persisted in the data platform (Databricks Silver Layer). Represents the audit trail creation time, distinct from the business event timestamp (alert_generated_timestamp).',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `days_since_last_fill` STRING COMMENT 'Number of days elapsed since the members last fill of the same or therapeutically equivalent drug. Key metric for early refill DUR alert generation and medication adherence analysis.',
    `days_supply` STRING COMMENT 'Number of days of medication supply dispensed with the prescription. Used in early refill DUR calculations, quantity limit evaluations, and high-dose alert assessments.',
    `dispensing_date` DATE COMMENT 'Date on which the drug was dispensed at the pharmacy. Used to correlate the DUR alert with the dispensing event and for retrospective DUR analysis and CMS Part D reporting.',
    `dispensing_pharmacy_npi` STRING COMMENT '10-digit National Provider Identifier (NPI) of the pharmacy that dispensed the drug and at which the DUR alert was generated during point-of-sale adjudication.. Valid values are `^[0-9]{10}$`',
    `drug_database_source` STRING COMMENT 'Identifies the clinical drug knowledge database used to generate the DUR alert (e.g., First DataBank (FDB), Medi-Span, Micromedex, Multum, or custom plan rules). Important for audit, reproducibility, and database version tracking.. Valid values are `FDB|MEDI-SPAN|MICROMEDEX|MULTUM|CUSTOM`',
    `drug_database_version` STRING COMMENT 'Version or effective date of the clinical drug knowledge database (e.g., FDB or Medi-Span) used at the time the DUR alert was generated. Required for audit trail and regulatory reproducibility of DUR alert decisions.',
    `drug_name` STRING COMMENT 'Brand or generic name of the primary drug (identified by drug_ndc) that triggered the DUR alert. Denormalized for reporting and pharmacist display without requiring a drug master join.',
    `drug_ndc` STRING COMMENT '11-digit National Drug Code (NDC) identifying the specific drug product (labeler, product, package) that triggered the DUR alert. Primary drug identifier used in pharmacy adjudication.. Valid values are `^[0-9]{11}$`',
    `dur_program_type` STRING COMMENT 'Indicates whether the DUR alert was generated as part of a prospective (point-of-sale, real-time), retrospective (post-dispensing, claims analysis), or concurrent (during hospitalization or ongoing therapy) DUR program.. Valid values are `prospective|retrospective|concurrent`',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `icd_code_version` STRING COMMENT 'Version of the ICD coding system used for the icd_diagnosis_code on this DUR alert record (e.g., ICD-10-CM). Required for accurate clinical coding interpretation and regulatory reporting.. Valid values are `ICD-9-CM|ICD-10-CM|ICD-11`',
    `icd_diagnosis_code` STRING COMMENT 'ICD-10-CM diagnosis code associated with the drug-disease contraindication or drug-condition DUR alert. Identifies the members condition that conflicts with the dispensed drug. Populated for DC (drug-disease) alert types.. Valid values are `^[A-Z][0-9]{2}(.[A-Z0-9]{1,4})?$`',
    `interacting_drug_name` STRING COMMENT 'Brand or generic name of the interacting drug involved in a drug-drug interaction or therapeutic duplication alert. Provides human-readable context for pharmacist review and DUR reporting without requiring a drug master lookup.',
    `interacting_drug_ndc` STRING COMMENT '11-digit NDC of the second drug involved in a drug-drug interaction (DDI) or therapeutic duplication DUR alert. Populated when alert_type_code indicates a drug-drug conflict. Null for non-interaction alert types.. Valid values are `^[0-9]{11}$`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `ncpdp_dur_code` STRING COMMENT 'Two-character NCPDP standardized DUR conflict code transmitted in the pharmacy claim transaction (Field 439-E4). Identifies the specific clinical conflict detected (e.g., DD for drug-drug interaction). Required for CMS Part D DUR reporting.. Valid values are `^[A-Z0-9]{2}$`',
    `ncpdp_reject_code` STRING COMMENT 'Two-digit NCPDP reject code returned when the DUR alert results in a claim rejection (e.g., 88=DUR Reject Error). Populated when adjudication_outcome is rejected. Used for claim denial tracking and appeals.. Valid values are `^[0-9]{2}$`',
    `override_code` STRING COMMENT 'Two-character NCPDP code submitted by the pharmacist to override a DUR alert and allow dispensing (e.g., OO=Other Override, OP=Prescriber Override, OR=Pharmacist Override). Populated when adjudication_outcome is overridden.. Valid values are `^[A-Z0-9]{2}$`',
    `override_comment` STRING COMMENT 'Free-text clinical justification or pharmacist notes entered when overriding a DUR alert. Documents the clinical rationale for proceeding with dispensing despite the alert. Supports audit and retrospective DUR review.',
    `pa_reference_number` STRING COMMENT 'Reference number of the Prior Authorization (PA) request or approval associated with this DUR alert. Populated when pa_required_flag is True and a PA has been submitted or approved.',
    `pa_required_flag` BOOLEAN COMMENT 'Indicates whether the DUR alert outcome requires a Prior Authorization (PA) to be obtained before the drug can be dispensed. True when the alert triggers a PA requirement per plan formulary or step therapy rules.',
    `prescribed_quantity` DECIMAL(18,2) COMMENT 'Quantity of the drug as written on the original prescription by the prescriber. Compared against quantity_dispensed and plan quantity limits in DUR alert evaluation.',
    `prescriber_npi` STRING COMMENT '10-digit National Provider Identifier (NPI) of the prescribing physician or clinician who ordered the drug associated with the DUR alert. Used for prescriber-level DUR reporting and outreach.. Valid values are `^[0-9]{10}$`',
    `prescription_written_date` DATE COMMENT 'Date the prescription was originally written by the prescriber. Used in early refill DUR alerts to calculate days since prescription was issued and validate refill timing.',
    `professional_service_code` STRING COMMENT 'Two-character NCPDP code (Field 440-E5) indicating the professional service performed by the pharmacist in response to the DUR alert (e.g., AS=Patient Assessment, CC=Coordination of Care, DE=Dosing Evaluation, PM=Patient Medication Education). Required for CMS Part D DUR reporting.. Valid values are `^[A-Z0-9]{2}$`',
    `quantity_dispensed` DECIMAL(18,2) COMMENT 'Quantity of the drug dispensed (in units as defined by the drugs billing unit of measure). Used in high-dose and quantity limit DUR alert evaluations.',
    `quantity_limit_flag` BOOLEAN COMMENT 'Indicates whether the DUR alert was triggered by a quantity limit edit, where the dispensed or prescribed quantity exceeds the plans maximum allowable quantity for the drug.',
    `reason_for_service_code` STRING COMMENT 'Two-character NCPDP code (Field 439-E4 context) providing the clinical reason for the DUR service intervention. Captures the specific clinical basis for the alert and pharmacist action. Used in prospective DUR programs.. Valid values are `^[A-Z0-9]{2}$`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `refill_number` STRING COMMENT 'Sequential refill number for the prescription (0=original fill, 1=first refill, etc.). Used in early refill DUR alert logic to determine if the member is refilling too soon relative to the previous fills days supply.',
    `result_of_service_code` STRING COMMENT 'Two-character NCPDP code (Field 441-E6) indicating the outcome of the pharmacists intervention in response to the DUR alert (e.g., FA=Filled As Is, FN=Filled with Prescriber Approval, FC=Filled, Calling Prescriber, FD=Filled, Directions Clarified). Required for CMS Part D DUR reporting.. Valid values are `^[A-Z0-9]{2}$`',
    `severity_level_code` STRING COMMENT 'Coded severity level of the DUR alert indicating clinical significance. Typically: 1=Contraindicated/Severe, 2=Major, 3=Moderate, 4=Minor, 5=Informational. Drives pharmacist override requirements and adjudication workflow.. Valid values are `1|2|3|4|5`',
    `severity_level_description` STRING COMMENT 'Plain-language description of the DUR alert severity level (e.g., Contraindicated, Major, Moderate, Minor, Informational). Used in pharmacist-facing displays and DUR reporting dashboards.. Valid values are `Contraindicated|Major|Moderate|Minor|Informational`',
    `step_therapy_flag` BOOLEAN COMMENT 'Indicates whether the DUR alert is related to a step therapy protocol violation, where the member has not tried a required first-line drug before the prescribed drug. Supports step therapy enforcement and CMS Part D reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the DUR alert record was last modified in the data platform. Tracks updates such as status changes, override entries, or adjudication outcome revisions for audit and data lineage purposes.',
    CONSTRAINT pk_dur_alert PRIMARY KEY(`dur_alert_id`)
) COMMENT 'Drug Utilization Review (DUR) alert record generated during pharmacy claim adjudication. Captures DUR alert type (drug-drug interaction, drug-disease, duplicate therapy, high dose, early refill), severity level, alert code (NCPDP DUR codes), prescriber NPI, dispensing pharmacy NPI, member ID, drug NDC, professional service code, result of service code, and adjudication outcome. Supports prospective and retrospective DUR programs and CMS Part D DUR reporting.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` (
    `dispensing_pharmacy_id` BIGINT COMMENT 'Unique surrogate identifier for the dispensing pharmacy record within the PBM network master. Primary key for this entity.',
    `baa_id` BIGINT COMMENT 'Foreign key linking to compliance.baa. Business justification: BAA management: each dispensing pharmacy must have a Business Associate Agreement for PHI handling; compliance tracks BAAs per pharmacy.',
    `provider_contract_id` BIGINT COMMENT 'Internal pharmacy identifier assigned by the PBM system (RxClaim or Argus) for claim routing and adjudication. May differ from NCPDP ID in multi-PBM environments. Used for system-level reconciliation.',
    `mac_list_id` BIGINT COMMENT 'Identifier of the MAC pricing list applied to this pharmacy for generic drug reimbursement. MAC lists define the maximum reimbursable ingredient cost for multi-source generic drugs. References the applicable MAC list version in the PBM system.',
    `provider_id` BIGINT COMMENT 'The 7-digit NCPDP pharmacy identifier (formerly NABP number) used as the primary pharmacy identifier in PBM claim transactions, formulary lookups, and pharmacy network directories. Sourced from RxClaim or Argus PBM system.',
    `record_id` BIGINT COMMENT 'Foreign key linking to credential.credential_record. Business justification: Network participation reports need each pharmacys verified credential record; FK provides authoritative license/DEA data for compliance audits.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Required for network participation reporting and CMS network adequacy; each pharmacy must be linked to the provider network it belongs to.',
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
    `network_tier` STRING COMMENT 'Pharmacy network tier designation that determines member cost-sharing levels and reimbursement rates. Preferred pharmacies offer lower member cost-sharing; specialty tier applies to specialty drug dispensing locations.. Valid values are `preferred|standard|specialty|out_of_network`',
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
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Regulatory obligations tied to PBM contracts; compliance team records which obligations each contract must satisfy.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Contract management assigns a manager employee; needed for performance monitoring and audit of PBM contracts.',
    `formulary_id` BIGINT COMMENT 'Reference to the drug formulary associated with this PBM contract. The formulary defines covered drugs, tier assignments, and utilization management rules governed by this contract.',
    `vendor_id` BIGINT COMMENT 'Reference identifier for the PBM vendor organization in the health plans vendor or trading partner master. Supports linking to vendor management records for credentialing and payment.',
    `vbc_arrangement_id` BIGINT COMMENT 'add column vbc_arrangement_id (BIGINT) with FK to network.vbc_arrangement.vbc_arrangement_id - modern PBM contracts include VBC components',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` (
    `drug_rebate_id` BIGINT COMMENT 'Unique surrogate identifier for each drug manufacturer rebate record in the pharmacy benefit management system. Primary key for the drug_rebate data product.',
    `drug_master_id` BIGINT COMMENT 'FK to pharmacy.drug_master',
    `formulary_id` BIGINT COMMENT 'Reference to the formulary under which the drugs tier placement drove the rebate calculation.',
    `pbm_contract_id` BIGINT COMMENT 'Reference to the PBM contract under which this rebate was negotiated and invoiced. Links to the governing PBM agreement.',
    `vendor_id` BIGINT COMMENT 'Reference to the pharmaceutical manufacturer entity responsible for the rebate obligation.',
    `awp_unit_price` DECIMAL(18,2) COMMENT 'Average Wholesale Price (AWP) per unit for the drug as of the rebate period, used as the price benchmark for rebate rate calculations.',
    `calculated_rebate_amount` DECIMAL(18,2) COMMENT 'Rebate amount computed by applying the contracted rebate rate to the utilization units and applicable price benchmark. Represents the expected receivable before invoicing.',
    `contracted_rebate_rate` DECIMAL(18,2) COMMENT 'Negotiated rebate rate expressed as a decimal percentage of Average Wholesale Price (AWP) or Wholesale Acquisition Cost (WAC) per the PBM contract terms. Confidential as it reflects proprietary pricing agreements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this drug rebate record was first created in the data platform. Supports audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this rebate record (e.g., USD). Supports multi-currency reporting for plans operating in US territories.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `dispute_reason` STRING COMMENT 'Free-text or coded reason for a rebate dispute when reconciliation_status is disputed. Captures manufacturer objections, utilization data discrepancies, or contract interpretation differences.',
    `dispute_resolution_date` DATE COMMENT 'Date on which a disputed rebate was formally resolved. Null if no dispute exists or dispute is still open.',
    `drug_tier` STRING COMMENT 'Formulary tier at which the drug was placed during the rebate period, which determines the applicable rebate rate. Tier placement is a key driver of rebate negotiations.. Valid values are `tier_1|tier_2|tier_3|tier_4|tier_5|specialty`',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Medication)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gl_account_code` STRING COMMENT 'Oracle Financials General Ledger account code to which the rebate receivable or cash receipt is posted. Supports financial close and statutory reporting.',
    `invoice_date` DATE COMMENT 'Date on which the rebate invoice was issued to the manufacturer or PBM. Marks the start of the payment due window per contract terms.',
    `invoiced_amount` DECIMAL(18,2) COMMENT 'Rebate amount formally invoiced to the manufacturer or PBM for the period. May differ from calculated amount due to adjustments, disputes, or rounding.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `line_of_business` STRING COMMENT 'Line of business under which the drug utilization generating this rebate was incurred: commercial, medicare_part_d, medicaid, exchange (ACA marketplace), or individual. Drives MLR segmentation and CMS reporting.. Valid values are `commercial|medicare_part_d|medicaid|exchange|individual`',
    `manufacturer_name` STRING COMMENT 'Legal name of the pharmaceutical manufacturer obligated to pay the rebate. Retained on the transaction for reporting and reconciliation without requiring a join.',
    `market_share_pct` DECIMAL(18,2) COMMENT 'Drugs market share within its therapeutic class during the rebate period, expressed as a decimal percentage. Used to determine market share rebate tier attainment per contract.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `mlr_rebate_category` STRING COMMENT 'Classification of the rebate for ACA Medical Loss Ratio (MLR) reporting purposes: medical_cost_reduction (reduces incurred claims), quality_improvement (allocated to QI activities), or excluded (not counted in MLR numerator).. Valid values are `medical_cost_reduction|quality_improvement|excluded`',
    `ndc_code` STRING COMMENT '11-digit National Drug Code identifying the specific drug product (labeler, product, package) subject to the rebate. Formatted as 5-4-2 per FDA NDC Directory standards.. Valid values are `^d{5}-d{4}-d{2}$`',
    `part_d_indicator` BOOLEAN COMMENT 'Indicates whether this rebate is subject to CMS Part D rebate pass-through requirements. True for Medicare Part D covered drugs; False for commercial or Medicaid lines of business.',
    `pass_through_amount` DECIMAL(18,2) COMMENT 'Portion of the received rebate amount that must be passed through to CMS or plan members per Part D or ACA requirements. Critical for MLR and CMS DIR (Direct and Indirect Remuneration) reporting.',
    `payment_due_date` DATE COMMENT 'Contractual date by which the manufacturer or PBM must remit the rebate payment. Used for aging analysis and dispute escalation.',
    `payment_received_date` DATE COMMENT 'Date on which the rebate payment was actually received and posted. Null if payment has not yet been received.',
    `performance_target_met_indicator` BOOLEAN COMMENT 'Indicates whether the contractual performance target (e.g., market share threshold, utilization goal) was met during the rebate period, triggering performance rebate eligibility.',
    `prior_auth_required_indicator` BOOLEAN COMMENT 'Indicates whether prior authorization was required for the drug during the rebate period. PA requirements can affect utilization volumes and rebate performance thresholds.',
    `rebate_invoice_number` STRING COMMENT 'Externally-known invoice number assigned by the PBM or manufacturer for this rebate billing cycle. Used for reconciliation with accounts receivable and PBM remittance.',
    `rebate_period_end_date` DATE COMMENT 'Last day of the rebate performance or utilization measurement period for which this rebate invoice applies.',
    `rebate_period_start_date` DATE COMMENT 'First day of the rebate performance or utilization measurement period (typically a calendar quarter) for which this rebate invoice applies.',
    `rebate_rate_basis` STRING COMMENT 'Price benchmark on which the contracted rebate rate is applied: Average Wholesale Price (AWP), Wholesale Acquisition Cost (WAC), Maximum Allowable Cost (MAC), or net price.. Valid values are `AWP|WAC|MAC|net_price`',
    `rebate_type` STRING COMMENT 'Classification of the rebate by its contractual basis: base (standard formulary placement), performance (quality/utilization targets), market_share (volume threshold), formulary_access (preferred tier), inflation (price increase above CPI), or supplemental (ad hoc negotiated). [ENUM-REF-CANDIDATE: base|performance|market_share|formulary_access|inflation|supplemental — promote to reference product if additional types emerge]. Valid values are `base|performance|market_share|formulary_access|inflation|supplemental`',
    `received_amount` DECIMAL(18,2) COMMENT 'Actual cash amount received from the manufacturer or PBM for this rebate invoice. Used for cash reconciliation and MLR reporting.',
    `reconciliation_status` STRING COMMENT 'Current lifecycle status of the rebate invoice reconciliation process: pending (not yet invoiced), invoiced (invoice sent), partially_received (partial payment), received (fully paid), disputed (discrepancy under review), written_off (uncollectable). [ENUM-REF-CANDIDATE: pending|invoiced|partially_received|received|disputed|written_off — promote to reference product]. Valid values are `pending|invoiced|partially_received|received|disputed|written_off`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `source_system_code` STRING COMMENT 'Identifies the operational source system from which this rebate record originated: RxClaim, Argus (PBM platforms), or manual (spreadsheet/manual entry). Supports data lineage in the Databricks Silver layer.. Valid values are `RxClaim|Argus|manual`',
    `specialty_drug_indicator` BOOLEAN COMMENT 'Indicates whether the drug is classified as a specialty drug, which typically carries higher rebate rates and requires prior authorization. Specialty drugs are subject to distinct PBM contract terms.',
    `step_therapy_indicator` BOOLEAN COMMENT 'Indicates whether step therapy protocols were in effect for this drug during the rebate period. Step therapy requirements influence market share and performance rebate attainment.',
    `therapeutic_class_code` STRING COMMENT 'Pharmacological therapeutic class code (e.g., GPI or ATC code) for the drug, used to aggregate rebates by drug category for formulary strategy and analytics.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this drug rebate record was last modified in the data platform. Used to detect changes during incremental Silver layer processing.',
    `utilization_claims_count` STRING COMMENT 'Number of pharmacy claims adjudicated for the drug during the rebate period. Used to validate utilization units and support audit of rebate calculations.',
    `utilization_units` DECIMAL(18,2) COMMENT 'Total dispensed units (e.g., tablets, milliliters, grams) of the drug during the rebate period, as reported to the manufacturer for rebate calculation. Sourced from PBM claims data.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between the invoiced amount and the received amount. A non-zero variance triggers reconciliation or dispute resolution workflows.',
    `wac_unit_price` DECIMAL(18,2) COMMENT 'Wholesale Acquisition Cost (WAC) per unit for the drug as of the rebate period. WAC is the manufacturers list price and an alternative rebate rate basis to AWP.',
    CONSTRAINT pk_drug_rebate PRIMARY KEY(`drug_rebate_id`)
) COMMENT 'Transactional record capturing drug manufacturer rebate invoices and payments negotiated through the PBM. Captures rebate period, drug NDC, manufacturer name, rebate type (base/performance/market share), contracted rebate rate, utilization units, calculated rebate amount, invoiced amount, received amount, and reconciliation status. Supports MLR (Medical Loss Ratio) reporting and CMS Part D rebate pass-through requirements.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` (
    `specialty_drug_program_id` BIGINT COMMENT 'Unique surrogate identifier for the specialty drug program record. Primary key for this entity in the Silver Layer lakehouse.',
    `drug_master_id` BIGINT COMMENT 'add column drug_master_id (BIGINT) with FK to pharmacy.drug_master.drug_master_id - specialty programs target specific drugs',
    `formulary_id` BIGINT COMMENT 'Reference to the formulary under which this specialty drug program operates. Links the program to the applicable drug tier structure and coverage rules managed in the PBM system.',
    `health_plan_id` BIGINT COMMENT 'Reference to the health plan or benefit plan under which this specialty drug program is offered. Links to the plan and benefit domain for coverage determination and member eligibility.',
    `pbm_contract_id` BIGINT COMMENT 'Reference to the PBM contract governing the administration of this specialty drug program, including pricing terms (MAC, AWP, WAC), dispensing fees, and performance guarantees.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Specialty drug programs are overseen by a program manager employee; required for program governance and reporting.',
    `accumulator_adjustment_flag` BOOLEAN COMMENT 'Indicates whether the Copay Accumulator Adjustment Program (CAAP) applies to this specialty drug program. When true, manufacturer copay assistance payments do NOT count toward the members deductible or Maximum Out-of-Pocket (MOOP). Critical for CMS Part D compliance.',
    `awp_discount_pct` DECIMAL(18,2) COMMENT 'Contracted discount percentage applied to the Average Wholesale Price (AWP) for specialty drugs dispensed under this program. Expressed as a decimal (e.g., 0.1800 = 18% discount). Governs ingredient cost reimbursement to specialty pharmacies.',
    `clinical_management_required_flag` BOOLEAN COMMENT 'Indicates whether drugs in this program require active clinical management, including disease management, case management, or care coordination through the Care Management Platform (Casenet TruCare or Altruista).',
    `cms_part_d_specialty_tier_flag` BOOLEAN COMMENT 'Indicates whether this program is reportable to CMS under the Part D specialty tier requirements. Drives inclusion in CMS Part D formulary submissions and Star Ratings (STAR) calculations.',
    `cold_chain_required_flag` BOOLEAN COMMENT 'Indicates whether drugs in this program require temperature-controlled cold chain handling and storage during dispensing and shipping. Drives specialty pharmacy network eligibility and logistics requirements.',
    `copay_assistance_flag` BOOLEAN COMMENT 'Indicates whether a manufacturer-sponsored copay assistance program (copay card) is available for drugs in this specialty program. Triggers copay accumulator adjustment program (CAAP) evaluation logic.',
    `copay_assistance_max_benefit_amount` DECIMAL(18,2) COMMENT 'Maximum dollar amount of manufacturer copay assistance benefit available to a member per program year under this specialty drug program. Used in accumulator adjustment calculations and OOP tracking.',
    `copay_assistance_program_name` STRING COMMENT 'Name of the manufacturer-sponsored copay assistance program (e.g., copay card program) associated with this specialty drug program. Used for affordability program tracking and OIG compliance reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the specialty drug program record was first created in the system. Supports audit trail, data lineage, and regulatory compliance requirements under HIPAA and CMS.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `dispensing_fee_amount` DECIMAL(18,2) COMMENT 'Contracted dispensing fee paid to specialty pharmacies per prescription dispensed under this program. Expressed in USD. Component of total pharmacy reimbursement alongside ingredient cost.',
    `drug_utilization_review_type` STRING COMMENT 'Type of Drug Utilization Review (DUR) applied to claims under this specialty program. Prospective DUR occurs at point-of-sale; retrospective DUR occurs post-adjudication for quality and safety analysis.. Valid values are `prospective|concurrent|retrospective|none`',
    `effective_date` DATE COMMENT 'Date on which the specialty drug program becomes active and eligible for member enrollment and claim adjudication. Aligns with plan year or contract effective dates.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: PractitionerRole.specialty)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `foundation_grant_flag` BOOLEAN COMMENT 'Indicates whether independent charitable foundation grants are available to assist members with cost-sharing obligations for drugs in this specialty program. Foundation grants may or may not count toward OOP accumulators depending on CMS guidance.',
    `hub_services_enrollment_flag` BOOLEAN COMMENT 'Indicates whether members must enroll in a manufacturer-sponsored hub services program to access drugs under this specialty program. Hub services may include patient support, adherence programs, and financial assistance coordination.',
    `icd_condition_codes` STRING COMMENT 'Comma-delimited list of ICD-10-CM diagnosis codes representing the covered clinical conditions for which drugs in this program are indicated. Used for prior authorization (PA) criteria and medical necessity determination.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the specialty drug program record was most recently modified. Used for change data capture (CDC), audit trail, and Silver Layer incremental processing in the Databricks Lakehouse.',
    `limited_distribution_flag` BOOLEAN COMMENT 'Indicates whether the drugs in this program are classified as Limited Distribution Drugs (LDD), available only through a restricted network of specialty pharmacies designated by the manufacturer.',
    `line_of_business` STRING COMMENT 'The insurance line of business (LOB) under which this specialty drug program operates. Determines applicable regulatory requirements, formulary rules, and CMS reporting obligations.. Valid values are `commercial|medicare_part_d|medicaid|exchange|fehb`',
    `mail_order_allowed_flag` BOOLEAN COMMENT 'Indicates whether drugs in this program may be dispensed via mail-order pharmacy channels in addition to retail specialty pharmacies.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `max_days_supply` STRING COMMENT 'Maximum number of days supply permitted per dispensing event for specialty drugs under this program. Typically 30 days for specialty drugs per CMS Part D guidance. Enforced at PBM adjudication.',
    `oop_accumulator_applies_flag` BOOLEAN COMMENT 'Indicates whether third-party assistance payments (copay cards, foundation grants) applied to this program count toward the members Out-of-Pocket (OOP) and Maximum Out-of-Pocket (MOOP) accumulators. Governs accumulator adjustment compliance.',
    `patient_assistance_program_flag` BOOLEAN COMMENT 'Indicates whether a manufacturer-sponsored Patient Assistance Program (PAP) is available for uninsured or underinsured members enrolled in this specialty drug program.',
    `prior_auth_required_flag` BOOLEAN COMMENT 'Indicates whether Prior Authorization (PA) is required for all drugs covered under this specialty program before dispensing. Drives integration with the Utilization Management (UM) system (InterQual or MCG).',
    `program_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the specialty drug program within the Pharmacy Benefit Management (PBM) system (RxClaim or Argus). Used in EDI transactions and CMS Part D reporting.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `program_description` STRING COMMENT 'Detailed narrative description of the specialty drug program, including clinical rationale, covered conditions, and program objectives. Used in plan documents, Summary of Benefits and Coverage (SBC), and member communications.',
    `program_name` STRING COMMENT 'Human-readable name of the specialty drug program (e.g., Oncology Specialty Tier Program, Rheumatology Hub Services Program). Used in member-facing communications and plan documents.',
    `program_status` STRING COMMENT 'Current lifecycle state of the specialty drug program. Controls whether the program is available for member enrollment and claim adjudication.. Valid values are `active|inactive|pending|suspended|terminated`',
    `program_type` STRING COMMENT 'Classification of the specialty drug program by its primary operational function. Drives downstream adjudication logic and reporting segmentation. [ENUM-REF-CANDIDATE: specialty_tier|hub_services|copay_assistance|patient_assistance|rems|cold_chain|limited_distribution — promote to reference product]',
    `quantity_limit_flag` BOOLEAN COMMENT 'Indicates whether quantity limit (QL) restrictions apply to drugs dispensed under this specialty program. Quantity limits are enforced at the PBM adjudication level.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `rems_required_flag` BOOLEAN COMMENT 'Indicates whether the specialty drugs in this program are subject to an FDA-mandated Risk Evaluation and Mitigation Strategy (REMS). When true, dispensing requires REMS-certified pharmacy and prescriber enrollment.',
    `specialty_drug_list_name` STRING COMMENT 'Name of the specialty drug list (SDL) associated with this program, identifying the set of National Drug Codes (NDCs) covered under the program. Managed in the PBM formulary system.',
    `specialty_pharmacy_network_name` STRING COMMENT 'Name of the specialty pharmacy network designated to dispense drugs under this program. Defines the restricted network of pharmacies eligible to fill specialty prescriptions.',
    `specialty_tier_designation` STRING COMMENT 'Formulary tier designation assigned to specialty drugs in this program. Determines member cost-sharing obligations and CMS Part D specialty tier reporting requirements.. Valid values are `tier_4|tier_5|tier_6|specialty_preferred|specialty_non_preferred`',
    `step_therapy_required_flag` BOOLEAN COMMENT 'Indicates whether step therapy protocols are enforced for drugs in this program, requiring members to try and fail on preferred therapies before accessing specialty drugs. Governed by state step therapy laws and CMS guidance.',
    `termination_date` DATE COMMENT 'Date on which the specialty drug program is no longer active. Null indicates an open-ended program with no scheduled end. Used for plan year transitions and CMS Part D reporting.',
    `therapeutic_category` STRING COMMENT 'Primary therapeutic or disease category associated with the specialty drugs in this program (e.g., Oncology, Rheumatology, Multiple Sclerosis, HIV/AIDS). Used for clinical reporting, HEDIS measures, and population health analytics.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `wac_discount_pct` DECIMAL(18,2) COMMENT 'Contracted discount percentage applied to the Wholesale Acquisition Cost (WAC) for specialty drugs in this program. Used as an alternative pricing basis to AWP in PBM contract negotiations.',
    CONSTRAINT pk_specialty_drug_program PRIMARY KEY(`specialty_drug_program_id`)
) COMMENT 'Master record for specialty pharmacy programs managing high-cost, complex specialty drugs and associated patient affordability programs. Captures program name, specialty drug list (NDCs), specialty pharmacy network, clinical management requirements, REMS flag, cold chain handling, hub services enrollment, and program effective dates. Owns all copay assistance and affordability program tracking: manufacturer copay assistance programs (copay cards), patient assistance programs (PAP), foundation grants, copay accumulator adjustment program (CAAP) interactions, benefit amounts applied, accumulator adjustment flags, and coordination with member out-of-pocket (OOP) accumulators. This is the SSOT for specialty drug management, affordability program administration, accumulator adjustment compliance, and CMS Part D specialty tier reporting.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` (
    `mtm_service_id` BIGINT COMMENT 'Primary key for mtm_service',
    `health_plan_id` BIGINT COMMENT 'Reference to the Part D prescription drug plan (PDP) or Medicare Advantage Prescription Drug (MA-PD) plan under which the member is enrolled and MTM eligibility is determined.',
    `subscriber_id` BIGINT COMMENT 'Reference to the health plan member who received the MTM service. Links to the member master record in the core administration platform (Facets/QNXT).',
    `program_id` BIGINT COMMENT 'Identifier for the specific MTM program offering under which this service was delivered. A plan sponsor may operate multiple MTM programs targeting different chronic condition cohorts.',
    `pharmacy_claim_id` BIGINT COMMENT 'FK to pharmacy.pharmacy_claim.pharmacy_claim_id',
    `chronic_condition_count` STRING COMMENT 'Number of qualifying chronic conditions the member has at the time of MTM eligibility determination. CMS Part D MTM eligibility requires a minimum number of chronic conditions (typically 2-3 depending on plan criteria). Used for eligibility validation and population stratification.',
    `cmr_completion_date` DATE COMMENT 'Date on which the annual Comprehensive Medication Review (CMR) was completed for the member. CMS requires at least one CMR per calendar year for all enrolled MTM beneficiaries. Directly drives the CMS STAR Ratings MTM CMR Completion Rate measure.',
    `cms_reporting_period` STRING COMMENT 'CMS Part D reporting period to which this MTM service record is attributed (e.g., 2024-Q1, 2024-ANNUAL). Used for CMS Part D MTM program reporting submissions and STAR ratings measurement year alignment.. Valid values are `^[0-9]{4}-(Q1|Q2|Q3|Q4|ANNUAL)$`',
    `contact_attempt_count` STRING COMMENT 'Total number of outreach attempts made to the member to schedule or deliver the MTM service. CMS requires documentation of good-faith efforts to reach enrolled members. Used for compliance audits and outreach effectiveness analytics.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this MTM service record was first created in the data platform. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for audit trail and data lineage in the Databricks Silver Layer.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `disenrollment_date` DATE COMMENT 'Date on which the member was disenrolled or opted out of the MTM program. Null if the member remains enrolled. Used to track program retention and calculate MTM completion rates.',
    `drug_therapy_problem_type` STRING COMMENT 'Primary category of drug therapy problem identified during the MTM service. Common types include: unnecessary drug therapy, needs additional drug therapy, ineffective drug, dosage too low, dosage too high, adverse drug reaction, non-adherence. [ENUM-REF-CANDIDATE: UNNECESSARY_DRUG|NEEDS_ADDITIONAL_DRUG|INEFFECTIVE_DRUG|DOSE_TOO_LOW|DOSE_TOO_HIGH|ADVERSE_REACTION|NON_ADHERENCE|NONE — promote to reference product]',
    `dur_outcome_code` STRING COMMENT 'NCPDP-standard Drug Utilization Review (DUR) outcome code documenting the result of the pharmacists clinical intervention during the MTM service (e.g., 1A = filled as is, 1B = filled with prescriber approval, 1C = not filled). Sourced from RxClaim or Argus PBM system DUR transaction records.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `eligibility_determination_date` DATE COMMENT 'Date on which the member was determined to be eligible for the MTM program based on CMS Part D criteria (multiple chronic conditions, multiple Part D drugs, likely to incur annual costs above the CMS threshold).',
    `enrollment_date` DATE COMMENT 'Date on which the eligible member was enrolled into the MTM program. CMS requires auto-enrollment of all eligible beneficiaries with opt-out capability.',
    `estimated_annual_drug_cost` DECIMAL(18,2) COMMENT 'Estimated annual cost of Part D covered drugs for the member at the time of MTM eligibility determination. CMS requires members likely to incur annual drug costs above the established threshold to be enrolled. Expressed in USD.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `follow_up_date` DATE COMMENT 'Scheduled or actual date of the follow-up contact or service following the MTM encounter. Null if no follow-up is required or scheduled. Used to track closure of open MAP items and clinical recommendations.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether a follow-up contact or service is required after the current MTM encounter based on clinical findings or unresolved MAP items. True = follow-up required; False = no follow-up needed.',
    `follow_up_status` STRING COMMENT 'Current status of the follow-up action required after the MTM service. PENDING = follow-up scheduled but not yet completed; COMPLETED = follow-up successfully conducted; DECLINED = member declined follow-up; UNREACHABLE = member could not be contacted for follow-up; NOT_REQUIRED = no follow-up needed.. Valid values are `PENDING|COMPLETED|DECLINED|UNREACHABLE|NOT_REQUIRED`',
    `intervention_count` STRING COMMENT 'Total number of clinical interventions or recommendations made during the MTM service encounter (e.g., drug therapy problem resolutions, adherence recommendations, prescriber referrals). Used for quality reporting and pharmacist productivity analytics.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_contact_attempt_date` DATE COMMENT 'Date of the most recent outreach attempt made to the member for MTM scheduling or delivery. Used alongside contact_attempt_count to document good-faith outreach efforts for CMS compliance.',
    `map_item_count` STRING COMMENT 'Number of action items documented in the Medication Action Plan (MAP) provided to the member. Each MAP item represents a specific recommendation or goal agreed upon between the pharmacist and the member.',
    `map_provided_flag` BOOLEAN COMMENT 'Indicates whether a written Medication Action Plan (MAP) was provided to the member following the CMR. CMS requires a standardized MAP to be delivered to the member and their prescriber(s) after each CMR. True = MAP provided; False = MAP not yet provided.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `member_consent_flag` BOOLEAN COMMENT 'Indicates whether the member provided consent to participate in the MTM service and for sharing of clinical findings with their prescriber(s). True = consent obtained; False = consent not obtained or pending. Required for HIPAA compliance when sharing PHI with prescribers.',
    `opt_out_flag` BOOLEAN COMMENT 'Indicates whether the member has opted out of the MTM program. CMS requires auto-enrollment with opt-out capability. True = member has opted out; False = member remains enrolled. When True, disenrollment_date should be populated.',
    `opt_out_reason` STRING COMMENT 'Reason code for the members opt-out or disenrollment from the MTM program. Null if the member has not opted out. Used for program retention analysis and CMS reporting.. Valid values are `MEMBER_REQUEST|DECEASED|DISENROLLED_FROM_PLAN|MOVED_OUT_OF_AREA|OTHER`',
    `part_d_drug_count` STRING COMMENT 'Number of Part D covered drugs the member is taking at the time of MTM eligibility determination. CMS Part D MTM eligibility requires a minimum number of Part D drugs (typically 8 or more). Used for eligibility validation.',
    `pbm_member_code` STRING COMMENT 'Member identifier assigned by the Pharmacy Benefit Manager (PBM) system (RxClaim or Argus) used to cross-reference the MTM record with pharmacy claims and formulary data.',
    `personal_medication_list_provided_flag` BOOLEAN COMMENT 'Indicates whether a Personal Medication List (PML) was provided to the member as part of the CMR standardized format. CMS requires both a MAP and a PML to be delivered following each CMR. True = PML provided; False = PML not provided.',
    `pharmacist_npi` STRING COMMENT '10-digit National Provider Identifier (NPI) of the pharmacist or clinical pharmacist who delivered the MTM service, including Comprehensive Medication Review (CMR) or Targeted Medication Review (TMR). Required for CMS Part D MTM reporting.. Valid values are `^[0-9]{10}$`',
    `pharmacist_recommendation_notes` STRING COMMENT 'Free-text clinical notes documenting the pharmacists recommendations, findings, and interventions during the MTM service encounter. Contains Protected Health Information (PHI) and must be handled in accordance with HIPAA Privacy Rule requirements.',
    `prescriber_notification_date` DATE COMMENT 'Date on which the prescriber(s) were notified of the MTM service findings and MAP items. Null if notification has not yet been sent. Used for compliance tracking against CMS timelines.',
    `prescriber_notification_flag` BOOLEAN COMMENT 'Indicates whether the members prescriber(s) were notified of the MTM service findings, recommendations, or MAP items. CMS requires that the MAP and relevant clinical findings be shared with the prescriber. True = prescriber notified; False = notification pending or not completed.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `service_date` DATE COMMENT 'Calendar date on which the MTM service (CMR, TMR, or follow-up) was delivered to the member. This is the principal real-world event date used for CMS Part D MTM reporting and STAR ratings quality measure calculations.',
    `service_delivery_channel` STRING COMMENT 'Mode through which the MTM service was delivered to the member. CMS requires CMRs to be offered as interactive, person-to-person consultations (in-person or telehealth). Supports channel-level analytics and compliance verification.. Valid values are `IN_PERSON|TELEPHONE|TELEHEALTH|MAIL|SECURE_MESSAGE`',
    `service_duration_minutes` STRING COMMENT 'Duration of the MTM service encounter in minutes. Used for pharmacist productivity reporting, billing reconciliation with PBM, and quality analytics. CMR encounters typically range from 30 to 60 minutes.',
    `service_status` STRING COMMENT 'Current lifecycle status of the MTM service record. SCHEDULED = appointment set; IN_PROGRESS = service initiated; COMPLETED = service fully delivered and documented; DECLINED = member declined participation; UNREACHABLE = member could not be contacted; CANCELLED = service cancelled prior to delivery.. Valid values are `SCHEDULED|IN_PROGRESS|COMPLETED|DECLINED|UNREACHABLE|CANCELLED`',
    `service_type` STRING COMMENT 'Classification of the MTM service delivered. CMR = Comprehensive Medication Review (annual face-to-face or telehealth); TMR = Targeted Medication Review (quarterly or as needed); FOLLOW_UP = follow-up contact on prior CMR/TMR; REFERRAL = referral to prescriber or specialist; OTHER = other MTM-related service.. Valid values are `CMR|TMR|FOLLOW_UP|REFERRAL|OTHER`',
    `source_system_code` STRING COMMENT 'Code identifying the operational source system from which this MTM service record originated. Supports data lineage tracking and reconciliation across PBM (RxClaim/Argus) and Care Management (Casenet TruCare/Altruista) platforms.. Valid values are `RXCLAIM|ARGUS|CASENET|ALTRUISTA|MANUAL|OTHER`',
    `source_system_record_code` STRING COMMENT 'Native record identifier from the originating source system (RxClaim, Argus, Casenet TruCare, or Altruista) for this MTM service record. Used for data lineage, reconciliation, and cross-system traceability in the Silver Layer lakehouse.',
    `star_measure_eligible_flag` BOOLEAN COMMENT 'Indicates whether this MTM service record is eligible to be counted toward the CMS STAR Ratings MTM Completion Rate for Comprehensive Medication Reviews (CMR) quality measure. True = eligible for STAR measure numerator/denominator; False = excluded from STAR measure calculation.',
    `tmr_date` DATE COMMENT 'Date on which the most recent Targeted Medication Review (TMR) was conducted. TMRs are performed at least quarterly for enrolled members who have not yet received a CMR or as clinically indicated. Null if no TMR has been performed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this MTM service record was last modified in the data platform. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change tracking, incremental processing, and audit trail in the Databricks Silver Layer.',
    CONSTRAINT pk_mtm_service PRIMARY KEY(`mtm_service_id`)
) COMMENT 'Record for Medication Therapy Management (MTM) services delivered to eligible members, as required under CMS Part D. Captures member eligibility criteria, MTM program enrollment date, comprehensive medication review (CMR) completion date, targeted medication review (TMR) date, pharmacist NPI, interventions recommended, medication action plan (MAP) items, follow-up status, and outcomes. Supports CMS Part D MTM reporting and STAR ratings quality measures.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` (
    `formulary_exception_id` BIGINT COMMENT 'Primary key for formulary_exception',
    `case_id` BIGINT COMMENT 'Identifier of the associated appeal record if the member or prescriber has filed an appeal against a denied formulary exception. Links to the appeals management entity. Null if no appeal has been filed.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Formulary exception requests are reviewed under regulatory obligations; linking captures which obligation governs each exception.',
    `record_id` BIGINT COMMENT 'add column credential_record_id (BIGINT) with FK to credential.record.record_id - exception requested by credentialed prescriber',
    `employee_id` BIGINT COMMENT 'Identifier of the clinical pharmacist, pharmacy technician, or medical director who reviewed and rendered the decision on the formulary exception request. Links to the workforce/staff entity.',
    `formulary_id` BIGINT COMMENT 'Identifier of the specific formulary against which the exception is being evaluated. A plan may maintain multiple formularies (e.g., commercial, Medicare Part D, Medicaid). Links to the formulary master in the PBM system (RxClaim/Argus).',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health benefit plan under which the formulary exception is being requested. Determines the applicable formulary, tier structure, and exception adjudication rules.',
    `identity_id` BIGINT COMMENT 'Identifier of the health plan member on whose behalf the formulary exception request is submitted. Links to the member master record in the core administration platform (Facets/QNXT).',
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
    `diagnosis_code` STRING COMMENT 'International Classification of Diseases (ICD-10-CM) diagnosis code supporting the medical necessity of the requested drug. Provided by the prescriber as part of the clinical justification for the exception. Treated as confidential health information.. Valid values are `^[A-Z][0-9A-Z]{1,6}$`',
    `drug_name` STRING COMMENT 'Brand or generic name of the drug for which the formulary exception is requested, as submitted by the requestor. Stored for human-readable reference alongside the NDC code.',
    `drug_ndc` STRING COMMENT '11-digit National Drug Code (NDC) of the specific drug product for which the formulary exception is requested. Identifies the labeler, product, and package configuration at the NDC level.. Valid values are `^[0-9]{11}$`',
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

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` (
    `part_d_submission_id` BIGINT COMMENT 'Unique surrogate identifier for each CMS Part D regulatory data submission record in the lakehouse silver layer. Serves as the primary key for this entity.',
    `health_plan_id` BIGINT COMMENT 'add column health_plan_id (BIGINT) with FK to plan.health_plan.health_plan_id - Part D submissions are per contract/plan',
    `benefit_package_id` BIGINT COMMENT 'The CMS-assigned Plan Benefit Package identifier associated with this submission. Distinguishes specific benefit packages within a Part D contract for formulary, cost-sharing, and coverage gap reporting.',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Part D submissions are a type of regulatory filing; linking to regulatory_submission records submission details and compliance tracking.',
    `accepted_record_count` STRING COMMENT 'The number of records within the submission batch that CMS accepted and processed successfully. Derived from the CMS acknowledgment response file. Used to calculate acceptance rate and identify partial rejections.',
    `batch_number` STRING COMMENT 'Externally assigned batch identifier assigned by the CMS submission system (RAPS, EDPS, or CGDP portal) for the submission file. Used to correlate records across the submission lifecycle and match CMS acknowledgment responses.',
    `benefit_year` STRING COMMENT 'The four-digit calendar year of the Medicare Part D benefit period to which this submission applies. Drives payment year reconciliation, risk adjustment settlement, and DIR reporting cycles with CMS.',
    `cgdp_invoice_amount` DECIMAL(18,2) COMMENT 'The total dollar amount invoiced under the Coverage Gap Discount Program for this submission, applicable to CGDP submission types. Represents manufacturer discount obligations for brand-name drugs dispensed to Part D beneficiaries in the coverage gap.',
    `clearinghouse_tracking_number` STRING COMMENT 'The tracking or reference identifier assigned by the EDI clearinghouse (Availity or Change Healthcare) upon receipt of the submission file. Used to trace submission status through the clearinghouse to CMS.',
    `cms_contract_number` STRING COMMENT 'The CMS-assigned Part D plan contract identifier (e.g., H1234 or S5678) under which this submission is filed. Identifies the health plans Medicare Part D contract for regulatory reporting and payment purposes.. Valid values are `^[HS][0-9]{4}$`',
    `cms_region_code` STRING COMMENT 'The CMS regional office code associated with the Part D contract under which this submission is filed. Used for regulatory routing and regional compliance reporting.',
    `cms_response_code` STRING COMMENT 'The acknowledgment or disposition code returned by CMS upon processing the submission batch. Maps to CMS-defined response code sets (e.g., RAPS response codes, EDPS acknowledgment codes). Used for automated error triage and compliance tracking.',
    `cms_response_date` TIMESTAMP COMMENT 'The timestamp when the CMS acknowledgment or response file was received by the health plan. Used to calculate CMS processing turnaround time and to trigger downstream reconciliation workflows.',
    `cms_response_description` STRING COMMENT 'Human-readable description of the CMS response code returned for this submission. Provides context for the acceptance, rejection, or error condition reported by CMS.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this Part D submission record was first created in the lakehouse silver layer. Serves as the record audit created timestamp for data lineage and ETL traceability.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `dir_amount` DECIMAL(18,2) COMMENT 'The total Direct and Indirect Remuneration dollar amount reported in this submission, applicable to DIR submission types. Represents post-point-of-sale price concessions, rebates, and other remuneration from manufacturers and pharmacies that reduce net drug costs. Required for CMS Part D DIR reconciliation.',
    `edi_interchange_control_number` STRING COMMENT 'The ISA13 interchange control number from the EDI transmission envelope, applicable to EDI-formatted submissions. Used to correlate submission files with EDI gateway acknowledgments (997/999) from the clearinghouse or CMS.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `error_detail` STRING COMMENT 'Structured or free-text description of errors returned by CMS for rejected or partially accepted records. May include CMS error codes, field-level rejection reasons, and record-level identifiers. Supports error remediation and resubmission workflows.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `hcc_record_count` STRING COMMENT 'The number of Hierarchical Condition Category diagnosis records included in this submission batch, applicable to RAPS and EDPS submission types. Used to monitor HCC capture completeness and risk score optimization.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_resubmission` BOOLEAN COMMENT 'Indicates whether this submission is a resubmission of a previously rejected or corrected batch (True) or an original submission (False). Used to track correction cycles and measure first-pass acceptance rates.',
    `is_timely_submission` BOOLEAN COMMENT 'Indicates whether the submission was transmitted to CMS on or before the regulatory deadline date (True) or after the deadline (False). Supports CMS compliance reporting and internal SLA monitoring.',
    `line_of_business` STRING COMMENT 'The Medicare Part D line of business associated with this submission. MAPD = Medicare Advantage Prescription Drug plan; PDP = standalone Prescription Drug Plan; EGWP = Employer Group Waiver Plan; LIS = Low Income Subsidy. Drives regulatory reporting segmentation.. Valid values are `MAPD|PDP|EGWP|LIS`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free-text field for operational notes, manual override justifications, or compliance annotations associated with this submission record. Used by compliance and operations teams to document exception handling, CMS communications, or remediation actions.',
    `original_batch_number` STRING COMMENT 'For resubmissions, the batch_id of the original submission that this record corrects or replaces. Null for original submissions. Enables lineage tracing across submission correction cycles.',
    `pbm_system_source` STRING COMMENT 'Identifies the source PBM system from which the submission data was extracted. Supports data lineage, reconciliation, and audit trail requirements. Values align to operational PBM platforms (RxClaim, Argus).. Valid values are `RXCLAIM|ARGUS|OTHER`',
    `pde_record_count` STRING COMMENT 'The number of Prescription Drug Event records included in this submission batch, applicable to PDE and EDPS submission types. PDE records are the foundational data element for CMS Part D payment and reconciliation.',
    `pending_record_count` STRING COMMENT 'The number of records within the submission batch that CMS has received but not yet finalized (e.g., held for additional review or in a processing queue). Supports real-time submission status monitoring.',
    `raf_impact_amount` DECIMAL(18,2) COMMENT 'The estimated revenue impact in dollars attributable to the risk adjustment data submitted in this batch, applicable to RAPS and EDPS submission types. Supports risk adjustment revenue integrity analysis and HCC-based payment reconciliation.',
    `reconciliation_date` DATE COMMENT 'The date on which the submission was fully reconciled against the CMS response. Null if reconciliation is not yet complete. Used for SLA tracking and audit trail.',
    `reconciliation_status` STRING COMMENT 'Indicates the reconciliation state of the submission against CMS response data. UNRECONCILED = CMS response not yet matched; IN_PROGRESS = reconciliation underway; RECONCILED = fully matched and closed; EXCEPTION = discrepancy identified requiring manual review.. Valid values are `UNRECONCILED|IN_PROGRESS|RECONCILED|EXCEPTION`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `rejected_record_count` STRING COMMENT 'The number of records within the submission batch that CMS rejected. Derived from the CMS acknowledgment response file. Drives error remediation workflows and resubmission prioritization.',
    `reporting_period_end_date` DATE COMMENT 'The last calendar date of the reporting period covered by this Part D submission. Together with reporting_period_start_date, defines the data window for the submission batch.',
    `reporting_period_start_date` DATE COMMENT 'The first calendar date of the reporting period covered by this Part D submission. Used to align submission data with the applicable benefit year, payment year, or reconciliation cycle as defined by CMS.',
    `resubmission_attempt_number` STRING COMMENT 'Sequential count of resubmission attempts for a given original batch. Value is 0 for original submissions, 1 for first resubmission, 2 for second, etc. Supports escalation workflows and CMS deadline compliance monitoring.',
    `submission_date` TIMESTAMP COMMENT 'The principal real-world event timestamp recording when the submission batch was transmitted to CMS. Distinct from the record audit created timestamp. Used for timeliness compliance tracking against CMS filing deadlines.',
    `submission_deadline_date` DATE COMMENT 'The regulatory deadline date by which this submission must be received by CMS. Used to assess timeliness compliance and trigger escalation alerts for at-risk submissions.',
    `submission_file_name` STRING COMMENT 'The name of the file transmitted to CMS for this submission batch. Used for audit trail, resubmission tracking, and reconciliation against CMS acknowledgment files.',
    `submission_format` STRING COMMENT 'The electronic data interchange or file format used for the CMS submission. EDI_837 = ANSI X12 837 pharmacy claim transaction; FLAT_FILE = CMS-specified fixed-width flat file; XML = extensible markup language; CSV = comma-separated values.. Valid values are `EDI_837|FLAT_FILE|XML|CSV`',
    `submission_status` STRING COMMENT 'Current workflow state of the Part D submission. PENDING = prepared but not yet transmitted; SUBMITTED = transmitted to CMS; ACCEPTED = CMS confirmed full acceptance; REJECTED = CMS rejected the batch; PARTIALLY_ACCEPTED = CMS accepted a subset of records; RECONCILED = submission reconciled against CMS response and closed.. Valid values are `PENDING|SUBMITTED|ACCEPTED|REJECTED|PARTIALLY_ACCEPTED|RECONCILED`',
    `submission_type` STRING COMMENT 'Classifies the type of CMS Part D regulatory submission. RAPS = Risk Adjustment Processing System pharmacy encounter; EDPS = Encounter Data Processing System; DIR = Direct and Indirect Remuneration report; CGDP = Coverage Gap Discount Program invoice; PDE = Prescription Drug Event. [ENUM-REF-CANDIDATE: RAPS|EDPS|DIR|CGDP|PDE — promote to reference product if additional types are added]. Valid values are `RAPS|EDPS|DIR|CGDP|PDE`',
    `submitter_name` STRING COMMENT 'The name of the organization or entity submitting the Part D data to CMS. May be the health plan, TPA, or PBM acting on behalf of the plan. Supports audit trail and accountability tracking.',
    `total_record_count` STRING COMMENT 'The total number of records (encounters, claims, or line items) included in the submission batch as transmitted to CMS. Used as the control total for reconciliation against CMS acknowledgment.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this Part D submission record was last modified in the lakehouse silver layer. Used to detect record changes, support incremental processing, and maintain audit trail integrity.',
    CONSTRAINT pk_part_d_submission PRIMARY KEY(`part_d_submission_id`)
) COMMENT 'Transactional record tracking CMS Part D regulatory data submissions including RAPS (Risk Adjustment Processing System) pharmacy encounter submissions, EDPS (Encounter Data Processing System) submissions, Direct and Indirect Remuneration (DIR) reporting, and Coverage Gap Discount Program (CGDP) invoicing. Captures submission batch ID, submission type, submission date, reporting period, record count, accepted count, rejected count, CMS response code, error detail, reconciliation status, and resubmission flag. Supports CMS Part D compliance, risk adjustment revenue integrity, and regulatory filing audit trail.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` (
    `benefit_accumulator_id` BIGINT COMMENT 'Primary key for benefit_accumulator',
    `group_id` BIGINT COMMENT 'Identifier for the employer group or sponsor associated with the members pharmacy benefit. Relevant for group-level accumulator reporting and ASO/TPA arrangements.',
    `health_plan_id` BIGINT COMMENT 'Identifier for the health benefit plan under which the member is enrolled, determining the applicable deductible, OOP maximum, and Part D benefit phase thresholds.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier for the health plan member whose pharmacy benefit accumulators are being tracked. Links to the member master record in the enrollment system (Facets/QNXT).',
    `pharmacy_claim2_id` BIGINT COMMENT 'Identifier of the most recent pharmacy claim that triggered an update to this accumulator record. Supports audit trail and real-time adjudication reconciliation.',
    `year_id` BIGINT COMMENT 'add column year_id (BIGINT) with FK to plan.year.year_id - accumulators reset per plan year',
    `accumulator_reset_date` DATE COMMENT 'Date on which the accumulator balances were last reset to zero, typically at the start of a new benefit year. Supports annual reconciliation and audit of accumulator lifecycle.',
    `accumulator_source_system` STRING COMMENT 'Identifies the operational system of record that originated or last updated this accumulator record (e.g., RxClaim, Argus PBM, Facets, QNXT). Supports data lineage, reconciliation, and audit trail requirements.. Valid values are `rxclaim|argus|facets|qnxt|manual|pbm_feed`',
    `accumulator_status` STRING COMMENT 'Current lifecycle state of the accumulator record. active indicates in-use for real-time adjudication; suspended indicates member eligibility gap; closed indicates benefit period ended; pending_reset indicates awaiting annual reset; reconciled indicates CMS or plan reconciliation completed.. Valid values are `active|suspended|closed|pending_reset|reconciled`',
    `accumulator_version` STRING COMMENT 'Optimistic locking version counter incremented with each update to the accumulator record. Supports concurrent adjudication event handling and prevents race conditions in real-time point-of-sale updates.',
    `benefit_period_end_date` DATE COMMENT 'Last date of the benefit year or coverage period to which this accumulator record applies. Defines the boundary for annual accumulator reset.',
    `benefit_period_start_date` DATE COMMENT 'First date of the benefit year or coverage period to which this accumulator record applies. Accumulators reset at the start of each new benefit period.',
    `catastrophic_applied_amt` DECIMAL(18,2) COMMENT 'Cumulative drug cost amounts applied toward the Medicare Part D catastrophic coverage threshold. Tracks member spend after exiting the coverage gap and entering catastrophic coverage.',
    `catastrophic_limit_amt` DECIMAL(18,2) COMMENT 'The Medicare Part D catastrophic coverage threshold amount for the current benefit year. Once TrOOP reaches this level, the member qualifies for catastrophic cost-sharing rates. Published annually by CMS.',
    `cms_reconciliation_status` STRING COMMENT 'Status of the CMS annual Part D reconciliation process for this accumulator record. Tracks whether the accumulator data has been submitted to and accepted by CMS via RAPS/EDPS for risk adjustment and subsidy reconciliation.. Valid values are `pending|submitted|accepted|rejected|reconciled`',
    `coordination_of_benefits_type` STRING COMMENT 'Indicates the coordination of benefits (COB) role of this plan for the members pharmacy benefit. Determines how accumulator amounts are applied when multiple payers are involved.. Valid values are `primary|secondary|tertiary|none`',
    `coverage_gap_discount_applied_amt` DECIMAL(18,2) COMMENT 'Cumulative manufacturer discount amounts applied to brand-name drugs while the member is in the Medicare Part D coverage gap (donut hole). These discounts count toward TrOOP under the ACA Coverage Gap Discount Program.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this accumulator record was first created in the Silver Layer lakehouse. Supports audit trail and data lineage requirements.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `deductible_applied_amt` DECIMAL(18,2) COMMENT 'Cumulative dollar amount the member has applied toward their pharmacy deductible in the current benefit period. Updated with each pharmacy claim adjudication event. Used at point of sale to determine member cost-sharing responsibility.',
    `deductible_limit_amt` DECIMAL(18,2) COMMENT 'Total pharmacy deductible amount the member must satisfy before plan cost-sharing begins, as defined in the benefit plan design for the current benefit period.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `eob_generated_flag` BOOLEAN COMMENT 'Indicates whether an Explanation of Benefits (EOB) has been generated for the member reflecting the current accumulator balances. Supports member communication and regulatory EOB delivery requirements.',
    `family_deductible_applied_amt` DECIMAL(18,2) COMMENT 'Cumulative dollar amount applied toward the family-level pharmacy deductible for plans with embedded or aggregate family deductible structures. Applicable for commercial group plans with family coverage tiers.',
    `family_oop_applied_amt` DECIMAL(18,2) COMMENT 'Cumulative out-of-pocket spend applied toward the family-level MOOP for plans with family OOP limits. Tracks combined member cost-sharing across all family members enrolled under the same plan.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: InsurancePlan.coverage.benefit)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `formulary_tier_applied` STRING COMMENT 'The formulary drug tier level most recently applied during adjudication for this members accumulator. Indicates the cost-sharing tier structure in effect, which affects deductible and OOP accumulation rates.. Valid values are `tier_1|tier_2|tier_3|tier_4|tier_5|specialty`',
    `hsa_eligible_applied_amt` DECIMAL(18,2) COMMENT 'Cumulative amount of pharmacy cost-sharing that qualifies as HSA-eligible expenses under IRS rules for members enrolled in a High Deductible Health Plan (HDHP). Supports member HSA contribution and tax reporting.',
    `icl_applied_amt` DECIMAL(18,2) COMMENT 'Cumulative total drug costs (plan paid plus member cost-sharing) applied toward the Medicare Part D Initial Coverage Limit (ICL). When this amount reaches the ICL threshold, the member enters the coverage gap (donut hole).',
    `icl_limit_amt` DECIMAL(18,2) COMMENT 'The Medicare Part D Initial Coverage Limit (ICL) threshold amount for the current benefit year, as published annually by CMS. Defines the boundary between the initial coverage phase and the coverage gap (donut hole).',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_deductible_met` BOOLEAN COMMENT 'Indicates whether the member has fully satisfied their pharmacy deductible for the current benefit period. When true, plan cost-sharing (copay/coinsurance) applies rather than full deductible responsibility.',
    `is_moop_met` BOOLEAN COMMENT 'Indicates whether the member has reached their maximum out-of-pocket (MOOP) limit for the current benefit period. When true, the plan covers 100% of covered pharmacy costs for the remainder of the benefit period.',
    `last_adjudication_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent pharmacy claim adjudication event that updated this accumulator record. Critical for real-time point-of-sale cost-sharing calculation and concurrency control.',
    `line_of_business` STRING COMMENT 'The line of business (LOB) under which the members pharmacy benefit is administered. Determines applicable regulatory framework, benefit phase rules, and accumulator logic (e.g., Part D coverage gap applies only to Medicare Part D).. Valid values are `commercial|medicare_part_d|medicaid|exchange|cobra|fehb`',
    `lis_copay_tier` STRING COMMENT 'The applicable LIS copay tier for the member, determining the fixed copay amounts for generic, preferred brand, non-preferred, and specialty drugs under the Low-Income Subsidy (LIS) program.. Valid values are `generic|preferred_brand|non_preferred|specialty|none`',
    `lis_level` STRING COMMENT 'Low-Income Subsidy (LIS) eligibility level for Medicare Part D members, determining reduced cost-sharing amounts. full indicates 100% subsidy; partial_1/2/3 indicate graduated subsidy tiers; none indicates no LIS. Affects TrOOP accumulation rules.. Valid values are `full|partial_1|partial_2|partial_3|none`',
    `mail_order_applied_amt` DECIMAL(18,2) COMMENT 'Cumulative cost-sharing amount applied for drugs dispensed through mail-order pharmacy channels in the current benefit period. Supports mail-order utilization reporting and member EOB generation.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `moop_limit_amt` DECIMAL(18,2) COMMENT 'The maximum out-of-pocket (MOOP) dollar threshold the member must reach before the plan covers 100% of covered pharmacy costs for the remainder of the benefit period. Set per plan design and ACA/CMS requirements.',
    `oop_applied_amt` DECIMAL(18,2) COMMENT 'Cumulative out-of-pocket (OOP) spend by the member for pharmacy benefits in the current benefit period, including deductible, copays, and coinsurance. Used to track progress toward the maximum out-of-pocket (MOOP) limit.',
    `part_d_benefit_phase` STRING COMMENT 'Current Medicare Part D benefit phase for the member based on accumulated TrOOP and ICL amounts. Drives cost-sharing calculation at point of sale. not_applicable for non-Part D lines of business.. Valid values are `deductible|initial_coverage|coverage_gap|catastrophic|not_applicable`',
    `pbm_member_code` STRING COMMENT 'Member identifier assigned by the Pharmacy Benefit Manager (PBM) system (RxClaim or Argus). Used to cross-reference accumulator balances between the health plan and PBM for reconciliation.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `rx_claim_count` STRING COMMENT 'Total number of pharmacy claims adjudicated and applied to this accumulator record in the current benefit period. Used for utilization reporting and EOB generation.',
    `specialty_drug_applied_amt` DECIMAL(18,2) COMMENT 'Cumulative cost-sharing amount applied specifically for specialty tier drugs in the current benefit period. Tracked separately to support specialty pharmacy reporting, prior authorization analytics, and plan design evaluation.',
    `third_party_applied_amt` DECIMAL(18,2) COMMENT 'Cumulative dollar amount paid by third parties (e.g., manufacturer copay assistance programs, other insurance) toward the members pharmacy cost-sharing. Tracked separately as these amounts may not count toward TrOOP under CMS rules.',
    `troop_applied_amt` DECIMAL(18,2) COMMENT 'Cumulative true out-of-pocket (TrOOP) expenditure for Medicare Part D members, counting only qualifying cost-sharing amounts toward the catastrophic coverage threshold. Excludes amounts paid by third parties not qualifying under CMS TrOOP rules. Required for CMS Part D benefit phase determination.',
    `troop_limit_amt` DECIMAL(18,2) COMMENT 'The annual TrOOP threshold amount that, when reached, transitions a Medicare Part D member into catastrophic coverage. Published annually by CMS as part of the Part D benefit parameters.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this accumulator record was most recently modified, reflecting the latest claim adjudication event or manual adjustment. Supports concurrency control and audit trail.',
    CONSTRAINT pk_benefit_accumulator PRIMARY KEY(`benefit_accumulator_id`)
) COMMENT 'Tracks member-level pharmacy benefit accumulator balances including deductible applied, out-of-pocket (OOP) spend, maximum out-of-pocket (MOOP) progress, true out-of-pocket (TrOOP) for Medicare Part D, initial coverage limit (ICL) progress, and catastrophic coverage threshold. Updated in real-time with each pharmacy claim adjudication event. Supports real-time cost-sharing calculation at point of sale, coverage gap (donut hole) determination for Part D members, low-income subsidy (LIS) cost-sharing adjustments, and member Explanation of Benefits (EOB) generation. Critical for CMS Part D benefit phase tracking and annual reconciliation.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` (
    `mac_list_id` BIGINT COMMENT 'Primary key for mac_list',
    `parent_mac_list_id` BIGINT COMMENT 'Self-referencing FK on mac_list (parent_mac_list_id)',
    `pbm_contract_id` BIGINT COMMENT 'add column pbm_contract_id (BIGINT) with FK to pharmacy.pbm_contract.pbm_contract_id - MAC lists belong to PBM contracts',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the manufacturer.',
    `brand_name` STRING COMMENT 'Brand name under which the drug is marketed.',
    `mac_list_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `dosage_form` STRING COMMENT 'Physical form of the drug (e.g., tablet, capsule).',
    `dosage_strength_unit` STRING COMMENT 'Unit of measurement for dosage strength.',
    `dosage_strength_value` DECIMAL(18,2) COMMENT 'Numeric strength of the dosage.',
    `drug_category` STRING COMMENT 'Category of the drug (e.g., pain management, cardiovascular).',
    `drug_class` STRING COMMENT 'Class of the drug (e.g., analgesic, antibiotic).',
    `drug_code` STRING COMMENT 'Standard code identifying the drug (e.g., RxNorm code).',
    `drug_code_description` STRING COMMENT 'Description of the drug code.',
    `drug_code_type` STRING COMMENT 'Type of drug code used (RxNorm, NDC, or other).',
    `drug_description` STRING COMMENT 'Detailed description of the drug.',
    `drug_form_code` STRING COMMENT 'Code representing the dosage form of the drug.',
    `drug_form_description` STRING COMMENT 'Description of the dosage form.',
    `drug_name` STRING COMMENT 'Human-readable name of the drug.',
    `drug_status` STRING COMMENT 'Current lifecycle status of the drug.',
    `drug_strength_code` STRING COMMENT 'Code representing the dosage strength.',
    `drug_strength_description` STRING COMMENT 'Description of the dosage strength.',
    `drug_therapeutic_class_code` STRING COMMENT 'Code representing the therapeutic class of the drug.',
    `drug_therapeutic_class_description` STRING COMMENT 'Description of the therapeutic class.',
    `drug_type` STRING COMMENT 'Type of drug (prescription, over-the-counter, specialty).',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `generic_name` STRING COMMENT 'Generic name of the drug.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `mac_created_at` TIMESTAMP COMMENT 'Timestamp when the MAC record was created in the system.',
    `mac_created_by` STRING COMMENT 'Identifier of the user who created the MAC record.',
    `mac_currency` STRING COMMENT 'Currency in which the MAC value is expressed.',
    `mac_effective_date` DATE COMMENT 'Date when the MAC value becomes effective.',
    `mac_expiration_date` DATE COMMENT 'Date when the MAC value expires.',
    `mac_list_status` STRING COMMENT '',
    `mac_list_type` STRING COMMENT '',
    `mac_methodology` STRING COMMENT '',
    `mac_price` DECIMAL(18,2) COMMENT '',
    `mac_source` STRING COMMENT 'Source of the MAC value (PBM, manufacturer, CMS).',
    `mac_source_date` DATE COMMENT 'Date when the MAC value was sourced.',
    `mac_unit_of_measure` STRING COMMENT '',
    `mac_unit_price` DECIMAL(18,2) COMMENT '',
    `mac_updated_at` TIMESTAMP COMMENT 'Timestamp when the MAC record was last updated.',
    `mac_updated_by` STRING COMMENT 'Identifier of the user who last updated the MAC record.',
    `mac_value` DECIMAL(18,2) COMMENT 'Maximum allowable cost for the drug as per PBM contract.',
    `mac_version` STRING COMMENT '',
    `manufacturer_name` STRING COMMENT 'Name of the drug manufacturer.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `multi_source_code` STRING COMMENT '',
    `mac_list_name` STRING COMMENT '',
    `ndc_code` STRING COMMENT 'Standard 10-digit NDC code identifying the drug.',
    `package_size` DECIMAL(18,2) COMMENT '',
    `package_size_unit` STRING COMMENT 'Unit of measurement for package size.',
    `package_size_value` DECIMAL(18,2) COMMENT 'Numeric value of the package size.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the record was first captured in the audit trail.',
    `record_audit_created_by` STRING COMMENT 'Identifier of the user who created the record in the audit trail.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp when the record was last updated in the audit trail.',
    `record_audit_updated_by` STRING COMMENT 'Identifier of the user who updated the record in the audit trail.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `source_system_code` STRING COMMENT '',
    `therapeutic_class` STRING COMMENT 'Therapeutic classification of the drug.',
    `therapeutic_equivalence_code` STRING COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `version` STRING COMMENT '',
    CONSTRAINT pk_mac_list PRIMARY KEY(`mac_list_id`)
) COMMENT 'Master reference table for mac_list. Referenced by mac_list_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` (
    `pharmacy_claim2_id` BIGINT COMMENT 'Unique surrogate identifier for each pharmacy claim record in the Silver layer lakehouse. Primary key for the pharmacy_claim data product. Role: TRANSACTION_HEADER.',
    `ap_payment_id` BIGINT COMMENT 'Foreign key linking to finance.ap_payment. Business justification: AP Payment Recording: payment of the AP invoice for a claim is tracked to close the reimbursement cycle.',
    `case_id` BIGINT COMMENT 'Foreign key linking to appeal.appeal_case. Business justification: Required for the Pharmacy Claim Appeal process where each claim can generate an appeal case; enables claim‑level appeal reporting and tracking.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Claim adjudication uses PBM contract rates, step‑therapy and rebate rules; linking claim to provider_contract enables accurate pricing and compliance reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost‑Center Allocation: claim expense is allocated to the appropriate cost center for budgeting and variance analysis.',
    `dispensing_pharmacy_id` BIGINT COMMENT 'Surrogate reference to the pharmacy that dispensed the drug. Links to the provider/pharmacy master record. Distinguishes retail, mail-order, and specialty pharmacy channels. Used for network adequacy reporting and pharmacy audit trail requirements.',
    `drug_master_id` BIGINT COMMENT 'Surrogate reference to the NDC-level drug master record in the pharmacy domain. Links to the formulary drug master product which carries NDC, drug name, tier, and pricing (AWP/WAC/MAC). Central to formulary compliance and drug utilization review (DUR).',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: Required for claim adjudication to determine members eligibility span at service date, supporting CMS reporting and accurate cost‑share calculations.',
    `header_id` BIGINT COMMENT 'Foreign key linking to claim.header. Business justification: Required for integrated care reporting: links pharmacy claims to the corresponding medical claim header for episode‑of‑care analysis and coordinated benefits calculations.',
    `health_plan_id` BIGINT COMMENT 'Surrogate reference to the health plan or benefit plan under which this pharmacy claim was adjudicated. Links to the plan and benefit product. Determines formulary, cost-sharing rules, and CMS Part D contract identification.',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Required for Claim Adjudication Posting process: each pharmacy claim expense must be posted to a GL ledger for financial reporting and regulatory audit.',
    `identity_id` BIGINT COMMENT 'Surrogate reference to the health plan member who is the beneficiary of this pharmacy claim. Links to the member master record in the Core Administration Platform (Facets/QNXT). Required for eligibility verification, coordination of benefits (COB), and CMS Part D risk adjustment (RAF/HCC).',
    `record_id` BIGINT COMMENT 'Foreign key linking to credential.credential_record. Business justification: Claim adjudication requires verifying prescriber credentials per CMS regulations; linking claim to credential_record enables automated credential status checks.',
    `prior_authorization_id` BIGINT COMMENT 'Surrogate reference to the prior authorization record that approved dispensing of this drug, if applicable. Null when no PA was required. Links to the utilization management PA product. Required for specialty drug claims and step therapy override tracking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for Claim Processing Audit Report to track which employee adjudicated each pharmacy claim.',
    `provider_id` BIGINT COMMENT 'Surrogate reference to the prescribing provider who authored the prescription. Links to the provider master record in the Provider Management System (Cactus/ProviderSource). Used for prescriber profiling, fraud/waste/abuse (FWA) detection, and HEDIS measure attribution.',
    `um_case_id` BIGINT COMMENT 'Foreign key linking to utilization.um_case. Business justification: Claims are associated with utilization‑management cases for case‑level cost analysis and outcome tracking, required by case management dashboards.',
    `adjudication_timestamp` TIMESTAMP COMMENT 'Date and time the pharmacy claim was adjudicated (approved or rejected) by the PBM system. Distinct from fill_date (dispensing event). Used for claims processing SLA measurement, 835 remittance matching, and audit trail compliance.',
    `basis_of_cost_determination` STRING COMMENT 'Code indicating the pricing benchmark used to determine the ingredient cost for this claim. AWP = Average Wholesale Price; WAC = Wholesale Acquisition Cost; MAC = Maximum Allowable Cost; usual_and_customary = pharmacys standard retail price; negotiated = contracted rate; 340B = 340B program pricing; other = alternative basis. [ENUM-REF-CANDIDATE: awp|wac|mac|usual_and_customary|negotiated|340b|other — 7 candidates stripped; promote to reference product]',
    `claim_number` STRING COMMENT 'Externally-known, human-readable claim reference number assigned by the Pharmacy Benefit Management (PBM) system (RxClaim or Argus) at adjudication. Used for member communications, Explanation of Benefits (EOB), and 835 remittance reconciliation. Maps to NCPDP D.0 transaction reference number.',
    `claim_status` STRING COMMENT 'Current adjudication lifecycle status of the pharmacy claim as determined by the PBM system. paid = claim adjudicated and payment issued; rejected = claim denied with reject code; reversed = previously paid claim reversed; adjusted = claim reprocessed with changed amounts; pending = awaiting adjudication; void = cancelled before processing.. Valid values are `paid|rejected|reversed|adjusted|pending|void`',
    `cob_indicator` BOOLEAN COMMENT 'Indicates whether coordination of benefits (COB) was applied on this claim (True = COB applied, another payer was involved). Triggers COB segment processing and other_payer_amount population. Used for COB reconciliation and CMS Part D TrOOP calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pharmacy claim record was first created in the Silver layer data product. Supports audit trail, data lineage, and HIPAA record retention requirements. RECORD_AUDIT_CREATED category.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `daw_code` STRING COMMENT 'NCPDP Dispense As Written (DAW) code indicating whether a brand drug was dispensed when a generic was available, and the reason. 0 = no product selection indicated; 1 = substitution not allowed by prescriber; 2 = substitution allowed, patient requested brand; 3 = substitution allowed, pharmacist selected brand; 4 = substitution allowed, generic not in stock; 5 = substitution allowed, brand dispensed as generic. Used for generic substitution rate analytics and formulary compliance.. Valid values are `0|1|2|3|4|5`',
    `days_supply` STRING COMMENT 'Number of days of medication supply dispensed on this claim as reported by the dispensing pharmacy. Used for refill-too-soon edits, medication adherence (MPR/PDC) calculations, HEDIS pharmacy measures, and CMS Part D days supply validation.',
    `deductible_applied` DECIMAL(18,2) COMMENT 'Dollar amount of this pharmacy claim applied toward the members pharmacy or combined medical/pharmacy deductible. Relevant for HDHP/HSA plans and CMS Part D deductible phase tracking. Contributes to OOP/MOOP accumulation.',
    `dispensing_fee` DECIMAL(18,2) COMMENT 'Fee charged by the dispensing pharmacy for the act of dispensing the prescription, separate from ingredient cost. Negotiated as part of the PBM network contract. Used for PBM contract reconciliation and total claim cost analysis.',
    `dispensing_pharmacy_npi` STRING COMMENT '10-digit National Provider Identifier (NPI) of the dispensing pharmacy as submitted on the pharmacy claim. Denormalized for claim-level auditability and NCPDP D.0 compliance. Used for pharmacy network validation, audit trail, and CMS Part D encounter data.. Valid values are `^[0-9]{10}$`',
    `dur_outcome_code` STRING COMMENT 'NCPDP standard code indicating the outcome of the prospective drug utilization review (DUR) edit performed during adjudication (e.g., drug-drug interaction, duplicate therapy, dose check). Null if no DUR alert was triggered. Critical for pharmacy safety and regulatory compliance. [ENUM-REF-CANDIDATE: promote to reference product — NCPDP DUR outcome codes exceed 6 values]',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Claim)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `fill_date` DATE COMMENT 'The date the prescription was dispensed by the pharmacy to the member. This is the principal real-world business event date (BUSINESS_EVENT_TIMESTAMP category). Used for days supply calculations, refill-too-soon edits, and CMS Part D encounter data date of service reporting.',
    `formulary_tier` STRING COMMENT 'Formulary tier assigned to the dispensed drug at the time of adjudication. Determines member cost-sharing (copay/coinsurance) and plan benefit design. Tier 1 = preferred generic; Tier 2 = generic; Tier 3 = preferred brand; Tier 4 = non-preferred brand; Tier 5 = specialty; non_formulary = not on formulary.. Valid values are `tier_1|tier_2|tier_3|tier_4|tier_5|non_formulary`',
    `ingredient_cost` DECIMAL(18,2) COMMENT 'The cost of the drug ingredient(s) as billed by the dispensing pharmacy, before dispensing fee and other adjustments. Basis may be AWP, WAC, MAC, or negotiated rate. Core component of the MONETARY_TRIPLET for pharmacy claim financials. Used for PBM contract reconciliation and MLR calculation.',
    `is_340b_claim` BOOLEAN COMMENT 'Indicates whether this pharmacy claim was dispensed under the 340B Drug Pricing Program (True = 340B claim). Used for 340B duplicate discount prevention, HRSA compliance reporting, and separation of 340B and non-340B claims in financial reconciliation.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_compound_claim` BOOLEAN COMMENT 'Indicates whether this claim is for a compounded drug product containing multiple ingredients (True = compound claim). Compound claims require line-level detail in the pharmacy_claim_line product. Used for compound drug utilization review and cost management.',
    `line_of_business` STRING COMMENT 'Line of business under which this pharmacy claim was adjudicated. Drives regulatory reporting requirements, formulary rules, and cost-sharing structures. commercial = employer-sponsored or individual; medicare_part_d = CMS Medicare Part D; medicaid = state Medicaid; exchange = ACA marketplace QHP; cobra = COBRA continuation coverage.. Valid values are `commercial|medicare_part_d|medicaid|exchange|cobra`',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `member_coinsurance` DECIMAL(18,2) COMMENT 'Percentage-based cost-sharing amount paid by the member for this pharmacy claim, calculated as a percentage of the allowed cost. Applies when the benefit design uses coinsurance rather than fixed copay. Contributes to OOP/MOOP accumulation.',
    `member_copay` DECIMAL(18,2) COMMENT 'Fixed dollar amount paid by the member at point of sale as their cost-sharing obligation for this pharmacy claim. Determined by formulary tier and benefit design. Contributes to member out-of-pocket (OOP) and maximum out-of-pocket (MOOP) accumulation.',
    `ndc` STRING COMMENT '11-digit National Drug Code identifying the specific drug product dispensed, including labeler, product, and package segment. Denormalized from the drug master for claim-level auditability and CMS Part D encounter data submission (EDPS). Required for 340B duplicate discount prevention and drug utilization review (DUR).. Valid values are `^[0-9]{11}$`',
    `original_claim_number` STRING COMMENT 'Claim number of the original pharmacy claim that this record adjusts or reverses. Populated only for adjusted or reversed claims; null for original claims. Enables claim adjustment chain tracing for financial reconciliation, audit, and CMS Part D encounter data correction submissions.',
    `other_payer_amount` DECIMAL(18,2) COMMENT 'Amount paid by another payer (secondary insurer, Medicare, Medicaid, manufacturer coupon) under coordination of benefits (COB). Used for COB reconciliation, 340B duplicate discount prevention, and CMS Part D TrOOP (True Out-of-Pocket) calculations.',
    `pharmacy_channel` STRING COMMENT 'Channel through which the drug was dispensed. Drives cost-sharing differentials, formulary tier rules, and network adequacy reporting. retail = community pharmacy; mail_order = 90-day mail service; specialty = specialty pharmacy for high-cost/complex drugs; long_term_care = SNF/LTC pharmacy; home_infusion = infusion therapy at home.. Valid values are `retail|mail_order|specialty|long_term_care|home_infusion`',
    `plan_paid_amount` DECIMAL(18,2) COMMENT 'Total amount paid by the health plan for this pharmacy claim after applying member cost-sharing (copay, coinsurance, deductible) and COB adjustments. Net total component of the MONETARY_TRIPLET. Used for 835 remittance, MLR reporting, and CMS Part D encounter data.',
    `prescriber_npi` STRING COMMENT '10-digit National Provider Identifier (NPI) of the prescribing provider as submitted on the pharmacy claim. Denormalized for claim-level auditability, NCPDP D.0 compliance, and CMS Part D encounter data submission. Used for prescriber fraud/waste/abuse (FWA) analytics.. Valid values are `^[0-9]{10}$`',
    `prescription_written_date` DATE COMMENT 'Date the prescription was written by the prescriber. Used to validate prescription age, enforce days-supply-from-written-date rules, and support medication adherence analytics. Distinct from fill_date (dispensing date).',
    `quantity_dispensed` DECIMAL(18,2) COMMENT 'Actual quantity of the drug dispensed (e.g., number of tablets, milliliters, grams) as reported by the dispensing pharmacy. Used for quantity limit (QL) edits, drug utilization review (DUR), and CMS Part D encounter data submission.',
    `quantity_unit_of_measure` STRING COMMENT 'NCPDP standard unit of measure code for the quantity dispensed. EA = each (tablets/capsules); ML = milliliters; GM = grams; UN = units; F2 = international units; ME = milliequivalents. Required for accurate quantity limit (QL) edit enforcement and CMS Part D encounter data.. Valid values are `EA|ML|GM|UN|F2|ME`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `refill_number` STRING COMMENT 'Refill sequence number for this dispensing event. Zero (0) indicates the original fill; subsequent values indicate refill number. Used for refill-too-soon edits, medication adherence tracking, and prescription lifecycle management.',
    `reject_code` STRING COMMENT 'NCPDP standard reject code returned by the PBM system when a claim is rejected or denied. Null for paid claims. Used for pharmacy operations, member appeals, and drug utilization review (DUR) outcome tracking. [ENUM-REF-CANDIDATE: promote to reference product — NCPDP reject codes exceed 6 values]',
    `sales_tax` DECIMAL(18,2) COMMENT 'Sales tax amount applied to the pharmacy claim where applicable by state law. Included in total claim cost and reported separately for financial reconciliation and statutory accounting (SAP) purposes.',
    `step_therapy_override` BOOLEAN COMMENT 'Indicates whether a step therapy protocol was overridden for this claim (True = override applied). Step therapy requires trying lower-cost drugs before approving higher-cost alternatives. Override requires prior authorization. Used for utilization management (UM) reporting and CMS step therapy compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this pharmacy claim record was last modified in the Silver layer, such as after a claim adjustment, reversal, or COB update. Supports change data capture (CDC) and audit trail requirements. RECORD_AUDIT_UPDATED category.',
    CONSTRAINT pk_pharmacy_claim2 PRIMARY KEY(`pharmacy_claim2_id`)
) COMMENT 'Core transactional record for each pharmacy claim submitted and adjudicated through the PBM system (RxClaim or Argus). Header captures: claim number, member ID, prescriber NPI, dispensing pharmacy NPI, NDC, days supply, quantity dispensed, fill date, adjudication date, claim status, reject codes, ingredient cost, dispensing fee, copay, coinsurance, deductible applied, plan paid amount, and coordination of benefits (COB) details. Line-level detail supports multi-ingredient compound claims and COB line splits: line sequence, per-ingredient NDC, ingredient cost, dispensing fee, sales tax, incentive amount, other payer amount, patient pay amount, and basis of cost determination. Supports NCPDP D.0 transaction standards, 835 remittance, CMS Part D encounter data submissions (EDPS/RAPS), 340B claim identification for duplicate discount prevention, and pharmacy audit trail requirements. This is the SSOT for all pharmacy claim header and line-level transactional data within the pharmacy domain.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` (
    `pharmacy_contract_id` BIGINT COMMENT 'Unique surrogate identifier for the pharmacy contract record in the lakehouse silver layer. Primary key for this entity.',
    `dispensing_pharmacy_id` BIGINT COMMENT 'Reference to the dispensing pharmacy or pharmacy chain entity in the pharmacy master. Links this contract to the specific pharmacy party.',
    `mac_list_id` BIGINT COMMENT 'Identifier of the MAC pricing list applied under this contract for generic and multi-source drug reimbursement. References the specific MAC schedule version used by the PBM or health plan. Applicable when ingredient_cost_basis is mac.',
    `provider_id` BIGINT COMMENT '7-digit NCPDP pharmacy identifier used in pharmacy claim transactions (NCPDP Telecom D.0) and PBM adjudication. Complements the NPI for pharmacy-specific identification.',
    `pbm_contract_id` BIGINT COMMENT 'Reference to the PBM contract under which this pharmacy dispensing agreement is administered, when the contract is PBM-administered rather than direct. Null for direct health-plan contracts.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Contracts are negotiated per network; linking contracts to provider_network enables contract‑level reporting, tiering, and compliance tracking.',
    `accreditation_type` STRING COMMENT 'Type of accreditation required or held by the pharmacy under this contract. URAC and ACHC are common for specialty pharmacies. PCAB (Pharmacy Compounding Accreditation Board) for compounding pharmacies. Relevant for specialty and mail-order contracts.. Valid values are `urac|achc|jcaho|pcab|none`',
    `audit_frequency` STRING COMMENT 'Contractually stipulated frequency at which the health plan or PBM may conduct pharmacy audits. Applicable when audit_rights_indicator is true.. Valid values are `annual|biannual|quarterly|as_needed`',
    `audit_rights_indicator` BOOLEAN COMMENT 'Indicates whether the health plan or PBM retains the right to conduct on-site or desk audits of the pharmacys dispensing records under this contract. Required for CMS Part D compliance.',
    `auto_renewal_indicator` BOOLEAN COMMENT 'Indicates whether this contract automatically renews at the end of the contract term unless either party provides notice of termination within the required notice period.',
    `awp_discount_pct` DECIMAL(18,2) COMMENT 'Contracted discount percentage applied to the drugs Average Wholesale Price (AWP) to determine ingredient cost reimbursement for brand and generic drugs. Expressed as a positive percentage (e.g., 16.50 = AWP minus 16.50%). Applicable when ingredient_cost_basis is awp_discount.',
    `contract_number` STRING COMMENT 'Externally-known, human-readable contract reference number assigned by the health plan or PBM. Used in correspondence, audits, and regulatory filings. Serves as the BUSINESS_IDENTIFIER for this agreement.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the pharmacy contract. Active contracts are eligible for claim adjudication. Suspended contracts are temporarily ineligible. Terminated/expired contracts are closed. Drives network eligibility checks in RxClaim/Argus.. Valid values are `active|pending|suspended|terminated|expired`',
    `contract_type` STRING COMMENT 'Classification of the contractual relationship: direct (health plan contracts directly with pharmacy), pbm_administered (PBM manages on plans behalf), chain (multi-location chain agreement), independent (single-location independent pharmacy), mail_order, or specialty. [ENUM-REF-CANDIDATE: direct|pbm_administered|chain|independent|mail_order|specialty — promote to reference product]. Valid values are `direct|pbm_administered|chain|independent|mail_order|specialty`',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `credentialing_required_indicator` BOOLEAN COMMENT 'Indicates whether the pharmacy must complete and maintain credentialing requirements (state licensure, DEA registration, accreditation) as a condition of this contract.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `days_supply_mail_max` STRING COMMENT 'Maximum days supply per mail-order prescription fill authorized under this contract (typically 90 days). Drives adjudication edits in RxClaim/Argus.',
    `days_supply_retail_max` STRING COMMENT 'Maximum days supply per retail prescription fill authorized under this contract (typically 30 or 34 days). Claims exceeding this limit may be rejected during adjudication.',
    `dispensing_channel` STRING COMMENT 'The dispensing channel(s) authorized under this contract. Retail covers walk-in pharmacies; mail_order covers 90-day supply dispensing; specialty covers high-cost/complex drugs; long_term_care covers SNF/LTC facilities; home_infusion covers IV therapy.. Valid values are `retail|mail_order|specialty|long_term_care|home_infusion`',
    `dispensing_fee_mail_order` DECIMAL(18,2) COMMENT 'Contracted flat dispensing fee (in USD) paid per mail-order prescription dispensed. Typically lower than retail due to higher volume and automation. Applicable for mail-order and specialty pharmacy contracts.',
    `dispensing_fee_retail` DECIMAL(18,2) COMMENT 'Contracted flat dispensing fee (in USD) paid to the pharmacy per retail prescription dispensed, in addition to ingredient cost reimbursement. A core financial term of the pharmacy contract.',
    `dispensing_fee_specialty` DECIMAL(18,2) COMMENT 'Contracted flat dispensing fee (in USD) paid per specialty drug prescription dispensed. Specialty drugs require enhanced clinical services, justifying a separate fee schedule.',
    `effective_date` DATE COMMENT 'Date on which the pharmacy contract becomes binding and the pharmacy is eligible to dispense claims under this agreement. Used for network eligibility validation during adjudication.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `executed_date` DATE COMMENT 'Date on which the pharmacy contract was fully executed (signed by all parties). May precede the effective_date if there is a future start date.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_reference` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version_code` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `generic_awp_discount_pct` DECIMAL(18,2) COMMENT 'Contracted AWP discount percentage specifically for generic drugs, which typically carries a deeper discount than brand drugs. Expressed as a positive percentage. Applicable when ingredient_cost_basis is awp_discount and a separate generic rate is negotiated.',
    `generic_dispensing_rate_target` DECIMAL(18,2) COMMENT 'Contracted minimum generic dispensing rate (GDR) the pharmacy must achieve as a performance requirement. Expressed as a percentage (e.g., 85.00 = 85%). Supports CMS Part D Star Ratings and cost management objectives.',
    `ingredient_cost_basis` STRING COMMENT 'The pricing methodology used to calculate ingredient cost reimbursement to the pharmacy. AWP (Average Wholesale Price) discount, MAC (Maximum Allowable Cost), WAC (Wholesale Acquisition Cost) discount, NADAC (National Average Drug Acquisition Cost), or Usual and Customary (U&C). Core reimbursement term in the contract.. Valid values are `awp_discount|mac|wac_discount|nadac|usual_and_customary`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_amended_date` DATE COMMENT 'Date of the most recent amendment or addendum to this pharmacy contract. Used to track contract evolution and ensure the current fee schedule and terms are applied during adjudication.',
    `line_of_business` STRING COMMENT 'The line of business to which this pharmacy contract applies. Determines applicable regulatory requirements (e.g., CMS Part D rules for Medicare, state Medicaid rules). A contract may be scoped to one or multiple LOBs.. Valid values are `commercial|medicare_part_d|medicaid|exchange|fehb`',
    `mail_order_indicator` BOOLEAN COMMENT 'Indicates whether this pharmacy is authorized to dispense mail-order (90-day supply) prescriptions under this contract.',
    `master_entity_reference` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `network_tier` STRING COMMENT 'Network participation tier assigned to the pharmacy under this contract. Preferred pharmacies typically offer lower member cost-sharing. Drives member cost-sharing calculations and formulary benefit design.. Valid values are `preferred|standard|specialty|out_of_network`',
    `part_d_indicator` BOOLEAN COMMENT 'Indicates whether this pharmacy contract is applicable to Medicare Part D prescription drug benefit administration. When true, CMS Part D network adequacy, pricing, and reporting requirements apply.',
    `performance_guarantee_indicator` BOOLEAN COMMENT 'Indicates whether this contract includes performance guarantees (e.g., generic dispensing rate, medication adherence, fill accuracy). When true, performance_guarantee_details apply.',
    `pharmacy_npi` STRING COMMENT '10-digit National Provider Identifier assigned to the dispensing pharmacy by CMS. Used for claims adjudication, EDI transactions (NCPDP 5.1/D.0), and network directory publication.. Valid values are `^[0-9]{10}$`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pharmacy contract record was first created in the lakehouse silver layer. Supports data lineage, audit trails, and SLA monitoring.',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this pharmacy contract record was most recently updated in the lakehouse silver layer. Used for change detection, incremental processing, and audit compliance.',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `recoupment_provision_indicator` BOOLEAN COMMENT 'Indicates whether the contract includes provisions allowing the health plan or PBM to recoup overpayments identified through audits or claims reviews.',
    `source_system_contract_code` STRING COMMENT 'Native contract identifier from the originating PBM system (RxClaim or Argus) or provider management system (Cactus/ProviderSource). Used for lineage tracing and reconciliation between the lakehouse and operational systems.',
    `specialty_drug_indicator` BOOLEAN COMMENT 'Indicates whether this pharmacy is contracted and credentialed to dispense specialty drugs under this agreement. Specialty pharmacies must meet enhanced accreditation requirements (URAC, ACHC).',
    `state_code` STRING COMMENT 'Two-letter US state code identifying the primary state jurisdiction governing this pharmacy contract. Determines applicable state DOI regulations, MAC transparency laws, and pharmacy contracting statutes.. Valid values are `^[A-Z]{2}$`',
    `termination_date` DATE COMMENT 'Date on which the pharmacy contract ends or was terminated. Null for open-ended contracts. Claims with service dates after this date are not eligible for reimbursement under this contract.',
    `termination_notice_days` STRING COMMENT 'Number of calendar days advance written notice required by either party to terminate the contract without cause. Regulatory minimums vary by state DOI requirements.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `version` STRING COMMENT 'Version identifier of the pharmacy contract document (e.g., v1.0, v2.1, Amendment 3). Tracks contract amendments and renegotiations over time for audit and compliance purposes.',
    `wac_discount_pct` DECIMAL(18,2) COMMENT 'Contracted discount percentage applied to the drugs Wholesale Acquisition Cost (WAC) for ingredient cost reimbursement. Applicable when ingredient_cost_basis is wac_discount.',
    CONSTRAINT pk_pharmacy_contract PRIMARY KEY(`pharmacy_contract_id`)
) COMMENT 'Contractual record governing the reimbursement terms between the health plan (or PBM on its behalf) and individual dispensing pharmacies or pharmacy chains. Captures pharmacy NPI, network tier (preferred/standard/specialty), dispensing fee schedule, ingredient cost basis (AWP discount/MAC/WAC), effective date range, contract type (direct/PBM-administered), performance requirements, and audit provisions. Distinct from pbm_contract which governs the PBM relationship.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim` (
    `pharmacy_claim_id` BIGINT COMMENT 'Primary key for pharmacy claim',
    `days_supply` STRING COMMENT 'Number of days supply dispensed',
    `dispense_as_written_code` STRING COMMENT 'DAW code indicating substitution instructions',
    `fhir_medication_dispense_resource_identifier` STRING COMMENT 'FHIR resource identifier for interoperability',
    `prescriber_npi` STRING COMMENT 'National Provider Identifier of the prescriber',
    `quantity_dispensed` DECIMAL(18,2) COMMENT 'Quantity of medication dispensed',
    `rx_number` STRING COMMENT 'Prescription number assigned by the pharmacy',
    `fhir_medication_dispense_resource_id` STRING COMMENT '',
    CONSTRAINT pk_pharmacy_claim PRIMARY KEY(`pharmacy_claim_id`)
) COMMENT 'Pharmacy claim transaction record';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_prior_version_formulary_id` FOREIGN KEY (`prior_version_formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ADD CONSTRAINT `fk_pharmacy_formulary_drug_tier_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ADD CONSTRAINT `fk_pharmacy_formulary_drug_tier_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ADD CONSTRAINT `fk_pharmacy_drug_pricing_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ADD CONSTRAINT `fk_pharmacy_drug_pricing_mac_list_id` FOREIGN KEY (`mac_list_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`mac_list`(`mac_list_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ADD CONSTRAINT `fk_pharmacy_drug_pricing_pbm_contract_id` FOREIGN KEY (`pbm_contract_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract`(`pbm_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ADD CONSTRAINT `fk_pharmacy_claim_line_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ADD CONSTRAINT `fk_pharmacy_claim_line_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ADD CONSTRAINT `fk_pharmacy_claim_line_pharmacy_claim2_id` FOREIGN KEY (`pharmacy_claim2_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2`(`pharmacy_claim2_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ADD CONSTRAINT `fk_pharmacy_claim_line_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ADD CONSTRAINT `fk_pharmacy_prior_authorization_original_pa_prior_authorization_id` FOREIGN KEY (`original_pa_prior_authorization_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ADD CONSTRAINT `fk_pharmacy_dur_alert_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ADD CONSTRAINT `fk_pharmacy_dur_alert_pharmacy_claim_id` FOREIGN KEY (`pharmacy_claim_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim`(`pharmacy_claim_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ADD CONSTRAINT `fk_pharmacy_dispensing_pharmacy_mac_list_id` FOREIGN KEY (`mac_list_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`mac_list`(`mac_list_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ADD CONSTRAINT `fk_pharmacy_pbm_contract_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ADD CONSTRAINT `fk_pharmacy_drug_rebate_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ADD CONSTRAINT `fk_pharmacy_drug_rebate_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ADD CONSTRAINT `fk_pharmacy_drug_rebate_pbm_contract_id` FOREIGN KEY (`pbm_contract_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract`(`pbm_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ADD CONSTRAINT `fk_pharmacy_specialty_drug_program_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ADD CONSTRAINT `fk_pharmacy_specialty_drug_program_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ADD CONSTRAINT `fk_pharmacy_specialty_drug_program_pbm_contract_id` FOREIGN KEY (`pbm_contract_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract`(`pbm_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ADD CONSTRAINT `fk_pharmacy_mtm_service_pharmacy_claim_id` FOREIGN KEY (`pharmacy_claim_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim`(`pharmacy_claim_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ADD CONSTRAINT `fk_pharmacy_formulary_exception_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ADD CONSTRAINT `fk_pharmacy_benefit_accumulator_pharmacy_claim2_id` FOREIGN KEY (`pharmacy_claim2_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2`(`pharmacy_claim2_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ADD CONSTRAINT `fk_pharmacy_mac_list_parent_mac_list_id` FOREIGN KEY (`parent_mac_list_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`mac_list`(`mac_list_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ADD CONSTRAINT `fk_pharmacy_mac_list_pbm_contract_id` FOREIGN KEY (`pbm_contract_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract`(`pbm_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim2_dispensing_pharmacy_id` FOREIGN KEY (`dispensing_pharmacy_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy`(`dispensing_pharmacy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim2_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ADD CONSTRAINT `fk_pharmacy_pharmacy_claim2_prior_authorization_id` FOREIGN KEY (`prior_authorization_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization`(`prior_authorization_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ADD CONSTRAINT `fk_pharmacy_pharmacy_contract_dispensing_pharmacy_id` FOREIGN KEY (`dispensing_pharmacy_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy`(`dispensing_pharmacy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ADD CONSTRAINT `fk_pharmacy_pharmacy_contract_mac_list_id` FOREIGN KEY (`mac_list_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`mac_list`(`mac_list_id`);
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ADD CONSTRAINT `fk_pharmacy_pharmacy_contract_pbm_contract_id` FOREIGN KEY (`pbm_contract_id`) REFERENCES `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract`(`pbm_contract_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`pharmacy` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_health_insurance_v1`.`pharmacy` SET TAGS ('pii_domain' = 'pharmacy');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` SET TAGS ('pii_subdomain' = 'drug_management');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` SET TAGS ('pii_fhir_resource' = 'Medication');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `drug_master_id` SET TAGS ('pii_business_glossary_term' = 'Drug Master ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `drug_master_id` SET TAGS ('pii_vibe_coding_demo' = 'scoped');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `atc_code` SET TAGS ('pii_business_glossary_term' = 'Anatomical Therapeutic Chemical (ATC) Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `atc_code` SET TAGS ('pii_value_regex' = '^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `atc_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `awp_effective_date` SET TAGS ('pii_business_glossary_term' = 'Average Wholesale Price (AWP) Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `awp_unit_price` SET TAGS ('pii_business_glossary_term' = 'Average Wholesale Price (AWP) Unit Price');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `awp_unit_price` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `brand_name` SET TAGS ('pii_business_glossary_term' = 'Brand Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('pii_business_glossary_term' = 'Controlled Substance Schedule (DEA)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('pii_value_regex' = 'I|II|III|IV|V|not_scheduled');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `dea_number_required` SET TAGS ('pii_business_glossary_term' = 'DEA Number Required Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `dosage_form` SET TAGS ('pii_business_glossary_term' = 'Dosage Form');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `drug_class_code` SET TAGS ('pii_business_glossary_term' = 'Drug Class Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `drug_class_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `drug_class_name` SET TAGS ('pii_business_glossary_term' = 'Drug Class Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `drug_name` SET TAGS ('pii_business_glossary_term' = 'Drug Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `drug_status` SET TAGS ('pii_business_glossary_term' = 'Drug Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `drug_status` SET TAGS ('pii_value_regex' = 'active|inactive|discontinued|recalled|pending');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `drug_type` SET TAGS ('pii_business_glossary_term' = 'Drug Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `drug_type` SET TAGS ('pii_value_regex' = 'brand|generic|biosimilar|otc|compound|repackaged');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `fda_approval_status` SET TAGS ('pii_business_glossary_term' = 'FDA Approval Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `fda_approval_status` SET TAGS ('pii_value_regex' = 'approved|tentatively_approved|pending|withdrawn|not_approved');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `generic_name` SET TAGS ('pii_business_glossary_term' = 'Generic Name (INN)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `gpi_code` SET TAGS ('pii_business_glossary_term' = 'Generic Product Identifier (GPI) Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `gpi_code` SET TAGS ('pii_value_regex' = '^[0-9]{14}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `gpi_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `hcc_relevant` SET TAGS ('pii_business_glossary_term' = 'Hierarchical Condition Category (HCC) Relevant Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `is_biosimilar` SET TAGS ('pii_business_glossary_term' = 'Biosimilar Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `is_generic_available` SET TAGS ('pii_business_glossary_term' = 'Generic Available Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `is_maintenance_drug` SET TAGS ('pii_business_glossary_term' = 'Maintenance Drug Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `is_preventive_drug` SET TAGS ('pii_business_glossary_term' = 'Preventive Drug Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `is_specialty_drug` SET TAGS ('pii_business_glossary_term' = 'Specialty Drug Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `labeler_code` SET TAGS ('pii_business_glossary_term' = 'NDC Labeler Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `labeler_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `labeler_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `multi_source_code` SET TAGS ('pii_business_glossary_term' = 'Multi-Source Code (MSC)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `multi_source_code` SET TAGS ('pii_value_regex' = 'O|M|N|Y');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `multi_source_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `ndc` SET TAGS ('pii_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `ndc` SET TAGS ('pii_value_regex' = '^[0-9]{11}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `ndc_11` SET TAGS ('pii_business_glossary_term' = 'National Drug Code (NDC) 11-Digit Formatted');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `ndc_11` SET TAGS ('pii_value_regex' = '^[0-9]{5}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `package_size` SET TAGS ('pii_business_glossary_term' = 'Package Size');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `package_size_unit` SET TAGS ('pii_business_glossary_term' = 'Package Size Unit of Measure');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `pharmacological_category` SET TAGS ('pii_business_glossary_term' = 'Pharmacological Category');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `reference_drug_ndc` SET TAGS ('pii_business_glossary_term' = 'Reference Listed Drug (RLD) NDC');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `reference_drug_ndc` SET TAGS ('pii_value_regex' = '^[0-9]{11}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `rems_program` SET TAGS ('pii_business_glossary_term' = 'Risk Evaluation and Mitigation Strategy (REMS) Program');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `route_of_administration` SET TAGS ('pii_business_glossary_term' = 'Route of Administration');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `source_record_code` SET TAGS ('pii_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `source_record_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `source_system_code` SET TAGS ('pii_value_regex' = 'FDB|MEDISPAN|RXCLAIM|ARGUS|INTERNAL');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `source_system_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `strength` SET TAGS ('pii_business_glossary_term' = 'Drug Strength');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `therapeutic_class_code` SET TAGS ('pii_business_glossary_term' = 'Therapeutic Class Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `therapeutic_class_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `therapeutic_class_name` SET TAGS ('pii_business_glossary_term' = 'Therapeutic Class Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `therapeutic_equivalence_code` SET TAGS ('pii_business_glossary_term' = 'Therapeutic Equivalence Code (TE Code)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `therapeutic_equivalence_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2}[0-9]*$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `therapeutic_equivalence_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `therapeutic_subclass_code` SET TAGS ('pii_business_glossary_term' = 'Therapeutic Subclass Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `therapeutic_subclass_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `therapeutic_subclass_name` SET TAGS ('pii_business_glossary_term' = 'Therapeutic Subclass Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `wac_unit_price` SET TAGS ('pii_business_glossary_term' = 'Wholesale Acquisition Cost (WAC) Unit Price');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_master` ALTER COLUMN `wac_unit_price` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` SET TAGS ('pii_subdomain' = 'formulary_benefits');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` SET TAGS ('pii_fhir_resource' = 'MedicationKnowledge');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_id` SET TAGS ('pii_business_glossary_term' = 'Formulary ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `prior_version_formulary_id` SET TAGS ('pii_business_glossary_term' = 'Prior Formulary Version ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_category` SET TAGS ('pii_business_glossary_term' = 'Formulary Category');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_category` SET TAGS ('pii_value_regex' = 'standard|enhanced|basic|premium|custom');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `change_notification_date` SET TAGS ('pii_business_glossary_term' = 'Formulary Change Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `cms_formulary_code` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Formulary Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `cms_formulary_code` SET TAGS ('pii_value_regex' = '^[0-9]{8}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `cms_formulary_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_code` SET TAGS ('pii_business_glossary_term' = 'Formulary Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_description` SET TAGS ('pii_business_glossary_term' = 'Formulary Description');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `drug_count` SET TAGS ('pii_business_glossary_term' = 'Formulary Drug Count');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `drug_utilization_review_ind` SET TAGS ('pii_business_glossary_term' = 'Drug Utilization Review (DUR) Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Formulary Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_status` SET TAGS ('pii_business_glossary_term' = 'Formulary Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|retired|suspended');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_type` SET TAGS ('pii_business_glossary_term' = 'Formulary Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_type` SET TAGS ('pii_value_regex' = 'open|closed|tiered|preferred|exclusive');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `generic_substitution_policy` SET TAGS ('pii_business_glossary_term' = 'Generic Substitution Policy');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `generic_substitution_policy` SET TAGS ('pii_value_regex' = 'mandatory|permissive|prohibited|daw_honored');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `is_aca_compliant` SET TAGS ('pii_business_glossary_term' = 'Affordable Care Act (ACA) Compliance Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `is_cms_part_d` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Part D Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Formulary Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `lob_code` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `lob_code` SET TAGS ('pii_value_regex' = 'commercial|medicare|medicaid|marketplace|fehb|tricare');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `lob_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `low_income_subsidy_ind` SET TAGS ('pii_business_glossary_term' = 'Low Income Subsidy (LIS) Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `mail_order_ind` SET TAGS ('pii_business_glossary_term' = 'Mail Order Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_name` SET TAGS ('pii_business_glossary_term' = 'Formulary Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `next_review_date` SET TAGS ('pii_business_glossary_term' = 'Formulary Next Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `pbm_formulary_code` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Benefit Manager (PBM) Formulary Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `pbm_formulary_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9_-]{1,50}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `pbm_formulary_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `plan_year` SET TAGS ('pii_business_glossary_term' = 'Plan Year');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `prior_auth_ind` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `pt_committee_approval_date` SET TAGS ('pii_business_glossary_term' = 'Pharmacy and Therapeutics (P&T) Committee Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `quantity_limit_ind` SET TAGS ('pii_business_glossary_term' = 'Quantity Limit Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `regulatory_approval_date` SET TAGS ('pii_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `regulatory_filing_date` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `regulatory_filing_status` SET TAGS ('pii_business_glossary_term' = 'Regulatory Filing Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `regulatory_filing_status` SET TAGS ('pii_value_regex' = 'not_filed|filed|approved|rejected|pending_review');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `source_system_code` SET TAGS ('pii_value_regex' = 'rxclaim|argus|facets|qnxt|manual|other');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `source_system_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `specialty_pharmacy_ind` SET TAGS ('pii_business_glossary_term' = 'Specialty Pharmacy Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `specialty_tier_ind` SET TAGS ('pii_business_glossary_term' = 'Specialty Tier Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `step_therapy_ind` SET TAGS ('pii_business_glossary_term' = 'Step Therapy Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Formulary Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `tier_count` SET TAGS ('pii_business_glossary_term' = 'Formulary Tier Count');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `url` SET TAGS ('pii_business_glossary_term' = 'Formulary URL');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `url` SET TAGS ('pii_value_regex' = '^https?://.+$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Formulary Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary` ALTER COLUMN `version` SET TAGS ('pii_value_regex' = '^[0-9]{1,4}.[0-9]{1,4}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` SET TAGS ('pii_subdomain' = 'formulary_benefits');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` SET TAGS ('pii_fhir_resource' = 'Medication');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `formulary_drug_tier_id` SET TAGS ('pii_business_glossary_term' = 'Formulary Drug Tier ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `drug_master_id` SET TAGS ('pii_business_glossary_term' = 'Drug ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `formulary_id` SET TAGS ('pii_business_glossary_term' = 'Formulary ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `benefit_year` SET TAGS ('pii_business_glossary_term' = 'Benefit Year');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `coinsurance_rate` SET TAGS ('pii_business_glossary_term' = 'Coinsurance Rate');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `coinsurance_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `copay_mail_order` SET TAGS ('pii_business_glossary_term' = 'Mail Order Copay Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `copay_mail_order` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `copay_retail_30` SET TAGS ('pii_business_glossary_term' = 'Retail 30-Day Copay Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `copay_retail_30` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `copay_retail_90` SET TAGS ('pii_business_glossary_term' = 'Retail 90-Day Copay Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `copay_retail_90` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `coverage_status` SET TAGS ('pii_business_glossary_term' = 'Drug Coverage Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `coverage_status` SET TAGS ('pii_value_regex' = 'covered|not_covered|covered_with_restrictions|excluded');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `deductible_applies` SET TAGS ('pii_business_glossary_term' = 'Deductible Applies Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `dispensing_channel` SET TAGS ('pii_business_glossary_term' = 'Dispensing Channel');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `dispensing_channel` SET TAGS ('pii_value_regex' = 'retail|mail_order|specialty|retail_and_mail|all');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `drug_tier_change_reason` SET TAGS ('pii_business_glossary_term' = 'Drug Tier Change Reason');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `dur_alert_type` SET TAGS ('pii_business_glossary_term' = 'Drug Utilization Review (DUR) Alert Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `formulary_status_code` SET TAGS ('pii_business_glossary_term' = 'CMS Formulary Status Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `formulary_status_code` SET TAGS ('pii_value_regex' = '1|2|3|4|5|6');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `formulary_status_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `lob_code` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `lob_code` SET TAGS ('pii_value_regex' = 'commercial|medicare_part_d|medicaid|exchange|fehb');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `lob_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `mac_pricing_applicable` SET TAGS ('pii_business_glossary_term' = 'Maximum Allowable Cost (MAC) Pricing Applicable Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `ndc_code` SET TAGS ('pii_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `ndc_code` SET TAGS ('pii_value_regex' = '^[0-9]{11}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `ndc_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `pa_criteria_description` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Criteria Description');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `pa_type` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `pa_type` SET TAGS ('pii_value_regex' = 'standard|expedited|retrospective|not_applicable');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `pbm_formulary_code` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Benefit Manager (PBM) Formulary Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `pbm_formulary_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `prior_auth_required` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `ql_clinical_basis` SET TAGS ('pii_business_glossary_term' = 'Quantity Limit (QL) Clinical Basis');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `ql_days_supply` SET TAGS ('pii_business_glossary_term' = 'Quantity Limit (QL) Days Supply');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `ql_dosage_form_restriction` SET TAGS ('pii_business_glossary_term' = 'Quantity Limit (QL) Dosage Form Restriction');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `ql_max_quantity` SET TAGS ('pii_business_glossary_term' = 'Quantity Limit (QL) Maximum Quantity');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `quantity_limit_required` SET TAGS ('pii_business_glossary_term' = 'Quantity Limit (QL) Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `record_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|superseded');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `specialty_drug_flag` SET TAGS ('pii_business_glossary_term' = 'Specialty Drug Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `st_clinical_rationale` SET TAGS ('pii_business_glossary_term' = 'Step Therapy (ST) Clinical Rationale');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `st_override_criteria` SET TAGS ('pii_business_glossary_term' = 'Step Therapy (ST) Override Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `st_required_step_ndc` SET TAGS ('pii_business_glossary_term' = 'Step Therapy (ST) Required Step Drug NDC');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `st_required_step_ndc` SET TAGS ('pii_value_regex' = '^[0-9]{11}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `st_step_number` SET TAGS ('pii_business_glossary_term' = 'Step Therapy (ST) Step Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `st_step_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `step_therapy_required` SET TAGS ('pii_business_glossary_term' = 'Step Therapy (ST) Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `tier_name` SET TAGS ('pii_business_glossary_term' = 'Drug Tier Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `tier_number` SET TAGS ('pii_business_glossary_term' = 'Drug Tier Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `tier_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `transition_fill_allowed` SET TAGS ('pii_business_glossary_term' = 'Transition Fill Allowed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_drug_tier` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` SET TAGS ('pii_subdomain' = 'drug_management');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` SET TAGS ('pii_fhir_resource' = 'Medication');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `drug_pricing_id` SET TAGS ('pii_business_glossary_term' = 'Drug Pricing ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `drug_master_id` SET TAGS ('pii_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `mac_list_id` SET TAGS ('pii_business_glossary_term' = 'Mac List Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `mac_list_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `awp_discount_pct` SET TAGS ('pii_business_glossary_term' = 'Average Wholesale Price (AWP) Discount Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `awp_discount_pct` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `awp_price` SET TAGS ('pii_business_glossary_term' = 'Average Wholesale Price (AWP)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `awp_price` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `days_supply` SET TAGS ('pii_business_glossary_term' = 'Days Supply');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `dea_schedule` SET TAGS ('pii_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `dea_schedule` SET TAGS ('pii_value_regex' = 'CI|CII|CIII|CIV|CV|NON-CONTROLLED');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `dispensing_channel` SET TAGS ('pii_business_glossary_term' = 'Dispensing Channel');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `dispensing_channel` SET TAGS ('pii_value_regex' = 'retail|mail_order|specialty|long_term_care');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `dispensing_fee` SET TAGS ('pii_business_glossary_term' = 'Dispensing Fee');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `dispensing_fee` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Pricing Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Pricing Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `formulary_tier` SET TAGS ('pii_business_glossary_term' = 'Formulary Tier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `formulary_tier` SET TAGS ('pii_value_regex' = 'tier_1|tier_2|tier_3|tier_4|tier_5|non_formulary');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `mac_list_version` SET TAGS ('pii_business_glossary_term' = 'Maximum Allowable Cost (MAC) List Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `mac_methodology` SET TAGS ('pii_business_glossary_term' = 'Maximum Allowable Cost (MAC) List Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `mac_methodology` SET TAGS ('pii_value_regex' = 'MARKET_BASKET|NADAC_BASED|AWP_DISCOUNT|WAC_DISCOUNT|CUSTOM');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `mac_price` SET TAGS ('pii_business_glossary_term' = 'Maximum Allowable Cost (MAC) Price');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `mac_price` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `multi_source_code` SET TAGS ('pii_business_glossary_term' = 'Multi-Source Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `multi_source_code` SET TAGS ('pii_value_regex' = 'O|M|N|Y');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `multi_source_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `package_size` SET TAGS ('pii_business_glossary_term' = 'Package Size');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `package_size_uom` SET TAGS ('pii_business_glossary_term' = 'Package Size Unit of Measure');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `price_change_pct` SET TAGS ('pii_business_glossary_term' = 'Price Change Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `price_change_pct` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `price_type` SET TAGS ('pii_business_glossary_term' = 'Price Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `price_type` SET TAGS ('pii_value_regex' = 'AWP|WAC|MAC|RBP|NADAC|USUAL_AND_CUSTOMARY');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `pricing_file_date` SET TAGS ('pii_business_glossary_term' = 'Pricing File Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `pricing_file_name` SET TAGS ('pii_business_glossary_term' = 'Pricing File Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `pricing_source` SET TAGS ('pii_business_glossary_term' = 'Pricing Source');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `pricing_status` SET TAGS ('pii_business_glossary_term' = 'Pricing Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `pricing_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|superseded');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `prior_unit_price` SET TAGS ('pii_business_glossary_term' = 'Prior Unit Price');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `prior_unit_price` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `rbp_price` SET TAGS ('pii_business_glossary_term' = 'Reference Based Pricing (RBP) Price');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `rbp_price` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `unit_price` SET TAGS ('pii_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `unit_price` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `wac_price` SET TAGS ('pii_business_glossary_term' = 'Wholesale Acquisition Cost (WAC)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_pricing` ALTER COLUMN `wac_price` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` SET TAGS ('pii_subdomain' = 'claim_processing');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` SET TAGS ('pii_fhir_resource' = 'Claim.item');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `claim_line_id` SET TAGS ('pii_business_glossary_term' = 'Claim Line Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Pbm Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `drug_master_id` SET TAGS ('pii_business_glossary_term' = 'Drug ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `formulary_id` SET TAGS ('pii_business_glossary_term' = 'Formulary ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('pii_business_glossary_term' = 'Journal Entry Line Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `pharmacy_claim2_id` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Claim ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `prior_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `adjudication_timestamp` SET TAGS ('pii_business_glossary_term' = 'Adjudication Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `basis_of_cost_determination` SET TAGS ('pii_business_glossary_term' = 'Basis of Cost Determination');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `catastrophic_coverage_indicator` SET TAGS ('pii_business_glossary_term' = 'Catastrophic Coverage Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `cob_sequence` SET TAGS ('pii_business_glossary_term' = 'Coordination of Benefits (COB) Sequence');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `compound_indicator` SET TAGS ('pii_business_glossary_term' = 'Compound Drug Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `coverage_gap_indicator` SET TAGS ('pii_business_glossary_term' = 'Coverage Gap Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `days_supply` SET TAGS ('pii_business_glossary_term' = 'Days Supply');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `dispense_as_written_code` SET TAGS ('pii_business_glossary_term' = 'Dispense As Written (DAW) Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `dispense_as_written_code` SET TAGS ('pii_value_regex' = '0|1|2|3|4|5');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `dispense_as_written_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `dispensed_date` SET TAGS ('pii_business_glossary_term' = 'Dispensed Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `dispensed_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `dispensed_date` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `dispensing_fee_amount` SET TAGS ('pii_business_glossary_term' = 'Dispensing Fee Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `dispensing_fee_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `drug_coverage_status` SET TAGS ('pii_business_glossary_term' = 'Drug Coverage Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `drug_coverage_status` SET TAGS ('pii_value_regex' = 'covered|non_covered|excluded|step_therapy_required|pa_required');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `dur_conflict_code` SET TAGS ('pii_business_glossary_term' = 'Drug Utilization Review (DUR) Conflict Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `dur_conflict_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `dur_outcome_code` SET TAGS ('pii_business_glossary_term' = 'Drug Utilization Review (DUR) Outcome Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `dur_outcome_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `fill_number` SET TAGS ('pii_business_glossary_term' = 'Fill Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `fill_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `formulary_tier` SET TAGS ('pii_business_glossary_term' = 'Formulary Tier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `formulary_tier` SET TAGS ('pii_value_regex' = 'tier_1|tier_2|tier_3|tier_4|tier_5|non_formulary');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `generic_indicator` SET TAGS ('pii_business_glossary_term' = 'Generic Drug Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `gross_drug_cost_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Drug Cost Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `gross_drug_cost_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `incentive_amount` SET TAGS ('pii_business_glossary_term' = 'Incentive Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `incentive_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `ingredient_cost_amount` SET TAGS ('pii_business_glossary_term' = 'Ingredient Cost Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `ingredient_cost_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `line_sequence_number` SET TAGS ('pii_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `line_sequence_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `line_status` SET TAGS ('pii_business_glossary_term' = 'Claim Line Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `line_status` SET TAGS ('pii_value_regex' = 'paid|denied|reversed|adjusted|pending|void');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `line_type` SET TAGS ('pii_business_glossary_term' = 'Claim Line Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `line_type` SET TAGS ('pii_value_regex' = 'standard|compound_ingredient|cob_split|reversal|adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `low_income_subsidy_indicator` SET TAGS ('pii_business_glossary_term' = 'Low Income Subsidy (LIS) Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `manufacturer_discount_amount` SET TAGS ('pii_business_glossary_term' = 'Manufacturer Discount Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `manufacturer_discount_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `ndc_code` SET TAGS ('pii_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `ndc_code` SET TAGS ('pii_value_regex' = '^[0-9]{11}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `ndc_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `ndc_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `ndc_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `other_payer_amount` SET TAGS ('pii_business_glossary_term' = 'Other Payer Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `other_payer_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `patient_pay_amount` SET TAGS ('pii_business_glossary_term' = 'Patient Pay Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `patient_pay_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `patient_pay_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `pde_submission_date` SET TAGS ('pii_business_glossary_term' = 'Prescription Drug Event (PDE) Submission Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `pharmacy_channel` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Channel');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `pharmacy_channel` SET TAGS ('pii_value_regex' = 'retail|mail_order|specialty|long_term_care|home_infusion');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `plan_paid_amount` SET TAGS ('pii_business_glossary_term' = 'Plan Paid Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `plan_paid_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `quantity_dispensed` SET TAGS ('pii_business_glossary_term' = 'Quantity Dispensed');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `quantity_limit_indicator` SET TAGS ('pii_business_glossary_term' = 'Quantity Limit Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `refill_number` SET TAGS ('pii_business_glossary_term' = 'Refill Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `refill_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `reversal_timestamp` SET TAGS ('pii_business_glossary_term' = 'Reversal Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `sales_tax_amount` SET TAGS ('pii_business_glossary_term' = 'Sales Tax Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `sales_tax_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `source_system_claim_line_key` SET TAGS ('pii_business_glossary_term' = 'Source System Claim Line Key');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `specialty_drug_indicator` SET TAGS ('pii_business_glossary_term' = 'Specialty Drug Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `step_therapy_indicator` SET TAGS ('pii_business_glossary_term' = 'Step Therapy Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `true_oop_amount` SET TAGS ('pii_business_glossary_term' = 'True Out-of-Pocket (TrOOP) Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `true_oop_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `true_oop_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`claim_line` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` SET TAGS ('pii_subdomain' = 'clinical_review');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` SET TAGS ('pii_fhir_resource' = 'CoverageEligibilityRequest');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `prior_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `case_id` SET TAGS ('pii_business_glossary_term' = 'Appeal Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Reviewing Clinician ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `formulary_id` SET TAGS ('pii_business_glossary_term' = 'Formulary ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `member_risk_score_id` SET TAGS ('pii_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `original_pa_prior_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Original Prior Authorization (PA) ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `pa_decision_id` SET TAGS ('pii_business_glossary_term' = 'Pa Decision Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `pa_request_id` SET TAGS ('pii_business_glossary_term' = 'Pa Request Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `appeal_indicator` SET TAGS ('pii_business_glossary_term' = 'Appeal Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `approved_days_supply` SET TAGS ('pii_business_glossary_term' = 'Approved Days Supply');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `approved_quantity` SET TAGS ('pii_business_glossary_term' = 'Approved Quantity');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `approved_refills` SET TAGS ('pii_business_glossary_term' = 'Approved Number of Refills');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `clinical_criteria_code` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `clinical_criteria_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `clinical_criteria_version` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `cms_part_d_reportable` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Part D Reportable Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `criteria_met` SET TAGS ('pii_business_glossary_term' = 'Clinical Criteria Met Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `decision_timestamp` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Decision Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Denial Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `denial_reason_description` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Denial Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `dispensing_channel` SET TAGS ('pii_business_glossary_term' = 'Dispensing Channel');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `dispensing_channel` SET TAGS ('pii_value_regex' = 'retail|mail_order|specialty|long_term_care|home_infusion');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `drug_ndc` SET TAGS ('pii_business_glossary_term' = 'Drug National Drug Code (NDC)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `drug_ndc` SET TAGS ('pii_value_regex' = '^[0-9]{11}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `drug_tier` SET TAGS ('pii_business_glossary_term' = 'Drug Formulary Tier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `drug_tier` SET TAGS ('pii_value_regex' = 'tier_1|tier_2|tier_3|tier_4|tier_5|specialty');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `dur_outcome_code` SET TAGS ('pii_business_glossary_term' = 'Drug Utilization Review (DUR) Outcome Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `dur_outcome_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `icd_diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'International Classification of Diseases (ICD) Primary Diagnosis Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `icd_diagnosis_code` SET TAGS ('pii_value_regex' = '^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `icd_diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `icd_diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `icd_diagnosis_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `lob` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `lob` SET TAGS ('pii_value_regex' = 'commercial|medicare_part_d|medicaid|marketplace|cobra|individual');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Clinical Notes');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `notes` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `notes` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `pa_reference_number` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `pa_reference_number` SET TAGS ('pii_value_regex' = '^PA-[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `pa_reference_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `pa_status` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `pa_status` SET TAGS ('pii_value_regex' = 'approved|denied|pending|cancelled|expired|appealed');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `pa_type` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `pa_type` SET TAGS ('pii_value_regex' = 'specialty|non_preferred|step_therapy|quantity_limit|age_restriction|off_label');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `prescriber_npi` SET TAGS ('pii_business_glossary_term' = 'Prescriber National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `prescriber_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `prescriber_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `quantity_limit_applied` SET TAGS ('pii_business_glossary_term' = 'Quantity Limit Applied Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `received_timestamp` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Received Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `request_date` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Request Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `request_type` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Request Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `request_type` SET TAGS ('pii_value_regex' = 'new|renewal|appeal|expedited|retrospective');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `review_level` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Review Level');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `review_level` SET TAGS ('pii_value_regex' = 'pharmacist|physician|peer_to_peer|medical_director');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `secondary_diagnosis_codes` SET TAGS ('pii_business_glossary_term' = 'Secondary International Classification of Diseases (ICD) Diagnosis Codes');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `secondary_diagnosis_codes` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `secondary_diagnosis_codes` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `source_system_pa_code` SET TAGS ('pii_business_glossary_term' = 'Source System Prior Authorization (PA) ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `source_system_pa_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `specialty_drug_flag` SET TAGS ('pii_business_glossary_term' = 'Specialty Drug Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `step_therapy_completed` SET TAGS ('pii_business_glossary_term' = 'Step Therapy Completed Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `step_therapy_required` SET TAGS ('pii_business_glossary_term' = 'Step Therapy Required Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`prior_authorization` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` SET TAGS ('pii_subdomain' = 'clinical_review');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `dur_alert_id` SET TAGS ('pii_business_glossary_term' = 'Drug Utilization Review (DUR) Alert ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Review Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `adjudication_outcome` SET TAGS ('pii_business_glossary_term' = 'DUR Alert Adjudication Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `adjudication_outcome` SET TAGS ('pii_value_regex' = 'paid|rejected|overridden|pending|reversed');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `alert_generated_timestamp` SET TAGS ('pii_business_glossary_term' = 'DUR Alert Generated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `alert_status` SET TAGS ('pii_business_glossary_term' = 'DUR Alert Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `alert_status` SET TAGS ('pii_value_regex' = 'active|resolved|overridden|suppressed|escalated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `alert_type_code` SET TAGS ('pii_business_glossary_term' = 'DUR Alert Type Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `alert_type_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `alert_type_description` SET TAGS ('pii_business_glossary_term' = 'DUR Alert Type Description');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `clinical_significance_code` SET TAGS ('pii_business_glossary_term' = 'Clinical Significance Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `clinical_significance_code` SET TAGS ('pii_value_regex' = '^[0-9]{1}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `clinical_significance_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `days_since_last_fill` SET TAGS ('pii_business_glossary_term' = 'Days Since Last Fill');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `days_supply` SET TAGS ('pii_business_glossary_term' = 'Days Supply');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `dispensing_date` SET TAGS ('pii_business_glossary_term' = 'Dispensing Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `dispensing_pharmacy_npi` SET TAGS ('pii_business_glossary_term' = 'Dispensing Pharmacy National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `dispensing_pharmacy_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `dispensing_pharmacy_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `drug_database_source` SET TAGS ('pii_business_glossary_term' = 'Drug Database Source');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `drug_database_source` SET TAGS ('pii_value_regex' = 'FDB|MEDI-SPAN|MICROMEDEX|MULTUM|CUSTOM');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `drug_database_version` SET TAGS ('pii_business_glossary_term' = 'Drug Database Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `drug_name` SET TAGS ('pii_business_glossary_term' = 'Drug Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `drug_ndc` SET TAGS ('pii_business_glossary_term' = 'Drug National Drug Code (NDC)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `drug_ndc` SET TAGS ('pii_value_regex' = '^[0-9]{11}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `dur_program_type` SET TAGS ('pii_business_glossary_term' = 'DUR Program Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `dur_program_type` SET TAGS ('pii_value_regex' = 'prospective|retrospective|concurrent');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `icd_code_version` SET TAGS ('pii_business_glossary_term' = 'International Classification of Diseases (ICD) Code Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `icd_code_version` SET TAGS ('pii_value_regex' = 'ICD-9-CM|ICD-10-CM|ICD-11');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `icd_diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'International Classification of Diseases (ICD) Diagnosis Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `icd_diagnosis_code` SET TAGS ('pii_value_regex' = '^[A-Z][0-9]{2}(.[A-Z0-9]{1,4})?$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `icd_diagnosis_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `icd_diagnosis_code` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `icd_diagnosis_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `interacting_drug_name` SET TAGS ('pii_business_glossary_term' = 'Interacting Drug Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `interacting_drug_ndc` SET TAGS ('pii_business_glossary_term' = 'Interacting Drug National Drug Code (NDC)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `interacting_drug_ndc` SET TAGS ('pii_value_regex' = '^[0-9]{11}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `ncpdp_dur_code` SET TAGS ('pii_business_glossary_term' = 'NCPDP Drug Utilization Review (DUR) Conflict Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `ncpdp_dur_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `ncpdp_dur_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `ncpdp_reject_code` SET TAGS ('pii_business_glossary_term' = 'NCPDP Reject Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `ncpdp_reject_code` SET TAGS ('pii_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `ncpdp_reject_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `override_code` SET TAGS ('pii_business_glossary_term' = 'DUR Override Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `override_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `override_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `override_comment` SET TAGS ('pii_business_glossary_term' = 'DUR Override Comment');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `pa_reference_number` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `pa_reference_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `pa_required_flag` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `prescribed_quantity` SET TAGS ('pii_business_glossary_term' = 'Prescribed Quantity');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `prescriber_npi` SET TAGS ('pii_business_glossary_term' = 'Prescriber National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `prescriber_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `prescriber_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `prescription_written_date` SET TAGS ('pii_business_glossary_term' = 'Prescription Written Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `prescription_written_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `prescription_written_date` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `professional_service_code` SET TAGS ('pii_business_glossary_term' = 'NCPDP Professional Service Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `professional_service_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `professional_service_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `quantity_dispensed` SET TAGS ('pii_business_glossary_term' = 'Quantity Dispensed');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `quantity_limit_flag` SET TAGS ('pii_business_glossary_term' = 'Quantity Limit Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `reason_for_service_code` SET TAGS ('pii_business_glossary_term' = 'NCPDP Reason for Service Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `reason_for_service_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `reason_for_service_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `refill_number` SET TAGS ('pii_business_glossary_term' = 'Refill Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `refill_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `result_of_service_code` SET TAGS ('pii_business_glossary_term' = 'NCPDP Result of Service Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `result_of_service_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `result_of_service_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `severity_level_code` SET TAGS ('pii_business_glossary_term' = 'DUR Alert Severity Level Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `severity_level_code` SET TAGS ('pii_value_regex' = '1|2|3|4|5');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `severity_level_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `severity_level_description` SET TAGS ('pii_business_glossary_term' = 'DUR Alert Severity Level Description');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `severity_level_description` SET TAGS ('pii_value_regex' = 'Contraindicated|Major|Moderate|Minor|Informational');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `step_therapy_flag` SET TAGS ('pii_business_glossary_term' = 'Step Therapy Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dur_alert` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` SET TAGS ('pii_subdomain' = 'drug_management');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` SET TAGS ('pii_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `dispensing_pharmacy_id` SET TAGS ('pii_business_glossary_term' = 'Dispensing Pharmacy ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `baa_id` SET TAGS ('pii_business_glossary_term' = 'Baa Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Benefit Manager (PBM) Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `mac_list_id` SET TAGS ('pii_business_glossary_term' = 'Maximum Allowable Cost (MAC) List Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'National Council for Prescription Drug Programs (NCPDP) Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Credential Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `accepts_electronic_prescriptions` SET TAGS ('pii_business_glossary_term' = 'Accepts Electronic Prescriptions Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Address Line 1');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `address_line1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `address_line1` SET TAGS ('pii_fhir_element' = 'address.line');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Address Line 2');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `address_line2` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `address_line2` SET TAGS ('pii_fhir_element' = 'address.line');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `awp_discount_percent` SET TAGS ('pii_business_glossary_term' = 'Average Wholesale Price (AWP) Discount Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `awp_discount_percent` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `chain_independent_flag` SET TAGS ('pii_business_glossary_term' = 'Chain or Independent Pharmacy Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `chain_independent_flag` SET TAGS ('pii_value_regex' = 'chain|independent');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `chain_organization_name` SET TAGS ('pii_business_glossary_term' = 'Chain Organization Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'Pharmacy City');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `city` SET TAGS ('pii_fhir_element' = 'address.city');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `cold_chain_certified` SET TAGS ('pii_business_glossary_term' = 'Cold Chain Certification Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `contract_effective_date` SET TAGS ('pii_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `contract_termination_date` SET TAGS ('pii_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `contract_type` SET TAGS ('pii_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `contract_type` SET TAGS ('pii_value_regex' = 'direct|pbm_administered');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `dispensing_fee_amount` SET TAGS ('pii_business_glossary_term' = 'Dispensing Fee Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `dispensing_fee_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `dispensing_state_code` SET TAGS ('pii_business_glossary_term' = 'Dispensing State Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `dispensing_state_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `dispensing_state_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fax_number` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Fax Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fax_number` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fax_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fax_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fax_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `ingredient_cost_basis` SET TAGS ('pii_business_glossary_term' = 'Ingredient Cost Reimbursement Basis');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `ingredient_cost_basis` SET TAGS ('pii_value_regex' = 'awp_discount|mac|wac|nadac');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'commercial|medicare_part_d|medicaid|exchange|cobra');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `mail_order_capable` SET TAGS ('pii_business_glossary_term' = 'Mail Order Capable Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `ncpdp_chain_code` SET TAGS ('pii_business_glossary_term' = 'National Council for Prescription Drug Programs (NCPDP) Chain Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `ncpdp_chain_code` SET TAGS ('pii_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `ncpdp_chain_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `network_effective_date` SET TAGS ('pii_business_glossary_term' = 'Network Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `network_participation_status` SET TAGS ('pii_business_glossary_term' = 'Network Participation Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `network_participation_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|terminated|pending');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `network_termination_date` SET TAGS ('pii_business_glossary_term' = 'Network Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `network_tier` SET TAGS ('pii_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `network_tier` SET TAGS ('pii_value_regex' = 'preferred|standard|specialty|out_of_network');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `performance_audit_provision` SET TAGS ('pii_business_glossary_term' = 'Performance Audit Provision Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `pharmacy_name` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `pharmacy_type` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `pharmacy_type` SET TAGS ('pii_value_regex' = 'retail|mail_order|specialty|long_term_care|compounding');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `phone_number` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `phone_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `phone_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `phone_number` SET TAGS ('pii_fhir_element' = 'telecom.phone');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `signature_required_flag` SET TAGS ('pii_business_glossary_term' = 'Signature Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `source_system_code` SET TAGS ('pii_value_regex' = 'rxclaim|argus|cactus|provider_source|manual');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `source_system_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `specialty_accreditation_code` SET TAGS ('pii_business_glossary_term' = 'Specialty Pharmacy Accreditation Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `specialty_accreditation_code` SET TAGS ('pii_value_regex' = 'urac|achc|jcaho|nabp_pcab|none');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `specialty_accreditation_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `state_code` SET TAGS ('pii_business_glossary_term' = 'Pharmacy State Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `state_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `state_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `state_code` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `twenty_four_hour_flag` SET TAGS ('pii_business_glossary_term' = '24-Hour Operation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `zip_code` SET TAGS ('pii_business_glossary_term' = 'Pharmacy ZIP Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `zip_code` SET TAGS ('pii_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `zip_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `zip_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`dispensing_pharmacy` ALTER COLUMN `zip_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` SET TAGS ('pii_subdomain' = 'rebate_contracting');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `pbm_contract_id` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Benefit Manager (PBM) Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Contract Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `formulary_id` SET TAGS ('pii_business_glossary_term' = 'Formulary ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'PBM Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `amendment_date` SET TAGS ('pii_business_glossary_term' = 'Most Recent Amendment Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `amendment_date` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `audit_frequency` SET TAGS ('pii_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `audit_frequency` SET TAGS ('pii_value_regex' = 'annual|biennial|on_demand|quarterly|not_applicable');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `audit_rights_flag` SET TAGS ('pii_business_glossary_term' = 'Audit Rights Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('pii_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `awp_discount_mail_pct` SET TAGS ('pii_business_glossary_term' = 'Average Wholesale Price (AWP) Discount Mail Order Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `awp_discount_mail_pct` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `awp_discount_retail_pct` SET TAGS ('pii_business_glossary_term' = 'Average Wholesale Price (AWP) Discount Retail Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `awp_discount_retail_pct` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `cms_contract_number` SET TAGS ('pii_business_glossary_term' = 'CMS Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `cms_contract_number` SET TAGS ('pii_value_regex' = '^H[0-9]{4}$|^S[0-9]{4}$|^R[0-9]{4}$|^E[0-9]{4}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `cms_contract_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_business_glossary_term' = 'PBM Contract Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `contract_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `contract_number` SET TAGS ('pii_business_glossary_term' = 'PBM Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `contract_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `contract_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `contract_owner_name` SET TAGS ('pii_business_glossary_term' = 'Contract Owner Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `contract_status` SET TAGS ('pii_business_glossary_term' = 'PBM Contract Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `contract_status` SET TAGS ('pii_value_regex' = 'draft|active|suspended|terminated|expired|pending_renewal');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `contract_type` SET TAGS ('pii_business_glossary_term' = 'PBM Contract Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `contract_type` SET TAGS ('pii_value_regex' = 'ASO|full_risk|carve_out|pass_through|hybrid');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `contract_type` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `contract_version` SET TAGS ('pii_business_glossary_term' = 'Contract Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `dispensing_fee_mail_order` SET TAGS ('pii_business_glossary_term' = 'Mail Order Dispensing Fee (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `dispensing_fee_mail_order` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `dispensing_fee_retail` SET TAGS ('pii_business_glossary_term' = 'Retail Dispensing Fee (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `dispensing_fee_retail` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `dispensing_fee_specialty` SET TAGS ('pii_business_glossary_term' = 'Specialty Dispensing Fee (USD)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `dispensing_fee_specialty` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `dur_program_flag` SET TAGS ('pii_business_glossary_term' = 'Drug Utilization Review (DUR) Program Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `effective_date` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `generic_dispensing_rate_guarantee` SET TAGS ('pii_business_glossary_term' = 'Generic Dispensing Rate (GDR) Guarantee Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `generic_dispensing_rate_guarantee` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `governing_state_code` SET TAGS ('pii_business_glossary_term' = 'Governing State Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `governing_state_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `governing_state_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `ingredient_cost_basis` SET TAGS ('pii_business_glossary_term' = 'Ingredient Cost Basis');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `ingredient_cost_basis` SET TAGS ('pii_value_regex' = 'AWP|WAC|MAC|NADAC|AAC');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `ingredient_cost_basis` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `lob_scope` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB) Scope');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `lob_scope` SET TAGS ('pii_value_regex' = 'commercial|medicare_part_d|medicaid|exchange|all');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `mac_list_reference` SET TAGS ('pii_business_glossary_term' = 'Maximum Allowable Cost (MAC) List Reference');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `mac_list_reference` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `mail_order_flag` SET TAGS ('pii_business_glossary_term' = 'Mail Order Pharmacy Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `mail_order_penetration_guarantee` SET TAGS ('pii_business_glossary_term' = 'Mail Order Penetration Rate Guarantee Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `mail_order_penetration_guarantee` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `performance_guarantee_flag` SET TAGS ('pii_business_glossary_term' = 'Performance Guarantee Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `prior_auth_flag` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `quantity_limit_flag` SET TAGS ('pii_business_glossary_term' = 'Quantity Limit Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `rebate_guarantee_pmpm` SET TAGS ('pii_business_glossary_term' = 'Rebate Guarantee Per Member Per Month (PMPM)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `rebate_guarantee_pmpm` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `rebate_pass_through_pct` SET TAGS ('pii_business_glossary_term' = 'Rebate Pass-Through Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `rebate_pass_through_pct` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `rebate_reconciliation_lag_days` SET TAGS ('pii_business_glossary_term' = 'Rebate Reconciliation Lag (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `rebate_settlement_frequency` SET TAGS ('pii_business_glossary_term' = 'Rebate Settlement Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `rebate_settlement_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `renewal_notice_days` SET TAGS ('pii_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `source_system_code` SET TAGS ('pii_value_regex' = 'RxClaim|Argus|manual|other');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `source_system_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `specialty_pharmacy_flag` SET TAGS ('pii_business_glossary_term' = 'Specialty Pharmacy Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `step_therapy_flag` SET TAGS ('pii_business_glossary_term' = 'Step Therapy Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `termination_date` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pbm_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` SET TAGS ('pii_subdomain' = 'rebate_contracting');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` SET TAGS ('pii_fhir_resource' = 'Medication');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `drug_rebate_id` SET TAGS ('pii_business_glossary_term' = 'Drug Rebate ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `drug_master_id` SET TAGS ('pii_business_glossary_term' = 'Drug Master Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `drug_master_id` SET TAGS ('pii_internal' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `formulary_id` SET TAGS ('pii_business_glossary_term' = 'Formulary ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `pbm_contract_id` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Benefit Manager (PBM) Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Drug Manufacturer ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `awp_unit_price` SET TAGS ('pii_business_glossary_term' = 'Average Wholesale Price (AWP) Unit Price');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `awp_unit_price` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `calculated_rebate_amount` SET TAGS ('pii_business_glossary_term' = 'Calculated Rebate Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `calculated_rebate_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `contracted_rebate_rate` SET TAGS ('pii_business_glossary_term' = 'Contracted Rebate Rate');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `contracted_rebate_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `dispute_reason` SET TAGS ('pii_business_glossary_term' = 'Rebate Dispute Reason');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `dispute_resolution_date` SET TAGS ('pii_business_glossary_term' = 'Rebate Dispute Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `drug_tier` SET TAGS ('pii_business_glossary_term' = 'Drug Formulary Tier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `drug_tier` SET TAGS ('pii_value_regex' = 'tier_1|tier_2|tier_3|tier_4|tier_5|specialty');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `gl_account_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `invoice_date` SET TAGS ('pii_business_glossary_term' = 'Rebate Invoice Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `invoiced_amount` SET TAGS ('pii_business_glossary_term' = 'Invoiced Rebate Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `invoiced_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'commercial|medicare_part_d|medicaid|exchange|individual');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_business_glossary_term' = 'Drug Manufacturer Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `market_share_pct` SET TAGS ('pii_business_glossary_term' = 'Market Share Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `mlr_rebate_category` SET TAGS ('pii_business_glossary_term' = 'Medical Loss Ratio (MLR) Rebate Category');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `mlr_rebate_category` SET TAGS ('pii_value_regex' = 'medical_cost_reduction|quality_improvement|excluded');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `ndc_code` SET TAGS ('pii_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `ndc_code` SET TAGS ('pii_value_regex' = '^d{5}-d{4}-d{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `ndc_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `part_d_indicator` SET TAGS ('pii_business_glossary_term' = 'CMS Part D Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `pass_through_amount` SET TAGS ('pii_business_glossary_term' = 'Rebate Pass-Through Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `pass_through_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `payment_due_date` SET TAGS ('pii_business_glossary_term' = 'Rebate Payment Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `payment_received_date` SET TAGS ('pii_business_glossary_term' = 'Rebate Payment Received Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `performance_target_met_indicator` SET TAGS ('pii_business_glossary_term' = 'Performance Target Met Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `prior_auth_required_indicator` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Required Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `rebate_invoice_number` SET TAGS ('pii_business_glossary_term' = 'Rebate Invoice Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `rebate_invoice_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `rebate_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Rebate Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `rebate_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Rebate Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `rebate_rate_basis` SET TAGS ('pii_business_glossary_term' = 'Rebate Rate Basis');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `rebate_rate_basis` SET TAGS ('pii_value_regex' = 'AWP|WAC|MAC|net_price');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `rebate_type` SET TAGS ('pii_business_glossary_term' = 'Rebate Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `rebate_type` SET TAGS ('pii_value_regex' = 'base|performance|market_share|formulary_access|inflation|supplemental');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `received_amount` SET TAGS ('pii_business_glossary_term' = 'Received Rebate Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `received_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Rebate Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_value_regex' = 'pending|invoiced|partially_received|received|disputed|written_off');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `source_system_code` SET TAGS ('pii_value_regex' = 'RxClaim|Argus|manual');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `source_system_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `specialty_drug_indicator` SET TAGS ('pii_business_glossary_term' = 'Specialty Drug Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `step_therapy_indicator` SET TAGS ('pii_business_glossary_term' = 'Step Therapy Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `therapeutic_class_code` SET TAGS ('pii_business_glossary_term' = 'Therapeutic Class Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `therapeutic_class_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `utilization_claims_count` SET TAGS ('pii_business_glossary_term' = 'Utilization Claims Count');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `utilization_units` SET TAGS ('pii_business_glossary_term' = 'Utilization Units');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `variance_amount` SET TAGS ('pii_business_glossary_term' = 'Rebate Variance Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `variance_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `wac_unit_price` SET TAGS ('pii_business_glossary_term' = 'Wholesale Acquisition Cost (WAC) Unit Price');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`drug_rebate` ALTER COLUMN `wac_unit_price` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` SET TAGS ('pii_subdomain' = 'drug_management');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` SET TAGS ('pii_fhir_resource' = 'PractitionerRole.specialty');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `specialty_drug_program_id` SET TAGS ('pii_business_glossary_term' = 'Specialty Drug Program ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `formulary_id` SET TAGS ('pii_business_glossary_term' = 'Formulary ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `pbm_contract_id` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Benefit Manager (PBM) Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Program Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `accumulator_adjustment_flag` SET TAGS ('pii_business_glossary_term' = 'Copay Accumulator Adjustment Program (CAAP) Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `awp_discount_pct` SET TAGS ('pii_business_glossary_term' = 'Average Wholesale Price (AWP) Discount Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `awp_discount_pct` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `clinical_management_required_flag` SET TAGS ('pii_business_glossary_term' = 'Clinical Management Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `cms_part_d_specialty_tier_flag` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Part D Specialty Tier Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `cold_chain_required_flag` SET TAGS ('pii_business_glossary_term' = 'Cold Chain Handling Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `copay_assistance_flag` SET TAGS ('pii_business_glossary_term' = 'Manufacturer Copay Assistance Program Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `copay_assistance_max_benefit_amount` SET TAGS ('pii_business_glossary_term' = 'Copay Assistance Maximum Benefit Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `copay_assistance_max_benefit_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `copay_assistance_program_name` SET TAGS ('pii_business_glossary_term' = 'Manufacturer Copay Assistance Program Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `dispensing_fee_amount` SET TAGS ('pii_business_glossary_term' = 'Specialty Pharmacy Dispensing Fee Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `dispensing_fee_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `drug_utilization_review_type` SET TAGS ('pii_business_glossary_term' = 'Drug Utilization Review (DUR) Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `drug_utilization_review_type` SET TAGS ('pii_value_regex' = 'prospective|concurrent|retrospective|none');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Program Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `foundation_grant_flag` SET TAGS ('pii_business_glossary_term' = 'Foundation Grant Assistance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `hub_services_enrollment_flag` SET TAGS ('pii_business_glossary_term' = 'Hub Services Enrollment Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `icd_condition_codes` SET TAGS ('pii_business_glossary_term' = 'International Classification of Diseases (ICD) Condition Codes');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `limited_distribution_flag` SET TAGS ('pii_business_glossary_term' = 'Limited Distribution Drug (LDD) Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'commercial|medicare_part_d|medicaid|exchange|fehb');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `mail_order_allowed_flag` SET TAGS ('pii_business_glossary_term' = 'Mail Order Dispensing Allowed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `max_days_supply` SET TAGS ('pii_business_glossary_term' = 'Maximum Days Supply');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `oop_accumulator_applies_flag` SET TAGS ('pii_business_glossary_term' = 'Out-of-Pocket (OOP) Accumulator Applies Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `patient_assistance_program_flag` SET TAGS ('pii_business_glossary_term' = 'Patient Assistance Program (PAP) Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `prior_auth_required_flag` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `program_code` SET TAGS ('pii_business_glossary_term' = 'Specialty Drug Program Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `program_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `program_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `program_description` SET TAGS ('pii_business_glossary_term' = 'Specialty Drug Program Description');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `program_name` SET TAGS ('pii_business_glossary_term' = 'Specialty Drug Program Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `program_status` SET TAGS ('pii_business_glossary_term' = 'Specialty Drug Program Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `program_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `program_type` SET TAGS ('pii_business_glossary_term' = 'Specialty Drug Program Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `quantity_limit_flag` SET TAGS ('pii_business_glossary_term' = 'Quantity Limit (QL) Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `rems_required_flag` SET TAGS ('pii_business_glossary_term' = 'Risk Evaluation and Mitigation Strategy (REMS) Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `specialty_drug_list_name` SET TAGS ('pii_business_glossary_term' = 'Specialty Drug List Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `specialty_pharmacy_network_name` SET TAGS ('pii_business_glossary_term' = 'Specialty Pharmacy Network Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `specialty_tier_designation` SET TAGS ('pii_business_glossary_term' = 'Specialty Tier Designation');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `specialty_tier_designation` SET TAGS ('pii_value_regex' = 'tier_4|tier_5|tier_6|specialty_preferred|specialty_non_preferred');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `step_therapy_required_flag` SET TAGS ('pii_business_glossary_term' = 'Step Therapy Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Program Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `therapeutic_category` SET TAGS ('pii_business_glossary_term' = 'Therapeutic Category');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `wac_discount_pct` SET TAGS ('pii_business_glossary_term' = 'Wholesale Acquisition Cost (WAC) Discount Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`specialty_drug_program` ALTER COLUMN `wac_discount_pct` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` SET TAGS ('pii_subdomain' = 'clinical_review');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `mtm_service_id` SET TAGS ('pii_business_glossary_term' = 'Mtm Service Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `program_id` SET TAGS ('pii_business_glossary_term' = 'MTM Program ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `chronic_condition_count` SET TAGS ('pii_business_glossary_term' = 'Chronic Condition Count');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `cmr_completion_date` SET TAGS ('pii_business_glossary_term' = 'Comprehensive Medication Review (CMR) Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `cms_reporting_period` SET TAGS ('pii_business_glossary_term' = 'CMS Reporting Period');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `cms_reporting_period` SET TAGS ('pii_value_regex' = '^[0-9]{4}-(Q1|Q2|Q3|Q4|ANNUAL)$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `contact_attempt_count` SET TAGS ('pii_business_glossary_term' = 'MTM Contact Attempt Count');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `disenrollment_date` SET TAGS ('pii_business_glossary_term' = 'MTM Program Disenrollment Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `drug_therapy_problem_type` SET TAGS ('pii_business_glossary_term' = 'Drug Therapy Problem (DTP) Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `dur_outcome_code` SET TAGS ('pii_business_glossary_term' = 'Drug Utilization Review (DUR) Outcome Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `dur_outcome_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `eligibility_determination_date` SET TAGS ('pii_business_glossary_term' = 'MTM Eligibility Determination Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `enrollment_date` SET TAGS ('pii_business_glossary_term' = 'MTM Program Enrollment Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `estimated_annual_drug_cost` SET TAGS ('pii_business_glossary_term' = 'Estimated Annual Part D Drug Cost');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `estimated_annual_drug_cost` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `follow_up_date` SET TAGS ('pii_business_glossary_term' = 'MTM Follow-Up Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `follow_up_required_flag` SET TAGS ('pii_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `follow_up_status` SET TAGS ('pii_business_glossary_term' = 'MTM Follow-Up Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `follow_up_status` SET TAGS ('pii_value_regex' = 'PENDING|COMPLETED|DECLINED|UNREACHABLE|NOT_REQUIRED');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `intervention_count` SET TAGS ('pii_business_glossary_term' = 'MTM Intervention Count');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `last_contact_attempt_date` SET TAGS ('pii_business_glossary_term' = 'Last MTM Contact Attempt Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `map_item_count` SET TAGS ('pii_business_glossary_term' = 'Medication Action Plan (MAP) Item Count');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `map_provided_flag` SET TAGS ('pii_business_glossary_term' = 'Medication Action Plan (MAP) Provided Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `member_consent_flag` SET TAGS ('pii_business_glossary_term' = 'Member Consent Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `opt_out_flag` SET TAGS ('pii_business_glossary_term' = 'MTM Opt-Out Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `opt_out_reason` SET TAGS ('pii_business_glossary_term' = 'MTM Opt-Out Reason');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `opt_out_reason` SET TAGS ('pii_value_regex' = 'MEMBER_REQUEST|DECEASED|DISENROLLED_FROM_PLAN|MOVED_OUT_OF_AREA|OTHER');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `part_d_drug_count` SET TAGS ('pii_business_glossary_term' = 'Part D Drug Count');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `pbm_member_code` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Benefit Manager (PBM) Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `pbm_member_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `pbm_member_code` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `pbm_member_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `personal_medication_list_provided_flag` SET TAGS ('pii_business_glossary_term' = 'Personal Medication List (PML) Provided Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `pharmacist_npi` SET TAGS ('pii_business_glossary_term' = 'Pharmacist National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `pharmacist_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `pharmacist_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `pharmacist_recommendation_notes` SET TAGS ('pii_business_glossary_term' = 'Pharmacist Recommendation Notes');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `pharmacist_recommendation_notes` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `pharmacist_recommendation_notes` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `prescriber_notification_date` SET TAGS ('pii_business_glossary_term' = 'Prescriber Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `prescriber_notification_flag` SET TAGS ('pii_business_glossary_term' = 'Prescriber Notification Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `service_date` SET TAGS ('pii_business_glossary_term' = 'MTM Service Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `service_delivery_channel` SET TAGS ('pii_business_glossary_term' = 'MTM Service Delivery Channel');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `service_delivery_channel` SET TAGS ('pii_value_regex' = 'IN_PERSON|TELEPHONE|TELEHEALTH|MAIL|SECURE_MESSAGE');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `service_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'MTM Service Duration (Minutes)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `service_status` SET TAGS ('pii_business_glossary_term' = 'MTM Service Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `service_status` SET TAGS ('pii_value_regex' = 'SCHEDULED|IN_PROGRESS|COMPLETED|DECLINED|UNREACHABLE|CANCELLED');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `service_type` SET TAGS ('pii_business_glossary_term' = 'MTM Service Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `service_type` SET TAGS ('pii_value_regex' = 'CMR|TMR|FOLLOW_UP|REFERRAL|OTHER');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `source_system_code` SET TAGS ('pii_value_regex' = 'RXCLAIM|ARGUS|CASENET|ALTRUISTA|MANUAL|OTHER');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `source_system_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `source_system_record_code` SET TAGS ('pii_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `source_system_record_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `star_measure_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'STAR Ratings Measure Eligible Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `tmr_date` SET TAGS ('pii_business_glossary_term' = 'Targeted Medication Review (TMR) Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mtm_service` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` SET TAGS ('pii_subdomain' = 'formulary_benefits');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` SET TAGS ('pii_fhir_resource' = 'MedicationKnowledge');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `formulary_exception_id` SET TAGS ('pii_business_glossary_term' = 'Formulary Exception Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `case_id` SET TAGS ('pii_business_glossary_term' = 'Appeal ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `formulary_id` SET TAGS ('pii_business_glossary_term' = 'Formulary ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `prior_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `appeal_rights_notification_date` SET TAGS ('pii_business_glossary_term' = 'Appeal Rights Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `appeal_rights_notified` SET TAGS ('pii_business_glossary_term' = 'Appeal Rights Notification Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `clinical_justification` SET TAGS ('pii_business_glossary_term' = 'Clinical Justification');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `clinical_justification` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `cms_coverage_determination_type` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Coverage Determination Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `cms_coverage_determination_type` SET TAGS ('pii_value_regex' = 'standard|expedited|reopen|revised');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `current_drug_tier` SET TAGS ('pii_business_glossary_term' = 'Current Drug Formulary Tier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `days_supply_requested` SET TAGS ('pii_business_glossary_term' = 'Days Supply Requested');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `decision_date` SET TAGS ('pii_business_glossary_term' = 'Exception Decision Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `decision_timestamp` SET TAGS ('pii_business_glossary_term' = 'Exception Decision Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `denial_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `denial_reason_description` SET TAGS ('pii_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_business_glossary_term' = 'Diagnosis Code (ICD)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_value_regex' = '^[A-Z][0-9A-Z]{1,6}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `diagnosis_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `drug_name` SET TAGS ('pii_business_glossary_term' = 'Requested Drug Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `drug_ndc` SET TAGS ('pii_business_glossary_term' = 'Drug National Drug Code (NDC)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `drug_ndc` SET TAGS ('pii_value_regex' = '^[0-9]{11}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Exception Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Exception Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `exception_request_number` SET TAGS ('pii_business_glossary_term' = 'Exception Request Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `exception_request_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `exception_status` SET TAGS ('pii_business_glossary_term' = 'Exception Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `exception_status` SET TAGS ('pii_value_regex' = 'pending|approved|denied|withdrawn|expired|appealed');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `exception_type` SET TAGS ('pii_business_glossary_term' = 'Exception Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `exception_type` SET TAGS ('pii_value_regex' = 'non_formulary|tier_exception|pa_exception|step_therapy_exception|quantity_limit_exception|coverage_determination');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `formulary_alternative_ndc` SET TAGS ('pii_business_glossary_term' = 'Formulary Alternative Drug National Drug Code (NDC)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `formulary_alternative_ndc` SET TAGS ('pii_value_regex' = '^[0-9]{11}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `is_expedited` SET TAGS ('pii_business_glossary_term' = 'Expedited Exception Request Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'commercial|medicare_part_d|medicaid|exchange|cobra|fehb');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `prescriber_npi` SET TAGS ('pii_business_glossary_term' = 'Prescriber National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `prescriber_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `prescriber_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `quantity_requested` SET TAGS ('pii_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `request_channel` SET TAGS ('pii_business_glossary_term' = 'Exception Request Channel');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `request_channel` SET TAGS ('pii_value_regex' = 'phone|fax|portal|edi|mail|prescriber_portal');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `request_date` SET TAGS ('pii_business_glossary_term' = 'Exception Request Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `request_received_timestamp` SET TAGS ('pii_business_glossary_term' = 'Exception Request Received Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `requested_drug_tier` SET TAGS ('pii_business_glossary_term' = 'Requested Drug Tier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `requested_drug_tier` SET TAGS ('pii_value_regex' = 'tier_1|tier_2|tier_3|tier_4|tier_5|specialty');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `requestor_type` SET TAGS ('pii_business_glossary_term' = 'Requestor Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `requestor_type` SET TAGS ('pii_value_regex' = 'member|prescriber|authorized_representative|pharmacy');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `review_level` SET TAGS ('pii_business_glossary_term' = 'Review Level');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `review_level` SET TAGS ('pii_value_regex' = 'pharmacist|medical_director|peer_to_peer|committee');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `source_system_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `step_therapy_drugs_tried` SET TAGS ('pii_business_glossary_term' = 'Step Therapy Drugs Tried');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `supporting_doc_received` SET TAGS ('pii_business_glossary_term' = 'Supporting Documentation Received Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `supporting_doc_received_date` SET TAGS ('pii_business_glossary_term' = 'Supporting Documentation Received Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`formulary_exception` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` SET TAGS ('pii_subdomain' = 'claim_processing');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `part_d_submission_id` SET TAGS ('pii_business_glossary_term' = 'Part D Submission ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `benefit_package_id` SET TAGS ('pii_business_glossary_term' = 'Plan Benefit Package (PBP) ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `regulatory_submission_id` SET TAGS ('pii_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `accepted_record_count` SET TAGS ('pii_business_glossary_term' = 'CMS Accepted Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `batch_number` SET TAGS ('pii_business_glossary_term' = 'Submission Batch ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `batch_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `benefit_year` SET TAGS ('pii_business_glossary_term' = 'Part D Benefit Year');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `cgdp_invoice_amount` SET TAGS ('pii_business_glossary_term' = 'Coverage Gap Discount Program (CGDP) Invoice Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `cgdp_invoice_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `clearinghouse_tracking_number` SET TAGS ('pii_business_glossary_term' = 'Clearinghouse Tracking ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `clearinghouse_tracking_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `cms_contract_number` SET TAGS ('pii_business_glossary_term' = 'CMS Part D Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `cms_contract_number` SET TAGS ('pii_value_regex' = '^[HS][0-9]{4}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `cms_contract_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `cms_region_code` SET TAGS ('pii_business_glossary_term' = 'CMS Region Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `cms_region_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `cms_response_code` SET TAGS ('pii_business_glossary_term' = 'CMS Response Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `cms_response_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `cms_response_date` SET TAGS ('pii_business_glossary_term' = 'CMS Response Receipt Date and Time');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `cms_response_description` SET TAGS ('pii_business_glossary_term' = 'CMS Response Description');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `dir_amount` SET TAGS ('pii_business_glossary_term' = 'Direct and Indirect Remuneration (DIR) Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `dir_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `edi_interchange_control_number` SET TAGS ('pii_business_glossary_term' = 'Electronic Data Interchange (EDI) Interchange Control Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `edi_interchange_control_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `error_detail` SET TAGS ('pii_business_glossary_term' = 'Submission Error Detail');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `hcc_record_count` SET TAGS ('pii_business_glossary_term' = 'Hierarchical Condition Category (HCC) Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `is_resubmission` SET TAGS ('pii_business_glossary_term' = 'Resubmission Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `is_timely_submission` SET TAGS ('pii_business_glossary_term' = 'Timely Submission Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'MAPD|PDP|EGWP|LIS');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Submission Notes');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `original_batch_number` SET TAGS ('pii_business_glossary_term' = 'Original Submission Batch ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `original_batch_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `pbm_system_source` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Benefit Management (PBM) System Source');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `pbm_system_source` SET TAGS ('pii_value_regex' = 'RXCLAIM|ARGUS|OTHER');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `pde_record_count` SET TAGS ('pii_business_glossary_term' = 'Prescription Drug Event (PDE) Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `pending_record_count` SET TAGS ('pii_business_glossary_term' = 'CMS Pending Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `raf_impact_amount` SET TAGS ('pii_business_glossary_term' = 'Risk Adjustment Factor (RAF) Impact Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `raf_impact_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `reconciliation_date` SET TAGS ('pii_business_glossary_term' = 'Reconciliation Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Submission Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `reconciliation_status` SET TAGS ('pii_value_regex' = 'UNRECONCILED|IN_PROGRESS|RECONCILED|EXCEPTION');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `rejected_record_count` SET TAGS ('pii_business_glossary_term' = 'CMS Rejected Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `reporting_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `reporting_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `resubmission_attempt_number` SET TAGS ('pii_business_glossary_term' = 'Resubmission Attempt Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `resubmission_attempt_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `submission_date` SET TAGS ('pii_business_glossary_term' = 'Submission Transmission Date and Time');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `submission_deadline_date` SET TAGS ('pii_business_glossary_term' = 'CMS Submission Deadline Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `submission_file_name` SET TAGS ('pii_business_glossary_term' = 'Submission File Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `submission_format` SET TAGS ('pii_business_glossary_term' = 'Submission File Format');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `submission_format` SET TAGS ('pii_value_regex' = 'EDI_837|FLAT_FILE|XML|CSV');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `submission_status` SET TAGS ('pii_business_glossary_term' = 'Submission Lifecycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `submission_status` SET TAGS ('pii_value_regex' = 'PENDING|SUBMITTED|ACCEPTED|REJECTED|PARTIALLY_ACCEPTED|RECONCILED');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `submission_type` SET TAGS ('pii_business_glossary_term' = 'Part D Submission Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `submission_type` SET TAGS ('pii_value_regex' = 'RAPS|EDPS|DIR|CGDP|PDE');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `submitter_name` SET TAGS ('pii_business_glossary_term' = 'Submitter Organization Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `total_record_count` SET TAGS ('pii_business_glossary_term' = 'Total Submission Record Count');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`part_d_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` SET TAGS ('pii_subdomain' = 'claim_processing');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` SET TAGS ('pii_fhir_resource' = 'InsurancePlan.coverage.benefit');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `benefit_accumulator_id` SET TAGS ('pii_business_glossary_term' = 'Benefit Accumulator Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `subscriber_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `subscriber_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `subscriber_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `pharmacy_claim2_id` SET TAGS ('pii_business_glossary_term' = 'Last Pharmacy Claim ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `accumulator_reset_date` SET TAGS ('pii_business_glossary_term' = 'Accumulator Reset Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `accumulator_source_system` SET TAGS ('pii_business_glossary_term' = 'Accumulator Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `accumulator_source_system` SET TAGS ('pii_value_regex' = 'rxclaim|argus|facets|qnxt|manual|pbm_feed');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `accumulator_status` SET TAGS ('pii_business_glossary_term' = 'Accumulator Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `accumulator_status` SET TAGS ('pii_value_regex' = 'active|suspended|closed|pending_reset|reconciled');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `accumulator_version` SET TAGS ('pii_business_glossary_term' = 'Accumulator Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `benefit_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Benefit Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `benefit_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Benefit Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `catastrophic_applied_amt` SET TAGS ('pii_business_glossary_term' = 'Catastrophic Coverage Applied Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `catastrophic_applied_amt` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `catastrophic_applied_amt` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `catastrophic_limit_amt` SET TAGS ('pii_business_glossary_term' = 'Catastrophic Coverage Threshold Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `catastrophic_limit_amt` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `catastrophic_limit_amt` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `cms_reconciliation_status` SET TAGS ('pii_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Reconciliation Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `cms_reconciliation_status` SET TAGS ('pii_value_regex' = 'pending|submitted|accepted|rejected|reconciled');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `coordination_of_benefits_type` SET TAGS ('pii_business_glossary_term' = 'Coordination of Benefits (COB) Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `coordination_of_benefits_type` SET TAGS ('pii_value_regex' = 'primary|secondary|tertiary|none');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `coverage_gap_discount_applied_amt` SET TAGS ('pii_business_glossary_term' = 'Coverage Gap Discount Applied Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `coverage_gap_discount_applied_amt` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `coverage_gap_discount_applied_amt` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `deductible_applied_amt` SET TAGS ('pii_business_glossary_term' = 'Deductible Applied Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `deductible_applied_amt` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `deductible_applied_amt` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `deductible_limit_amt` SET TAGS ('pii_business_glossary_term' = 'Deductible Limit Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `deductible_limit_amt` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `deductible_limit_amt` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `eob_generated_flag` SET TAGS ('pii_business_glossary_term' = 'Explanation of Benefits (EOB) Generated Flag');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `family_deductible_applied_amt` SET TAGS ('pii_business_glossary_term' = 'Family Deductible Applied Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `family_deductible_applied_amt` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `family_deductible_applied_amt` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `family_oop_applied_amt` SET TAGS ('pii_business_glossary_term' = 'Family Out-of-Pocket (OOP) Applied Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `family_oop_applied_amt` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `family_oop_applied_amt` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `formulary_tier_applied` SET TAGS ('pii_business_glossary_term' = 'Formulary Tier Applied');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `formulary_tier_applied` SET TAGS ('pii_value_regex' = 'tier_1|tier_2|tier_3|tier_4|tier_5|specialty');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `hsa_eligible_applied_amt` SET TAGS ('pii_business_glossary_term' = 'Health Savings Account (HSA) Eligible Applied Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `hsa_eligible_applied_amt` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `hsa_eligible_applied_amt` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `icl_applied_amt` SET TAGS ('pii_business_glossary_term' = 'Initial Coverage Limit (ICL) Applied Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `icl_applied_amt` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `icl_applied_amt` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `icl_limit_amt` SET TAGS ('pii_business_glossary_term' = 'Initial Coverage Limit (ICL) Limit Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `icl_limit_amt` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `icl_limit_amt` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `is_deductible_met` SET TAGS ('pii_business_glossary_term' = 'Deductible Met Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `is_moop_met` SET TAGS ('pii_business_glossary_term' = 'Maximum Out-of-Pocket (MOOP) Met Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `last_adjudication_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Adjudication Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'commercial|medicare_part_d|medicaid|exchange|cobra|fehb');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `lis_copay_tier` SET TAGS ('pii_business_glossary_term' = 'Low-Income Subsidy (LIS) Copay Tier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `lis_copay_tier` SET TAGS ('pii_value_regex' = 'generic|preferred_brand|non_preferred|specialty|none');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `lis_level` SET TAGS ('pii_business_glossary_term' = 'Low-Income Subsidy (LIS) Level');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `lis_level` SET TAGS ('pii_value_regex' = 'full|partial_1|partial_2|partial_3|none');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `mail_order_applied_amt` SET TAGS ('pii_business_glossary_term' = 'Mail Order Applied Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `mail_order_applied_amt` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `mail_order_applied_amt` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `moop_limit_amt` SET TAGS ('pii_business_glossary_term' = 'Maximum Out-of-Pocket (MOOP) Limit Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `moop_limit_amt` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `moop_limit_amt` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `oop_applied_amt` SET TAGS ('pii_business_glossary_term' = 'Out-of-Pocket (OOP) Applied Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `oop_applied_amt` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `oop_applied_amt` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `part_d_benefit_phase` SET TAGS ('pii_business_glossary_term' = 'Medicare Part D Benefit Phase');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `part_d_benefit_phase` SET TAGS ('pii_value_regex' = 'deductible|initial_coverage|coverage_gap|catastrophic|not_applicable');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `pbm_member_code` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Benefit Manager (PBM) Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `pbm_member_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `pbm_member_code` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `pbm_member_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `rx_claim_count` SET TAGS ('pii_business_glossary_term' = 'Pharmacy (Rx) Claim Count');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `specialty_drug_applied_amt` SET TAGS ('pii_business_glossary_term' = 'Specialty Drug Applied Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `specialty_drug_applied_amt` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `specialty_drug_applied_amt` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `third_party_applied_amt` SET TAGS ('pii_business_glossary_term' = 'Third-Party Applied Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `third_party_applied_amt` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `third_party_applied_amt` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `troop_applied_amt` SET TAGS ('pii_business_glossary_term' = 'True Out-of-Pocket (TrOOP) Applied Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `troop_applied_amt` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `troop_applied_amt` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `troop_limit_amt` SET TAGS ('pii_business_glossary_term' = 'True Out-of-Pocket (TrOOP) Limit Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `troop_limit_amt` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `troop_limit_amt` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`benefit_accumulator` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` SET TAGS ('pii_subdomain' = 'rebate_contracting');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `mac_list_id` SET TAGS ('pii_business_glossary_term' = 'Mac List Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `parent_mac_list_id` SET TAGS ('pii_business_glossary_term' = 'Parent Mac List Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `parent_mac_list_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `brand_name` SET TAGS ('pii_business_glossary_term' = 'Brand Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `mac_list_code` SET TAGS ('pii_business_glossary_term' = 'Mac List Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `dosage_form` SET TAGS ('pii_business_glossary_term' = 'Dosage Form');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `dosage_strength_unit` SET TAGS ('pii_business_glossary_term' = 'Dosage Strength Unit');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `dosage_strength_value` SET TAGS ('pii_business_glossary_term' = 'Dosage Strength Value');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `drug_category` SET TAGS ('pii_business_glossary_term' = 'Drug Category');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `drug_class` SET TAGS ('pii_business_glossary_term' = 'Drug Class');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `drug_code` SET TAGS ('pii_business_glossary_term' = 'Drug Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `drug_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `drug_code_description` SET TAGS ('pii_business_glossary_term' = 'Drug Code Description');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `drug_code_type` SET TAGS ('pii_business_glossary_term' = 'Drug Code Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `drug_description` SET TAGS ('pii_business_glossary_term' = 'Drug Description');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `drug_form_code` SET TAGS ('pii_business_glossary_term' = 'Drug Form Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `drug_form_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `drug_form_description` SET TAGS ('pii_business_glossary_term' = 'Drug Form Description');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `drug_name` SET TAGS ('pii_business_glossary_term' = 'Drug Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `drug_status` SET TAGS ('pii_business_glossary_term' = 'Drug Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `drug_strength_code` SET TAGS ('pii_business_glossary_term' = 'Drug Strength Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `drug_strength_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `drug_strength_description` SET TAGS ('pii_business_glossary_term' = 'Drug Strength Description');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `drug_therapeutic_class_code` SET TAGS ('pii_business_glossary_term' = 'Drug Therapeutic Class Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `drug_therapeutic_class_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `drug_therapeutic_class_description` SET TAGS ('pii_business_glossary_term' = 'Drug Therapeutic Class Description');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `drug_type` SET TAGS ('pii_business_glossary_term' = 'Drug Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `generic_name` SET TAGS ('pii_business_glossary_term' = 'Generic Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `mac_created_at` SET TAGS ('pii_business_glossary_term' = 'Mac Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `mac_created_by` SET TAGS ('pii_business_glossary_term' = 'Mac Created By');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `mac_currency` SET TAGS ('pii_business_glossary_term' = 'Mac Currency');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `mac_effective_date` SET TAGS ('pii_business_glossary_term' = 'Mac Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `mac_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Mac Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `mac_list_status` SET TAGS ('pii_business_glossary_term' = 'Mac List Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `mac_list_type` SET TAGS ('pii_business_glossary_term' = 'Mac List Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `mac_methodology` SET TAGS ('pii_business_glossary_term' = 'Mac Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `mac_price` SET TAGS ('pii_business_glossary_term' = 'Mac Price');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `mac_source` SET TAGS ('pii_business_glossary_term' = 'Mac Source');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `mac_source_date` SET TAGS ('pii_business_glossary_term' = 'Mac Source Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `mac_unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Mac Unit Of Measure');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `mac_unit_price` SET TAGS ('pii_business_glossary_term' = 'Mac Unit Price');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `mac_updated_at` SET TAGS ('pii_business_glossary_term' = 'Mac Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `mac_updated_by` SET TAGS ('pii_business_glossary_term' = 'Mac Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `mac_value` SET TAGS ('pii_business_glossary_term' = 'Mac Value');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `mac_version` SET TAGS ('pii_business_glossary_term' = 'Mac Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `multi_source_code` SET TAGS ('pii_business_glossary_term' = 'Multi Source Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `mac_list_name` SET TAGS ('pii_business_glossary_term' = 'Mac List Name');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `ndc_code` SET TAGS ('pii_business_glossary_term' = 'Ndc Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `ndc_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `package_size` SET TAGS ('pii_business_glossary_term' = 'Package Size');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `package_size_unit` SET TAGS ('pii_business_glossary_term' = 'Package Size Unit');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `package_size_value` SET TAGS ('pii_business_glossary_term' = 'Package Size Value');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `record_audit_created_by` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created By');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `record_audit_updated_by` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `therapeutic_class` SET TAGS ('pii_business_glossary_term' = 'Therapeutic Class');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `therapeutic_equivalence_code` SET TAGS ('pii_business_glossary_term' = 'Therapeutic Equivalence Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`mac_list` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` SET TAGS ('pii_subdomain' = 'claim_processing');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` SET TAGS ('pii_fhir_resource' = 'Claim');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` SET TAGS ('pii_rename_redirect_applied' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `pharmacy_claim2_id` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Claim ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `ap_payment_id` SET TAGS ('pii_business_glossary_term' = 'Ap Payment Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `case_id` SET TAGS ('pii_business_glossary_term' = 'Appeal Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `provider_contract_id` SET TAGS ('pii_business_glossary_term' = 'Pbm Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `dispensing_pharmacy_id` SET TAGS ('pii_business_glossary_term' = 'Dispensing Pharmacy Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `drug_master_id` SET TAGS ('pii_business_glossary_term' = 'Drug Master ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('pii_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `header_id` SET TAGS ('pii_business_glossary_term' = 'Claim Header Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `ledger_id` SET TAGS ('pii_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `identity_id` SET TAGS ('pii_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `identity_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `identity_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `record_id` SET TAGS ('pii_business_glossary_term' = 'Prescriber Credential Record Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `prior_authorization_id` SET TAGS ('pii_business_glossary_term' = 'Prior Authorization (PA) ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Processor Employee Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'Prescriber Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `um_case_id` SET TAGS ('pii_business_glossary_term' = 'Um Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `adjudication_timestamp` SET TAGS ('pii_business_glossary_term' = 'Claim Adjudication Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `basis_of_cost_determination` SET TAGS ('pii_business_glossary_term' = 'Basis of Cost Determination');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `claim_number` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Claim Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `claim_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `claim_status` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Claim Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `claim_status` SET TAGS ('pii_value_regex' = 'paid|rejected|reversed|adjusted|pending|void');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `cob_indicator` SET TAGS ('pii_business_glossary_term' = 'Coordination of Benefits (COB) Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `daw_code` SET TAGS ('pii_business_glossary_term' = 'Dispense As Written (DAW) Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `daw_code` SET TAGS ('pii_value_regex' = '0|1|2|3|4|5');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `daw_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `days_supply` SET TAGS ('pii_business_glossary_term' = 'Days Supply');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `deductible_applied` SET TAGS ('pii_business_glossary_term' = 'Deductible Applied Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `deductible_applied` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `deductible_applied` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `dispensing_fee` SET TAGS ('pii_business_glossary_term' = 'Dispensing Fee');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `dispensing_fee` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `dispensing_fee` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `dispensing_pharmacy_npi` SET TAGS ('pii_business_glossary_term' = 'Dispensing Pharmacy National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `dispensing_pharmacy_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `dispensing_pharmacy_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `dur_outcome_code` SET TAGS ('pii_business_glossary_term' = 'Drug Utilization Review (DUR) Outcome Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `dur_outcome_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `fill_date` SET TAGS ('pii_business_glossary_term' = 'Prescription Fill Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `formulary_tier` SET TAGS ('pii_business_glossary_term' = 'Formulary Drug Tier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `formulary_tier` SET TAGS ('pii_value_regex' = 'tier_1|tier_2|tier_3|tier_4|tier_5|non_formulary');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `ingredient_cost` SET TAGS ('pii_business_glossary_term' = 'Ingredient Cost');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `ingredient_cost` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `ingredient_cost` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `is_340b_claim` SET TAGS ('pii_business_glossary_term' = '340B Program Claim Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `is_compound_claim` SET TAGS ('pii_business_glossary_term' = 'Compound Drug Claim Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'commercial|medicare_part_d|medicaid|exchange|cobra');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `member_coinsurance` SET TAGS ('pii_business_glossary_term' = 'Member Coinsurance Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `member_coinsurance` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `member_coinsurance` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `member_copay` SET TAGS ('pii_business_glossary_term' = 'Member Copay Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `member_copay` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `member_copay` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `ndc` SET TAGS ('pii_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `ndc` SET TAGS ('pii_value_regex' = '^[0-9]{11}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `original_claim_number` SET TAGS ('pii_business_glossary_term' = 'Original Claim Number (Adjustment Reference)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `original_claim_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `other_payer_amount` SET TAGS ('pii_business_glossary_term' = 'Other Payer Amount (Coordination of Benefits)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `other_payer_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `other_payer_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `pharmacy_channel` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Dispensing Channel');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `pharmacy_channel` SET TAGS ('pii_value_regex' = 'retail|mail_order|specialty|long_term_care|home_infusion');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `plan_paid_amount` SET TAGS ('pii_business_glossary_term' = 'Plan Paid Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `plan_paid_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `plan_paid_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `prescriber_npi` SET TAGS ('pii_business_glossary_term' = 'Prescriber National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `prescriber_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `prescriber_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `prescription_written_date` SET TAGS ('pii_business_glossary_term' = 'Prescription Written Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `prescription_written_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `prescription_written_date` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `quantity_dispensed` SET TAGS ('pii_business_glossary_term' = 'Quantity Dispensed');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('pii_value_regex' = 'EA|ML|GM|UN|F2|ME');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `refill_number` SET TAGS ('pii_business_glossary_term' = 'Prescription Refill Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `refill_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `reject_code` SET TAGS ('pii_business_glossary_term' = 'Claim Reject Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `reject_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `sales_tax` SET TAGS ('pii_business_glossary_term' = 'Sales Tax Amount');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `sales_tax` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `sales_tax` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `step_therapy_override` SET TAGS ('pii_business_glossary_term' = 'Step Therapy Override Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim2` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` SET TAGS ('pii_subdomain' = 'rebate_contracting');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` SET TAGS ('pii_vreq_batch_verified' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `pharmacy_contract_id` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `dispensing_pharmacy_id` SET TAGS ('pii_business_glossary_term' = 'Pharmacy ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `mac_list_id` SET TAGS ('pii_business_glossary_term' = 'Maximum Allowable Cost (MAC) List ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `mac_list_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `provider_id` SET TAGS ('pii_business_glossary_term' = 'National Council for Prescription Drug Programs (NCPDP) Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `pbm_contract_id` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Benefit Manager (PBM) Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `provider_network_id` SET TAGS ('pii_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `accreditation_type` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Accreditation Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `accreditation_type` SET TAGS ('pii_value_regex' = 'urac|achc|jcaho|pcab|none');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `audit_frequency` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Audit Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `audit_frequency` SET TAGS ('pii_value_regex' = 'annual|biannual|quarterly|as_needed');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `audit_rights_indicator` SET TAGS ('pii_business_glossary_term' = 'Audit Rights Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `auto_renewal_indicator` SET TAGS ('pii_business_glossary_term' = 'Auto-Renewal Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `awp_discount_pct` SET TAGS ('pii_business_glossary_term' = 'Average Wholesale Price (AWP) Discount Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `awp_discount_pct` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `contract_number` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `contract_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `contract_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `contract_status` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Contract Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `contract_status` SET TAGS ('pii_value_regex' = 'active|pending|suspended|terminated|expired');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `contract_type` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Contract Type');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `contract_type` SET TAGS ('pii_value_regex' = 'direct|pbm_administered|chain|independent|mail_order|specialty');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `contract_type` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `credentialing_required_indicator` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Credentialing Required Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `days_supply_mail_max` SET TAGS ('pii_business_glossary_term' = 'Maximum Mail Order Days Supply');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `days_supply_retail_max` SET TAGS ('pii_business_glossary_term' = 'Maximum Retail Days Supply');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `dispensing_channel` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Dispensing Channel');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `dispensing_channel` SET TAGS ('pii_value_regex' = 'retail|mail_order|specialty|long_term_care|home_infusion');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `dispensing_fee_mail_order` SET TAGS ('pii_business_glossary_term' = 'Mail Order Dispensing Fee');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `dispensing_fee_mail_order` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `dispensing_fee_retail` SET TAGS ('pii_business_glossary_term' = 'Retail Dispensing Fee');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `dispensing_fee_retail` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `dispensing_fee_specialty` SET TAGS ('pii_business_glossary_term' = 'Specialty Drug Dispensing Fee');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `dispensing_fee_specialty` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `executed_date` SET TAGS ('pii_business_glossary_term' = 'Contract Executed Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `fhir_resource_reference` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `fhir_version_code` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `generic_awp_discount_pct` SET TAGS ('pii_business_glossary_term' = 'Generic Average Wholesale Price (AWP) Discount Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `generic_awp_discount_pct` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `generic_dispensing_rate_target` SET TAGS ('pii_business_glossary_term' = 'Generic Dispensing Rate (GDR) Target Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `ingredient_cost_basis` SET TAGS ('pii_business_glossary_term' = 'Ingredient Cost Basis');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `ingredient_cost_basis` SET TAGS ('pii_value_regex' = 'awp_discount|mac|wac_discount|nadac|usual_and_customary');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `ingredient_cost_basis` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `last_amended_date` SET TAGS ('pii_business_glossary_term' = 'Contract Last Amended Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `line_of_business` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `line_of_business` SET TAGS ('pii_value_regex' = 'commercial|medicare_part_d|medicaid|exchange|fehb');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `mail_order_indicator` SET TAGS ('pii_business_glossary_term' = 'Mail Order Pharmacy Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `master_entity_reference` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `network_tier` SET TAGS ('pii_business_glossary_term' = 'Pharmacy Network Tier');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `network_tier` SET TAGS ('pii_value_regex' = 'preferred|standard|specialty|out_of_network');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `part_d_indicator` SET TAGS ('pii_business_glossary_term' = 'Medicare Part D Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `performance_guarantee_indicator` SET TAGS ('pii_business_glossary_term' = 'Performance Guarantee Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `pharmacy_npi` SET TAGS ('pii_business_glossary_term' = 'Pharmacy National Provider Identifier (NPI)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `pharmacy_npi` SET TAGS ('pii_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `pharmacy_npi` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `recoupment_provision_indicator` SET TAGS ('pii_business_glossary_term' = 'Recoupment Provision Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `source_system_contract_code` SET TAGS ('pii_business_glossary_term' = 'Source System Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `source_system_contract_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `specialty_drug_indicator` SET TAGS ('pii_business_glossary_term' = 'Specialty Drug Dispensing Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `state_code` SET TAGS ('pii_business_glossary_term' = 'Contract State Code');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `state_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `state_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `state_code` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `termination_notice_days` SET TAGS ('pii_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `version` SET TAGS ('pii_business_glossary_term' = 'Contract Version');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `wac_discount_pct` SET TAGS ('pii_business_glossary_term' = 'Wholesale Acquisition Cost (WAC) Discount Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_contract` ALTER COLUMN `wac_discount_pct` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim` SET TAGS ('pii_subdomain' = 'claim_processing');
ALTER TABLE `vibe_health_insurance_v1`.`pharmacy`.`pharmacy_claim` ALTER COLUMN `fhir_medication_dispense_resource_id` SET TAGS ('pii_fhir_interop' = 'true');
