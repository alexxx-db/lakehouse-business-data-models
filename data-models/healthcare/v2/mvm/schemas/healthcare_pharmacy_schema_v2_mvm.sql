-- Schema for Domain: pharmacy | Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-07-10 16:21:49

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`pharmacy` COMMENT 'Owns the medication lifecycle from prescribing through dispensing and administration. Manages formulary, NDC (National Drug Code) drug master, MAR (Medication Administration Record), medication reconciliation, controlled substance tracking (DEA Schedule), adverse drug event monitoring, pharmacy inventory, and prescription fulfillment. Sourced from Epic Willow and Cerner PharmNet.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` (
    `drug_master_id` BIGINT COMMENT 'Unique identifier for the drug master record. Primary key for the drug master product.',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Drug master NDC/RxNorm codes mapped to SNOMED, ATC for clinical data exchange. Real business process: medication terminology harmonization, HIE data quality, clinical decision support, international d',
    `ndc_drug_id` BIGINT COMMENT 'add column reference_ndc_drug_id (BIGINT) with FK to reference.ndc_drug.ndc_drug_id - drug_master is the pharmacy operational drug record but lacks a direct FK to the reference NDC code set, relying only on interoperability.terminology_mapp',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Drug master records require a structured SNOMED CT concept link for clinical decision support (drug-allergy checking, FHIR MedicationKnowledge resources), interoperability, and formulary management. T',
    `active_status` STRING COMMENT 'The current lifecycle status of the drug in the organizations drug master, indicating whether it is available for prescribing, dispensing, and administration.. Valid values are `Active|Inactive|Discontinued|Recalled`',
    `atc_code` STRING COMMENT 'The World Health Organizations ATC classification code that categorizes drugs according to the organ or system on which they act and their therapeutic, pharmacological, and chemical properties.',
    `beyond_use_date_hours` STRING COMMENT 'The number of hours after opening or preparation that the drug remains safe and effective for use, particularly relevant for compounded or multi-dose preparations.',
    `black_box_warning_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the FDA has issued a black box warning (boxed warning) for this drug, signaling serious or life-threatening risks that require prominent disclosure.',
    `brand_name` STRING COMMENT 'The proprietary, trademarked name assigned by the pharmaceutical manufacturer for marketing and commercial distribution.',
    `controlled_substance_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the drug is classified as a controlled substance under DEA regulations, requiring special handling, documentation, and security measures.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this drug master record was first created in the system.',
    `dea_schedule` STRING COMMENT 'The DEA controlled substance schedule classification indicating the drugs potential for abuse and accepted medical use. Schedule I has highest abuse potential with no accepted medical use; Schedule V has lowest abuse potential.. Valid values are `Schedule I|Schedule II|Schedule III|Schedule IV|Schedule V|Non-Controlled`',
    `discontinuation_date` DATE COMMENT 'The date on which the drug was discontinued from the formulary or removed from active use in the organization.',
    `discontinuation_reason` STRING COMMENT 'The business or clinical rationale for discontinuing the drug from the formulary (e.g., Manufacturer Discontinuation, Safety Concern, Cost, Therapeutic Alternative Available).',
    `dosage_form` STRING COMMENT 'The physical form in which the drug is manufactured and dispensed (e.g., Tablet, Capsule, Injection, Solution, Cream, Patch, Inhaler).',
    `drug_class` STRING COMMENT 'The pharmacological or therapeutic classification of the drug based on mechanism of action, chemical structure, or therapeutic use (e.g., Beta-Blocker, ACE Inhibitor, NSAID).',
    `fda_application_number` STRING COMMENT 'The FDA-assigned New Drug Application (NDA) or Abbreviated New Drug Application (ANDA) number that uniquely identifies the regulatory submission and approval.',
    `fda_approval_date` DATE COMMENT 'The date on which the FDA granted marketing approval for this drug product, establishing its legal authorization for commercial distribution in the United States.',
    `formulary_status` STRING COMMENT 'The drugs inclusion status in the organizations formulary, indicating whether it is approved for routine use, requires special authorization, or is preferred based on clinical and cost-effectiveness criteria. [ENUM-REF-CANDIDATE: Formulary|Non-Formulary|Restricted|Preferred|Tier 1|Tier 2|Tier 3 — 7 candidates stripped; promote to reference product]',
    `generic_name` STRING COMMENT 'The non-proprietary, scientific name of the active pharmaceutical ingredient as established by the United States Adopted Names (USAN) Council or international nomenclature standards.',
    `geriatric_dosing_adjustment_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the drug requires dosing adjustments or special considerations for geriatric patients due to altered pharmacokinetics or increased sensitivity.',
    `hazardous_drug_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the drug is classified as hazardous per NIOSH criteria, requiring special handling, personal protective equipment, and disposal procedures to protect healthcare workers.',
    `hepatic_dosing_adjustment_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the drug requires dosing adjustments for patients with hepatic impairment or liver disease.',
    `ismp_high_alert_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the drug is classified as high-alert by ISMP, meaning it carries heightened risk of causing significant patient harm when used in error.',
    `lactation_risk_category` STRING COMMENT 'The classification indicating the drugs safety profile for use during breastfeeding and potential risks to nursing infants.',
    `lasa_drug_pairs` STRING COMMENT 'Comma-separated list of drug names that are commonly confused with this drug due to similar appearance or pronunciation, used for clinical decision support and error prevention.',
    `lasa_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the drug has been identified as having look-alike or sound-alike characteristics with other medications, requiring additional safety measures to prevent confusion.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this drug master record was most recently modified or updated.',
    `light_sensitive_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the drug is photosensitive and requires protection from light exposure during storage and handling.',
    `manufacturer_labeler_code` STRING COMMENT 'The first segment of the NDC identifying the labeler or manufacturer, assigned by the FDA.',
    `manufacturer_name` STRING COMMENT 'The name of the pharmaceutical company or labeler responsible for manufacturing and distributing the drug product.',
    `multi_dose_vial_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the drug is packaged as a multi-dose vial that can be used for multiple patient administrations, requiring special dating and handling protocols.',
    `ndc` STRING COMMENT 'FDA-assigned National Drug Code uniquely identifying the drug product, including labeler, product, and package segments. The authoritative pharmaceutical product identifier in the United States.. Valid values are `^d{5}-d{4}-d{2}$|^d{5}-d{3}-d{2}$|^d{4}-d{4}-d{2}$`',
    `package_size` STRING COMMENT 'The quantity of drug units contained in the standard package or container (e.g., 100 tablets, 10 mL vial, 30-day supply).',
    `package_type` STRING COMMENT 'The type of container or packaging in which the drug is supplied (e.g., Bottle, Blister Pack, Vial, Ampule, Syringe, Box).',
    `pediatric_approved_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the drug has FDA approval for use in pediatric populations with established dosing and safety data.',
    `pregnancy_category` STRING COMMENT 'The FDA pregnancy category or Pregnancy and Lactation Labeling Rule (PLLR) classification indicating the drugs safety profile for use during pregnancy.',
    `refrigeration_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the drug requires refrigerated storage conditions to maintain stability and efficacy.',
    `rems_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the FDA requires a Risk Evaluation and Mitigation Strategy program for this drug to ensure that benefits outweigh risks.',
    `renal_dosing_adjustment_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the drug requires dosing adjustments for patients with renal impairment based on creatinine clearance or glomerular filtration rate.',
    `route_of_administration` STRING COMMENT 'The path by which the drug is administered into the body (e.g., Oral, Intravenous, Intramuscular, Subcutaneous, Topical, Inhalation, Ophthalmic).',
    `rxnorm_code` STRING COMMENT 'The standardized nomenclature code from the National Library of Medicines RxNorm system, used for semantic interoperability and clinical decision support across health IT systems.',
    `storage_temperature_range` STRING COMMENT 'The recommended temperature range for proper storage of the drug to maintain potency and safety (e.g., 2-8°C, 15-30°C, Room Temperature).',
    `strength` STRING COMMENT 'The amount of active pharmaceutical ingredient per dosage unit, expressed with numeric value and unit of measure (e.g., 500 mg, 10 mg/mL, 0.5%).',
    `tall_man_lettering` STRING COMMENT 'The drug name displayed with mixed-case capitalization to emphasize differences between look-alike drug names and reduce medication errors (e.g., hydrOXYzine vs hydrALAzine).',
    `therapeutic_category` STRING COMMENT 'The clinical therapeutic category indicating the primary disease state or condition the drug is used to treat (e.g., Cardiovascular, Antibiotic, Analgesic, Antidiabetic).',
    `unit_of_measure` STRING COMMENT 'The standard unit used to quantify the drug for inventory, dispensing, and administration purposes (e.g., Each, Milliliter, Gram, Vial, Patch).',
    CONSTRAINT pk_drug_master PRIMARY KEY(`drug_master_id`)
) COMMENT 'Authoritative pharmacy drug master for every medication managed within the organization. Captures NDC (National Drug Code), drug name (generic and brand), drug class, DEA schedule, dosage form, strength, route of administration, unit of measure, therapeutic category, formulary status, controlled substance indicator, hazardous drug flag, tall-man lettering, ISMP high-alert flag, look-alike/sound-alike (LASA) indicators, and regulatory approval metadata. Serves as the pharmacy-owned SSOT for drug attributes consumed by prescribing, dispensing, administration, and inventory workflows. Distinct from reference domain NDC code sets — this product adds pharmacy-operational attributes (formulary status, ISMP flags, hazardous drug classification). Sourced from Epic Willow and Cerner PharmNet drug dictionaries.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` (
    `formulary_id` BIGINT COMMENT 'Unique identifier for the formulary entry. Primary key for the formulary product.',
    `code_set_version_id` BIGINT COMMENT 'Foreign key linking to reference.code_set_version. Business justification: Formulary decisions are governed by P&T committee policies (prior auth criteria, step therapy protocols). Real process: formulary management requires linking formulary entries to governing policies fo',
    `drug_master_id` BIGINT COMMENT 'Reference to the drug master record containing NDC (National Drug Code), drug name, strength, dosage form, and therapeutic class.',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Formulary drug codes (NDC, RxNorm) mapped to standard terminologies for interoperability. Real business process: semantic interoperability, formulary data exchange standardization, payer formulary fil',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Formulary management requires linking coverage rules to standardized NDC drug definitions for tier assignment, prior authorization criteria, and therapeutic interchange decisions. Essential for payer ',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Formulary rules for specialty drugs administered in clinical settings (e.g., infusion therapy, chemotherapy) require CPT code linkage for procedure-based coverage determination. Essential for buy-and-',
    `age_restriction_max` STRING COMMENT 'Maximum patient age (in years) for which this drug is covered under the formulary. Null if no maximum age restriction applies.',
    `age_restriction_min` STRING COMMENT 'Minimum patient age (in years) for which this drug is covered under the formulary. Null if no minimum age restriction applies.',
    `approval_date` DATE COMMENT 'Date when this formulary entry was officially approved for inclusion in the formulary. Format: yyyy-MM-dd.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or committee that approved this formulary entry (e.g., P&T Committee, Chief Pharmacy Officer).',
    `clinical_review_required` BOOLEAN COMMENT 'Indicates whether clinical review by a pharmacist or physician is required before dispensing. True if clinical review is mandatory.',
    `controlled_substance_schedule` STRING COMMENT 'DEA schedule classification for controlled substances. Schedule II drugs have high abuse potential, Schedule V have lowest. Non-controlled if not a controlled substance.. Valid values are `schedule_I|schedule_II|schedule_III|schedule_IV|schedule_V|non_controlled`',
    `coverage_status` STRING COMMENT 'Indicates whether the drug is covered under this formulary. Conditional or restricted coverage requires additional criteria to be met.. Valid values are `covered|not_covered|conditional|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this formulary record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `days_supply_limit` STRING COMMENT 'Maximum number of days supply that can be dispensed per prescription under this formulary. Common values are 30, 60, or 90 days.',
    `diagnosis_restriction` STRING COMMENT 'ICD-10 diagnosis codes or clinical conditions for which this drug is covered. May be a comma-separated list or reference to a diagnosis group.',
    `effective_date` DATE COMMENT 'Date when this formulary entry becomes active and coverage rules take effect. Format: yyyy-MM-dd.',
    `expiration_date` DATE COMMENT 'Date when this formulary entry expires and coverage rules are no longer in effect. Null for open-ended formularies. Format: yyyy-MM-dd.',
    `formulary_status` STRING COMMENT 'Current lifecycle status of this formulary entry. Active entries are in effect, inactive are not currently used, pending are awaiting approval.. Valid values are `active|inactive|pending|suspended|archived`',
    `formulary_type` STRING COMMENT 'Type or category of formulary, typically aligned with payer type or benefit plan category (e.g., commercial, Medicare Part D, Medicaid).. Valid values are `commercial|medicare_part_d|medicaid|exchange|employer_group|specialty`',
    `gender_restriction` STRING COMMENT 'Gender restriction for coverage of this drug under the formulary. Some drugs may be covered only for specific genders based on clinical indication.. Valid values are `male|female|all|not_specified`',
    `generic_substitution_allowed` BOOLEAN COMMENT 'Indicates whether generic substitution is permitted for this drug under the formulary. True if pharmacist may substitute with generic equivalent.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this formulary record was last updated or modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_reviewed_date` DATE COMMENT 'Date when this formulary entry was last reviewed by the Pharmacy and Therapeutics (P&T) committee or formulary management team. Format: yyyy-MM-dd.',
    `mail_order_eligible` BOOLEAN COMMENT 'Indicates whether this drug is eligible for mail-order pharmacy fulfillment under the formulary. True if mail-order is available.',
    `formulary_name` STRING COMMENT 'Business name or label for this formulary (e.g., Commercial Preferred Formulary 2024, Medicare Part D Standard Formulary).',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formulary review of this entry. Format: yyyy-MM-dd.',
    `notes` STRING COMMENT 'Free-text notes or comments about this formulary entry, including special instructions, clinical guidance, or administrative notes for pharmacists and prescribers.',
    `pharmacy_network_restriction` STRING COMMENT 'Indicates which pharmacy network tier or type is required for dispensing this drug under the formulary (e.g., specialty pharmacy only, preferred network).. Valid values are `preferred_network|standard_network|specialty_pharmacy_only|all_networks`',
    `prior_authorization_criteria` STRING COMMENT 'Detailed clinical or administrative criteria that must be met for prior authorization approval. May reference diagnosis codes, lab values, or prior treatment history.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether prior authorization from the payer is required before the drug can be dispensed. True if PA is mandatory.',
    `quantity_limit` DECIMAL(18,2) COMMENT 'Maximum quantity of the drug that can be dispensed per prescription or per time period under this formulary. Null if no quantity limit applies.',
    `quantity_limit_unit` STRING COMMENT 'Unit of measure for the quantity limit (e.g., tablets, capsules, milliliters, days supply). Defines how the quantity limit is measured. [ENUM-REF-CANDIDATE: tablets|capsules|ml|units|doses|days|per_30_days|per_90_days — 8 candidates stripped; promote to reference product]',
    `refill_limit` STRING COMMENT 'Maximum number of refills allowed for this drug under the formulary. Null if no refill limit applies or unlimited refills are permitted.',
    `specialty_drug_indicator` BOOLEAN COMMENT 'Indicates whether this drug is classified as a specialty drug requiring special handling, distribution, or patient management. True if specialty drug.',
    `step_therapy_protocol` STRING COMMENT 'Description of the step therapy protocol, including which alternative medications must be tried first and for how long before this drug is covered.',
    `step_therapy_required` BOOLEAN COMMENT 'Indicates whether step therapy (trial of alternative medications) is required before this drug is covered. True if step therapy protocol must be followed.',
    `therapeutic_alternative_available` BOOLEAN COMMENT 'Indicates whether therapeutic alternatives (drugs with similar clinical effect) are available on the formulary. True if alternatives exist.',
    `therapeutic_class_code` STRING COMMENT 'Standardized therapeutic class code for the drug (e.g., AHFS, ETC, or internal classification). Used for formulary management and therapeutic interchange.',
    `tier` STRING COMMENT 'The tier classification of the drug within the formulary, determining patient cost-sharing and coverage level. Tier 1 typically has lowest cost-sharing, Tier 5 for specialty drugs.. Valid values are `tier_1_preferred_generic|tier_2_generic|tier_3_preferred_brand|tier_4_non_preferred_brand|tier_5_specialty|not_covered`',
    `version` STRING COMMENT 'Version identifier for the formulary, used to track changes and updates over time (e.g., 2024.1, Q1-2024).',
    CONSTRAINT pk_formulary PRIMARY KEY(`formulary_id`)
) COMMENT 'Defines the approved drug formulary for each health plan, payer, or facility tier. Captures formulary tier (preferred/non-preferred/specialty), prior authorization requirements, step therapy requirements, quantity limits, formulary effective and expiration dates, therapeutic alternatives, payer-specific coverage rules, and specialty drug classification. Supports formulary management, clinical decision support at point of prescribing, and prescription adjudication. Benefit plan financial details (copay/coinsurance schedules, deductible applicability, mail-order benefit rules) are sourced from the billing domain; this product owns drug-level coverage and access rules only. Sourced from Epic Willow and Cerner PharmNet formulary modules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` (
    `prescription_id` BIGINT COMMENT 'Unique identifier for the prescription record. Primary key.',
    `demographics_id` BIGINT COMMENT 'Foreign key linking to patient.demographics. Business justification: New prescriptions trigger ADT notifications to care coordinators, PCPs. Real business process: care coordination, medication reconciliation alerts, high-risk medication monitoring, transitions of care',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: A prescription is written for a specific drug in the pharmacy drug master. Adding drug_master_id normalizes the medication reference from denormalized strings (medication_name, ndc) to the authoritati',
    `eligibility_id` BIGINT COMMENT 'Foreign key linking to claim.eligibility. Business justification: Eligibility verification is performed at point of prescribing for specialty and PA-required drugs to confirm formulary benefit coverage. Linking prescription to the eligibility check supports PA submi',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary. Business justification: A prescription is written against a specific formulary (the patients health plan formulary) which determines coverage tier, prior authorization requirements, and substitution rules. Adding formulary_',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Retail and specialty pharmacies dispense durable medical equipment (DME), prosthetics, orthotics, diabetic supplies, and respiratory equipment that require prescription authorization. These items foll',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Prescriptions require ICD-10 diagnosis linkage for medical necessity validation, prior authorization processing, and off-label use documentation. Essential for payer coverage determination and clinica',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: E-prescribing prior authorization determination and formulary tier checking requires the active insurance coverage at prescribing time. Prescribers must know PA requirements and step therapy obligatio',
    `lab_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_order. Business justification: Prescribing decisions require lab results for renal/hepatic dosing adjustments, therapeutic drug monitoring, and culture-directed antibiotic therapy. Clinical decision support workflow standard in EHR',
    `location_id` BIGINT COMMENT 'Reference to the pharmacy location designated to dispense this prescription. May be null if no specific pharmacy has been selected.',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Prescriptions must reference standardized NDC definitions for drug identification, dispensing validation, formulary checking, and pharmacy claims processing. Core to e-prescribing workflows and medica',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: E-prescribing volume tracked for PI measure attestation (e-Prescribing objective). Real business process: meaningful use compliance, MIPS scoring, e-prescribing measure reporting, CMS quality payment ',
    `original_prescription_id` BIGINT COMMENT 'Reference to the original prescription record if this is a refill, renewal, or change. Null for new prescriptions. Enables tracking of prescription history and refill chains.',
    `dea_registration_id` BIGINT COMMENT 'Foreign key linking to provider.dea_registration. Business justification: Controlled substance prescriptions must be written by a DEA-registered prescriber. Linking prescription to dea_registration enables DEA compliance validation, PDMP reporting, and credentialing verific',
    `clinician_id` BIGINT COMMENT 'Reference to the provider who wrote this prescription. Links to the provider master.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom this prescription was written. Links to the patient master.',
    `prescription_patient_mpi_record_id` BIGINT COMMENT 'FK to patient.mpi_record.mpi_record_id — Prescriptions must link to the patient for medication reconciliation, drug interaction checking, and longitudinal medication history. Required for patient safety.',
    `prescription_prescriber_clinician_id` BIGINT COMMENT 'FK to provider.clinician.clinician_id — Every prescription must identify the prescribing provider for DEA compliance, controlled substance tracking, and clinical accountability. Required by state pharmacy boards and CMS.',
    `specialty_id` BIGINT COMMENT 'The system user ID of the person who last modified this prescription record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this prescription record was first created in the system. Used for audit trail and data lineage tracking.',
    `daw_code` STRING COMMENT 'NCPDP standard code indicating the reason for dispensing a brand-name drug when a generic is available. 0=no product selection indicated; 1=substitution not allowed by prescriber; 2=substitution allowed but patient requested brand; 3-9=other specific reasons. [ENUM-REF-CANDIDATE: 0|1|2|3|4|5|6|7|8|9 — 10 candidates stripped; promote to reference product]',
    `days_supply` STRING COMMENT 'The number of days the prescribed quantity is expected to last based on the sig instructions. Used for refill timing and insurance adjudication.',
    `dea_schedule` STRING COMMENT 'The DEA controlled substance schedule classification for this medication. Schedule I-V indicates controlled substances with varying abuse potential and regulatory requirements; non-controlled indicates the medication is not a controlled substance.. Valid values are `I|II|III|IV|V|non-controlled`',
    `discontinuation_date` DATE COMMENT 'The date on which the prescription was discontinued by the prescriber. Null if the prescription has not been discontinued.',
    `discontinuation_reason` STRING COMMENT 'Free-text explanation of why the prescription was discontinued (e.g., adverse reaction, treatment completed, medication no longer needed, switched to alternative therapy).',
    `dosage_form` STRING COMMENT 'The physical form in which the medication is dispensed (e.g., tablet, capsule, liquid, injection). [ENUM-REF-CANDIDATE: tablet|capsule|liquid|injection|topical|inhaler|patch|suppository|cream|ointment|solution|suspension — 12 candidates stripped; promote to reference product]',
    `drug_strength` STRING COMMENT 'The strength or concentration of the medication (e.g., 500mg, 10mg/mL). Includes both numeric value and unit of measure.',
    `effective_date` DATE COMMENT 'The date on which the prescription becomes active and may be filled. May differ from prescription_date for future-dated prescriptions.',
    `epcs_flag` BOOLEAN COMMENT 'Indicates whether this prescription for a controlled substance was transmitted electronically using EPCS-compliant technology. True if EPCS was used; false if paper or non-EPCS electronic transmission.',
    `erx_transmission_status` STRING COMMENT 'The status of electronic transmission of this prescription to the dispensing pharmacy. Transmitted indicates successful delivery; pending indicates queued for transmission; failed indicates transmission error; not-transmitted indicates paper or verbal prescription.. Valid values are `transmitted|pending|failed|not-transmitted|acknowledged|rejected`',
    `erx_transmission_timestamp` TIMESTAMP COMMENT 'The date and time when the prescription was electronically transmitted to the pharmacy. Null if not electronically transmitted.',
    `expiration_date` DATE COMMENT 'The date after which the prescription is no longer valid and cannot be filled. Typically one year from prescription_date for non-controlled substances; shorter for controlled substances per DEA regulations.',
    `formulary_status` STRING COMMENT 'The status of this medication on the patients insurance formulary. Preferred medications have lower copays; non-preferred have higher copays; not-covered requires full patient payment; other values indicate special requirements.. Valid values are `preferred|non-preferred|not-covered|prior-auth-required|step-therapy-required|quantity-limit`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this prescription record was last updated. Used for audit trail and change tracking.',
    `number` STRING COMMENT 'The externally-known prescription number or control number assigned by the pharmacy system. Used for prescription tracking, refill requests, and patient communication.',
    `pharmacy_notes` STRING COMMENT 'Free-text notes entered by pharmacy staff regarding this prescription. May include clarifications, patient counseling notes, or special handling instructions.',
    `prescriber_notes` STRING COMMENT 'Free-text notes entered by the prescriber regarding this prescription. May include clinical rationale, special instructions, or patient-specific considerations.',
    `prescription_date` DATE COMMENT 'The date on which the prescription was written by the prescriber. This is the authoritative date for prescription validity and expiration calculations.',
    `prescription_status` STRING COMMENT 'The current lifecycle status of the prescription. Active prescriptions may be filled; discontinued prescriptions have been stopped by the prescriber; expired prescriptions have passed their expiration date; on-hold prescriptions are temporarily suspended. [ENUM-REF-CANDIDATE: active|discontinued|expired|on-hold|completed|cancelled|entered-in-error — 7 candidates stripped; promote to reference product]',
    `prescription_type` STRING COMMENT 'Classifies the prescription transaction type. New indicates first-time prescription; refill indicates subsequent fill of existing prescription; renewal indicates new prescription for same medication after previous expired; transfer indicates prescription moved between pharmacies; change indicates modification to existing prescription.. Valid values are `new|refill|renewal|transfer-in|transfer-out|change`',
    `prior_authorization_number` STRING COMMENT 'The authorization number issued by the insurance payer approving coverage for this prescription. Null if no prior authorization was required or obtained.',
    `prior_authorization_required_flag` BOOLEAN COMMENT 'Indicates whether insurance prior authorization is required before this prescription can be filled. True if prior auth is needed; false otherwise.',
    `quantity_prescribed` DECIMAL(18,2) COMMENT 'The total quantity of medication prescribed, expressed in the unit appropriate to the dosage form (e.g., number of tablets, milliliters of liquid).',
    `quantity_unit` STRING COMMENT 'The unit of measure for the prescribed quantity (e.g., tablets, capsules, mL, grams).',
    `refills_authorized` STRING COMMENT 'The number of refills authorized by the prescriber. Zero indicates no refills allowed. Controlled substances have regulatory limits on refill counts.',
    `refills_remaining` STRING COMMENT 'The number of refills remaining on this prescription. Decremented each time the prescription is filled.',
    `route_of_administration` STRING COMMENT 'The path by which the medication is administered to the patient (e.g., oral, intravenous, topical). [ENUM-REF-CANDIDATE: oral|intravenous|intramuscular|subcutaneous|topical|inhalation|rectal|transdermal|sublingual|ophthalmic|otic|nasal — 12 candidates stripped; promote to reference product]',
    `sig` STRING COMMENT 'The prescribers instructions to the patient on how to take the medication. Free-text field containing dosing frequency, timing, and special instructions (e.g., Take 1 tablet by mouth twice daily with food).',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Indicates whether generic substitution is permitted by the prescriber. True allows the pharmacist to dispense a generic equivalent; false requires dispensing as written (DAW).',
    `timestamp` TIMESTAMP COMMENT 'The precise date and time when the prescription was written and entered into the system. Used for audit trails and CPOE (Computerized Physician Order Entry) compliance.',
    CONSTRAINT pk_prescription PRIMARY KEY(`prescription_id`)
) COMMENT 'Core transactional record representing a medication order written by an authorized prescriber for a patient. Captures MRN, prescriber NPI, drug name, NDC, sig (directions), quantity prescribed, days supply, refills authorized, prescribing date, indication (ICD-10), prescription status (active/discontinued/expired/on-hold), e-prescribing transmission status, DEA number for controlled substances, and EPCS (Electronic Prescribing of Controlled Substances) compliance flag. Sourced from Epic Willow and Cerner PharmNet. Governance note: this product has 27 outgoing foreign keys, above the recommended maximum of 25; consider splitting into multiple products or refactoring as a junction table.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` (
    `dispense_event_id` BIGINT COMMENT 'Unique identifier for each medication dispensing event. Primary key for the dispense event transaction.',
    `demographics_id` BIGINT COMMENT 'Reference to the patient receiving the dispensed medication. Links to patient master record.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Dispensing pharmacist is a licensed clinician. Pharmacy operations require tracking which clinician dispensed medication for regulatory compliance, audit trails, quality assurance, and liability. NPI ',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Each dispense event dispenses a specific drug from the drug master. Cardinality N:1 (many dispense events for one drug). The medication_name can be retrieved from drug_master via JOIN. The ndc_code is',
    `eligibility_id` BIGINT COMMENT 'Foreign key linking to claim.eligibility. Business justification: Real-time eligibility verification (NCPDP 270/271) is performed at point of dispense before processing a pharmacy claim. Linking dispense_event to the eligibility record used enables coverage verifica',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary. Business justification: Dispense events must reference the specific health plan for benefit determination (copay, coinsurance, deductible application, formulary tier). Plan-specific rules govern coverage and patient cost-sha',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Pharmacy dispenses medical supplies (diabetic testing supplies, ostomy supplies, wound care products, nebulizers) alongside medications. Dispense events must track both drug and supply dispensing for ',
    `location_id` BIGINT COMMENT 'Reference to the pharmacy location or facility where the medication was dispensed. Links to facility master data.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Dispense events trigger outbound messages (ADT, pharmacy claims, PDMP reports) to payers, HIEs, state agencies. Real business process: real-time benefit verification, PDMP reporting compliance, claims',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Dispense events require direct NDC reference for PDMP reporting, DEA compliance, pharmacy claims adjudication, and drug recall tracking. Regulatory mandate for controlled substance monitoring and stat',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Dispense events documented in CDA Medication Dispense documents for care transitions, discharge summaries. Real business process: continuity of care, medication reconciliation at transitions, post-acu',
    `prescription_id` BIGINT COMMENT 'Reference to the prescription order that authorized this dispensing event. Links to the prescription master record.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: State pharmacy boards require linking dispensing events to licensed employee pharmacists for audits, credentialing verification, and diversion monitoring. Essential for labor cost allocation and produ',
    `controlled_substance_tracking_number` STRING COMMENT 'Unique tracking identifier for controlled substance dispensing events. Required for DEA reporting and audit trail of Schedule II-V medications.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this dispense event. Typically USD for US healthcare organizations.. Valid values are `^[A-Z]{3}$`',
    `days_supply` STRING COMMENT 'The estimated number of days the dispensed medication quantity is expected to last based on prescribed dosing instructions. Used for refill timing and adherence monitoring.',
    `dea_schedule` STRING COMMENT 'DEA controlled substance schedule classification for the dispensed medication. Schedules I-V indicate increasing levels of accepted medical use and decreasing abuse potential. Non-controlled indicates no DEA restriction.. Valid values are `I|II|III|IV|V|non_controlled`',
    `dispense_status` STRING COMMENT 'Current status of the dispensing event in its lifecycle. Indicates whether the medication was successfully dispensed, partially filled, cancelled, or encountered an error.. Valid values are `completed|partial|cancelled|on_hold|stopped|entered_in_error`',
    `dispense_timestamp` TIMESTAMP COMMENT 'The exact date and time when the medication was physically dispensed to the patient or their representative. Represents the business event timestamp for the dispensing action.',
    `dispense_type` STRING COMMENT 'Classification of the dispensing setting or channel. Distinguishes between inpatient hospital pharmacy, outpatient clinic, retail pharmacy, specialty pharmacy, mail order, or emergency dispensing.. Valid values are `inpatient|outpatient|retail|specialty|mail_order|emergency`',
    `dispensed_quantity` DECIMAL(18,2) COMMENT 'The numeric quantity of medication dispensed, measured in the unit specified by quantity_unit. Represents the actual amount provided to the patient.',
    `dispensing_fee_amount` DECIMAL(18,2) COMMENT 'The professional fee charged by the pharmacy for dispensing services, separate from the medication cost. Used for revenue cycle and reimbursement tracking.',
    `dispensing_location_name` STRING COMMENT 'Human-readable name of the pharmacy or dispensing location. Provides context for reporting and patient communication.',
    `expiration_date` DATE COMMENT 'The expiration date of the specific medication lot dispensed. Ensures patient safety and regulatory compliance for medication shelf life.',
    `fill_number` STRING COMMENT 'Sequential fill number for this prescription. Value of 0 or 1 indicates original fill; values greater than 1 indicate refills. Tracks prescription fulfillment history.',
    `insurance_paid_amount` DECIMAL(18,2) COMMENT 'The amount reimbursed or expected to be reimbursed by the patients insurance plan for this dispensing event. Used for revenue cycle and claims reconciliation.',
    `lot_number` STRING COMMENT 'Manufacturer lot or batch number for the dispensed medication. Critical for product recalls, quality control, and adverse event tracking.',
    `medication_cost_amount` DECIMAL(18,2) COMMENT 'The ingredient cost of the medication dispensed, representing the pharmacy acquisition cost or contracted price. Used for financial and inventory management.',
    `ndc_code` STRING COMMENT 'The 11-digit National Drug Code identifying the specific drug product, strength, and package size dispensed. Standardized FDA identifier for medications.. Valid values are `^[0-9]{11}$|^[0-9]{5}-[0-9]{4}-[0-9]{2}$|^[0-9]{5}-[0-9]{3}-[0-9]{2}$|^[0-9]{4}-[0-9]{4}-[0-9]{2}$`',
    `patient_counseling_completed_flag` BOOLEAN COMMENT 'Indicates whether the pharmacist provided patient counseling on medication use, side effects, and interactions as required by state pharmacy practice acts.',
    `patient_counseling_declined_flag` BOOLEAN COMMENT 'Indicates whether the patient or their representative declined pharmacist counseling when offered. Documents patient choice for regulatory compliance.',
    `patient_pay_amount` DECIMAL(18,2) COMMENT 'The out-of-pocket amount paid by the patient for this dispensing event, including copay, coinsurance, or full cash price. Represents patient financial responsibility.',
    `prescriber_dea_number` STRING COMMENT 'The DEA registration number of the prescriber, required for controlled substance prescriptions. Format is two letters followed by seven digits.. Valid values are `^[A-Z]{2}[0-9]{7}$`',
    `prescriber_npi` STRING COMMENT 'The 10-digit NPI of the physician or authorized prescriber who wrote the original prescription. Links to provider master data.. Valid values are `^[0-9]{10}$`',
    `prescription_written_date` DATE COMMENT 'The date the original prescription was written by the prescriber. Used to validate prescription validity and track time from prescribing to dispensing.',
    `quantity_unit` STRING COMMENT 'The unit of measure for the dispensed quantity (e.g., tablets, capsules, mL, grams, inhalers, patches). Standardized using UCUM codes where applicable.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this dispense event record was first created in the data platform. Audit field for data lineage and troubleshooting.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this dispense event record was last modified in the data platform. Tracks data currency and change history.',
    `refills_remaining` STRING COMMENT 'Number of authorized refills remaining after this dispense event. Decremented with each fill to track prescription lifecycle.',
    `sig_text` STRING COMMENT 'The patient instructions for medication use as written on the prescription label. Includes dosing frequency, route, and special instructions. Latin abbreviation sig means write on label.',
    `source_system_dispense_code` STRING COMMENT 'The unique identifier for this dispense event in the originating pharmacy system. Maintains traceability to source system for reconciliation and troubleshooting.',
    `substitution_made_flag` BOOLEAN COMMENT 'Indicates whether a generic or therapeutic substitution was made from the originally prescribed medication. Tracks formulary compliance and cost management.',
    `substitution_reason` STRING COMMENT 'Free-text or coded reason for medication substitution when substitution_made_flag is true. Examples include formulary requirement, drug shortage, patient request, or cost savings.',
    `verification_timestamp` TIMESTAMP COMMENT 'The date and time when the dispensing action was verified by a pharmacist. Represents the final quality check before medication is released to patient.',
    `verifying_pharmacist_npi` STRING COMMENT 'The NPI of the pharmacist who verified the dispensing action. In many workflows, a second pharmacist verifies the dispense for safety and accuracy.. Valid values are `^[0-9]{10}$`',
    CONSTRAINT pk_dispense_event PRIMARY KEY(`dispense_event_id`)
) COMMENT 'Transactional record of each medication dispensing action performed by the pharmacy. Captures prescription reference, dispensed NDC, dispensed quantity, dispensed days supply, lot number, expiration date, dispensing pharmacist NPI, dispensing location, dispense date and time, fill number (original vs. refill), dispense type (inpatient/outpatient/retail/specialty), patient counseling flag, and verification status. Represents the physical fulfillment of a prescription. Sourced from Epic Willow and Cerner PharmNet.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` (
    `mar_record_id` BIGINT COMMENT 'Unique identifier for the medication administration record. Primary key for the MAR record product.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Administering provider is a licensed clinician. Medication administration records must track which licensed provider administered medication for legal liability, clinical review, audit compliance, and',
    `dispense_event_id` BIGINT COMMENT 'Foreign key linking to pharmacy.dispense_event. Business justification: A MAR record documents the administration of a medication that was dispensed via a specific dispense_event. Linking mar_record to dispense_event provides full traceability from dispensing to administr',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Each MAR record documents administration of a specific drug from the drug master. Cardinality N:1 (many MAR records for one drug). The medication_name can be retrieved from drug_master via JOIN. The m',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Inpatient MAR administration events are billed using HCPCS J-codes (injectable drugs) and other drug administration codes for UB-04 charge capture and CMS billing. A domain expert expects MAR records ',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the patient who received the medication. Links to the patient master.',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Medication administration records need NDC linkage for barcode medication administration (BCMA) validation, regulatory reporting to CMS, and adverse event tracking. Required for Joint Commission medic',
    `prescription_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prescription. Business justification: A MAR record documents the administration of a medication that was originally prescribed. Linking mar_record to prescription completes the medication lifecycle chain: prescription → dispense_event → m',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Medication administration by nurses/providers must link to employee for competency assessment, incident investigation, labor cost allocation to patient care, and regulatory compliance (Joint Commissio',
    `actual_administration_timestamp` TIMESTAMP COMMENT 'The actual date and time when the medication was administered to the patient. Core timestamp for medication safety and regulatory compliance.',
    `administration_method` STRING COMMENT 'The specific method or technique used to administer the medication (e.g., IV push, IV piggyback, continuous infusion, nebulizer).',
    `administration_site` STRING COMMENT 'The specific anatomical location where the medication was administered (e.g., left deltoid, right forearm, abdomen).',
    `administration_status` STRING COMMENT 'The status of the medication administration event indicating whether the medication was given, held, refused by patient, not available, or omitted. [ENUM-REF-CANDIDATE: given|held|refused|not-available|omitted|stopped|completed|entered-in-error — 8 candidates stripped; promote to reference product]',
    `administration_status_reason` STRING COMMENT 'The reason why the medication was held, refused, not available, or omitted. Required when status is not given.',
    `barcode_scan_timestamp` TIMESTAMP COMMENT 'The date and time when the medication barcode was scanned during administration, supporting five rights verification (right patient, right drug, right dose, right route, right time).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this MAR record was first created in the lakehouse silver layer.',
    `dea_schedule` STRING COMMENT 'The DEA controlled substance schedule classification for the medication (I through V for controlled substances, or non-controlled).. Valid values are `I|II|III|IV|V|non-controlled`',
    `documentation_timestamp` TIMESTAMP COMMENT 'The date and time when the medication administration was documented in the electronic medical record system.',
    `dose_given` DECIMAL(18,2) COMMENT 'The quantity of medication administered to the patient in this administration event.',
    `dose_unit` STRING COMMENT 'The unit of measure for the dose given (e.g., mg, mL, units, tablets). [ENUM-REF-CANDIDATE: mg|g|mcg|mL|L|units|mEq|mmol|tablets|capsules|puffs|drops|patches — 13 candidates stripped; promote to reference product]',
    `expiration_date` DATE COMMENT 'The expiration date of the medication administered. Required for medication safety and quality assurance.',
    `infusion_duration_minutes` STRING COMMENT 'The total duration in minutes over which an intravenous medication was infused.',
    `infusion_rate` DECIMAL(18,2) COMMENT 'The rate at which an intravenous medication was infused, applicable for IV administrations.',
    `infusion_rate_unit` STRING COMMENT 'The unit of measure for the infusion rate (e.g., mL/hr, units/hr, mcg/kg/min).. Valid values are `mL/hr|mL/min|units/hr|mcg/kg/min|mg/hr`',
    `is_first_dose` BOOLEAN COMMENT 'Boolean flag indicating whether this administration represents the first dose of this medication for the patient during this visit or treatment course.',
    `is_stat_order` BOOLEAN COMMENT 'Boolean flag indicating whether this was a stat (immediate/urgent) medication order requiring immediate administration.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this MAR record was last updated in the lakehouse silver layer.',
    `lot_number` STRING COMMENT 'The manufacturers lot or batch number of the medication administered. Critical for recall tracking and adverse event investigation.',
    `medication_ndc` STRING COMMENT 'The National Drug Code identifying the specific medication product administered. Standard 11-digit FDA identifier in 5-4-2, 5-3-2, or 4-4-2 format.. Valid values are `^[0-9]{4,5}-[0-9]{3,4}-[0-9]{1,2}$`',
    `patient_response` STRING COMMENT 'Clinical observation of the patients response to the medication administration, including any adverse reactions or therapeutic effects noted.',
    `pharmacy_verification_timestamp` TIMESTAMP COMMENT 'The date and time when a pharmacist verified the medication order prior to administration, if applicable.',
    `prn_indication` STRING COMMENT 'The clinical indication or reason for administering a PRN (as needed) medication. Required when the order is PRN.',
    `route` STRING COMMENT 'The anatomical route by which the medication was administered to the patient. [ENUM-REF-CANDIDATE: oral|intravenous|intramuscular|subcutaneous|topical|inhalation|rectal|sublingual|transdermal|ophthalmic|otic|nasal|epidural|intrathecal — 14 candidates stripped; promote to reference product]',
    `scheduled_administration_timestamp` TIMESTAMP COMMENT 'The date and time when the medication was originally scheduled to be administered per the order.',
    `source_system_record_code` STRING COMMENT 'The unique identifier for this MAR record in the source system, enabling traceability back to the originating EHR.',
    `verifying_pharmacist_npi` STRING COMMENT 'The 10-digit National Provider Identifier of the pharmacist who verified the medication order.. Valid values are `^[0-9]{10}$`',
    `waste_amount` DECIMAL(18,2) COMMENT 'The quantity of controlled substance medication that was wasted or discarded during this administration event. Required for controlled substance tracking.',
    `waste_unit` STRING COMMENT 'The unit of measure for the waste amount recorded. [ENUM-REF-CANDIDATE: mg|g|mcg|mL|L|units|mEq|mmol|tablets|capsules — 10 candidates stripped; promote to reference product]',
    `witness_provider_name` STRING COMMENT 'The full name of the clinician who witnessed the controlled substance waste.',
    `witness_provider_npi` STRING COMMENT 'The 10-digit National Provider Identifier of the second clinician who witnessed the controlled substance waste. Required for DEA compliance when waste is documented.. Valid values are `^[0-9]{10}$`',
    CONSTRAINT pk_mar_record PRIMARY KEY(`mar_record_id`)
) COMMENT 'Medication Administration Record (MAR) capturing each instance of medication administration to an inpatient or outpatient patient. Records administered drug, dose given, route, administration date and time, administering nurse/clinician NPI, administration site, patient response, waste amount (for controlled substances), witness NPI for controlled substance waste, and administration status (given/held/refused/not-available). Core to inpatient medication safety and regulatory compliance. Sourced from Epic ClinDoc MAR and Cerner PharmNet.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` (
    `controlled_substance_log_id` BIGINT COMMENT 'Unique identifier for each controlled substance transaction log entry. Primary key for the controlled substance audit trail.',
    `clinical_order_id` BIGINT COMMENT 'Reference to the clinical order (CPOE) that authorized the controlled substance transaction. Null for waste or transfer transactions.',
    `dea_registration_id` BIGINT COMMENT 'Foreign key linking to provider.dea_registration. Business justification: 21 CFR Part 1304 requires every controlled substance transaction to be traceable to a valid DEA registrant. Linking controlled_substance_log to dea_registration enables DEA audit trail compliance, PDM',
    `dispense_event_id` BIGINT COMMENT 'Foreign key linking to pharmacy.dispense_event. Business justification: DEA-compliant controlled substance logs must be traceable to the specific dispense event that triggered the transaction. When a controlled substance is dispensed, a controlled_substance_log entry is c',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Each controlled substance transaction references a specific drug in the drug master. Cardinality N:1 (many log entries for one drug). The drug_name can be retrieved from drug_master via JOIN. No bidir',
    `inventory_id` BIGINT COMMENT 'Foreign key linking to pharmacy.inventory. Business justification: Controlled substance transactions (dispense, waste, transfer, return) directly affect inventory levels. Linking controlled_substance_log to inventory enables real-time reconciliation of the running_ba',
    `lab_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_order. Business justification: Controlled substance monitoring programs (pain management agreements, opioid treatment protocols) require linking CS dispense/administration transactions to the associated urine drug screen or serum d',
    `location_id` BIGINT COMMENT 'Foreign key linking to provider.location. Business justification: Controlled substances are stored and tracked at specific pharmacy locations. Cardinality N:1 (many log entries at one location). The storage_location is kept as it represents a sub-location within the',
    `mar_record_id` BIGINT COMMENT 'Foreign key linking to pharmacy.mar_record. Business justification: When a controlled substance is administered to a patient (captured in a MAR record), a corresponding controlled_substance_log entry must be created for DEA compliance. Linking controlled_substance_log',
    `test_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_result. Business justification: DEA/PDMP compliance and pain management agreements require linking CS transactions to urine drug screen or serum drug-level test results confirming patient compliance or detecting diversion. Regulator',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Controlled substance dispensing reported to state PDMPs. Real business process: opioid epidemic monitoring, prescription drug monitoring program compliance, DEA ARCOS reporting, state health departmen',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: DEA Form 222 reporting and controlled substance inventory reconciliation require standardized NDC reference. Mandatory for DEA audits, diversion monitoring, and automated dispensing cabinet (ADC) disc',
    `prescription_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prescription. Business justification: Controlled substance transactions are often linked to prescriptions for audit trail purposes. Cardinality N:1 (many log entries for one prescription). The prescription_number is kept as the business i',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to claim.prior_authorization. Business justification: Controlled substances (Schedule II-V) frequently require PA before dispensing. Linking controlled_substance_log to the authorizing PA record supports DEA audit trails, PDMP compliance reporting, and r',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Responsible provider is a licensed clinician. DEA compliance requires tracking which licensed provider is responsible for controlled substance transactions. FK enables DEA registration verification an',
    `scheduling_appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: PDMP reporting generates HL7 messages tracked for state compliance. Real business process: state-mandated controlled substance reporting (ASAP standard), opioid stewardship, DEA audit compliance, tran',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: DEA requires separate accountability for investigational controlled substances in clinical trials. Audits trace study drug from receipt through administration/disposal per protocol. Essential for regu',
    `surgical_case_id` BIGINT COMMENT 'Foreign key linking to scheduling.surgical_case. Business justification: DEA regulatory requirement: controlled substances used intraoperatively (fentanyl, morphine, ketamine) must be logged per surgical case for DEA Form 222 compliance, state PDMP reporting, and discrepan',
    `visit_id` BIGINT COMMENT 'Reference to the patient encounter (visit, admission) during which the controlled substance transaction occurred. Null for non-patient transactions.',
    `visit_procedure_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_procedure. Business justification: DEA regulations require controlled substance accountability at the procedure level for intraoperative drugs (fentanyl, propofol, ketamine). Linking controlled_substance_log to visit_procedure enables ',
    `adc_device_code` STRING COMMENT 'Unique identifier of the Automated Dispensing Cabinet (Pyxis, Omnicell) from which the controlled substance was accessed. Null for non-ADC transactions.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this log entry was first created in the data platform. Distinct from transaction_timestamp which represents the real-world event time.',
    `dea_form_222_number` STRING COMMENT 'DEA Form 222 order number for Schedule II controlled substance procurement. Required for all Schedule II transfers between DEA registrants.',
    `dea_schedule` STRING COMMENT 'DEA classification of the controlled substance based on abuse potential and accepted medical use. Schedule II (e.g., morphine, fentanyl) has highest medical use with high abuse potential; Schedule V has lowest abuse potential.. Valid values are `Schedule I|Schedule II|Schedule III|Schedule IV|Schedule V`',
    `department_code` STRING COMMENT 'Code identifying the department or nursing unit where the transaction occurred (e.g., ICU, ED, OR, 3West).',
    `discrepancy_flag` BOOLEAN COMMENT 'Indicates whether this transaction was flagged as a discrepancy during inventory reconciliation or audit. True if discrepancy detected.',
    `discrepancy_reason` STRING COMMENT 'Explanation of the inventory discrepancy: count mismatch, missing documentation, unrecorded waste, suspected diversion. Null if no discrepancy.',
    `drug_ndc` STRING COMMENT 'FDA National Drug Code uniquely identifying the drug product, labeler, and package size. 11-digit code in 5-4-2, 4-4-2, or 5-3-2 format.. Valid values are `^[0-9]{5}-[0-9]{4}-[0-9]{2}$|^[0-9]{4}-[0-9]{4}-[0-9]{2}$|^[0-9]{5}-[0-9]{3}-[0-9]{2}$`',
    `expiration_date` DATE COMMENT 'Manufacturer expiration date of the controlled substance. Used to identify expired inventory requiring disposal.',
    `lot_number` STRING COMMENT 'Manufacturer lot number of the controlled substance. Used for recall tracking and quality assurance.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this log entry was last modified. Used for audit trail and data lineage tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments about the controlled substance transaction. Used for additional context, clarifications, or audit trail documentation.',
    `override_flag` BOOLEAN COMMENT 'Indicates whether the transaction required a system override or manual intervention (e.g., ADC override, pharmacist override). True if override occurred.',
    `override_reason` STRING COMMENT 'Free-text explanation for why a system override was required. Null if no override occurred.',
    `patient_mrn` STRING COMMENT 'Patient Medical Record Number for whom the controlled substance was dispensed or administered. Null for non-patient transactions (waste, transfer, inventory count).',
    `pdmp_reported_flag` BOOLEAN COMMENT 'Indicates whether this controlled substance transaction has been reported to the state Prescription Drug Monitoring Program. True if reported.',
    `pdmp_reported_timestamp` TIMESTAMP COMMENT 'Date and time when the transaction was reported to the state PDMP. Null if not yet reported.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of controlled substance involved in the transaction. Positive for additions (transfer_in, return), negative for reductions (dispensing, administration, waste, transfer_out).',
    `running_balance` DECIMAL(18,2) COMMENT 'Cumulative balance of the controlled substance at the storage location after this transaction. Used for reconciliation and discrepancy detection.',
    `storage_location` STRING COMMENT 'Physical location where the controlled substance is stored: nursing unit, pharmacy vault, ADC cabinet identifier, or specific storage bin/drawer.',
    `transaction_timestamp` TIMESTAMP COMMENT 'Precise date and time when the controlled substance transaction occurred. Critical for DEA audit trail and diversion detection.',
    `transaction_type` STRING COMMENT 'Type of controlled substance transaction: dispensing (pharmacy to patient), administration (nurse to patient), waste (disposal), return (patient to pharmacy), transfer_in (received from another location), transfer_out (sent to another location).. Valid values are `dispensing|administration|waste|return|transfer_in|transfer_out`',
    `transfer_destination` STRING COMMENT 'Destination facility or location for transfer_out transactions. Includes facility name and DEA registration number.',
    `transfer_source` STRING COMMENT 'Source facility or location for transfer_in transactions. Includes facility name and DEA registration number.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the controlled substance quantity (e.g., tablet, ml for liquid, mg for powder). [ENUM-REF-CANDIDATE: tablet|capsule|ml|mg|mcg|patch|vial|ampule — 8 candidates stripped; promote to reference product]',
    `waste_reason` STRING COMMENT 'Reason for controlled substance waste: patient refused, medication error, partial dose unused, expired, contaminated. Null for non-waste transactions.',
    `witness_provider_name` STRING COMMENT 'Full name of the witnessing healthcare provider for waste transactions. Null if no witness required.',
    `witness_provider_npi` STRING COMMENT '10-digit NPI of the witnessing provider for waste transactions. Required for controlled substance waste per facility policy.. Valid values are `^[0-9]{10}$`',
    CONSTRAINT pk_controlled_substance_log PRIMARY KEY(`controlled_substance_log_id`)
) COMMENT 'DEA-compliant audit log for all controlled substance transactions including dispensing, administration, waste, returns, inventory counts, and automated dispensing cabinet (ADC) access events. Captures DEA schedule, drug NDC, transaction type, quantity in/out, running balance, transaction timestamp, responsible pharmacist NPI, witness NPI, patient reference, source system (manual/ADC/Pyxis/Omnicell), cabinet/location identifier, override reason, and discrepancy flags. Supports DEA 222 form compliance, state PDMP reporting, diversion detection, and nursing unit controlled substance accountability. Sourced from Epic Willow, Cerner PharmNet, and Pyxis/Omnicell ADC systems.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` (
    `adverse_drug_event_id` BIGINT COMMENT 'Unique identifier for the adverse drug event record. Primary key.',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Adverse drug events are caused by specific drugs in the drug master. The FK is labeled causative_drug_master_id to distinguish from potential other drug references. Cardinality N:1. The causative_dr',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Adverse drug events trigger claims for treatment of the adverse event (ED visits, hospitalizations, additional medications). Claims analysis identifies drug safety patterns, cost impact of ADEs, and p',
    `code_set_version_id` BIGINT COMMENT 'Foreign key linking to reference.code_set_version. Business justification: Serious adverse drug events require FDA MedWatch reporting (mandatory regulatory submission). Real process: ADE triggers creation of regulatory submission; link tracks submission status and acknowledg',
    `test_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_result. Business justification: Pharmacovigilance and ADE causality assessment workflows require linking the ADE record to the specific lab result that detected or confirmed the event (e.g., elevated creatinine for nephrotoxicity, s',
    `contrast_admin_id` BIGINT COMMENT 'Foreign key linking to radiology.contrast_admin. Business justification: ACR and FDA MedWatch require contrast adverse reactions documented in the pharmacy ADE system to reference the specific contrast administration event (dose, agent, route, injection site). This is the ',
    `demographics_id` BIGINT COMMENT 'Reference to the patient who experienced the adverse drug event.',
    `dispense_event_id` BIGINT COMMENT 'Foreign key linking to pharmacy.dispense_event. Business justification: An adverse drug event may be directly caused by a specific dispensing action — wrong drug dispensed, wrong dose, wrong patient. Linking adverse_drug_event to dispense_event enables traceability from t',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: FDA MedWatch and ISMP pharmacovigilance reporting require ICD-coded classification of the adverse event type (T36-T50 poisoning codes, Y-codes for adverse effects). This is distinct from the resulting',
    `scheduling_appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: Patient safety/pharmacovigilance workflow: after an ADE is documented, a follow-up appointment is scheduled for monitoring and closure. Pharmacy safety officers and risk management track ADE-to-follow',
    `imaging_order_id` BIGINT COMMENT 'Foreign key linking to radiology.imaging_order. Business justification: Contrast-related ADEs must be traceable to the originating imaging order for FDA MedWatch and ISMP reporting, especially when the study was never completed. The existing radiology_study FK does not co',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Payer-required ADE reporting and coverage liability determination requires knowing which insurance coverage was active at time of the adverse event. Insurers use this for subrogation, formulary safety',
    `lab_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_order. Business justification: ADE root cause analysis requires linking to lab results that detected the adverse event (elevated liver enzymes for hepatotoxicity, creatinine for nephrotoxicity). Required for FDA MedWatch reporting ',
    `mar_record_id` BIGINT COMMENT 'Foreign key linking to pharmacy.mar_record. Business justification: An adverse drug event may be directly caused by a specific administration event — wrong route, wrong time, wrong dose administered. Linking adverse_drug_event to mar_record enables traceability from t',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: ADEs reported to FDA MedWatch, state health departments. Real business process: pharmacovigilance, public health surveillance, FDA adverse event reporting, medication safety monitoring, post-market dr',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: FDA MedWatch reporting and pharmacovigilance surveillance require NDC-level drug identification for adverse event submissions. Essential for patient safety reporting, ISMP medication error tracking, a',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: FDA MedWatch and ISMP adverse event reporting require facility identification. Linking adverse_drug_event to org_provider enables facility-level ADE rate reporting, Joint Commission patient safety ana',
    `prescription_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prescription. Business justification: An adverse drug event is often caused by a specific prescription — the prescribing decision, dose, or drug interaction. Linking adverse_drug_event to prescription enables root cause analysis tracing t',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Reporter is often a licensed clinician. Adverse drug event reporting requires tracking reporter identity for follow-up, quality improvement, and regulatory reporting. FK enables linking ADE reports to',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_diagnosis. Business justification: ADEs may result in new diagnoses (drug-induced hepatitis, anaphylaxis, Stevens-Johnson syndrome) that must be documented and coded. Required for patient safety reporting, quality measures, and HAC pre',
    `visit_diagnosis_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_diagnosis. Business justification: Pharmacovigilance and HAI/ADE quality reporting require linking an adverse drug event to the specific encounter-level diagnosis it caused or contributed to. This enables AHRQ Patient Safety Indicator ',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Pharmacovigilance standards (FDA FAERS, ICH E2B) and clinical allergy/intolerance documentation require SNOMED CT coding of adverse drug reactions. A pharmacy informaticist expects ADE records to carr',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which the adverse drug event was identified or occurred.',
    `adverse_drug_event_status` STRING COMMENT 'Current status of the adverse drug event record in the investigation and resolution workflow: reported, under investigation, investigation complete, or closed.. Valid values are `reported|under_investigation|investigation_complete|closed`',
    `causative_drug_ndc` STRING COMMENT 'National Drug Code (NDC) of the medication identified as the cause or contributing factor to the adverse drug event.. Valid values are `^[0-9]{4,5}-[0-9]{3,4}-[0-9]{1,2}$`',
    `contributing_factors` STRING COMMENT 'Documented factors that contributed to the adverse drug event, such as prescribing errors, dispensing errors, administration errors, patient factors, or system failures.',
    `corrective_actions` STRING COMMENT 'Description of corrective actions implemented to prevent recurrence of similar adverse drug events, such as process changes, staff education, or system modifications.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the adverse drug event record was first created in the system.',
    `detection_method` STRING COMMENT 'Method by which the adverse drug event was detected: clinical observation, patient report, laboratory result, automated alert, chart review, or pharmacy review.. Valid values are `clinical_observation|patient_report|laboratory_result|automated_alert|chart_review|pharmacy_review`',
    `event_date` DATE COMMENT 'Date on which the adverse drug event occurred or was first identified.',
    `event_description` STRING COMMENT 'Detailed narrative description of the adverse drug event, including clinical presentation, symptoms, and circumstances.',
    `event_number` STRING COMMENT 'Business identifier or case number assigned to the adverse drug event for tracking and reporting purposes.',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the adverse drug event occurred or was first identified.',
    `event_type` STRING COMMENT 'Classification of the adverse drug event: allergic reaction, adverse drug reaction (ADR), medication error, near-miss, toxicity, therapeutic failure, or drug interaction. [ENUM-REF-CANDIDATE: allergic_reaction|adverse_drug_reaction|medication_error|near_miss|toxicity|therapeutic_failure|drug_interaction — 7 candidates stripped; promote to reference product]',
    `fda_report_number` STRING COMMENT 'FDA MedWatch report number assigned when the adverse drug event was submitted to the FDA.',
    `harm_category` STRING COMMENT 'NCC MERP index category indicating the level of harm: A (no error), B (error no harm), C (error no harm), D (error monitoring required), E (temporary harm), F (temporary harm hospitalization), G (permanent harm), H (life-threatening), I (death). [ENUM-REF-CANDIDATE: A|B|C|D|E|F|G|H|I — 9 candidates stripped; promote to reference product]',
    `intervention_description` STRING COMMENT 'Description of the clinical interventions performed to address the adverse drug event, such as medication discontinuation, antidote administration, or supportive care.',
    `intervention_required` BOOLEAN COMMENT 'Indicates whether clinical intervention was required to mitigate or treat the adverse drug event.',
    `ismp_report_number` STRING COMMENT 'ISMP report number assigned when the adverse drug event was submitted to the ISMP Medication Errors Reporting Program.',
    `modified_by` STRING COMMENT 'User identifier or name of the individual who last modified or updated the adverse drug event record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the adverse drug event record was last modified or updated.',
    `outcome` STRING COMMENT 'Clinical outcome of the adverse drug event: recovered, recovering, not recovered, fatal, or unknown.. Valid values are `recovered|recovering|not_recovered|fatal|unknown`',
    `pharmacy_review_date` DATE COMMENT 'Date on which the adverse drug event was reviewed by the Pharmacy and Therapeutics (P&T) Committee for safety and quality improvement purposes.',
    `preventability_assessment` STRING COMMENT 'Assessment of whether the adverse drug event was preventable, probably preventable, not preventable, or unknown.. Valid values are `preventable|probably_preventable|not_preventable|unknown`',
    `reported_to_fda` BOOLEAN COMMENT 'Indicates whether the adverse drug event was reported to the FDA MedWatch program.',
    `reported_to_ismp` BOOLEAN COMMENT 'Indicates whether the adverse drug event was reported to the Institute for Safe Medication Practices (ISMP) Medication Errors Reporting Program.',
    `reporter_role` STRING COMMENT 'Professional role or title of the individual who reported the adverse drug event (e.g., physician, nurse, pharmacist, patient).',
    `root_cause_analysis_performed` BOOLEAN COMMENT 'Indicates whether a formal root cause analysis was conducted for this adverse drug event.',
    `root_cause_findings` STRING COMMENT 'Summary of findings from the root cause analysis, identifying underlying system or process failures that contributed to the adverse drug event.',
    `severity_level` STRING COMMENT 'Clinical severity classification of the adverse drug event: mild, moderate, severe, life-threatening, or fatal.. Valid values are `mild|moderate|severe|life_threatening|fatal`',
    `created_by` STRING COMMENT 'User identifier or name of the individual who created the adverse drug event record in the system.',
    CONSTRAINT pk_adverse_drug_event PRIMARY KEY(`adverse_drug_event_id`)
) COMMENT 'Operational record of adverse drug events (ADEs), adverse drug reactions (ADRs), and medication errors identified during patient care. Captures event date and time, patient reference, causative drug (NDC), event type (allergic reaction/toxicity/medication error/near-miss), severity level, harm category (NCC MERP index), contributing factors, reporter NPI, encounter reference, root cause analysis findings, and corrective actions taken. Supports pharmacovigilance, FDA MedWatch reporting, ISMP medication error reporting, and pharmacy P&T committee safety reviews. Sourced from Epic Willow and Cerner PharmNet.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` (
    `inventory_id` BIGINT COMMENT 'Primary key for inventory',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Pharmacy inventory management assigned to specific employees for accountability in variance investigation, controlled substance reconciliation (DEA requirement), and financial controls. Essential for ',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Each inventory record tracks a specific drug from the drug master. Cardinality N:1 (many inventory records for one drug across locations/lots). The drug_name, drug_strength, dosage_form, and therapeut',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Pharmacy inventory includes medical supplies and devices (syringes, IV supplies, diabetic testing supplies, spacers, peak flow meters) stored alongside medications. Pharmacy inventory management syste',
    `location_id` BIGINT COMMENT 'Identifier for the specific storage location within the facility (inpatient pharmacy, outpatient pharmacy, automated dispensing cabinet, emergency department, operating room, intensive care unit).',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Pharmacy inventory management requires NDC linkage for drug procurement, FDA recall response, expiration tracking, and 340B program compliance. Critical for automated reorder systems and drug shortage',
    `surgical_case_id` BIGINT COMMENT 'Foreign key linking to scheduling.surgical_case. Business justification: Perioperative pharmacy workflow: drug inventory (anesthesia agents, pre-op antibiotics, implant medications) is allocated and consumed per surgical case. OR pharmacy technicians and anesthesiologists ',
    `average_daily_usage` DECIMAL(18,2) COMMENT 'The calculated average quantity of this medication dispensed per day over a rolling period (typically 30, 60, or 90 days). Used for demand forecasting and reorder calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this inventory record was first created in the source system.',
    `cycle_count_variance` DECIMAL(18,2) COMMENT 'The difference between the system quantity and physical count from the last cycle count (positive indicates overage, negative indicates shortage).',
    `days_supply_on_hand` STRING COMMENT 'The estimated number of days the current on-hand quantity will last based on average daily usage. Used for inventory planning and shortage prevention.',
    `dea_schedule` STRING COMMENT 'The DEA controlled substance schedule classification (I, II, III, IV, V, or non-controlled) indicating the drugs potential for abuse and regulatory requirements.. Valid values are `I|II|III|IV|V|non-controlled`',
    `expiration_date` DATE COMMENT 'The date beyond which the medication should not be used, as determined by the manufacturer. Critical for patient safety and waste management.',
    `formulary_status` STRING COMMENT 'Indicates whether the drug is on the hospital formulary and any restrictions on its use (formulary, non-formulary, restricted, preferred).. Valid values are `formulary|non-formulary|restricted|preferred`',
    `high_alert_medication` BOOLEAN COMMENT 'Flag indicating whether this medication is classified as high-alert by ISMP, requiring additional safety precautions due to increased risk of significant patient harm if used in error.',
    `inventory_status` STRING COMMENT 'The current disposition of the inventory (active/available, quarantined pending quality review, recalled by manufacturer or FDA, expired, damaged, reserved for specific patient or procedure).. Valid values are `active|quarantined|recalled|expired|damaged|reserved`',
    `last_cycle_count_date` DATE COMMENT 'The date when the most recent physical inventory cycle count was performed for this item at this location.',
    `last_dispensed_date` DATE COMMENT 'The date when this medication was most recently dispensed from this location for patient administration or transfer.',
    `last_receipt_date` DATE COMMENT 'The date when inventory was most recently received into this location from purchasing or transfer.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this inventory record was most recently modified in the source system.',
    `lot_number` STRING COMMENT 'The manufacturer-assigned lot or batch number for traceability and recall management.',
    `ndc` STRING COMMENT 'The 11-digit National Drug Code uniquely identifying the drug product, including labeler, product, and package size. Primary drug identifier per FDA standards.. Valid values are `^[0-9]{11}$|^[0-9]{5}-[0-9]{4}-[0-9]{2}$`',
    `par_level` DECIMAL(18,2) COMMENT 'The target maximum inventory level for this medication at this location. Used to optimize inventory investment and storage space.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'The current physical count of medication units available in this location. Measured in the unit of measure specified.',
    `quarantine_reason` STRING COMMENT 'The reason this inventory is quarantined if inventory_status is quarantined (e.g., pending quality review, temperature excursion, damaged packaging, recall investigation).',
    `recall_number` STRING COMMENT 'The FDA or manufacturer recall identification number if this lot is subject to a recall.',
    `reorder_point` DECIMAL(18,2) COMMENT 'The minimum inventory level that triggers a replenishment order. Used to prevent stockouts and ensure medication availability.',
    `shortage_indicator` BOOLEAN COMMENT 'Flag indicating whether this medication is currently on the FDA drug shortage list or experiencing supply chain disruption.',
    `snapshot_timestamp` TIMESTAMP COMMENT 'The date and time when this inventory snapshot was captured. Used to track inventory levels over time and support historical analysis.',
    `storage_requirements` STRING COMMENT 'Special storage conditions required for this medication (e.g., refrigeration 2-8°C, room temperature, protect from light, controlled room temperature).',
    `total_value` DECIMAL(18,2) COMMENT 'The total dollar value of the on-hand quantity (quantity_on_hand × unit_cost). Used for financial reporting and asset management.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The acquisition cost per unit of measure. Used for inventory valuation, budgeting, and financial reporting.',
    `unit_of_measure` STRING COMMENT 'The unit in which inventory quantity is tracked (each, tablet, capsule, vial, ampule, bottle, tube, box, milliliter, liter, gram, milligram). [ENUM-REF-CANDIDATE: each|tablet|capsule|vial|ampule|bottle|tube|box|mL|L|g|mg — 12 candidates stripped; promote to reference product]',
    CONSTRAINT pk_inventory PRIMARY KEY(`inventory_id`)
) COMMENT 'Real-time and periodic snapshot of medication inventory levels and movement history across all pharmacy locations including inpatient, outpatient, and automated dispensing cabinets. Captures drug NDC, location, on-hand quantity, reorder point, par level, lot number, expiration date, unit cost, inventory status (active/quarantined/recalled/expired), shortage indicators, and transaction history (receipts, returns, waste, transfers, cycle count adjustments). Supports medication availability, drug shortage management, supply chain integration, waste reduction, and full inventory audit trail. Sourced from Epic Willow and Cerner PharmNet.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` (
    `rx_claim_id` BIGINT COMMENT 'Unique identifier for the pharmacy benefit claim transaction.',
    `appeal_id` BIGINT COMMENT 'Foreign key linking to claim.claim_appeal. Business justification: When a pharmacy claim denial is appealed, the appeal record in claim_appeal must be traceable from the originating rx_claim. This supports pharmacy appeals management, overturn rate reporting by drug/',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Pharmacy claims must trace to originating clinical orders for audit compliance, revenue cycle reconciliation, clinical outcomes analysis, and quality measure reporting. Required for CMS medication adh',
    `demographics_id` BIGINT COMMENT 'Identifier for the patient receiving the medication.',
    `denial_id` BIGINT COMMENT 'Foreign key linking to claim.claim_denial. Business justification: When a pharmacy claim is rejected or denied by the payer, the denial detail is captured in claim_denial. Linking rx_claim to its denial record is essential for pharmacy denial management workflows, ap',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_diagnosis. Business justification: Pharmacy claims require diagnosis codes for adjudication and medical necessity validation. Required for payer reimbursement, fraud prevention, and utilization management. Standard in pharmacy benefit ',
    `dispense_event_id` BIGINT COMMENT 'Foreign key linking to pharmacy.dispense_event. Business justification: An rx_claim is submitted to a PBM/payer for reimbursement of a specific dispensing action. The dispense_event is the source transaction that generates the pharmacy claim. Linking rx_claim to dispense_',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Dispensing pharmacy is an organizational provider. Claims processing requires pharmacy organization identification for network participation verification, payment routing, and fraud detection. FK enab',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary. Business justification: An rx_claim is adjudicated against a specific formulary — the formulary determines the tier, copay, prior authorization requirements, and coverage status that drive the claim adjudication outcome. Lin',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Pharmacy claims for injectable drugs, vaccines, and DME-related medications require HCPCS code linkage for Medicare Part B billing and medical benefit adjudication. Required for specialty pharmacy cla',
    `imaging_order_id` BIGINT COMMENT 'Foreign key linking to radiology.imaging_order. Business justification: Pharmacy claims for radiopharmaceuticals (PET tracers, nuclear medicine agents) and contrast agents must reconcile against the imaging order for bundled payment analysis, prior authorization validatio',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Pharmacy claims adjudication requires linking to specific coverage record for real-time benefit verification, coordination of benefits processing, and accurate patient cost-sharing calculation. Member',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Pharmacy claims (rx_claim) coordinate with medical claims for integrated patient cost tracking, coordination of benefits determination, and total cost of care reporting. Payers analyze pharmacy + medi',
    `mpi_record_id` BIGINT COMMENT 'Pharmacy benefit plan member identifier assigned by the payer or PBM (Pharmacy Benefit Manager).',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Pharmacy claims adjudication requires NDC linkage for NCPDP transaction processing, drug pricing verification, rebate calculation, and MAC (Maximum Allowable Cost) pricing. Fundamental to pharmacy ben',
    `patient_account_id` BIGINT COMMENT 'Foreign key linking to billing.patient_account. Business justification: Pharmacy claim financial account assignment: rx_claims belong to a patients financial account for balance tracking, collections, and statements. Patient financial services requires rx_claims linked t',
    `patient_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.patient_coverage. Business justification: Pharmacy claim adjudication and COB processing requires the patient_coverage record to determine COB priority, coverage tier, and patient responsibility amount. patient_coverage captures these adjudic',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Prescriber is a licensed clinician. Pharmacy claims must identify prescribing clinician for adjudication, fraud detection, prescribing pattern analysis, and reimbursement. FK enables payer enrollment ',
    `prescription_id` BIGINT COMMENT 'Identifier for the prescription order that authorized this dispensing.',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to claim.prior_authorization. Business justification: Pharmacy benefit adjudication requires the PA number on the rx_claim for payer submission. Linking rx_claim to the structured PA record supports PA utilization reporting, DIR fee reconciliation, and N',
    `remittance_id` BIGINT COMMENT 'Foreign key linking to claim.remittance. Business justification: Remittance advice (835 ERA) is the payers payment response to a submitted pharmacy claim. Linking rx_claim to its remittance record is required for pharmacy revenue cycle reconciliation, ERA auto-pos',
    `scheduling_appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: Pharmacy claims (NCPDP D.0 transactions) generate message log entries for adjudication tracking. Real business process: claims reconciliation, reject resolution, payer communication audit trail, reven',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Claims adjudication for trial-related prescriptions requires study linkage to apply clinical trial coverage policies, distinguish standard-of-care from research costs per Medicare/CMS guidelines, and ',
    `submission_id` BIGINT COMMENT 'Foreign key linking to claim.submission. Business justification: rx_claim is the pharmacy billing record submitted to the payer via EDI. claim.submission tracks the EDI transmission lifecycle. Linking rx_claim to its submission record enables end-to-end pharmacy cl',
    `visit_procedure_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_procedure. Business justification: Buy-and-bill drug claims (J-code biologics, chemotherapy) must be linked to the specific procedure during which the drug was administered for revenue cycle accuracy, payer adjudication, and CMS Part B',
    `adjudication_date` DATE COMMENT 'Date the claim was processed and adjudicated by the PBM (Pharmacy Benefit Manager) or payer.',
    `bin_number` STRING COMMENT 'Six-digit Bank Identification Number (BIN) that routes the claim to the correct PBM (Pharmacy Benefit Manager) processor.. Valid values are `^[0-9]{6}$`',
    `claim_date` DATE COMMENT 'Date the pharmacy claim was submitted to the PBM (Pharmacy Benefit Manager) or payer for adjudication.',
    `claim_number` STRING COMMENT 'External claim number assigned by the pharmacy system or PBM (Pharmacy Benefit Manager) for tracking and reconciliation.',
    `claim_status` STRING COMMENT 'Current processing status of the pharmacy claim in the adjudication lifecycle.. Valid values are `submitted|paid|rejected|reversed|pending|adjusted`',
    `cob_indicator` BOOLEAN COMMENT 'Indicates whether Coordination of Benefits (COB) applies because the patient has multiple pharmacy benefit plans.',
    `compound_indicator` BOOLEAN COMMENT 'Indicates whether the prescription is a compounded medication prepared by combining multiple ingredients.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the claim record was first created in the system.',
    `daw_code` STRING COMMENT 'Dispense As Written (DAW) code indicating whether a brand-name drug was dispensed instead of a generic equivalent and the reason. [ENUM-REF-CANDIDATE: 0|1|2|3|4|5|6|7|8|9 — 10 candidates stripped; promote to reference product]',
    `days_supply` STRING COMMENT 'Number of days the dispensed medication is expected to last based on the prescribed dosing regimen.',
    `dispensing_fee` DECIMAL(18,2) COMMENT 'Fee charged by the pharmacy for dispensing the medication and providing pharmaceutical services.',
    `dispensing_pharmacy_ncpdp_number` STRING COMMENT 'Seven-digit National Council for Prescription Drug Programs (NCPDP) provider identifier for the dispensing pharmacy.. Valid values are `^[0-9]{7}$`',
    `dosage_form` STRING COMMENT 'Physical form of the medication such as tablet, capsule, liquid, injection, or topical.',
    `drug_name` STRING COMMENT 'Brand or generic name of the medication dispensed.',
    `drug_strength` STRING COMMENT 'Strength or concentration of the medication dispensed, including unit of measure.',
    `fill_date` DATE COMMENT 'Date the prescription was dispensed to the patient by the pharmacy.',
    `group_number` STRING COMMENT 'Employer or plan sponsor group identifier for pharmacy benefit eligibility.',
    `ingredient_cost` DECIMAL(18,2) COMMENT 'Cost of the drug ingredient itself, excluding dispensing fees and other charges.',
    `ndc_code` STRING COMMENT 'National Drug Code (NDC) identifying the specific drug product dispensed, including manufacturer, product, and package size.. Valid values are `^[0-9]{5}-[0-9]{4}-[0-9]{2}$|^[0-9]{11}$`',
    `patient_copay` DECIMAL(18,2) COMMENT 'Amount paid by the patient at the point of sale as their cost-sharing responsibility.',
    `pcn_number` STRING COMMENT 'Processor Control Number (PCN) used by the PBM (Pharmacy Benefit Manager) to identify the specific benefit plan or processing rules.',
    `plan_paid_amount` DECIMAL(18,2) COMMENT 'Amount paid by the pharmacy benefit plan or PBM (Pharmacy Benefit Manager) for the claim.',
    `primary_payer_paid_amount` DECIMAL(18,2) COMMENT 'Amount paid by the primary payer in a Coordination of Benefits (COB) scenario.',
    `quantity_dispensed` DECIMAL(18,2) COMMENT 'Quantity of medication dispensed, measured in the appropriate unit (tablets, milliliters, grams, etc.).',
    `refill_number` STRING COMMENT 'Sequential refill number for this prescription, with zero indicating the original fill.',
    `reject_code` STRING COMMENT 'NCPDP reject code returned by the PBM (Pharmacy Benefit Manager) when a claim is denied, indicating the reason for rejection.',
    `reject_description` STRING COMMENT 'Human-readable description of the reject code explaining why the claim was denied.',
    `reversal_date` DATE COMMENT 'Date the claim was reversed or voided, if applicable.',
    `sales_tax` DECIMAL(18,2) COMMENT 'Sales tax amount applied to the prescription transaction, if applicable.',
    `submission_clarification_code` STRING COMMENT 'NCPDP submission clarification code providing additional context about the claim submission circumstances.',
    `total_amount_paid` DECIMAL(18,2) COMMENT 'Total amount paid for the prescription, including patient copay and plan paid amount.',
    `transaction_response_status` STRING COMMENT 'Real-time response status returned by the PBM (Pharmacy Benefit Manager) during claim adjudication.. Valid values are `approved|rejected|captured|duplicate`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the claim record was last modified or updated.',
    `usual_and_customary_price` DECIMAL(18,2) COMMENT 'Usual and Customary (U&C) price the pharmacy would charge a cash-paying customer for the same prescription.',
    CONSTRAINT pk_rx_claim PRIMARY KEY(`rx_claim_id`)
) COMMENT 'Pharmacy benefit claim submitted to a PBM (Pharmacy Benefit Manager) or payer for reimbursement of a dispensed medication. Captures NCPDP transaction fields including claim date, BIN/PCN/group number, member ID, prescriber NPI, dispensing pharmacy NPI, drug NDC, quantity dispensed, days supply, DAW (Dispense As Written) code, ingredient cost, dispensing fee, patient copay, plan paid amount, U&C (Usual and Customary) price, claim status (paid/rejected/reversed), NCPDP reject codes, and coordination of benefits (COB) data. Distinct from medical claims in the claim domain — this product owns pharmacy-specific NCPDP D.0 claim transactions. Sourced from Epic Willow and Cerner PharmNet.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_original_prescription_id` FOREIGN KEY (`original_prescription_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_dispense_event_id` FOREIGN KEY (`dispense_event_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`dispense_event`(`dispense_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_dispense_event_id` FOREIGN KEY (`dispense_event_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`dispense_event`(`dispense_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_inventory_id` FOREIGN KEY (`inventory_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`inventory`(`inventory_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_mar_record_id` FOREIGN KEY (`mar_record_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`mar_record`(`mar_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_dispense_event_id` FOREIGN KEY (`dispense_event_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`dispense_event`(`dispense_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_mar_record_id` FOREIGN KEY (`mar_record_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`mar_record`(`mar_record_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_dispense_event_id` FOREIGN KEY (`dispense_event_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`dispense_event`(`dispense_event_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`prescription`(`prescription_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`pharmacy` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`pharmacy` SET TAGS ('dbx_domain' = 'pharmacy');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Terminology Mapping Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Discontinued|Recalled');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `atc_code` SET TAGS ('dbx_business_glossary_term' = 'Anatomical Therapeutic Chemical (ATC) Classification Code');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `beyond_use_date_hours` SET TAGS ('dbx_business_glossary_term' = 'Beyond Use Date Hours');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `black_box_warning_flag` SET TAGS ('dbx_business_glossary_term' = 'Black Box Warning Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Drug Name');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `controlled_substance_indicator` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Indicator');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_value_regex' = 'Schedule I|Schedule II|Schedule III|Schedule IV|Schedule V|Non-Controlled');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `discontinuation_reason` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Reason');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `dosage_form` SET TAGS ('dbx_business_glossary_term' = 'Dosage Form');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `dosage_form` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `drug_class` SET TAGS ('dbx_business_glossary_term' = 'Drug Classification');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `fda_application_number` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Application Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `fda_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `formulary_status` SET TAGS ('dbx_business_glossary_term' = 'Formulary Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `generic_name` SET TAGS ('dbx_business_glossary_term' = 'Generic Drug Name');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `geriatric_dosing_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Geriatric Dosing Adjustment Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `hazardous_drug_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Drug Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `hepatic_dosing_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Hepatic Dosing Adjustment Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `ismp_high_alert_flag` SET TAGS ('dbx_business_glossary_term' = 'Institute for Safe Medication Practices (ISMP) High-Alert Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `lactation_risk_category` SET TAGS ('dbx_business_glossary_term' = 'Lactation Risk Category');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `lasa_drug_pairs` SET TAGS ('dbx_business_glossary_term' = 'Look-Alike Sound-Alike (LASA) Drug Pairs');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `lasa_indicator` SET TAGS ('dbx_business_glossary_term' = 'Look-Alike Sound-Alike (LASA) Indicator');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `light_sensitive_flag` SET TAGS ('dbx_business_glossary_term' = 'Light Sensitive Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `manufacturer_labeler_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Labeler Code');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `multi_dose_vial_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Dose Vial Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `ndc` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `ndc` SET TAGS ('dbx_value_regex' = '^d{5}-d{4}-d{2}$|^d{5}-d{3}-d{2}$|^d{4}-d{4}-d{2}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `package_size` SET TAGS ('dbx_business_glossary_term' = 'Package Size');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `package_size` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `package_type` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `pediatric_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Pediatric Approved Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `pregnancy_category` SET TAGS ('dbx_business_glossary_term' = 'Pregnancy Category');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `refrigeration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Refrigeration Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `rems_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Evaluation and Mitigation Strategy (REMS) Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `renal_dosing_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Renal Dosing Adjustment Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `rxnorm_code` SET TAGS ('dbx_business_glossary_term' = 'RxNorm Code');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `storage_temperature_range` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Range');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `storage_temperature_range` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `strength` SET TAGS ('dbx_business_glossary_term' = 'Drug Strength');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `tall_man_lettering` SET TAGS ('dbx_business_glossary_term' = 'Tall Man Lettering');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `therapeutic_category` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Category');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `code_set_version_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Terminology Mapping Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `age_restriction_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Age Restriction');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `age_restriction_max` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `age_restriction_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Restriction');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `age_restriction_min` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `clinical_review_required` SET TAGS ('dbx_business_glossary_term' = 'Clinical Review Required');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Controlled Substance Schedule');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_value_regex' = 'schedule_I|schedule_II|schedule_III|schedule_IV|schedule_V|non_controlled');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `coverage_status` SET TAGS ('dbx_value_regex' = 'covered|not_covered|conditional|restricted');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `coverage_status` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `days_supply_limit` SET TAGS ('dbx_business_glossary_term' = 'Days Supply Limit');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `diagnosis_restriction` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Restriction');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `diagnosis_restriction` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `diagnosis_restriction` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Formulary Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Formulary Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_status` SET TAGS ('dbx_business_glossary_term' = 'Formulary Entry Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|archived');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_type` SET TAGS ('dbx_business_glossary_term' = 'Formulary Type');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_type` SET TAGS ('dbx_value_regex' = 'commercial|medicare_part_d|medicaid|exchange|employer_group|specialty');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_business_glossary_term' = 'Gender Restriction');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_value_regex' = 'male|female|all|not_specified');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `generic_substitution_allowed` SET TAGS ('dbx_business_glossary_term' = 'Generic Substitution Allowed');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `mail_order_eligible` SET TAGS ('dbx_business_glossary_term' = 'Mail Order Eligible');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_name` SET TAGS ('dbx_business_glossary_term' = 'Formulary Name');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_name` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Formulary Notes');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `pharmacy_network_restriction` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Network Restriction');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `pharmacy_network_restriction` SET TAGS ('dbx_value_regex' = 'preferred_network|standard_network|specialty_pharmacy_only|all_networks');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `prior_authorization_criteria` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Criteria');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Required');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `quantity_limit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `quantity_limit_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `refill_limit` SET TAGS ('dbx_business_glossary_term' = 'Refill Limit');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `specialty_drug_indicator` SET TAGS ('dbx_business_glossary_term' = 'Specialty Drug Indicator');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `step_therapy_protocol` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Protocol');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Required');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `therapeutic_alternative_available` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Alternative Available');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `therapeutic_class_code` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Class Code');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Formulary Tier');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `tier` SET TAGS ('dbx_value_regex' = 'tier_1_preferred_generic|tier_2_generic|tier_3_preferred_brand|tier_4_non_preferred_brand|tier_5_specialty|not_covered');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Formulary Version');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Identifier');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Care Transition Notification Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Indication Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Lab Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Pharmacy Identifier');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Promoting Interoperability Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `original_prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Original Prescription Identifier');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `original_prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `original_prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `dea_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Dea Registration Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Identifier');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `clinician_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_confidentiality' = 'confidential');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_patient_mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Patient Mpi Record Id');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_prescriber_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Prescriber Clinician Id');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `specialty_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `specialty_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `daw_code` SET TAGS ('dbx_business_glossary_term' = 'Dispense As Written (DAW) Code');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `days_supply` SET TAGS ('dbx_business_glossary_term' = 'Days Supply');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_value_regex' = 'I|II|III|IV|V|non-controlled');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `discontinuation_reason` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Reason');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `dosage_form` SET TAGS ('dbx_business_glossary_term' = 'Dosage Form');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `dosage_form` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `drug_strength` SET TAGS ('dbx_business_glossary_term' = 'Drug Strength');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `epcs_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Prescribing of Controlled Substances (EPCS) Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `erx_transmission_status` SET TAGS ('dbx_business_glossary_term' = 'Electronic Prescription (eRx) Transmission Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `erx_transmission_status` SET TAGS ('dbx_value_regex' = 'transmitted|pending|failed|not-transmitted|acknowledged|rejected');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `erx_transmission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Electronic Prescription (eRx) Transmission Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `formulary_status` SET TAGS ('dbx_business_glossary_term' = 'Formulary Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `formulary_status` SET TAGS ('dbx_value_regex' = 'preferred|non-preferred|not-covered|prior-auth-required|step-therapy-required|quantity-limit');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Prescription Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `number` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `pharmacy_notes` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Notes');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescriber_notes` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Notes');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_date` SET TAGS ('dbx_business_glossary_term' = 'Prescription Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_status` SET TAGS ('dbx_business_glossary_term' = 'Prescription Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_type` SET TAGS ('dbx_business_glossary_term' = 'Prescription Type');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_type` SET TAGS ('dbx_value_regex' = 'new|refill|renewal|transfer-in|transfer-out|change');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prior_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prior_authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `quantity_prescribed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Prescribed');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `refills_authorized` SET TAGS ('dbx_business_glossary_term' = 'Refills Authorized');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `refills_remaining` SET TAGS ('dbx_business_glossary_term' = 'Refills Remaining');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `sig` SET TAGS ('dbx_business_glossary_term' = 'Sig (Directions for Use)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `timestamp` SET TAGS ('dbx_business_glossary_term' = 'Prescription Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `timestamp` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `dispense_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dispense Event Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Pharmacist Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `formulary_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `formulary_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Location Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Dispense Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Dispense Cda Document Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Pharmacist Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `specialty_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `specialty_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `controlled_substance_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Tracking Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `controlled_substance_tracking_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `days_supply` SET TAGS ('dbx_business_glossary_term' = 'Days Supply');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_value_regex' = 'I|II|III|IV|V|non_controlled');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `dispense_status` SET TAGS ('dbx_business_glossary_term' = 'Dispense Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `dispense_status` SET TAGS ('dbx_value_regex' = 'completed|partial|cancelled|on_hold|stopped|entered_in_error');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `dispense_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispense Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `dispense_type` SET TAGS ('dbx_business_glossary_term' = 'Dispense Type');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `dispense_type` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|retail|specialty|mail_order|emergency');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `dispensed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Dispensed Quantity');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `dispensing_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Fee Amount');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `dispensing_location_name` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Location Name');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Medication Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `fill_number` SET TAGS ('dbx_business_glossary_term' = 'Fill Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `insurance_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `medication_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Medication Cost Amount');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{11}$|^[0-9]{5}-[0-9]{4}-[0-9]{2}$|^[0-9]{5}-[0-9]{3}-[0-9]{2}$|^[0-9]{4}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `patient_counseling_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Counseling Completed Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `patient_counseling_declined_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Counseling Declined Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `patient_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Patient Pay Amount');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `prescriber_dea_number` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Drug Enforcement Administration (DEA) Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `prescriber_dea_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{7}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `prescriber_dea_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `prescriber_npi` SET TAGS ('dbx_business_glossary_term' = 'Prescriber National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `prescriber_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `prescription_written_date` SET TAGS ('dbx_business_glossary_term' = 'Prescription Written Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `prescription_written_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `prescription_written_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `refills_remaining` SET TAGS ('dbx_business_glossary_term' = 'Refills Remaining');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `sig_text` SET TAGS ('dbx_business_glossary_term' = 'Sig (Signatura) Text');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `source_system_dispense_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Dispense Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `substitution_made_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Made Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `substitution_reason` SET TAGS ('dbx_business_glossary_term' = 'Substitution Reason');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `verifying_pharmacist_npi` SET TAGS ('dbx_business_glossary_term' = 'Verifying Pharmacist National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `verifying_pharmacist_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `mar_record_id` SET TAGS ('dbx_business_glossary_term' = 'Medication Administration Record (MAR) Record ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Administering Provider Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `dispense_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dispense Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Administering Provider Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `specialty_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `specialty_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `actual_administration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Administration Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `administration_method` SET TAGS ('dbx_business_glossary_term' = 'Administration Method');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `administration_site` SET TAGS ('dbx_business_glossary_term' = 'Administration Site');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `administration_status` SET TAGS ('dbx_business_glossary_term' = 'Administration Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `administration_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Administration Status Reason');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `barcode_scan_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Barcode Scan Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_value_regex' = 'I|II|III|IV|V|non-controlled');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `documentation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Documentation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `dose_given` SET TAGS ('dbx_business_glossary_term' = 'Dose Given');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `dose_unit` SET TAGS ('dbx_business_glossary_term' = 'Dose Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Medication Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `infusion_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Infusion Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `infusion_rate` SET TAGS ('dbx_business_glossary_term' = 'Infusion Rate');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `infusion_rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Infusion Rate Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `infusion_rate_unit` SET TAGS ('dbx_value_regex' = 'mL/hr|mL/min|units/hr|mcg/kg/min|mg/hr');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `is_first_dose` SET TAGS ('dbx_business_glossary_term' = 'Is First Dose Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `is_stat_order` SET TAGS ('dbx_business_glossary_term' = 'Is Stat Order Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Medication Lot Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `medication_ndc` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `medication_ndc` SET TAGS ('dbx_value_regex' = '^[0-9]{4,5}-[0-9]{3,4}-[0-9]{1,2}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `patient_response` SET TAGS ('dbx_business_glossary_term' = 'Patient Response');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `pharmacy_verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Verification Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `prn_indication` SET TAGS ('dbx_business_glossary_term' = 'Pro Re Nata (PRN) Indication');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `route` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `scheduled_administration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Administration Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `verifying_pharmacist_npi` SET TAGS ('dbx_business_glossary_term' = 'Verifying Pharmacist National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `verifying_pharmacist_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `waste_amount` SET TAGS ('dbx_business_glossary_term' = 'Waste Amount');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `waste_unit` SET TAGS ('dbx_business_glossary_term' = 'Waste Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `witness_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Provider Name');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `witness_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Witness Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `witness_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `controlled_substance_log_id` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Log ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `dea_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Dea Registration Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `dispense_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dispense Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `mar_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mar Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Test Result Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Cs Public Health Report Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Provider Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Pdmp Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `visit_procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Procedure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `adc_device_code` SET TAGS ('dbx_business_glossary_term' = 'Automated Dispensing Cabinet (ADC) Device ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `adc_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `adc_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `dea_form_222_number` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Form 222 Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_value_regex' = 'Schedule I|Schedule II|Schedule III|Schedule IV|Schedule V');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `discrepancy_reason` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Reason');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `drug_ndc` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `drug_ndc` SET TAGS ('dbx_value_regex' = '^[0-9]{5}-[0-9]{4}-[0-9]{2}$|^[0-9]{4}-[0-9]{4}-[0-9]{2}$|^[0-9]{5}-[0-9]{3}-[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `patient_mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `pdmp_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Prescription Drug Monitoring Program (PDMP) Reported Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `pdmp_reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Prescription Drug Monitoring Program (PDMP) Reported Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Transaction Quantity');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `running_balance` SET TAGS ('dbx_business_glossary_term' = 'Running Balance');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `storage_location` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'dispensing|administration|waste|return|transfer_in|transfer_out');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `transfer_destination` SET TAGS ('dbx_business_glossary_term' = 'Transfer Destination');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `transfer_source` SET TAGS ('dbx_business_glossary_term' = 'Transfer Source');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `waste_reason` SET TAGS ('dbx_business_glossary_term' = 'Waste Reason');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `witness_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Provider Name');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `witness_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Witness Provider National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `witness_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `adverse_drug_event_id` SET TAGS ('dbx_business_glossary_term' = 'Adverse Drug Event (ADE) ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Causative Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `code_set_version_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Confirming Test Result Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `contrast_admin_id` SET TAGS ('dbx_business_glossary_term' = 'Contrast Admin Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `dispense_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dispense Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Event Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Scheduling Appointment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `imaging_order_id` SET TAGS ('dbx_business_glossary_term' = 'Imaging Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Lab Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `mar_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mar Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Ade Public Health Report Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Reporter Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Clinical Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Visit Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `adverse_drug_event_status` SET TAGS ('dbx_business_glossary_term' = 'Adverse Drug Event (ADE) Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `adverse_drug_event_status` SET TAGS ('dbx_value_regex' = 'reported|under_investigation|investigation_complete|closed');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `causative_drug_ndc` SET TAGS ('dbx_business_glossary_term' = 'Causative Drug National Drug Code (NDC)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `causative_drug_ndc` SET TAGS ('dbx_value_regex' = '^[0-9]{4,5}-[0-9]{3,4}-[0-9]{1,2}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `contributing_factors` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factors');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `corrective_actions` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Taken');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'clinical_observation|patient_report|laboratory_result|automated_alert|chart_review|pharmacy_review');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Adverse Drug Event (ADE) Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Adverse Drug Event (ADE) Description');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Adverse Drug Event (ADE) Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adverse Drug Event (ADE) Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Adverse Drug Event (ADE) Type');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `fda_report_number` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Report Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `harm_category` SET TAGS ('dbx_business_glossary_term' = 'National Coordinating Council for Medication Error Reporting and Prevention (NCC MERP) Harm Category');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `intervention_description` SET TAGS ('dbx_business_glossary_term' = 'Intervention Description');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `intervention_required` SET TAGS ('dbx_business_glossary_term' = 'Intervention Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `ismp_report_number` SET TAGS ('dbx_business_glossary_term' = 'Institute for Safe Medication Practices (ISMP) Report Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Adverse Drug Event (ADE) Outcome');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'recovered|recovering|not_recovered|fatal|unknown');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `pharmacy_review_date` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy and Therapeutics (P&T) Committee Review Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `preventability_assessment` SET TAGS ('dbx_business_glossary_term' = 'Preventability Assessment');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `preventability_assessment` SET TAGS ('dbx_value_regex' = 'preventable|probably_preventable|not_preventable|unknown');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `reported_to_fda` SET TAGS ('dbx_business_glossary_term' = 'Reported to Food and Drug Administration (FDA) Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `reported_to_ismp` SET TAGS ('dbx_business_glossary_term' = 'Reported to Institute for Safe Medication Practices (ISMP) Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `reporter_role` SET TAGS ('dbx_business_glossary_term' = 'Reporter Role');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `root_cause_analysis_performed` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Performed Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `root_cause_findings` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Findings');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Adverse Drug Event (ADE) Severity Level');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'mild|moderate|severe|life_threatening|fatal');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Identifier');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `clinician_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `average_daily_usage` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Usage');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `average_daily_usage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `cycle_count_variance` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Variance');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `days_supply_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Days Supply On Hand');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_value_regex' = 'I|II|III|IV|V|non-controlled');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `formulary_status` SET TAGS ('dbx_business_glossary_term' = 'Formulary Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `formulary_status` SET TAGS ('dbx_value_regex' = 'formulary|non-formulary|restricted|preferred');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `high_alert_medication` SET TAGS ('dbx_business_glossary_term' = 'High Alert Medication');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'active|quarantined|recalled|expired|damaged|reserved');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `last_dispensed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dispensed Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `last_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Last Receipt Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `ndc` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `ndc` SET TAGS ('dbx_value_regex' = '^[0-9]{11}$|^[0-9]{5}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `par_level` SET TAGS ('dbx_business_glossary_term' = 'Par Level');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `quarantine_reason` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Reason');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Recall Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `shortage_indicator` SET TAGS ('dbx_business_glossary_term' = 'Shortage Indicator');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `shortage_indicator` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `storage_requirements` SET TAGS ('dbx_business_glossary_term' = 'Storage Requirements');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `storage_requirements` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Inventory Value');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `total_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `rx_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Claim ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Appeal Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `denial_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Denial Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `dispense_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dispense Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Pharmacy Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `imaging_order_id` SET TAGS ('dbx_business_glossary_term' = 'Imaging Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `claim_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `claim_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `patient_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `remittance_id` SET TAGS ('dbx_business_glossary_term' = 'Remittance Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `visit_procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Procedure Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `adjudication_date` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `bin_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `bin_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `claim_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_value_regex' = 'submitted|paid|rejected|reversed|pending|adjusted');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `cob_indicator` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Indicator');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `compound_indicator` SET TAGS ('dbx_business_glossary_term' = 'Compound Indicator');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `daw_code` SET TAGS ('dbx_business_glossary_term' = 'Dispense As Written (DAW) Code');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `days_supply` SET TAGS ('dbx_business_glossary_term' = 'Days Supply');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `dispensing_fee` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Fee');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `dispensing_pharmacy_ncpdp_number` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Pharmacy National Council for Prescription Drug Programs (NCPDP) ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `dispensing_pharmacy_ncpdp_number` SET TAGS ('dbx_value_regex' = '^[0-9]{7}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `dosage_form` SET TAGS ('dbx_business_glossary_term' = 'Dosage Form');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `dosage_form` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `drug_name` SET TAGS ('dbx_business_glossary_term' = 'Drug Name');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `drug_strength` SET TAGS ('dbx_business_glossary_term' = 'Drug Strength');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `fill_date` SET TAGS ('dbx_business_glossary_term' = 'Fill Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `group_number` SET TAGS ('dbx_business_glossary_term' = 'Group Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `ingredient_cost` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Cost');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}-[0-9]{4}-[0-9]{2}$|^[0-9]{11}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `patient_copay` SET TAGS ('dbx_business_glossary_term' = 'Patient Copay');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `pcn_number` SET TAGS ('dbx_business_glossary_term' = 'Processor Control Number (PCN)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `plan_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Plan Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `primary_payer_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Primary Payer Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `quantity_dispensed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Dispensed');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `refill_number` SET TAGS ('dbx_business_glossary_term' = 'Refill Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `reject_code` SET TAGS ('dbx_business_glossary_term' = 'National Council for Prescription Drug Programs (NCPDP) Reject Code');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `reject_description` SET TAGS ('dbx_business_glossary_term' = 'Reject Description');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `sales_tax` SET TAGS ('dbx_business_glossary_term' = 'Sales Tax');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `submission_clarification_code` SET TAGS ('dbx_business_glossary_term' = 'Submission Clarification Code');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `total_amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Paid');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `transaction_response_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Response Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `transaction_response_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|captured|duplicate');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `usual_and_customary_price` SET TAGS ('dbx_business_glossary_term' = 'Usual and Customary (U&C) Price');
