-- Schema for Domain: pharmacy | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 14:11:17

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`pharmacy` COMMENT 'Owns the medication lifecycle from prescribing through dispensing and administration. Manages formulary, NDC (National Drug Code) drug master, MAR (Medication Administration Record), medication reconciliation, controlled substance tracking (DEA Schedule), adverse drug event monitoring, pharmacy inventory, and prescription fulfillment. Sourced from Epic Willow and Cerner PharmNet.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` (
    `drug_master_id` BIGINT COMMENT 'Unique identifier for the drug master record. Primary key for the drug master product.',
    `compliance_program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: REMS programs, DEA controlled substance schedules, and FDA risk management programs are compliance programs that govern specific drugs. Real process: REMS enrollment verification requires linking drug',
    `terminology_mapping_id` BIGINT COMMENT 'Foreign key linking to interoperability.terminology_mapping. Business justification: Drug master NDC/RxNorm codes mapped to SNOMED, ATC for clinical data exchange. Real business process: medication terminology harmonization, HIE data quality, clinical decision support, international d',
    `ndc_drug_id` BIGINT COMMENT 'add column reference_ndc_drug_id (BIGINT) with FK to reference.ndc_drug.ndc_drug_id - drug_master is the pharmacy operational drug record but lacks a direct FK to the reference NDC code set, relying only on interoperability.terminology_mapp',
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
    `snomed_code` STRING COMMENT 'The SNOMED CT concept identifier for the drug, enabling standardized clinical terminology and interoperability with Electronic Health Record (EHR) systems.',
    `storage_temperature_range` STRING COMMENT 'The recommended temperature range for proper storage of the drug to maintain potency and safety (e.g., 2-8°C, 15-30°C, Room Temperature).',
    `strength` STRING COMMENT 'The amount of active pharmaceutical ingredient per dosage unit, expressed with numeric value and unit of measure (e.g., 500 mg, 10 mg/mL, 0.5%).',
    `tall_man_lettering` STRING COMMENT 'The drug name displayed with mixed-case capitalization to emphasize differences between look-alike drug names and reduce medication errors (e.g., hydrOXYzine vs hydrALAzine).',
    `therapeutic_category` STRING COMMENT 'The clinical therapeutic category indicating the primary disease state or condition the drug is used to treat (e.g., Cardiovascular, Antibiotic, Analgesic, Antidiabetic).',
    `unit_of_measure` STRING COMMENT 'The standard unit used to quantify the drug for inventory, dispensing, and administration purposes (e.g., Each, Milliliter, Gram, Vial, Patch).',
    CONSTRAINT pk_drug_master PRIMARY KEY(`drug_master_id`)
) COMMENT 'Authoritative pharmacy drug master for every medication managed within the organization. Captures NDC (National Drug Code), drug name (generic and brand), drug class, DEA schedule, dosage form, strength, route of administration, unit of measure, therapeutic category, formulary status, controlled substance indicator, hazardous drug flag, tall-man lettering, ISMP high-alert flag, look-alike/sound-alike (LASA) indicators, and regulatory approval metadata. Serves as the pharmacy-owned SSOT for drug attributes consumed by prescribing, dispensing, administration, and inventory workflows. Distinct from reference domain NDC code sets — this product adds pharmacy-operational attributes (formulary status, ISMP flags, hazardous drug classification). Sourced from Epic Willow and Cerner PharmNet drug dictionaries.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` (
    `formulary_id` BIGINT COMMENT 'Unique identifier for the formulary entry. Primary key for the formulary product.',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or hospital system for which this formulary is defined. Supports facility-specific formulary management.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Formulary decisions are governed by P&T committee policies (prior auth criteria, step therapy protocols). Real process: formulary management requires linking formulary entries to governing policies fo',
    `drug_master_id` BIGINT COMMENT 'Reference to the drug master record containing NDC (National Drug Code), drug name, strength, dosage form, and therapeutic class.',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Formulary management requires linking coverage rules to standardized NDC drug definitions for tier assignment, prior authorization criteria, and therapeutic interchange decisions. Essential for payer ',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Formulary rules for specialty drugs administered in clinical settings (e.g., infusion therapy, chemotherapy) require CPT code linkage for procedure-based coverage determination. Essential for buy-and-',
    `regulatory_change_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_change. Business justification: Formulary policies must adapt to regulatory changes (new coverage mandates, step therapy restrictions). Real process: formulary updates document which regulatory changes drove policy modifications for',
    `terminology_mapping_id` BIGINT COMMENT 'Foreign key linking to interoperability.terminology_mapping. Business justification: Formulary drug codes (NDC, RxNorm) mapped to standard terminologies for interoperability. Real business process: semantic interoperability, formulary data exchange standardization, payer formulary fil',
    `health_plan_id` BIGINT COMMENT 'add column insurance_health_plan_id (BIGINT) with FK to insurance.health_plan.health_plan_id - formularies are plan-specific but formulary only links to facility.care_site; health plan association is critical for PBM operations',
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
    `formulary_status` STRING COMMENT 'Current lifecycle status of this formulary entry. Active entries are in effect, inactive are not currently used, pending are awaiting approval.. Valid values are `active|inactive|pending|suspended|archived`',
    `step_therapy_protocol` STRING COMMENT 'Description of the step therapy protocol, including which alternative medications must be tried first and for how long before this drug is covered.',
    `step_therapy_required` BOOLEAN COMMENT 'Indicates whether step therapy (trial of alternative medications) is required before this drug is covered. True if step therapy protocol must be followed.',
    `therapeutic_alternative_available` BOOLEAN COMMENT 'Indicates whether therapeutic alternatives (drugs with similar clinical effect) are available on the formulary. True if alternatives exist.',
    `therapeutic_class_code` STRING COMMENT 'Standardized therapeutic class code for the drug (e.g., AHFS, ETC, or internal classification). Used for formulary management and therapeutic interchange.',
    `tier` STRING COMMENT 'The tier classification of the drug within the formulary, determining patient cost-sharing and coverage level. Tier 1 typically has lowest cost-sharing, Tier 5 for specialty drugs.. Valid values are `tier_1_preferred_generic|tier_2_generic|tier_3_preferred_brand|tier_4_non_preferred_brand|tier_5_specialty|not_covered`',
    `formulary_type` STRING COMMENT 'Type or category of formulary, typically aligned with payer type or benefit plan category (e.g., commercial, Medicare Part D, Medicaid).. Valid values are `commercial|medicare_part_d|medicaid|exchange|employer_group|specialty`',
    `version` STRING COMMENT 'Version identifier for the formulary, used to track changes and updates over time (e.g., 2024.1, Q1-2024).',
    CONSTRAINT pk_formulary PRIMARY KEY(`formulary_id`)
) COMMENT 'Defines the approved drug formulary for each health plan, payer, or facility tier. Captures formulary tier (preferred/non-preferred/specialty), prior authorization requirements, step therapy requirements, quantity limits, formulary effective and expiration dates, therapeutic alternatives, payer-specific coverage rules, and specialty drug classification. Supports formulary management, clinical decision support at point of prescribing, and prescription adjudication. Benefit plan financial details (copay/coinsurance schedules, deductible applicability, mail-order benefit rules) are sourced from the billing domain; this product owns drug-level coverage and access rules only. Sourced from Epic Willow and Cerner PharmNet formulary modules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` (
    `prescription_id` BIGINT COMMENT 'Unique identifier for the prescription record. Primary key.',
    `care_transition_notification_id` BIGINT COMMENT 'Foreign key linking to interoperability.care_transition_notification. Business justification: New prescriptions trigger ADT notifications to care coordinators, PCPs. Real business process: care coordination, medication reconciliation alerts, high-risk medication monitoring, transitions of care',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Prescriptions generate medical claims for provider visits where prescriptions are written. Claims adjudication validates prescription details for coverage determination, fraud detection, and coordinat',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Prescriptions generate pharmacy costs tracked by cost center for departmental P&L, budget variance analysis, and operational accounting. Essential for pharmacy service line financial reporting and cos',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_diagnosis. Business justification: Prescriptions must link to diagnoses for prior authorization, formulary compliance, and medical necessity documentation. Required for payer adjudication, quality measure reporting, and regulatory comp',
    `employee_id` BIGINT COMMENT 'The system user ID of the person who last modified this prescription record. Used for audit trail and accountability.',
    `direct_message_id` BIGINT COMMENT 'Foreign key linking to interoperability.direct_message. Business justification: E-prescriptions transmitted via Direct messaging to retail/specialty pharmacies. Real business process: secure prescription routing (HIPAA-compliant alternative to Surescripts), specialty pharmacy coo',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: E-prescribing generates HL7/NCPDP SCRIPT messages tracked in message_log. Real business process: tracking eRx transmission success/failure for clinical workflow, EPCS compliance, Surescripts reconcili',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Prescriptions require ICD-10 diagnosis linkage for medical necessity validation, prior authorization processing, and off-label use documentation. Essential for payer coverage determination and clinica',
    `lab_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_order. Business justification: Prescribing decisions require lab results for renal/hepatic dosing adjustments, therapeutic drug monitoring, and culture-directed antibiotic therapy. Clinical decision support workflow standard in EHR',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Retail and specialty pharmacies dispense durable medical equipment (DME), prosthetics, orthotics, diabetic supplies, and respiratory equipment that require prescription authorization. These items foll',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Prescriptions must reference standardized NDC definitions for drug identification, dispensing validation, formulary checking, and pharmacy claims processing. Core to e-prescribing workflows and medica',
    `original_prescription_id` BIGINT COMMENT 'Reference to the original prescription record if this is a refill, renewal, or change. Null for new prescriptions. Enables tracking of prescription history and refill chains.',
    `pharmacy_location_id` BIGINT COMMENT 'Reference to the pharmacy location designated to dispense this prescription. May be null if no specific pharmacy has been selected.',
    `hie_query_id` BIGINT COMMENT 'Foreign key linking to interoperability.hie_query. Business justification: Prescribers query HIE for patient medication history before writing prescriptions (PDMP integration, duplicate therapy checking). Real business process: clinical decision support, opioid stewardship, ',
    `clinician_id` BIGINT COMMENT 'Reference to the provider who wrote this prescription. Links to the provider master.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom this prescription was written. Links to the patient master.',
    `prescription_patient_mpi_record_id` BIGINT COMMENT 'FK to patient.mpi_record.mpi_record_id — Prescriptions must link to the patient for medication reconciliation, drug interaction checking, and longitudinal medication history. Required for patient safety.',
    `prescription_prescriber_clinician_id` BIGINT COMMENT 'FK to provider.clinician.clinician_id — Every prescription must identify the prescribing provider for DEA compliance, controlled substance tracking, and clinical accountability. Required by state pharmacy boards and CMS.',
    `promoting_interoperability_id` BIGINT COMMENT 'Foreign key linking to interoperability.promoting_interoperability. Business justification: E-prescribing volume tracked for PI measure attestation (e-Prescribing objective). Real business process: meaningful use compliance, MIPS scoring, e-prescribing measure reporting, CMS quality payment ',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Clinical trials prescribe investigational drugs through standard prescription workflow. Protocol compliance, adverse event correlation, and FDA regulatory reporting (21 CFR 312) require linking prescr',
    `scheduling_appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: Prescriptions are frequently written during appointments. Tracking this enables medication reconciliation workflows, prescription-to-visit analytics for quality measures, and supports e-prescribing au',
    `treatment_consent_id` BIGINT COMMENT 'Foreign key linking to consent.treatment_consent. Business justification: Prescriptions for procedures/treatments requiring informed consent (chemotherapy, high-risk medications, off-label use) must link to the documented treatment consent for regulatory compliance (Joint C',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which this prescription was written. May be null for outpatient prescriptions written outside of a visit context.',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Prescriptions originate from clinical orders in CPOE workflows. This link enables e-prescribing traceability, medication reconciliation, clinical decision support alerts, and regulatory audit trails r',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this prescription record was first created in the system. Used for audit trail and data lineage tracking.',
    `prescription_date` DATE COMMENT 'The date on which the prescription was written by the prescriber. This is the authoritative date for prescription validity and expiration calculations.',
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
    `medication_name` STRING COMMENT 'The name of the prescribed medication, typically the generic or brand name as entered by the prescriber.',
    `ndc` STRING COMMENT 'The 11-digit National Drug Code identifying the specific drug product, labeler, and package size. Standard format for drug identification in the United States.. Valid values are `^[0-9]{11}$|^[0-9]{5}-[0-9]{4}-[0-9]{2}$`',
    `number` STRING COMMENT 'The externally-known prescription number or control number assigned by the pharmacy system. Used for prescription tracking, refill requests, and patient communication.',
    `pharmacy_notes` STRING COMMENT 'Free-text notes entered by pharmacy staff regarding this prescription. May include clarifications, patient counseling notes, or special handling instructions.',
    `prescriber_dea_number` STRING COMMENT 'The DEA registration number of the prescriber, required for prescribing controlled substances. Format: two letters followed by seven digits.. Valid values are `^[A-Z]{2}[0-9]{7}$`',
    `prescriber_notes` STRING COMMENT 'Free-text notes entered by the prescriber regarding this prescription. May include clinical rationale, special instructions, or patient-specific considerations.',
    `prior_authorization_number` STRING COMMENT 'The authorization number issued by the insurance payer approving coverage for this prescription. Null if no prior authorization was required or obtained.',
    `prior_authorization_required_flag` BOOLEAN COMMENT 'Indicates whether insurance prior authorization is required before this prescription can be filled. True if prior auth is needed; false otherwise.',
    `quantity_prescribed` DECIMAL(18,2) COMMENT 'The total quantity of medication prescribed, expressed in the unit appropriate to the dosage form (e.g., number of tablets, milliliters of liquid).',
    `quantity_unit` STRING COMMENT 'The unit of measure for the prescribed quantity (e.g., tablets, capsules, mL, grams).',
    `refills_authorized` STRING COMMENT 'The number of refills authorized by the prescriber. Zero indicates no refills allowed. Controlled substances have regulatory limits on refill counts.',
    `refills_remaining` STRING COMMENT 'The number of refills remaining on this prescription. Decremented each time the prescription is filled.',
    `route_of_administration` STRING COMMENT 'The path by which the medication is administered to the patient (e.g., oral, intravenous, topical). [ENUM-REF-CANDIDATE: oral|intravenous|intramuscular|subcutaneous|topical|inhalation|rectal|transdermal|sublingual|ophthalmic|otic|nasal — 12 candidates stripped; promote to reference product]',
    `sig` STRING COMMENT 'The prescribers instructions to the patient on how to take the medication. Free-text field containing dosing frequency, timing, and special instructions (e.g., Take 1 tablet by mouth twice daily with food).',
    `prescription_status` STRING COMMENT 'The current lifecycle status of the prescription. Active prescriptions may be filled; discontinued prescriptions have been stopped by the prescriber; expired prescriptions have passed their expiration date; on-hold prescriptions are temporarily suspended. [ENUM-REF-CANDIDATE: active|discontinued|expired|on-hold|completed|cancelled|entered-in-error — 7 candidates stripped; promote to reference product]',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Indicates whether generic substitution is permitted by the prescriber. True allows the pharmacist to dispense a generic equivalent; false requires dispensing as written (DAW).',
    `timestamp` TIMESTAMP COMMENT 'The precise date and time when the prescription was written and entered into the system. Used for audit trails and CPOE (Computerized Physician Order Entry) compliance.',
    `prescription_type` STRING COMMENT 'Classifies the prescription transaction type. New indicates first-time prescription; refill indicates subsequent fill of existing prescription; renewal indicates new prescription for same medication after previous expired; transfer indicates prescription moved between pharmacies; change indicates modification to existing prescription.. Valid values are `new|refill|renewal|transfer-in|transfer-out|change`',
    CONSTRAINT pk_prescription PRIMARY KEY(`prescription_id`)
) COMMENT 'Core transactional record representing a medication order written by an authorized prescriber for a patient. Captures MRN, prescriber NPI, drug name, NDC, sig (directions), quantity prescribed, days supply, refills authorized, prescribing date, indication (ICD-10), prescription status (active/discontinued/expired/on-hold), e-prescribing transmission status, DEA number for controlled substances, and EPCS (Electronic Prescribing of Controlled Substances) compliance flag. Sourced from Epic Willow and Cerner PharmNet. Governance note: this product has 27 outgoing foreign keys, above the recommended maximum of 25; consider splitting into multiple products or refactoring as a junction table.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` (
    `dispense_event_id` BIGINT COMMENT 'Unique identifier for each medication dispensing event. Primary key for the dispense event transaction.',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Pharmacy dispense events in facility settings (inpatient, clinic-administered medications) generate facility claims. Hospitals bill medications as part of facility claims using revenue codes. Links di',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Dispensing events incur direct costs (pharmacist labor, dispensing fees, overhead) allocated to pharmacy cost centers for operational cost accounting, productivity analysis, and departmental budgeting',
    `demographics_id` BIGINT COMMENT 'Reference to the patient receiving the dispensed medication. Links to patient master record.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_diagnosis. Business justification: Pharmacy dispensing systems validate diagnosis codes for restricted medications and prior authorization requirements. Required for REMS compliance, controlled substance monitoring, and payer claim adj',
    `care_transition_notification_id` BIGINT COMMENT 'Foreign key linking to interoperability.care_transition_notification. Business justification: Dispense events at discharge trigger notifications to post-acute providers. Real business process: transitions of care, medication continuity, discharge medication reconciliation, SNF/home health noti',
    `cda_document_id` BIGINT COMMENT 'Foreign key linking to interoperability.cda_document. Business justification: Dispense events documented in CDA Medication Dispense documents for care transitions, discharge summaries. Real business process: continuity of care, medication reconciliation at transitions, post-acu',
    `fhir_resource_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.fhir_resource_log. Business justification: FHIR MedicationDispense resources logged for payer-to-payer exchange, patient access APIs. Real business process: CMS Interoperability Rule compliance, patient medication history access, payer data ex',
    `interface_channel_id` BIGINT COMMENT 'Foreign key linking to interoperability.interface_channel. Business justification: Dispense event messages routed through payer/PDMP interface channels. Real business process: claims submission routing, PDMP reporting channel management, payer connectivity monitoring, real-time bene',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: Dispense events trigger outbound messages (ADT, pharmacy claims, PDMP reports) to payers, HIEs, state agencies. Real business process: real-time benefit verification, PDMP reporting compliance, claims',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Dispensing pharmacist is a licensed clinician. Pharmacy operations require tracking which clinician dispensed medication for regulatory compliance, audit trails, quality assurance, and liability. NPI ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: State pharmacy boards require linking dispensing events to licensed employee pharmacists for audits, credentialing verification, and diversion monitoring. Essential for labor cost allocation and produ',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Each dispense event dispenses a specific drug from the drug master. Cardinality N:1 (many dispense events for one drug). The medication_name can be retrieved from drug_master via JOIN. The ndc_code is',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Dispense events must reference the specific health plan for benefit determination (copay, coinsurance, deductible application, formulary tier). Plan-specific rules govern coverage and patient cost-sha',
    `lab_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_order. Business justification: Pharmacist verification protocols require checking lab values before dispensing high-alert medications (warfarin/INR, vancomycin/levels, chemotherapy/CBC). Medication safety standard enforced by Joint',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Pharmacy dispenses medical supplies (diabetic testing supplies, ostomy supplies, wound care products, nebulizers) alongside medications. Dispense events must track both drug and supply dispensing for ',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Dispense events require direct NDC reference for PDMP reporting, DEA compliance, pharmacy claims adjudication, and drug recall tracking. Regulatory mandate for controlled substance monitoring and stat',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Pharmacy claims adjudication requires payer identification for real-time eligibility verification, formulary checks, and payment processing at point of dispense. Every dispensing event in retail/outpa',
    `pharmacy_location_id` BIGINT COMMENT 'Reference to the pharmacy location or facility where the medication was dispensed. Links to facility master data.',
    `phi_access_log_id` BIGINT COMMENT 'Foreign key linking to compliance.phi_access_log. Business justification: Every dispense event is a PHI access that must be logged for HIPAA audit trails. Real process: access monitoring systems link dispense transactions to access logs for anomaly detection and audit respo',
    `prescription_id` BIGINT COMMENT 'Reference to the prescription order that authorized this dispensing event. Links to the prescription master record.',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Investigational product dispensing must link to study for drug accountability per 21 CFR Part 312, regulatory inspections, and coverage analysis (Medicare NCD 310.1). Distinguishes research dispensing',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter or visit during which this medication was dispensed. May be null for outpatient retail dispensing.',
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
    `prior_authorization_number` STRING COMMENT 'Insurance prior authorization reference number when required for coverage of the dispensed medication. Links to payer approval for high-cost or restricted medications.',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Medication administration by nurses/providers must link to employee for competency assessment, incident investigation, labor cost allocation to patient care, and regulatory compliance (Joint Commissio',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Inpatient medication administration (MAR) drives facility claim line items. Hospitals bill for administered medications via claim lines with revenue codes. Essential for claim substantiation, medical ',
    `clinical_order_id` BIGINT COMMENT 'Unique identifier for the clinical order that authorized this medication administration.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_diagnosis. Business justification: Medication administration records reference diagnosis being treated for documentation and billing compliance. Required for medication administration documentation standards and charge capture validati',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Each MAR record documents administration of a specific drug from the drug master. Cardinality N:1 (many MAR records for one drug). The medication_name can be retrieved from drug_master via JOIN. The m',
    `lab_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_order. Business justification: Nursing protocols mandate lab verification before administering specific medications (potassium levels before IV potassium, glucose before insulin, INR before warfarin). Standard nursing practice docu',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the patient who received the medication. Links to the patient master.',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Medication administration records need NDC linkage for barcode medication administration (BCMA) validation, regulatory reporting to CMS, and adverse event tracking. Required for Joint Commission medic',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Medication administration in trials must track protocol schedule compliance. Administration timing/adherence are efficacy endpoints; deviations trigger protocol deviation reports. Required for GCP com',
    `visit_id` BIGINT COMMENT 'Unique identifier for the patient encounter or visit during which the medication was administered.',
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
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: DEA audits specifically target controlled substance logs for diversion detection and compliance verification. Real process: audit findings reference specific log entries as evidence of discrepancies o',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility where the controlled substance transaction occurred.',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Controlled substance dispensing events are billed via claims. Regulatory compliance (DEA, state boards) requires linking dispensing logs to claim submissions for audit trails, diversion monitoring, an',
    `clinical_order_id` BIGINT COMMENT 'Reference to the clinical order (CPOE) that authorized the controlled substance transaction. Null for waste or transfer transactions.',
    `public_health_report_id` BIGINT COMMENT 'Foreign key linking to interoperability.public_health_report. Business justification: Controlled substance dispensing reported to state PDMPs. Real business process: opioid epidemic monitoring, prescription drug monitoring program compliance, DEA ARCOS reporting, state health departmen',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Each controlled substance transaction references a specific drug in the drug master. Cardinality N:1 (many log entries for one drug). The drug_name can be retrieved from drug_master via JOIN. No bidir',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: DEA Form 222 reporting and controlled substance inventory reconciliation require standardized NDC reference. Mandatory for DEA audits, diversion monitoring, and automated dispensing cabinet (ADC) disc',
    `patient_safety_event_id` BIGINT COMMENT 'Foreign key linking to quality.patient_safety_event. Business justification: Controlled substance discrepancies, overrides, and suspected diversion events trigger mandatory patient safety event reporting. Quality teams investigate CS log anomalies as safety events for regulato',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: PDMP reporting generates HL7 messages tracked for state compliance. Real business process: state-mandated controlled substance reporting (ASAP standard), opioid stewardship, DEA audit compliance, tran',
    `pharmacy_location_id` BIGINT COMMENT 'Foreign key linking to pharmacy.location. Business justification: Controlled substances are stored and tracked at specific pharmacy locations. Cardinality N:1 (many log entries at one location). The storage_location is kept as it represents a sub-location within the',
    `prescription_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prescription. Business justification: Controlled substance transactions are often linked to prescriptions for audit trail purposes. Cardinality N:1 (many log entries for one prescription). The prescription_number is kept as the business i',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: DEA requires separate accountability for investigational controlled substances in clinical trials. Audits trace study drug from receipt through administration/disposal per protocol. Essential for regu',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Responsible provider is a licensed clinician. DEA compliance requires tracking which licensed provider is responsible for controlled substance transactions. FK enables DEA registration verification an',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: DEA requires tracking which employee accessed controlled substances for diversion monitoring. Essential for regulatory audits, internal investigations, and compliance with 21 CFR Part 1301 controlled ',
    `substance_use_consent_id` BIGINT COMMENT 'Foreign key linking to consent.substance_use_consent. Business justification: Controlled substance dispensing in substance use disorder (SUD) treatment programs (methadone clinics, buprenorphine programs) requires 42 CFR Part 2 consent for disclosure of patient-identifying info',
    `visit_id` BIGINT COMMENT 'Reference to the patient encounter (visit, admission) during which the controlled substance transaction occurred. Null for non-patient transactions.',
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
    `public_health_report_id` BIGINT COMMENT 'Foreign key linking to interoperability.public_health_report. Business justification: ADEs reported to FDA MedWatch, state health departments. Real business process: pharmacovigilance, public health surveillance, FDA adverse event reporting, medication safety monitoring, post-market dr',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Adverse drug events are caused by specific drugs in the drug master. The FK is labeled causative_drug_master_id to distinguish from potential other drug references. Cardinality N:1. The causative_dr',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Adverse drug events trigger claims for treatment of the adverse event (ED visits, hospitalizations, additional medications). Claims analysis identifies drug safety patterns, cost impact of ADEs, and p',
    `compliance_regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Serious adverse drug events require FDA MedWatch reporting (mandatory regulatory submission). Real process: ADE triggers creation of regulatory submission; link tracks submission status and acknowledg',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: ADE investigations, root cause analyses, and corrective actions consume pharmacy quality/safety resources tracked by cost center for patient safety program cost accounting and quality improvement ROI ',
    `demographics_id` BIGINT COMMENT 'Reference to the patient who experienced the adverse drug event.',
    `hotline_report_id` BIGINT COMMENT 'Foreign key linking to compliance.hotline_report. Business justification: ADEs may be reported via compliance hotline (especially if preventable/negligence suspected). Real process: patient safety hotline intake creates report; link tracks which ADEs originated from hotline',
    `improvement_initiative_id` BIGINT COMMENT 'Foreign key linking to quality.improvement_initiative. Business justification: ADEs are primary triggers for quality improvement initiatives (medication safety programs, high-alert drug protocols, ISMP recommendations). Quality teams launch initiatives based on ADE patterns and ',
    `investigation_id` BIGINT COMMENT 'Foreign key linking to compliance.investigation. Business justification: Serious ADEs trigger compliance investigations for root cause analysis and preventability assessment. Real process: patient safety investigations examine ADE circumstances; link tracks investigation f',
    `lab_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_order. Business justification: ADE root cause analysis requires linking to lab results that detected the adverse event (elevated liver enzymes for hepatotoxicity, creatinine for nephrotoxicity). Required for FDA MedWatch reporting ',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: FDA MedWatch reporting and pharmacovigilance surveillance require NDC-level drug identification for adverse event submissions. Essential for patient safety reporting, ISMP medication error tracking, a',
    `patient_safety_event_id` BIGINT COMMENT 'Foreign key linking to quality.patient_safety_event. Business justification: ADEs are a category of patient safety events tracked by quality teams for root cause analysis, regulatory reporting (TJC, CMS), and harm assessment. Quality committees review ADEs as safety events for',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Reporter is often a licensed clinician. Adverse drug event reporting requires tracking reporter identity for follow-up, quality improvement, and regulatory reporting. FK enables linking ADE reports to',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: ADE reporting requires tracking which employee identified/reported event for quality improvement, competency assessment, and regulatory submissions (FDA MedWatch, state boards). Essential for patient ',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Pharmacy-detected ADEs during trials require immediate study linkage for expedited reporting to sponsor/IRB/FDA per 21 CFR 312.32. Causality assessment references study protocol; serious unexpected ev',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_diagnosis. Business justification: ADEs may result in new diagnoses (drug-induced hepatitis, anaphylaxis, Stevens-Johnson syndrome) that must be documented and coded. Required for patient safety reporting, quality measures, and HAC pre',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which the adverse drug event was identified or occurred.',
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
    `adverse_drug_event_status` STRING COMMENT 'Current status of the adverse drug event record in the investigation and resolution workflow: reported, under investigation, investigation complete, or closed.. Valid values are `reported|under_investigation|investigation_complete|closed`',
    `created_by` STRING COMMENT 'User identifier or name of the individual who created the adverse drug event record in the system.',
    CONSTRAINT pk_adverse_drug_event PRIMARY KEY(`adverse_drug_event_id`)
) COMMENT 'Operational record of adverse drug events (ADEs), adverse drug reactions (ADRs), and medication errors identified during patient care. Captures event date and time, patient reference, causative drug (NDC), event type (allergic reaction/toxicity/medication error/near-miss), severity level, harm category (NCC MERP index), contributing factors, reporter NPI, encounter reference, root cause analysis findings, and corrective actions taken. Supports pharmacovigilance, FDA MedWatch reporting, ISMP medication error reporting, and pharmacy P&T committee safety reviews. Sourced from Epic Willow and Cerner PharmNet.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` (
    `inventory_id` BIGINT COMMENT 'Primary key for inventory',
    `care_site_id` BIGINT COMMENT 'Identifier for the healthcare facility where this inventory is located (hospital, clinic, outpatient pharmacy).',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Each inventory record tracks a specific drug from the drug master. Cardinality N:1 (many inventory records for one drug across locations/lots). The drug_name, drug_strength, dosage_form, and therapeut',
    `investigational_product_id` BIGINT COMMENT 'Foreign key linking to research.investigational_product. Business justification: Pharmacy inventory systems must track investigational products separately from commercial stock for drug accountability, temperature monitoring, expiration management, and regulatory inspection readin',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Pharmacy inventory management assigned to specific employees for accountability in variance investigation, controlled substance reconciliation (DEA requirement), and financial controls. Essential for ',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Pharmacy inventory includes medical supplies and devices (syringes, IV supplies, diabetic testing supplies, spacers, peak flow meters) stored alongside medications. Pharmacy inventory management syste',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Pharmacy inventory management requires NDC linkage for drug procurement, FDA recall response, expiration tracking, and 340B program compliance. Critical for automated reorder systems and drug shortage',
    `pharmacy_location_id` BIGINT COMMENT 'Identifier for the specific storage location within the facility (inpatient pharmacy, outpatient pharmacy, automated dispensing cabinet, emergency department, operating room, intensive care unit).',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Pharmacy inventory must track which vendor supplies each drug. Currently has manufacturer_name as text, but vendor relationship provides complete vendor details (contact, terms, status). Normalizes ve',
    `average_daily_usage` DECIMAL(18,2) COMMENT 'The calculated average quantity of this medication dispensed per day over a rolling period (typically 30, 60, or 90 days). Used for demand forecasting and reorder calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this inventory record was first created in the source system.',
    `cycle_count_variance` DECIMAL(18,2) COMMENT 'The difference between the system quantity and physical count from the last cycle count (positive indicates overage, negative indicates shortage).',
    `days_supply_on_hand` STRING COMMENT 'The estimated number of days the current on-hand quantity will last based on average daily usage. Used for inventory planning and shortage prevention.',
    `dea_schedule` STRING COMMENT 'The DEA controlled substance schedule classification (I, II, III, IV, V, or non-controlled) indicating the drugs potential for abuse and regulatory requirements.. Valid values are `I|II|III|IV|V|non-controlled`',
    `expiration_date` DATE COMMENT 'The date beyond which the medication should not be used, as determined by the manufacturer. Critical for patient safety and waste management.',
    `formulary_status` STRING COMMENT 'Indicates whether the drug is on the hospital formulary and any restrictions on its use (formulary, non-formulary, restricted, preferred).. Valid values are `formulary|non-formulary|restricted|preferred`',
    `high_alert_medication` BOOLEAN COMMENT 'Flag indicating whether this medication is classified as high-alert by ISMP, requiring additional safety precautions due to increased risk of significant patient harm if used in error.',
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
    `inventory_status` STRING COMMENT 'The current disposition of the inventory (active/available, quarantined pending quality review, recalled by manufacturer or FDA, expired, damaged, reserved for specific patient or procedure).. Valid values are `active|quarantined|recalled|expired|damaged|reserved`',
    `storage_requirements` STRING COMMENT 'Special storage conditions required for this medication (e.g., refrigeration 2-8°C, room temperature, protect from light, controlled room temperature).',
    `total_value` DECIMAL(18,2) COMMENT 'The total dollar value of the on-hand quantity (quantity_on_hand × unit_cost). Used for financial reporting and asset management.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The acquisition cost per unit of measure. Used for inventory valuation, budgeting, and financial reporting.',
    `unit_of_measure` STRING COMMENT 'The unit in which inventory quantity is tracked (each, tablet, capsule, vial, ampule, bottle, tube, box, milliliter, liter, gram, milligram). [ENUM-REF-CANDIDATE: each|tablet|capsule|vial|ampule|bottle|tube|box|mL|L|g|mg — 12 candidates stripped; promote to reference product]',
    CONSTRAINT pk_inventory PRIMARY KEY(`inventory_id`)
) COMMENT 'Real-time and periodic snapshot of medication inventory levels and movement history across all pharmacy locations including inpatient, outpatient, and automated dispensing cabinets. Captures drug NDC, location, on-hand quantity, reorder point, par level, lot number, expiration date, unit cost, inventory status (active/quarantined/recalled/expired), shortage indicators, and transaction history (receipts, returns, waste, transfers, cycle count adjustments). Supports medication availability, drug shortage management, supply chain integration, waste reduction, and full inventory audit trail. Sourced from Epic Willow and Cerner PharmNet.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` (
    `medication_pa_request_id` BIGINT COMMENT 'Unique identifier for the medication prior authorization request.',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to claim.prior_authorization. Business justification: Medication prior authorizations in pharmacy domain link to claim-level prior authorizations for unified authorization tracking. Payers manage pharmacy and medical authorizations in integrated systems.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Prior authorization requests must link to standardized ICD-10 codes for clinical indication validation and payer medical necessity review. Required for automated PA decision support and specialty phar',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Prior authorization requests are triggered by medication orders requiring payer approval. This link supports PA workflow automation, denial management, appeal processes, and tracking authorization sta',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Prior authorization requests consume significant administrative resources (pharmacist time, documentation) tracked by cost center for operational cost management and productivity analysis. Essential f',
    `demographics_id` BIGINT COMMENT 'Reference to the patient for whom the medication prior authorization is being requested.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_diagnosis. Business justification: Prior authorization requests require diagnosis codes to justify medical necessity. Regulatory requirement for payer adjudication. Reuses existing clinical_indication_icd10 field pattern but formalizes',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Each prior authorization request is for a specific drug from the drug master. Cardinality N:1 (many PA requests for one drug). The drug_name, drug_strength, and drug_form can be retrieved from drug_ma',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Prior authorization workflow requires linking to specific patient coverage record to validate formulary tier, benefit limits, and payer-specific PA criteria. Payer_id alone insufficient—need member-sp',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Prior authorization requests must reference standardized NDC for payer adjudication systems, formulary exception processing, and specialty pharmacy benefit verification. Required for electronic prior ',
    `direct_message_id` BIGINT COMMENT 'Foreign key linking to interoperability.direct_message. Business justification: PA supporting documentation (labs, clinical notes) transmitted to payers via Direct. Real business process: PA workflow acceleration, secure document exchange, specialty medication approval, clinical ',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: Prior authorization requests/responses exchanged via HL7/X12 278 transactions. Real business process: PA workflow tracking, turnaround time monitoring, payer integration troubleshooting, approval/deni',
    `public_health_report_id` BIGINT COMMENT 'Foreign key linking to interoperability.public_health_report. Business justification: PA denials for specialty medications reported to state agencies for access monitoring. Real business process: healthcare equity surveillance, formulary access oversight, specialty medication availabil',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer or health plan to which the prior authorization request is being submitted.',
    `population_health_gap_id` BIGINT COMMENT 'Foreign key linking to quality.population_health_gap. Business justification: PA denials/delays create documented care gaps in HEDIS/STARS measures (medication adherence, diabetes control). Quality teams track PA barriers as gap closure obstacles and report PA-related gaps to p',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Prescriber is a licensed clinician. Prior authorization requests originate from prescribing clinician and require clinician identification for payer communication, approval workflow, and prescribing a',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Prior authorization for study drugs requires study protocol reference to justify coverage under Medicare NCD 310.1 (clinical trial policy). Payers need NCT number, protocol phase, and standard-of-care',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Prior authorization submissions performed by pharmacy staff; tracking submitter employee enables workload analysis, productivity metrics, quality assessment (approval rates), and training needs identi',
    `visit_id` BIGINT COMMENT 'Reference to the clinical visit or encounter during which the medication was prescribed.',
    `appeal_date` DATE COMMENT 'The date on which an appeal was submitted to the payer following a prior authorization denial.',
    `appeal_decision_date` DATE COMMENT 'The date on which the payer made a determination on the appeal of the prior authorization denial.',
    `appeal_outcome` STRING COMMENT 'The result of the appeal process (approved, denied, pending, or withdrawn).. Valid values are `approved|denied|pending|withdrawn`',
    `appeal_submitted_flag` BOOLEAN COMMENT 'Indicates whether an appeal has been submitted following a denial of the prior authorization request.',
    `approval_effective_date` DATE COMMENT 'The date from which the prior authorization approval becomes effective and the medication can be dispensed under the authorization.',
    `approval_expiration_date` DATE COMMENT 'The date on which the prior authorization approval expires and a new authorization would be required for continued medication coverage.',
    `approved_days_supply` STRING COMMENT 'The number of days supply approved by the payer, which may differ from the originally requested days supply.',
    `approved_quantity` DECIMAL(18,2) COMMENT 'The quantity of medication units approved by the payer, which may differ from the originally requested quantity.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this prior authorization request record was first created in the system.',
    `denial_reason_code` STRING COMMENT 'The standardized code provided by the payer indicating the reason for denial of the prior authorization request.',
    `denial_reason_description` STRING COMMENT 'A textual explanation of why the prior authorization request was denied by the payer.',
    `documentation_type` STRING COMMENT 'The type or category of supporting documentation provided (e.g., clinical notes, lab results, imaging reports, prior treatment history).',
    `drug_ndc` STRING COMMENT 'The 11-digit National Drug Code identifying the specific medication product requiring prior authorization.. Valid values are `^[0-9]{11}$|^[0-9]{5}-[0-9]{4}-[0-9]{2}$`',
    `estimated_medication_cost` DECIMAL(18,2) COMMENT 'The estimated total cost of the medication for the requested quantity and days supply, used for financial impact analysis.',
    `formulary_status` STRING COMMENT 'The classification of the medication within the payers formulary (formulary, non-formulary, preferred, non-preferred, specialty, or restricted).. Valid values are `formulary|non_formulary|preferred|non_preferred|specialty|restricted`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this prior authorization request record was most recently modified or updated.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or clinical justification provided by the prescriber or submitter to support the prior authorization request.',
    `pa_decision_date` DATE COMMENT 'The date on which the payer made a determination (approval or denial) on the prior authorization request.',
    `pa_request_date` DATE COMMENT 'The date on which the prior authorization request was submitted to the payer.',
    `pa_request_number` STRING COMMENT 'The externally-known business identifier or tracking number assigned to this prior authorization request by the submitting organization or payer.',
    `pa_status` STRING COMMENT 'The current status of the prior authorization request in its lifecycle (pending review, approved, denied, appealed, withdrawn, or expired).. Valid values are `pending|approved|denied|appealed|withdrawn|expired`',
    `payer_reference_number` STRING COMMENT 'The unique tracking or reference number assigned by the payer to this prior authorization request for their internal processing and tracking.',
    `prior_medications_tried` STRING COMMENT 'A list or description of alternative medications the patient has previously tried as part of step therapy requirements.',
    `requested_days_supply` STRING COMMENT 'The number of days the requested medication quantity is intended to last based on the prescribed dosing regimen.',
    `requested_quantity` DECIMAL(18,2) COMMENT 'The quantity of medication units requested in the prior authorization (e.g., number of tablets, vials, or milliliters).',
    `specialty_medication_flag` BOOLEAN COMMENT 'Indicates whether the medication is classified as a specialty drug requiring special handling, administration, or distribution.',
    `step_therapy_required_flag` BOOLEAN COMMENT 'Indicates whether the payer requires the patient to try alternative medications (step therapy) before approving the requested medication.',
    `submitter_contact_fax` STRING COMMENT 'The fax number of the submitting organization for receiving payer responses or additional documentation requests.',
    `submitter_contact_phone` STRING COMMENT 'The phone number of the submitting organization or individual for follow-up regarding the prior authorization request.',
    `supporting_documentation_provided_flag` BOOLEAN COMMENT 'Indicates whether clinical documentation, lab results, or other supporting evidence was submitted with the prior authorization request.',
    `urgency_level` STRING COMMENT 'The priority or urgency classification of the prior authorization request (routine, urgent, expedited, or emergency).. Valid values are `routine|urgent|expedited|emergency`',
    CONSTRAINT pk_medication_pa_request PRIMARY KEY(`medication_pa_request_id`)
) COMMENT 'Tracks prior authorization (PA) requests submitted to payers for non-formulary or specialty medications. Captures PA request date, payer name, drug NDC, patient reference, prescriber NPI, clinical indication (ICD-10), supporting documentation, PA status (pending/approved/denied/appealed), approval effective and expiration dates, approved quantity/days supply, denial reason code, and appeal outcome. Supports RCM and specialty pharmacy workflows.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` (
    `rx_claim_id` BIGINT COMMENT 'Unique identifier for the pharmacy benefit claim transaction.',
    `ar_account_id` BIGINT COMMENT 'Foreign key linking to finance.ar_account. Business justification: Pharmacy claims create accounts receivable when insurance adjudication results in amounts due from payers. Critical for revenue cycle management, linking clinical pharmacy claims to financial AR aging',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Pharmacy claims are audited by payers, PBMs, and CMS for fraud/abuse detection. Real process: audit findings reference specific claims as evidence; link enables claim-level audit trail and recovery tr',
    `interface_channel_id` BIGINT COMMENT 'Foreign key linking to interoperability.interface_channel. Business justification: Pharmacy claims routed through payer-specific interface channels (NCPDP). Real business process: claims clearinghouse routing, payer connectivity management, adjudication performance monitoring, rejec',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: Pharmacy claims (NCPDP D.0 transactions) generate message log entries for adjudication tracking. Real business process: claims reconciliation, reject resolution, payer communication audit trail, reven',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Pharmacy claims must trace to originating clinical orders for audit compliance, revenue cycle reconciliation, clinical outcomes analysis, and quality measure reporting. Required for CMS medication adh',
    `demographics_id` BIGINT COMMENT 'Identifier for the patient receiving the medication.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_diagnosis. Business justification: Pharmacy claims require diagnosis codes for adjudication and medical necessity validation. Required for payer reimbursement, fraud prevention, and utilization management. Standard in pharmacy benefit ',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Dispensing pharmacy is an organizational provider. Claims processing requires pharmacy organization identification for network participation verification, payment routing, and fraud detection. FK enab',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Pharmacy claims for injectable drugs, vaccines, and DME-related medications require HCPCS code linkage for Medicare Part B billing and medical benefit adjudication. Required for specialty pharmacy cla',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Pharmacy claims adjudication requires linking to specific coverage record for real-time benefit verification, coordination of benefits processing, and accurate patient cost-sharing calculation. Member',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Retail pharmacies submit claims for durable medical equipment and medical supplies (diabetic supplies, nebulizers, spacers, peak flow meters) through pharmacy benefit managers using NCPDP transaction ',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Pharmacy claims (rx_claim) coordinate with medical claims for integrated patient cost tracking, coordination of benefits determination, and total cost of care reporting. Payers analyze pharmacy + medi',
    `mpi_record_id` BIGINT COMMENT 'Pharmacy benefit plan member identifier assigned by the payer or PBM (Pharmacy Benefit Manager).',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Pharmacy claims adjudication requires NDC linkage for NCPDP transaction processing, drug pricing verification, rebate calculation, and MAC (Maximum Allowable Cost) pricing. Fundamental to pharmacy ben',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Prescriber is a licensed clinician. Pharmacy claims must identify prescribing clinician for adjudication, fraud detection, prescribing pattern analysis, and reimbursement. FK enables payer enrollment ',
    `prescription_id` BIGINT COMMENT 'Identifier for the prescription order that authorized this dispensing.',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to research.research_study. Business justification: Claims adjudication for trial-related prescriptions requires study linkage to apply clinical trial coverage policies, distinguish standard-of-care from research costs per Medicare/CMS guidelines, and ',
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
    `prior_authorization_number` STRING COMMENT 'Prior authorization approval number obtained from the payer before dispensing, required for certain high-cost or restricted medications.',
    `quantity_dispensed` DECIMAL(18,2) COMMENT 'Quantity of medication dispensed, measured in the appropriate unit (tablets, milliliters, grams, etc.).',
    `refill_number` STRING COMMENT 'Sequential refill number for this prescription, with zero indicating the original fill.',
    `reject_code` STRING COMMENT 'NCPDP reject code returned by the PBM (Pharmacy Benefit Manager) when a claim is denied, indicating the reason for rejection.',
    `reject_description` STRING COMMENT 'Human-readable description of the reject code explaining why the claim was denied.',
    `reversal_date` DATE COMMENT 'Date the claim was reversed or voided, if applicable.',
    `sales_tax` DECIMAL(18,2) COMMENT 'Sales tax amount applied to the prescription transaction, if applicable.',
    `secondary_payer_paid_amount` DECIMAL(18,2) COMMENT 'Amount paid by the secondary payer in a Coordination of Benefits (COB) scenario.',
    `submission_clarification_code` STRING COMMENT 'NCPDP submission clarification code providing additional context about the claim submission circumstances.',
    `total_amount_paid` DECIMAL(18,2) COMMENT 'Total amount paid for the prescription, including patient copay and plan paid amount.',
    `transaction_response_status` STRING COMMENT 'Real-time response status returned by the PBM (Pharmacy Benefit Manager) during claim adjudication.. Valid values are `approved|rejected|captured|duplicate`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the claim record was last modified or updated.',
    `usual_and_customary_price` DECIMAL(18,2) COMMENT 'Usual and Customary (U&C) price the pharmacy would charge a cash-paying customer for the same prescription.',
    CONSTRAINT pk_rx_claim PRIMARY KEY(`rx_claim_id`)
) COMMENT 'Pharmacy benefit claim submitted to a PBM (Pharmacy Benefit Manager) or payer for reimbursement of a dispensed medication. Captures NCPDP transaction fields including claim date, BIN/PCN/group number, member ID, prescriber NPI, dispensing pharmacy NPI, drug NDC, quantity dispensed, days supply, DAW (Dispense As Written) code, ingredient cost, dispensing fee, patient copay, plan paid amount, U&C (Usual and Customary) price, claim status (paid/rejected/reversed), NCPDP reject codes, and coordination of benefits (COB) data. Distinct from medical claims in the claim domain — this product owns pharmacy-specific NCPDP D.0 claim transactions. Sourced from Epic Willow and Cerner PharmNet.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` (
    `medication_therapy_mgmt_id` BIGINT COMMENT 'Unique identifier for the medication therapy management service encounter. Primary key for the medication therapy management product.',
    `care_site_id` BIGINT COMMENT 'Reference to the facility where the medication therapy management service was provided.',
    `cms_condition_status_id` BIGINT COMMENT 'Foreign key linking to compliance.cms_condition_status. Business justification: MTM services are CMS Conditions of Participation requirements for Medicare Part D pharmacies. Real process: CoP surveys verify MTM service delivery; link tracks compliance with specific condition requ',
    `demographics_id` BIGINT COMMENT 'Reference to the patient who received the medication therapy management service.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_diagnosis. Business justification: MTM services targeted to patients with specific chronic conditions (diabetes, heart failure, COPD, multiple chronic conditions). Required for CMS Part D MTM program eligibility determination and quali',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: MTM eligibility criteria, service coverage, and reimbursement rates are plan-specific. Pharmacists must document which health plan the MTM service is provided under to ensure proper billing, meet plan',
    `lab_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_order. Business justification: MTM comprehensive medication reviews require evaluating lab monitoring compliance (lipid panels for statins, A1C for diabetes medications, INR for warfarin). CMS Star Ratings measure and clinical phar',
    `measure_result_id` BIGINT COMMENT 'Foreign key linking to quality.measure_result. Business justification: MTM services contribute to quality measure numerators (comprehensive medication review completion, medication reconciliation, transitions of care). Quality teams link MTM encounters to measure result ',
    `cda_document_id` BIGINT COMMENT 'Foreign key linking to interoperability.cda_document. Business justification: MTM comprehensive medication reviews documented as CDA clinical notes for HIE sharing. Real business process: care coordination, chronic disease management, value-based care reporting, PCP notificatio',
    `promoting_interoperability_id` BIGINT COMMENT 'Foreign key linking to interoperability.promoting_interoperability. Business justification: MTM services documented for MIPS Promoting Interoperability attestation. Real business process: quality measure reporting, value-based payment, MIPS scoring, medication management attestation, chronic',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: MTM services are billable clinical services requiring payer identification for claims submission and reimbursement. CMS Part D and commercial payers have specific MTM program requirements and payment ',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Pharmacist providing MTM is a licensed clinician. Medication therapy management services are billable clinical services requiring licensed pharmacist identification for claims submission, quality repo',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: MTM services are billable clinical services requiring licensed pharmacist employee. Essential for credentialing verification, billing validation, productivity tracking, and CMS Part D MTM program comp',
    `pharmacy_location_id` BIGINT COMMENT 'Foreign key linking to pharmacy.location. Business justification: MTM services are provided at specific pharmacy locations. Cardinality N:1 (many MTM sessions at one location). The service_location string can be replaced by a FK to the location master. No bidirectio',
    `training_completion_id` BIGINT COMMENT 'Foreign key linking to compliance.training_completion. Business justification: MTM pharmacists require certification/training completion (APhA MTM Certificate, state-specific credentials). Real process: MTM service billing requires verifying pharmacist completed required trainin',
    `treatment_consent_id` BIGINT COMMENT 'Foreign key linking to consent.treatment_consent. Business justification: MTM services (comprehensive medication reviews, pharmacist interventions) are billable clinical services requiring patient consent for the service itself, documentation of patient agreement to partici',
    `visit_id` BIGINT COMMENT 'Reference to the clinical visit or encounter during which the MTM service was provided, if applicable.',
    `billing_cpt_code` STRING COMMENT 'The five-digit CPT code used for billing the medication therapy management service (e.g., 99605, 99606, 99607 for MTM services).. Valid values are `^[0-9]{5}$`',
    `billing_status` STRING COMMENT 'Current billing status of the medication therapy management service.. Valid values are `billable|non_billable|billed|paid|denied|pending`',
    `cms_part_d_compliant` BOOLEAN COMMENT 'Indicates whether the medication therapy management service meets CMS Part D MTM program compliance requirements.',
    `cost_avoidance_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated cost avoidance amount (e.g., USD).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this medication therapy management service record was first created in the system.',
    `documentation_complete` BOOLEAN COMMENT 'Indicates whether all required documentation for the medication therapy management service has been completed.',
    `drug_therapy_problem_count` STRING COMMENT 'Total number of drug therapy problems identified during the medication therapy management service.',
    `drug_therapy_problem_description` STRING COMMENT 'Detailed narrative description of the drug therapy problems identified during the medication therapy management service.',
    `drug_therapy_problem_identified` BOOLEAN COMMENT 'Indicates whether one or more drug therapy problems were identified during the medication therapy management service.',
    `estimated_cost_avoidance_amount` DECIMAL(18,2) COMMENT 'Estimated dollar amount of healthcare costs avoided as a result of the medication therapy management intervention.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether a follow-up medication therapy management service is required for this patient.',
    `follow_up_scheduled_date` DATE COMMENT 'The scheduled date for the follow-up medication therapy management service, if applicable.',
    `intervention_description` STRING COMMENT 'Detailed narrative description of the clinical intervention performed during the medication therapy management service.',
    `intervention_type` STRING COMMENT 'Type of clinical intervention performed by the pharmacist during the medication therapy management service. [ENUM-REF-CANDIDATE: dose_optimization|therapeutic_substitution|allergy_clarification|cost_reduction|duplicate_therapy_resolution|adherence_improvement|adverse_event_management — 7 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this medication therapy management service record was last modified in the system.',
    `medication_count_reviewed` STRING COMMENT 'Total number of medications reviewed during the medication therapy management service encounter.',
    `outcome_description` STRING COMMENT 'Detailed narrative description of the outcome of the medication therapy management service.',
    `outcome_status` STRING COMMENT 'The outcome status of the medication therapy management service indicating whether identified drug therapy problems were resolved.. Valid values are `resolved|partially_resolved|unresolved|pending|patient_declined`',
    `patient_action_plan` STRING COMMENT 'Personalized action plan provided to the patient outlining steps to optimize medication therapy and achieve therapeutic goals.',
    `patient_satisfaction_score` STRING COMMENT 'Patient satisfaction score for the medication therapy management service, typically on a scale of 1-5 or 1-10.',
    `prescriber_notification_date` DATE COMMENT 'The date on which the prescriber was notified of the medication therapy management findings and recommendations.',
    `prescriber_notified` BOOLEAN COMMENT 'Indicates whether the prescriber was notified of the medication therapy management findings and recommendations.',
    `prescriber_response` STRING COMMENT 'The prescribers response to the pharmacists medication therapy management recommendations.. Valid values are `accepted|rejected|modified|no_response`',
    `prescriber_response_date` DATE COMMENT 'The date on which the prescriber responded to the medication therapy management recommendations.',
    `quality_measure_reported` BOOLEAN COMMENT 'Indicates whether this medication therapy management service was reported for quality measurement and regulatory reporting purposes.',
    `recommendation_made` STRING COMMENT 'Detailed recommendations made by the pharmacist to the patient and/or prescriber as a result of the medication therapy management service.',
    `service_date` DATE COMMENT 'The date on which the medication therapy management service was provided to the patient.',
    `service_duration_minutes` STRING COMMENT 'Total duration of the medication therapy management service session in minutes.',
    `service_end_time` TIMESTAMP COMMENT 'The timestamp when the medication therapy management service session concluded.',
    `service_notes` STRING COMMENT 'Additional clinical notes and observations documented by the pharmacist during the medication therapy management service.',
    `service_start_time` TIMESTAMP COMMENT 'The timestamp when the medication therapy management service session began.',
    `service_type` STRING COMMENT 'Type of medication therapy management service provided. CMR = Comprehensive Medication Review, TMR = Targeted Medication Review, clinical intervention, adherence counseling, drug therapy problem resolution, or medication reconciliation.. Valid values are `CMR|TMR|clinical_intervention|adherence_counseling|drug_therapy_problem_resolution|medication_reconciliation`',
    `source_system_record_code` STRING COMMENT 'The unique identifier for this medication therapy management service record in the source system.',
    CONSTRAINT pk_medication_therapy_mgmt PRIMARY KEY(`medication_therapy_mgmt_id`)
) COMMENT 'Records pharmacist clinical services including Medication Therapy Management (MTM), clinical interventions, and patient counseling activities. Captures service type (CMR - Comprehensive Medication Review / TMR - Targeted Medication Review / clinical intervention / adherence counseling), service date, pharmacist NPI, patient reference, medications reviewed, drug therapy problems identified, intervention type (dose optimization/therapeutic substitution/allergy clarification/cost reduction/duplicate therapy resolution), recommendations made, patient action plan, prescriber notification and response, outcome, estimated cost avoidance, and billing CPT code. Supports CMS Part D MTM program compliance, pharmacy value demonstration, and quality reporting. Sourced from Epic Willow and Cerner PharmNet.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` (
    `rems_compliance_id` BIGINT COMMENT 'Unique identifier for the REMS compliance record. Primary key for tracking patient enrollment and compliance with FDA-mandated REMS programs and specialty pharmacy requirements.',
    `compliance_regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: REMS programs require periodic FDA reporting of enrollment and compliance data. Real process: REMS status reports are regulatory submissions; link tracks submission of patient/prescriber enrollment da',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: REMS compliance tracking is for specific drugs requiring FDA-mandated risk mitigation. Cardinality N:1 (many compliance records for one drug). The drug_ndc is kept as its the business key for REMS pr',
    `employee_id` BIGINT COMMENT 'Reference to the care coordinator or specialty pharmacy case manager assigned to support the patient through the REMS program and specialty medication management. Null if no coordinator assigned.',
    `lab_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_order. Business justification: FDA REMS programs mandate specific lab monitoring before dispensing (clozapine requires ANC, isotretinoin requires pregnancy tests, lenalidomide requires pregnancy tests). Regulatory compliance requir',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient enrolled in the REMS or specialty pharmacy program. Links to the patient master record.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Prescriber is a licensed clinician. REMS programs require certified prescriber tracking for restricted drug distribution per FDA mandates. FK enables verification of prescriber REMS certification stat',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to consent.consent_record. Business justification: FDA REMS programs (iPLEDGE for isotretinoin, TIRF REMS for fentanyl products) mandate documented patient enrollment consent acknowledging risks and monitoring requirements. Regulatory compliance requi',
    `training_id` BIGINT COMMENT 'Foreign key linking to compliance.training. Business justification: REMS programs mandate specific training for prescribers, pharmacists, and patients. Real process: REMS enrollment verification requires confirming completion of program-specific training; link tracks ',
    `adherence_monitoring_required` BOOLEAN COMMENT 'Indicates whether the REMS program mandates ongoing adherence monitoring or patient follow-up as a program element. True if adherence monitoring is required; false if not required.',
    `adherence_monitoring_status` STRING COMMENT 'Compliance status for the adherence monitoring element: compliant (patient adherence verified), non-compliant (adherence issues identified), pending (monitoring in progress), or not required (program does not mandate adherence monitoring).. Valid values are `Compliant|Non-Compliant|Pending|Not Required`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this REMS compliance record was first created in the system.',
    `dispensing_pharmacy_npi` STRING COMMENT 'The 10-digit National Provider Identifier of the pharmacy authorized to dispense the REMS medication. Must be certified in the REMS program if required.. Valid values are `^[0-9]{10}$`',
    `drug_ndc` STRING COMMENT 'The 11-digit National Drug Code identifying the specific medication subject to REMS or specialty program requirements. Format: labeler-product-package.. Valid values are `^[0-9]{4,5}-[0-9]{3,4}-[0-9]{1,2}$`',
    `enrollment_date` DATE COMMENT 'The date the patient was enrolled in the REMS or specialty pharmacy program.',
    `enrollment_status` STRING COMMENT 'Current status of the patients enrollment in the program: active (fully enrolled and compliant), pending (enrollment in progress), inactive (not currently enrolled), withdrawn (patient withdrew), suspended (temporarily paused), or completed (program requirements fulfilled).. Valid values are `Active|Pending|Inactive|Withdrawn|Suspended|Completed`',
    `fda_reporting_required` BOOLEAN COMMENT 'Indicates whether this REMS compliance record requires reporting to the FDA as part of the REMS program assessment. True if FDA reporting is required; false if not required.',
    `fda_reporting_status` STRING COMMENT 'Status of FDA reporting for this compliance record: reported (data submitted to FDA), pending (report in preparation), overdue (report past due date), or not required (no FDA reporting obligation for this record).. Valid values are `Reported|Pending|Overdue|Not Required`',
    `hub_services_enrollment_status` STRING COMMENT 'Status of patient enrollment in manufacturer hub services for specialty medication support: enrolled (active in hub), not enrolled (not participating), pending (enrollment in progress), inactive (previously enrolled but now inactive), or not applicable (hub services not available for this medication).. Valid values are `Enrolled|Not Enrolled|Pending|Inactive|Not Applicable`',
    `lab_monitoring_required` BOOLEAN COMMENT 'Indicates whether the REMS program mandates periodic laboratory testing or monitoring as a program element. True if lab monitoring is required; false if not required.',
    `lab_monitoring_status` STRING COMMENT 'Compliance status for the laboratory monitoring element: compliant (all required tests completed on schedule), non-compliant (tests not completed), pending (test scheduled), overdue (test past due date), or not required (program does not mandate lab monitoring).. Valid values are `Compliant|Non-Compliant|Pending|Overdue|Not Required`',
    `last_adherence_verification_date` DATE COMMENT 'The date of the most recent adherence verification or patient follow-up contact. Null if adherence monitoring is not required or not yet performed.',
    `last_fda_report_date` DATE COMMENT 'The date this compliance record was last reported to the FDA as part of REMS program assessment. Null if not yet reported or reporting not required.',
    `last_lab_monitoring_date` DATE COMMENT 'The date of the most recent laboratory test or monitoring event required by the REMS program. Null if lab monitoring is not required or not yet performed.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this REMS compliance record was most recently updated or modified.',
    `last_verification_date` DATE COMMENT 'The date of the most recent comprehensive compliance verification across all REMS program elements.',
    `next_lab_monitoring_due_date` DATE COMMENT 'The date by which the next laboratory test or monitoring event is due per REMS program requirements. Null if lab monitoring is not required.',
    `next_verification_due_date` DATE COMMENT 'The date by which the next comprehensive compliance verification is due per REMS program requirements.',
    `non_compliance_reason` STRING COMMENT 'Free-text description of the reason for non-compliance with REMS program elements, if applicable. Documents barriers, patient refusal, system issues, or other factors preventing full compliance.',
    `overall_compliance_status` STRING COMMENT 'Aggregate compliance status across all required REMS program elements: fully compliant (all elements met), partially compliant (some elements met), non-compliant (critical elements not met), or pending review (compliance assessment in progress).. Valid values are `Fully Compliant|Partially Compliant|Non-Compliant|Pending Review`',
    `patient_assistance_program_status` STRING COMMENT 'Status of patient eligibility and enrollment in manufacturer patient assistance programs for medication cost support: eligible (qualifies for assistance), not eligible (does not qualify), enrolled (actively receiving assistance), pending (application in progress), expired (assistance period ended), or not applicable (no assistance program available).. Valid values are `Eligible|Not Eligible|Enrolled|Pending|Expired|Not Applicable`',
    `patient_enrollment_date` DATE COMMENT 'The date the patient completed enrollment in the REMS program. Null if enrollment is not required or not yet completed.',
    `patient_enrollment_required` BOOLEAN COMMENT 'Indicates whether the REMS program mandates patient enrollment as a program element. True if patient must enroll; false if not required.',
    `patient_enrollment_status` STRING COMMENT 'Compliance status for the patient enrollment element: enrolled (patient has completed enrollment), not enrolled (patient has not enrolled), pending (enrollment in progress), expired (enrollment lapsed), or not required (program does not mandate patient enrollment).. Valid values are `Enrolled|Not Enrolled|Pending|Expired|Not Required`',
    `pharmacy_certification_date` DATE COMMENT 'The date the pharmacy completed REMS program certification. Null if certification is not required or not yet completed.',
    `pharmacy_certification_status` STRING COMMENT 'Indicates whether the dispensing pharmacy has completed required REMS program certification: certified (active certification), not certified (lacks certification), pending (certification in progress), expired (certification lapsed), or not required (program does not mandate pharmacy certification).. Valid values are `Certified|Not Certified|Pending|Expired|Not Required`',
    `prescriber_certification_date` DATE COMMENT 'The date the prescriber completed REMS program certification. Null if certification is not required or not yet completed.',
    `prescriber_certification_status` STRING COMMENT 'Indicates whether the prescriber has completed required REMS program certification: certified (active certification), not certified (lacks certification), pending (certification in progress), expired (certification lapsed), or not required (program does not mandate prescriber certification).. Valid values are `Certified|Not Certified|Pending|Expired|Not Required`',
    `program_expiration_date` DATE COMMENT 'The date the patients enrollment in the REMS or specialty program expires and requires renewal. Null for programs without expiration.',
    `program_name` STRING COMMENT 'The official name of the FDA REMS program or specialty pharmacy program (e.g., iPLEDGE for isotretinoin, Clozapine REMS, Tysabri TOUCH Prescribing Program).',
    `program_type` STRING COMMENT 'The category of program governing the medication: FDA-mandated REMS, manufacturer hub services, patient assistance program, specialty enrollment, restricted distribution, or general risk management.. Valid values are `REMS|Hub Services|Patient Assistance|Specialty Enrollment|Restricted Distribution|Risk Management`',
    `risk_category` STRING COMMENT 'The risk level classification of the medication requiring REMS oversight: high (serious safety concerns requiring intensive monitoring), medium (moderate risk requiring standard monitoring), or low (minimal risk with basic oversight).. Valid values are `High|Medium|Low`',
    CONSTRAINT pk_rems_compliance PRIMARY KEY(`rems_compliance_id`)
) COMMENT 'Tracks patient enrollment and compliance with FDA-mandated REMS (Risk Evaluation and Mitigation Strategy) programs and specialty pharmacy program requirements for high-risk and specialty medications. Captures program name and type (REMS/hub services/patient assistance/specialty enrollment), drug NDC, patient reference, prescriber NPI, dispensing pharmacy NPI, required program elements (patient enrollment, prescriber certification, pharmacy certification, lab monitoring, adherence monitoring), compliance status per element, last verification date, hub services enrollment status, patient assistance program eligibility, care coordinator assignment, and FDA reporting status. Supports FDA REMS obligations, specialty pharmacy hub operations, patient support programs, and audit readiness. Sourced from Epic Willow and Cerner PharmNet.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` (
    `drug_recall_id` BIGINT COMMENT 'Unique identifier for the drug recall record. Primary key.',
    `compliance_regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Drug recalls trigger mandatory reporting to FDA and state boards of pharmacy. Real process: recall disposition reports (quantities quarantined/returned/destroyed) are regulatory submissions required f',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Drug recall management requires designated employee coordinator for patient notification, inventory quarantine, FDA reporting, and documentation. Essential for regulatory compliance and accountability',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Drug recalls reference specific drugs in the drug master. The ndc column is kept as its the FDA recall identifier. This link eliminates the siloed drug_recall table. Cardinality N:1 (many recalls can',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: FDA drug recall management requires linking recall notices to standardized NDC definitions for patient notification, inventory quarantine, and regulatory reporting. Essential for FDA Enforcement Repor',
    `patient_safety_event_id` BIGINT COMMENT 'Foreign key linking to quality.patient_safety_event. Business justification: Drug recalls involving patient exposure trigger mandatory patient safety event reporting. Quality teams document recall-related safety events for regulatory submission, harm assessment, and patient no',
    `pharmacy_location_id` BIGINT COMMENT 'Foreign key linking to pharmacy.location. Business justification: Recalled drugs are quarantined and managed at specific pharmacy locations. Cardinality N:1 (many recalls managed at one location). The quarantine_location is kept as it represents a sub-location withi',
    `direct_message_id` BIGINT COMMENT 'Foreign key linking to interoperability.direct_message. Business justification: Recall notifications sent to prescribers/patients via Direct secure messaging. Real business process: patient safety communication, recall response coordination, affected patient notification, prescri',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to interoperability.message_log. Business justification: FDA recall notifications received via HL7 messages trigger quarantine workflows. Real business process: patient safety event management, recall response coordination, affected patient identification, ',
    `adverse_event_count` STRING COMMENT 'Number of adverse drug events reported in association with the recalled product at this facility.',
    `adverse_event_reported` BOOLEAN COMMENT 'Indicates whether any adverse drug events were reported in association with the recalled product at this facility.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this recall record was first created in the system.',
    `destruction_date` DATE COMMENT 'Date when recalled product was destroyed on-site, if applicable.',
    `destruction_witness_name` STRING COMMENT 'Name of authorized personnel who witnessed the destruction of recalled controlled substances, if applicable.',
    `disposition_method` STRING COMMENT 'Method used to dispose of recalled product inventory.. Valid values are `returned to manufacturer|destroyed on-site|returned to distributor|pending disposition`',
    `drug_name` STRING COMMENT 'Brand or generic name of the drug product subject to recall.',
    `fda_enforcement_report_date` DATE COMMENT 'Date the recall was published in the FDA Enforcement Report.',
    `fda_recall_number` STRING COMMENT 'Official FDA-assigned recall identification number used for tracking and regulatory reporting.. Valid values are `^[A-Z]-[0-9]{4}-[0-9]{4}$`',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact of the recall to the organization, including inventory loss, return costs, and patient notification expenses, in US dollars.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this recall record was last modified.',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number(s) affected by the recall. May contain multiple comma-separated values.',
    `manufacturer_name` STRING COMMENT 'Name of the pharmaceutical manufacturer or distributor initiating the recall.',
    `ndc` STRING COMMENT 'National Drug Code identifying the specific drug product affected by the recall. Standard 11-digit FDA identifier.. Valid values are `^[0-9]{5}-[0-9]{4}-[0-9]{2}$|^[0-9]{5}-[0-9]{3}-[0-9]{2}$|^[0-9]{4}-[0-9]{4}-[0-9]{2}$`',
    `notes` STRING COMMENT 'Free-text notes documenting additional details, actions taken, or special circumstances related to the recall response.',
    `patient_notification_date` DATE COMMENT 'Date when patient notification process was completed or last attempted.',
    `patient_notification_method` STRING COMMENT 'Method(s) used to notify affected patients (e.g., phone call, certified mail, patient portal message, in-person contact).',
    `patient_notification_status` STRING COMMENT 'Status of patient notification efforts for patients who received the recalled medication.. Valid values are `not required|pending|in progress|completed|unable to contact`',
    `patients_affected_count` STRING COMMENT 'Number of unique patients who received the recalled drug product prior to recall identification.',
    `provider_notification_date` DATE COMMENT 'Date when prescribing providers were notified of the recall affecting their patients.',
    `provider_notification_status` STRING COMMENT 'Status of notification to prescribing providers whose patients received the recalled medication.. Valid values are `not required|pending|completed`',
    `quantity_dispensed` DECIMAL(18,2) COMMENT 'Total quantity of the affected drug product already dispensed to patients prior to recall identification, measured in dispensing units.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'Total quantity of the affected drug product in pharmacy inventory at the time the recall was identified, measured in dispensing units.',
    `quantity_quarantined` DECIMAL(18,2) COMMENT 'Quantity of affected drug product removed from active inventory and placed in quarantine status pending return or destruction.',
    `quantity_returned` DECIMAL(18,2) COMMENT 'Quantity of affected drug product successfully returned to the manufacturer or distributor.',
    `quarantine_date` DATE COMMENT 'Date when affected inventory was removed from active stock and placed in quarantine status.',
    `quarantine_location` STRING COMMENT 'Physical location or bin identifier where quarantined recalled product is stored pending disposition.',
    `recall_classification` STRING COMMENT 'FDA recall classification indicating severity: Class I (dangerous or fatal), Class II (temporary or reversible health consequences), Class III (unlikely to cause adverse health consequences).. Valid values are `Class I|Class II|Class III`',
    `recall_closure_date` DATE COMMENT 'Date when all recall response activities were completed and the recall was officially closed within the organization.',
    `recall_initiation_date` DATE COMMENT 'Date the recall was officially initiated by the manufacturer or FDA.',
    `recall_reason` STRING COMMENT 'Detailed explanation of the reason for the recall, including defect type, contamination, labeling error, or other safety concern.',
    `recall_scope` STRING COMMENT 'Distribution level to which the recall extends: consumer (patient), retail (pharmacy), or wholesale (distributor).. Valid values are `consumer level|retail level|wholesale level`',
    `recall_status` STRING COMMENT 'Current status of the recall action within the healthcare organizations response workflow.. Valid values are `ongoing|completed|terminated|pending`',
    `recall_type` STRING COMMENT 'Indicates whether the recall was voluntary by the manufacturer, requested by FDA, or mandated by FDA.. Valid values are `voluntary|FDA-requested|FDA-mandated`',
    `responsible_party_contact` STRING COMMENT 'Contact information (phone or email) for the responsible party managing this recall.',
    `responsible_party_name` STRING COMMENT 'Name of the pharmacy staff member or department responsible for managing this recall response.',
    `return_authorization_number` STRING COMMENT 'Manufacturer or distributor-issued return merchandise authorization (RMA) number for product return.',
    `return_date` DATE COMMENT 'Date when recalled product was shipped back to manufacturer or distributor.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for quantity fields (e.g., tablets, vials, milliliters, grams).',
    CONSTRAINT pk_drug_recall PRIMARY KEY(`drug_recall_id`)
) COMMENT 'Operational record of FDA drug recalls and market withdrawals affecting medications in the pharmacy inventory or dispensed to patients. Captures recall classification (Class I/II/III), NDC, lot numbers affected, recall initiation date, FDA recall number, recall reason, quantity on hand at time of recall, quantity already dispensed, patient notification status, return/quarantine actions taken, and recall closure date. Supports patient safety response and regulatory compliance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` (
    `compounding_record_id` BIGINT COMMENT 'Unique identifier for the compounding record. Primary key for this entity.',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Compounded medications use a base solution from the drug master. The FK is labeled base_solution_drug_master_id to distinguish from potential other drug references in compounding. Cardinality N:1 (m',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Compounded medications are prepared based on specific clinical orders. This link ensures traceability for USP 797/800 compliance, adverse event investigation, batch recall management, and clinical doc',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Compounding pharmacist is a licensed clinician. USP 797/800 compliance requires identification of licensed pharmacist who prepared compounded medication for quality assurance, regulatory inspection, a',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Compounding pharmacist must be traceable to credentialed employee for USP 797/800 compliance, competency assessment, and quality assurance. State boards require employee-level tracking for sterile com',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Compounding activities incur direct costs (raw materials, pharmacist labor, quality testing, equipment) tracked by cost center for specialty pharmacy cost accounting, pricing analysis, and 340B progra',
    `demographics_id` BIGINT COMMENT 'The unique identifier for the patient for whom this compounded medication is prepared (if patient-specific).',
    `investigational_product_id` BIGINT COMMENT 'Foreign key linking to research.investigational_product. Business justification: Compounded investigational products (especially oncology trials) require linkage to IP master for formula verification, stability data, USP 797/800 compliance, and batch traceability. Essential for sp',
    `lab_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_order. Business justification: Patient-specific compounding requires lab values for dose calculation (chemotherapy based on BSA/renal function, TPN based on electrolytes/nutrition labs). Personalized medicine standard documented in',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Sterile and non-sterile compounding records need NDC reference for ingredient tracking, USP <797>/<795> compliance documentation, and FDA registration. Required for compounding pharmacy quality assura',
    `pharmacy_location_id` BIGINT COMMENT 'The unique identifier for the pharmacy facility or compounding location where the preparation was made.',
    `prescription_id` BIGINT COMMENT 'The unique identifier for the prescription order that triggered this compounding preparation.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Sterile and hazardous compounding uses medical supplies (syringes, filters, IV bags, tubing, needles) as essential components. USP 797/800 compliance requires tracking all materials used in compoundin',
    `treatment_consent_id` BIGINT COMMENT 'Foreign key linking to consent.treatment_consent. Business justification: Compounded medications, especially hazardous drugs (chemotherapy), investigational compounds, or non-FDA-approved formulations, require specific patient consent documenting risks, alternatives, and of',
    `visit_id` BIGINT COMMENT 'The unique identifier for the patient encounter associated with this compounded preparation (if applicable).',
    `base_solution_ndc` STRING COMMENT 'The NDC of the base solution used in IV admixture compounding (e.g., normal saline, dextrose).',
    `base_solution_volume_ml` DECIMAL(18,2) COMMENT 'The volume of the base solution used in the IV admixture, measured in milliliters.',
    `batch_number` STRING COMMENT 'The batch or lot number assigned to this compounding preparation for tracking and traceability.',
    `batch_size` DECIMAL(18,2) COMMENT 'The total quantity or volume of the compounded preparation in this batch.',
    `batch_size_unit` STRING COMMENT 'The unit of measure for the batch size (e.g., milliliters, grams, doses).. Valid values are `ml|l|g|kg|units|doses`',
    `beyond_use_date` DATE COMMENT 'The date after which the compounded preparation should not be used, based on stability and sterility considerations per USP guidelines.',
    `compound_name` STRING COMMENT 'The name or label assigned to the compounded medication preparation.',
    `compounding_room` STRING COMMENT 'The specific compounding room or cleanroom where the preparation was performed (e.g., ISO Class 5, ISO Class 7).',
    `compounding_status` STRING COMMENT 'The current lifecycle status of the compounding record (e.g., in progress, completed, verified, dispensed, discarded).. Valid values are `in_progress|completed|verified|dispensed|discarded|quarantined`',
    `compounding_type` STRING COMMENT 'The category of compounding performed: non-sterile (USP 795), sterile (USP 797), or IV admixture.. Valid values are `non-sterile|sterile|iv_admixture`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this compounding record was first created in the system.',
    `delivery_location` STRING COMMENT 'The clinical unit, department, or patient location where the compounded preparation is to be delivered.',
    `discard_reason` STRING COMMENT 'The reason why the compounded preparation was discarded, if applicable (e.g., contamination, expiration, preparation error).',
    `discard_timestamp` TIMESTAMP COMMENT 'The date and time when the compounded preparation was discarded.',
    `endotoxin_test_performed` BOOLEAN COMMENT 'Indicates whether endotoxin testing was performed on this compounded preparation per USP 797 requirements.',
    `endotoxin_test_result` STRING COMMENT 'The result of the endotoxin test, if performed.. Valid values are `pass|fail|pending|not_applicable`',
    `environmental_monitoring_notes` STRING COMMENT 'Additional notes or details regarding environmental monitoring results and conditions during compounding.',
    `environmental_monitoring_result` STRING COMMENT 'The result of environmental monitoring (e.g., air quality, surface sampling) performed during sterile compounding per USP 797 requirements.. Valid values are `pass|fail|not_applicable`',
    `fda_registration_number` STRING COMMENT 'The FDA registration number for the compounding facility, if applicable under 503B outsourcing facility requirements.',
    `final_concentration` STRING COMMENT 'The final concentration of the active ingredient(s) in the compounded preparation (e.g., mg/mL, mcg/mL).',
    `formula_reference_number` STRING COMMENT 'The reference number or identifier for the compounding formula or recipe used in this preparation.',
    `hazardous_drug_flag` BOOLEAN COMMENT 'Indicates whether the compounded preparation contains hazardous drugs requiring special handling per USP 800.',
    `infusion_rate` DECIMAL(18,2) COMMENT 'The recommended infusion rate for IV admixtures (e.g., mL/hr, mg/min).',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this compounding record was last modified in the system.',
    `notes` STRING COMMENT 'Additional free-text notes or comments regarding the compounding preparation, including any deviations or special considerations.',
    `preparation_date` DATE COMMENT 'The date on which the compounded medication was prepared.',
    `preparation_timestamp` TIMESTAMP COMMENT 'The precise date and time when the compounding preparation was completed.',
    `qa_verification_pharmacist_name` STRING COMMENT 'The full name of the pharmacist who performed QA verification.',
    `qa_verification_pharmacist_npi` STRING COMMENT 'The NPI of the pharmacist who performed quality assurance verification of the compounded preparation.',
    `qa_verification_timestamp` TIMESTAMP COMMENT 'The date and time when quality assurance verification was completed.',
    `regulatory_compliance_status` STRING COMMENT 'The compliance status of this compounding record with respect to FDA 503A/503B regulations and USP standards.. Valid values are `compliant|non_compliant|pending_review`',
    `sterility_test_performed` BOOLEAN COMMENT 'Indicates whether sterility testing was performed on this compounded preparation per USP 797 requirements.',
    `sterility_test_result` STRING COMMENT 'The result of the sterility test, if performed.. Valid values are `pass|fail|pending|not_applicable`',
    `total_volume_ml` DECIMAL(18,2) COMMENT 'The total volume of the final compounded preparation, measured in milliliters.',
    `usp_chapter_compliance` STRING COMMENT 'The USP chapter standard that governs this compounding preparation: USP 795 (non-sterile), USP 797 (sterile), or USP 800 (hazardous drugs).. Valid values are `usp_795|usp_797|usp_800`',
    CONSTRAINT pk_compounding_record PRIMARY KEY(`compounding_record_id`)
) COMMENT 'Master and production record for all compounded medication preparations (non-sterile, sterile, and IV admixtures) prepared by the pharmacy. Captures compound name, formula/recipe reference, compounding type (non-sterile/sterile/IV admixture), BUD (Beyond-Use Date), USP chapter compliance (USP 795/797/800), ingredients with NDC and quantities, lot numbers, compounding pharmacist NPI, QA verification pharmacist NPI, preparation date and time, batch size, environmental monitoring results, and for IV admixtures: base solution, additives, final concentration, total volume, infusion rate, and delivery location. Supports USP compliance, 503A/503B compounding regulations, and IV workflow safety. Sourced from Epic Willow and Cerner PharmNet.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` (
    `pharmacy_location_id` BIGINT COMMENT 'Unique identifier for the pharmacy location. Primary key.',
    `accreditation_status_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_status. Business justification: Pharmacy locations hold accreditations (ACHC, URAC, specialty pharmacy). Real process: accreditation surveys assess location-specific compliance; link tracks accreditation status, survey dates, and fi',
    `care_site_id` BIGINT COMMENT 'Reference to the parent facility or hospital where this pharmacy location is situated.',
    `inventory_location_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_location. Business justification: Pharmacy locations are specialized inventory storage locations within enterprise supply chain systems. Linking pharmacy locations to supply chain inventory locations enables cross-domain inventory vis',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Pharmacist in charge is a licensed clinician. State pharmacy regulations require designated pharmacist in charge for each licensed pharmacy location. FK enables verification of PIC credentials, state ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Every pharmacy location must have designated pharmacist-in-charge (PIC) who is credentialed employee; state board licensure requirement. Essential for regulatory compliance, accountability, and workfo',
    `provider_location_id` BIGINT COMMENT 'FK to SSOT owner provider.provider_location for the location entity.',
    `accreditation_body` STRING COMMENT 'Name of the accrediting organization that granted accreditation to the pharmacy location (e.g., The Joint Commission, ACHC, URAC).',
    `accreditation_expiration_date` DATE COMMENT 'Expiration date of the current pharmacy accreditation; requires renewal to maintain accredited status.',
    `accreditation_status` STRING COMMENT 'Current accreditation status of the pharmacy location by recognized accrediting bodies (e.g., ACHC, URAC, Joint Commission).. Valid values are `accredited|not_accredited|pending|expired`',
    `address_line_1` STRING COMMENT 'Primary street address of the pharmacy location (street number, street name, suite/unit).',
    `address_line_2` STRING COMMENT 'Secondary address information (building name, floor, department) for the pharmacy location.',
    `automated_dispensing_cabinet_count` STRING COMMENT 'Number of automated dispensing cabinets (e.g., Pyxis, Omnicell) deployed at this pharmacy location for decentralized medication storage and dispensing.',
    `city` STRING COMMENT 'City where the pharmacy location is situated.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the pharmacy location (e.g., USA).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pharmacy location record was first created in the system.',
    `dea_registration_number` STRING COMMENT 'DEA registration number authorizing the pharmacy location to dispense controlled substances (Schedule II-V).. Valid values are `^[A-Z]{2}[0-9]{7}$`',
    `dispensing_capability_controlled_substances` BOOLEAN COMMENT 'Indicates whether the pharmacy location is authorized and equipped to dispense DEA Schedule II-V controlled substances.',
    `dispensing_capability_non_sterile` BOOLEAN COMMENT 'Indicates whether the pharmacy location has USP 795 compliant non-sterile compounding capabilities (oral suspensions, topical preparations).',
    `dispensing_capability_specialty` BOOLEAN COMMENT 'Indicates whether the pharmacy location is equipped to dispense specialty medications (biologics, high-cost drugs, limited distribution drugs requiring REMS).',
    `dispensing_capability_sterile` BOOLEAN COMMENT 'Indicates whether the pharmacy location has USP 797 compliant sterile compounding capabilities (IV admixtures, chemotherapy, TPN).',
    `effective_end_date` DATE COMMENT 'Date when the pharmacy location ceased operations or was decommissioned; null for currently active locations.',
    `effective_start_date` DATE COMMENT 'Date when the pharmacy location became operational and began dispensing services.',
    `email_address` STRING COMMENT 'Primary email address for pharmacy location correspondence and notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for receiving prescription orders and clinical communications.',
    `inventory_management_system` STRING COMMENT 'Name of the pharmacy inventory management system in use at this location (e.g., Epic Willow, Cerner PharmNet, Omnicell).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the pharmacy location record was last updated in the system.',
    `location_code` STRING COMMENT 'Internal business identifier or code for the pharmacy location used in operational systems (Epic Willow, Cerner PharmNet).',
    `location_name` STRING COMMENT 'Human-readable name of the pharmacy location (e.g., Main Hospital Pharmacy, Outpatient Retail Pharmacy, Oncology Satellite Pharmacy).',
    `location_type` STRING COMMENT 'Classification of the pharmacy location by service model and operational scope. [ENUM-REF-CANDIDATE: inpatient|outpatient_retail|specialty|satellite|automated_dispensing_cabinet|central_fill|compounding|emergency_department|operating_room — promote to reference product]',
    `ncpdp_number` STRING COMMENT 'Seven-digit NCPDP pharmacy identifier required for prescription claims processing and payer adjudication.. Valid values are `^[0-9]{7}$`',
    `npi` STRING COMMENT 'Ten-digit NPI assigned to the pharmacy location as an organizational provider for billing and claims submission.. Valid values are `^[0-9]{10}$`',
    `operating_hours` STRING COMMENT 'Standard operating hours for the pharmacy location (e.g., Mon-Fri 08:00-20:00, Sat 09:00-17:00, Sun Closed).',
    `phone_number` STRING COMMENT 'Primary contact phone number for the pharmacy location.',
    `postal_code` STRING COMMENT 'Five-digit or nine-digit ZIP code for the pharmacy location address.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `program_340b_covered_entity_code` STRING COMMENT 'HRSA-assigned covered entity identification number for 340B program participation and audit compliance.',
    `program_340b_participation` BOOLEAN COMMENT 'Indicates whether the pharmacy location participates in the federal 340B Drug Pricing Program for discounted outpatient drugs.',
    `state` STRING COMMENT 'Two-letter state code for the pharmacy location address.',
    `state_pharmacy_license_expiration_date` DATE COMMENT 'Expiration date of the state pharmacy license; requires renewal to maintain operational compliance.',
    `state_pharmacy_license_number` STRING COMMENT 'State board of pharmacy license number authorizing the location to operate as a pharmacy within the jurisdiction.',
    `state_pharmacy_license_state` STRING COMMENT 'Two-letter state code where the pharmacy license was issued (e.g., CA, NY, TX).',
    `pharmacy_location_status` STRING COMMENT 'Current operational status of the pharmacy location indicating whether it is actively dispensing medications.. Valid values are `active|inactive|temporarily_closed|pending_licensure|decommissioned`',
    `twenty_four_hour_service` BOOLEAN COMMENT 'Indicates whether the pharmacy location provides 24-hour dispensing services.',
    CONSTRAINT pk_pharmacy_location PRIMARY KEY(`pharmacy_location_id`)
) COMMENT 'Master record for all pharmacy service locations including inpatient pharmacies, outpatient retail pharmacies, specialty pharmacies, satellite pharmacies, and automated dispensing cabinet locations. Captures location name, location type, facility reference, NCPDP pharmacy number, DEA registration number, state pharmacy license number, operating hours, dispensing capabilities (sterile/non-sterile/specialty), 340B program participation status, and active/inactive status. Supports dispensing workflow routing and regulatory compliance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` (
    `medication_review_id` BIGINT COMMENT 'Unique identifier for this medication review record. Primary key.',
    `visit_id` BIGINT COMMENT 'add column encounter_visit_id (BIGINT) with FK to encounter.visit.visit_id - medication reviews occur during encounters but lack a visit FK',
    `medication_therapy_mgmt_id` BIGINT COMMENT 'Foreign key linking to the MTM session during which this prescription was reviewed',
    `mpi_record_id` BIGINT COMMENT 'add column patient_mpi_record_id (BIGINT) with FK to patient.mpi_record.mpi_record_id - medication reviews are patient-specific but only link to medication_therapy_mgmt and prescription without a direct patient FK',
    `prescription_id` BIGINT COMMENT 'Foreign key linking to the prescription that was reviewed during this MTM session',
    `clinician_id` BIGINT COMMENT 'add column provider_clinician_id (BIGINT) with FK to provider.clinician.clinician_id - medication reviews are performed by clinicians but lack a provider FK',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this medication review record was created',
    `drug_therapy_problem_description` STRING COMMENT 'Detailed description of the drug therapy problem identified for this prescription during this review',
    `drug_therapy_problem_identified` BOOLEAN COMMENT 'Indicates whether a drug therapy problem was identified for this specific prescription during this MTM session',
    `estimated_cost_avoidance_amount` DECIMAL(18,2) COMMENT 'Estimated healthcare cost savings attributed to interventions on this specific prescription',
    `intervention_description` STRING COMMENT 'Detailed narrative of the clinical intervention performed for this prescription',
    `intervention_type` STRING COMMENT 'Type of clinical intervention performed for this prescription (dose optimization, therapeutic substitution, allergy clarification, cost reduction, duplicate therapy resolution)',
    `outcome_description` STRING COMMENT 'Detailed description of the outcome for this prescription review',
    `outcome_status` STRING COMMENT 'Outcome status for this prescription review (resolved, pending, accepted, rejected)',
    `prescriber_notification_date` DATE COMMENT 'Date the prescriber was notified about this prescriptions review findings',
    `prescriber_notification_method` STRING COMMENT 'The method used to notify the prescriber of the medication therapy management findings and recommendations. [Moved from medication_therapy_mgmt: The method of notification may vary by prescription and prescriber. This belongs in the association to track communication method per prescription.]. Valid values are `phone|fax|electronic_message|mail|in_person`',
    `prescriber_notified` BOOLEAN COMMENT 'Indicates whether the prescriber was notified about findings related to this specific prescription',
    `prescriber_response` STRING COMMENT 'The prescribers response to recommendations made for this prescription',
    `prescriber_response_date` DATE COMMENT 'Date the prescriber responded regarding this prescription',
    `prescriber_response_notes` STRING COMMENT 'Additional notes or comments from the prescriber regarding the medication therapy management recommendations. [Moved from medication_therapy_mgmt: Response notes are specific to individual prescription recommendations and belong in the association.]',
    `recommendation_made` STRING COMMENT 'Specific recommendations made to the patient and/or prescriber regarding this prescription',
    `review_notes` STRING COMMENT 'Additional clinical notes specific to the review of this prescription during this MTM session',
    `review_sequence_number` STRING COMMENT 'The order in which this prescription was reviewed during the MTM session (1st, 2nd, 3rd, etc.)',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this medication review record was last updated',
    CONSTRAINT pk_medication_review PRIMARY KEY(`medication_review_id`)
) COMMENT 'This association product represents the clinical review of a specific prescription during a Medication Therapy Management (MTM) session. It captures the pharmacists assessment, interventions, and outcomes for each prescription evaluated during the MTM encounter. Each record links one MTM session to one prescription with clinical findings, drug therapy problems, interventions, and prescriber communications that exist only in the context of reviewing that specific prescription during that specific MTM session.. Existence Justification: In healthcare pharmacy operations, MTM sessions routinely involve comprehensive review of multiple prescriptions simultaneously (a patient typically has 5-15 active prescriptions reviewed in one MTM session), and individual prescriptions are reviewed repeatedly over time during different MTM encounters as part of ongoing medication safety monitoring. Pharmacists document specific clinical findings, drug therapy problems, interventions, and outcomes for each prescription within each MTM session, creating relationship data that belongs neither to the MTM session alone nor to the prescription alone.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` (
    `study_drug_assignment_id` BIGINT COMMENT 'Unique identifier for this study-drug assignment record. Primary key.',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to the drug master record for the investigational product assigned to this study',
    `research_study_id` BIGINT COMMENT 'Foreign key linking to the research study to which this drug is assigned',
    `arm_assignment` STRING COMMENT 'The specific treatment arm(s) within the study to which this drug is assigned, linking to the studys treatment arm structure',
    `assignment_end_date` DATE COMMENT 'The date on which this drug assignment was terminated or completed, null if still active',
    `assignment_start_date` DATE COMMENT 'The date on which this drug assignment became effective in the study protocol',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this drug assignment within the study (active, suspended due to safety hold, discontinued, or completed)',
    `blinding_status` STRING COMMENT 'The blinding or masking status specific to this drug assignment within the study, which may vary by drug even within the same study',
    `dose_level` STRING COMMENT 'The specific dose level or dosing regimen assigned for this drug in this study, including strength, frequency, and duration (e.g., 100mg PO BID x 12 weeks)',
    `drug_accountability_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this drug assignment requires formal drug accountability tracking per FDA regulations (typically true for investigational products and controlled substances)',
    `formulary_tier` STRING COMMENT 'Classification of the drug within the study formulary indicating its role in the protocol (investigational agent, active comparator, placebo, standard of care, or rescue medication)',
    `ind_ide_coverage_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this drug is covered under the studys IND or IDE application, determining regulatory reporting requirements',
    `pharmacy_notes` STRING COMMENT 'Free-text notes from research pharmacy regarding special handling, preparation, or dispensing requirements for this drug in this study context',
    `protocol_version` STRING COMMENT 'The specific protocol version or amendment number under which this drug assignment is active, enabling tracking of drug assignment changes across protocol amendments',
    `randomization_date` DATE COMMENT 'The date on which this drug was randomized or assigned to the study protocol, establishing the effective date of the assignment',
    CONSTRAINT pk_study_drug_assignment PRIMARY KEY(`study_drug_assignment_id`)
) COMMENT 'This association product represents the investigational product allocation between drug_master and research_study. It captures the assignment of specific drugs to specific research studies, including arm-specific dosing protocols, blinding status, randomization details, and protocol version tracking. Each record links one drug to one study with attributes that exist only in the context of this research relationship. Supports drug accountability, formulary planning, and protocol compliance workflows managed by research pharmacists.. Existence Justification: Clinical research studies routinely test multiple drugs simultaneously (combination therapy, dose-ranging arms, active comparators vs. investigational agents), and each drug participates in multiple studies across different phases, indications, and institutions. Research pharmacists actively manage study-drug assignments as operational entities with arm-specific dosing protocols, blinding requirements, randomization tracking, and protocol version linkage. The business refers to these as study drug assignments or investigational product allocations and manages them for drug accountability, formulary planning, and regulatory compliance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` (
    `pharmacy_network_participation_id` BIGINT COMMENT 'Primary key for pharmacy_network_participation',
    `facility_contract_id` BIGINT COMMENT 'Business identifier for the contract governing this pharmacys participation in this network.',
    `insurance_network_participation_id` BIGINT COMMENT 'Unique identifier for this pharmacy-network participation record. Primary key.',
    `pharmacy_insurance_network_participation_id` BIGINT COMMENT 'FK to SSOT owner insurance.insurance_network_participation for the network_participation entity.',
    `pharmacy_location_id` BIGINT COMMENT 'Foreign key linking to the pharmacy location participating in the network',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to the provider network in which the pharmacy participates',
    `billing_network_participation_id` BIGINT COMMENT '',
    `provider_network_participation_id` BIGINT COMMENT '',
    `accepting_new_members_flag` BOOLEAN COMMENT 'Indicates whether this pharmacy is accepting new members from this network. May be false if pharmacy has reached capacity for this network.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this participation record was created in the system.',
    `effective_date` DATE COMMENT 'Date when the pharmacys participation in this network becomes active and claims can be adjudicated as in-network.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp when this participation record was last modified.',
    `mail_order_flag` BOOLEAN COMMENT 'Indicates whether this pharmacy participates in this network as a mail-order pharmacy.',
    `network_tier` STRING COMMENT 'Tier classification of this pharmacy within this specific network for member cost-sharing purposes. Preferred or Tier 1 pharmacies have lower member copays. Standard or Tier 2 have higher copays. Tier assignment varies by network.',
    `ninety_day_supply_flag` BOOLEAN COMMENT 'Indicates whether this pharmacy is authorized to dispense 90-day supplies for maintenance medications under this network.',
    `participation_status` STRING COMMENT 'Current status of the pharmacys participation in this network. Active means pharmacy is currently in-network and accepting claims. Inactive means participation has ended. Suspended means temporarily not accepting network claims. Pending means contract signed but not yet effective.',
    `preferred_pharmacy_flag` BOOLEAN COMMENT 'Indicates whether this pharmacy is designated as a preferred pharmacy in this network, offering lower member cost-sharing.',
    `reimbursement_rate_schedule` STRING COMMENT 'Identifier or reference to the reimbursement rate schedule or fee schedule that applies to this pharmacy for this network. Rates vary by pharmacy-network combination based on contract negotiations.',
    `specialty_pharmacy_flag` BOOLEAN COMMENT 'Indicates whether this pharmacy participates in this network as a specialty pharmacy for high-cost specialty medications.',
    `termination_date` DATE COMMENT 'Date when the pharmacys participation in this network ends. Null if participation is ongoing.',
    CONSTRAINT pk_pharmacy_network_participation PRIMARY KEY(`pharmacy_network_participation_id`)
) COMMENT 'This association product represents the contractual participation relationship between pharmacy locations and payer provider networks. It captures which pharmacies are in-network for which payer networks, the terms of participation, and network-specific reimbursement arrangements. Each record links one pharmacy location to one provider network with attributes that exist only in the context of this participation agreement.. Existence Justification: Pharmacy network participation is a genuine operational many-to-many relationship in healthcare. Each pharmacy location participates in multiple payer networks simultaneously (a CVS pharmacy accepts BCBS, Aetna, UnitedHealthcare, Cigna networks), and each provider network includes hundreds to thousands of pharmacy locations. The business actively manages these participation relationships with network-specific terms including tier status, reimbursement schedules, effective dates, and participation status.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_original_prescription_id` FOREIGN KEY (`original_prescription_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ADD CONSTRAINT `fk_pharmacy_controlled_substance_log_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ADD CONSTRAINT `fk_pharmacy_medication_pa_request_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ADD CONSTRAINT `fk_pharmacy_rx_claim_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ADD CONSTRAINT `fk_pharmacy_medication_therapy_mgmt_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ADD CONSTRAINT `fk_pharmacy_rems_compliance_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ADD CONSTRAINT `fk_pharmacy_drug_recall_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ADD CONSTRAINT `fk_pharmacy_drug_recall_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ADD CONSTRAINT `fk_pharmacy_compounding_record_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ADD CONSTRAINT `fk_pharmacy_medication_review_medication_therapy_mgmt_id` FOREIGN KEY (`medication_therapy_mgmt_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt`(`medication_therapy_mgmt_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ADD CONSTRAINT `fk_pharmacy_medication_review_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ADD CONSTRAINT `fk_pharmacy_study_drug_assignment_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ADD CONSTRAINT `fk_pharmacy_pharmacy_network_participation_pharmacy_location_id` FOREIGN KEY (`pharmacy_location_id`) REFERENCES `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location`(`pharmacy_location_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`pharmacy` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`pharmacy` SET TAGS ('dbx_domain' = 'pharmacy');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` SET TAGS ('dbx_subdomain' = 'formulary_management');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `compliance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `terminology_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Terminology Mapping Id (Foreign Key)');
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
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `snomed_code` SET TAGS ('dbx_business_glossary_term' = 'Systematized Nomenclature of Medicine Clinical Terms (SNOMED CT) Code');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `storage_temperature_range` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Range');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `storage_temperature_range` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `strength` SET TAGS ('dbx_business_glossary_term' = 'Drug Strength');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `tall_man_lettering` SET TAGS ('dbx_business_glossary_term' = 'Tall Man Lettering');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `therapeutic_category` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Category');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_master` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` SET TAGS ('dbx_subdomain' = 'formulary_management');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `terminology_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Terminology Mapping Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_status` SET TAGS ('dbx_business_glossary_term' = 'Formulary Entry Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|archived');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `step_therapy_protocol` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Protocol');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Required');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `therapeutic_alternative_available` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Alternative Available');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `therapeutic_class_code` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Class Code');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Formulary Tier');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `tier` SET TAGS ('dbx_value_regex' = 'tier_1_preferred_generic|tier_2_generic|tier_3_preferred_brand|tier_4_non_preferred_brand|tier_5_specialty|not_covered');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_type` SET TAGS ('dbx_business_glossary_term' = 'Formulary Type');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `formulary_type` SET TAGS ('dbx_value_regex' = 'commercial|medicare_part_d|medicaid|exchange|employer_group|specialty');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`formulary` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Formulary Version');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` SET TAGS ('dbx_subdomain' = 'dispensing_operations');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` SET TAGS ('dbx_fk_count_review' = 'exceeds_max_25');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Identifier');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `care_transition_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Care Transition Notification Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `direct_message_id` SET TAGS ('dbx_business_glossary_term' = 'Erx Direct Message Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `direct_message_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `message_log_id` SET TAGS ('dbx_business_glossary_term' = 'Erx Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `message_log_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Indication Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Lab Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `original_prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Original Prescription Identifier');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `original_prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `original_prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Pharmacy Identifier');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `hie_query_id` SET TAGS ('dbx_business_glossary_term' = 'Prescribing Hie Query Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Identifier');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `clinician_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_confidentiality' = 'confidential');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_patient_mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Patient Mpi Record Id');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_prescriber_clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Prescriber Clinician Id');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `promoting_interoperability_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Promoting Interoperability Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Appointment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Consent Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_date` SET TAGS ('dbx_business_glossary_term' = 'Prescription Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_date` SET TAGS ('dbx_pii_health' = 'true');
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
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `medication_name` SET TAGS ('dbx_business_glossary_term' = 'Medication Name');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `ndc` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `ndc` SET TAGS ('dbx_value_regex' = '^[0-9]{11}$|^[0-9]{5}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Prescription Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `number` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `pharmacy_notes` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Notes');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescriber_dea_number` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Drug Enforcement Administration (DEA) Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescriber_dea_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{7}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescriber_dea_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescriber_notes` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Notes');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prior_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prior_authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `quantity_prescribed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Prescribed');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `refills_authorized` SET TAGS ('dbx_business_glossary_term' = 'Refills Authorized');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `refills_remaining` SET TAGS ('dbx_business_glossary_term' = 'Refills Remaining');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `sig` SET TAGS ('dbx_business_glossary_term' = 'Sig (Directions for Use)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_status` SET TAGS ('dbx_business_glossary_term' = 'Prescription Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `timestamp` SET TAGS ('dbx_business_glossary_term' = 'Prescription Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `timestamp` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_type` SET TAGS ('dbx_business_glossary_term' = 'Prescription Type');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_type` SET TAGS ('dbx_value_regex' = 'new|refill|renewal|transfer-in|transfer-out|change');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`prescription` ALTER COLUMN `prescription_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` SET TAGS ('dbx_subdomain' = 'dispensing_operations');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `dispense_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dispense Event Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `care_transition_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Dispense Care Transition Notification Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `cda_document_id` SET TAGS ('dbx_business_glossary_term' = 'Dispense Cda Document Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `fhir_resource_log_id` SET TAGS ('dbx_business_glossary_term' = 'Dispense Fhir Resource Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `interface_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Dispense Interface Channel Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `message_log_id` SET TAGS ('dbx_business_glossary_term' = 'Dispense Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `message_log_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Pharmacist Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Pharmacist Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Lab Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Location Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `phi_access_log_id` SET TAGS ('dbx_business_glossary_term' = 'Phi Access Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
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
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`dispense_event` ALTER COLUMN `prior_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number');
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
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` SET TAGS ('dbx_subdomain' = 'dispensing_operations');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `mar_record_id` SET TAGS ('dbx_business_glossary_term' = 'Medication Administration Record (MAR) Record ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Administering Provider Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Administering Provider Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Lab Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`mar_record` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit ID');
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
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` SET TAGS ('dbx_subdomain' = 'dispensing_operations');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `controlled_substance_log_id` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Log ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `public_health_report_id` SET TAGS ('dbx_business_glossary_term' = 'Cs Public Health Report Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `public_health_report_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `public_health_report_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `patient_safety_event_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Safety Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `message_log_id` SET TAGS ('dbx_business_glossary_term' = 'Pdmp Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `message_log_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Provider Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Provider Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `substance_use_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Substance Use Consent Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`controlled_substance_log` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
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
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` SET TAGS ('dbx_subdomain' = 'clinical_safety');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `adverse_drug_event_id` SET TAGS ('dbx_business_glossary_term' = 'Adverse Drug Event (ADE) ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `public_health_report_id` SET TAGS ('dbx_business_glossary_term' = 'Ade Public Health Report Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `public_health_report_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `public_health_report_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Causative Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `compliance_regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `hotline_report_id` SET TAGS ('dbx_business_glossary_term' = 'Hotline Report Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `improvement_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Improvement Initiative Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Lab Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `patient_safety_event_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Safety Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Reporter Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reporter Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Clinical Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
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
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `adverse_drug_event_status` SET TAGS ('dbx_business_glossary_term' = 'Adverse Drug Event (ADE) Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `adverse_drug_event_status` SET TAGS ('dbx_value_regex' = 'reported|under_investigation|investigation_complete|closed');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` SET TAGS ('dbx_subdomain' = 'formulary_management');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Identifier');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `investigational_product_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
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
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'active|quarantined|recalled|expired|damaged|reserved');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `storage_requirements` SET TAGS ('dbx_business_glossary_term' = 'Storage Requirements');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `storage_requirements` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Inventory Value');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `total_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`inventory` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` SET TAGS ('dbx_subdomain' = 'benefit_reimbursement');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `medication_pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Medication Prior Authorization (PA) Request ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Prior Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Indication Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `direct_message_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Direct Message Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `direct_message_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `message_log_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `message_log_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `public_health_report_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Public Health Report Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `public_health_report_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `public_health_report_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `population_health_gap_id` SET TAGS ('dbx_business_glossary_term' = 'Population Health Gap Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `population_health_gap_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `population_health_gap_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitter Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `appeal_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'approved|denied|pending|withdrawn');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `appeal_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Submitted Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `approval_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `approval_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `approved_days_supply` SET TAGS ('dbx_business_glossary_term' = 'Approved Days Supply');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `approved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Approved Quantity');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `documentation_type` SET TAGS ('dbx_business_glossary_term' = 'Documentation Type');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `drug_ndc` SET TAGS ('dbx_business_glossary_term' = 'Drug National Drug Code (NDC)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `drug_ndc` SET TAGS ('dbx_value_regex' = '^[0-9]{11}$|^[0-9]{5}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `estimated_medication_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Medication Cost');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `formulary_status` SET TAGS ('dbx_business_glossary_term' = 'Formulary Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `formulary_status` SET TAGS ('dbx_value_regex' = 'formulary|non_formulary|preferred|non_preferred|specialty|restricted');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `pa_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Decision Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `pa_request_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Request Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `pa_request_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Request Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `pa_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `pa_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|appealed|withdrawn|expired');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `payer_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `prior_medications_tried` SET TAGS ('dbx_business_glossary_term' = 'Prior Medications Tried');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `requested_days_supply` SET TAGS ('dbx_business_glossary_term' = 'Requested Days Supply');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `specialty_medication_flag` SET TAGS ('dbx_business_glossary_term' = 'Specialty Medication Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `step_therapy_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `submitter_contact_fax` SET TAGS ('dbx_business_glossary_term' = 'Submitter Contact Fax');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `submitter_contact_fax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `submitter_contact_fax` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `submitter_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Submitter Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `submitter_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `submitter_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `supporting_documentation_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Provided Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `urgency_level` SET TAGS ('dbx_business_glossary_term' = 'Urgency Level');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_pa_request` ALTER COLUMN `urgency_level` SET TAGS ('dbx_value_regex' = 'routine|urgent|expedited|emergency');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` SET TAGS ('dbx_subdomain' = 'benefit_reimbursement');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `rx_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Claim ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `ar_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Account Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `interface_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Interface Channel Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `message_log_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `message_log_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Pharmacy Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Claim Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `claim_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `claim_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
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
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `prior_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `quantity_dispensed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Dispensed');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `refill_number` SET TAGS ('dbx_business_glossary_term' = 'Refill Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `reject_code` SET TAGS ('dbx_business_glossary_term' = 'National Council for Prescription Drug Programs (NCPDP) Reject Code');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `reject_description` SET TAGS ('dbx_business_glossary_term' = 'Reject Description');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `sales_tax` SET TAGS ('dbx_business_glossary_term' = 'Sales Tax');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `secondary_payer_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Secondary Payer Paid Amount');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `submission_clarification_code` SET TAGS ('dbx_business_glossary_term' = 'Submission Clarification Code');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `total_amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Paid');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `transaction_response_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Response Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `transaction_response_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|captured|duplicate');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rx_claim` ALTER COLUMN `usual_and_customary_price` SET TAGS ('dbx_business_glossary_term' = 'Usual and Customary (U&C) Price');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` SET TAGS ('dbx_subdomain' = 'clinical_safety');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `medication_therapy_mgmt_id` SET TAGS ('dbx_business_glossary_term' = 'Medication Therapy Management (MTM) Service ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `cms_condition_status_id` SET TAGS ('dbx_business_glossary_term' = 'Cms Condition Status Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Lab Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `measure_result_id` SET TAGS ('dbx_business_glossary_term' = 'Measure Result Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `cda_document_id` SET TAGS ('dbx_business_glossary_term' = 'Mtm Cda Document Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `promoting_interoperability_id` SET TAGS ('dbx_business_glossary_term' = 'Mtm Promoting Interoperability Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacist Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacist Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Consent Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `billing_cpt_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Current Procedural Terminology (CPT) Code');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `billing_cpt_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `billing_status` SET TAGS ('dbx_value_regex' = 'billable|non_billable|billed|paid|denied|pending');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `cms_part_d_compliant` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Part D Compliant Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `cost_avoidance_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Avoidance Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `cost_avoidance_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `documentation_complete` SET TAGS ('dbx_business_glossary_term' = 'Documentation Complete Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `drug_therapy_problem_count` SET TAGS ('dbx_business_glossary_term' = 'Drug Therapy Problem Count');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `drug_therapy_problem_description` SET TAGS ('dbx_business_glossary_term' = 'Drug Therapy Problem Description');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `drug_therapy_problem_identified` SET TAGS ('dbx_business_glossary_term' = 'Drug Therapy Problem Identified Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `estimated_cost_avoidance_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Avoidance Amount');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `follow_up_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Scheduled Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `intervention_description` SET TAGS ('dbx_business_glossary_term' = 'Clinical Intervention Description');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `intervention_type` SET TAGS ('dbx_business_glossary_term' = 'Clinical Intervention Type');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `medication_count_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Medication Count Reviewed');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `outcome_description` SET TAGS ('dbx_business_glossary_term' = 'Outcome Description');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `outcome_status` SET TAGS ('dbx_business_glossary_term' = 'Medication Therapy Management (MTM) Outcome Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `outcome_status` SET TAGS ('dbx_value_regex' = 'resolved|partially_resolved|unresolved|pending|patient_declined');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `patient_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Patient Action Plan');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `patient_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Patient Satisfaction Score');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `prescriber_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `prescriber_notified` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Notified Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `prescriber_response` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Response');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `prescriber_response` SET TAGS ('dbx_value_regex' = 'accepted|rejected|modified|no_response');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `prescriber_response_date` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Response Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `quality_measure_reported` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Reported Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `recommendation_made` SET TAGS ('dbx_business_glossary_term' = 'Pharmacist Recommendation');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `service_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `service_end_time` SET TAGS ('dbx_business_glossary_term' = 'Service End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `service_notes` SET TAGS ('dbx_business_glossary_term' = 'Service Notes');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `service_start_time` SET TAGS ('dbx_business_glossary_term' = 'Service Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Medication Therapy Management (MTM) Service Type');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'CMR|TMR|clinical_intervention|adherence_counseling|drug_therapy_problem_resolution|medication_reconciliation');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_therapy_mgmt` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` SET TAGS ('dbx_subdomain' = 'clinical_safety');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `rems_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Evaluation and Mitigation Strategy (REMS) Compliance ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `compliance_regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Care Coordinator ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Lab Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Training Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `adherence_monitoring_required` SET TAGS ('dbx_business_glossary_term' = 'Adherence Monitoring Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `adherence_monitoring_status` SET TAGS ('dbx_business_glossary_term' = 'Adherence Monitoring Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `adherence_monitoring_status` SET TAGS ('dbx_value_regex' = 'Compliant|Non-Compliant|Pending|Not Required');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `dispensing_pharmacy_npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI) - Dispensing Pharmacy');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `dispensing_pharmacy_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `drug_ndc` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `drug_ndc` SET TAGS ('dbx_value_regex' = '^[0-9]{4,5}-[0-9]{3,4}-[0-9]{1,2}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'Active|Pending|Inactive|Withdrawn|Suspended|Completed');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `fda_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'FDA Reporting Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `fda_reporting_status` SET TAGS ('dbx_business_glossary_term' = 'FDA Reporting Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `fda_reporting_status` SET TAGS ('dbx_value_regex' = 'Reported|Pending|Overdue|Not Required');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `hub_services_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Hub Services Enrollment Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `hub_services_enrollment_status` SET TAGS ('dbx_value_regex' = 'Enrolled|Not Enrolled|Pending|Inactive|Not Applicable');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `lab_monitoring_required` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Monitoring Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `lab_monitoring_status` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Monitoring Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `lab_monitoring_status` SET TAGS ('dbx_value_regex' = 'Compliant|Non-Compliant|Pending|Overdue|Not Required');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `last_adherence_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Adherence Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `last_fda_report_date` SET TAGS ('dbx_business_glossary_term' = 'Last FDA Report Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `last_lab_monitoring_date` SET TAGS ('dbx_business_glossary_term' = 'Last Laboratory Monitoring Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `last_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `next_lab_monitoring_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Laboratory Monitoring Due Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `next_verification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Verification Due Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `non_compliance_reason` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Reason');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `overall_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Compliance Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `overall_compliance_status` SET TAGS ('dbx_value_regex' = 'Fully Compliant|Partially Compliant|Non-Compliant|Pending Review');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `patient_assistance_program_status` SET TAGS ('dbx_business_glossary_term' = 'Patient Assistance Program Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `patient_assistance_program_status` SET TAGS ('dbx_value_regex' = 'Eligible|Not Eligible|Enrolled|Pending|Expired|Not Applicable');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `patient_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Patient Enrollment Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `patient_enrollment_required` SET TAGS ('dbx_business_glossary_term' = 'Patient Enrollment Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `patient_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Patient Enrollment Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `patient_enrollment_status` SET TAGS ('dbx_value_regex' = 'Enrolled|Not Enrolled|Pending|Expired|Not Required');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `pharmacy_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Certification Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `pharmacy_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Certification Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `pharmacy_certification_status` SET TAGS ('dbx_value_regex' = 'Certified|Not Certified|Pending|Expired|Not Required');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `prescriber_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Certification Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `prescriber_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Certification Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `prescriber_certification_status` SET TAGS ('dbx_value_regex' = 'Certified|Not Certified|Pending|Expired|Not Required');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `program_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Program Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'REMS Program Name');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'REMS|Hub Services|Patient Assistance|Specialty Enrollment|Restricted Distribution|Risk Management');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`rems_compliance` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'High|Medium|Low');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` SET TAGS ('dbx_subdomain' = 'clinical_safety');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `drug_recall_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Recall Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `compliance_regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Coordinator Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `patient_safety_event_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Safety Event Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `direct_message_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Direct Message Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `direct_message_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `message_log_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Message Log Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `message_log_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `adverse_event_count` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Count');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `adverse_event_reported` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Reported Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `destruction_date` SET TAGS ('dbx_business_glossary_term' = 'Destruction Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `destruction_witness_name` SET TAGS ('dbx_business_glossary_term' = 'Destruction Witness Name');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `destruction_witness_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `destruction_witness_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `disposition_method` SET TAGS ('dbx_business_glossary_term' = 'Disposition Method');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `disposition_method` SET TAGS ('dbx_value_regex' = 'returned to manufacturer|destroyed on-site|returned to distributor|pending disposition');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `drug_name` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Name');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `fda_enforcement_report_date` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Enforcement Report Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `fda_recall_number` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Recall Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `fda_recall_number` SET TAGS ('dbx_value_regex' = '^[A-Z]-[0-9]{4}-[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `ndc` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `ndc` SET TAGS ('dbx_value_regex' = '^[0-9]{5}-[0-9]{4}-[0-9]{2}$|^[0-9]{5}-[0-9]{3}-[0-9]{2}$|^[0-9]{4}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Recall Notes');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `patient_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Patient Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `patient_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Patient Notification Method');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `patient_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Patient Notification Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `patient_notification_status` SET TAGS ('dbx_value_regex' = 'not required|pending|in progress|completed|unable to contact');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `patients_affected_count` SET TAGS ('dbx_business_glossary_term' = 'Patients Affected Count');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `provider_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Provider Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `provider_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Provider Notification Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `provider_notification_status` SET TAGS ('dbx_value_regex' = 'not required|pending|completed');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `quantity_dispensed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Dispensed');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity on Hand');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `quantity_quarantined` SET TAGS ('dbx_business_glossary_term' = 'Quantity Quarantined');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `quantity_returned` SET TAGS ('dbx_business_glossary_term' = 'Quantity Returned');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `quarantine_date` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `quarantine_location` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Location');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `recall_classification` SET TAGS ('dbx_business_glossary_term' = 'Recall Classification');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `recall_classification` SET TAGS ('dbx_value_regex' = 'Class I|Class II|Class III');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `recall_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Closure Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `recall_initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Initiation Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `recall_reason` SET TAGS ('dbx_business_glossary_term' = 'Recall Reason');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `recall_scope` SET TAGS ('dbx_business_glossary_term' = 'Recall Scope');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `recall_scope` SET TAGS ('dbx_value_regex' = 'consumer level|retail level|wholesale level');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `recall_status` SET TAGS ('dbx_business_glossary_term' = 'Recall Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `recall_status` SET TAGS ('dbx_value_regex' = 'ongoing|completed|terminated|pending');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `recall_type` SET TAGS ('dbx_business_glossary_term' = 'Recall Type');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `recall_type` SET TAGS ('dbx_value_regex' = 'voluntary|FDA-requested|FDA-mandated');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `responsible_party_contact` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Contact');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `responsible_party_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `responsible_party_contact` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `return_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Return Authorization Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'Return Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`drug_recall` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` SET TAGS ('dbx_subdomain' = 'formulary_management');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `compounding_record_id` SET TAGS ('dbx_business_glossary_term' = 'Compounding Record Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Base Solution Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Compounding Pharmacist Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compounding Pharmacist Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `demographics_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `demographics_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `investigational_product_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Product Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Lab Order Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Compounding Facility Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Material Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Consent Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `treatment_consent_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `visit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `visit_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `base_solution_ndc` SET TAGS ('dbx_business_glossary_term' = 'Base Solution National Drug Code (NDC)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `base_solution_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Base Solution Volume in Milliliters (mL)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `batch_size` SET TAGS ('dbx_business_glossary_term' = 'Batch Size');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `batch_size_unit` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `batch_size_unit` SET TAGS ('dbx_value_regex' = 'ml|l|g|kg|units|doses');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `beyond_use_date` SET TAGS ('dbx_business_glossary_term' = 'Beyond-Use Date (BUD)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `compound_name` SET TAGS ('dbx_business_glossary_term' = 'Compound Medication Name');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `compounding_room` SET TAGS ('dbx_business_glossary_term' = 'Compounding Room');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `compounding_status` SET TAGS ('dbx_business_glossary_term' = 'Compounding Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `compounding_status` SET TAGS ('dbx_value_regex' = 'in_progress|completed|verified|dispensed|discarded|quarantined');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `compounding_type` SET TAGS ('dbx_business_glossary_term' = 'Compounding Type');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `compounding_type` SET TAGS ('dbx_value_regex' = 'non-sterile|sterile|iv_admixture');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `discard_reason` SET TAGS ('dbx_business_glossary_term' = 'Discard Reason');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `discard_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discard Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `endotoxin_test_performed` SET TAGS ('dbx_business_glossary_term' = 'Endotoxin Test Performed Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `endotoxin_test_result` SET TAGS ('dbx_business_glossary_term' = 'Endotoxin Test Result');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `endotoxin_test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|pending|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `environmental_monitoring_notes` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Notes');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `environmental_monitoring_result` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Result');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `environmental_monitoring_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `fda_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Registration Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `final_concentration` SET TAGS ('dbx_business_glossary_term' = 'Final Concentration');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `formula_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Formula Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `hazardous_drug_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Drug Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `infusion_rate` SET TAGS ('dbx_business_glossary_term' = 'Infusion Rate');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compounding Notes');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `preparation_date` SET TAGS ('dbx_business_glossary_term' = 'Preparation Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `preparation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Preparation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `qa_verification_pharmacist_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Verification Pharmacist Name');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `qa_verification_pharmacist_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `qa_verification_pharmacist_npi` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Verification Pharmacist National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `qa_verification_pharmacist_npi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `qa_verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Verification Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `sterility_test_performed` SET TAGS ('dbx_business_glossary_term' = 'Sterility Test Performed Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `sterility_test_result` SET TAGS ('dbx_business_glossary_term' = 'Sterility Test Result');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `sterility_test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|pending|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `total_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Total Volume in Milliliters (mL)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `usp_chapter_compliance` SET TAGS ('dbx_business_glossary_term' = 'United States Pharmacopeia (USP) Chapter Compliance');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`compounding_record` ALTER COLUMN `usp_chapter_compliance` SET TAGS ('dbx_value_regex' = 'usp_795|usp_797|usp_800');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` SET TAGS ('dbx_subdomain' = 'formulary_management');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `accreditation_status_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `inventory_location_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Location Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacist In Charge Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacist In Charge Employee Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|not_accredited|pending|expired');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `automated_dispensing_cabinet_count` SET TAGS ('dbx_business_glossary_term' = 'Automated Dispensing Cabinet (ADC) Count');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `dea_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Registration Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `dea_registration_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{7}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `dea_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `dispensing_capability_controlled_substances` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substances Dispensing Capability');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `dispensing_capability_non_sterile` SET TAGS ('dbx_business_glossary_term' = 'Non-Sterile Compounding Dispensing Capability');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `dispensing_capability_specialty` SET TAGS ('dbx_business_glossary_term' = 'Specialty Pharmacy Dispensing Capability');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `dispensing_capability_sterile` SET TAGS ('dbx_business_glossary_term' = 'Sterile Compounding Dispensing Capability');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `inventory_management_system` SET TAGS ('dbx_business_glossary_term' = 'Inventory Management System');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `inventory_management_system` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location Code');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location Name');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location Type');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `ncpdp_number` SET TAGS ('dbx_business_glossary_term' = 'National Council for Prescription Drug Programs (NCPDP) Pharmacy Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `ncpdp_number` SET TAGS ('dbx_value_regex' = '^[0-9]{7}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `program_340b_covered_entity_code` SET TAGS ('dbx_business_glossary_term' = '340B Covered Entity ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `program_340b_participation` SET TAGS ('dbx_business_glossary_term' = '340B Drug Pricing Program Participation');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `state_pharmacy_license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'State Pharmacy License Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `state_pharmacy_license_expiration_date` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `state_pharmacy_license_number` SET TAGS ('dbx_business_glossary_term' = 'State Pharmacy License Number');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `state_pharmacy_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `state_pharmacy_license_number` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `state_pharmacy_license_state` SET TAGS ('dbx_business_glossary_term' = 'State Pharmacy License State');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `state_pharmacy_license_state` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `pharmacy_location_status` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Location Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `pharmacy_location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|temporarily_closed|pending_licensure|decommissioned');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_location` ALTER COLUMN `twenty_four_hour_service` SET TAGS ('dbx_business_glossary_term' = '24-Hour Service Indicator');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` SET TAGS ('dbx_subdomain' = 'clinical_safety');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` SET TAGS ('dbx_association_edges' = 'pharmacy.medication_therapy_mgmt,pharmacy.prescription');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ALTER COLUMN `medication_review_id` SET TAGS ('dbx_business_glossary_term' = 'Medication Review ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ALTER COLUMN `medication_therapy_mgmt_id` SET TAGS ('dbx_business_glossary_term' = 'Medication Review - Medication Therapy Mgmt Id');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Medication Review - Prescription Id');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ALTER COLUMN `drug_therapy_problem_description` SET TAGS ('dbx_business_glossary_term' = 'Drug Therapy Problem Description');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ALTER COLUMN `drug_therapy_problem_identified` SET TAGS ('dbx_business_glossary_term' = 'Drug Therapy Problem Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ALTER COLUMN `estimated_cost_avoidance_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Avoidance Amount');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ALTER COLUMN `intervention_description` SET TAGS ('dbx_business_glossary_term' = 'Intervention Description');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ALTER COLUMN `intervention_type` SET TAGS ('dbx_business_glossary_term' = 'Intervention Type');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ALTER COLUMN `outcome_description` SET TAGS ('dbx_business_glossary_term' = 'Review Outcome Description');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ALTER COLUMN `outcome_status` SET TAGS ('dbx_business_glossary_term' = 'Review Outcome Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ALTER COLUMN `prescriber_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ALTER COLUMN `prescriber_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Notification Method');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ALTER COLUMN `prescriber_notification_method` SET TAGS ('dbx_value_regex' = 'phone|fax|electronic_message|mail|in_person');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ALTER COLUMN `prescriber_notified` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Notification Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ALTER COLUMN `prescriber_response` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Response');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ALTER COLUMN `prescriber_response_date` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Response Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ALTER COLUMN `prescriber_response_notes` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Response Notes');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ALTER COLUMN `recommendation_made` SET TAGS ('dbx_business_glossary_term' = 'Recommendation');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ALTER COLUMN `review_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Review Sequence');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`medication_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` SET TAGS ('dbx_subdomain' = 'formulary_management');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` SET TAGS ('dbx_association_edges' = 'pharmacy.drug_master,research.research_study');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ALTER COLUMN `study_drug_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Study Drug Assignment Identifier');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Study Drug Assignment - Drug Master Id');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ALTER COLUMN `research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Drug Assignment - Research Study Id');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ALTER COLUMN `arm_assignment` SET TAGS ('dbx_business_glossary_term' = 'Treatment Arm Assignment');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ALTER COLUMN `blinding_status` SET TAGS ('dbx_business_glossary_term' = 'Blinding Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ALTER COLUMN `dose_level` SET TAGS ('dbx_business_glossary_term' = 'Dose Level');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ALTER COLUMN `drug_accountability_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Drug Accountability Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ALTER COLUMN `formulary_tier` SET TAGS ('dbx_business_glossary_term' = 'Formulary Tier');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ALTER COLUMN `ind_ide_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'IND/IDE Coverage Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ALTER COLUMN `ind_ide_coverage_flag` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ALTER COLUMN `pharmacy_notes` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Notes');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`study_drug_assignment` ALTER COLUMN `randomization_date` SET TAGS ('dbx_business_glossary_term' = 'Randomization Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` SET TAGS ('dbx_subdomain' = 'benefit_reimbursement');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` SET TAGS ('dbx_association_edges' = 'pharmacy.location,insurance.provider_network');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ALTER COLUMN `pharmacy_network_participation_id` SET TAGS ('dbx_business_glossary_term' = 'pharmacy_network_participation Identifier');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ALTER COLUMN `facility_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Network Contract ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ALTER COLUMN `insurance_network_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Network Participation ID');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ALTER COLUMN `pharmacy_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Network Participation - Pharmacy Location Id');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Network Participation - Provider Network Id');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ALTER COLUMN `billing_network_participation_id` SET TAGS ('dbx_ssot_reference' = 'billing.billing_network_participation');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ALTER COLUMN `provider_network_participation_id` SET TAGS ('dbx_ssot_reference' = 'provider.provider_network_participation');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ALTER COLUMN `accepting_new_members_flag` SET TAGS ('dbx_business_glossary_term' = 'Accepting New Members Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Date');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ALTER COLUMN `mail_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Mail Order Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ALTER COLUMN `network_tier` SET TAGS ('dbx_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ALTER COLUMN `ninety_day_supply_flag` SET TAGS ('dbx_business_glossary_term' = 'Ninety Day Supply Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ALTER COLUMN `preferred_pharmacy_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Pharmacy Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ALTER COLUMN `reimbursement_rate_schedule` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Rate Schedule');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ALTER COLUMN `reimbursement_rate_schedule` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ALTER COLUMN `specialty_pharmacy_flag` SET TAGS ('dbx_business_glossary_term' = 'Specialty Pharmacy Flag');
ALTER TABLE `vibe_healthcare_v1`.`pharmacy`.`pharmacy_network_participation` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Termination Date');
